Return-Path: <bpf+bounces-32485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BAC90E15D
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 03:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D315283510
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F82CA40;
	Wed, 19 Jun 2024 01:42:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C31878;
	Wed, 19 Jun 2024 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761333; cv=none; b=SSHQj4NHHzoP4nn2OAQTcas51ZXtdWMmpvmqY0IanvDDNMts2ueEd0Cn+MsMUZNYHPrS4F2MLFRfjHKD2nP4kttc9ObVQDqw7ndBKEiyYVUvO12bS5RSzHUFniwobECxdMyKWhw0GfYO47wiOQcHXNdKJMkXXpPSFdaoW473dQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761333; c=relaxed/simple;
	bh=cQHrcDumL6vgjlnTK8i0kB5JaMupkPaj19PCYsvzV3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvsz6HbbgomolMKSOA8ex8RSf0Ok497NKDTTrL49KJYS9Qi4sBHUDTsttOYd71FwaOaJ7UXmJR/FYmJO1T8yuCZPruq/0WYX43Ed2LrmsKA0gJVHf9ThlVcApodeH2w3Xvil/qOQKQAFXg7kPSbnGp11q9iKpkMMWIydO9/4Jfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W3mVK48MZzPrdZ;
	Wed, 19 Jun 2024 09:38:33 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id E03C6140257;
	Wed, 19 Jun 2024 09:42:05 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 19 Jun
 2024 09:42:05 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<oleg@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <nathan@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <mark.rutland@arm.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH bpf-next] uprobes: Fix the xol slots reserved for uretprobe trampoline
Date: Wed, 19 Jun 2024 01:34:11 +0000
Message-ID: <20240619013411.756995-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

When the new uretprobe system call was added [1], the xol slots reserved
for the uretprobe trampoline might be insufficient on some architecture.
For example, on arm64, the trampoline is consist of three instructions
at least. So it should mark enough bits in area->bitmaps and
and area->slot_count for the reserved slots.

[1] https://lore.kernel.org/all/20240611112158.40795-4-jolsa@kernel.org/

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/events/uprobes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2816e65729ac..efd2d7f56622 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1485,7 +1485,7 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long insns_size;
+	unsigned long insns_size, slot_nr;
 	struct xol_area *area;
 	void *insns;
 
@@ -1508,10 +1508,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->vaddr = vaddr;
 	init_waitqueue_head(&area->wq);
-	/* Reserve the 1st slot for get_trampoline_vaddr() */
-	set_bit(0, area->bitmap);
-	atomic_set(&area->slot_count, 1);
 	insns = arch_uprobe_trampoline(&insns_size);
+	/* Reserve enough slots for the uretprobe trampoline */
+	for (slot_nr = 0;
+	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
+	     slot_nr++)
+		set_bit(slot_nr, area->bitmap);
+	atomic_set(&area->slot_count, slot_nr);
 	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
-- 
2.34.1


