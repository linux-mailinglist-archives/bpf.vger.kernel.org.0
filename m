Return-Path: <bpf+bounces-38135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5296079B
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934021C210C0
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063819D8A2;
	Tue, 27 Aug 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbE5Ff6S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086D182B2
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755073; cv=none; b=SY110qtehG6pVGGNt5vh28DX5aUVgcnJqQuI1/IsYtIwKTtgnxRudzUiMMTqo3KOud6e3FT0PVwH+SvgLTNVla4rHEqMbFOcS7n7t/vbFkx2AXJIRxebOdUB5Lq0ZC+982ZkXv/J49vTjeJnVH7EqzVdkuHa4+vggTeEBHHuYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755073; c=relaxed/simple;
	bh=2pJTM0vvasmsj5jZ2hAHyjd+7lUh8wH5We8Eq9wbeKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iq9mbc6oHDHmIKZ4E/DPyD1ASCoNQN4rQyUx74j1q9FhbSKbiWYwyrkd6aogDghTXmcQ6Khy+4hTxa1vXgKvF7V42u0XaQYrBwFAD5doOLuYVGPI8ZWwCF/5CitZL1YxNI3wHEvDtvnUk5TrOGHuOQjuwwrsaylU+kyM7FyffWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbE5Ff6S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021c03c13aso39815005ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724755071; x=1725359871; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0CFwYOmiWtOvDgJdWY8DwW5yfIoImnbqtxErErCpWZU=;
        b=mbE5Ff6SNrV7UoA98BAzCTjBci+UaYzkMAUYerh3uhzt1NKG0idW/AOABi0yBfMcyq
         dmn16SAj9TMwiVUgFozkBaOcgLuXdllb43MgtVD/MsTgRhfaDQuz4ELTr1B+H27YQwoi
         agCk0acYKedUi6UUkpFFwq/Yg6tW24NQ2d7iWK8P+nIELl4TPCxmNvoqDJMQOGqMKSgs
         SsSo4T8+yshFCnN9OMQBiNBS2gtn10oGOW+0F4p2OQDHkCzeD0YCYGwN2dDxpMT8pDEb
         UfEmGsOXYfYfqMW+vSU1x891bkB1l+veGQvcB5XCnMExg6zi+vvoryWmsC5Ikbu9+SJq
         5Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724755071; x=1725359871;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CFwYOmiWtOvDgJdWY8DwW5yfIoImnbqtxErErCpWZU=;
        b=e+9cvkC3Eb19m+PtgvMGGl0iqLA0pR7Ys2rosQHhahOEmecZMGlGUh3GVLiXcKNY5y
         nanYUSl8YkioQCPUXKLfFQP9V0SBlXosv7GpO7n/2ytpkAAPWlstXrWb4pZBAvRoZzsy
         5zncj+gRQeA9XS8xXa2v42mvZ1Jnz8j/8VBGx+qudcE57zO4RSnign0ohJ/+R+nOR5pV
         ANv1Ft8TvQ5+GdaIuFKV3PMO4iunCJKRIbRmr45MLIfUmJmLXzNBkGa23nt53NDtfgmF
         5ClZd0/LKxjRaxudMitwwMfw2dZ2pizRTI/l3d42MJQUp2hU6vEsi3FJRU68EJXngsPu
         HBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+p03WkZTCu5/aRuFGcIELRKgb22pwNS6YusAGWm8in2pL1GJ3iSzuNSjX5toZlY714BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrUuO0Y/vTPO7XEoliVsA0JWj47LV44zcBXqNIzuttxBpmmHR
	pJK4s1B7pG9cbCQB44nhi3T6kfEk+hO7i0buhrgRVTs9EMH++9Orfi2aGA==
