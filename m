Return-Path: <bpf+bounces-54076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753ADA61DA5
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C5D88386C
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889821ACED3;
	Fri, 14 Mar 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHQXZZUh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CB131E2D;
	Fri, 14 Mar 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986517; cv=none; b=hD/nAyDi0sGFQ/nY55rn133BecixD7nQJ9I+LtA/mz5rJWZ8JfKDLMwen/zgRnn8BddOH3pu4gVckMHE9XYYGTvDm9hzfZnvk3nwEXWBlS6sw++D6UWp8iIbLGcBsHCcf9x3AdxrNL+l9oiI0BkhIA4QytZf/s4vvMHj8E4aesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986517; c=relaxed/simple;
	bh=hiZ+Son+grgrSk/sJLmrdMFOSZOoKTbVCW5HdAyQa8s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/b7URRfpFMKWCVa62yd/Rxiia31S03r4ZuTisSDwTIoqqLHEdchDIHFvTgpb2AmhGF1THmiSPZXvSPGlUgkAny8jcIFG2SIyrnEfQyILLNuUbpBks5OMowUS7R25IWv1fwggvVyV6WZOu3fzhN1My0YEAvivWfiT9lCm3xEZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHQXZZUh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224171d6826so63364955ad.3;
        Fri, 14 Mar 2025 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741986514; x=1742591314; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ItZwr7jwtJlvdfaZ6NezaYrshwwloW29/e2NSC7fACg=;
        b=AHQXZZUhRzjw9c8pCeyxaExn0NAIOekRv1B5jmDqVdLfWBa3xfNc3WWeMH+ITr6Du/
         JWNlaUA02NaA2XlZAJEqludtAR8XapbOYAThLOm89TNeyjLiofZ87y0IA3IYjG3HJHeP
         ZL7TCfDMVJEFFDt35CUYKK3OcIA4535Jpnz9VHyr6kpxyZrx4/3ZsOepFccQY4zKCjAI
         xlbFCXkX2dRZ/D33EPwwC55AKQmxQv7lOaXfTRrNXqZ3ZvKZpjG6FC+OyFpiJb66vN3j
         n60h/ulEY24mqRV6yNU+gymTU+oQzgQofrZdzmT2xDWLVr0GiCiMtik3p0Rz4uLhSl3f
         Bw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741986514; x=1742591314;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItZwr7jwtJlvdfaZ6NezaYrshwwloW29/e2NSC7fACg=;
        b=K2VYeF723vxYawP5sg67rPTmDdycxO++t+uXXlX1RQY0A1DWEBjGM1WprkImYuP9/e
         n+i12eV6m1S0vlCiiOtfz4fY4AH7e0jPPcNqfYwKHTThQVWllFmahojVuBvdyZdEm4cY
         N8SQASefzScWtukihj9MHdbGRhq1cfrkieaP9OHJSBOzUO5vMO0a2GY5vFjfsAd6sWGE
         na77hGRUukZM76Py2S3gzsmE71Q0mavXrzsDZ/EVNVGtFnRcCpXKOGGM7cuLnsYKSWF5
         HNNrxJqFkt/VTPe06VzV3vCLIwOcW5hMFofzp+m26w+7fKMPbfXITB/k/IamLQXE8cVe
         i19w==
X-Forwarded-Encrypted: i=1; AJvYcCW6787ts+v49y1bQfH281KKi5QEbfiBy26Q9WPVHDSTvDHbosw0aAVjTeOVTdSjnKThUUlK2OT60waw0RY3@vger.kernel.org, AJvYcCXOHkDkjPsqENlk1rOsQquoaJFAXclZCjgcT4N1078coU9hE6qGY/Ds0A4PohjSTU49acU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxFqaTlfY+kxiZcDclhr033/2PMDq7kHuCYLiPKpH2g/GXQrS
	EbjBqZxf/4KSYDmrpTrmzcAzDdHlQpllhY413ScOuSDnbyH/1XGT
