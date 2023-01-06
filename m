Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C876603A2
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 16:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjAFPoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 10:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjAFPoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 10:44:04 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665C3D5FA
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 07:44:04 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id m129so1797984vsc.11
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd5JRFn3Cr5IWNkuRQ9nibDUI9vKExSd4SCBuH3OmNw=;
        b=W3BOxt4a7zLzcHt5RbOYmVdoHtne+0CNMYaCjuAlZ9GrHaRCSgiq5pAPd3KQqye6oq
         axxavehyxKqrmf4Gvj0BZGFH+nd7kVyWug5Gt4p/iJzcW9crHQ2O1IIgCcPqIvxV2/QI
         bODjxUlpV5Hb6Wk/dR9Q1OnABzB3T9BmoAhkjnxEBwiUPTNMZdhXNlyHsVv/nF1Exxsr
         f0/6aGV3qQgLTxICpzYYOMnNlIgVSARZu6ZW3Rlx5quL/egJ/oFQXi0ITJ005k73Wn67
         KjXWBcma04sLmLsLZR1i22/8RpI69T/x/2wBIthk8qQHVT+kg0erEoYsOkhhXv7/iv0r
         CEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd5JRFn3Cr5IWNkuRQ9nibDUI9vKExSd4SCBuH3OmNw=;
        b=KetlojoTMO2ScxRIwkNXJRWqLmMvqfsoGv6q2o1TFTXVadGf5Z4nbrhNOU/fq3ttb4
         4aH5pser9cWNbi48CFToI7DeyPa4+UE58YDSLImvl0b2jyjTohemFDEX1p3DHKwYbzPx
         mZMEvKzCe6xErEdFDZiu5OcjtswHgBHi0w9oLoUl3Qg2Rp/0skADQP1xifsfG5YCsHt4
         g2zZMlCVTTFoHhYbs6gLGawwcGIxrbiuQZkWCX388bVOVgr12PkJh0YrvnzwRwqnkuDv
         Dofz0aNLppI6jY4zU/4eJJLkw/KSO8XeJWnhoNq4mTQ59XY1rAnVwXXK79hyEl6fAb3z
         M8zA==
X-Gm-Message-State: AFqh2krRltLUAzKO6xCnumG+XZw86plueDpj3YtKmjDXNkO5f+SJiaaw
        5aHsvH0LJjRHIsqBMJhuMSp5KxanQe6Gwo8=
X-Google-Smtp-Source: AMrXdXs8rijHgVUdSfFZAXBKIH6T7FgQK3p9S5Uiy+/kLe4hL1kOCqS28Jglq6Smsm8NfhFBWxp6fA==
X-Received: by 2002:a67:fe8c:0:b0:3cc:fb78:e403 with SMTP id b12-20020a67fe8c000000b003ccfb78e403mr13173588vsr.10.1673019843168;
        Fri, 06 Jan 2023 07:44:03 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id w19-20020a05620a445300b006fc3fa1f589sm678167qkp.114.2023.01.06.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 07:44:02 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-audit@redhat.com, bpf@vger.kernel.org
Cc:     Burn Alting <burn.alting@iinet.net.au>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 2/2] bpf: remove the do_idr_lock parameter from bpf_prog_free_id()
Date:   Fri,  6 Jan 2023 10:44:00 -0500
Message-Id: <20230106154400.74211-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106154400.74211-1-paul@paul-moore.com>
References: <20230106154400.74211-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It was determined that the do_idr_lock parameter to
bpf_prog_free_id() was not necessary as it should always be true.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

---
* v3
- initial draft
---
 include/linux/bpf.h  |  2 +-
 kernel/bpf/syscall.c | 20 ++++++--------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3de24cfb7a3d..634d37a599fa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1832,7 +1832,7 @@ void bpf_prog_inc(struct bpf_prog *prog);
 struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
 
-void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
+void bpf_prog_free_id(struct bpf_prog *prog);
 void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
 
 struct btf_field *btf_record_find(const struct btf_record *rec,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 61bb19e81b9c..ecca9366c7a6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2001,7 +2001,7 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
 	return id > 0 ? 0 : id;
 }
 
-void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
+void bpf_prog_free_id(struct bpf_prog *prog)
 {
 	unsigned long flags;
 
@@ -2013,18 +2013,10 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
 	if (!prog->aux->id)
 		return;
 
-	if (do_idr_lock)
-		spin_lock_irqsave(&prog_idr_lock, flags);
-	else
-		__acquire(&prog_idr_lock);
-
+	spin_lock_irqsave(&prog_idr_lock, flags);
 	idr_remove(&prog_idr, prog->aux->id);
 	prog->aux->id = 0;
-
-	if (do_idr_lock)
-		spin_unlock_irqrestore(&prog_idr_lock, flags);
-	else
-		__release(&prog_idr_lock);
+	spin_unlock_irqrestore(&prog_idr_lock, flags);
 }
 
 static void __bpf_prog_put_rcu(struct rcu_head *rcu)
@@ -2067,11 +2059,11 @@ static void bpf_prog_put_deferred(struct work_struct *work)
 	prog = aux->prog;
 	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
 	bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
-	bpf_prog_free_id(prog, true);
+	bpf_prog_free_id(prog);
 	__bpf_prog_put_noref(prog, true);
 }
 
-static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
+static void __bpf_prog_put(struct bpf_prog *prog)
 {
 	struct bpf_prog_aux *aux = prog->aux;
 
@@ -2087,7 +2079,7 @@ static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
 
 void bpf_prog_put(struct bpf_prog *prog)
 {
-	__bpf_prog_put(prog, true);
+	__bpf_prog_put(prog);
 }
 EXPORT_SYMBOL_GPL(bpf_prog_put);
 
-- 
2.39.0

