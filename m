Return-Path: <bpf+bounces-70119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A225FBB154C
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F7D3BC2BD
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6B2D29AC;
	Wed,  1 Oct 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT/6maqH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17925208961
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338816; cv=none; b=FuOK1n0zAKaNH9WfHpb5ZJ89hCMOLsZd5Ujz18TA7u8Qcff31kfc3GCVpNa9FgkCGagxV/0N3jn68W7c9WvFyNt3DggWKTFMaqeEaS16pa3dDER5qRTiTYFYNv18TFKARSsvs2q4TnHENk8akMkZz3Rbf9NYGkZHoyVWEzLGx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338816; c=relaxed/simple;
	bh=T9L5AUT324IzFxfdT5uEZ6UrhxXR8yqMUK7yvO79PJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUrhSabICIyBCyfgO2qTxOZ0LB2pRLMId0gCtd+aj2B5BVw6DQdKbBRuFGV9AdTe1Vr73T8/7CMJRk7OAz4x4hLMVR8J1btiG+r0KKlYm+3DHGbqgY4TzsXOu/Ido/QK0h8PhF7LBKcPT0EkfsqyzPp9Ar7BY+UUen0trk/M91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT/6maqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EF0C4CEF1;
	Wed,  1 Oct 2025 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759338815;
	bh=T9L5AUT324IzFxfdT5uEZ6UrhxXR8yqMUK7yvO79PJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sT/6maqHnnCfcMToZ2dj8R7OKV3WX/0NgVem4fNxzEuzvx3WhLcglrQORJL6Yakjk
	 OXRV74Bt7NNlEvGBjmBZSMAwxSxtsYUlJD3UehGsSZjyF9anJD/QJ0yxbkdIMZ9Fkf
	 TP4qulBv/ZgXUmeR2SVL+leNQrMF3nJQAQAPXXkWoTNosLk7fDPht3c0ITesrqEx+m
	 S8FFkW5xeFU/ELKzwwRmYrTqIT6pJuWkRJYCHwFp9D3TzHk6AKzX51Fmw5bROGMVVw
	 T5UgvMmWU/P+1rojQ98grECVNYZpQK9AEWRIkohTeO98vBPGLGK13sZdfxu4l8FHS9
	 QwoKlu3YiaZ9A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 2/5] libbpf: remove unused libbpf_strerror_r and STRERR_BUFSIZE
Date: Wed,  1 Oct 2025 10:13:23 -0700
Message-ID: <20251001171326.3883055-3-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001171326.3883055-1-andrii@kernel.org>
References: <20251001171326.3883055-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libbpf_strerror_r() is not exposed as public API and neither is it used
inside libbpf itself. Remove it altogether.

Same for STRERR_BUFSIZE, it's just an orphaned leftover constant which
we missed to clean up some time earlier.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c    |  2 --
 tools/lib/bpf/str_error.c | 24 ------------------------
 tools/lib/bpf/str_error.h |  4 ----
 3 files changed, 30 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f92083f51bdb..c21bc61f5ff4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -319,8 +319,6 @@ static void pr_perm_msg(int err)
 		buf);
 }
 
-#define STRERR_BUFSIZE  128
-
 /* Copied from tools/perf/util/util.h */
 #ifndef zfree
 # define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 9a541762f54c..92dbd801102f 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -12,30 +12,6 @@
 /* make sure libbpf doesn't use kernel-only integer typedefs */
 #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
 
-/*
- * Wrapper to allow for building in non-GNU systems such as Alpine Linux's musl
- * libc, while checking strerror_r() return to avoid having to check this in
- * all places calling it.
- */
-char *libbpf_strerror_r(int err, char *dst, int len)
-{
-	int ret = strerror_r(err < 0 ? -err : err, dst, len);
-	/* on glibc <2.13, ret == -1 and errno is set, if strerror_r() can't
-	 * handle the error, on glibc >=2.13 *positive* (errno-like) error
-	 * code is returned directly
-	 */
-	if (ret == -1)
-		ret = errno;
-	if (ret) {
-		if (ret == EINVAL)
-			/* strerror_r() doesn't recognize this specific error */
-			snprintf(dst, len, "unknown error (%d)", err < 0 ? err : -err);
-		else
-			snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
-	}
-	return dst;
-}
-
 const char *libbpf_errstr(int err)
 {
 	static __thread char buf[12];
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index 53e7fbffc13e..d4c82eec034d 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -2,10 +2,6 @@
 #ifndef __LIBBPF_STR_ERROR_H
 #define __LIBBPF_STR_ERROR_H
 
-#define STRERR_BUFSIZE  128
-
-char *libbpf_strerror_r(int err, char *dst, int len);
-
 /**
  * @brief **libbpf_errstr()** returns string corresponding to numeric errno
  * @param err negative numeric errno
-- 
2.47.3


