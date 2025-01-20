Return-Path: <bpf+bounces-49281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC09A16601
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 05:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125FE3A69C3
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D051494C2;
	Mon, 20 Jan 2025 04:06:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0C14387B
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737345996; cv=none; b=afhsDjjjkiLpYB8Eijk678wxrvQCeJwNJSqkE4Z90neaqkELoKtg5MdwXL7OyqUsLWHaKXBY4sPWFgsIhJqu+zgVfxotIVJ/SVsRIQc0KLwXBtFjWwusUADw7zaT1NpAT4GEYK1Ek0zrY3Uqa5LSgFqNjPRsI8TxbXRxZDj3Dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737345996; c=relaxed/simple;
	bh=lGcpI6a1XWnVK+8d105nMxH5caH276UZtY187MsL1go=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U29X7qwBNRn2+4lqVxLCoqdqsEOJigFM8Y0nRkm+4X67kxMPst7w2RndYx52e75LETlvU1T7kP9XaiYIMEWgrjCGbH1KWCKEX9obNY0fZ56Y/VDkCwWmXKCdVvWFMcyGqrq9gj7/PwWIyroege/WZtoEdTzJHi45MF5pWFQ3A7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so75594045ab.0
        for <bpf@vger.kernel.org>; Sun, 19 Jan 2025 20:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737345993; x=1737950793;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5kTggof5/XRx+IqqN0vAKAtak7NSxBUzxASWi1qccs=;
        b=VAuJZyzSG216nZCnmioTq0+Ympr/NUMjg3XEZGGzZrLfk28RMYOUUSSDYrSjnKPURx
         tK+/eAmd+Xi49cJ4GvoDcjaSFqrv3WNDFtJaAXsWXjJ+Dds/x94QRklo3X/g8F0uNEnR
         o/JtTCjybCF4CUhVzobEI3s63KQLtdXaVhPqPKLNm8j8hKwkN1MdT6cqJSvXzp6YMbKj
         g9ylLmZh/02vv6pJvp5CfVkXcV4B5CVnbZ+xpjQzSZTaFHs9yO0Y2ckIHCx6SxTWoJ9l
         BpWr+0Q0ijc0pfiZGP6XvDE8jRxfyzMdFztDmQbSNWr6F8F6bEA7BZ1O+w9BEkpJZEV3
         NIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNd5YVsJ9lPtZFJaTKvrnb8GnGrEgnIc+h3Zw51MQTOxA90mGZuHBWoEDE8iZjcL5Pq/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8SyKJwHD9e7Bv777qJmWKIwmFQld0lQ27Wps15Dk6JN1xCOs2
	GzPvJTesvj/FO/kiHR4o86mJJxsN3nTXsVtZ+GEhEruvTiKWbtGcYPqRNhAgEKNKoBfOEoPCq2w
	jf0+CMratZNguA/dv3bbj1/zXzUfnXxowPkMXudg6FizbDD3cHRgqIBk=
X-Google-Smtp-Source: AGHT+IEo+U22gUnuFW3ZZkVe2FUHEhE/kVyBUCQU8tnatHeOLTp8cUlkw5kBgM2bkOraxZ+xMGxV0rQReSCRIge49Ug+VXIIpTab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1389:b0:3ce:81ab:c445 with SMTP id
 e9e14a558f8ab-3cf74495106mr77145405ab.17.1737345993182; Sun, 19 Jan 2025
 20:06:33 -0800 (PST)
Date: Sun, 19 Jan 2025 20:06:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678dcbc9.050a0220.303755.0066.GAE@google.com>
Subject: [syzbot] [bpf?] possible deadlock in bpf_map_mmap
From: syzbot <syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6251d1776bc5 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1273fcb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5408fc4cf982e2c4
dashboard link: https://syzkaller.appspot.com/bug?extid=4dc041c686b7c816a71e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50b69fc9b7af/disk-6251d177.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/685bf0a83938/vmlinux-6251d177.xz
kernel image: https://storage.googleapis.com/syzbot-assets/195cb7e053b8/Image-6251d177.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-g6251d1776bc5 #0 Tainted: G        W         
------------------------------------------------------
syz.2.434/8634 is trying to acquire lock:
ffff0000cf16ca90 (&vma->vm_lock->lock){++++}-{4:4}, at: vma_start_write include/linux/mm.h:770 [inline]
ffff0000cf16ca90 (&vma->vm_lock->lock){++++}-{4:4}, at: vm_flags_clear include/linux/mm.h:907 [inline]
ffff0000cf16ca90 (&vma->vm_lock->lock){++++}-{4:4}, at: bpf_map_mmap+0x2b4/0x6a8 kernel/bpf/syscall.c:1063

