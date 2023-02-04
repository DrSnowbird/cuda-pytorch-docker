import torch

print(f"torch.cuda.is_available(): {torch.cuda.is_available()}")

print(f"torch.cuda.device_count(): {torch.cuda.device_count()}")

print(f"torch.cuda.current_device(): {torch.cuda.current_device()}")

print(f"torch.cuda.device(0): {torch.cuda.device(0)}")

print(f"torch.cuda.get_device_name(0): {torch.cuda.get_device_name(0)}")

