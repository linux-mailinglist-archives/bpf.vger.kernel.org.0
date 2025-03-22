Return-Path: <bpf+bounces-54566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96D2A6C79C
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 05:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B4046126D
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 04:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF4149C64;
	Sat, 22 Mar 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ap3tWabb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAF43159;
	Sat, 22 Mar 2025 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742619270; cv=none; b=MeRcBnmH5MQPZoefN8JThyihJWO3O9c3GhzNOQiiRQRDw9r4SQtuk3wY/P9O/AHr1OKLMKLv8F1WUPl8OKPTWbuBHvF6Az5VzuzO9hF1ovba9mEGE0Qhxx0nC+225vxVHI6PRWAIQMa7jmlfyaYzAiFn519byPnQxdBPVh4xrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742619270; c=relaxed/simple;
	bh=3ydXXbT5equQ3C1uE4/yvOoMekh4kDDX0mnFYBjTixk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ+ZOzPH0ggrff2N7gu8tasiJDKwhojWDGzSMCqPqHeWusauokat1RRlxVRCcYV6aJAuRnRLFD22CZzcjOouvSn+FZZUjDHL77Xjhon6NidOUSZgfgSUcUZS6fqtHN94YRi5fqhq5x8KdcBJfsQhI+FHvAJ8WeBVRJzKYNYI2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ap3tWabb; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742619269; x=1774155269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N0xR7ZaOD6iJPKT2G6sb7uOVN4ndCLRhd0TH5TyGygw=;
  b=Ap3tWabbl9AOLSkOVnQ4XqphxOjEMxIdrGBExCsg8LWb+MaPSlIK4unU
   wdwyN48xF9BRfU+OJp0B+9r7wqJEukHn7K/jHIIHWOXsrT8zw7lvSP5Ah
   OGk7nESfwg5oVzAJQZnzXKywbjqMlYUS7Wmq8w3DzH0F3bSP9eITdKmOn
   c=;
X-IronPort-AV: E=Sophos;i="6.14,266,1736812800"; 
   d="scan'208";a="180893015"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 04:54:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:36160]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.118:2525] with esmtp (Farcaster)
 id 0e76b754-3f32-4f7c-a4cd-f3b58a70cc28; Sat, 22 Mar 2025 04:54:26 +0000 (UTC)
X-Farcaster-Flow-ID: 0e76b754-3f32-4f7c-a4cd-f3b58a70cc28
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 04:54:26 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 04:54:20 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Peilin Ye <yepeilin@google.com>, Ilya Leoshkevich
	<iii@linux.ibm.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>,
	<syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
Subject: [PATCH v3 bpf-next 1/2] bpf: Fix out-of-bounds read in check_atomic_load/store()
Date: Sat, 22 Mar 2025 13:52:55 +0900
Message-ID: <20250322045340.18010-5-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250322045340.18010-4-enjuk@amazon.com>
References: <20250322045340.18010-4-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

syzbot reported the following splat [0].

In check_atomic_load/store(), register validity is not checked before
atomic_ptr_type_ok(). This causes the out-of-bounds read in is_ctx_reg()
called from atomic_ptr_type_ok() when the register number is MAX_BPF_REG
or greater.

Let's call check_load_mem()/check_store_reg() before atomic_ptr_type_ok()
to avoid the OOB read.

