Return-Path: <bpf+bounces-28743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0628BD86F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CCC1C2291E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C56622;
	Tue,  7 May 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4l93vsK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899810FA
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040832; cv=none; b=QnZyEPeTinx+kcJGQId1YPmMM2ErsfGZ1KpIxfjNFzN4nlekaK9tJxcnvv5cedsocnsMoRO3qBvIOj1zNfazfDtT4zDVtNOMaGXonGztucF+bLbXEWnI2UWZG3WRMBvQ9vDK5C5t8BeMqJefwrDiiOzL3uIKg7AgEMRhVC1vICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040832; c=relaxed/simple;
	bh=/xZHCP4fsyVjIySO6TVQTq8s5ppUOvO0ovzCQoojzSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo8CiooRwYHqHzM5Wc8JxCF92t36DH/A+2xcpzKGvLAddIcq0ihuvk25P7gPoLuAJ74aFQfbCm4r/ZY1DuQAiaOG3omWrhRtogydQZrh6KHAyTUmIoi4WhDi/BndvANYTiVX1WJPHauKgI5Ob2x+zXZWGxFVsubdvMITjt03r80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4l93vsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C56C116B1;
	Tue,  7 May 2024 00:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040832;
	bh=/xZHCP4fsyVjIySO6TVQTq8s5ppUOvO0ovzCQoojzSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4l93vsKUu4GeWTplCyRDK4jISPw740rqAu3cd0bpI6UCT2mv3AsU5Fm9iPPRji6h
	 sXtpkktfqfNwgrrCgNzLiqFZcFLrKY2kFc1j+UYm2F938Yb/AUJIxFZHvkWr7uWM3Q
	 Ggf4899w5Vgin9QnHY2RqJVSm/rZxu5NGxXWGIzLktV1RaGCG8rjNujRWFvwHHtSaG
	 mzfZy/BgqySIRoEc9fqvkKPenHFWl36TOsWLfFqiRGtpt09hqx7fOhp3DTF0iPncgt
	 q6r4ZxyIKHfANOxDOA0X7MEsPGa7YNskQOo/dtsO8kyyhd3mtd3jCo2eymV3Axa832
	 GfFQFRuzvlZGQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/7] libbpf: fix libbpf_strerror_r() handling unknown errors
Date: Mon,  6 May 2024 17:13:32 -0700
Message-ID: <20240507001335.1445325-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507001335.1445325-1-andrii@kernel.org>
References: <20240507001335.1445325-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strerror_r(), used from libbpf-specific libbpf_strerror_r() wrapper is
documented to return error in two different ways, depending on glibc
version. Take that into account when handling strerror_r()'s own errors,
which happens when we pass some non-standard (internal) kernel error to
it. Before this patch we'd have "ERROR: strerror_r(524)=22", which is
quite confusing. Now for the same situation we'll see a bit less
visually scary "unknown error (-524)".

At least we won't confuse user with irrelevant EINVAL (22).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/str_error.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 146da01979c7..5e6a1e27ddf9 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -2,6 +2,7 @@
 #undef _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
+#include <errno.h>
 #include "str_error.h"
 
 /* make sure libbpf doesn't use kernel-only integer typedefs */
@@ -15,7 +16,18 @@
 char *libbpf_strerror_r(int err, char *dst, int len)
 {
 	int ret = strerror_r(err < 0 ? -err : err, dst, len);
-	if (ret)
-		snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
+	/* on glibc <2.13, ret == -1 and errno is set, if strerror_r() can't
+	 * handle the error, on glibc >=2.13 *positive* (errno-like) error
+	 * code is returned directly
+	 */
+	if (ret == -1)
+		ret = errno;
+	if (ret) {
+		if (ret == EINVAL)
+			/* strerror_r() doesn't recognize this specific error */
+			snprintf(dst, len, "unknown error (%d)", err < 0 ? err : -err);
+		else
+			snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
+	}
 	return dst;
 }
-- 
2.43.0


