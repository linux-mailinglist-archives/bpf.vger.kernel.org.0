Return-Path: <bpf+bounces-54773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4EA71E03
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 19:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68C01767D3
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EA24EF7C;
	Wed, 26 Mar 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlOLi95I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564124EF75
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012441; cv=none; b=igQMohyCDeBmA+t6ZGe4lupXCJ2NBPr0Ctzb8gvnRxl1BSF/x73DzilN3Nb/2gfEkTL1Y8RN1K7Z45zskSLfPnH3Uj+4TXqWGe2e6kC/a1y/78GXxaRxrQ0kKs/N5WnuSYhxUVHX702MKRne5X6jvwQLZr7vB3fo+zoTW+92a5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012441; c=relaxed/simple;
	bh=baK7p24Dax5tWP6N71//bnq1UXzaGxGc9GcJQQtpa9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UbxTcY/uy0XFckh/eUpim6YiF4Yv5DVpkuxUk/PAzel/bD4NT6ShCrKS7wMfiHyijPFvmSDoOPOFDNq93Hgr6qCBgPTx2NjOFwTfhGrhqmV1N/qv/VKfwMJYKN1MJ4+DsEi5cU32lTVb2vhYUpHw7ZttsHod4FZp4dI/wZv5YG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlOLi95I; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7430e27b2so19392266b.3
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743012438; x=1743617238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpTzmuymZQs8desL7NVD6gMUOzOOfqqv2Sm2PIvrwP0=;
        b=UlOLi95IhpWk6wnDZus5DRmUTdJHvIUsEbpa12qM7ucXIwurZXfYnqaYh3MJbq+YNl
         1FeT90mMfx1lrTkBnzaqGGAjoPTrhR+GAXowCf1k7vYP70Ztc/uxD3BvHY4N2XE5CjpB
         OFNjZvMKRzTbKyjn1uvxNn2DFA0qjW0w7XkWg5HtV6sFv2hy4pthkIGRwjUyJql4dDdG
         6TQzmAERoUtDYFNHGeug5bR4NArshGGyQ4P0k3c+0fp4xX1BROPwR5XlUfNlEQhb+tuv
         zphi8YNZyykpFFYcfOQEraNkzEMDzIwEEa7qOR6xIEdx1Gnop/i6iZvQYtykk8By+0lz
         lqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743012438; x=1743617238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpTzmuymZQs8desL7NVD6gMUOzOOfqqv2Sm2PIvrwP0=;
        b=IEN531J/ihzLadLPYKZWHynOz/dWOMYBxsWbLewOr8QD8pHaLOCtRU8GSnxjCD9FOJ
         e29ygRuv6U+Mzd5XFIEZEj948cKEy2w7YiG5obO4RE3X046B42U/r2kBa8l5e8nULATc
         O4B+CjkYr4RItb4M0P5bKDecH9uh4rBXPmRGsy4ScRY5xLwVP0+OnjxJgHECOOIvxtBe
         gCXLtOSv90wvDw8XqllrFQuQNXcyJdPVQx1wc/AE6aSjHFymuxJBz6lqvBi2jfr+K3cf
         bSUrmDtQsLvz1u66Z3ylhkJQXo6v9cJVYcBeaK4ElOnVxbEALFjLpecPFNT2m0HLnKIm
         IsHg==
X-Gm-Message-State: AOJu0YzGwLkB0FVjJivtZYTQwk5wX5jSfErS/SGFeUl3cGnW1/ou5iRQ
	PBdswUfUtl6tuMkeJBdXGB+0pQdc5BrtOfIXBO6z55j7k5ak08fJVxUwXg==
