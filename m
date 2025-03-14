Return-Path: <bpf+bounces-54067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7CAA61B29
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 20:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AAC420537
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC3204F62;
	Fri, 14 Mar 2025 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F+IVbaAB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BC204C0A;
	Fri, 14 Mar 2025 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982205; cv=none; b=M5gSckPKeexkPT/5KLxsdxEN986N9u+nmMWyGxeZd2YiAEIlJ9ojQQzI4kTAhACss/HJt8CnHIpnpkNZ1zxhJlE2KjK0LFxMt7uCNA8U7cHcjesPc5BEh+1Fvqf41j8w+aylvhueQXPiyUU8d9mB2HUQT2lGBCaeB8bcwV3r5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982205; c=relaxed/simple;
	bh=U3LTqnaQoJ6cnivkZhFFJm/5At6UnuFG6cx9LlZRvUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxvT2sOuqXH5tWSkj1t3QFh71L6VFxJUV/RP35izGTALNKgjVukejsvUEH4vmF5II8TFLxL8FlgOi3R41WGa0caX1Q2atOqHlnJBOeozWYbWoTW6l0UM/nBtQMjB+qRVdPsUYRKhOf9Nf/gY1v5PGsx1CXDOPe8vvIkpuc1OhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F+IVbaAB; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741982203; x=1773518203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U7wRJ7VC+rv4EtJEW3sN+uBrLZBEFVu4eIr+PzFjG2M=;
  b=F+IVbaABi+pZ0/GD5NhCkNinCQ5Q8QpUP82pxiY+Q5/9pG91ipCyktWr
   s+2pLTVGMuXJBqX2h+Ycs2Oe9lOX4Cbi1Ck+uQRfcCq0KbrH4IYBX4lxw
   Fm3q4Tn4dY5aSQ/zru/k0+r5ggHKwfhGDZkSFZltIbYvGJ3srX2QF6lHu
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="182024035"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 19:56:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:15347]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id 03c2bee9-b5f1-4f3f-a53a-ffce81e92184; Fri, 14 Mar 2025 19:56:41 +0000 (UTC)
X-Farcaster-Flow-ID: 03c2bee9-b5f1-4f3f-a53a-ffce81e92184
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:56:40 +0000
Received: from b0be8375a521.amazon.com (10.118.255.19) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:56:35 +0000
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
Subject: [PATCH bpf-next v1] bpf: Fix out-of-bounds read in check_atomic_load/store()
Date: Sat, 15 Mar 2025 04:54:24 +0900
Message-ID: <20250314195619.23772-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

syzbot reported the following splat [0].

In check_atomic_load/store(), register validity is not checked before
atomic_ptr_type_ok(). This causes the out-of-bounds read in is_ctx_reg()
called from atomic_ptr_type_ok() when the register number is MAX_BPF_REG
or greater.

Add check_reg_arg() before atomic_ptr_type_ok(), and return early when
the register is invalid.

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
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 kernel/bpf/verifier.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3303a3605ee8..6481604ab612 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7788,6 +7788,12 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 static int check_atomic_load(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
 		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
 			insn->src_reg,
@@ -7801,6 +7807,12 @@ static int check_atomic_load(struct bpf_verifier_env *env,
 static int check_atomic_store(struct bpf_verifier_env *env,
 			      struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
-- 
2.48.1


