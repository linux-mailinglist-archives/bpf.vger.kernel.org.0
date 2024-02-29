Return-Path: <bpf+bounces-23085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B2586D54A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 21:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E702A286399
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6223B16A35B;
	Thu, 29 Feb 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCYjgIIp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D116A349;
	Thu, 29 Feb 2024 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239297; cv=none; b=Y4J7hwOdwKbHH0sA9K6HVmr7PLv7aZCjtjtbJOybY0DeYG9nE7MWMKeibaGgfIIbAWaGDlLZXhSsPF+/zeu7lB56e4hywHtr5GCLdLaRVY3MFf1L7RDLnTtxLTNpam6xNPPhP5cUFEBqd7RCwt86Nnzcb+9I/m5T+g+vZBfJVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239297; c=relaxed/simple;
	bh=Vo3k/UgoRrmyUGzlldwCCqinbenvGMIr4yM+BJI4MQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGGYESCk6oYOWL3OE6NLKH5z9kKuxJHVysJV+9fuIi9xubo6fgUeEhkvV6TSY2WqtYiQ5b2VwMocMjWicgMbpL2ViTo+AozVHdIXmCkparSGGIFp5Zpj8pofQ/wp5nj5DbZdbsj7upXdvKIc73m3g5F9aVbaNCfNfddfpsVzyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCYjgIIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01B2C43394;
	Thu, 29 Feb 2024 20:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239297;
	bh=Vo3k/UgoRrmyUGzlldwCCqinbenvGMIr4yM+BJI4MQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCYjgIIpWH9B+MiOIlBBO+UjeZdUhlOBs4J5aa6kMSnkrd28QijIqhDb30zXQ0GmY
	 nTPFp6vRuaGOlgLzbMPVTslCSpGIYUJ59sb0Gdy1sQuD2mmBY1cn3IQAjpJUHD3hpA
	 um0sFAoAZYapRIHosAUGhlY+ehfIzN6TDNf2X07K+bLXZHKImI37faNoAJAdv/ciQ7
	 Mj5YmDP4mcFbRCmN1s1mjIAXENKTlJ/q8Znahqa5dDnoEAKy7ApuWW+D+fJRPSo0GF
	 tcFGq9C8JwBAksDGKLVq95zhBRCPfZfNuToQyDnxpw6YmTJsujMSafDDn4hLpSxn4S
	 fIHc9bcSbHd6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com,
	xingwei lee <xrivendell7@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/8] x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
Date: Thu, 29 Feb 2024 15:41:21 -0500
Message-ID: <20240229204127.2861980-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204127.2861980-1-sashal@kernel.org>
References: <20240229204127.2861980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 32019c659ecfe1d92e3bf9fcdfbb11a7c70acd58 ]

When trying to use copy_from_kernel_nofault() to read vsyscall page
through a bpf program, the following oops was reported:

  BUG: unable to handle page fault for address: ffffffffff600000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 3231067 P4D 3231067 PUD 3233067 PMD 3235067 PTE 0
  Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 1 PID: 20390 Comm: test_progs ...... 6.7.0+ #58
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  RIP: 0010:copy_from_kernel_nofault+0x6f/0x110
  ......
  Call Trace:
   <TASK>
   ? copy_from_kernel_nofault+0x6f/0x110
   bpf_probe_read_kernel+0x1d/0x50
   bpf_prog_2061065e56845f08_do_probe_read+0x51/0x8d
   trace_call_bpf+0xc5/0x1c0
   perf_call_bpf_enter.isra.0+0x69/0xb0
   perf_syscall_enter+0x13e/0x200
   syscall_trace_enter+0x188/0x1c0
   do_syscall_64+0xb5/0xe0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
   </TASK>
  ......
  ---[ end trace 0000000000000000 ]---

The oops is triggered when:

1) A bpf program uses bpf_probe_read_kernel() to read from the vsyscall
page and invokes copy_from_kernel_nofault() which in turn calls
__get_user_asm().

2) Because the vsyscall page address is not readable from kernel space,
a page fault exception is triggered accordingly.

3) handle_page_fault() considers the vsyscall page address as a user
space address instead of a kernel space address. This results in the
fix-up setup by bpf not being applied and a page_fault_oops() is invoked
due to SMAP.

Considering handle_page_fault() has already considered the vsyscall page
address as a userspace address, fix the problem by disallowing vsyscall
page read for copy_from_kernel_nofault().

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com
Reported-by: xingwei lee <xrivendell7@gmail.com>
Closes: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com
Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240202103935.3154011-3-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/maccess.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 6993f026adec9..42115ac079cfe 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -3,6 +3,8 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
+#include <asm/vsyscall.h>
+
 #ifdef CONFIG_X86_64
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
@@ -15,6 +17,14 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
 		return false;
 
+	/*
+	 * Reading from the vsyscall page may cause an unhandled fault in
+	 * certain cases.  Though it is at an address above TASK_SIZE_MAX, it is
+	 * usually considered as a user space address.
+	 */
+	if (is_vsyscall_vaddr(vaddr))
+		return false;
+
 	/*
 	 * Allow everything during early boot before 'x86_virt_bits'
 	 * is initialized.  Needed for instruction decoding in early
-- 
2.43.0


