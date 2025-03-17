Return-Path: <bpf+bounces-54152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0647EA639F0
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 02:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAFD188F157
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE7813AA2A;
	Mon, 17 Mar 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="p/LHlfu7"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01B145323;
	Mon, 17 Mar 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174206; cv=none; b=cVvnFodNUp8ezncq8VzP6yO/VtP4bsszSTYidE9F0YYitZPbbgx+ULCMBxykKV38jchKBvGWwnESRn73kwd1lkIC0jqHAqj0YVDjjrg24ufmYCa7/Nt0xCIM/ccYXphyrLPVXv3S/x9oTrYfGSJaUwF90AAwblYLINDIMRlLLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174206; c=relaxed/simple;
	bh=f8ylXnYjAovcWV1hNoHapa560iwl0vQ8IUpRdomoX/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8myT6fz1sptRPukV/V8icHywfftFvOltk7xUfl/B34bhMa4FfTLJcfnY7WtrbAsAboQIntqpwa3xq1jh0Fn5NJtz3hdc5/luoXejBjyBwtqon9GJhnck7wDOO1Brk4YJoZLeVzkvfNsNRbYNTstRCNPA9+J8gEvvql2qxzhXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=p/LHlfu7; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742174185;
	bh=hq7yTqJjEJZI2dh88leRFyAcAEXTLAjjYen6xx/Xhl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=p/LHlfu7CEPd2ysJjLxI8IRJBjCtEb76VcSkxPVav2eU2YfxA1ja77DgeJyHfzWDa
	 wGvUhJ/C2B8LuTUvqHqIIm0F8omaUnDrmoVUHoEHrBjuJgeEUV0o2ZkMJhnEAQWsRO
	 /ymBCQ4vreAT4KGmcl5ewHnCS0hlZV2+xg7tALvw=
X-QQ-mid: bizesmtp83t1742174179torkq2gh
X-QQ-Originating-IP: MPpbp5eR9xW4e2Hc/ZdiDW30mef5exgCwUz97ZJwIgY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 09:16:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6968549317870358748
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jann Horn <jannh@google.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.6 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 09:16:04 +0800
Message-ID: <84B05ADD5527685D+20250317011604.119801-2-chenlinxuan@deepin.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: M3R3hrqCvLD/hkASQ+7taVzMzGxS3tyTHkedtwjtg69HyY5S2J7P1JJo
	okDhGrImyjgPc/WYWIb9GMOI0pwyayCiUTHWyLJMrccpeGRdaX4UM4erD+yDbJCelqeBwMj
	AyCcCMZ3xMW1rwpGoOS836eQQDOiLQKEzVNgyxz3M30MXEtkE2so1c40frdPjgG4n1b4Ztc
	FlGazpQaPAyJ6okOVAYE+oegn0Ps223wRDL1eoKoP4Rdk/WnJiBz7H+snOq8K+66/0k2M1H
	cLEdVRhBy4D1ArbRi0APWu8AOhF6Y9HM6x039EWpJntYYYYQd7dy9pXVOmf4TP3cbCpor5h
	NOkRnhhsMpJLY0EgVEKPbLqkwRG3Nqy00m3k+VxGM4P2eu/Uf1ynZpuYHDQS/I8TEs6quRJ
	AZFmY3PcDBGRFnZ/wkcpCYdaNESViYIjLx9rHKcnxPZ3v5c9ZYWLKyePPuLz341jYx6agbO
	Kisj5BBvllCShN1DtrvBVNLofQZCHl2UbW91iQoguanJSMIR2CrcxCaE90/igUtW7cLcRXM
	LsU/bqE+otZqHrh97RLfKdgVtPZ34td56krCD/BNXRgSi57gJxkorwyc/uwhKAi8Y0SRo85
	+zRzWBop3pB+adLAecQLnIpEeNlkv37XlKconTngp8Wn/iRw+BLcLuaiyug/kTgzUNSW5gD
	RtJ5H7SN2Qr1vjt8kXLomZYD2VaRz1CHBBeiT30fg3eO51FW64SYN/ornlpG1P7mzJuUZT9
	hG9+Bk8jVW3XkIC0XBkjzpxNLcSAxYpQ3yFbHoxwQXL0FBG2jjEyiIL4BrcDeDjZqgBtmMI
	gaYzjIKIDJgcc2mPEJ9GY5qSqMwoLPF3p+bQts6tqPHiRP9I7I8EDNSdls7R2640RGrHPfN
	x0wZNUvJYSlTvPQNLXyCKts9xBw4NCXFkoZqQ3/VtqsRkMihTBgkhOWGynWLZ036fL/RStj
	8tVt2fA9YzQLfwKfab5o12qZI1BEEjsIlSl3L8HZEvm/1OYccke2vEAf3aygKcORAJxxe+n
	QtyoFIgVAaEHqOKDIMotcPXwJDD9JBSyZB8eC1z3dLHeGrn8NQIVt6ykv56+M=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

[ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]

>From memfd_secret(2) manpage:

  The memory areas backing the file created with memfd_secret(2) are
  visible only to the processes that have access to the file descriptor.
  The memory region is removed from the kernel page tables and only the
  page tables of the processes holding the file descriptor map the
  corresponding physical memory. (Thus, the pages in the region can't be
  accessed by the kernel itself, so that, for example, pointers to the
  region can't be passed to system calls.)

We need to handle this special case gracefully in build ID fetching
code. Return -EFAULT whenever secretmem file is passed to build_id_parse()
family of APIs. Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/

Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
Reported-by: Yi Lai <yi1.lai@intel.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.com
Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kernel.org
[ Chen Linxuan: backport same logic without folio-based changes ]
Cc: stable@vger.kernel.org
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
---
v1 -> v2: use vma_is_secretmem() instead of directly checking
          vma->vm_file->f_op == &secretmem_fops
---
 lib/buildid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..34315d09b544 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -157,6 +158,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+	/* reject secretmem */
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