However, some tests introduced by commit ff3afe5da998 ("selftests/bpf: Add
selftests for load-acquire and store-release instructions") assume
calling atomic_ptr_type_ok() before checking register validity.
Therefore the swapping of order unintentionally changes verifier messages
of these tests.

For example in the test load_acquire_from_pkt_pointer(), expected message
is 'BPF_ATOMIC loads from R2 pkt is not allowed' although actual messages
are different.

  validate_msgs:FAIL:754 expect_msg
  VERIFIER LOG:
  =============
  Global function load_acquire_from_pkt_pointer() doesn't return scalar. Only those are supported.
  0: R1=ctx() R10=fp0
  ; asm volatile ( @ verifier_load_acquire.c:140
  0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx() R2_w=pkt(r=0)
  1: (d3) r0 = load_acquire((u8 *)(r2 +0))
  invalid access to packet, off=0 size=1, R2(id=0,off=0,r=0)
  R2 offset is outside of the packet
  processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  =============
  EXPECTED   SUBSTR: 'BPF_ATOMIC loads from R2 pkt is not allowed'
  #505/19  verifier_load_acquire/load-acquire from pkt pointer:FAIL

This is because instructions in the test don't pass check_load_mem() and
therefore don't enter the atomic_ptr_type_ok() path.
In this case, we have to modify instructions so that they pass the
check_load_mem() and trigger atomic_ptr_type_ok().
Similarly for store-release tests, we need to modify instructions so that
they pass check_store_reg().

Like load_acquire_from_pkt_pointer(), modify instructions in:
  load_acquire_from_sock_pointer()
  store_release_to_ctx_pointer()
  store_release_to_pkt_pointer()

Also in store_release_to_sock_pointer(), check_store_reg() returns error
early and atomic_ptr_type_ok() is not triggered, since write to sock
pointer is not possible in general.
We might be able to remove the test, but for now let's leave it and just
change the expected message.

[0]
 BUG: KASAN: slab-out-of-bounds in is_ctx_reg kernel/bpf/verifier.c:6185 [inline]
 BUG: KASAN: slab-out-of-bounds in atomic_ptr_type_ok+0x3d7/0x550 kernel/bpf/verifier.c:6223
 Read of size 4 at addr ffff888141b0d690 by task syz-executor143/5842

 CPU: 1 UID: 0 PID: 5842 Comm: syz-executor143 Not tainted 6.14.0-rc3-syzkaller-gf28214603dc6 #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
 Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:408 [inline]
  print_report+0x16e/0x5b0 mm/kasan/report.c:521
  kasan_report+0x143/0x180 mm/kasan/report.c:634
  is_ctx_reg kernel/bpf/verifier.c:6185 [inline]
  atomic_ptr_type_ok+0x3d7/0x550 kernel/bpf/verifier.c:6223
  check_atomic_store kernel/bpf/verifier.c:7804 [inline]
  check_atomic kernel/bpf/verifier.c:7841 [inline]
  do_check+0x89dd/0xedd0 kernel/bpf/verifier.c:19334
  do_check_common+0x1678/0x2080 kernel/bpf/verifier.c:22600
  do_check_main kernel/bpf/verifier.c:22691 [inline]
  bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
  bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
  __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
  __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x7fa3ac86bab9
 Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
 RSP: 002b:00007ffe50fff5f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa3ac86bab9
 RDX: 0000000000000094 RSI: 00004000000009c0 RDI: 0000000000000005
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
  </TASK>

 Allocated by task 5842:
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
  kasan_kmalloc include/linux/kasan.h:260 [inline]
  __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4325
  kmalloc_noprof include/linux/slab.h:901 [inline]
  kzalloc_noprof include/linux/slab.h:1037 [inline]
  do_check_common+0x1ec/0x2080 kernel/bpf/verifier.c:22499
  do_check_main kernel/bpf/verifier.c:22691 [inline]
  bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
  bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
  __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
  __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

 The buggy address belongs to the object at ffff888141b0d000
  which belongs to the cache kmalloc-2k of size 2048
 The buggy address is located 312 bytes to the right of
  allocated 1368-byte region [ffff888141b0d000, ffff888141b0d558)

 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x141b08
 head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
 page_type: f5(slab)
 raw: 057ff00000000040 ffff88801b042000 dead000000000100 dead000000000122
 raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
 head: 057ff00000000040 ffff88801b042000 dead000000000100 dead000000000122
 head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
 head: 057ff00000000003 ffffea000506c201 ffffffffffffffff 0000000000000000
 head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: kasan: bad access detected
 page_owner tracks the page as allocated
 page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 8909973200, free_ts 0
  set_page_owner include/linux/page_owner.h:32 [inline]
  post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1585
  prep_new_page mm/page_alloc.c:1593 [inline]
  get_page_from_freelist+0x3a8c/0x3c20 mm/page_alloc.c:3538
  __alloc_frozen_pages_noprof+0x264/0x580 mm/page_alloc.c:4805
  alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
  alloc_slab_page mm/slub.c:2423 [inline]
  allocate_slab+0x8f/0x3a0 mm/slub.c:2587
  new_slab mm/slub.c:2640 [inline]
  ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
  __slab_alloc+0x58/0xa0 mm/slub.c:3916
  __slab_alloc_node mm/slub.c:3991 [inline]
  slab_alloc_node mm/slub.c:4152 [inline]
  __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4320
  kmalloc_noprof include/linux/slab.h:901 [inline]
  kzalloc_noprof include/linux/slab.h:1037 [inline]
  virtio_pci_probe+0x54/0x340 drivers/virtio/virtio_pci_common.c:689
  local_pci_probe drivers/pci/pci-driver.c:324 [inline]
  pci_call_probe drivers/pci/pci-driver.c:392 [inline]
  __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
  pci_device_probe+0x6c5/0xa10 drivers/pci/pci-driver.c:451
  really_probe+0x2b9/0xad0 drivers/base/dd.c:658
  __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
  __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
  bus_add_driver+0x346/0x670 drivers/base/bus.c:678
 page_owner free stack trace missing

 Memory state around the buggy address:
  ffff888141b0d580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888141b0d600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff888141b0d680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                          ^
  ffff888141b0d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888141b0d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Fixes: e24bbad29a8d ("bpf: Introduce load-acquire and store-release instructions")
Fixes: ff3afe5da998 ("selftests/bpf: Add selftests for load-acquire and store-release instructions")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                            | 16 ++++++++++++++--
 .../selftests/bpf/progs/verifier_load_acquire.c  | 12 ++++++++++--
 .../selftests/bpf/progs/verifier_store_release.c | 14 +++++++++++---
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41fd93db8258..8ad7338e726b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7788,6 +7788,12 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 static int check_atomic_load(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_load_mem(env, insn, true, false, false, "atomic_load");
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
 		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
 			insn->src_reg,
@@ -7795,12 +7801,18 @@ static int check_atomic_load(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	return check_load_mem(env, insn, true, false, false, "atomic_load");
+	return 0;
 }
 
 static int check_atomic_store(struct bpf_verifier_env *env,
 			      struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_store_reg(env, insn, true);
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
@@ -7808,7 +7820,7 @@ static int check_atomic_store(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	return check_store_reg(env, insn, true);
+	return 0;
 }
 
 static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index 608097453832..1babe9ad9b43 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -139,10 +139,16 @@ __naked void load_acquire_from_pkt_pointer(void)
 {
 	asm volatile (
 	"r2 = *(u32 *)(r1 + %[xdp_md_data]);"
+	"r3 = *(u32 *)(r1 + %[xdp_md_data_end]);"
+	"r1 = r2;"
+	"r1 += 8;"
+	"if r1 >= r3 goto l0_%=;"
 	".8byte %[load_acquire_insn];" // w0 = load_acquire((u8 *)(r2 + 0));
+"l0_%=:  r0 = 0;"
 	"exit;"
 	:
 	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
 	  __imm_insn(load_acquire_insn,
 		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_2, 0))
 	: __clobber_all);
@@ -172,12 +178,14 @@ __naked void load_acquire_from_sock_pointer(void)
 {
 	asm volatile (
 	"r2 = *(u64 *)(r1 + %[sk_reuseport_md_sk]);"
-	".8byte %[load_acquire_insn];" // w0 = load_acquire((u8 *)(r2 + 0));
+	// w0 = load_acquire((u8 *)(r2 + offsetof(struct bpf_sock, family)));
+	".8byte %[load_acquire_insn];"
 	"exit;"
 	:
 	: __imm_const(sk_reuseport_md_sk, offsetof(struct sk_reuseport_md, sk)),
 	  __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_2, 0))
+		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_2,
+				   offsetof(struct bpf_sock, family)))
 	: __clobber_all);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
index f1c64c08f25f..cd6f1e5f378b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -140,11 +140,13 @@ __naked void store_release_to_ctx_pointer(void)
 {
 	asm volatile (
 	"w0 = 0;"
-	".8byte %[store_release_insn];" // store_release((u8 *)(r1 + 0), w0);
+	// store_release((u8 *)(r1 + offsetof(struct __sk_buff, cb[0])), w0);
+	".8byte %[store_release_insn];"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
-		     BPF_ATOMIC_OP(BPF_B, BPF_STORE_REL, BPF_REG_1, BPF_REG_0, 0))
+		     BPF_ATOMIC_OP(BPF_B, BPF_STORE_REL, BPF_REG_1, BPF_REG_0,
+				   offsetof(struct __sk_buff, cb[0])))
 	: __clobber_all);
 }
 
@@ -156,10 +158,16 @@ __naked void store_release_to_pkt_pointer(void)
 	asm volatile (
 	"w0 = 0;"
 	"r2 = *(u32 *)(r1 + %[xdp_md_data]);"
+	"r3 = *(u32 *)(r1 + %[xdp_md_data_end]);"
+	"r1 = r2;"
+	"r1 += 8;"
+	"if r1 >= r3 goto l0_%=;"
 	".8byte %[store_release_insn];" // store_release((u8 *)(r2 + 0), w0);
+"l0_%=:  r0 = 0;"
 	"exit;"
 	:
 	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
 	  __imm_insn(store_release_insn,
 		     BPF_ATOMIC_OP(BPF_B, BPF_STORE_REL, BPF_REG_2, BPF_REG_0, 0))
 	: __clobber_all);
@@ -185,7 +193,7 @@ __naked void store_release_to_flow_keys_pointer(void)
 
 SEC("sk_reuseport")
 __description("store-release to sock pointer")
-__failure __msg("BPF_ATOMIC stores into R2 sock is not allowed")
+__failure __msg("R2 cannot write into sock")
 __naked void store_release_to_sock_pointer(void)
 {
 	asm volatile (
-- 
2.48.1


