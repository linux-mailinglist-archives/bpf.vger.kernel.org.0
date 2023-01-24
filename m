Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E8679E3E
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjAXQJm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjAXQJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:09:41 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57F4ABEC;
        Tue, 24 Jan 2023 08:09:30 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id n2so11979079qvo.1;
        Tue, 24 Jan 2023 08:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPyaQjSFalprBy0AXNcos253eyU8hf3tSNTKaLeAtbU=;
        b=eXJI/NGrUz19C2WlxSZtJURJ2eHilrHrSosVRdtit+1WY6c0HXwV5jygEj6C5ZFhte
         42NkGAgv0Q+dIGdtUsR0n8eMGijKV+S8BMtpC0CMHMGtVLKuzNfXRmwmX65SrvDpSSdX
         ptUeyLRgg0x7z/Wfpua82IG6Ig3VI3YA1KVXuSbgTsryJBmBibYBo/GMtbA0yRTNsmwp
         VqyjyuqmeSTzK/T2Ojd55XCJVvTPeHjC/ykpZA9kNSx1vwVQMyI26b94HdMbSw6zYbQM
         LUcUq87860YM7hz1Soj6qV4j52e+nOBgUyWXTz8oC8lxs/nbZXOPStn8X899aumP1GlV
         qBmw==
X-Gm-Message-State: AFqh2kqsVvmYgzdAimFeWokc/w9LQxIySvEyAv1KEvHW6sHrM8K04oxm
        pch1y5QXvETYDvSDZ/lQJPZMeBM2xHXPf7VP
X-Google-Smtp-Source: AMrXdXvUF5f1t2iUehlJH0V3aqTk/IaILyQnq3gEV6JJvYPZISaqAx6aurCAHATbwobigkSlUpMOag==
X-Received: by 2002:a0c:8b12:0:b0:535:2264:7433 with SMTP id q18-20020a0c8b12000000b0053522647433mr38105343qva.6.1674576569229;
        Tue, 24 Jan 2023 08:09:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id e22-20020a05620a209600b006cbe3be300esm1676344qka.12.2023.01.24.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:09:28 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v2 3/4] bpf: Pass const struct bpf_prog * to .check_member
Date:   Tue, 24 Jan 2023 10:08:01 -0600
Message-Id: <20230124160802.1122124-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124160802.1122124-1-void@manifault.com>
References: <20230124160802.1122124-1-void@manifault.com>
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

