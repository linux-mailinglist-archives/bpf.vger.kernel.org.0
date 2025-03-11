Return-Path: <bpf+bounces-53801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62038A5BD41
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 11:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729341897D76
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973222FF21;
	Tue, 11 Mar 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="NbHoNCtC"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE122F395;
	Tue, 11 Mar 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687698; cv=none; b=ecD0rzTCS7y6xN6Q57fdoM5AfPEpC6N/5rDWW+vcizd/GfreE9Fz01DF7HW4aWlRGCYPNVwXq36tAcEa/HpLF/bDuUwfpg1hDSAH8NvvcWJhE+TGZ/8V+YWvMcQv0XWJ6/9ouusbqDE/uGCsXyBvHgA4edZEGxGYU7cp+QgtnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687698; c=relaxed/simple;
	bh=/YEgTke/EWVA4zV2VvPzaZU3/mXdRxciFkmCnDilfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3L+9NZvmPNRJlTK7WAs9M4Lj+QXgMvS+jFhqOF6nBC+jjnzHX5uL+IvM9zlRN8hxqzZvdJ9NL6Xy0mc/IfQgmcPxqvO0EiZNnM+O3lQkij8+xx2cEiMfQdX90HWsf84UIUdUK78jPvwGMcNyPFdMkSJLOHOYxM79kQwghB1oiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=NbHoNCtC; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741687602;
	bh=zMkGsEOhRrQJoE7b/qjicmm9MOJ2PvmNyE4ve+8Rljo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NbHoNCtCHrdBNEZw9hBOFLibdlFWFRfrfcPWqHUQ7WWGlHlv12rtHt+DWF+cHKfSv
	 upYj1I2QwkeLQ5VauT+7H0Ef0o3pFQEMiMRaojHio1R/hXo1nZE8XsgU6lPMO+8u5/
	 6X+KUByO2DmogatK5H60W/NgZBBD7XJ2Gic7uMBg=
X-QQ-mid: bizesmtpsz9t1741687593tbq18dz
X-QQ-Originating-IP: kX9y4Fcsu0iy1+sU5FRsf9m+pbG5rAfE84obBpFpOyY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 18:06:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1712328354969147816
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.1] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Tue, 11 Mar 2025 18:06:23 +0800
Message-ID: <98CE17BE6E190CAE+20250311100624.310951-1-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: MSstRF5C1p/jzCQM7slgxRxrF5U/0JKGgZFG6WYI3/BTsmGcz63LH6s0
	VzW7IQufUiK/4jSXL+5F4rSuDRL6kTEcRqtE/XPayYSnMJVnJFDVkqQg4N+pBV76LJDtVlr
	E42fyJRpSgIkUfvY740v82BATbrE78P5rPpEYRohfEAz9KzZ+WS1kUMvJ8KJrn27/G+PQrp
	IaBCb/iNoBBSCqGBFZBKVllvlbpzIIwGRPmqCWf0G08szuQRhyxiZ79eWvK9s8m7N3r/KE3
	ghg8zymSnu480nIpRuOmbw/lNNPXrHdFwmYDUdUsJ7QH6iXCMpZbu+cKlF7TKAl2mAEMqz3
	UKCZnjtoEHLOxSv1i6SJC6akhoryH9H3tdoN9DsbZPUO3r+r1H7m1TzzM+6musCVYdcH39V
	4v2xhugOEyY5zLj6wTI3wjT7kDvrEIG4LpcPEUevhUxJeyE+6eZ9p3u+xuvBABozBsmw5Cv
	/Ue/K21zN3DOv93NaqOuCOySjBKAmvp1Ou2myWx/jv25oHn4aRtE2A5WWOkLYutDZeF5A6y
	ZmFtJ0/UjCns1TKdE28u6ukO/XWCbA1q1o7EYUdrwU6xYWFFWe6Q5jxt1i0NUExpKA1Dld1
	4mn+1J/ObXuGGjOw/T1SsYXNtnXfysPznNtoaoudQd9y8wohIdr5jt5kth2RNcGOsDkwZ5E
	zvWiicOLXzg6r3nJP5+w4H6H531JEojdPLPlr+7GvPns8AEjBUmiG1bOWSC5P0p0LfM0qOM
	yOGyDHihkNUt5Qf4Hel0CdTiukawxfxr+79Miq8KkJNERHntVD6WOXGu2VZu5dmk9QWq4T0
	jBCwO3EWGXsx1w6jpu4Y3W5Yw8boAH1BQlpoJzbUcN48svIqKDD2/9eXUGy1V3PGS8BrYro
	w9XXUFbr7O1S3Zo4gDdnoyFEp3e9QUJn6RvY4xVhqfODij5+O3RzUJQybUYHfHtR+3Bxu2S
	2Km5VAo2k/5UOkH8H/TCGbQnTmbyxwX9c/JcsUufZL8SiLAkZldIKIcFErLJGLUTmSWEK72
	UtP/kVDvlCXdP0jxHCa0LGnAST0oN7zZrv6T/Dnh4SWBPVhCFR
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


