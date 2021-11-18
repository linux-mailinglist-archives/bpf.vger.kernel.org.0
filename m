Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483E455A6C
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbhKRLdD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344064AbhKRLbB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9S+q8pWMDFvdDxjJwU6rYEztkMBIcs++/6oEf507CaQ=;
        b=Vb+xMTJxHjbeB8Gj4fjs3IlfE2QT9MJGWX1nku13PmqMctV28yrMy/eKari0VVL3tR0YIf
        rp7THdUhvB53Cx3PvWjH5VteGKE/XAoyBm2BKu6OD0OHuYVazIWATGWHBUC8/yxbPLGDT8
        bnlcQZxqEq4tEHxnsvpejHxNpic9vGE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-2m0tDZulPEKL7zrIOKd4hg-1; Thu, 18 Nov 2021 06:26:22 -0500
X-MC-Unique: 2m0tDZulPEKL7zrIOKd4hg-1
Received: by mail-ed1-f69.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so5039035edq.3
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9S+q8pWMDFvdDxjJwU6rYEztkMBIcs++/6oEf507CaQ=;
        b=YzAmBNxVrRdJFVu2Yhfa7fFSSZWxK1ZvNzgWq5JRIQlVcaIaDfE7i/x1hUGKU8mxtC
         Ddw1yLtVSHF/whAtgS7w/0FnDdyvbDcU7IECnO0WniqQecTmSCnfPog6M5dqstVWdtLp
         jqrhkyP4OEnL40q29LxNI2/cFJ0R+kVfxsuxenQB8DuvCYWbNI/euNSfV/y56sOEYCiy
         Hsu6nzObomwgLa6X+cZw3ln1JpiF940VgDodPFP3ZeLNRaxzQi+gIa/NQcGzRpaCLBEp
         wNGXqsElgwg9mLw6bpZFsliaKlk0unKFOT8n5TaQulakLt2i6xbzM2mFTfwAe6pBPj3z
         xa8Q==
X-Gm-Message-State: AOAM531oZ2mPlvzZ1LKTmjaHQCqv7MsSI1TjHRMP3IiALAQpiPM3DXDC
        WexzGmkwwrAQSkrOiQUwK0qnryKO9lyp4dXnPl6I8XbmVdQokqZxZwH99rp1TIf2XOwPo+Ihnts
        tHyasytwtaEpC
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr34545054ejc.385.1637234781217;
        Thu, 18 Nov 2021 03:26:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgmIk56biArqymQrAnbeMLfZmEiUWksIFVac/+dL5uyCKQcFWyXprnJ/2JdubpH4kbDMoLgw==
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr34545021ejc.385.1637234781062;
        Thu, 18 Nov 2021 03:26:21 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o12sm1418821edw.84.2021.11.18.03.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:26:20 -0800 (PST)
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
Subject: [PATCH bpf-next 14/29] bpf: Add support to store multiple ids in bpf_tramp_id object
Date:   Thu, 18 Nov 2021 12:24:40 +0100
Message-Id: <20211118112455.475349-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to store multiple ids in bpf_tramp_id object,
to have id for trampolines with multiple functions assigned.

Extra array of u32 values is allocated within bpf_tramp_id
object allocation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  6 ++++--
 kernel/bpf/syscall.c    |  6 +++---
 kernel/bpf/trampoline.c | 39 +++++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c   |  2 +-
 4 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2dbc00904a84..47e25d8be600 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -672,8 +672,10 @@ struct bpf_tramp_image {
 };
 
 struct bpf_tramp_id {
+	u32 max;
+	u32 cnt;
 	u32 obj_id;
-	u32 btf_id;
+	u32 *id;
 	void *addr;
 };
 
@@ -749,7 +751,7 @@ static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	return bpf_func(ctx, insnsi);
 }
 #ifdef CONFIG_BPF_JIT
-struct bpf_tramp_id *bpf_tramp_id_alloc(void);
+struct bpf_tramp_id *bpf_tramp_id_alloc(u32 cnt);
 void bpf_tramp_id_free(struct bpf_tramp_id *id);
 bool bpf_tramp_id_is_empty(struct bpf_tramp_id *id);
 int bpf_tramp_id_is_equal(struct bpf_tramp_id *a, struct bpf_tramp_id *b);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a65c1862ab68..216fcce07326 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2704,7 +2704,7 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 
 	info->tracing.attach_type = tr_link->attach_type;
 	info->tracing.target_obj_id = attach->id->obj_id;
