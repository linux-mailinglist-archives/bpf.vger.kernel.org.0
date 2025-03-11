Return-Path: <bpf+bounces-53800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD431A5BD3D
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 11:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18333AFBC8
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB2122D4FD;
	Tue, 11 Mar 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="la58mwm1"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A922B8D9;
	Tue, 11 Mar 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687673; cv=none; b=lnmrqAd8Ep5mW+CbzSNuau6jNZ5LfPbIWi5scmITH4CZ3TV5TsXqJwAULIOI7KGFjTJGyH3FdQqFyckeWTVupuITnQnAOhgAAZnL4BnlIgebohSL0ZcH74C/xDDVXu+Hv6oPfVjP/F4nPTVN+yUmWd1G9M+QHqsx4pIJdCiuB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687673; c=relaxed/simple;
	bh=/YEgTke/EWVA4zV2VvPzaZU3/mXdRxciFkmCnDilfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwAkvrT2Wv8GrBEUI/7fBhXBbKANRN+r87O59Whxa4ymFJ2Ve8z3mkFPqNzyfILBAllomFN3/A+QcSb5u79zxaUHXLsi7k9ndRN+Euc/5tAVmISGf55avdHTCxkVgFTcTOcEhhPyieg77GDrCsUwWfV/A5FGyJQBoki1Eu2KF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=la58mwm1; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741687619;
	bh=zMkGsEOhRrQJoE7b/qjicmm9MOJ2PvmNyE4ve+8Rljo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=la58mwm1rzqJdmIdJ6wglAy/6kC3IymMCwXqX+aTbcpW1bdXq5XRo+z3qePjN682A
	 znvAVqQrsljn5vQ5MGon0T94RQmc4Hjm6xcUcLbhi0gU2Amx8YTbAlr22s2AWFG38U
	 VZM+wZ0EvIIknv5s5b5rOa+n9ku4MM3QVd7Ra8u4=
X-QQ-mid: bizesmtpsz6t1741687609t6fhxcq
X-QQ-Originating-IP: gZ5N7ZadqohAjtcrwNj1tBMumWLqxssqEM+Ec67h4RI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 18:06:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6920947092459425178
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: stable@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 5.15] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Tue, 11 Mar 2025 18:06:38 +0800
Message-ID: <31488F4A9095C9D0+20250311100639.311087-1-chenlinxuan@deepin.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: M94I2jolx1v3EsK0u5BrFY8RGHNQarjX3cayv7769wJEcGzHC40sETRp
	abdEyrGE2Hsxu2pvbWunAmNPDM4D6DUlUTg0s/erwMXnp9/iPLWs3QysVpks1pmunZEhGRd
	BGP4a4KnjXaCrdLp20r9HlUyLhnSGY+zr0fj7b7To3bVYSej57kHYbZ5pGjlwJp07xB3WuQ
	z4NBAhfqhIv+Qf9h3jNSHdcnIymOa8k6MKKChGuUrxxoU6j6GeiVWjnoqfHggmnG//mcgL7
	Xe7YjcSQs1OTp4/SoAkITid7AHfHG4FefAHtG+kLL6pZdbF6dT6GxcF+YlWtucQcY5LR98U
	/+qsw4jeTJg5xm7rx3S8xbp87ii0QBDxDF6K15/RUM0MLIp0lLW9pPy5E+kcgKWCm5eHykQ
	J+fQV+0qst7u0ZzTM/+I4fHbkID2ORr39YUnipOAOlTq7hrIthxnra5lgSt1z5ADyDrgLbS
	+yhP3ZoqAdwjoTlKnRYpR2vwp8+K0B8sJgiAIcHaUnlnW10+ezEEa0Fc1k0F1eajPDY7/zQ
	mgYIkNjUwe5RwAAhNuFf9YdVuIZv5ELF1jyAPPhiLAvtJ6TIrXOJ01leH3vKBS0kBfNtyro
	Kyz+Q2Jxqh13+Lykos0374YTynU4c+l7TOvx9AZfPhktNAxC4plfIezNXqrpAyYDC0Rlckz
	WVxx9xfrZMZc8g6NYMxFsjU+bsMQpYiLy3/8FCq5/4PmfqtNJfomBX3hMZqUPJknfk8ehTV
	53brjJ0+h1+LqcZ3ausGaqG84u6/XGuI090kzADKT9dsbTYFPnaodXJeO+qB7PXnESx5Q8t
	mCqZsm+js6PbsAwwR0N65hlRX+08tgI8eNxjl9x9hVVE3QmqBtwOlf58AboqCYe9B39jGYf
	op8Q8xMH+QY73cKhgB1mbWWve9B0+mhEz8c5CfyGXlbr+zjcN+HhN+P+01Zwws51RvuiGp6
	54r0FlvYgzU+aYQ8q2lFop5kkDaEwm9Uv/cXU8rh1BvGsgPYv17N2+1s+Kpo//Ge/fvJNu5
	bs3NltNun3C7CivsapxEFdfRDoyd8=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
Handle memfd_secret() files in build_id_parse()") to address an issue
where accessing secret memfd contents through build_id_parse() would
trigger faults.

Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/

This repro will cause BUG: unable to handle kernel paging request in
build_id_parse in 5.15/6.1/6.6.

Some other discussions can be found in [1].

  [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel.org/T/#u

Cc: stable@vger.kernel.org
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
---
 lib/buildid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..9db35305f257 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -157,6 +158,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+#ifdef CONFIG_SECRETMEM
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
+		return -EFAULT;
+#endif
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


