Return-Path: <bpf+bounces-46004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770449E1E26
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D44228312D
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8451F1312;
	Tue,  3 Dec 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="gB7U+iVF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1241F12E3
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233725; cv=none; b=D/bz0OvzywhJiy9M1pdIpr9e8cCKYNTOLijzqr0BGP4m4Zte9WRnzBk8SHR2QjGu1yHfL8xf/Jp/z7HqXD5JNlSXBeE+TUBcE9SgrW/DkpkSHq7a2L4WptTXsjAb2eVmps1Ciy7AMQ2sDpUYW4sRO/Aa/1Gaf0gCoEvbFYQL2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233725; c=relaxed/simple;
	bh=Pm/rYukddwWR8om5fe1EIxnOcGvurQb5gP9wi6yjR+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JF6uukSK1EnOiF+lQccthmL2uejgRQV+EgFjL/NCY5oMSv/JOn+1J4T8blYiSKnZcfl+QxZxX56KfSXLRJIwz2jsaZ/ZFVIQVSAG9rZt8Vo6lKvekamAJB4E28GM8VUZxNWUHtx3+5WyLfdohzv2ZJFvd9UnZp5h+BZ16Ce17xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=gB7U+iVF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa578d10d50so888416866b.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233722; x=1733838522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUoRIDX3jNFNRZLU9ZvNZnJsXY5FDodfucjj4WxwEUU=;
        b=gB7U+iVF0tYSREw4ONyBzTnf3tmQcBsxYDeEnlVXMZNLel84v6O8ciVyi9gKALTlXN
         psKj/uMJ8Jmch2Drv2EIygNYfiVutCajOHGaLmuilULDIS8Wjs9N4KTWX6+rkgk7Mf6I
         A4w2DhUMhmlQeNzur3CDkAPkhXKcvatgW9GSIb+cRcKLuZCeN5cKE/0A2DWKgg8X5uVJ
         X1//qxTwBlggwoCWZHwkh0H9/5NaVz4ko/o8bCGylwRrk6oEQ9ALT3IdPiTfSxo+MM1K
         5jc4dhr+ECPtyEcK7ghKJysLTm5mTtUo8Ec/GmxRti7SNe6QbypDhkFHHkitoly7kStM
         bxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233722; x=1733838522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUoRIDX3jNFNRZLU9ZvNZnJsXY5FDodfucjj4WxwEUU=;
        b=jYej4jR1ugAYhoB1zoJ31arsW37Ou1u1ve5UYz8TALfukj53pZ6zMZO9lRTe8olAGR
         pyLJLxqE2jA1cKVWT63HE7AV8xVXb4YCtO7XcuMF6oqtrUNj0JbmUyTGZfOI9W2kKQHf
         KNa0/VBR9XuCIZrdHicCVgonu5oWTOEjVGcnXFsO5yXpR6Q54zPxl3H55MXKSFEWXdZ5
         N2Jd8B8H9sbklO+FXmeXrrf98VU0IDsXNcPK7f1ymKDJ8po2WuN7ztDNQYxS8f4dfUvy
         4JUuASD+215ioIZv8QYz/DA0hXG09ZGKZJn3XvwMkmjQsYgSDKnHIs/LISQnC6SLPM+b
         TevA==
X-Gm-Message-State: AOJu0Yzgq7+k93yoK04/iCj86pTX42ITUziOw1/BcElX9jG/6UrV15YK
	EUruHC1diu/dhjfEFCNLS/ZXCtETOjFzakDedPw6hS9jIpzSeumXfFv03LqATKSn1yI006XNtVh
	t
X-Gm-Gg: ASbGncvG9D6ayTNk3vggvNoyNUM1NhEoatCp33h3GmQuLsI0bwFZyny1UtOcEMSS2wl
	Jx370rlWn7UAynJ54Q2s0EN7ZohRetw3r4Gu5KkDxvIap+4UbL6ZO9zCDY0aJJTEiWz1ASyp5MU
	0zMwHa2tjhU4q2BbLOI8xlfTD1rZUvMh5A0XsLeNdp/W+1dIBzYenpVhRBvzcv3rl/4eo1JNmDE
	6gAfl6fpsf28VtWHLKBM1Ucg7/0GheFtbbn0ekDvvONF5UBlKjoJgApJp/0eJw=
X-Google-Smtp-Source: AGHT+IGyytfiGngG7CrYeW8v8+MD6FHZgUUVpTa9XlvhWOKxrhmUG3VaalMIRbB6Exwonl3nklnkvg==
X-Received: by 2002:a17:906:311b:b0:a9a:dac:2ab9 with SMTP id a640c23a62f3a-aa6018d89c6mr28745266b.42.1733233721827;
        Tue, 03 Dec 2024 05:48:41 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:41 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 4/7] libbpf: prog load: allow to use fd_array_cnt
Date: Tue,  3 Dec 2024 13:50:49 +0000
Message-Id: <20241203135052.3380721-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203135052.3380721-1-aspsk@isovalent.com>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
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