-	info->tracing.target_btf_id = attach->id->btf_id;
+	info->tracing.target_btf_id = attach->id->id[0];
 
 	return 0;
 }
@@ -2766,7 +2766,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			goto out_put_prog;
 		}
 
-		id = bpf_tramp_id_alloc();
+		id = bpf_tramp_id_alloc(1);
 		if (!id) {
 			err = -ENOMEM;
 			goto out_put_prog;
@@ -2829,7 +2829,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			goto out_unlock;
 		}
 
-		id = bpf_tramp_id_alloc();
+		id = bpf_tramp_id_alloc(1);
 		if (!id) {
 			err = -ENOMEM;
 			goto out_unlock;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 16fc4c14319b..d65f463c532d 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -60,27 +60,45 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
+static bool bpf_tramp_id_is_multi(struct bpf_tramp_id *id)
+{
+	return id->cnt > 1;
+}
+
 static u64 bpf_tramp_id_key(struct bpf_tramp_id *id)
 {
-	return ((u64) id->obj_id << 32) | id->btf_id;
+	if (bpf_tramp_id_is_multi(id))
+		return (u64) &id;
+	else
+		return ((u64) id->obj_id << 32) | id->id[0];
 }
 
 bool bpf_tramp_id_is_empty(struct bpf_tramp_id *id)
 {
-	return !id || (!id->obj_id && !id->btf_id);
+	return !id || id->cnt == 0;
 }
 
 int bpf_tramp_id_is_equal(struct bpf_tramp_id *a,
 			  struct bpf_tramp_id *b)
 {
-	return !memcmp(a, b, sizeof(*a));
+	return a->obj_id == b->obj_id && a->cnt == b->cnt &&
+	       !memcmp(a->id, b->id, a->cnt * sizeof(*a->id));
 }
 
-struct bpf_tramp_id *bpf_tramp_id_alloc(void)
+struct bpf_tramp_id *bpf_tramp_id_alloc(u32 max)
 {
 	struct bpf_tramp_id *id;
 
-	return kzalloc(sizeof(*id), GFP_KERNEL);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (id) {
+		id->id = kzalloc(sizeof(u32) * max, GFP_KERNEL);
+		if (!id->id) {
+			kfree(id);
+			return NULL;
+		}
+		id->max = max;
+	}
+	return id;
 }
 
 void bpf_tramp_id_init(struct bpf_tramp_id *id,
@@ -91,11 +109,15 @@ void bpf_tramp_id_init(struct bpf_tramp_id *id,
 		id->obj_id = tgt_prog->aux->id;
 	else
 		id->obj_id = btf_obj_id(btf);
-	id->btf_id = btf_id;
+	id->id[0] = btf_id;
+	id->cnt = 1;
 }
 
 void bpf_tramp_id_free(struct bpf_tramp_id *id)
 {
+	if (!id)
+		return;
+	kfree(id->id);
 	kfree(id);
 }
 
@@ -362,7 +384,8 @@ bpf_tramp_image_alloc(struct bpf_tramp_id *id, u32 idx)
 	ksym = &im->ksym;
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
 	key = bpf_tramp_id_key(id);
-	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu_%u", key, idx);
+	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu_%u%s", key, idx,
+		 bpf_tramp_id_is_multi(id) ? "_multi" : "");
 	bpf_image_ksym_add(image, ksym);
 	return im;
 
@@ -597,7 +620,7 @@ struct bpf_tramp_attach *bpf_tramp_attach(struct bpf_tramp_id *id,
 	if (!node)
 		goto out;
 
-	err = bpf_check_attach_model(prog, tgt_prog, id->btf_id, &tr->func.model);
+	err = bpf_check_attach_model(prog, tgt_prog, id->id[0], &tr->func.model);
 	if (err)
 		goto out;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e05f39fd2708..1903d5d256b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13995,7 +13995,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	id = bpf_tramp_id_alloc();
+	id = bpf_tramp_id_alloc(1);
 	if (!id)
 		return -ENOMEM;
 
-- 
2.31.1

