Return-Path: <bpf+bounces-54162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BDA63F86
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 06:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16FB7A6737
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E3218EA7;
	Mon, 17 Mar 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="ptecTpPf"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38DF21504D;
	Mon, 17 Mar 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742189013; cv=none; b=BffYlvOju1n1g+VeF8q8B7/g/pdphwZRUeqeMtL3skTWeAZYE8MVMa4DKUw4TppqOxfIFih5w7OuDR5NmWb7BUQgCKIDUCnekHDY6yV2y8QAAy8ob04DllvGnoUhBf9MRZ/51vbo2FlQ3J+G2CYdW5UiS84FdzFaL7FIwYEXZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742189013; c=relaxed/simple;
	bh=UW2ueA2Qb2x942vo6/I7KZcgWikDZcH9qzJDqMyqTXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzNHemcIZEFKIW8ZxwcyIUfMdCPlrOKHRCZGYetn2ViUtpF2m75uDz+HKNJjppBEsQjE+yJEtML5GKsFbarGAKTMI29n8VeDOdi8lNhUsGP1CQ9qYlYtIhiwM9JHwbSqBubI1QQz/u8Fhne/OtKYHvT/FlVU/sPChiJEL1FSZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=ptecTpPf; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742188973;
	bh=5VoWo9+kTVRGehYZZb0Zl0JIHZwjW6msh7h7oa+43/k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ptecTpPfgPVGHl46fRwTY3Va3ZcWZY4zOWJ4Msz9FuR+HYFVCJ6J1DRLBf1CmEfiH
	 mh+sxEkUMlC3YFWX1kZNQ3LauMdeBVb794jFloGXMit2KAu6Pk2Z+R3ms5D97roohV
	 +P1aPauUjAO7pS4k6DGn9rKe4zpKHAx32nEqCKv8=
X-QQ-mid: bizesmtp82t1742188971t1m7w3mm
X-QQ-Originating-IP: djKXfLBif2j97QVwxqBQla9T8D7LOXKk7aoXSc0Nenk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 13:22:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3296478406473002312
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 5.15 v3] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 13:21:32 +0800
Message-ID: <DC5F0190D52D7B57+20250317052132.23783-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: M4K5nIxZYv59mzLTsOPB8xGTLzBE0hsYcloIEf/+T9k2eVUJF0/yw1/F
	8W0tbPH/xKH1OXOnlgyIYTIx6LWQ0okHyVJ752Mig7TieUcaX5aAyueXH5V1RyQ/5AJXBqv
	z0GM47LFgNjx9+2PbfpFhb6viQSbs9eNjK7XAFevoTws1+ADOqJ3VacZdNsFSPhANvCpaSE
	EvFl8X7sWOCjCI/oQwgXCvQwpDHzteqLZ3m925d3ScnsEeemDjYSu9aMAPwugYHxhBP2iA8
	9UKpZir51pVmse8hmayHIp601tKPl3nJD81xg5537aEMlZDZUpLcl1cwzgCWvy0oBDKUUBs
	OCLabEOlU9dSeCekFhHlfcFohxswQ+VRc4ziFP42iWh+GMg1FzI4h9U3MwtHZvZqR3iw2+j
	QWGgFq2i9FZfUPmo2avdqqMLLOGp6ZxCxn2xxbaggS1tU3C/5M/lstzLpYs1m4sGAj0Kr7F
	eQBTrZFwQTslDepUF30zoQlsNCYl+5P0OxHYST8l9fM2V6T5UBUpHyC7Fuj0uuSghvfWoJO
	UFgzDygdn4MQi230Gb7sb1pnlVub9GlGeTUkf2Ykx0kGJWACt/A2AEvGit7BM21Q1YHcttC
	HWc+63mR1iZgOlt/sUqzfRDkO86Hu7oa8VGF5QVf0uX2aQ6CUqDkLXql+g9/M+lvqs1fZbU
	NY4B8EGGrLj5pMP6o7Sdr7ZVs8gyP0DZEnsenHucdVszD0vFiipenaFfhw6VzgPUHlaEADk
	mhv0J6Qmbx85+kAWARPFX2dgnK+ms63QjO9L1WHbOIqNqVdAvNumFCs5XXADYC+le3bR0Oe
	pqJN/qJ5OPOV2I8/AzyUMpx0jGTRJo/v6q955o+n6XiQwQsWPbIoA/5O0h9vvKryIazAn8I
	0on2vBu52dJwcWw9FUu8EVSpFK68IfrUeZhlPQBi5fXz5F30Tod/Z2Y7hKa/HUVtvsOHDnu
	IGXHbOJj8vGKeMmMQ5wdLkngFKogBtaT++jG62MNN7YpRN3x6wIjklokg
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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


