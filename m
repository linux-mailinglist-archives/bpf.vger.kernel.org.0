Return-Path: <bpf+bounces-64045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A5B0DAEB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE487562095
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3A23B636;
	Tue, 22 Jul 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgr1Tgre"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFC1E4A9
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191263; cv=none; b=HkjvHtdBur385AgZMtKAhfG7c7iufdQp0aX5p6VMiQ7GIhw1xr9DwK1UnRm6wb/p5Hy3mn3ygOvGzu/zTEy211C6Bt0ckR0QwRnZSxm9HQ+VgJFrqCB+3ZtKSZORiK+kynwB738rVzdlyLiJmUURgF/+Ux8fv7JwVOJEe3rTJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191263; c=relaxed/simple;
	bh=cpVVOpKqJMowKezArzWqHRnlHnTMZtgYv2FGlQcjelg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O7fcyBM1RIwhXj3aTm8DbodTZqt+2VVV3z3qHoFfMkHkCxvivyvlO49tyrSAExMEfkpjMEmSphhGwPYrPPXLg8ASwaIbhRcUhSFeLlfGzG/GY4aGaZ4Kw62Yoa1TBvpOTThCAiTg9ilXNLnEWIbESHDVOvja4+0AIxOBFcmrbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgr1Tgre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA7C4CEEB;
	Tue, 22 Jul 2025 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191263;
	bh=cpVVOpKqJMowKezArzWqHRnlHnTMZtgYv2FGlQcjelg=;
	h=From:To:Subject:Date:From;
	b=Tgr1TgreItVdtbas0lUgDgplkZknhj2bZad+h2WFv3IUsWylxMcKFdJ2kIfs74WiS
	 TfHJf5HrHwrneGIjJSxUW83pxc+fYLwF2ZS2+Fi9gzm5/L6AG7agd2v0GJDBidTY56
	 JFar8i4LkGUyNSe3MwefDDfLEatMljq3V9QWUogfGkt/HOdTeEenVBUr8ucvj4emqr
	 JumnCDtiFsFz3maCK7Vczfgaupjmt8kMB4uh2vqT78SAB/zF8vKOyxuNRtfys2YAOA
	 su0r5/UK4wA6WebByF6IU3nOgZ/HRf+3hryBmFHhdu529uDngxhz94WXcaUvQXMynw
	 CqKWzm3RV73Gw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/1] bpf, arm64: fix fp initialization for exception boundary
Date: Tue, 22 Jul 2025 13:34:08 +0000
Message-ID: <20250722133410.54161-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ARM64 BPF JIT when prog->aux->exception_boundary is set for a BPF
program, find_used_callee_regs() is not called because for a program acting
as exception boundary, all callee saved registers are saved.
find_used_callee_regs() sets `ctx->fp_used = true;` when it sees FP being
used in any of the instructions.
For programs acting as exception boundary, ctx->fp_used always remains
false and therefore, BPF frame pointer is never set-up for such programs in
the prologue.

This can cause crashes like:

With the following BPF program loaded and attached:

    static __noinline int static_func(u64 i)
    {
            bpf_throw(0);
            return i;
    }

    SEC("fentry/do_unlinkat")
    int BPF_PROG(do_unlinkat, int dfd, struct filename *name)
    {
            volatile u64 a[2] = {0};

            a[1] = __sync_fetch_and_add(&a[0], 1);

            static_func(23);
            return 0;
    }

Triggering it causes a page fault because the FP register is not
initialised.

[root@localhost ~]# touch test
[root@localhost ~]# rm test
 Unable to handle kernel paging request at virtual address fffffffffffffff0
 Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000043783000
 [fffffffffffffff0] pgd=0000000000000000, p4d=00000000450a0403, pud=00000000450a1403, pmd=0000000000000000
 Internal error: Oops: 0000000096000006 [#1]  SMP
 Modules linked in:
 CPU: 12 UID: 0 PID: 487 Comm: rm Not tainted 6.16.0-rc6-00212-g7abc678e3084 #7 PREEMPT
 Hardware name: linux,dummy-virt (DT)
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : bpf_prog_5148f2d6554f3ab3_do_unlinkat+0x48/0x90
 lr : bpf_trampoline_6442562433+0x68/0x168
 sp : ffff80008c8b3d10
 x29: ffff80008c8b3d80 x28: ffff0000d66d0000 x27: 0000000000000000
 x26: ffff80008c8b3d70 x25: 0000000000000000 x24: 0000000000000000
 x23: 0000000060001000 x22: 0000ffffaea95b0c x21: 00000000ffffffff
 x20: 0000000000000001 x19: ffff80008c1bd000 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000020000 x12: 0000000000000015
 x11: 0000000000000000 x10: fffffffffffffff0 x9 : ffff8000871d65e8
 x8 : ffff800084eb1d30 x7 : 0000000000000000 x6 : 0000000000000001
 x5 : 00000000c3affd79 x4 : 000000001055937d x3 : ffff801809627000
 x2 : ffff0000d66d0000 x1 : 0000000100000000 x0 : 0000000000000001
 Call trace:
  bpf_prog_5148f2d6554f3ab3_do_unlinkat+0x48/0x90 (P)
  bpf_trampoline_6442562433+0x68/0x168
  do_unlinkat+0x8/0x290
  __arm64_sys_unlinkat+0x44/0x90
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x48/0xf0
  el0t_64_sync_handler+0xc8/0xd0
  el0t_64_sync+0x198/0x1a0
 Code: f90007e0 f90003e0 d2800020 d100432a (f8e00140)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x2000,000081c0,02004ca1,04407a0b
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

Please take it into the bpf tree if needed, I sent it to bpf-next as
this bug is multiple months old.

Puranjay Mohan (1):
  bpf, arm64: fix fp initialization for exception boundary

 arch/arm64/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.47.1


