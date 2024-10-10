Return-Path: <bpf+bounces-41512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017849979EB
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B264D28504B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A217BA1;
	Thu, 10 Oct 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPmTxtDU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848DFC08
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521925; cv=none; b=ncSLvrwA0/+wu7z1/9oY7c2ZJvsMIKYuuGxtQuVBQ4k9gkUvNtxRkbIKRk/gM65nO4UWRpr4H0Tt6NL0xXhD+mhf2dBtiOlW7pNXBhNQ+HClyykB6wCzpPCQ8SCEpGRKuvagYyC1rEqDvx9kGAQU5RWmD8xM/h7IoKV4jo207J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521925; c=relaxed/simple;
	bh=pGHEpiZombgLJTo/wXjeyjDR1BobWzGGHleOm8VIGQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugvSFrj2tr7319JToaZGywdmEH0hVcCyfYNGTuDKs9JGODqUGMPHr7nKr0w0hZJVQcinM3i0QCav6lS5LE29x+BWoJe295AqQKMlicpIluJHsg/Hlz9L8uOpMFbt6zjrdUR79Oh4AQDyEQhb2AsZ3uC7/sxwEAPW0+91Xo4gZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPmTxtDU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4612da0fso504201f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728521921; x=1729126721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxEysLkc1qMouX3ypLTowt+Yd69GWJ3QiSkn50PCVyU=;
        b=bPmTxtDU6EEnWBUXouHYywUpAlNcI2pYZaa9dtrFpOYvMDFpKxGfpSzfDrvCDvEUoE
         EEVMkDNm6RSIEBlEdk6i2bMbBzP5xVTQRWS79uOHbWwVPAGLOwR7jabeUvJnJbC6nMbi
         sNZmopq86nKdRAGQDwE1ja7Szsh2abt6RFySzwQmvSJEp5k3D1dmCHX9NlH66hZcPiMm
         Do55rjYn60Ol4jXxdUk5pMnYfaIxgf3QzUJ/YFPu78+6UTNzwMaTsxQQWcfatx8UCYF3
         /qJxzds1U1MGF+CSFq4n3D+ubCGraVrGIA/UNquYmkWyuE7BzAdc4NWdlW0Cq5sHjCpA
         5Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728521921; x=1729126721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxEysLkc1qMouX3ypLTowt+Yd69GWJ3QiSkn50PCVyU=;
        b=CCcm36cYW+9PYCnkJxQX4poHZokp4U13y4o49Ues6nTITwi5Omt4/a2qtRaaoamIke
         EltkieBsqIAG9p3UrnvQweUYsG/sP8HPIlyLZCFS1vK1p0/2j06fLqWlkslWLv7bvQ11
         /lpH8KUm1oAUVeGjiMKUwTiUUHyaWeOax/4KptCzjm9oVbKwnbI66cc4ErFqXaTuTOSu
         DxmakfZtOJ6YLHWTJ1oSY7GTUTqCKeQu97vBSXVUJECzl+Aa/Ok1lcri6C5ULBfkfsVU
         20CduELaXHKeSTUoa0r/t5mzO0oPqsazTPUqbFOxIFQcqf3bXDdHbxnKiUQJ4MKw/4Ww
         Anhg==
X-Gm-Message-State: AOJu0Yylvivbvpjkx4EK3BjcPOaYsBxk/G1pNndxXD30MD9C7M0cBfNR
	0m5oEfM0Sz0V91zZfayRXKRLBBic/fefNslO2p/GWOcrsZxblXbKJ0cCNGkRCYa7X1Jnudhe+lr
	YDpo3cfZ52gTQyRwmVpowJ8pB/1o=
X-Google-Smtp-Source: AGHT+IGl9XrZ3gYnjaOONsa+gFiufMrSG5DXq55S8hpUXYmCdSBAuBIIlm/jJvoD/NWyp49STY4NnvJC0UGwJLgCI4A=
X-Received: by 2002:a5d:4208:0:b0:37d:4706:f721 with SMTP id
 ffacd0b85a97d-37d481a761cmr1486845f8f.27.1728521920904; Wed, 09 Oct 2024
 17:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008161333.33469-1-leon.hwang@linux.dev> <20241008161333.33469-2-leon.hwang@linux.dev>
In-Reply-To: <20241008161333.33469-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 17:58:29 -0700
Message-ID: <CAADnVQL1D7Kxc7a20Zov_3AR+jzSTdu-552S3goK+pi30di0WQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com, 
	kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:16=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> This patch prevents an infinite loop issue caused by combination of tailc=
