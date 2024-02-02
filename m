Return-Path: <bpf+bounces-21039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC6846E18
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 11:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678BB1C23EF9
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB713D512;
	Fri,  2 Feb 2024 10:38:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46112B159;
	Fri,  2 Feb 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870330; cv=none; b=J5lDeBRqt9TK2F48J/BNogIwnw74ns4doyP0/AKg3/joZtJEn1U6KHY05b3rWtNLiVz7GPsFdsqA8Wpfs3zsenBu6fjKCQGtP5RcA189DuLiHmr1/m1fbtSwcliZjvVUyYG1Yy9htbqiIvd3cxJ0t6HeL99Q2mA4hA7fzBs/ulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870330; c=relaxed/simple;
	bh=WbBu3/T/kZRzPSrOvtk9vfTthyAtax8KVPQchPHbkPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTh/R16k+nbBdLcS6+DNnOCfB9PsirQDpYfxzFv7CgqxXnvG85Eo4WShoGP1keoM0EQnX/gcQHrKH9S5Eoy9IcItZLAM3Sop6n1DRz/D+rxEhUcDSU25n9+GIGtZW39h2tFNiSnnhAPw7o3xJUrvjhwtCNNFmD1SDQGzi3G+xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TRC1D4wtfz4f3l2N;
	Fri,  2 Feb 2024 18:38:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E87501A0175;
	Fri,  2 Feb 2024 18:38:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REwxrxl46r1Cg--.15879S6;
	Fri, 02 Feb 2024 18:38:44 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: x86@kernel.org,
	bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	Jann Horn <jannh@google.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	houtao1@huawei.com
Subject: [PATCH bpf v3 2/3] x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
Date: Fri,  2 Feb 2024 18:39:34 +0800
Message-Id: <20240202103935.3154011-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240202103935.3154011-1-houtao@huaweicloud.com>
References: <20240202103935.3154011-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REwxrxl46r1Cg--.15879S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCryUKF1fGF45GF1fCFWDtwb_yoW5Zw18p3
	y5Cw43Kr4FkF18AFsFq340vay8J3WvvF45Gryvvry5Zay7WFn0yrWkWa4vqrZrAFnrKrWf
	Wr4DArWDtw15X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

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
2.29.2


