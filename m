Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E79A678BF4
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 00:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjAWXWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 18:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjAWXWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 18:22:40 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA517CF7;
        Mon, 23 Jan 2023 15:22:39 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id o5so11718330qtr.11;
        Mon, 23 Jan 2023 15:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m39MU2Z/G62daCdjUzCBvxJkprRH1i3gxUN8pCdsiIk=;
        b=P0thrspY03Ru6G4iI8LWMinFTDRlfAD7JglDVSCqO4f7TK+KgK2zeuHSUmggHhmXgm
         8u9oJMCvSb8uEOfzKdpazJQTo5qjyW7ZFDk517D3EWbggBhRk9T/uUDVoZTU2sc4Vtzv
         x4EPwU1PEcpadT8ZvK47ug4YbSiX5EXw3pCOfmu5VZ4nZ/jF+7YQUM4+V4cLd2acsMjF
         BYjgckt1aLV/q23ylf+00yAmrc5DBQwDPz/jwQGwTAD0Ey++ffHWZYpYqiGKGamUWWfG
         ggQkaJoT5u0LgjpW3tx3k2/lX9S0NtDQxJCZhcg7eyE3+k6rzXSl18BBMQ8F0JgHE5c+
         tr4Q==
X-Gm-Message-State: AFqh2kqcdEdiOtvOewexKzb4aAULVqJIca72ZivMHWNSiQqQkMdMXuKS
        XDIn6JUgrHONWMi8vxAwqs48dpShP2aj9g/H
X-Google-Smtp-Source: AMrXdXs6nUxZb9/T6OdbpSl6pLLdA284qYmd/HZHMKqvCUf5uG3E5kaIYoJvyCvZr2e5gVpIHtBmfQ==
X-Received: by 2002:ac8:5490:0:b0:3a7:242:4f3 with SMTP id h16-20020ac85490000000b003a7024204f3mr37770983qtq.66.1674516157823;
        Mon, 23 Jan 2023 15:22:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id e16-20020ac84910000000b003972790deb9sm151439qtq.84.2023.01.23.15.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:22:37 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next 2/3] bpf: Pass const struct bpf_prog * to .check_member
Date:   Mon, 23 Jan 2023 17:22:27 -0600
Message-Id: <20230123232228.646563-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123232228.646563-1-void@manifault.com>
References: <20230123232228.646563-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The .check_member field of struct bpf_struct_ops is currently passed the
member's btf_type via const struct btf_type *t, and a const struct
btf_member *member. This allows the struct_ops implementation to check
whether e.g. an ops is supported, but it would be useful to also allow
it to enforce that the struct_ops prog being loaded for that member has
other properties, like being sleepable (or not). This patch therefore
updates the .check_member() callback to also take a const struct
bpf_prog *prog argument.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h   | 3 ++-
 kernel/bpf/verifier.c | 2 +-
 net/ipv4/bpf_tcp_ca.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae7771c7d750..b30739634947 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1421,7 +1421,8 @@ struct bpf_struct_ops {
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
index 6b8dcd542950..eaa0b9acb555 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16714,7 +16714,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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