all
> and freplace.
>
> For example:
>
> tc_bpf2bpf.c:
>
> // SPDX-License-Identifier: GPL-2.0
>
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
>
> __noinline
> int subprog_tc(struct __sk_buff *skb)
> {
>         return skb->len * 2;
> }
>
> SEC("tc")
> int entry_tc(struct __sk_buff *skb)
> {
>         return subprog_tc(skb);
> }
>
> char __license[] SEC("license") =3D "GPL";
>
> tailcall_freplace.c:
>
> // SPDX-License-Identifier: GPL-2.0
>
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
>
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>
> int count =3D 0;
>
> SEC("freplace")
> int entry_freplace(struct __sk_buff *skb)
> {
>         count++;
>         bpf_tail_call_static(skb, &jmp_table, 0);
>         return count;
> }
>
> char __license[] SEC("license") =3D "GPL";

No need to put the whole selftest into commit log.

The below few paragraphs are enough:

> The attach target of entry_freplace is subprog_tc, and the tail callee
> in entry_freplace is entry_tc.
>
> Then, the infinite loop will be entry_tc -> subprog_tc -> entry_freplace
> --tailcall-> entry_tc, because tail_call_cnt in entry_freplace will count
> from zero for every time of entry_freplace execution. Kernel will panic,
> like:

99% of this full dump below is nothing but noise.
Drop it. Above "kernel will panic" is enough.

