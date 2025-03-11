Return-Path: <bpf+bounces-53799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D446A5BD3B
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 11:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D067A4015
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 10:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882AB22F177;
	Tue, 11 Mar 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="JFDma0Sx"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05142065;
	Tue, 11 Mar 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687663; cv=none; b=uHgUrLqOevFtwmTdEIeaVKNH3XTewe90h4yrZnHeWmis8Yjo3Gw7RNr/fjeKfiTG3MSRBSJPL1mt2qCoepn3UBNjnWi5OIxQjP5zk9nImGZSJ9PXSCH6plSODsNGIzGkH+MF4wHgiB7e34Ha+oHnmxd0nqO0PLVtdZzntQQdkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687663; c=relaxed/simple;
	bh=/YEgTke/EWVA4zV2VvPzaZU3/mXdRxciFkmCnDilfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeKEjhbm4FqQ3jAUfextl08b7e4PBUfWTauRJwoOhIVxwMZnc7sd2YGr8trP30WfM8YTG+MZCQRTi0t/ft7huAlmaOa7Pfy2fOyZ9tEmDNE/dk/eYKFx3d9SwysRFcXEbY9pqdl2v8/8W0xspTglayrJQ0RssyudgszKdDGgknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=JFDma0Sx; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741687584;
	bh=zMkGsEOhRrQJoE7b/qjicmm9MOJ2PvmNyE4ve+8Rljo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JFDma0Sx70LyAwmDN+hfUM5JXkG9mFZW6sp+7DtCrsuK2OPYR/ocb/BgUT4dAKHWU
	 Q7edz2wU0FUNrGZHAyQ1J8tCTOlWUtqDS13DTwosDWczpqBG41PAxnP15u2fnK/V2S
	 69jwAKwks/AhY/yJ1jMN7z4MLpTX5lyaQjvbBFK8=
X-QQ-mid: bizesmtp78t1741687576tbd9r1h4
X-QQ-Originating-IP: I5QyNztvaL4Hpsa+XWzIzqTavcUHPCv5hPoG9fF/GAg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 18:06:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17129962958386938985
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Jann Horn <jannh@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: stable@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Tue, 11 Mar 2025 18:05:55 +0800
Message-ID: <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: NMmFuNR2VmXuIQ0E9PNn01QX4IfcZT61I0zh1I/+2VvC1C85TOQe+I3J
	gQ4j8BhLRHRCX0c7hS5CSvf98rSNvspH6x1XcyxDXa6M0I8taik+ntuOl1gpUEePZhaKBLo
	VF4Vad3mEWuHTxAUR1tjilDIn4dp4uDWgb+KnQzCm18p91uI0OSzUeqZtgUDG5dXAW2GlFM
	owp9+Oeg6ji6dLj0gXYxDG8YXUI9iWWgnzj98qngTPRSGXtgbzTBhY8wZPRtRHWpwRWINk9
	qw9yKztxr5zppxFhJuNovUp4fteyBfu5UKA2jtXw+IKTGv/CByuZhPj2AiF4Lpg2zIpqdVD
	PBg0wUJBUrjUiNeJEcJsMvnGSCFQ+hgSEhxn5H+yoqwdvpQUVu00U3MWNm2rkzOjItnYq8Y
	mMnMKZ4U1oBH/jNgkYHHaduJoZs9fsh+92kA/VEpvYO/lyWfw3BrluYksljvQGS5fBn6PLz
	GdT3pbBGlWQ2msaA3RK+z0WVF4EKJnkGD63r15uQe+WByIqndalI5OIR4elgbnWuu1hU/cR
	dEn24ARZb4PgG8VbkdleNuetV0uS54gspn7sDqY1uv78n0BqzhWVZ5h5nbSKajPs/MrjxWG
	IHjQDcDlZg2WJENmRzM0FnYuc9ZAAU03sGpg0uxHPczA/MmPzM5sYwg4TGxj5cB4EkS51xb
	2vyp3S05GBk0Q8c+AL8FoFYmRD4CG89Bj5poCrphUwrm+woCDaLB1nA65d6FYd5wsnW9ASo
	3J7Lf6j06MokizGoUSEBl1fSSI3VcksZ9TqdTW8Ytbqox7WGx82OICoMEpJjc5XmK7OM6+j
	XBbbsR+FQsyjwldMwmTTrj3OM3i8M9bYORvMvwrkOeVOeBF0aWTJprqBZSKhGXQGuQqNnDV
	UdzU/DnvKIMw/KZBp0/cGQs3AR/Y4JzcAtgNPIkvWTKzQbVxvAQBGWE5AG41VBm31exsk7+
	jeFEe8iwmVCd66Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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


