Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C71457ACE
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhKTDgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhKTDgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7459C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so12352242pjc.4
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFN7iLDWWH5fM42Le5DXiZezjfBciVePC7oj9N54hwM=;
        b=YAT7aaUfxFQG1MAKv4LgZmIXLXF+C2svLVOYwKj0sZ2EgM5o9L6a5g/U3ATAlq10zl
         qPoJBQoK4BcPVPfae1/3qvOyZ9+i/ggzq5baPT/Y9VL4MQr1b7KCp++AxAkZXKglSI3R
         FvfkRhAMN2GkaYuvsXtoVoUequWiC3TpTHRSGJUDATeVKaF94hao9whbsnmIJrQvEI/5
         07c4vHBDiz7uPYY1pf4I3++KhNYy0AAd/jgqjdhNCrXmGgodDJa+VjY7CDGnH4Qf1Avm
         z2UkT8zSXvrl+sYD4VEiVo3eozYSEi2Q7UsJphPNjMQ0R+wvak1VzbqCk2KHQeXnRTgx
         xZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFN7iLDWWH5fM42Le5DXiZezjfBciVePC7oj9N54hwM=;
        b=nk8JwoslqDrmnRBolr+9JynfozTWx2Pg7ohmmGVL/GHb+8xOCUJcIfYZiAx9YRGIhI
         LApFwv6a1dqVUXHbTKzBCR6+r5qNe7JP7b3zeIoLAzuXQe+P9Wcr/nVkg3PB7nbonXyk
         8MPeYyPXeDHEiMf2CyP74YqFxDcmqtC3dzYjWlWnvl5FdJjPXFK2orB2JUB9/5uU4d2/
         Ce9Cp0wrluhBNnlKBGkQSeeecU98ocDJKeq5KM7mhZGp4dSw6zSUKD+On/UG+/hlwBKb
         0TwlqMJwKi4tkKdlPiAer05yo32V+tYVCLqUFZCX7Bvc5BG329Yh2t91GKGZJX34/+kI
         h1bw==
X-Gm-Message-State: AOAM533gmghYDlCikwrKmD/QbKUiC+cCqhp8M2i+qz5+oySfCy8+g/gc
        T/bfv1gjE0MubNKU4F0Cqjg=
X-Google-Smtp-Source: ABdhPJyNuHwgRSpx4c0180RedL7M4Lpm4sDkUaIm9vwLcWqkSiaeRSqBV4zcAzFIIaUlDMWZ59eNwA==
X-Received: by 2002:a17:90a:e012:: with SMTP id u18mr6213910pjy.103.1637379189234;
        Fri, 19 Nov 2021 19:33:09 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id p16sm1054537pfh.97.2021.11.19.19.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:08 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 04/13] bpf: Define enum bpf_core_relo_kind as uapi.
Date:   Fri, 19 Nov 2021 19:32:46 -0800
Message-Id: <20211120033255.91214-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

enum bpf_core_relo_kind is generated by llvm and processed by libbpf.
It's a de-facto uapi.
With CO-RE in the kernel the bpf_core_relo_kind values become uapi de-jure.
Also rename them with BPF_CORE_ prefix to distinguish from conflicting names in
bpf_core_read.h. The enums bpf_field_info_kind, bpf_type_id_kind,
bpf_type_info_kind, bpf_enum_value_kind are passing different values from bpf
program into llvm.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       | 19 ++++++++
 tools/include/uapi/linux/bpf.h | 19 ++++++++
 tools/lib/bpf/libbpf.c         |  2 +-
 tools/lib/bpf/relo_core.c      | 84 +++++++++++++++++-----------------
 tools/lib/bpf/relo_core.h      | 18 +-------
 5 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a69e4b04ffeb..190e9e3c0693 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6349,4 +6349,23 @@ enum {
 	BTF_F_ZERO	=	(1ULL << 3),
 };
 