> [   15.310490] BUG: TASK stack guard page was hit at (____ptrval____)
> (stack is (____ptrval____)..(____ptrval____))
> [   15.310490] Oops: stack guard page: 0000 [#1] PREEMPT SMP NOPTI
> [   15.310490] CPU: 1 PID: 89 Comm: test_progs Tainted: G           OE
>    6.10.0-rc6-g026dcdae8d3e-dirty #72
> [   15.310490] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
> [   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
> fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
> [   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
> [   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
> 0000000000008cb5
> [   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
> ffff9c98808b7e00
> [   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
> 0000000000000000
> [   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
> ffffb500c01af000
> [   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
> 0000000000000000
> [   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
> knlGS:0000000000000000
> [   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
> 00000000000006f0
> [   15.310490] Call Trace:
> [   15.310490]  <#DF>
> [   15.310490]  ? die+0x36/0x90
> [   15.310490]  ? handle_stack_overflow+0x4d/0x60
> [   15.310490]  ? exc_double_fault+0x117/0x1a0
> [   15.310490]  ? asm_exc_double_fault+0x23/0x30
> [   15.310490]  ? bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
> [   15.310490]  </#DF>
> [   15.310490]  <TASK>
> [   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
> [   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
> [   15.310490]  ...
> [   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
> [   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
> [   15.310490]  bpf_test_run+0x210/0x370
> [   15.310490]  ? bpf_test_run+0x128/0x370
> [   15.310490]  bpf_prog_test_run_skb+0x388/0x7a0
> [   15.310490]  __sys_bpf+0xdbf/0x2c40
> [   15.310490]  ? clockevents_program_event+0x52/0xf0
> [   15.310490]  ? lock_release+0xbf/0x290
> [   15.310490]  __x64_sys_bpf+0x1e/0x30
> [   15.310490]  do_syscall_64+0x68/0x140
> [   15.310490]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   15.310490] RIP: 0033:0x7f133b52725d
> [   15.310490] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
> [   15.310490] RSP: 002b:00007ffddbc10258 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000141
> [   15.310490] RAX: ffffffffffffffda RBX: 00007ffddbc10828 RCX:
> 00007f133b52725d
> [   15.310490] RDX: 0000000000000050 RSI: 00007ffddbc102a0 RDI:
> 000000000000000a
> [   15.310490] RBP: 00007ffddbc10270 R08: 0000000000000000 R09:
> 00007ffddbc102a0
> [   15.310490] R10: 0000000000000064 R11: 0000000000000206 R12:
> 0000000000000004
> [   15.310490] R13: 0000000000000000 R14: 0000558ec4c24890 R15:
> 00007f133b6ed000
> [   15.310490]  </TASK>
> [   15.310490] Modules linked in: bpf_testmod(OE)
> [   15.310490] ---[ end trace 0000000000000000 ]---
> [   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
> [   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
> fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
> [   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
> [   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
> 0000000000008cb5
> [   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
> ffff9c98808b7e00
> [   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
> 0000000000000000
> [   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
> ffffb500c01af000
> [   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
> 0000000000000000
> [   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
> knlGS:0000000000000000
> [   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
> 00000000000006f0
> [   15.310490] Kernel panic - not syncing: Fatal exception in interrupt
> [   15.310490] Kernel Offset: 0x30000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Below paragraphs are almost ok, but pls use imperative language.
Instead of "this patch prevents ..."
say "Fix the issue by preventing update of ext prog .."

Consider using grammarly or chatgpt to make it less nerdy.

> This patch prevents this panic by preventing updating extended prog to
> prog_array map and preventing extending a prog, which has been updated
> to prog_array map, with freplace prog.
>
> If a prog or its subprog has been extended by freplace prog, the prog
> can not be updated to prog_array map.
>
> If a prog has been updated to prog_array map, it or its subprog can not
> be extended by freplace prog.
>
> BTW, fix a minor code style issue by replacing 8 spaces with a tab.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410080455.vy5GT8Vz-lkp@i=
ntel.com/
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h     | 21 ++++++++++++++++++++
>  kernel/bpf/arraymap.c   | 23 +++++++++++++++++++++-
>  kernel/bpf/core.c       |  1 +
>  kernel/bpf/syscall.c    | 21 ++++++++++++++------
>  kernel/bpf/trampoline.c | 43 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 102 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 19d8ca8ac960f..213a68c59bdf7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1294,6 +1294,12 @@ bool __bpf_dynptr_is_rdonly(const struct bpf_dynpt=
r_kern *ptr);
>  #ifdef CONFIG_BPF_JIT
>  int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tra=
mpoline *tr);
>  int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_t=
rampoline *tr);
> +int bpf_extension_link_prog(struct bpf_tramp_link *link,
> +                           struct bpf_trampoline *tr,
> +                           struct bpf_prog *tgt_prog);
> +int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
> +                             struct bpf_trampoline *tr,
> +                             struct bpf_prog *tgt_prog);
>  struct bpf_trampoline *bpf_trampoline_get(u64 key,
>                                           struct bpf_attach_target_info *=
tgt_info);
>  void bpf_trampoline_put(struct bpf_trampoline *tr);
> @@ -1383,6 +1389,18 @@ static inline int bpf_trampoline_unlink_prog(struc=
t bpf_tramp_link *link,
>  {
>         return -ENOTSUPP;
>  }
> +static inline int bpf_extension_link_prog(struct bpf_tramp_link *link,
> +                           struct bpf_trampoline *tr,
> +                           struct bpf_prog *tgt_prog)
> +{
> +       return -ENOTSUPP;
> +}
> +static inline int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
> +                             struct bpf_trampoline *tr,
> +                             struct bpf_prog *tgt_prog)
> +{
> +       return -ENOTSUPP;
> +}
>  static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
>                                                         struct bpf_attach=
_target_info *tgt_info)
>  {
> @@ -1483,6 +1501,9 @@ struct bpf_prog_aux {
>         bool xdp_has_frags;
>         bool exception_cb;
>         bool exception_boundary;
> +       bool is_extended; /* true if extended by freplace program */
> +       u64 prog_array_member_cnt; /* counts how many times as member of =
prog_array */
> +       struct mutex ext_mutex; /* mutex for is_extended and prog_array_m=
ember_cnt */
>         struct bpf_arena *arena;
>         /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>         const struct btf_type *attach_func_proto;
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 79660e3fca4c1..f9bd63a74eee7 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -947,6 +947,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *ma=
p,
>                                    struct file *map_file, int fd)
>  {
>         struct bpf_prog *prog =3D bpf_prog_get(fd);
> +       bool is_extended;
>
>         if (IS_ERR(prog))
>                 return prog;
> @@ -956,13 +957,33 @@ static void *prog_fd_array_get_ptr(struct bpf_map *=
map,
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       mutex_lock(&prog->aux->ext_mutex);
> +       is_extended =3D prog->aux->is_extended;
> +       if (!is_extended)
> +               prog->aux->prog_array_member_cnt++;
> +       mutex_unlock(&prog->aux->ext_mutex);
> +       if (is_extended) {
> +               /* Extended prog can not be tail callee. It's to prevent =
a
> +                * potential infinite loop like:
> +                * tail callee prog entry -> tail callee prog subprog ->
> +                * freplace prog entry --tailcall-> tail callee prog entr=
y.
> +                */
> +               bpf_prog_put(prog);
> +               return ERR_PTR(-EBUSY);
> +       }
> +
>         return prog;
>  }
>
>  static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool n=
eed_defer)
>  {
> +       struct bpf_prog *prog =3D ptr;
> +
> +       mutex_lock(&prog->aux->ext_mutex);
> +       prog->aux->prog_array_member_cnt--;
> +       mutex_unlock(&prog->aux->ext_mutex);
>         /* bpf_prog is freed after one RCU or tasks trace grace period */
> -       bpf_prog_put(ptr);
> +       bpf_prog_put(prog);
>  }
>
>  static u32 prog_fd_array_sys_lookup_elem(void *ptr)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5e77c58e06010..233ea78f8f1bd 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -131,6 +131,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int=
 size, gfp_t gfp_extra_flag
>         INIT_LIST_HEAD_RCU(&fp->aux->ksym_prefix.lnode);
>  #endif
>         mutex_init(&fp->aux->used_maps_mutex);
> +       mutex_init(&fp->aux->ext_mutex);
>         mutex_init(&fp->aux->dst_mutex);
>
>         return fp;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca54..4a5a44bbb5f50 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3212,15 +3212,21 @@ static void bpf_tracing_link_release(struct bpf_l=
ink *link)
>  {
>         struct bpf_tracing_link *tr_link =3D
>                 container_of(link, struct bpf_tracing_link, link.link);
> +       struct bpf_prog *tgt_prog =3D tr_link->tgt_prog;
>
> -       WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
> -                                               tr_link->trampoline));
> +       if (link->prog->type =3D=3D BPF_PROG_TYPE_EXT)
> +               WARN_ON_ONCE(bpf_extension_unlink_prog(&tr_link->link,
> +                                                      tr_link->trampolin=
e,
> +                                                      tgt_prog));
> +       else
> +               WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
> +                                                       tr_link->trampoli=
ne));

This early demux into two helpers looks odd.
I think it would be cleaner to add this logic to bpf_trampoline_unlink_prog=
()
Just extend it with an extra prog argument.

>         bpf_trampoline_put(tr_link->trampoline);
>
>         /* tgt_prog is NULL if target is a kernel function */
> -       if (tr_link->tgt_prog)
> -               bpf_prog_put(tr_link->tgt_prog);
> +       if (tgt_prog)
> +               bpf_prog_put(tgt_prog);
>  }
>
>  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> @@ -3354,7 +3360,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>          *   in prog->aux
>          *
>          * - if prog->aux->dst_trampoline is NULL, the program has alread=
y been
> -         *   attached to a target and its initial target was cleared (be=
low)
> +        *   attached to a target and its initial target was cleared (bel=
ow)
>          *
>          * - if tgt_prog !=3D NULL, the caller specified tgt_prog_fd +
>          *   target_btf_id using the link_create API.
> @@ -3429,7 +3435,10 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>         if (err)
>                 goto out_unlock;
>
> -       err =3D bpf_trampoline_link_prog(&link->link, tr);
> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT)
> +               err =3D bpf_extension_link_prog(&link->link, tr, tgt_prog=
);
> +       else
> +               err =3D bpf_trampoline_link_prog(&link->link, tr);

same here.

>         if (err) {
>                 bpf_link_cleanup(&link_primer);
>                 link =3D NULL;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f8302a5ca400d..b14f56046ad4e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -580,6 +580,35 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *=
link, struct bpf_trampoline
>         return err;
>  }
>
> +int bpf_extension_link_prog(struct bpf_tramp_link *link,
> +                           struct bpf_trampoline *tr,
> +                           struct bpf_prog *tgt_prog)
> +{
> +       struct bpf_prog_aux *aux =3D tgt_prog->aux;
> +       int err;
> +
> +       mutex_lock(&aux->ext_mutex);

pls use guard(mutex) as I suggested earlier.

> +       if (aux->prog_array_member_cnt) {
> +               /* Program extensions can not extend target prog when the=
 target
> +                * prog has been updated to any prog_array map as tail ca=
llee.
> +                * It's to prevent a potential infinite loop like:
> +                * tgt prog entry -> tgt prog subprog -> freplace prog en=
try
> +                * --tailcall-> tgt prog entry.
> +                */
> +               err =3D -EBUSY;
> +               goto out_unlock;
> +       }
> +
> +       err =3D bpf_trampoline_link_prog(link, tr);
> +       if (err)
> +               goto out_unlock;
> +
> +       aux->is_extended =3D true;
> +out_unlock:
> +       mutex_unlock(&aux->ext_mutex);
> +       return err;
> +}
> +
>  static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, str=
uct bpf_trampoline *tr)
>  {
>         enum bpf_tramp_prog_type kind;
> @@ -609,6 +638,20 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link=
 *link, struct bpf_trampolin
>         return err;
>  }
>
> +int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
> +                             struct bpf_trampoline *tr,
> +                             struct bpf_prog *tgt_prog)
> +{
> +       struct bpf_prog_aux *aux =3D tgt_prog->aux;
> +       int err;
> +
> +       mutex_lock(&aux->ext_mutex);
> +       err =3D bpf_trampoline_unlink_prog(link, tr);
> +       aux->is_extended =3D false;
> +       mutex_unlock(&aux->ext_mutex);

same suggestions.

pw-bot: cr