but task is already holding lock:
ffff80009d03d0d8 (&map->freeze_mutex){+.+.}-{4:4}, at: bpf_map_mmap+0x114/0x6a8 kernel/bpf/syscall.c:1042

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #10 (&map->freeze_mutex){+.+.}-{4:4}:
       __mutex_lock_common+0x218/0x28f4 kernel/locking/mutex.c:585
       __mutex_lock kernel/locking/mutex.c:735 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:787
       bpf_map_mmap+0x114/0x6a8 kernel/bpf/syscall.c:1042
       call_mmap include/linux/fs.h:2183 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x185c/0x2188 mm/vma.c:2456
       mmap_region+0x1f4/0x370 mm/mmap.c:1352
       do_mmap+0x8f8/0x1094 mm/mmap.c:500
       vm_mmap_pgoff+0x1a0/0x38c mm/util.c:575
       ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:546
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #9 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault+0xc4/0x124 mm/memory.c:6751
       drm_mode_atomic_ioctl+0x504/0x1398 drivers/gpu/drm/drm_atomic_uapi.c:1437
       drm_ioctl_kernel+0x26c/0x368 drivers/gpu/drm/drm_ioctl.c:796
       drm_ioctl+0x624/0xb14 drivers/gpu/drm/drm_ioctl.c:893
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #8 (crtc_ww_class_mutex){+.+.}-{4:4}:
       ww_acquire_init include/linux/ww_mutex.h:162 [inline]
       drm_modeset_acquire_init+0x1e4/0x384 drivers/gpu/drm/drm_modeset_lock.c:250
       drmm_mode_config_init+0xb98/0x130c drivers/gpu/drm/drm_mode_config.c:453
       vkms_modeset_init drivers/gpu/drm/vkms/vkms_drv.c:158 [inline]
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:219 [inline]
       vkms_init+0x2fc/0x600 drivers/gpu/drm/vkms/vkms_drv.c:256
       do_one_initcall+0x254/0x9f8 init/main.c:1266
       do_initcall_level+0x154/0x214 init/main.c:1328
       do_initcalls+0x58/0xac init/main.c:1344
       do_basic_setup+0x8c/0xa0 init/main.c:1363
       kernel_init_freeable+0x324/0x478 init/main.c:1577
       kernel_init+0x24/0x2a0 init/main.c:1466
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

-> #7 (crtc_ww_class_acquire){+.+.}-{0:0}:
       ww_acquire_init include/linux/ww_mutex.h:161 [inline]
       drm_modeset_acquire_init+0x1c4/0x384 drivers/gpu/drm/drm_modeset_lock.c:250
       drm_client_modeset_commit_atomic+0xd8/0x724 drivers/gpu/drm/drm_client_modeset.c:1009
       drm_client_modeset_commit_locked+0xd0/0x4a8 drivers/gpu/drm/drm_client_modeset.c:1173
       drm_client_modeset_commit+0x50/0x7c drivers/gpu/drm/drm_client_modeset.c:1199
       __drm_fb_helper_restore_fbdev_mode_unlocked+0xd4/0x178 drivers/gpu/drm/drm_fb_helper.c:237
       drm_fb_helper_set_par+0xc4/0x110 drivers/gpu/drm/drm_fb_helper.c:1351
       fbcon_init+0xf34/0x1eb8 drivers/video/fbdev/core/fbcon.c:1113
       visual_init+0x27c/0x548 drivers/tty/vt/vt.c:1011
       do_bind_con_driver+0x7dc/0xe04 drivers/tty/vt/vt.c:3833
       do_take_over_console+0x4ac/0x5f0 drivers/tty/vt/vt.c:4399
       do_fbcon_takeover+0x158/0x260 drivers/video/fbdev/core/fbcon.c:549
       do_fb_registered drivers/video/fbdev/core/fbcon.c:2988 [inline]
       fbcon_fb_registered+0x370/0x4ec drivers/video/fbdev/core/fbcon.c:3008
       do_register_framebuffer drivers/video/fbdev/core/fbmem.c:449 [inline]
       register_framebuffer+0x470/0x610 drivers/video/fbdev/core/fbmem.c:515
       __drm_fb_helper_initial_config_and_unlock+0x137c/0x1910 drivers/gpu/drm/drm_fb_helper.c:1841
       drm_fb_helper_initial_config+0x48/0x64 drivers/gpu/drm/drm_fb_helper.c:1906
       drm_fbdev_client_hotplug+0x158/0x22c drivers/gpu/drm/drm_fbdev_client.c:51
       drm_client_register+0x144/0x1e0 drivers/gpu/drm/drm_client.c:140
       drm_fbdev_client_setup+0x1a4/0x39c drivers/gpu/drm/drm_fbdev_client.c:158
       drm_client_setup+0x28/0x9c drivers/gpu/drm/drm_client_setup.c:29
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:230 [inline]
       vkms_init+0x4f0/0x600 drivers/gpu/drm/vkms/vkms_drv.c:256
       do_one_initcall+0x254/0x9f8 init/main.c:1266
       do_initcall_level+0x154/0x214 init/main.c:1328
       do_initcalls+0x58/0xac init/main.c:1344
       do_basic_setup+0x8c/0xa0 init/main.c:1363
       kernel_init_freeable+0x324/0x478 init/main.c:1577
       kernel_init+0x24/0x2a0 init/main.c:1466
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

