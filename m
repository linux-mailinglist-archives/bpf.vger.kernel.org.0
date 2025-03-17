Return-Path: <bpf+bounces-54150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA2A639E2
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 02:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71637188E877
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750731465AE;
	Mon, 17 Mar 2025 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="Ab7GDiXT"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3C84D34;
	Mon, 17 Mar 2025 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174166; cv=none; b=CHh+mEM/ao1rTTwsjTqWWutypr9+y+gm3AZBtESAlW/C1mQtBulVGSTXn9hBJCVbIIGigEyLn25KDL9Ew3hB4wMyIkRbqe/WFVoMO1D8hyBocWE/NN83wP3NC3JZAJJb1k4brsDM48GKgO1zqap+J9VI5iP4Gtact5w/GQMfROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174166; c=relaxed/simple;
	bh=f8ylXnYjAovcWV1hNoHapa560iwl0vQ8IUpRdomoX/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3J20qEhjzVGecG1hRCCgt91kJJGFlwvp7nbV+yHKGjtXnFhdCfnmUrOeDTtXXB6bu+8NDD9IJdFHMDXVrCw1310cm7XxvSrS2YfgFkzwl/uvvWmFC/TAwtynotOnCN37y7JtrhK6Q7AJrllzBCXuP8xZ+16dWfbKJh+WwV1S0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=Ab7GDiXT; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742174127;
	bh=hq7yTqJjEJZI2dh88leRFyAcAEXTLAjjYen6xx/Xhl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Ab7GDiXT1mD9p2zh1wG2yySVGSDYjIyaBZ5H7iBxG4GGJmScXO5JWvwNLU8M89sPK
	 STZCzhjiXA0PKN8ymbkz9PEXgpxib4YbPik2F+1FR7nwSXbk0vulEOOVsTTcGVujfB
	 q6USYSjIOxCb/8nYMk2s3gsKwZCHofXiz0vqAKlw=
X-QQ-mid: bizesmtp90t1742174118tyldrwni
X-QQ-Originating-IP: tL/PX2nb+gKddWUQBMRfqZdfZaw04/DM23EMBI9yowI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 09:15:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17978949113820821780
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 5.15 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 09:13:40 +0800
Message-ID: <C20998946B822F0F+20250317011339.119224-3-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: OHTF91J1Rz8hHy5JQijd6SoVpHeuOYSZow0R5p8dM10iTln+yPA/Hjv7
	J8zMoBx/5phAmHPvG1WzBNPSLWIu0/PQmgETadlZHLYCWUsCyBm8BgqA7h1xsBag3/fgP6X
	rBdeROc3WMgw+ckRr319LMvViSynYoCVSXK9S8/qW7cp0DB5lKjmoQWUnO5QuMA+wuvFpnn
	3JvLKyr63Ly0iSK+cJqnnJxKUcNnsi+VPT8NBjWkgr1nUq0nJdQKWrL3QhuymxZ9BiW4Yhl
	qE4aoH9m9UyZtodkZGlfma9Dq2f/ZSildpxz5MYGTHDi9V4iYTNyauvBOLMj8rHTKXnGEy/
	p7CdRIUALhB6Ua6HAc2FCmSDSU4qmoPcZthm7vItMqAiX2liiafU2OlJjCXXsNbiVqTu/EK
	eR/p3JV8hPxr4kaYYaJKyUESIdkl/y8QDolSrgemonM/ZzUErNd/FaHYDCq6jHPHCGUoLkl
	jaE7lz0Zn8EYDBlRz3OxZcEtZ7l2JiACNh6uCBuK8onrb/EgCYptdY/utjZYG+H+m+lvEap
	CmlDoK/ktu5U8+wluw90sNIaMFkce/m9U1iQbB1+QqChS3ipsBoVP38V23W/yq7w8TNYklz
	TPy8ISmDUIDeh2wnPhvDAe638z4NUdvTpncXOXMl7BLcETm3yd2UtfFWeDIO8zSUphqUXhH
	25lq8sOIQn4A4hlPRBgFRsqvw780Fp3+N+75CVLdCF28BubqaNqfzDw2LvyJq3FWtSmHEee
	mH4M+0ITzFe3LlAG0MlEXcME6OsdVvdeLWN7dVIuoDrq6etlB9XXURhL53LsbFznjY5V8x1
	MPwIGbC9+Ym3LdqH4UBS8PxOEcHs4Q+MVszc8k0jyMoz8k8NRBvfOP+NaBluTvV6SQzs5yH
	0EcaDbW/QUmecpUfQd2OWWb0r/9SHEh8yqyTHkFEYpVzGNzMFMCSSSyU7JospkiOlH+5/Jd
	FPCxH78oEqV+JgHXIN01loZU+
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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