X-Gm-Gg: ASbGncv8lazgYqDsDPf9uy2k/RrNm7OBBvK6Sk+uZVD9Dj+anU5YLTrUSpSvLCAhn4k
	VGvupEqSuo0woopoqAgnAtYBi1AjOyxYvt0R02ZGBzBmdbFZVDzLDHoveRLAjs/bZKE/Pba7o+Q
	goBgww2fP6cXPwGratMV54P+mMjuM8imfMCW1Z+L7y0HmJFFJhjxXPNbi0gI1e7Gs10H3M7qLXy
	DdqwUU0YL/a4J+aWj1iFMKBU+Tsar2bmjGw/AWx8gzj+qZf16kv0gQVFElaqQxqJMBbVdLgAWcw
	+EguxJHoPF8wOw33BJGi+dSpUBNKauClricX0/aJPmhQYzm5Zuc=
X-Google-Smtp-Source: AGHT+IEutJ9Um8SAmVFWlRaAOHJABH2JcsKzAl0BDZhy5GHzb3KM2GoGLgumIsOA0961SmwO7AhrIg==
X-Received: by 2002:a05:6a00:2343:b0:730:9752:d02a with SMTP id d2e1a72fcca58-7372236c6a7mr4952384b3a.4.1741986514481;
        Fri, 14 Mar 2025 14:08:34 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e69sm3424875b3a.141.2025.03.14.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:08:34 -0700 (PDT)
Message-ID: <c11f1caa46535ebb102d1ed2bba83bf257ef6939.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Fix out-of-bounds read in
 check_atomic_load/store()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kohei Enju <enjuk@amazon.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Peilin Ye
 <yepeilin@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Kuniyuki
 Iwashima	 <kuniyu@amazon.com>, kohei.enju@gmail.com, 
	syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Date: Fri, 14 Mar 2025 14:08:29 -0700
