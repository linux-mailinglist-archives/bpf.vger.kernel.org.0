Return-Path: <bpf+bounces-54164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB5A63F8E
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 06:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A454189047D
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 05:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C859218EA1;
	Mon, 17 Mar 2025 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="IcsyNP+q"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F68634E;
	Mon, 17 Mar 2025 05:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742189048; cv=none; b=TuHClnO6q5X3XwcXDLZowKbBOz0ccKz1Ot2vGTYGS1qB1J6rCujzbnnrLyG9xuDG3L9HkIj6XSMmawCk4dTQLxkE4LiaErgoARl8W1gLkPjMXIZZSzaXUlj0L2KPvJS9VazXxYsiqh2KhOV5gsG7IJOnyuY8b64IS+iwPF8NeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742189048; c=relaxed/simple;
	bh=UW2ueA2Qb2x942vo6/I7KZcgWikDZcH9qzJDqMyqTXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdjDPkXBAnex5PMtGL4kEAest4Zv3vX+dJ/NKgJVrFI74kKJXsa7qV51EIrQJMhi3LsnLnsIdEK8c1Kws4+QBinXlQgSCZjpy1h9ZVeZhwN9k5KNDtTv94MJRnEr+TZWPMBrqqmhbD4LUQLQNwiCDrkP72jCjKzdtntU+smmejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=IcsyNP+q; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742189026;
	bh=5VoWo9+kTVRGehYZZb0Zl0JIHZwjW6msh7h7oa+43/k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IcsyNP+qxarg1U329SGBI/wERhTLVPQZnwkEAgLKjEa7Yv0RbERHNs+hVzLXO4jAi
	 Ij8Ua8f39fYiIsvfBvp4FBkMHcMJQEa1X98vlV58Mvd5vzySrRj2IzFy6DGlDKHVpV
	 wel9ARLXGZlwBxFY/F7pqMODizCfAhJdoOVkkzYM=
X-QQ-mid: bizesmtp86t1742189024t3gm7a4x
X-QQ-Originating-IP: ZT/V87ZlcmIrbedDu6mjreraAzLCV6foXe3nc6gTxUY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 13:23:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10335816984539076361
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.6 v3] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 13:23:25 +0800
Message-ID: <485715E6BEC61FE5+20250317052325.24365-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: Md9VxqCp8QXzSUzbtfFe13PwQR/NbAlE7YSML+hwb8NiHE0hGnxEJxtt
	5xs2yS1VeCwc9kpTCmAy2ZCZYuUeeoUhhmezVQSao+3xgTR8hMsvvb+4cxq3Lc/LsHZe0YP
	GagG6xn1FtI2epcmaDLlqOD2htUeptzzoTQmaA36bglwW2RDjDZDgFMtfR0j43TyxHe4Brc
	+ST+3BXJmE+yA0J5DjrPdEY9qBg5MZVO0WFu7ORX50YnJTUpMDB16fxjhBieHUkUBZLoVic
	CPYqARs/ymEdmOECF+EEI/+boMACfuh3mcfLV5x7DpuHQnUbZ1GFSzhDH7S1GlBDU/Itd0l
	KYztyeY312My6kG1gRW0aMOFJqvm8sGuq7qvYiqcw/jcR9gl3VAhgUziefrpgovgjPgZaM6
	O1IvwOnXhRDnkSM+rQi2cuOJjt6aEwVaV54JDJq+eG8VrL4eC71KDU/qeoNYbfj2ckK+mO/
	PJ5Yh24N5uQsF1ES4EVhAUm2k3XCZ6NJcR5enthDexxJMHOwJkFAYVIoX/wxT7nvzKm+2LT
	i3Yu6HlcV2J/YrPlA3MT5V3p5OXyrRETQmbUIGivLptopFBCLDzFc6RavxfzTJDvd1+9ewd
	m9JSpe6+UxBMLqqHOt+r4saleG1uaiP9B2HW0kX2gqTfh8upwiyWcpA7mwqGBVZj5K9t/cF
	CSrtVkxpKLXM76aznZH2LkNdK2sDdcO1Cv4sU5GISClAxW6ZFesyGMvQeL6BKo7tnIAYwlB
	hhh0oL6vGfI8xHPck/OaFrYOiAV750/K70JG2La+mjFQdClF18P8W+70hme2st3F6yKSMPt
	82jDRAnEJYEP60JEfQ1bkhg0FZWNSo49xcvinyL/TVX/WbY3FHpekZG3MjiOOhSlUzucOyI
	/SsJOv1Ma8ZIX+k5cFkAnBVO4E2ZpCBssntk/XxHF/WawbBDVd2CPSxckY8BZr7WHmcwd4K
	1A/RNBPAcuRAfRBeq/2rT6G7Gnb0TcScEXPz7adG4Ip1C2mvNxiCgQicdCq3fa9VTiMasOV
	EcU47d6CBuxQEIp6h4GiYsiwtzP/8T1Pqyf9h+XwUlPz/3BFk0+82iKXt+xsxV4w6K+J56q
	i5YAqMzxma1WTUqRV4WojBRN0C7TvoY3CTZDd7qtifTOlIsc/q8YQg=
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
v2 -> v3: keep original comment
---
 lib/buildid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..8d839ff5548e 100644
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
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


