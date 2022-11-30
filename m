Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31463D061
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiK3IXy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiK3IXs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:48 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD75FBBA;
        Wed, 30 Nov 2022 00:23:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so1193375pje.5;
        Wed, 30 Nov 2022 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRnwnSE0pgMdvenGsAIhpw8rC6avY4LYPdWHnC8Zd84=;
        b=KqVk2nFS12JlPcPUEdhLECvI1z71JEov8mUnf2l8ZwccxMz4bTbQ6mrVZSMMkV8cg/
         d43NmAZd+QvARDxttlLPbhIhC4tzB60TXvTypj2hQ7NTz86ybp3FHqX7NPjXk7p0PDae
         mvNfsvGt6O8/9ceaL4jZiF+/cZOIHgtye/orITjLxgC1k6EqUoXzZjPjcDAxjy9fgg5u
         0BuxteZw2FAvOSZsl1VrN7umTcFpVWEp3c/x8T+NflmyhhSlU6soHmHcnpjVrkjR/8Oh
         UBPQHQIDRdEn69bVO4wtu6OiGM0c0lZAoTLgIJGMQRI3uxOBV5GSdybtqJt5KMq3ccrC
         w5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRnwnSE0pgMdvenGsAIhpw8rC6avY4LYPdWHnC8Zd84=;
        b=knn8nGTtShG3youZiy487IpowU1MNJMNJu6AT4hRmHbkvKsJDBzVQHDw7sfP/TyWxD
         y9yBlH5lwpzjPKeuFWOLzYQ6JsfRzl3SS/KB+IRSmP25PFNA6k/N1Fw2h0lM0lK2b0+q
         Dvdv3/KoNW5ipMq4frarR9kAvtMtWvFl3nuel2nATnYgQHTEnpgEr4FZY0ksQqy4cVQQ
         Q+vASQgaivSGi8RkVBlpw/Je88AZ5SdZP6Xdh5ZveK4WEoCn11HnmDksStnU8gRDKcJ9
         OZJ4mH5n4XV2q0kZa+l3Rhhpc23t0iuPV/r4/+rkdOEwR767CTVtsl0k/CFVBjBWToJ4
         34Pw==
X-Gm-Message-State: ANoB5pldzp/7VBEdUJ6IbqTrUHWVs/u2M9qeB7enJuSvvNOSiKzeLZBu
        J+UkEkN0XihcvlbcIOG9r7g=
X-Google-Smtp-Source: AA0mqf4lZvxlZSCJ9+DtY5osPPsA+cMeAN3oF5PNd+otYSYGGpOO+tfzw1EQjaQjf4nnHDVJDGbVDQ==
X-Received: by 2002:a17:902:e886:b0:188:fb19:5f39 with SMTP id w6-20020a170902e88600b00188fb195f39mr44380705plg.21.1669796624541;
        Wed, 30 Nov 2022 00:23:44 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b0057507bbd704sm819767pfl.5.2022.11.30.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/31] BPF: Add @prog to bpf_struct_ops->check_member()
Date:   Tue, 29 Nov 2022 22:22:45 -1000
Message-Id: <20221130082313.3241517-4-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pass an extra @prog parameter to bpf_struct_ops->check_member(). This will
be used in the future to verify @prog->aux->sleepable per-operation so that
a subset of operations in a struct_ops can be sleepable.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/bpf.h   | 3 ++-
 kernel/bpf/verifier.c | 2 +-
 net/ipv4/bpf_tcp_ca.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..82f5c30100fd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1337,7 +1337,8 @@ struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
 	int (*init)(struct btf *btf);
 	int (*check_member)(const struct btf_type *t,
-			    const struct btf_member *member);
+			    const struct btf_member *member,
+			    struct bpf_prog *prog);
 	int (*init_member)(const struct btf_type *t,
 			   const struct btf_member *member,
 			   void *kdata, const void *udata);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07c0259dfc1a..b5dba33f8e7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14928,7 +14928,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (st_ops->check_member) {
-		int err = st_ops->check_member(t, member);
+		int err = st_ops->check_member(t, member, prog);
 
 		if (err) {
 			verbose(env, "attach to unsupported member %s of struct %s\n",
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 6da16ae6a962..24c819509b98 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -247,7 +247,8 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
 }
 
 static int bpf_tcp_ca_check_member(const struct btf_type *t,
-				   const struct btf_member *member)
+				   const struct btf_member *member,
+				   struct bpf_prog *prog)
 {
 	if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
 		return -ENOTSUPP;
-- 
2.38.1

