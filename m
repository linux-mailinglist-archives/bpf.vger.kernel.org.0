Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F3455A4A
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbhKRLbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344001AbhKRL3t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPsGDeo6aCmpgmXjMoObHMVqT9QgbV/NPDn9sVokyBo=;
        b=DYbVQ08b+5HkSFBBdvRbirakb1OzAHbsJTFm/IxcCYSNFenTWvCkWbd8GDN8JSK9Z1VXl5
        5JgJD0y3witph3lVsfkjzO85R0x4nDIBlD0+X/kQvot92LzZRagAtnQKcyuiAqsyNGXHFN
        FEIPKA0ffxp5WErFtssfGzYRtYYmmLY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-VMExiy6FMTSHFbMIH9b2MA-1; Thu, 18 Nov 2021 06:26:46 -0500
X-MC-Unique: VMExiy6FMTSHFbMIH9b2MA-1
Received: by mail-ed1-f70.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so5010575edq.8
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPsGDeo6aCmpgmXjMoObHMVqT9QgbV/NPDn9sVokyBo=;
        b=PqgAT+bVieBf5E1Drgx33jBphjrRKahbbdVecBQlXN5R/o4WMS/ahkaxO5MluhBcNS
         EsvE/q9dfwiRqQ4xM4xNc4gzClha2uM9/VcMynkGe0rgxEOCAZa5bQc8RmkC31ozNWqJ
         Ievw9fI3QKZzzd+Pk8GIJ6j5DFhAPDTTSmQsJwFYkWVMBMK40d8AezRy3Rfn5HJh6eTW
         7JRNsRuJt1ZtkC6GGO2p6aSFltkV4iE3L7t7zmnPMC15C2WVGBmh+3dh4Of+hqMoIv3M
         WOKRC1n6SrRL6kmdE8DKjeGZQgRsZqgnz234SqRgs2GwJjme1MyM//f8wIF3YdcvKnVL
         W1LA==
X-Gm-Message-State: AOAM5305SQADV0dVSEEEkkHUj4b7Add/4QPr5h3b0v3PSEPIN7jRZ6k8
        fKQxkrUPa9P2gfugihKNUBwxBL/o/ij3rdUzVkFD6Gy14ePibpsromk+gvrjV6OJBkm6k2U53Xv
        PFOP+NP7tKOiE
X-Received: by 2002:a17:906:e28b:: with SMTP id gg11mr32475319ejb.23.1637234805216;
        Thu, 18 Nov 2021 03:26:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgwQ6CQ0SzIvpMVKYD9a6jI2nTXJU1J4Gvi7jQflrEU22Z7fbPtedQcD2IlTdlp73ZuuVP1g==
X-Received: by 2002:a17:906:e28b:: with SMTP id gg11mr32475289ejb.23.1637234805030;
        Thu, 18 Nov 2021 03:26:45 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hc16sm1164557ejc.12.2021.11.18.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:26:44 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 18/29] bpf: Add refcount_t to struct bpf_tramp_id
Date:   Thu, 18 Nov 2021 12:24:44 +0100
Message-Id: <20211118112455.475349-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding refcount_t to struct bpf_tramp_id so we can
track its allocation and safely use one object on
more places in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  3 +++
 kernel/bpf/syscall.c    |  2 +-
 kernel/bpf/trampoline.c | 16 +++++++++++++---
 kernel/bpf/verifier.c   |  2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dda24339e4b1..04ada1d2495e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpfptr.h>
+#include <linux/refcount.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -677,6 +678,7 @@ struct bpf_tramp_id {
 	u32 obj_id;
 	u32 *id;
 	void **addr;
+	refcount_t refcnt;
 };
 
 struct bpf_tramp_node {
@@ -753,6 +755,7 @@ static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 #ifdef CONFIG_BPF_JIT
 struct bpf_tramp_id *bpf_tramp_id_alloc(u32 cnt);
 void bpf_tramp_id_free(struct bpf_tramp_id *id);
+void bpf_tramp_id_put(struct bpf_tramp_id *id);
 bool bpf_tramp_id_is_empty(struct bpf_tramp_id *id);
 int bpf_tramp_id_is_equal(struct bpf_tramp_id *a, struct bpf_tramp_id *b);
 struct bpf_tramp_id *bpf_tramp_id_single(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0acf6cb0fdc7..bfbd81869818 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2901,7 +2901,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 out_put_prog:
 	if (tgt_prog_fd && tgt_prog)
 		bpf_prog_put(tgt_prog);
-	bpf_tramp_id_free(id);
+	bpf_tramp_id_put(id);
 	return err;
 }
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e6a73088ecee..39600fb78c9e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -100,6 +100,7 @@ struct bpf_tramp_id *bpf_tramp_id_alloc(u32 max)
 			return NULL;
 		}
 		id->max = max;
+		refcount_set(&id->refcnt, 1);
 	}
 	return id;
 }
@@ -133,10 +134,18 @@ struct bpf_tramp_id *bpf_tramp_id_single(const struct bpf_prog *tgt_prog,
 	return id;
 }
 
-void bpf_tramp_id_free(struct bpf_tramp_id *id)
+static struct bpf_tramp_id *bpf_tramp_id_get(struct bpf_tramp_id *id)
+{
+	refcount_inc(&id->refcnt);
+	return id;
+}
+
+void bpf_tramp_id_put(struct bpf_tramp_id *id)
 {
 	if (!id)
 		return;
+	if (!refcount_dec_and_test(&id->refcnt))
+		return;
 	kfree(id->addr);
 	kfree(id->id);
 	kfree(id);
@@ -162,7 +171,7 @@ static struct bpf_trampoline *bpf_trampoline_get(struct bpf_tramp_id *id)
 	if (!tr)
 		goto out;
 
-	tr->id = id;
+	tr->id = bpf_tramp_id_get(id);
 	INIT_HLIST_NODE(&tr->hlist);
 	hlist_add_head(&tr->hlist, head);
 	refcount_set(&tr->refcnt, 1);
@@ -592,6 +601,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * multiple rcu callbacks.
 	 */
 	hlist_del(&tr->hlist);
+	bpf_tramp_id_put(tr->id);
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
@@ -663,7 +673,7 @@ void bpf_tramp_detach(struct bpf_tramp_attach *attach)
 	hlist_for_each_entry_safe(node, n, &attach->nodes, hlist_attach)
 		node_free(node);
 
-	bpf_tramp_id_free(attach->id);
+	bpf_tramp_id_put(attach->id);
 	kfree(attach);
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d56d43489aa..6a87180ac2bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14001,7 +14001,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 
 	attach = bpf_tramp_attach(id, tgt_prog, prog);
 	if (IS_ERR(attach)) {
-		bpf_tramp_id_free(id);
+		bpf_tramp_id_put(id);
 		return PTR_ERR(attach);
 	}
 
-- 
2.31.1