In-Reply-To: <20250314195619.23772-2-enjuk@amazon.com>
References: <20250314195619.23772-2-enjuk@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-15 at 04:54 +0900, Kohei Enju wrote:
> syzbot reported the following splat [0].
>=20
> In check_atomic_load/store(), register validity is not checked before
> atomic_ptr_type_ok(). This causes the out-of-bounds read in is_ctx_reg()
> called from atomic_ptr_type_ok() when the register number is MAX_BPF_REG
> or greater.
>=20
> Add check_reg_arg() before atomic_ptr_type_ok(), and return early when
> the register is invalid.
>=20
> [0]
>  BUG: KASAN: slab-out-of-bounds in is_ctx_reg kernel/bpf/verifier.c:6185 =
[inline]
>  BUG: KASAN: slab-out-of-bounds in atomic_ptr_type_ok+0x3d7/0x550 kernel/=
bpf/verifier.c:6223
>  Read of size 4 at addr ffff888141b0d690 by task syz-executor143/5842
>=20
>  CPU: 1 UID: 0 PID: 5842 Comm: syz-executor143 Not tainted 6.14.0-rc3-syz=
kaller-gf28214603dc6 #0
>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 02/12/2025
>  Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:408 [inline]
>   print_report+0x16e/0x5b0 mm/kasan/report.c:521
>   kasan_report+0x143/0x180 mm/kasan/report.c:634
>   is_ctx_reg kernel/bpf/verifier.c:6185 [inline]
>   atomic_ptr_type_ok+0x3d7/0x550 kernel/bpf/verifier.c:6223
>   check_atomic_store kernel/bpf/verifier.c:7804 [inline]
>   check_atomic kernel/bpf/verifier.c:7841 [inline]
>   do_check+0x89dd/0xedd0 kernel/bpf/verifier.c:19334
>   do_check_common+0x1678/0x2080 kernel/bpf/verifier.c:22600
>   do_check_main kernel/bpf/verifier.c:22691 [inline]
>   bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
>   bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
>   __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
>   __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x7fa3ac86bab9
>  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>  RSP: 002b:00007ffe50fff5f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa3ac86bab9
>  RDX: 0000000000000094 RSI: 00004000000009c0 RDI: 0000000000000005
>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>  R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
>=20
>  Allocated by task 5842:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>   kasan_kmalloc include/linux/kasan.h:260 [inline]
>   __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4325
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   do_check_common+0x1ec/0x2080 kernel/bpf/verifier.c:22499
>   do_check_main kernel/bpf/verifier.c:22691 [inline]
>   bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
>   bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
>   __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
>   __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
>  The buggy address belongs to the object at ffff888141b0d000
>   which belongs to the cache kmalloc-2k of size 2048
>  The buggy address is located 312 bytes to the right of
>   allocated 1368-byte region [ffff888141b0d000, ffff888141b0d558)
>=20
>  The buggy address belongs to the physical page:
>  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x141=
b08
>  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>  flags: 0x57ff00000000040(head|node=3D1|zone=3D2|lastcpupid=3D0x7ff)
>  page_type: f5(slab)
>  raw: 057ff00000000040 ffff88801b042000 dead000000000100 dead000000000122
>  raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
>  head: 057ff00000000040 ffff88801b042000 dead000000000100 dead00000000012=
2
>  head: 0000000000000000 0000000080080008 00000000f5000000 000000000000000=
0
>  head: 057ff00000000003 ffffea000506c201 ffffffffffffffff 000000000000000=
0
>  head: 0000000000000008 0000000000000000 00000000ffffffff 000000000000000=
0
>  page dumped because: kasan: bad access detected
>  page_owner tracks the page as allocated
>  page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0=
(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),=
 pid 1, tgid 1 (swapper/0), ts 8909973200, free_ts 0
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1585
>   prep_new_page mm/page_alloc.c:1593 [inline]
>   get_page_from_freelist+0x3a8c/0x3c20 mm/page_alloc.c:3538
>   __alloc_frozen_pages_noprof+0x264/0x580 mm/page_alloc.c:4805
>   alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
>   alloc_slab_page mm/slub.c:2423 [inline]
>   allocate_slab+0x8f/0x3a0 mm/slub.c:2587
>   new_slab mm/slub.c:2640 [inline]
>   ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
>   __slab_alloc+0x58/0xa0 mm/slub.c:3916
>   __slab_alloc_node mm/slub.c:3991 [inline]
>   slab_alloc_node mm/slub.c:4152 [inline]
>   __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4320
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   virtio_pci_probe+0x54/0x340 drivers/virtio/virtio_pci_common.c:689
>   local_pci_probe drivers/pci/pci-driver.c:324 [inline]
>   pci_call_probe drivers/pci/pci-driver.c:392 [inline]
>   __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
>   pci_device_probe+0x6c5/0xa10 drivers/pci/pci-driver.c:451
>   really_probe+0x2b9/0xad0 drivers/base/dd.c:658
>   __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
>   driver_probe_device+0x50/0x430 drivers/base/dd.c:830
>   __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
>   bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
>   bus_add_driver+0x346/0x670 drivers/base/bus.c:678
>  page_owner free stack trace missing
>=20
>  Memory state around the buggy address:
>   ffff888141b0d580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888141b0d600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  >ffff888141b0d680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                           ^
>   ffff888141b0d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888141b0d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>=20
> Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da5964227adc0f904549c
> Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
> Fixes: e24bbad29a8d ("bpf: Introduce load-acquire and store-release instr=
uctions")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---

I wonder if we have test cases for malformed instructions.
Maybe add one since this issue was hit?

>  kernel/bpf/verifier.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3303a3605ee8..6481604ab612 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7788,6 +7788,12 @@ static int check_atomic_rmw(struct bpf_verifier_en=
v *env,
>  static int check_atomic_load(struct bpf_verifier_env *env,
>  			     struct bpf_insn *insn)
>  {
> +	int err;
> +
> +	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
> +	if (err)
> +		return err;
> +

I agree with these changes, however, both check_load_mem() and
check_store_reg() already do check_reg_arg() first thing.
Maybe just swap the atomic_ptr_type_ok() and check_load_mem()?

>  	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
>  		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
>  			insn->src_reg,
> @@ -7801,6 +7807,12 @@ static int check_atomic_load(struct bpf_verifier_e=
nv *env,
>  static int check_atomic_store(struct bpf_verifier_env *env,
>  			      struct bpf_insn *insn)
>  {
> +	int err;
> +
> +	err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> +	if (err)
> +		return err;
> +
>  	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
>  		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
>  			insn->dst_reg,



