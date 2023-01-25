Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4207267A9D8
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 06:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjAYFER (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 00:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjAYFEO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 00:04:14 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F8D474F4;
        Tue, 24 Jan 2023 21:04:13 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id q9so12684580pgq.5;
        Tue, 24 Jan 2023 21:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPyaQjSFalprBy0AXNcos253eyU8hf3tSNTKaLeAtbU=;
        b=7ERx4DmrZjRzcasQoO3UM8jXd4neDD4F52KG1zFLNTpBayr44dSWqd62m4yThf+MHu
         akdk+n4OXJYAz0lAKxEy/07ECjhGYHjtTL+n0PiGDmFj2zlsjmg25CzfQqgbvfMOnCKc
         daWt/VRfXPORJ/cuBgzXEsA4P03rpYZwI1OJ6/v3+Tcgj2C/tqQcURBoCOZrCULOjQVM
         uOqGXu7grpiY7mxYjTWQbptkjgs2fylRlPwoJQD1n38NUh8OQGmrWqTa7dL3NKqoA/de
         rh16T6a7+JYDR9x/5eClmL4LeuXj9ppLF1KPUgyvNkKT+dSHQlh2c5THRqAsWqgfURir
         ZxHg==
X-Gm-Message-State: AFqh2kovHS61dxrp6NZks6ZjI/diGl2NEFOmD+4j5aHwZH2l9Bkk0DPE
        PhCVVphKckCwpTkRvQhFc5AR9JWNumA48zO0
X-Google-Smtp-Source: AMrXdXvw4J/o1ImA+C1jpJQ9l3iTvg8+m6Q9Dwk0OPLJ/u17+mvnwEugoa6kCvz1TwFNnIkipU01sg==
X-Received: by 2002:aa7:982b:0:b0:58b:4ae0:c761 with SMTP id q11-20020aa7982b000000b0058b4ae0c761mr31031791pfl.34.1674623052636;
        Tue, 24 Jan 2023 21:04:12 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:d24a])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79499000000b005775c52dbc4sm2492216pfk.167.2023.01.24.21.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 21:04:12 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v3 3/4] bpf: Pass const struct bpf_prog * to .check_member
Date:   Tue, 24 Jan 2023 23:03:58 -0600
Message-Id: <20230125050359.339273-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125050359.339273-1-void@manifault.com>
References: <20230125050359.339273-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The .check_member field of struct bpf_struct_ops is currently passed the
member's btf_type via const struct btf_type *t, and a const struct
btf_member *member. This allows the struct_ops implementation to check
whether e.g. an ops is supported, but it would be useful to also enforce
that the struct_ops prog being loaded for that member has other
qualities, like being sleepable (or not). This patch therefore updates
the .check_member() callback to also take a const struct bpf_prog *prog
argument.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h   | 3 ++-
 kernel/bpf/verifier.c | 2 +-
 net/ipv4/bpf_tcp_ca.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ad4bb36d4c10..50123afab9bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1422,7 +1422,8 @@ struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
 	int (*init)(struct btf *btf);
 	int (*check_member)(const struct btf_type *t,
-			    const struct btf_member *member);
+			    const struct btf_member *member,
+			    const struct bpf_prog *prog);
 	int (*init_member)(const struct btf_type *t,
 			   const struct btf_member *member,
 			   void *kdata, const void *udata);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b8f0c0aa0cc..20dd03498e56 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16732,7 +16732,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (st_ops->check_member) {
-		int err = st_ops->check_member(t, member);
+		int err = st_ops->check_member(t, member, prog);
 
 		if (err) {
 			verbose(env, "attach to unsupported member %s of struct %s\n",
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 4517d2bd186a..13fc0c185cd9 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -248,7 +248,8 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
 }
 
 static int bpf_tcp_ca_check_member(const struct btf_type *t,
-				   const struct btf_member *member)
+				   const struct btf_member *member,
+				   const struct bpf_prog *prog)
 {
 	if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
 		return -ENOTSUPP;
-- 
2.39.0

