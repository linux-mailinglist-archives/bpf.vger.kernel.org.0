Return-Path: <bpf+bounces-70058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB59BAE9D9
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 23:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3863B980E
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D229D297;
	Tue, 30 Sep 2025 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="texjR5vl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C482246332
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267609; cv=none; b=Zk5Q9r5E/5IrEv2kvYNvSxSGUhdSkUSnI+PHRhox56zRK1hig4avIocS52a5+bTOucS6GEWzf5tJ1uPjtl2KiqHlb2eTlqLyLwTyTmOc/gXBIcIvLTjLI1/YaFvhciwVDWiMMCImzBmPjAMLh41bsR5Hmh2z72TCvwuYdIXRbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267609; c=relaxed/simple;
	bh=T9L5AUT324IzFxfdT5uEZ6UrhxXR8yqMUK7yvO79PJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf2hXGInwwceajTCBavDKBTRyOrm7xeplJEkQuG52c4MYUf2sQUQkf6jnS7ywhvq/zbXl4djMEhXaXS5TwawyVb8zPC9me9hoiOqWIx5Uhg3Q8W25+5fKaGfRlOcvV0VRACa5a3DGPNBFdE1s9Q71kSpA2PPzym8sLLD1wI99LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=texjR5vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D4FC4CEF0;
	Tue, 30 Sep 2025 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759267606;
	bh=T9L5AUT324IzFxfdT5uEZ6UrhxXR8yqMUK7yvO79PJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=texjR5vlrTZcidAaKqc1TTw3omWGPc3PbOGUf0XsAlAkMI2b+46HsqZWypEU1qq0o
	 +z04P62G2RJ+1/Up/RUqsDdpGr08VDLS6Sgr56qLnNLlT3wpmLbhhWg0RhAcjltHKw
	 uSwwjvDV51JMH6jXAxX380AGlUYbM+EIug829CLATjEA7NWFNi2B6tV6eZpAMvonXL
	 qnvA93MqgFfV7CBm7pZUrfKeJwNe3Eobj8kd0Gr6yEhgzAf8rJhWuIAWFqPa1thbUo
	 c3Ynzx/3OEvKF5dchIDIgxEejmkTwGAdzLkmnUVyIatJ8nrJrG8s4aJclAButmgjmK
	 zBAsXM7TdQ71Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/5] libbpf: remove unused libbpf_strerror_r and STRERR_BUFSIZE
Date: Tue, 30 Sep 2025 14:26:16 -0700
Message-ID: <20250930212619.1645410-3-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930212619.1645410-1-andrii@kernel.org>
References: <20250930212619.1645410-1-andrii@kernel.org>
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


