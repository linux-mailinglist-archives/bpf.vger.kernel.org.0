Return-Path: <bpf+bounces-54029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8794DA60CAE
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD0A1733D8
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E702157465;
	Fri, 14 Mar 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="KB+jN3TB"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499EE1DD877;
	Fri, 14 Mar 2025 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943088; cv=none; b=EQqB4OuKAsYZHsPOco1bws1mHrhZEKBNbja/8vzBPPHR0byW2ySqnmbq0+t9ukG3xqLNErCYWVf7ZI45Rf7HRtpmrbXh4uK20Sex22o2h8n2LOjT95DEDmD77qnizahBgNPn2QCcC87+AWK4Q0hQdT1MbB16HUEbffSI35OhvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943088; c=relaxed/simple;
	bh=ZErZMC+QOWToIegQ2iKmCvjBmUNPIrj83qIYnRryRRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARgRxjS59/VxU6C7m0CroNeju60lD2hcGg7De0yddsCiz577eWKcX+CHBDhAM5MxmcWCiru6cdGXA06pXpagjRqIIiGMSAhuIr7LCU1zBaGxSVAnd9CcMrN5hdW/vKJ0Zy5cJ6XFcoUpHhrB5kngMruyfO5JNpTYyEnnlWqosns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=KB+jN3TB; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741943064;
	bh=F3Mr2gHjrrQbbfObvuHIpoye6jVxjDNGFB92bMbmjnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KB+jN3TBO6D4thI9ZO5p2Lv7DnyH06j4vMAIj8m/u/SUKligkg0ak9B1y9Y0BeMum
	 in+AmhlfX4BbhethgtBFcESnPFw195Dx4pMiNhGZsE50Sb2SFeKEin/TF3KulAOeGv
	 cuhTobxlueTDXybsANqH9U/QCT6tD6NGzheAK1uQ=
X-QQ-mid: bizesmtpsz4t1741943062ty14a9x
X-QQ-Originating-IP: U5AE3YDjEh4ooRkvOj8VyCB63QVy2rZOlGNxtnFrpKM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 17:04:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13118731995164398442
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 5.15] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 17:04:00 +0800
Message-ID: <E2C3ADFDB3DFD774+20250314090400.31676-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: M2GOzXfxLYLpSibyllIY4YRrvaS50z5cnXKrV5ua65le3t0z00/7AMyj
	gS7LrYuZVhc0q9a9loiVx65wigaVyHc/U3zmQrKL4GvVVB8w0/QtnfKiP5gFdDTnvWwAuZN
	REKJTVyA3JSWsvC5e755ngzZytoVJPz13rPC0YADlwgaEzOvBH8ZwyJt3OMvLL+N/JYz4qt
	AtMWb6UyVwm3OTNopzRdBZWp/zsw/7zvug5xYt02g6RxRTvnTgbmp2z2Kror/PkuuzCMNrL
	ajak2MuvwQ+sV9dI+1JlZLcRZI6H3w4m0YBuXdNtvhMxzPCHu9WLXsdyIH1RBN/ZXBBLC1P
	PNAfLZQkcwT4Ap0LILzIXVqjx3WbMkVgyChQXCMfZNLM1zP3fwfNtDdc2Xg13ip00Ez7zUO
	QUXWrY8+azUOvefs1hu9hqhaEmV5LGCkzAsOaXyvL0OaLKjAB8rBSFkTIc56VHkoB1pHu2g
	Cc40g5Kyvh2vsCRsNNuqcrtjGiAZtxdsUb7ilsSta4mUFnb/MTZ9Syle5E9WilU884Gcu0L
	eexlKb6W+0bl+DbBy67aPpCycL14XXZrvFyB10wbu8EVNStMk3eTl+qJFrqco11mCB113Gs
	re3CzQ6jpr3qy6NSFsVcuDadtDpTBpcbDiGJx6GMJE0mxZcMBhVda8iQLLHknVpA9NOU/ku
	7MZ7Q6TDSO3PDL3Zycf5hAuYGw34wM1XWeXjWIi/ZWKruWQhc6A4RqKmMjNGdFIS/tmCBS8
	RPoibIGN/SBt99wQ0D+INlIz6++zXmI1zQaHAMhhTJ2qZ6beR3NazbA9KJsUWuGUt92FmrO
	Q+Q+LEbOVtVzo/68miaadlrjylbfHYSon/bbdk81DiK0/O6TbVv/q3bAadXGaNVQcgGt5om
	nMaidfvlWdCA1UKgUpERTO/cLNHC1/Bw3E82iSbJL1L2n1adFWGxSM2YIZu1CqEGRKGEUx8
	i5Fbhu/pJdWdf0Sv9Mvl8jkm705qtLVWR/gOIk7bSzbJZpWjKIEfFrU8R7iqaACML6NoEP7
	FYpOAzGZq3EnpTLKF+aWz51TnyxzKVVwk7a9ApARa1TLli/mK/zMmiVl5Q4GaZVdqXVcF+L
	biZo8tN6x6aJmTLhMI/j3c=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
[ Linxuan: perform an equivalent direct check without folio-based changes ]
Cc: stable@vger.kernel.org
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
---

Some previous discussions can be found in the following links:
https://lore.kernel.org/stable/05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org/

---
 lib/buildid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..6249bd47fb0b 100644
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
+       /* reject secretmem folios created with memfd_secret() */
+       if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
+               return -EFAULT;
+#endif
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


