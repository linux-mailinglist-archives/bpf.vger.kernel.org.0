Return-Path: <bpf+bounces-45872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042059DE776
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D20C162320
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949B19E980;
	Fri, 29 Nov 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YXwPXR8L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8619DF99
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886758; cv=none; b=A96ZVZG6k5LUQxza++HbQmsI6SY6eZX3MeVZGoCtifK/QKD4+PoSnDCi4TMCadtT78slWIQ2o+vnF0faxzR0VC8QlX/egYtrtMKTgEIPSST6+35j5DiE3a9YLaFSRxV5w9qU3SrJRjzRtbAIrvWQMxEk5LVFWtRY0AM4t5Uy3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886758; c=relaxed/simple;
	bh=+3YHL5ETaHgemL9MKXcPtQyVjffmElI54Yw7T+argj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvQsJHxFgJpDdlpn1cMrwdVsXFN8jpihR+QhkQjYB0H/Yi0xW59tInGt60zaz2zz/WJhCGYrktFmaCCnhQNNPmBU3ksUlmDL1+S+xuo1gfMeZxlBMxmyxTwBCuZamO7/y/jefVMpW87VFxaIC6UU5XMybfcaUA3h/xLbyTJs86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=YXwPXR8L; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5325af6a0so244135966b.2
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886754; x=1733491554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggpXSD19Jf6A3piaA1js1qwFVJYAvd9BbmdJF8eAUGg=;
        b=YXwPXR8LxV/0R3XbiLP2XLKhSNXweKq5fOAVfXpxDdPgYJ1Um2Ql5yOOcqHPEl2Ldl
         DN0s/F0kFbRizFml91zskX14I4Da01PsKjrtSkZw1Q+HAJ4WohfpaPhF2PnupV/ZVAHk
         AU+pc1s1N6cQ27AnMoIpQ8Ka/9DDcgcDKyIecjH4KFDt2QOdTrinRoWAmEIkcgxUCBd3
         ntkh1Utrjd/o66QeCsra7RAwTA5Ei/T1mbTYMPqpoWbPY7SwovlLfIi987Kh35vit4jI
         7nsAbNVFvBoHI1bt6dFPwoMTcuzU4scvpzJWJca6y5JwdAvjaxXCo4ok1DWQEgwGuF+9
         t5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886754; x=1733491554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggpXSD19Jf6A3piaA1js1qwFVJYAvd9BbmdJF8eAUGg=;
        b=TbipzSeL8xIsQeK+0Hc9mMmI553r+G6JJgo4cXne6VO7eMvj2+j9hvZYvwi7LDho4U
         XQNn0OVOlfgIxYdxAm6G/QpB7SlbKj5B188kTuS2+Q/HUQmsfvZa51m1QYyUvUciHhGp
         eZb7ZZ1WiOHAsP9X5VL92H/GOIR+Rm1I+jFJ5vOU/AVMgtkn2fTepPH4ApTODcy8UVdp
         6S245WUrZYzpbbgRx5gEG9BWvLtF8ZKBA6FkyItIAtViV/o/BApIFv2fGin+tpN0MIpm
         NZxD55HLL9AodJLPidvBeWBCFIi5F+fF+46BTNa3vXUGnj/LJMW5aknh8qb0PEfPdGQs
         AhaQ==
X-Gm-Message-State: AOJu0YyzENcdiptzLcQRSTvg18qL8p85ySLJfc1vWIIKgqHhdVNjs1Vh
	wIqpo8uEfjRn+pb2OFSWNh5V6hHkmLL30uQHgEeIgsAGxT+kRGxTa0FZVsFziOolwdCX54sdhbf
	+
X-Gm-Gg: ASbGncvxuOIBEkymlHx47yTCEJEfWKoW6SnWUkeH1NHRgd8JeX8SSOG8rxseEaQUlTO
	O5jIXn5HCd2oJCA3ssz9FH7az6mNIs2Q1ZigG+divRmWDZNcWIPTtID7jSNB8HGrbcm1zOSWkre
	r1xTtVX9OJdg5ABbAxbbraFQ42BsGMvYt06iAyc6oo0jCc83AAHNBHtPM121LSEXxz4/q6ZLruV
	avKc0pYsRoILECLsidaAXYFOuQ9F0LM1GYqllZTzRgxQfcz40H/Mp7BS7KHStY=
X-Google-Smtp-Source: AGHT+IGtIvdoSrCeS5AQoFq6igE84lRLxefPXvurQJRZfZPoQArYghQf+o6//zjZR5WWzd+YOSvsBA==
X-Received: by 2002:a17:906:3145:b0:aa4:9ab1:196c with SMTP id a640c23a62f3a-aa580edf60bmr745364466b.9.1732886754275;
        Fri, 29 Nov 2024 05:25:54 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:53 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 bpf-next 1/7] bpf: add a __btf_get_by_fd helper
Date: Fri, 29 Nov 2024 13:28:07 +0000
Message-Id: <20241129132813.1452294-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129132813.1452294-1-aspsk@isovalent.com>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper to get a pointer to a struct btf from a file
descriptor. This helper doesn't increase a refcnt. Add a comment
explaining this and pointing to a corresponding function which
does take a reference.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h | 17 +++++++++++++++++
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 13 ++++---------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ace0d6227e3..fcb4ecd9d1fd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2294,6 +2294,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 
+/*
+ * The __bpf_map_get() and __btf_get_by_fd() functions parse a file
+ * descriptor and return a corresponding map or btf object.
+ * Their names are double underscored to emphasize the fact that they
+ * do not increase refcnt. To also increase refcnt use corresponding
+ * bpf_map_get() and btf_get_by_fd() functions.
+ */
+
 static inline struct bpf_map *__bpf_map_get(struct fd f)
 {
 	if (fd_empty(f))
@@ -2303,6 +2311,15 @@ static inline struct bpf_map *__bpf_map_get(struct fd f)
 	return fd_file(f)->private_data;
 }
 
+static inline struct btf *__btf_get_by_fd(struct fd f)
+{
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+	if (unlikely(fd_file(f)->f_op != &btf_fops))
+		return ERR_PTR(-EINVAL);
+	return fd_file(f)->private_data;
+}
+
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
 struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..69159e649675 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_BTF_H
 #define _LINUX_BTF_H 1
 
+#include <linux/file.h>
 #include <linux/types.h>
 #include <linux/bpfptr.h>
 #include <linux/bsearch.h>
@@ -143,6 +144,7 @@ void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
 int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..ad5310fa1d3b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7743,17 +7743,12 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 struct btf *btf_get_by_fd(int fd)
 {
-	struct btf *btf;
 	CLASS(fd, f)(fd);
+	struct btf *btf;
 
-	if (fd_empty(f))
-		return ERR_PTR(-EBADF);
-
-	if (fd_file(f)->f_op != &btf_fops)
-		return ERR_PTR(-EINVAL);
-
-	btf = fd_file(f)->private_data;
-	refcount_inc(&btf->refcnt);
+	btf = __btf_get_by_fd(f);
+	if (!IS_ERR(btf))
+		refcount_inc(&btf->refcnt);
 
 	return btf;
 }
-- 
2.34.1