+/* bpf_core_relo_kind encodes which aspect of captured field/type/enum value
+ * has to be adjusted by relocations. It is emitted by llvm and passed to
+ * libbpf and later to the kernel.
+ */
+enum bpf_core_relo_kind {
+	BPF_CORE_FIELD_BYTE_OFFSET = 0,      /* field byte offset */
+	BPF_CORE_FIELD_BYTE_SIZE = 1,        /* field size in bytes */
+	BPF_CORE_FIELD_EXISTS = 2,           /* field existence in target kernel */
+	BPF_CORE_FIELD_SIGNED = 3,           /* field signedness (0 - unsigned, 1 - signed) */
+	BPF_CORE_FIELD_LSHIFT_U64 = 4,       /* bitfield-specific left bitshift */
+	BPF_CORE_FIELD_RSHIFT_U64 = 5,       /* bitfield-specific right bitshift */
+	BPF_CORE_TYPE_ID_LOCAL = 6,          /* type ID in local BPF object */
+	BPF_CORE_TYPE_ID_TARGET = 7,         /* type ID in target kernel */
+	BPF_CORE_TYPE_EXISTS = 8,            /* type existence in target kernel */
+	BPF_CORE_TYPE_SIZE = 9,              /* type size in bytes */
+	BPF_CORE_ENUMVAL_EXISTS = 10,        /* enum value existence in target kernel */
+	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a69e4b04ffeb..190e9e3c0693 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6349,4 +6349,23 @@ enum {
 	BTF_F_ZERO	=	(1ULL << 3),
 };
 
+/* bpf_core_relo_kind encodes which aspect of captured field/type/enum value
+ * has to be adjusted by relocations. It is emitted by llvm and passed to
+ * libbpf and later to the kernel.
+ */
+enum bpf_core_relo_kind {
+	BPF_CORE_FIELD_BYTE_OFFSET = 0,      /* field byte offset */
+	BPF_CORE_FIELD_BYTE_SIZE = 1,        /* field size in bytes */
+	BPF_CORE_FIELD_EXISTS = 2,           /* field existence in target kernel */
+	BPF_CORE_FIELD_SIGNED = 3,           /* field signedness (0 - unsigned, 1 - signed) */
+	BPF_CORE_FIELD_LSHIFT_U64 = 4,       /* bitfield-specific left bitshift */
+	BPF_CORE_FIELD_RSHIFT_U64 = 5,       /* bitfield-specific right bitshift */
+	BPF_CORE_TYPE_ID_LOCAL = 6,          /* type ID in local BPF object */
+	BPF_CORE_TYPE_ID_TARGET = 7,         /* type ID in target kernel */
+	BPF_CORE_TYPE_EXISTS = 8,            /* type existence in target kernel */
+	BPF_CORE_TYPE_SIZE = 9,              /* type size in bytes */
+	BPF_CORE_ENUMVAL_EXISTS = 10,        /* enum value existence in target kernel */
+	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index af405c38aadc..fc9a179ea412 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5459,7 +5459,7 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
 		return -ENOTSUP;
 	}
 
-	if (relo->kind != BPF_TYPE_ID_LOCAL &&
+	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
 	    !hashmap__find(cand_cache, type_key, (void **)&cands)) {
 		cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
 		if (IS_ERR(cands)) {
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 56dbe6d16664..d194fb9306ed 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -113,18 +113,18 @@ static bool is_flex_arr(const struct btf *btf,
 static const char *core_relo_kind_str(enum bpf_core_relo_kind kind)
 {
 	switch (kind) {
-	case BPF_FIELD_BYTE_OFFSET: return "byte_off";
-	case BPF_FIELD_BYTE_SIZE: return "byte_sz";
-	case BPF_FIELD_EXISTS: return "field_exists";
-	case BPF_FIELD_SIGNED: return "signed";
-	case BPF_FIELD_LSHIFT_U64: return "lshift_u64";
-	case BPF_FIELD_RSHIFT_U64: return "rshift_u64";
-	case BPF_TYPE_ID_LOCAL: return "local_type_id";
-	case BPF_TYPE_ID_TARGET: return "target_type_id";
-	case BPF_TYPE_EXISTS: return "type_exists";
-	case BPF_TYPE_SIZE: return "type_size";
-	case BPF_ENUMVAL_EXISTS: return "enumval_exists";
-	case BPF_ENUMVAL_VALUE: return "enumval_value";
+	case BPF_CORE_FIELD_BYTE_OFFSET: return "byte_off";
+	case BPF_CORE_FIELD_BYTE_SIZE: return "byte_sz";
+	case BPF_CORE_FIELD_EXISTS: return "field_exists";
+	case BPF_CORE_FIELD_SIGNED: return "signed";
+	case BPF_CORE_FIELD_LSHIFT_U64: return "lshift_u64";
+	case BPF_CORE_FIELD_RSHIFT_U64: return "rshift_u64";
+	case BPF_CORE_TYPE_ID_LOCAL: return "local_type_id";
+	case BPF_CORE_TYPE_ID_TARGET: return "target_type_id";
+	case BPF_CORE_TYPE_EXISTS: return "type_exists";
+	case BPF_CORE_TYPE_SIZE: return "type_size";
+	case BPF_CORE_ENUMVAL_EXISTS: return "enumval_exists";
+	case BPF_CORE_ENUMVAL_VALUE: return "enumval_value";
 	default: return "unknown";
 	}
 }
@@ -132,12 +132,12 @@ static const char *core_relo_kind_str(enum bpf_core_relo_kind kind)
 static bool core_relo_is_field_based(enum bpf_core_relo_kind kind)
 {
 	switch (kind) {
-	case BPF_FIELD_BYTE_OFFSET:
-	case BPF_FIELD_BYTE_SIZE:
-	case BPF_FIELD_EXISTS:
-	case BPF_FIELD_SIGNED:
-	case BPF_FIELD_LSHIFT_U64:
-	case BPF_FIELD_RSHIFT_U64:
+	case BPF_CORE_FIELD_BYTE_OFFSET:
+	case BPF_CORE_FIELD_BYTE_SIZE:
+	case BPF_CORE_FIELD_EXISTS:
+	case BPF_CORE_FIELD_SIGNED:
+	case BPF_CORE_FIELD_LSHIFT_U64:
+	case BPF_CORE_FIELD_RSHIFT_U64:
 		return true;
 	default:
 		return false;
@@ -147,10 +147,10 @@ static bool core_relo_is_field_based(enum bpf_core_relo_kind kind)
 static bool core_relo_is_type_based(enum bpf_core_relo_kind kind)
 {
 	switch (kind) {
-	case BPF_TYPE_ID_LOCAL:
-	case BPF_TYPE_ID_TARGET:
-	case BPF_TYPE_EXISTS:
-	case BPF_TYPE_SIZE:
+	case BPF_CORE_TYPE_ID_LOCAL:
+	case BPF_CORE_TYPE_ID_TARGET:
+	case BPF_CORE_TYPE_EXISTS:
+	case BPF_CORE_TYPE_SIZE:
 		return true;
 	default:
 		return false;
@@ -160,8 +160,8 @@ static bool core_relo_is_type_based(enum bpf_core_relo_kind kind)
 static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
 {
 	switch (kind) {
-	case BPF_ENUMVAL_EXISTS:
-	case BPF_ENUMVAL_VALUE:
+	case BPF_CORE_ENUMVAL_EXISTS:
+	case BPF_CORE_ENUMVAL_VALUE:
 		return true;
 	default:
 		return false;
@@ -624,7 +624,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 
 	*field_sz = 0;
 
-	if (relo->kind == BPF_FIELD_EXISTS) {
+	if (relo->kind == BPF_CORE_FIELD_EXISTS) {
 		*val = spec ? 1 : 0;
 		return 0;
 	}
@@ -637,7 +637,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 
 	/* a[n] accessor needs special handling */
 	if (!acc->name) {
-		if (relo->kind == BPF_FIELD_BYTE_OFFSET) {
+		if (relo->kind == BPF_CORE_FIELD_BYTE_OFFSET) {
 			*val = spec->bit_offset / 8;
 			/* remember field size for load/store mem size */
 			sz = btf__resolve_size(spec->btf, acc->type_id);
@@ -645,7 +645,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 				return -EINVAL;
 			*field_sz = sz;
 			*type_id = acc->type_id;
-		} else if (relo->kind == BPF_FIELD_BYTE_SIZE) {
+		} else if (relo->kind == BPF_CORE_FIELD_BYTE_SIZE) {
 			sz = btf__resolve_size(spec->btf, acc->type_id);
 			if (sz < 0)
 				return -EINVAL;
@@ -697,36 +697,36 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 		*validate = !bitfield;
 
 	switch (relo->kind) {
-	case BPF_FIELD_BYTE_OFFSET:
+	case BPF_CORE_FIELD_BYTE_OFFSET:
 		*val = byte_off;
 		if (!bitfield) {
 			*field_sz = byte_sz;
 			*type_id = field_type_id;
 		}
 		break;
-	case BPF_FIELD_BYTE_SIZE:
+	case BPF_CORE_FIELD_BYTE_SIZE:
 		*val = byte_sz;
 		break;
-	case BPF_FIELD_SIGNED:
+	case BPF_CORE_FIELD_SIGNED:
 		/* enums will be assumed unsigned */
 		*val = btf_is_enum(mt) ||
 		       (btf_int_encoding(mt) & BTF_INT_SIGNED);
 		if (validate)
 			*validate = true; /* signedness is never ambiguous */
 		break;
-	case BPF_FIELD_LSHIFT_U64:
+	case BPF_CORE_FIELD_LSHIFT_U64:
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 		*val = 64 - (bit_off + bit_sz - byte_off  * 8);
 #else
 		*val = (8 - byte_sz) * 8 + (bit_off - byte_off * 8);
 #endif
 		break;
-	case BPF_FIELD_RSHIFT_U64:
+	case BPF_CORE_FIELD_RSHIFT_U64:
 		*val = 64 - bit_sz;
 		if (validate)
 			*validate = true; /* right shift is never ambiguous */
 		break;
-	case BPF_FIELD_EXISTS:
+	case BPF_CORE_FIELD_EXISTS:
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -747,20 +747,20 @@ static int bpf_core_calc_type_relo(const struct bpf_core_relo *relo,
 	}
 
 	switch (relo->kind) {
-	case BPF_TYPE_ID_TARGET:
+	case BPF_CORE_TYPE_ID_TARGET:
 		*val = spec->root_type_id;
 		break;
-	case BPF_TYPE_EXISTS:
+	case BPF_CORE_TYPE_EXISTS:
 		*val = 1;
 		break;
-	case BPF_TYPE_SIZE:
+	case BPF_CORE_TYPE_SIZE:
 		sz = btf__resolve_size(spec->btf, spec->root_type_id);
 		if (sz < 0)
 			return -EINVAL;
 		*val = sz;
 		break;
-	case BPF_TYPE_ID_LOCAL:
-	/* BPF_TYPE_ID_LOCAL is handled specially and shouldn't get here */
+	case BPF_CORE_TYPE_ID_LOCAL:
+	/* BPF_CORE_TYPE_ID_LOCAL is handled specially and shouldn't get here */
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -776,10 +776,10 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
 	const struct btf_enum *e;
 
 	switch (relo->kind) {
-	case BPF_ENUMVAL_EXISTS:
+	case BPF_CORE_ENUMVAL_EXISTS:
 		*val = spec ? 1 : 0;
 		break;
-	case BPF_ENUMVAL_VALUE:
+	case BPF_CORE_ENUMVAL_VALUE:
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
 		t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
@@ -1236,7 +1236,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	libbpf_print(LIBBPF_DEBUG, "\n");
 
 	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
-	if (relo->kind == BPF_TYPE_ID_LOCAL) {
+	if (relo->kind == BPF_CORE_TYPE_ID_LOCAL) {
 		targ_res.validate = true;
 		targ_res.poison = false;
 		targ_res.orig_val = local_spec.root_type_id;
@@ -1302,7 +1302,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	}
 
 	/*
-	 * For BPF_FIELD_EXISTS relo or when used BPF program has field
+	 * For BPF_CORE_FIELD_EXISTS relo or when used BPF program has field
 	 * existence checks or kernel version/config checks, it's expected
 	 * that we might not find any candidates. In this case, if field
 	 * wasn't found in any candidate, the list of candidates shouldn't
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 3b9f8f18346c..3d0b86e7f439 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -4,23 +4,7 @@
 #ifndef __RELO_CORE_H
 #define __RELO_CORE_H
 
-/* bpf_core_relo_kind encodes which aspect of captured field/type/enum value
- * has to be adjusted by relocations.
- */
-enum bpf_core_relo_kind {
-	BPF_FIELD_BYTE_OFFSET = 0,	/* field byte offset */
-	BPF_FIELD_BYTE_SIZE = 1,	/* field size in bytes */
-	BPF_FIELD_EXISTS = 2,		/* field existence in target kernel */
-	BPF_FIELD_SIGNED = 3,		/* field signedness (0 - unsigned, 1 - signed) */
-	BPF_FIELD_LSHIFT_U64 = 4,	/* bitfield-specific left bitshift */
-	BPF_FIELD_RSHIFT_U64 = 5,	/* bitfield-specific right bitshift */
-	BPF_TYPE_ID_LOCAL = 6,		/* type ID in local BPF object */
-	BPF_TYPE_ID_TARGET = 7,		/* type ID in target kernel */
-	BPF_TYPE_EXISTS = 8,		/* type existence in target kernel */
-	BPF_TYPE_SIZE = 9,		/* type size in bytes */
-	BPF_ENUMVAL_EXISTS = 10,	/* enum value existence in target kernel */
-	BPF_ENUMVAL_VALUE = 11,		/* enum value integer value */
-};
+#include <linux/bpf.h>
 
 /* The minimum bpf_core_relo checked by the loader
  *
-- 
2.30.2

