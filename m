Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352B9455A47
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbhKRLbp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343993AbhKRL3m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RSrlNmESC/yOXTmaT8HmTuDmJmtanZNQqjhrNcr48I=;
        b=XofaOF7Juy9NXUHKHYtbtn4oSQa+RkEGEwLFhY7pVc1NL4goUD/JepWk0Ave7CWvwrGOMC
        cdT3qttuDMOtnOqLMbOrYOOMBOt+hVDTIXhn1kMXnWjOqG3DC7XL3reDWC0jA4IT2OtAnE
        L2YDdUXARJ0fAhP3ygvMAGBR9JVk2w8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-YiqysoOXOMq9axP5RSWSTg-1; Thu, 18 Nov 2021 06:26:40 -0500
X-MC-Unique: YiqysoOXOMq9axP5RSWSTg-1
Received: by mail-ed1-f69.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso4983981edb.11
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RSrlNmESC/yOXTmaT8HmTuDmJmtanZNQqjhrNcr48I=;
        b=P2/oUHF8ycaoMyyIXIZkWWSHKhveuJpw1WOdOx1wA382JfQjkMAbaT6luBdLI5KaxD
         cXD2iOdtA4xFfJmkntC5DAiVrtIUFbiCK21U2tg+lK8ZfjeQ7lDFTIfyJGS3ql9PM8y+
         0baBQqg20m7I+tPAkpu+AUevfGNFv1m1zN83SqwggHubOTRZ1YbFZPSBEctInO3uS+AS
         HyJnRLJF0v2drnpBJyBcBctAcOb27IVxv3wxj2220DTZig2FDozdCjJyfyMF5WDunYxD
         GzIFLnua7vugpWCZopIwzsTpq8uomZiBjC33fWk7zXcJ5xmP5iHv3V4oNwv0EUAeSnzr
         plmQ==
X-Gm-Message-State: AOAM531ct3J/mvyidu+1zI7cOeg95WvtV+R8rVOMENXRHQlYf/2Dw7gi
        cYK+Wx48kyqDtfc3jPT80ftL+YJ71/r0uBtWZEN1RyVBFLvWgPHkC3L5M/UBckFfTsLRBvT6cAf
        +gthhzCgnOfZE
X-Received: by 2002:a17:907:6287:: with SMTP id nd7mr32143151ejc.152.1637234799197;
        Thu, 18 Nov 2021 03:26:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfgptxV/yt6rQtMUYJJlBglJe4JjttXNxcM3GrqP3qFWIlFIoxdWI3k6g3rjJEHp1aYxDTeA==
X-Received: by 2002:a17:907:6287:: with SMTP id nd7mr32143126ejc.152.1637234799060;
        Thu, 18 Nov 2021 03:26:39 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id e16sm1706157edz.18.2021.11.18.03.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:26:38 -0800 (PST)
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
Subject: [PATCH bpf-next 17/29] bpf: Resolve id in bpf_tramp_id_single
Date:   Thu, 18 Nov 2021 12:24:43 +0100
Message-Id: <20211118112455.475349-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving the id resolving in the bpf_tramp_id_single function
so it's centralized together with the trampoline's allocation
and init.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  3 ++-
 kernel/bpf/syscall.c    | 21 ++++++---------------
 kernel/bpf/trampoline.c | 18 +++++++++++++++---
 kernel/bpf/verifier.c   |  4 +---
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 894ee812e213..dda24339e4b1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -756,7 +756,8 @@ void bpf_tramp_id_free(struct bpf_tramp_id *id);
 bool bpf_tramp_id_is_empty(struct bpf_tramp_id *id);
 int bpf_tramp_id_is_equal(struct bpf_tramp_id *a, struct bpf_tramp_id *b);
 struct bpf_tramp_id *bpf_tramp_id_single(const struct bpf_prog *tgt_prog,
-					 struct btf *btf, u32 btf_id);
+					 struct bpf_prog *prog, u32 btf_id,
+					 struct bpf_attach_target_info *tgt_info);
 int bpf_trampoline_link_prog(struct bpf_tramp_node *node, struct bpf_trampoline *tr);
 int bpf_trampoline_unlink_prog(struct bpf_tramp_node *node, struct bpf_trampoline *tr);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8109b0fc7d2f..0acf6cb0fdc7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2773,9 +2773,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			goto out_put_prog;
 		}
 
-		id = bpf_tramp_id_single(tgt_prog, NULL, btf_id);
-		if (!id) {
-			err = -ENOMEM;
+		id = bpf_tramp_id_single(tgt_prog, prog, btf_id, NULL);
+		if (IS_ERR(id)) {
+			err = PTR_ERR(id);
 			goto out_put_prog;
 		}
 	}
@@ -2828,9 +2828,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		}
 
 		btf_id = prog->aux->attach_btf_id;
-		id = bpf_tramp_id_single(NULL, prog->aux->attach_btf, btf_id);
-		if (!id) {
-			err = -ENOMEM;
+		id = bpf_tramp_id_single(NULL, prog, btf_id, NULL);
+		if (IS_ERR(id)) {
+			err = PTR_ERR(id);
 			goto out_unlock;
 		}
 	}
@@ -2842,15 +2842,6 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * different from the destination specified at load time, we
 		 * need a new trampoline and a check for compatibility
 		 */
-		struct bpf_attach_target_info tgt_info = {};
-
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
-					      &tgt_info);
-		if (err)
-			goto out_unlock;
-
-		id->addr[0] = (void *) tgt_info.tgt_addr;
-
 		attach = bpf_tramp_attach(id, tgt_prog, prog);
 		if (IS_ERR(attach)) {
 			err = PTR_ERR(attach);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 4a4ef9396b7e..e6a73088ecee 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -105,18 +105,30 @@ struct bpf_tramp_id *bpf_tramp_id_alloc(u32 max)
 }
 
 struct bpf_tramp_id *bpf_tramp_id_single(const struct bpf_prog *tgt_prog,
-					 struct btf *btf, u32 btf_id)
+					 struct bpf_prog *prog, u32 btf_id,
+					 struct bpf_attach_target_info *tgt_info)
 {
 	struct bpf_tramp_id *id;
 
+	if (!tgt_info) {
+		struct bpf_attach_target_info __tgt_info = {};
+		int err;
+
+		tgt_info = &__tgt_info;
+		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+					     tgt_info);
+		if (err)
+			return ERR_PTR(err);
+	}
 	id = bpf_tramp_id_alloc(1);
 	if (!id)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	if (tgt_prog)
 		id->obj_id = tgt_prog->aux->id;
 	else
-		id->obj_id = btf_obj_id(btf);
+		id->obj_id = btf_obj_id(prog->aux->attach_btf);
 	id->id[0] = btf_id;
+	id->addr[0] = (void *) tgt_info->tgt_addr;
 	id->cnt = 1;
 	return id;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9914487f2281..8d56d43489aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13995,12 +13995,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	id = bpf_tramp_id_single(NULL, prog->aux->attach_btf, btf_id);
+	id = bpf_tramp_id_single(tgt_prog, prog, btf_id, &tgt_info);
 	if (!id)
 		return -ENOMEM;
 
-	id->addr[0] = (void *) tgt_info.tgt_addr;
-
 	attach = bpf_tramp_attach(id, tgt_prog, prog);
 	if (IS_ERR(attach)) {
 		bpf_tramp_id_free(id);
-- 
2.31.1