-> #6 (&client->modeset_mutex){+.+.}-{4:4}:
       __mutex_lock_common+0x218/0x28f4 kernel/locking/mutex.c:585
       __mutex_lock kernel/locking/mutex.c:735 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:787
       drm_client_modeset_probe+0x304/0x3f64 drivers/gpu/drm/drm_client_modeset.c:834
       __drm_fb_helper_initial_config_and_unlock+0x104/0x1910 drivers/gpu/drm/drm_fb_helper.c:1818
       drm_fb_helper_initial_config+0x48/0x64 drivers/gpu/drm/drm_fb_helper.c:1906
       drm_fbdev_client_hotplug+0x158/0x22c drivers/gpu/drm/drm_fbdev_client.c:51
       drm_client_register+0x144/0x1e0 drivers/gpu/drm/drm_client.c:140
       drm_fbdev_client_setup+0x1a4/0x39c drivers/gpu/drm/drm_fbdev_client.c:158
       drm_client_setup+0x28/0x9c drivers/gpu/drm/drm_client_setup.c:29
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:230 [inline]
       vkms_init+0x4f0/0x600 drivers/gpu/drm/vkms/vkms_drv.c:256
       do_one_initcall+0x254/0x9f8 init/main.c:1266
       do_initcall_level+0x154/0x214 init/main.c:1328
       do_initcalls+0x58/0xac init/main.c:1344
       do_basic_setup+0x8c/0xa0 init/main.c:1363
       kernel_init_freeable+0x324/0x478 init/main.c:1577
       kernel_init+0x24/0x2a0 init/main.c:1466
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

-> #5 (&helper->lock){+.+.}-{4:4}:
       __mutex_lock_common+0x218/0x28f4 kernel/locking/mutex.c:585
       __mutex_lock kernel/locking/mutex.c:735 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:787
       __drm_fb_helper_restore_fbdev_mode_unlocked+0xb4/0x178 drivers/gpu/drm/drm_fb_helper.c:228
       drm_fb_helper_set_par+0xc4/0x110 drivers/gpu/drm/drm_fb_helper.c:1351
       fbcon_init+0xf34/0x1eb8 drivers/video/fbdev/core/fbcon.c:1113
       visual_init+0x27c/0x548 drivers/tty/vt/vt.c:1011
       do_bind_con_driver+0x7dc/0xe04 drivers/tty/vt/vt.c:3833
       do_take_over_console+0x4ac/0x5f0 drivers/tty/vt/vt.c:4399
       do_fbcon_takeover+0x158/0x260 drivers/video/fbdev/core/fbcon.c:549
       do_fb_registered drivers/video/fbdev/core/fbcon.c:2988 [inline]
       fbcon_fb_registered+0x370/0x4ec drivers/video/fbdev/core/fbcon.c:3008
       do_register_framebuffer drivers/video/fbdev/core/fbmem.c:449 [inline]
       register_framebuffer+0x470/0x610 drivers/video/fbdev/core/fbmem.c:515
       __drm_fb_helper_initial_config_and_unlock+0x137c/0x1910 drivers/gpu/drm/drm_fb_helper.c:1841
       drm_fb_helper_initial_config+0x48/0x64 drivers/gpu/drm/drm_fb_helper.c:1906
       drm_fbdev_client_hotplug+0x158/0x22c drivers/gpu/drm/drm_fbdev_client.c:51
       drm_client_register+0x144/0x1e0 drivers/gpu/drm/drm_client.c:140
       drm_fbdev_client_setup+0x1a4/0x39c drivers/gpu/drm/drm_fbdev_client.c:158
       drm_client_setup+0x28/0x9c drivers/gpu/drm/drm_client_setup.c:29
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:230 [inline]
       vkms_init+0x4f0/0x600 drivers/gpu/drm/vkms/vkms_drv.c:256
       do_one_initcall+0x254/0x9f8 init/main.c:1266
       do_initcall_level+0x154/0x214 init/main.c:1328
       do_initcalls+0x58/0xac init/main.c:1344
       do_basic_setup+0x8c/0xa0 init/main.c:1363
       kernel_init_freeable+0x324/0x478 init/main.c:1577
       kernel_init+0x24/0x2a0 init/main.c:1466
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

