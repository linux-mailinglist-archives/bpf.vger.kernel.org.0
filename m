Return-Path: <bpf+bounces-54100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22CDA62900
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 09:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ABE19C0508
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DCF1DF994;
	Sat, 15 Mar 2025 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e9F/C0g5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2B1DD87D;
	Sat, 15 Mar 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742027000; cv=none; b=lZbA73HNnjiaqOtUTE5HiCQ9Nv3W6IBuY2AVf/LL8IIXATJbf07Lw3KzLfSv9/ct8N7udUXOZWyesp8v2qJiuWFOMistiwZZ0ka3WacZsyb06q0wzpNPNl360Ys744VDRpCpCEFzxmk8/PsMi5jPLFB/JJCHH8ie71vaMIBQCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742027000; c=relaxed/simple;
	bh=z6iGQRwbXesEyOIXoStMS9ieznoBDqUOJ18mrPXRIWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFshmPy2XcttY6L9DtOgnk7vMHwnFOc8zEfxG7lnqgPOnnGE+IuF2Jk7DACaKcu3OQSZpCYoLm8EFOvCbxuUjt/hGWXb0OlWDG7GpyKuS+zmmVNY1X8oiku+fV/m3rGLAW5lonPGNF2ANSw0xHh+71vp0XHrpj89ptQVudlmkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=e9F/C0g5; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742026999; x=1773562999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Up+dmDB0E4GXyo3n4QaQusR3J35sCNIUgaYEbjOQAxo=;
  b=e9F/C0g5moFY3U2yNjzhUaXA33TjtoaD6OOpCiv9zuUI4ykZeDXN7yUC
   X9RmUWL7utanBCPTrRfnPGlYXkvYWDmkY6ok41peGAcrq1eZsuHUoJvrz
   XUBnoCr00AYLb8LaMJHRhwP5aW+hn2mJAWRG0iDU8R07j83T8mBCcCIPV
   g=;
X-IronPort-AV: E=Sophos;i="6.14,249,1736812800"; 
   d="scan'208";a="1497335"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 08:23:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:62860]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 6d8675d6-f123-4b09-9ad3-71f099c31b08; Sat, 15 Mar 2025 08:23:11 +0000 (UTC)
X-Farcaster-Flow-ID: 6d8675d6-f123-4b09-9ad3-71f099c31b08
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 08:23:06 +0000
Received: from b0be8375a521.amazon.com (10.118.246.93) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 08:23:00 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <eddyz87@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <enjuk@amazon.com>, <haoluo@google.com>,
	<iii@linux.ibm.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kohei.enju@gmail.com>, <kpsingh@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <martin.lau@linux.dev>, <sdf@fomichev.me>,
	<song@kernel.org>, <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>,
	<yepeilin@google.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1] bpf: Fix out-of-bounds read in check_atomic_load/store()
Date: Sat, 15 Mar 2025 17:21:55 +0900
Message-ID: <20250315082251.32679-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <c11f1caa46535ebb102d1ed2bba83bf257ef6939.camel@gmail.com>
References: <c11f1caa46535ebb102d1ed2bba83bf257ef6939.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

