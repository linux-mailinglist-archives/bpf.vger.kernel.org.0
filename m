Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A14368BD
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJURLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJURLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 13:11:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438FC061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 10:09:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r13-20020a17090a1bcd00b001a1b1747cd2so692056pjr.9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8bVJyeQz8xtfM71rV28KhbClKuVdVe3Fd5qAFyoOMtE=;
        b=LQWLTn2bReceDx4GkOQd4UsuBvNnJZcFIvgo3okOiSxhCaDAz8TOzJN6AWNZcTpxbE
         DOc5FG2ax1q8JO4z9WtJlV/yTsTxqORhlwS9uYJJcJjPNHE6SFN2jnr+K2NEdaC/U78L
         JRBO46rIKKi5j0OWNKKA4krTJLn+4Kvs5+97a43rf0Q3tnhQpyUZrpXozufoxVvAmj5t
         In8ugRJjB+F2jImSKUbZPihVUFjWPF/0mtvy4dJRYFJ9NmegSCrYy1q4Hs/ymZWpXmVJ
         SE9VgqxPAH5oBbNfuSQUB/Ak6/RbqVZOLSWYuA8Q4FjIu/Ty6grai4Den7y6/M/YHnkq
         JNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8bVJyeQz8xtfM71rV28KhbClKuVdVe3Fd5qAFyoOMtE=;
        b=XjVxzXHzGX7l/9+rVOTnmDM1v8osuwocH/MmulXVpiO2Gs+DsVv8COH+naz4d+XtgE
         JJkA5rRHjs7j/gHxIoJl+R27MJCJ9qbpPHSlFHMvOaedmxONSF4fE113O1dSKNQNvIWv
         +ySLPLl3YNGOckYB3+ZvuygI0s8AVTiovi4jgciiJwcDqXasM97Vn3LxGjFX9YBJzP4E
         yvxBxaq+gT+plOjLHkCT9XE8lBL233lT+icRhFh1Mjgmt/bMtUO8TsFdhtLIEGw4o/6Q
         mIpqytujTWSQg2TKdzVqNW/e6ue/nNVjar4FNhlwGnwMsk5IrtnCZcYNqtzOsPFUeRYz
         XOKQ==
X-Gm-Message-State: AOAM530R//uQqzEXulLnyY82Li0VLojbLLSIQFpmeTsXQXZa4lgrZUMU
        XURStBgrUhHuFXbRktq2+IaHxOrJ5sMy
X-Google-Smtp-Source: ABdhPJw4DWa6hpqEjb/R1I2IkusoFxtH2pRYBMHj8/BZAsX61IOx32P+Bc6dkLoFOpQmbHXvumh2vzWAWK7d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6827:3dc3:9d6c:8c3d])
 (user=irogers job=sendgmr) by 2002:a17:90b:30d6:: with SMTP id
 hi22mr8279633pjb.4.1634836142110; Thu, 21 Oct 2021 10:09:02 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:08:58 -0700
Message-Id: <20211021170858.446660-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2] btf_encoder: Make BTF_KIND_TAG conditional
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
the code requiring it conditionally compiled in.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 btf_encoder.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index c341f95..1694679 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -31,6 +31,15 @@
 #include <errno.h>
 #include <stdint.h>
 
+#ifndef LIBBPF_MINOR_VERSION
+/*
+ * The libbpf version is not defined in older versions, workaround by assuming
+ * version 0.5.
+ */
+#define LIBBPF_MAJOR_VERSION 0
+#define LIBBPF_MINOR_VERSION 5
+#endif
+
 struct elf_function {
 	const char	*name;
 	bool		 generated;
@@ -141,7 +150,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_VAR]          = "VAR",
 	[BTF_KIND_DATASEC]      = "DATASEC",
 	[BTF_KIND_FLOAT]        = "FLOAT",
+#if LIBBPF_MINOR_VERSION > 5
 	[BTF_KIND_TAG]          = "TAG",
+#endif
 };
 
 static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
@@ -648,6 +659,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
 static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
 				    int component_idx)
 {
+#if LIBBPF_MINOR_VERSION > 5
 	struct btf *btf = encoder->btf;
 	const struct btf_type *t;
 	int32_t id;
@@ -663,6 +675,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
 	}
 
 	return id;
+#else
+        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
+        return -ENOTSUP;
+#endif
 }
 
 /*
-- 
2.33.0.1079.g6e70778dc9-goog