-> #4 (console_lock){+.+.}-{0:0}:
       console_lock+0x19c/0x1f4 kernel/printk/printk.c:2833
       __bch2_print_string_as_lines fs/bcachefs/util.c:267 [inline]
       bch2_print_string_as_lines+0x2c/0xd4 fs/bcachefs/util.c:286
       __bch2_fsck_err+0x1864/0x2544 fs/bcachefs/error.c:411
       bch2_check_fix_ptr fs/bcachefs/buckets.c:112 [inline]
       bch2_check_fix_ptrs+0x15b8/0x515c fs/bcachefs/buckets.c:266
       bch2_trigger_extent+0x71c/0x814 fs/bcachefs/buckets.c:856
       bch2_key_trigger fs/bcachefs/bkey_methods.h:87 [inline]
       bch2_gc_mark_key+0x4b4/0xb70 fs/bcachefs/btree_gc.c:634
       bch2_gc_btree fs/bcachefs/btree_gc.c:670 [inline]
       bch2_gc_btrees fs/bcachefs/btree_gc.c:729 [inline]
       bch2_check_allocations+0x1018/0x48f4 fs/bcachefs/btree_gc.c:1133
       bch2_run_recovery_pass+0xe4/0x1d4 fs/bcachefs/recovery_passes.c:191
       bch2_run_recovery_passes+0x30c/0x73c fs/bcachefs/recovery_passes.c:244
       bch2_fs_recovery+0x32d8/0x55dc fs/bcachefs/recovery.c:861
       bch2_fs_start+0x30c/0x53c fs/bcachefs/super.c:1037
       bch2_fs_get_tree+0x938/0x1030 fs/bcachefs/fs.c:2170
       vfs_get_tree+0x90/0x28c fs/super.c:1814
       do_new_mount+0x278/0x900 fs/namespace.c:3507
       path_mount+0x590/0xe04 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount fs/namespace.c:4034 [inline]
       __arm64_sys_mount+0x4d4/0x5ac fs/namespace.c:4034
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #3 (&c->fsck_error_msgs_lock){+.+.}-{4:4}:
       __mutex_lock_common+0x218/0x28f4 kernel/locking/mutex.c:585
       __mutex_lock kernel/locking/mutex.c:735 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:787
       __bch2_fsck_err+0x344/0x2544 fs/bcachefs/error.c:282
       bch2_check_fix_ptr fs/bcachefs/buckets.c:112 [inline]
       bch2_check_fix_ptrs+0x15b8/0x515c fs/bcachefs/buckets.c:266
       bch2_trigger_extent+0x71c/0x814 fs/bcachefs/buckets.c:856
       bch2_key_trigger fs/bcachefs/bkey_methods.h:87 [inline]
       bch2_gc_mark_key+0x4b4/0xb70 fs/bcachefs/btree_gc.c:634
       bch2_gc_btree fs/bcachefs/btree_gc.c:670 [inline]
       bch2_gc_btrees fs/bcachefs/btree_gc.c:729 [inline]
       bch2_check_allocations+0x1018/0x48f4 fs/bcachefs/btree_gc.c:1133
       bch2_run_recovery_pass+0xe4/0x1d4 fs/bcachefs/recovery_passes.c:191
       bch2_run_recovery_passes+0x30c/0x73c fs/bcachefs/recovery_passes.c:244
       bch2_fs_recovery+0x32d8/0x55dc fs/bcachefs/recovery.c:861
       bch2_fs_start+0x30c/0x53c fs/bcachefs/super.c:1037
       bch2_fs_get_tree+0x938/0x1030 fs/bcachefs/fs.c:2170
       vfs_get_tree+0x90/0x28c fs/super.c:1814
       do_new_mount+0x278/0x900 fs/namespace.c:3507
       path_mount+0x590/0xe04 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount fs/namespace.c:4034 [inline]
       __arm64_sys_mount+0x4d4/0x5ac fs/namespace.c:4034
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #2 (&c->mark_lock){++++}-{0:0}:
       percpu_down_read+0x5c/0x2e8 include/linux/percpu-rwsem.h:51
       __bch2_disk_reservation_add+0xc4/0x9f4 fs/bcachefs/buckets.c:1170
       bch2_disk_reservation_add+0x29c/0x4f4 fs/bcachefs/buckets.h:367
       __bch2_folio_reservation_get+0x2dc/0x798 fs/bcachefs/fs-io-pagecache.c:428
       bch2_folio_reservation_get fs/bcachefs/fs-io-pagecache.c:477 [inline]
       bch2_page_mkwrite+0xa70/0xe44 fs/bcachefs/fs-io-pagecache.c:637
       do_page_mkwrite+0x140/0x2dc mm/memory.c:3176
       wp_page_shared mm/memory.c:3577 [inline]
       do_wp_page+0x1f50/0x38a0 mm/memory.c:3727
       handle_pte_fault mm/memory.c:5817 [inline]
       __handle_mm_fault+0x1208/0x5ff0 mm/memory.c:5944
       handle_mm_fault+0x29c/0x8b4 mm/memory.c:6112
       do_page_fault+0x404/0x10a8 arch/arm64/mm/fault.c:647
       do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
       el0_da+0x60/0x178 arch/arm64/kernel/entry-common.c:604
       el0t_64_sync_handler+0xcc/0x108 arch/arm64/kernel/entry-common.c:765
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #1 (sb_pagefaults#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1725 [inline]
       sb_start_pagefault include/linux/fs.h:1890 [inline]
       bch2_page_mkwrite+0x280/0xe44 fs/bcachefs/fs-io-pagecache.c:614
       do_page_mkwrite+0x140/0x2dc mm/memory.c:3176
       wp_page_shared mm/memory.c:3577 [inline]
       do_wp_page+0x1f50/0x38a0 mm/memory.c:3727
       handle_pte_fault mm/memory.c:5817 [inline]
       __handle_mm_fault+0x1208/0x5ff0 mm/memory.c:5944
       handle_mm_fault+0x29c/0x8b4 mm/memory.c:6112
       do_page_fault+0x404/0x10a8 arch/arm64/mm/fault.c:647
       do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
       el0_da+0x60/0x178 arch/arm64/kernel/entry-common.c:604
       el0t_64_sync_handler+0xcc/0x108 arch/arm64/kernel/entry-common.c:765
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #0 (&vma->vm_lock->lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x34f0/0x7904 kernel/locking/lockdep.c:5226
       lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
       vma_start_write include/linux/mm.h:770 [inline]
       vm_flags_clear include/linux/mm.h:907 [inline]
       bpf_map_mmap+0x2b4/0x6a8 kernel/bpf/syscall.c:1063
       call_mmap include/linux/fs.h:2183 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x185c/0x2188 mm/vma.c:2456
       mmap_region+0x1f4/0x370 mm/mmap.c:1352
       do_mmap+0x8f8/0x1094 mm/mmap.c:500
       vm_mmap_pgoff+0x1a0/0x38c mm/util.c:575
       ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:546
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

