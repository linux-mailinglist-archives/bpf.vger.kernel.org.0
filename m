Return-Path: <bpf+bounces-23225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40186EDD1
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03141C21F74
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221FDB66F;
	Sat,  2 Mar 2024 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbvd7/yu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD7A95E
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342392; cv=none; b=FnclIfDMHTe8V/BR2TbzQNqfgnfoE8/LbDzXIN8SLCJ3aAFcsL51An2kCysTZ8TCG5kiNKmye7AGwz/X++8LkXLKX5j9Mm2ksxs8IsZOkdFeK9GORsFjYDIzYQ0RsBj1IeqV6gHGKEaok986OlR34WdbF5Rfa4rxfShE4XVdjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342392; c=relaxed/simple;
	bh=MocsDWsqIiR3iXSCyqpTWSv+2V/Qrzfj2a5lHRCtc0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aV9GB92LRLOhwdFQ3pEvbv0/KMvtoDqZAA2GoxFh74wQ+ad6dUiflY/6WsVkvXym1yDA8w3acG1lwjEx5OZ3U0vYBr9VfpgzvB3YiDwGL+1o6qLbEniNmI/YOrrC+RA2KSrJwz0tYy93cNQsR+b9XlUA3wHN6qR8yg00KygDBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cbvd7/yu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d269dc3575so23703451fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342388; x=1709947188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12Z2+H+2rtu/sqx0a2yGcy38skHVCPSpGAMA3Zq9sXE=;
        b=Cbvd7/yuIrXljK42cP7x6DSRCkg/lPGF7o/UsIX3TNTsXLrnG6qvqIfK6dG8wQ0P2Y
         eJYBsoFsUl77nDAT1w/BXXoVzKUMgovQxeTk6HCSuFdbKidixHYa2N1qFu+yG5le2WTM
         c7M9Wagu3Eq0Nk/nVS45cWk40oBebwlO80R+/WDPchRJxhw7isI0J63xpc7/zfp8PaI3
         9ITmhTqNXlnOQ/h79l0wZjelq1jgBLQVEH3JXTJNKeWmr8hN6ocBjKlFlJUQcU/3F058
         ht2qNLRx2CTVIFjjSuCasa2C0daDAs8nTZTFvNp6s/2HQzove71leVuGKn1QiPNSMuh6
         LiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342388; x=1709947188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12Z2+H+2rtu/sqx0a2yGcy38skHVCPSpGAMA3Zq9sXE=;
        b=gJDL4iSHg1WdVp9UPVjsJTqjeEe1aYVbxGig+vm6YiWzqeSCcsmmO8pzhWscX1HdVH
         trjsMdUiebNQ3yPvBrdDltQIpSEUfijASTiy5y/GfmXXIeJ8dHbnsKkKpbIyTyFJW5fP
         YayYZlbyzIv56IF8M+dhaAMSHyTnqeqrgma3zFoj+/chEBcvZQC9F10tTDro9/HI3ZLw
         8TMDlEUd2W7phtonG2VeeFsgB4UTAmO0KEtgo5qrvFfDuwZrl1yfZqnFCoYhqjbhF8RB
         Fxtldx96/CnoJuXbjSFmA1X5Y8/i53/gx02Fckt7KaXZmFsYaCGM4q/CC3JUakW3kuXA
         Zfvg==
X-Gm-Message-State: AOJu0YzzCsyG9krmOhhs4+2qQrp6LbsI7ZrLa3jP/J5kf6dnssuwkjxD
	2Is1Y6dlJnYxa6GHTMNHN5EPwajjP25YjdfVkMfxXhTPwPHawRpsv3daft9Z
X-Google-Smtp-Source: AGHT+IE1RaWiq03CnecwLkaCrzXZK9j1w75VHJGLjoFqcXpuAB0hVEPk2uqd2iYHINQTXveVFWPEhQ==
X-Received: by 2002:a2e:b011:0:b0:2d2:c506:4b46 with SMTP id y17-20020a2eb011000000b002d2c5064b46mr2545639ljk.19.1709342388546;
        Fri, 01 Mar 2024 17:19:48 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:48 -0800 (PST)
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
Subject: [PATCH bpf-next v2 12/15] libbpf: rewrite btf datasec names starting from '?'
Date: Sat,  2 Mar 2024 03:19:17 +0200
Message-ID: <20240302011920.15302-13-eddyz87@gmail.com>
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