>> syzbot reported the following splat [0].
>> 
>> In check_atomic_load/store(), register validity is not checked before
>> atomic_ptr_type_ok(). This causes the out-of-bounds read in is_ctx_reg()
>> called from atomic_ptr_type_ok() when the register number is MAX_BPF_REG
>> or greater.
>> 
>> Add check_reg_arg() before atomic_ptr_type_ok(), and return early when
>> the register is invalid.
>> 
>> [0]
>>  BUG: KASAN: slab-out-of-bounds in is_ctx_reg kernel/bpf/verifier.c:6185 [inline]
>>  BUG: KASAN: slab-out-of-bounds in atomic_ptr_type_ok+0x3d7/0x550 kernel/bpf/verifier.c:6223
>>  Read of size 4 at addr ffff888141b0d690 by task syz-executor143/5842
>> 
>>  CPU: 1 UID: 0 PID: 5842 Comm: syz-executor143 Not tainted 6.14.0-rc3-syzkaller-gf28214603dc6 #0
>>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
>>  Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:94 [inline]
>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>   print_address_description mm/kasan/report.c:408 [inline]
>>   print_report+0x16e/0x5b0 mm/kasan/report.c:521
>>   kasan_report+0x143/0x180 mm/kasan/report.c:634
>>   is_ctx_reg kernel/bpf/verifier.c:6185 [inline]
>>   atomic_ptr_type_ok+0x3d7/0x550 kernel/bpf/verifier.c:6223
>>   check_atomic_store kernel/bpf/verifier.c:7804 [inline]
>>   check_atomic kernel/bpf/verifier.c:7841 [inline]
>>   do_check+0x89dd/0xedd0 kernel/bpf/verifier.c:19334
>>   do_check_common+0x1678/0x2080 kernel/bpf/verifier.c:22600
>>   do_check_main kernel/bpf/verifier.c:22691 [inline]
>>   bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
>>   bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
>>   __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
>>   __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
>>   __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
>>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>  RIP: 0033:0x7fa3ac86bab9
>>  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>>  RSP: 002b:00007ffe50fff5f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa3ac86bab9
>>  RDX: 0000000000000094 RSI: 00004000000009c0 RDI: 0000000000000005
>>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
>>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>  R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>>   </TASK>
>> 
>>  Allocated by task 5842:
>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>>   kasan_kmalloc include/linux/kasan.h:260 [inline]
>>   __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4325
>>   kmalloc_noprof include/linux/slab.h:901 [inline]
>>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>>   do_check_common+0x1ec/0x2080 kernel/bpf/verifier.c:22499
>>   do_check_main kernel/bpf/verifier.c:22691 [inline]
>>   bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
>>   bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
>>   __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
>>   __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
>>   __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
>>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> 
>>  The buggy address belongs to the object at ffff888141b0d000
>>   which belongs to the cache kmalloc-2k of size 2048
>>  The buggy address is located 312 bytes to the right of
>>   allocated 1368-byte region [ffff888141b0d000, ffff888141b0d558)
>> 
>>  The buggy address belongs to the physical page:
>>  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x141b08
>>  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>  flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
>>  page_type: f5(slab)
>>  raw: 057ff00000000040 ffff88801b042000 dead000000000100 dead000000000122
>>  raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
>>  head: 057ff00000000040 ffff88801b042000 dead000000000100 dead000000000122
>>  head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
>>  head: 057ff00000000003 ffffea000506c201 ffffffffffffffff 0000000000000000
>>  head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>>  page dumped because: kasan: bad access detected
>>  page_owner tracks the page as allocated
>>  page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 8909973200, free_ts 0
>>   set_page_owner include/linux/page_owner.h:32 [inline]
>>   post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1585
>>   prep_new_page mm/page_alloc.c:1593 [inline]
>>   get_page_from_freelist+0x3a8c/0x3c20 mm/page_alloc.c:3538
>>   __alloc_frozen_pages_noprof+0x264/0x580 mm/page_alloc.c:4805
>>   alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
>>   alloc_slab_page mm/slub.c:2423 [inline]
>>   allocate_slab+0x8f/0x3a0 mm/slub.c:2587
>>   new_slab mm/slub.c:2640 [inline]
>>   ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
>>   __slab_alloc+0x58/0xa0 mm/slub.c:3916
>>   __slab_alloc_node mm/slub.c:3991 [inline]
>>   slab_alloc_node mm/slub.c:4152 [inline]
>>   __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4320
>>   kmalloc_noprof include/linux/slab.h:901 [inline]
>>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>>   virtio_pci_probe+0x54/0x340 drivers/virtio/virtio_pci_common.c:689
>>   local_pci_probe drivers/pci/pci-driver.c:324 [inline]
>>   pci_call_probe drivers/pci/pci-driver.c:392 [inline]
>>   __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
>>   pci_device_probe+0x6c5/0xa10 drivers/pci/pci-driver.c:451
>>   really_probe+0x2b9/0xad0 drivers/base/dd.c:658
>>   __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
>>   driver_probe_device+0x50/0x430 drivers/base/dd.c:830
>>   __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
>>   bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
>>   bus_add_driver+0x346/0x670 drivers/base/bus.c:678
>>  page_owner free stack trace missing
>> 
>>  Memory state around the buggy address:
>>   ffff888141b0d580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888141b0d600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>  >ffff888141b0d680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>                           ^
>>   ffff888141b0d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888141b0d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> 
>> Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
>> Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
>> Fixes: e24bbad29a8d ("bpf: Introduce load-acquire and store-release instructions")
>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
>> ---
>
>I wonder if we have test cases for malformed instructions.
>Maybe add one since this issue was hit?

