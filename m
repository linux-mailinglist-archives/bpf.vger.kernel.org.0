Return-Path: <bpf+bounces-54028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90BA60CAB
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478AC7AC32B
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39C61E1C1A;
	Fri, 14 Mar 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="pLDlxPSb"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACB1DED5F;
	Fri, 14 Mar 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943065; cv=none; b=Ft+lnwVaTzWWc9DoToawGVEeur3FzFCJY+s+TukmYee1C2gqZOb5dGMLwCLs5mYSzg9VNK7w7bL0PIboDrhO4qOXmRksLqJYJibzlsRDHCh1+XZcpi6kzo6NpWb4hp6nFxOeaHyWSawhau3w2xIthkUT2hwRHmNOlg3pabIaRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943065; c=relaxed/simple;
	bh=ZErZMC+QOWToIegQ2iKmCvjBmUNPIrj83qIYnRryRRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqZ2QJI31Ifb2J//BTllDgiC1/wrPAkjuqH7edN8W/uUhA/uwieUNSlElGwGlncfdkISkyC9SMoJO6Z6SjQRtcHw4w4dInIlDwBEfGlQg4JG1K2IeybWQqEIHnJriHXx0kcLjxdQ4B+5TzbMgZd+C76B3GxT7BGTgLrkKIEj0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=pLDlxPSb; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741943038;
	bh=F3Mr2gHjrrQbbfObvuHIpoye6jVxjDNGFB92bMbmjnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=pLDlxPSbXbVHVICbmstD7WUeIHn07qlEoGXSsPJDK+5XKeliC/Bj5DVmFW5U1PFsq
	 4SZZdqaD0BKj0kxrYCbY7oHZ1YS6fLEtcxRreT1jQ2jMMjSNrzTrY0M2hmgYu5CKKC
	 H7zLhFHPXsWI5rXAiRm6tTWCfwngfyiSPto8j6iQ=
X-QQ-mid: bizesmtpsz14t1741943032t2nm74
X-QQ-Originating-IP: cofoNjCPpcHG+6HQh6taFZ/s42ZR9Z1Rn1rASZqKK64=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 17:03:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15483051603732972353
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Jann Horn <jannh@google.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 17:03:37 +0800
Message-ID: <0D63CE7960D94BE9+20250314090337.31408-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: ODc4ukgihQJXMk3gy4yeVwMF0oGTLbBMK8ZYTMOJLpPzFxIBGnkHIOPD
	urHA3yQEIZEdv8lh2MeOUngYFP1AZvGLHq17TdK/s+/N5WhwptZ7TUwKQ6kQt1Hy53LuS2j
	+xXHGyEMfsS0kRldTcRacVt2O2ffZwbuvaatXMnTdHMhBEucLaP8PRPLk0llqbTpSePQUAx
	OPg34g8KCKJ6VuIa3A6bd7kM8/Abr7meN2+4IAYrqwb/7fDDyCU6q23B0XgEpnT/zJ7AY/2
	T5qolF+8zc3/pz1Hvq2VJHG8FBNyH1ezJE2wgL7cHCQAW/MnpvUbwqiLXtSEFymDrHsr4is
	xxIWG0cVQMaqHsM6rdSN2dzn6q3qyDHJmW5kKtbYmp8pY78DDy2Izv2LWE37Dsaqil5nezf
	RAr3ogw44I3Sb29Kn/7gIKdEoUONXPlxByif7mBiamAeTQ0J2dBswIPwFUgpOJ+b+YTLZbf
	Fq46+xvxgphuRW/fmiHbtpKduGe+BRiDSroPQQdhROUyAIL6hcXhdWXArGHbn7kVgpG9DoE
	Bk3C8BhbRc6xv+yDgKRF6tV8ryNwrEx6PaVLX00Jk4omcILVyB1/p+f3lmfC1H+AJromblW
	HKEcFa8U5KlGtC6aNUVtF/SucJT8HsOt/APh0vHIzPQNCgypm7518/CWDtfxixfDYe7W7dN
	2SFRqTzEcwToez8uKsVRgzhswppzYNNHhqRQ4mXHt7iCh76kqqoKC43/8RQ2S+Kv3O6+xUP
	NdYe054H6LR5xUF6DEfdNhnuEHz1rRKw4S7xELvhfKdCGETJYtK5msPEH0i8aisW2DkuvRq
	rbjpZDSHGauxHObbwsmW/igww8jAJeptttMZm6oYSznFdYeQnDyNI8BjHqU6YgJRv0lXm38
	DmFcISCBjOXejB3RWkcuEwSJFm7dgnuLJdA5KMIFk4GEFHe78FGSBKr4NnUtnubNjuOLFzl
	mExDFc8ckPw8sEODrD8VtFnnfqC9Nn+hDcWxW4VtnzRwAGIqa0digJyeBI35ESxIAA4N1Wi
	qOPHgN5zPRDu1TgAAsFyIViC+UzCYN5XBNRXFCqQ6j5eGrbZ7X8K8RB9rCyKw/9wgYdm78H
	fIcLPFUnHeUsn+gh5szUw4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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