X-Google-Smtp-Source: AGHT+IE6yV/mIRB1lHmMZf1bNVDuI5fcRyE4JBG2gXP+cFuwxIVKZdZUNGa9uxIhEnSj03XsrfkIMw==
X-Received: by 2002:a17:902:ec86:b0:1f4:a04e:8713 with SMTP id d9443c01a7336-204ddd87ec0mr35966205ad.28.1724755070652;
        Tue, 27 Aug 2024 03:37:50 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859f0121sm80664775ad.246.2024.08.27.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:37:50 -0700 (PDT)
Message-ID: <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop
 caused by freplace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Tue, 27 Aug 2024 03:37:45 -0700
In-Reply-To: <20240825130943.7738-2-leon.hwang@linux.dev>
References: <20240825130943.7738-1-leon.hwang@linux.dev>
	 <20240825130943.7738-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-25 at 21:09 +0800, Leon Hwang wrote:
> This patch fixes a tailcall infinite loop issue caused by freplace.
>=20
> Since commit 1c123c567fb1 ("bpf: Resolve fext program type when checking =
map compatibility"),
> freplace prog is allowed to tail call its target prog. Then, when a
> freplace prog attaches to its target prog's subprog and tail calls its
> target prog, kernel will panic.
>=20
> For example:
>=20
> tc_bpf2bpf.c:
>=20
> // SPDX-License-Identifier: GPL-2.0
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
>=20
> __noinline
> int subprog_tc(struct __sk_buff *skb)
> {
> 	return skb->len * 2;
> }
>=20
> SEC("tc")
> int entry_tc(struct __sk_buff *skb)
> {
> 	return subprog_tc(skb);
> }
>=20
> char __license[] SEC("license") =3D "GPL";
>=20
> tailcall_bpf2bpf_hierarchy_freplace.c:
>=20
> // SPDX-License-Identifier: GPL-2.0
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
>=20
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>=20
> int count =3D 0;
>=20
> static __noinline
> int subprog_tail(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
>=20
> SEC("freplace")
> int entry_freplace(struct __sk_buff *skb)
> {
> 	count++;
> 	subprog_tail(skb);
> 	subprog_tail(skb);
> 	return count;
> }
>=20
> char __license[] SEC("license") =3D "GPL";
>=20
> The attach target of entry_freplace is subprog_tc, and the tail callee
> in subprog_tail is entry_tc.
>=20
> Then, the infinite loop will be entry_tc -> subprog_tc -> entry_freplace
> -> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
> entry_freplace will count from zero for every time of entry_freplace
> execution. Kernel will panic:
>=20
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
>=20
> This patch fixes the issue by initializing tail_call_cnt at the prologue
> of entry_tc.
>=20
> Next, when call subprog_tc, the tail_call_cnt_ptr is propagated to
> subprog_tc by rax.
> Next, when jump to entry_freplace, the tail_call_cnt_ptr will be reused t=
o
> count tailcall in freplace prog.
> Next, when call subprog_tail, the tail_call_cnt_ptr is propagated to
> subprog_tail by rax.
> Next, while tail calling to entry_tc, the tail_call_cnt on the stack of
> entry_tc increments via the tail_call_cnt_ptr.
>=20
> The whole procedure shows as the following JITed prog dumping.
>=20
> bpftool p d j n entry_tc:
>=20
> int entry_tc(struct __sk_buff * skb):
> bpf_prog_1c515f389a9059b4_entry_tc:
> ; return subprog_tc(skb);
>    0:	endbr64
>    4:	xorq	%rax, %rax		;; rax =3D 0 (tail_call_cnt)
>    7:	nopl	(%rax,%rax)
>    c:	pushq	%rbp
>    d:	movq	%rsp, %rbp
>   10:	endbr64
>   14:	cmpq	$33, %rax		;; if rax > 33, rax =3D tcc_ptr
>   18:	ja	0x20			;; if rax > 33 goto 0x20 ---+
>   1a:	pushq	%rax			;; [rbp - 8] =3D rax =3D 0      |
>   1b:	movq	%rsp, %rax		;; rax =3D rbp - 8            |
>   1e:	jmp	0x21			;; ---------+               |
>   20:	pushq	%rax			;; <--------|---------------+
>   21:	pushq	%rax			;; <--------+ [rbp - 16] =3D rax
>   22:	movq	-16(%rbp), %rax		;; rax =3D tcc_ptr
>   29:	callq	0x70			;; call subprog_tc()
> ; return subprog_tc(skb);
>   2e:	leave
>   2f:	retq
>=20
> int subprog_tc(struct __sk_buff * skb):
> bpf_prog_1e8f76e2374a0607_subprog_tc:
> ; return skb->len * 2;
>    0:	endbr64
>    4:	nopl	(%rax)			;; do not touch tail_call_cnt
>    7:	jmp	0x108			;; jump to entry_freplace()
>    c:	pushq	%rbp
>    d:	movq	%rsp, %rbp
>   10:	endbr64
>   14:	pushq	%rax
>   15:	pushq	%rax
>   16:	movl	112(%rdi), %eax
> ; return skb->len * 2;
>   19:	shll	%eax
> ; return skb->len * 2;
>   1b:	leave
>   1c:	retq
>=20
> bpftool p d j n entry_freplace:
>=20
> int entry_freplace(struct __sk_buff * skb):
> bpf_prog_85781a698094722f_entry_freplace:
> ; int entry_freplace(struct __sk_buff *skb)
>    0:	endbr64
>    4:	nopl	(%rax)			;; do not touch tail_call_cnt
>    7:	nopl	(%rax,%rax)
>    c:	pushq	%rbp
>    d:	movq	%rsp, %rbp
>   10:	endbr64
>   14:	cmpq	$33, %rax		;; if rax > 33, rax =3D tcc_ptr
>   18:	ja	0x20			;; if rax > 33 goto 0x20 ---+
>   1a:	pushq	%rax			;; [rbp - 8] =3D rax =3D 0      |
>   1b:	movq	%rsp, %rax		;; rax =3D rbp - 8            |
>   1e:	jmp	0x21			;; ---------+               |
>   20:	pushq	%rax			;; <--------|---------------+
>   21:	pushq	%rax			;; <--------+ [rbp - 16] =3D rax
>   22:	pushq	%rbx			;; callee saved
>   23:	pushq	%r13			;; callee saved
>   25:	movq	%rdi, %rbx		;; rbx =3D skb (callee saved)
> ; count++;
>   28:	movabsq	$-123406219759616, %r13
>   32:	movl	(%r13), %edi
>   36:	addl	$1, %edi
>   39:	movl	%edi, (%r13)
> ; subprog_tail(skb);
>   3d:	movq	%rbx, %rdi		;; rdi =3D skb
>   40:	movq	-16(%rbp), %rax		;; rax =3D tcc_ptr
>   47:	callq	0x80			;; call subprog_tail()
> ; subprog_tail(skb);
>   4c:	movq	%rbx, %rdi		;; rdi =3D skb
>   4f:	movq	-16(%rbp), %rax		;; rax =3D tcc_ptr
>   56:	callq	0x80			;; call subprog_tail()
> ; return count;
>   5b:	movl	(%r13), %eax
> ; return count;
>   5f:	popq	%r13
>   61:	popq	%rbx
>   62:	leave
>   63:	retq
>=20
> int subprog_tail(struct __sk_buff * skb):
> bpf_prog_3a140cef239a4b4f_subprog_tail:
> ; int subprog_tail(struct __sk_buff *skb)
>    0:	endbr64
>    4:	nopl	(%rax)			;; do not touch tail_call_cnt
>    7:	nopl	(%rax,%rax)
>    c:	pushq	%rbp
>    d:	movq	%rsp, %rbp
>   10:	endbr64
>   14:	pushq	%rax			;; [rbp - 8]  =3D rax (tcc_ptr)
>   15:	pushq	%rax			;; [rbp - 16] =3D rax (tcc_ptr)
>   16:	pushq	%rbx			;; callee saved
>   17:	pushq	%r13			;; callee saved
>   19:	movq	%rdi, %rbx		;; rbx =3D skb
> ; asm volatile("r1 =3D %[ctx]\n\t"
>   1c:	movabsq	$-128494642337280, %r13	;; r13 =3D jmp_table
>   26:	movq	%rbx, %rdi		;; 1st arg, skb
>   29:	movq	%r13, %rsi		;; 2nd arg, jmp_table
>   2c:	xorl	%edx, %edx		;; 3rd arg, index =3D 0
>   2e:	movq	-16(%rbp), %rax		;; rax =3D [rbp - 16] (tcc_ptr)
>   35:	cmpq	$33, (%rax)
>   39:	jae	0x4e			;; if *tcc_ptr >=3D 33 goto 0x4e --------+
>   3b:	nopl	(%rax,%rax)		;; jmp bypass, toggled by poking       |
>   40:	addq	$1, (%rax)		;; (*tcc_ptr)++                        |
>   44:	popq	%r13			;; callee saved                        |
>   46:	popq	%rbx			;; callee saved                        |
>   47:	popq	%rax			;; undo rbp-16 push                    |
>   48:	popq	%rax			;; undo rbp-8  push                    |
>   49:	jmp	0xfffffffffffffe18	;; tail call target, toggled by poking |
> ; return 0;				;;                                     |
>   4e:	popq	%r13			;; restore callee saved <--------------+
>   50:	popq	%rbx			;; restore callee saved
>   51:	leave
>   52:	retq
>=20
> As a result, the tail_call_cnt is stored on the stack of entry_tc. And
> the tail_call_cnt_ptr is propagated between subprog_tc, entry_freplace,
> subprog_tail and entry_tc.
>=20
> Furthermore, trampoline is required to propagate
> tail_call_cnt/tail_call_cnt_ptr always, no matter whether there is
> tailcall at run time.
> So, it reuses trampoline flag "BIT(7)" to tell trampoline to propagate
> the tail_call_cnt/tail_call_cnt_ptr, as BPF_TRAMP_F_TAIL_CALL_CTX is not
> used by any other arch BPF JIT.

This change seem to be correct.
Could you please add an explanation somewhere why nop3/xor and nop5
are swapped in the prologue?

As far as I understand, this is done so that freplace program
would reuse xor generated for replaced program, is that right?
E.g. for tailcall_bpf2bpf_freplace test case disasm looks as follows:

--------------- entry_tc --------------
func #0:
0:	f3 0f 1e fa                         	endbr64
4:	48 31 c0                            	xorq	%rax, %rax
7:	0f 1f 44 00 00                      	nopl	(%rax,%rax)
c:	55                                  	pushq	%rbp
d:	48 89 e5                            	movq	%rsp, %rbp
10:	f3 0f 1e fa                         	endbr64
...

------------ entry_freplace -----------
func #0:
0:	f3 0f 1e fa                         	endbr64
4:	0f 1f 00                            	nopl	(%rax)
7:	0f 1f 44 00 00                      	nopl	(%rax,%rax)
c:	55                                  	pushq	%rbp
d:	48 89 e5                            	movq	%rsp, %rbp
...

So, if entry_freplace would be used to replace entry_tc instead
of subprog_tc, the disasm would change to:=20

--------------- entry_tc --------------
func #0:
0:	f3 0f 1e fa                         	endbr64
4:	48 31 c0                            	xorq	%rax, %rax
7:	0f 1f 44 00 00                      	jmp <entry_freplace>

Thus reusing %rax initialization from entry_tc.

> However, the bad effect is that it requires initializing tail_call_cnt at
> prologue always no matter whether the prog is tail_call_reachable, becaus=
e
> it is unable to confirm itself or its subprog[s] whether to be attached b=
y
> freplace prog.
> And, when call subprog, tail_call_cnt_ptr is required to be propagated
> to subprog always.

This seems unfortunate.
I wonder if disallowing to freplace programs when
replacement.tail_call_reachable !=3D replaced.tail_call_reachable
would be a better option?

[...]

