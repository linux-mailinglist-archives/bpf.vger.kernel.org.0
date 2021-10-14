Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA342E32F
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhJNVW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhJNVW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 17:22:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A156C061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 14:20:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a252256000000b005b67a878f56so2186815ybi.17
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LhIvyKiqWMJh9z36zfOEjX66ugRybYFWymjUtEWgEpw=;
        b=kLwOoBUIyHB+c36qj5ycsQB2iDG356EHLJcIdCxOqn+rXoRKuvDWcCaqH+afTp8q1x
         n0X3LRcjnEbPoyFwvFio3kaKvzDWPBnyZHCeB7mmX6LMAzSq/irZlTUhEJaArw3NLCPf
         pDjAAJlpVqBh4sqQ0X1Vax15aTwyLvJWfnF48LF1XTYTHSZwk+79ZkXtRzqYOQ6tKsg3
         wMX5veDox3lHqI5ujENR+dOpl5sBxMi/+wbuAzt/lQLqHKu/7HThkeCxpKmBt7djFR6B
         5N+vUZLNxkBdBksFP4YWRksi/GZOVBM0+SjKNDVvekO7WkeHvgFX3YPDon9Ks1gupo/Q
         HVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LhIvyKiqWMJh9z36zfOEjX66ugRybYFWymjUtEWgEpw=;
        b=lGqknFFe481pLCjk84ntKkBDqfY/liR42t+qs2l0BACh0ozQb6EYOOKh8GeDqIeAH9
         5un3fIoKzXsYGE0QwqtjzVi/zQfaUFVohDiFHS4drJWpku5sA/8tZoawZetS4C8DBHF2
         J8HosU4QnqZViKtEQmIe9YTj1oZc+/GQZCKdO5Z9RNUONAaOKNdFXnyMs9aPGfa4bicq
         L8dovAwuBndsOb4OF8Vl6hsV92FH2EZJ9cxhiwwRvrwTw9gUun+k4XauhfP4m7jxib12
         dFxpzlt9X8gG9i8jT3rEf0GnruQg6bFD40zrNwPK4XCzVOAtyxIsKuisulVYHUzXILgO
         5CqQ==
X-Gm-Message-State: AOAM531clxH+wL9SqBLLIv3rAMv+ajv2nMp/DNMc76548YedMi1q9PJ9
        QKuuSPcuG2QCZ5BCSXIDNgEanLjblzjn
X-Google-Smtp-Source: ABdhPJyD++4Y3fAAuhgZ9WXjt0VE1z7s9k8DOIFqelyLIuItQ3GZ1cjPMDiFAvMiVh/lEcadubmok/Suv215
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c2c4:f27e:e7cd:5238])
 (user=irogers job=sendgmr) by 2002:a25:5e06:: with SMTP id
 s6mr8944427ybb.175.1634246453227; Thu, 14 Oct 2021 14:20:53 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:20:49 -0700
Message-Id: <20211014212049.1010192-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] btf_encoder: Make BTF_KIND_TAG conditional
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
 btf_encoder.c | 7 +++++++
 lib/bpf       | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c341f95..400d64b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -141,7 +141,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_VAR]          = "VAR",
 	[BTF_KIND_DATASEC]      = "DATASEC",
 	[BTF_KIND_FLOAT]        = "FLOAT",
+#ifdef BTF_KIND_TAG /* BTF_KIND_TAG was added in 6.0 */
 	[BTF_KIND_TAG]          = "TAG",
+#endif
 };
 
 static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
@@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
 static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
 				    int component_idx)
 {
+#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */
 	struct btf *btf = encoder->btf;
 	const struct btf_type *t;
 	int32_t id;
@@ -663,6 +666,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
 	}
 
 	return id;
+#else
+        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
+        return -ENOTSUP;
+#endif
 }
 
 /*
diff --git a/lib/bpf b/lib/bpf
index 980777c..986962f 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
+Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
-- 
2.33.0.1079.g6e70778dc9-goog

