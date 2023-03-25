Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92D86C90FD
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 22:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjCYVc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 17:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYVc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 17:32:29 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2ACCC00;
        Sat, 25 Mar 2023 14:32:19 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 59so4293676qva.11;
        Sat, 25 Mar 2023 14:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679779939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beTKJfiS4cdFGvjwvhWeZJkcVPSdZmhKDIoBjmdTTxM=;
        b=wROKc2odk+PGDIC0jrAC4F2WpEt4JtXwUtXOKofljq3jGiNDXJeGB4l/0p3bh5xeyZ
         hkNz6CuuBn2C4warfq/d5OajSwR65ZF/GVVYMf60qQRLafQ3fBgCk+9I7zi0dHRBw1O0
         HW73iNciwpVy2qjVn/zmO12PwVZ1xxwbU3uF3RYYEhLYSszE+oFNmyDZfAcylQbBQ/P/
         umUnVJqs+9UgsrLOwTGi5NVyuKIt1T73GGBjmbGORR1SZ+VnhZmc11QKC8yuCyLWukhd
         A7XYgIkyyDyRhNKEIeUWZBE5PWfVtu3hFjNYY3rRE6Y2vrTl+PTMtorA2P7hH+ZNm+xg
         2E9A==
X-Gm-Message-State: AAQBX9ew0igcySMQM/n4P/QIFp9fGzM7CiYzlyRcnRMDy4hu0KiZWKoF
        /0TXVVwDLTeTo9bk6FP0fKdJuUFPS14FNCHeqmo=
X-Google-Smtp-Source: AKy350YUeJB5IIYKLJtrE6eHiS1NoZqKJBfN1G4aPqm3+KL4ESP5bbDM+68fbfBN99SrEdy/yyPCqg==
X-Received: by 2002:a05:6214:2a87:b0:5c6:403d:7af4 with SMTP id jr7-20020a0562142a8700b005c6403d7af4mr10878487qvb.43.1679779938528;
        Sat, 25 Mar 2023 14:32:18 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id mg18-20020a056214561200b005dd8b93457dsm1711403qvb.21.2023.03.25.14.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 14:32:18 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/3] bpf: Remove now-unnecessary NULL checks for KF_RELEASE kfuncs
Date:   Sat, 25 Mar 2023 16:31:45 -0500
Message-Id: <20230325213144.486885-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230325213144.486885-1-void@manifault.com>
References: <20230325213144.486885-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we're not invoking kfunc destructors when the kptr in a map was
NULL, we no longer require NULL checks in many of our KF_RELEASE kfuncs.
This patch removes those NULL checks.

Signed-off-by: David Vernet <void@manifault.com>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 3 ---
 kernel/bpf/cpumask.c               | 3 ---
 kernel/bpf/helpers.c               | 6 ------
 net/bpf/test_run.c                 | 3 ---
 net/netfilter/nf_conntrack_bpf.c   | 2 --
 5 files changed, 17 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 8a034a555d4c..d9ef45fcaeab 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -342,9 +342,6 @@ hid_bpf_release_context(struct hid_bpf_ctx *ctx)
 {
 	struct hid_bpf_ctx_kern *ctx_kern;
 
-	if (!ctx)
-		return;
-
 	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
 
 	kfree(ctx_kern);
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index db9da2194c1a..e991af7dc13c 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -102,9 +102,6 @@ static void cpumask_free_cb(struct rcu_head *head)
  */
 __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 {
-	if (!cpumask)
-		return;
-
 	if (refcount_dec_and_test(&cpumask->usage))
 		call_rcu(&cpumask->rcu, cpumask_free_cb);
 }
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f753676ef652..8980f6859443 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2089,9 +2089,6 @@ __bpf_kfunc struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
  */
 __bpf_kfunc void bpf_task_release(struct task_struct *p)
 {
-	if (!p)
-		return;
-
 	put_task_struct(p);
 }
 
@@ -2148,9 +2145,6 @@ __bpf_kfunc struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
  */
 __bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
 {
-	if (!cgrp)
-		return;
-
 	cgroup_put(cgrp);
 }
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8d6b31209bd6..27587f1c5f36 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -615,9 +615,6 @@ bpf_kfunc_call_memb_acquire(void)
 
 __bpf_kfunc void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
-	if (!p)
-		return;
-
 	refcount_dec(&p->cnt);
 }
 
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index cd99e6dc1f35..002e9d24a1e9 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -401,8 +401,6 @@ __bpf_kfunc struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
  */
 __bpf_kfunc void bpf_ct_release(struct nf_conn *nfct)
 {
-	if (!nfct)
-		return;
 	nf_ct_put(nfct);
 }
 
-- 
2.39.0