X-Gm-Gg: ASbGncs94Sv2l6+5cp1rk0WVlT89LZ+os74G+yjezQ6Z0LIDeu71dJI4ryYA1J/Fsuq
	WyipKnVYvb6XTnaumSMjgzXgs///M5hvIUY9NRKlUd2fqekrDc7VRXu5lXBd2dDobzzENADvC5j
	xumG3p+YFP/AuSHyMqwy+Ylk0kHDZthx7lX4g13fZPNPRTEl61+rRmYAZMMaygHfKgrl3nT2Huj
	9w25QFyviGWMEHABqiY1Sx5GNLyqvZo89nukCQvtQK8h1s+uJbSyuOf+9/L2aG6ovxvNEfX/Yk7
	jq0F4qEBECuA4EArlFyY70Ui8Fd0WG2bsODFC5DdtaZMz0M1vebDmVyHtS0=
X-Google-Smtp-Source: AGHT+IEKckTW0OaMj4yi/CuK5SW3EB/wWfRBfXwMi1tsVMc/YwcpwVV7t/m6j1sXkiUu4tjKcZMVeQ==
X-Received: by 2002:a17:907:9809:b0:ac3:3f11:58ff with SMTP id a640c23a62f3a-ac6fb0fcd8cmr39448066b.45.1743012438057;
        Wed, 26 Mar 2025 11:07:18 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:7e9c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb52279sm1063815466b.116.2025.03.26.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:07:17 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line info
Date: Wed, 26 Mar 2025 18:07:14 +0000
Message-ID: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing new libbpf API getters for BTF.ext func and line info,
namely:
  bpf_program__func_info
  bpf_program__func_info_cnt
  bpf_program__func_info_rec_size
  bpf_program__line_info
  bpf_program__line_info_cnt
  bpf_program__line_info_rec_size

This change enables scenarios, when user needs to load bpf_program
directly using `bpf_prog_load`, instead of higher-level
`bpf_object__load`. Line and func info are required for checking BTF
info in verifier; verification may fail without these fields if, for
example, program calls `bpf_obj_new`.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  8 ++++++++
 tools/lib/bpf/libbpf.map |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b85060f07b3..bc15526ed84c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9455,6 +9455,36 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 	return 0;
 }
 
+void *bpf_program__func_info(struct bpf_program *prog)
+{
+	return prog->func_info;
+}
+
+__u32 bpf_program__func_info_cnt(struct bpf_program *prog)
+{
+	return prog->func_info_cnt;
+}
+
+__u32 bpf_program__func_info_rec_size(struct bpf_program *prog)
+{
+	return prog->func_info_rec_size;
+}
+
+void *bpf_program__line_info(struct bpf_program *prog)
+{
+	return prog->line_info;
+}
+
+__u32 bpf_program__line_info_cnt(struct bpf_program *prog)
+{
+	return prog->line_info_cnt;
+}
+
+__u32 bpf_program__line_info_rec_size(struct bpf_program *prog)
+{
+	return prog->line_info_rec_size;
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = (char *)sec_pfx,						    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e0605403f977..29a5fd7f51f0 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -940,6 +940,14 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
 LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
 LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
+LIBBPF_API void *bpf_program__func_info(struct bpf_program *prog);
+LIBBPF_API __u32 bpf_program__func_info_cnt(struct bpf_program *prog);
+LIBBPF_API __u32 bpf_program__func_info_rec_size(struct bpf_program *prog);
+
+LIBBPF_API void *bpf_program__line_info(struct bpf_program *prog);
+LIBBPF_API __u32 bpf_program__line_info_cnt(struct bpf_program *prog);
+LIBBPF_API __u32 bpf_program__line_info_rec_size(struct bpf_program *prog);
+
 /**
  * @brief **bpf_program__set_attach_target()** sets BTF-based attach target
  * for supported BPF program types:
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d8b71f22f197..a5d83189c084 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -437,6 +437,12 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
 		bpf_object__prepare;
+		bpf_program__func_info;
+		bpf_program__func_info_cnt;
+		bpf_program__func_info_rec_size;
+		bpf_program__line_info;
+		bpf_program__line_info_cnt;
+		bpf_program__line_info_rec_size;
 		btf__add_decl_attr;
 		btf__add_type_attr;
 } LIBBPF_1.5.0;
-- 
2.48.1


