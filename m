Return-Path: <bpf+bounces-46843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F29F0D00
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDBB188B4D2
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789471E04BE;
	Fri, 13 Dec 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Is83/DCS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6E1E04A8
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095276; cv=none; b=f4K5BoTGzT+jonA6qjLLp9KHDVn5UgSNpXX6mDDjD40R2jIB8Ss04K+UNgmTzU4pitYrg3Jd06cJDj1Al9M6/LLsZ1hqyhlJPalIPpkZ/XTfq3FrrSojEnYyD4/jsB5RuB35JSybfilWBpmUUfGazQiGUPLadSqEf8caLokOnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095276; c=relaxed/simple;
	bh=37xWweMVnPjTMIinBPE8sEnS5ivuAtlDCRGY7ekcwo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBXTCHUAN0lcoS7wZiUECO14nGIYIBeYREuzPxLx5XX418TvK/++lEEHhxLOBhlKQX63Gur7F1jCQDnt4Nfslk2AK/aWnBaQ7xcgLmtOwo+ffaSe8aAK/wmfEPegk8AOdWTH5aB0mqbyNfkjPxHYGCuKyR6Ejy8djXz3RDWvpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Is83/DCS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso2538920a12.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734095272; x=1734700072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THm3h0TBS0hs0yUtWDo06cVL5P2F91yIvoK0e5TSDkk=;
        b=Is83/DCSQUJdUsLgGyaM1W0ZUrEniMZI9DFYeRYOmUvMV6c2sS3k/KtWPXM63yoToo
         BAFPNcymd9uLD5yg5gsi+PY8nepdzO5N1lojfO3MBOjBKgAAVs3G09yAgpfYgJ0bPSqj
         arkVMln42PJWGnRDNhCI44ljx1Ai9HtWe8NvRiJCGLrUbKkozP2KJFrsNSlLPhJxt344
         IsCiKQKrr2RQof/qm0ydOKuVDRAr8WX/Dg2qK4g8Zh7I1yj4I5uoXYTIh6IExfxTRuNn
         yM8bpceopsyQQYImtgTVq/XEhmm6LCKywH83Sjoci7s86OsM4v+QXwidAs10FV5YWI3I
         FuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095272; x=1734700072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THm3h0TBS0hs0yUtWDo06cVL5P2F91yIvoK0e5TSDkk=;
        b=vLVh0SNpM2QsufH44spc2+yvJ2S6vRF8IO6gFQycJOHb6dMdxgOCOGGnFIYzBwJu3f
         gvA5kR/pUxhKAlBFh4b1jiRKftnUB6yPZcS8Lr0b51I/J/ikggqwtNrHtSwXokqoFPAF
         Qv3mgZdecfphxi+IPwUvp3y472UVHWO4CqiCgTNm8XoUa1KpP3fn+MzKtS69FCJjg71Q
         RmZn9fQCQhQDfWzIY0e9weIuJFLALM/sFLjtOaJ55U/DZBQ/LBK12ZCGNjECdvBe2y4y
         9LV/TSbmwFp2Dl32dT6EmJV0VAqWFZf1w/M8j3w/15Iy4R0QVNclxnM/0gcDlxTAh660
         bHHA==
X-Gm-Message-State: AOJu0Yy7SBeYyAZA796HnH63hLd2FnXY5a+DxxAkTpIQ16/561AeIsVJ
	FckqyN+Cs/YKcssNPqlaXDFMjYBoFc3mwKoYFgiOkr3/LATsIIE0+2bfACHGYRUxuyfrtxD/ite
	m
X-Gm-Gg: ASbGncudDaFrBZqwG1KVwpIu749/7AJy2ABlO4v+FbzwFYVoOAdlaLJdDtPz/UXrZ/4
	9UHrsB4bA7+BrHOSK+1ORzVJUDyPfP94WKYGhhdo4EqTNaerk0HgLqqL6CWNo1SqNOs/Ds6sJJp
	Com5C59O58erCuBP2UOLn5J1LH2jWyqs+Ygu6daElWpqLnCc99dlp2m2+U2eOLglN8QCDmOllK2
	P+afSS1O8cN7WbFRwy34q1/UvplFRu1kHT2ZjjvGBiy0INuHLAFecKs7MJntmV1H1Nj4g==
X-Google-Smtp-Source: AGHT+IFFTJuI+ON8fasFTTYXjoXm2zNZlWcSb1ZMGTB9yUxZ/g2QL16HbOEZtV8eCCS6EceelU5gwg==
X-Received: by 2002:a17:907:1c08:b0:aa5:225f:47d9 with SMTP id a640c23a62f3a-aab779ceb5cmr281882366b.29.1734095272358;
        Fri, 13 Dec 2024 05:07:52 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm931248666b.128.2024.12.13.05.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:51 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 bpf-next 5/7] libbpf: prog load: allow to use fd_array_cnt
Date: Fri, 13 Dec 2024 13:09:32 +0000
Message-Id: <20241213130934.1087929-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213130934.1087929-1-aspsk@isovalent.com>
References: <20241213130934.1087929-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new fd_array_cnt field to bpf_prog_load_opts
and pass it in bpf_attr, if set.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 3 ++-
 tools/lib/bpf/bpf.h | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index becdfa701c75..359f73ead613 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -238,7 +238,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, fd_array_cnt);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -311,6 +311,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.line_info_cnt = OPTS_GET(opts, line_info_cnt, 0);
 
 	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
+	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
 
 	if (log_level) {
 		attr.log_buf = ptr_to_u64(log_buf);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a4a7b1ad1b63..435da95d2058 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -107,9 +107,12 @@ struct bpf_prog_load_opts {
 	 */
 	__u32 log_true_size;
 	__u32 token_fd;
+
+	/* if set, provides the length of fd_array */
+	__u32 fd_array_cnt;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field token_fd
+#define bpf_prog_load_opts__last_field fd_array_cnt
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
-- 
2.34.1