Optional struct_ops maps are defined using question mark at the start
of the section name, e.g.:

    SEC("?.struct_ops")
    struct test_ops optional_map = { ... };

This commit teaches libbpf to detect if kernel allows '?' prefix
in datasec names, and if it doesn't then to rewrite such names
by removing '?' prefix and adding ".optional" suffix.
For example:

    DATASEC ?.struct_ops -> DATASEC .struct_ops.optional

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/features.c        | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 30 +++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 6b0738ad7063..4e783cc7fc4b 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -147,6 +147,25 @@ static int probe_kern_btf_datasec(int token_fd)
 					     strs, sizeof(strs), token_fd));
 }
 
+static int probe_kern_btf_qmark_datasec(int token_fd)
+{
+	static const char strs[] = "\0x\0?.data";
+	/* static int a; */
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs), token_fd));
+}
+
 static int probe_kern_btf_float(int token_fd)
 {
 	static const char strs[] = "\0float";
@@ -534,6 +553,9 @@ static struct kern_feature_desc {
 	[FEAT_ARG_CTX_TAG] = {
 		"kernel-side __arg_ctx tag", probe_kern_arg_ctx_tag,
 	},
+	[FEAT_BTF_QMARK_DATASEC] = {
+		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 157d28aea186..af0bfb987928 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2828,6 +2828,11 @@ static bool section_have_execinstr(struct bpf_object *obj, int idx)
 	return sh->sh_flags & SHF_EXECINSTR;
 }
 
+static bool starts_with_qmark(const char *s)
+{
+	return s && s[0] == '?';
+}
+
 static bool btf_needs_sanitization(struct bpf_object *obj)
 {
 	bool has_func_global = kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
@@ -2837,9 +2842,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
+	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag || !has_enum64;
+	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
 }
 
 static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
@@ -2851,6 +2857,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
+	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 	int enum64_placeholder_id = 0;
 	struct btf_type *t;
 	int i, j, vlen;
@@ -2876,6 +2883,8 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 			char *name;
 
 			name = (char *)btf__name_by_offset(btf, t->name_off);
+			if (*name == '?')
+				*name++ = '_';
 			while (*name) {
 				if (*name == '.')
 					*name = '_';
@@ -2892,6 +2901,25 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 				vt = (void *)btf__type_by_id(btf, v->type);
 				m->name_off = vt->name_off;
 			}
+		} else if (!has_qmark_datasec && btf_is_datasec(t) &&
+			   starts_with_qmark(btf__name_by_offset(btf, t->name_off))) {
+			/* remove '?' prefix and add '.optional' suffix for
+			 * DATASEC names staring from '?':
+			 *
+			 *   DATASEC ?.foo -> DATASEC .foo.optional
+			 */
+			const char *name;
+			char buf[256];
+			int str;
+
+			name = btf__name_by_offset(btf, t->name_off);
+			snprintf(buf, sizeof(buf), "%s.optional", &name[1] /* skip '?' */);
+			str = btf__add_str(btf, buf);
+			if (str < 0)
+				return str;
+
+			t = (struct btf_type *)btf__type_by_id(btf, i);
+			t->name_off = str;
 		} else if (!has_func && btf_is_func_proto(t)) {
 			/* replace FUNC_PROTO with ENUM */
 			vlen = btf_vlen(t);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ad936ac5e639..864b36177424 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -374,6 +374,8 @@ enum kern_feature_id {
 	FEAT_UPROBE_MULTI_LINK,
 	/* Kernel supports arg:ctx tag (__arg_ctx) for global subprogs natively */
 	FEAT_ARG_CTX_TAG,
+	/* Kernel supports '?' at the front of datasec names */
+	FEAT_BTF_QMARK_DATASEC,
 	__FEAT_CNT,
 };
 
-- 
2.43.0


