Return-Path: <bpf+bounces-52137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB2A3EA61
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A117F49B
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92F1CD1E1;
	Fri, 21 Feb 2025 01:51:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057D70807;
	Fri, 21 Feb 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102683; cv=none; b=u7nv40hOrijAn6ka8Dp0BT3aaG9LJVGoHaXcgsNUy+9F3DWIpZpUnAB2cfUxHNdlPPmRb9H5dveoQUnUkGoQ/lxVbYloeyNzNYKyVaDi05ZeT4ea1tcEEoxGgAiRm5hgYPYWoFl0K7t8hFBHlTvwiyvas4Puqg+4pnazyNXjCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102683; c=relaxed/simple;
	bh=pofo1p1sPAJ5BwZKidB+v48Bp+eCZ+Zmh0S5C0spgVY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fzxRtjhpYauJazi5NAWglM6fO0lMZNQMesdCh3Va2p7FvHH+Vkk12NfzKa7uMTbgkn/U8KA244TQdI4S2PUsowGuGOWRDYseuWtPdqkX8nNfaMQyDmPP8jNmwDi5HShNdXbzbO2rIkIsygkmQvtbJBU+4Y5qlXwmAorsl/+WCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YzY0R1gvXz1wn7R;
	Fri, 21 Feb 2025 09:47:19 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id A8D8B18001B;
	Fri, 21 Feb 2025 09:51:16 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 09:51:15 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: David Hildenbrand <david@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Peter Xu
	<peterx@redhat.com>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Masami
 Hiramatsu <mhiramat@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Tong Tiangen <tongtiangen@huawei.com>,
	<wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next v2] uprobes: fix two zero old_folio bugs in __replace_page()
Date: Fri, 21 Feb 2025 09:50:56 +0800
Message-ID: <20250221015056.1269344-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)

We triggered the following error logs in syzkaller test:

  BUG: Bad page state in process syz.7.38  pfn:1eff3
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eff3
  flags: 0x3fffff00004004(referenced|reserved|node=0|zone=1|lastcpupid=0x1fffff)
  raw: 003fffff00004004 ffffe6c6c07bfcc8 ffffe6c6c07bfcc8 0000000000000000
  raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x32/0x50
   bad_page+0x69/0xf0
   free_unref_page_prepare+0x401/0x500
   free_unref_page+0x6d/0x1b0
   uprobe_write_opcode+0x460/0x8e0
   install_breakpoint.part.0+0x51/0x80
   register_for_each_vma+0x1d9/0x2b0
   __uprobe_register+0x245/0x300
   bpf_uprobe_multi_link_attach+0x29b/0x4f0
   link_create+0x1e2/0x280
   __sys_bpf+0x75f/0xac0
   __x64_sys_bpf+0x1a/0x30
   do_syscall_64+0x56/0x100
   entry_SYSCALL_64_after_hwframe+0x78/0xe2

   BUG: Bad rss-counter state mm:00000000452453e0 type:MM_FILEPAGES val:-1

The following syzkaller test case can be used to reproduce:

  r2 = creat(&(0x7f0000000000)='./file0\x00', 0x8)
  write$nbd(r2, &(0x7f0000000580)=ANY=[], 0x10)
  r4 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x42, 0x0)
  mmap$IORING_OFF_SQ_RING(&(0x7f0000ffd000/0x3000)=nil, 0x3000, 0x0, 0x12, r4, 0x0)
  r5 = userfaultfd(0x80801)
  ioctl$UFFDIO_API(r5, 0xc018aa3f, &(0x7f0000000040)={0xaa, 0x20})
  r6 = userfaultfd(0x80801)
  ioctl$UFFDIO_API(r6, 0xc018aa3f, &(0x7f0000000140))
  ioctl$UFFDIO_REGISTER(r6, 0xc020aa00, &(0x7f0000000100)={{&(0x7f0000ffc000/0x4000)=nil, 0x4000}, 0x2})
  ioctl$UFFDIO_ZEROPAGE(r5, 0xc020aa04, &(0x7f0000000000)={{&(0x7f0000ffd000/0x1000)=nil, 0x1000}})
  r7 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3, &(0x7f0000000200)=ANY=[@ANYBLOB="1800000000120000000000000000000095"], &(0x7f0000000000)='GPL\x00', 0x7, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, @fallback=0x30, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, @void, @value}, 0x94)
  bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000040)={r7, 0x0, 0x30, 0x1e, @val=@uprobe_multi={&(0x7f0000000080)='./file0\x00', &(0x7f0000000100)=[0x2], 0x0, 0x0, 0x1}}, 0x40)

The cause is that zero pfn is set to the pte without increasing the rss
count in mfill_atomic_pte_zeropage() and the refcount of zero folio does
not increase accordingly. Then, the operation on the same pfn is performed
in uprobe_write_opcode()->__replace_page() to unconditional decrease the
rss count and old_folio's refcount.

Therefore, two bugs are introduced:
1. The rss count is incorrect, when process exit, the check_mm() report
   error "Bad rss-count".
2. The reserved folio (zero folio) is freed when folio->refcount is zero,
   then free_pages_prepare->free_page_is_bad() report error
   "Bad page state".

Considering that uprobe hit the zero folio is a very rare scene, just
reject zero old folio immediately after get_user_page_vma_remote().

Fixes: 7396fa818d62 ("uprobes/core: Make background page replacement logic account for rss_stat counters")
Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
v2: Modified according to the comments of David and Oleg. 
---
 kernel/events/uprobes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 46ddf3a2334d..daa46868faf3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -506,6 +506,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
+	if (is_zero_page(old_page)) {
+		ret = -EINVAL;
+		goto put_old;
+	}
+
 	if (WARN(!is_register && PageCompound(old_page),
 		 "uprobe unregister should never work on compound page\n")) {
 		ret = -EINVAL;
-- 
2.25.1


