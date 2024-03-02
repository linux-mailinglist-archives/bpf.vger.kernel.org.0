Return-Path: <bpf+bounces-23227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0386EDD3
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D452875E8
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2141C8FF;
	Sat,  2 Mar 2024 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVwt47pp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A1B661
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342394; cv=none; b=ceUPvt+ybUOR9kVC622eC+XdzX7Uo4jxP3kDmmyhOIrI+HJDXM23xZcrF4pKckpq53uJelSqFOxi3P0jpBjQ2dSMedT7s28sIDdiM7XvWL+X50NKTvtz0m+a2xv/RruwE7BDXCSY9FXvUNomIMDEEftiI97mOSusr11v4+YChgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342394; c=relaxed/simple;
	bh=vY2eM0UqjsJ93XnGPnegnfX6oPS8A/CrHw+0bW+dkTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZ5/uW+YuhTpy2VL7XvQAOTUayXWowPHm9HwR3/+gbErBmKByKnBcJwNHzzfOy8zhax+S4VOnij7ol4IJIl4ahamnPSKu4u8MyZgvYbU6bnedA2XMVrWSJ/OCUPL1oSEbgMiluY1gUGHWTcnky6PmJJW9qgU8Ys2mSMzSdN4pLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVwt47pp; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so34416561fa.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342391; x=1709947191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYMlnF4l/D4ErZPFlA4ND9mYkMopZNVa5Qwk1lR+k2Q=;
        b=XVwt47ppbC9fvnq4hYhdi4P89Uuz3+EIILBZSO5leH4JETPu2AEWq1qRS9Zo9emKhZ
         d65//AduTBlRewY7K/p58ZjCzCKo/QaAaytvFUiOHFpo8Y1a6JxUE8Fc7+u8SWVUpSoi
         Paig3VTKVf69JA2zjdsBsQiyCMPrP8NNTPUaCv7p8xEks5X6np7jHohCem0XCEk2XV6y
         UVdm9AaeyzfwkomePOj5rMqNroQ8bFbyFmL9L0IiSnaH757vN7omblkDqLJflx+ysWM4
         ae2AV1CJt+MbKhzmI70ZH7l8LNZX5Qos1H/HrAdnNiqGquY7XOK8mgMS2D89ST4/Jlo7
         XjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342391; x=1709947191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYMlnF4l/D4ErZPFlA4ND9mYkMopZNVa5Qwk1lR+k2Q=;
        b=XOAn6Sd41yIcgxGxz864qmNdfbL/be7fcDBkJyG4cpz+EM8U5Nv+79VrvYpa4uzQDa
         lFGPXIfRmCwY+nHqlMYdDpNwQ7ouQK/NedlW0kz2sLwrPAg22SUf7G2BXFoVJMtEl221
         25VSqnII7vbL3aO4s9glMsfzb0br2oxl+IHsqw/laQhZ9RJWtfe9D6T4yWlM1IsWIZIf
         ou1nHamVnT7+UGFIIJv+o+Pi2/DKQizIqyaEviqcMJebUUYUP4fMYzDhuAdxV+MTc2Yl
         fWHEk3vgk7nABgdM4DCBg69Y0bmgmeBbQ3qePWsAzW893TLIO5PnWztV/hsqCneWDTLh
         jtjQ==
X-Gm-Message-State: AOJu0Yy5oo8qD7iDx5OR5yciewfSZ0YyRnEOdwhqbMUwTHNWd2OZ58aB
	9HSxewgyWF6wozivFmrpHaYQMSoiexAFcWtQGph+5qFVF/YQ9h5TBa9G3uql
X-Google-Smtp-Source: AGHT+IGv/gQ4OXq8lzolWzBLgjT9MkQ//36lqK2zLFd5o9eJ8tXew7BxufYt11xBtsNOdpxeYtTo1g==
X-Received: by 2002:a2e:9858:0:b0:2d2:c53f:ab18 with SMTP id e24-20020a2e9858000000b002d2c53fab18mr2365095ljj.11.1709342390919;
        Fri, 01 Mar 2024 17:19:50 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:50 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 14/15] bpf: allow '?' at the beginning of DATASEC names
Date: Sat,  2 Mar 2024 03:19:19 +0200
Message-ID: <20240302011920.15302-15-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kernel does not allow question marks in BTF names.
This commit makes an exception, allowing first character of the
DATASEC name to be a question mark.

The intent is to allow libbpf to use SEC("?.struct_ops") to identify
struct_ops maps that are optional, e.g. like in the following BPF code:

    SEC("?.struct_ops")
    struct test_ops optional_map = { ... };

Which yields the following BTF:

    ...
    [13] DATASEC '?.struct_ops' size=0 vlen=...
    ...

To load such BTF libbpf rewrites DATASEC name before load.
After this patch the rewrite won't be necessary.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6ff0bd1a91d5..a25fb6bce808 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -761,12 +761,13 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 	return offset < btf->hdr.str_len;
 }
 
-static bool __btf_name_char_ok(char c, bool first)
+static bool __btf_name_char_ok(char c, bool first, bool allow_qmark)
 {
 	if ((first ? !isalpha(c) :
 		     !isalnum(c)) &&
 	    c != '_' &&
-	    c != '.')
+	    c != '.' &&
+	    (allow_qmark && first ? c != '?' : true))
 		return false;
 	return true;
 }
@@ -783,20 +784,20 @@ static const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-static bool __btf_name_valid(const struct btf *btf, u32 offset)
+static bool __btf_name_valid(const struct btf *btf, u32 offset, bool allow_qmark)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
-	if (!__btf_name_char_ok(*src, true))
+	if (!__btf_name_char_ok(*src, true, allow_qmark))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false))
+		if (!__btf_name_char_ok(*src, false, false))
 			return false;
 		src++;
 	}
@@ -806,12 +807,12 @@ static bool __btf_name_valid(const struct btf *btf, u32 offset)
 
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset);
+	return __btf_name_valid(btf, offset, false);
 }
 
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset);
+	return __btf_name_valid(btf, offset, true);
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
@@ -4481,7 +4482,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !__btf_name_valid(env->btf, t->name_off)) {
+	    !btf_name_valid_identifier(env->btf, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
-- 
2.43.0


