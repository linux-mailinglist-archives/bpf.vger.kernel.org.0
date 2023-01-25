Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8067B732
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjAYQrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjAYQrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:47:47 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F3972A0;
        Wed, 25 Jan 2023 08:47:46 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id z9so16453395qtv.5;
        Wed, 25 Jan 2023 08:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGxzySYtoUdE+E5gljdC4XUw0xMv3aIF1+OGStefhxI=;
        b=cBXJUAyFUbLK2KQ99yMT0mdq2UYnLq6U2vNGZsYn0NYhlODqrLb1r+GAVZPhdiolhx
         0btzhW63NWFWFKwmBcV8ytU/u/zSzeYVOTV/Hgym9JRIqZcUd6bwkflczZdrIt87fre+
         EdvhbduqzmMjid3NZWZpLXzJNaEnLNKw+8fHBa570B6ExA98xNZo36Fo17oXhodSR+by
         gdc/VOalRrrnGhPJGcuCSQ4N0g58GY7tKR3O+vYRMawjbNiI5UYsPBGofm7enRUoTEWe
         0aq3hvikUvTpfjMxSht3e1xy+SMbvt7Cdh//eDNoTXzw8PVKUkrYQ8KV89BExHL1LojH
         r6Sw==
X-Gm-Message-State: AO0yUKV05faV/lCBxFQsdE/0yBh1EvTP8z6VavH7/5xU+jaDOoB2BVrV
        Db0NmiGLhWOtyEAWQqiLUTYsylBGkc1PcM5Q
X-Google-Smtp-Source: AK7set/JGiDIAim+xVDiHSMzFk3ky9qOfyNKD7i9MtcZLY1TPG9NptHcflbpeOkpkwPhu9pG7QwGhg==
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr4986515qti.29.1674665265146;
        Wed, 25 Jan 2023 08:47:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id e127-20020a376985000000b006f9ddaaf01esm3736686qkc.102.2023.01.25.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:47:44 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v4 3/4] bpf: Pass const struct bpf_prog * to .check_member
Date:   Wed, 25 Jan 2023 10:47:34 -0600
Message-Id: <20230125164735.785732-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125164735.785732-1-void@manifault.com>
References: <20230125164735.785732-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
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
index 1bec48d9e5d9..0d868ef1b973 100644
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
index c8907df49f81..6bd097e0d45f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16792,7 +16792,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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