other info that might help us debug this:

Chain exists of:
  &vma->vm_lock->lock --> &mm->mmap_lock --> &map->freeze_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&map->freeze_mutex);
                               lock(&mm->mmap_lock);
                               lock(&map->freeze_mutex);
  lock(&vma->vm_lock->lock);

 *** DEADLOCK ***

2 locks held by syz.2.434/8634:
 #0: ffff0000da528a10 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff0000da528a10 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x154/0x38c mm/util.c:573
 #1: ffff80009d03d0d8 (&map->freeze_mutex){+.+.}-{4:4}, at: bpf_map_mmap+0x114/0x6a8 kernel/bpf/syscall.c:1042

stack backtrace:
CPU: 0 UID: 0 PID: 8634 Comm: syz.2.434 Tainted: G        W          6.13.0-rc6-syzkaller-g6251d1776bc5 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x154/0x1c0 kernel/locking/lockdep.c:2074
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x34f0/0x7904 kernel/locking/lockdep.c:5226
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
 vma_start_write include/linux/mm.h:770 [inline]
 vm_flags_clear include/linux/mm.h:907 [inline]
 bpf_map_mmap+0x2b4/0x6a8 kernel/bpf/syscall.c:1063
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x185c/0x2188 mm/vma.c:2456
 mmap_region+0x1f4/0x370 mm/mmap.c:1352
 do_mmap+0x8f8/0x1094 mm/mmap.c:500
 vm_mmap_pgoff+0x1a0/0x38c mm/util.c:575
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:546
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

