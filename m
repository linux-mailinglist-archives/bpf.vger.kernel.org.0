Return-Path: <bpf+bounces-77451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA92CDF3DB
	for <lists+bpf@lfdr.de>; Sat, 27 Dec 2025 04:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1AA73008F9C
	for <lists+bpf@lfdr.de>; Sat, 27 Dec 2025 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AFD224AF2;
	Sat, 27 Dec 2025 03:57:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp233.sjtu.edu.cn (smtp233.sjtu.edu.cn [202.120.2.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3A1E9B1A
	for <bpf@vger.kernel.org>; Sat, 27 Dec 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766807836; cv=none; b=XHgKYs+Rly/l5F3udRemOWtuhT+1JWTJp7BoF2gUoNBZfwQq+ZcQCkCZmAGWZ6xtdCSClv6HvRGa/nxdXokY+fxNXjz+44Gq+6yFM28muu7SWk/ImqCMAU10KJfLqmYWV8uDHBh4FAyfzGAzHe+6EVHZYizDjICsezQs1kR9PRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766807836; c=relaxed/simple;
	bh=N0j9x3kCQX+XRpaFcmuDaEL4LoY6FVqOY/cTmGoZXSQ=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=Vcf7FxKcvtYHQgaem6jtQ2ikCGfJi6mDemYehQwJcTcc/8jeXBiftunG2WeaEQGQvxuECBqOP9A2MmAXLfh/NExg/n1fxjaS1i8zKE9LhhLD5lqSllsKMxQzDq++V9ggjVEN5HXkZDsf/HA7eXTC3TL7a5YLz7rywmWS0JCYFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; arc=none smtp.client-ip=202.120.2.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
	by smtp233.sjtu.edu.cn (Postfix) with ESMTPS id 8325211B87D9E;
	Sat, 27 Dec 2025 11:51:07 +0800 (CST)
Received: from mstore132.sjtu.edu.cn (unknown [10.118.0.132])
	by mta91.sjtu.edu.cn (Postfix) with ESMTP id 5562E37C9CF;
	Sat, 27 Dec 2025 11:51:07 +0800 (CST)
Date: Sat, 27 Dec 2025 11:51:07 +0800 (CST)
From: =?gb2312?B?s8LA1g==?= <tom2cat@sjtu.edu.cn>
To: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, andrii@kernel.org, daniel@iogearbox.net
Message-ID: <1174895617.11202082.1766807467283.JavaMail.zimbra@sjtu.edu.cn>
Subject: [WARNING]BPF verifier: REG INVARIANTS VIOLATION(false_reg2) : range
 bounds violation at reg_bounds_sanity_check on 6.19-rc2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.0.14_GA_4767 (ZimbraWebClient - GC143 (Win)/10.0.15_GA_4781)
Thread-Index: oRWNSq+zjLuKMY2Pmqhg27UX//M6CA==
Thread-Topic: BPF verifier: REG INVARIANTS VIOLATION(false_reg2) : range bounds violation at reg_bounds_sanity_check on 6.19-rc2

Dear BPF maintainers,

Hello, I am reporting a bug in the BPF verifier where a register invariants=
 violation occurs during bounds checking, leading to an invalid range state=
 (u64 min > max). This was triggered by a selftest-like BPF program testing=
 32-bit signed boundary crossing with JMP32_JSLT. The issue appears to be a=
 logic error in range bounds deduction, possibly related to signed/unsigned=
 mixing or false branch register handling. I noticed that syzbot has a disc=
ussion about a similar bug=A3=BA
https://ci.syzbot.org/series/9bfb8ed3-0d6e-4ae4-93a1-e5d466326f9e
https://lore.kernel.org/all/694a9e1d.050a0220.19928e.0028.GAE@google.com/

## Environment

- Kernel version: Linux 6.19.0-rc2-gccd1cdca5cd4
- Architecture: x86_64
- Compiler: Debian clang version 16.0.6 (15~deb12u1)
- bpftool version: v7.6.0
- libbpf version: v1.6


## Reproducer

Poc.c
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("xdp")
__attribute__((btf_decl_tag("comment:test_description=3D" "bound check with=
 JMP32_JSLT for crossing 32-bit signed boundary")))
__attribute__((btf_decl_tag("comment:test_expect_success"))) __attribute__(=
(btf_decl_tag("comment:test_retval=3D""0")))
__attribute__((btf_decl_tag("comment:test_prog_flags=3D""!BPF_F_TEST_REG_IN=
VARIANTS")))
__attribute__((naked)) void crossing_32_bit_signed_boundary_2(void)
{
    asm volatile (
        "r2 =3D *(u32*)(r1 + %[xdp_md_data]);"
        "r3 =3D *(u32*)(r1 + %[xdp_md_data_end]);"
        "r1 =3D r2;"
        "r1 +=3D 1;"
        "if r1 > r3 goto l0_%=3D;"
        "r1 =3D *(u8*)(r2 + 0);"
        "w0 =3D 0x7fffff10;"
        "w1 +=3D w0;"
        "w2 =3D 0x80000fff;"
        "w0 =3D 0x80000000;"
        "l1_%=3D:"
        "w0 +=3D 1;"
        "if w0 s> w2 goto l0_%=3D;"
        "if w0 s< w1 goto l1_%=3D;"
        "r0 =3D 1;"
        "exit;"
        "l0_%=3D:"
        "r0 =3D 0;"
        "exit;"
        :
        : [xdp_md_data] "i" (offsetof(struct xdp_md, data)),
          [xdp_md_data_end] "i" (offsetof(struct xdp_md, data_end))
        : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "memo=
ry"
    );
}

char LICENSE[] SEC("license") =3D "GPL";


## Log

 ------------[ cut here ]------------
verifier bug: REG INVARIANTS VIOLATION (false_reg2): range bounds violation=
 u64=3D[0x80000010, 0x8000000f] s64=3D[0x80000010, 0x8000000f] u32=3D[0x800=
00010, 0x8000000f] s32=3D[0x80000010, 0x80000010] var_off=3D(0x80000000, 0x=
1f)
WARNING: kernel/bpf/verifier.c:2748 at reg_bounds_sanity_check+0x206/0xc30,=
 CPU#0: bpftool/7638
Modules linked in:
CPU: 0 UID: 0 PID: 7638 Comm: bpftool Not tainted 6.19.0-rc2-gccd1cdca5cd4 =
#1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:reg_bounds_sanity_check+0x3eb/0xc30
Code: 98 00 00 00 4c 8b 8c 24 88 00 00 00 41 ff 34 24 41 57 55 41 55 ff b4 =
24 f0 00 00 00 ff b4 24 a8 00 00 00 ff b4 24 c0 00 00 00 <67> 48 0f b9 3a 4=
8 83 c4 38 49 bf 00 00 00 00 00 fc ff df 48 8b 84
RSP: 0018:ffffc9000b67ef30 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff11024059612 RCX: 0000000080000010
RDX: ffffffff8b52f560 RSI: ffffffff8b538240 RDI: ffffffff905fff20
RBP: 0000000080000010 R08: 000000008000000f R09: 0000000080000010
R10: 00000000000000d0 R11: 0000000000000000 R12: ffff8881202cb090
R13: 0000000080000010 R14: 1ffff11024059611 R15: 0000000080000000
FS:  00007f34f3a41780(0000) GS:ffff888261e92000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b031c72000 CR3: 000000010babe000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 check_cond_jmp_op+0x1908/0x2cc0
 ? __pfx_verbose+0x10/0x10
 ? __pfx_check_cond_jmp_op+0x10/0x10
 ? bpf_reset_stack_write_marks+0x1f0/0x260
 do_check+0x5cc9/0xeb80
 ? __might_fault+0xb4/0x130
 ? __pfx_do_check+0x10/0x10
 ? __pfx_verbose+0x10/0x10
 ? __pfx_disasm_kfunc_name+0x10/0x10
 do_check_common+0x1a1e/0x2600
 bpf_check+0x16a62/0x1bf90
 ? is_bpf_text_address+0x2b/0x2b0
 ? is_bpf_text_address+0x2b/0x2b0
 ? is_bpf_text_address+0x297/0x2b0
 ? is_bpf_text_address+0x2b/0x2b0
 ? __kernel_text_address+0x12/0x40
 ? unwind_get_return_address+0x52/0x90
 ? __lock_acquire+0x6b5/0x2c60
 ? __lock_acquire+0x6b5/0x2c60
 ? pcpu_memcg_post_alloc_hook+0x7c/0x590
 ? __pfx_bpf_check+0x10/0x10
 ? ktime_get_with_offset+0x91/0x2a0
 ? ktime_get_with_offset+0x91/0x2a0
 ? bpf_lsm_bpf_prog_load+0xe/0x20
 ? security_bpf_prog_load+0x12a/0x3f0
 bpf_prog_load+0x1557/0x1be0
 ? __pfx_bpf_prog_load+0x10/0x10
 ? __might_fault+0xb4/0x130
 ? __might_fault+0xb4/0x130
 ? bpf_lsm_bpf+0xe/0x20
 ? security_bpf+0x83/0x300
 __sys_bpf+0x573/0x910
 ? __pfx___sys_bpf+0x10/0x10
 ? exc_page_fault+0x71/0xd0
 __x64_sys_bpf+0x81/0x90
 do_syscall_64+0xea/0xf80
 ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
 ? trace_irq_disable+0x37/0x100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f34f3d207d9
Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d f7 05 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff8186b908 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f34f3d207d9
RDX: 0000000000000098 RSI: 00007fff8186b990 RDI: 0000000000000005
RBP: 000055b031c64c50 R08: 00007fff8186bac0 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000098
R13: 00007fff8186b990 R14: 00007fff8186b990 R15: 000055b031c66e80
</TASK>
----------------

