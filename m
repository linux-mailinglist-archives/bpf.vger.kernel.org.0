Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F9436A97
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhJUSgC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 14:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhJUSfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 14:35:55 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC55C061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 11:33:34 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c140-20020a624e92000000b0044d3de98438so870803pfb.14
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=csE7Jl2MSzq5uoCjuK5e2feHugbpafxKXv5MEvDBDoM=;
        b=qgGEPVVYPyXkr87p36vd3FVc+ikcy34fAE4AwmR+hVEnhpZ66WcbvPN5v4pD6Gnzlk
         jH86so+jRPZPP00Qz46Ptota6qfBfKmM7RXyJv7z50DQ+ZK+0Q+IcBipDJK4SayNFmJN
         urHlVzuGlMw7ua55+QKeTYEuQU1FU/On/PuiPxxzOLs9/sUT6t1r5k8L2NHjGBau5xn8
         sayoJ1N579KscMsAQgkh0mOyCuPTRkcybH5hcsPqDWwmkXEh5tJxmCIYTJ6Eci50P3Cf
         431UVOpP/DMj8q6bU4re4RUKj6EbBrGcy3nQme5vc3NcEkgQhLyjul+BfC+qkBKjEH5I
         0C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=csE7Jl2MSzq5uoCjuK5e2feHugbpafxKXv5MEvDBDoM=;
        b=FF5C8sxHprJm1B0xauspZOKeH1UuinhZ5e2jXOwMcN4/w/+hTYPo/taBQMWSBZG9ac
         XX5GUU4v+kZUd/PDRIQFZASSfKOvUjEqT+0yHfxHNCezfBXd63GYNzOHQAOL5D++32vG
         9RvEu6xP02JX/IYNvldV3Pc5mmAcKcN3GSqH3L5dfsOazivpgU8MZzvqhCedc7su/fB7
         uJRIsZBMkz6nXzqGKsmD1RGaaF2a1it5pqBlkls7XrlTMk1EYlNquSo/qgZAJTURiBJf
         N/bI7o1nh37+lgJcBsGirXapLMKBhNLYtE7oHT8FLY/WOUfgt7Hg6j2N6JyCqxxTYz9v
         4BHA==
X-Gm-Message-State: AOAM532uQMilAQaxv5Dj94ziaWqBB/qATPzp0igxliY0LTgcHIYDPKYn
        IU+dlA90jFotG3/HZaQ2KytUru2u2VzT
X-Google-Smtp-Source: ABdhPJzS1jplhYx98s4IlY/ZI6NZ6JIe9NbOnCMZDjZW7QVaOrIaiSNT4Kug+8BDXjbsJHeVO8fAzLRA8zvS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6827:3dc3:9d6c:8c3d])
 (user=irogers job=sendgmr) by 2002:a63:bf4a:: with SMTP id
 i10mr5709794pgo.196.1634841213930; Thu, 21 Oct 2021 11:33:33 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:33:30 -0700
Message-Id: <20211021183330.460681-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3] btf_encoder: Make BTF_KIND_TAG conditional
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
index c341f95..5e523f1 100644
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
+#if LIBBPF_MAJOR_VERSION > 0 || LIBBPF_MINOR_VERSION > 5
 	[BTF_KIND_TAG]          = "TAG",
+#endif
 };
 
 static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
@@ -648,6 +659,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
 static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
 				    int component_idx)
 {
+#if LIBBPF_MAJOR_VERSION > 0 || LIBBPF_MINOR_VERSION > 5
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