Thank you for the suggestion. 
I agree that having a test for this specific issue would be valuable. 
I'll work on it.

>
>>  kernel/bpf/verifier.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 3303a3605ee8..6481604ab612 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7788,6 +7788,12 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
>>  static int check_atomic_load(struct bpf_verifier_env *env,
>>  			     struct bpf_insn *insn)
>>  {
>> +	int err;
>> +
>> +	err = check_reg_arg(env, insn->src_reg, SRC_OP);
>> +	if (err)
>> +		return err;
>> +
>
>I agree with these changes, however, both check_load_mem() and
>check_store_reg() already do check_reg_arg() first thing.
>Maybe just swap the atomic_ptr_type_ok() and check_load_mem()?

You're absolutely right. The additional check_reg_arg() introduces some 
redundancy since check_load_mem() and check_store_reg() do that.
I've revised the patch to simply swap the order and syzbot didn't trigger 
the issue in this context.
    https://lore.kernel.org/all/20250315055941.10487-2-enjuk@amazon.com/

However, the change in order affects results of existing test cases 
because messages are changed by this swapping.[1]
In this case, we need to either modify these existing test cases or 
reconsider the logic of check_atomic_load/store().
I'm not sure which approach would be preferable in this situation.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20250315055941.10487-2-enjuk@amazon.com/
 First test_progs failure (test_progs-x86_64-llvm-18):
 #504 verifier_load_acquire
 tester_init:PASS:tester_log_buf 0 nsec
 process_subtest:PASS:obj_open_mem 0 nsec
 process_subtest:PASS:specs_alloc 0 nsec
 #504/17 verifier_load_acquire/load-acquire from pkt pointer
 run_subtest:PASS:obj_open_mem 0 nsec
 libbpf: prog 'load_acquire_from_pkt_pointer': BPF program load failed: -EACCES
 libbpf: prog 'load_acquire_from_pkt_pointer': failed to load: -EACCES
 libbpf: failed to load object 'verifier_load_acquire'
 run_subtest:PASS:unexpected_load_success 0 nsec
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
 ... (snip)
 #541/25 verifier_store_release/store-release to sock pointer
 run_subtest:PASS:obj_open_mem 0 nsec
 libbpf: prog 'store_release_to_sock_pointer': BPF program load failed: -EACCES
 libbpf: prog 'store_release_to_sock_pointer': failed to load: -EACCES
 libbpf: failed to load object 'verifier_store_release'
 run_subtest:PASS:unexpected_load_success 0 nsec
 validate_msgs:FAIL:754 expect_msg
 VERIFIER LOG:
 =============
 Global function store_release_to_sock_pointer() doesn't return scalar. Only those are supported.
 0: R1=ctx() R10=fp0
 ; asm volatile ( @ verifier_store_release.c:191
 0: (b4) w0 = 0                        ; R0_w=0
 1: (79) r2 = *(u64 *)(r1 +40)         ; R1=ctx() R2_w=sock()
 2: (d3) store_release((u8 *)(r2 +0), r0)
 R2 cannot write into sock
 processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
 =============
 EXPECTED   SUBSTR: 'BPF_ATOMIC stores into R2 sock is not allowed'

>
>>  	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
>>  		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
>>  			insn->src_reg,
>> @@ -7801,6 +7807,12 @@ static int check_atomic_load(struct bpf_verifier_env *env,
>>  static int check_atomic_store(struct bpf_verifier_env *env,
>>  			      struct bpf_insn *insn)
>>  {
>> +	int err;
>> +
>> +	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
>> +	if (err)
>> +		return err;
>> +
>>  	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
>>  		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
>>  			insn->dst_reg,

Regards,
Kohei

