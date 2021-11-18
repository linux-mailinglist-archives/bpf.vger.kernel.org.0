Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E524B455A39
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbhKRLad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343899AbhKRL3F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XypHiVckCtchSMS5k0zGXWKdvhQKbyQpumDiEMgd5B4=;
        b=BHb6zgQHf/ZzgH5m9Xl9VxPP0jsWElEhylqJPQNuRTIJCr9uBlm8iukF86AdNZDwOjYe+6
        tOrvFRGz66dDgo6K1L85c0s9Ebk6nQTPyCmyHGvr3OUonG6ADjjUaruaBE2nXpHGoRItVh
        Ju9KuDiT5JOajaJiTZrlMk57SH3DSyY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-w3ry05QHNR-zriLeRl_1Dg-1; Thu, 18 Nov 2021 06:26:04 -0500
X-MC-Unique: w3ry05QHNR-zriLeRl_1Dg-1
Received: by mail-ed1-f69.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so5006255edw.6
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XypHiVckCtchSMS5k0zGXWKdvhQKbyQpumDiEMgd5B4=;
        b=mlYvTkr0mVo2dwuSUPxRThnzEjw4SRh3Un2dYLMF9n0OGjOTfsStbVzhmvYr33STGf
         JcoHZo/+5ws0lCAn1oLAlgqteiaQgtq6bbeJSjVTVA7I/PU3VDRmeWfB6wBDqCzwsQ7t
         Kl0peFECE6Qfp8eTquFskHJ7cClHui4WVRhZXcQnVhnfDIjjyssJFcPEO250AwSx3Gam
         +KrdUukzGpx7Twl6X2YEG542nM8uAcgC8km4XIkk0rZF5EhOoq+crzONK5vcNGA7didF
         SavACx9dv0d0eykRmNabHWoY0QI1o+LsArZd74tR6RW7k09aCBEyB6GDV9ItuQOq/Po+
         Qf7w==
X-Gm-Message-State: AOAM532hDMxgfhyBb5FkX9MafzyG9iZpHB0VD/tcMqK7NKrf/nmqrxjU
        oueDNxbLXRMTdU4L60BNrtQuhmDI8dkzT1NDwEEMNx1ddnnJSJD9CxcArF21fAo2/V8ZQHgNqXE
        BWQWjtUOof8Sx
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr32075647ejb.144.1637234763253;
        Thu, 18 Nov 2021 03:26:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBQI73h/Vg62/lRu8DgzrcfesdyULZXRPaNgUlfBPzFYq2vuDj6EuY7Fwvl9ivPQRcK8lGHw==
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr32075597ejb.144.1637234763001;
        Thu, 18 Nov 2021 03:26:03 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id s3sm1146445ejm.49.2021.11.18.03.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:26:02 -0800 (PST)
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
Subject: [PATCH bpf-next 11/29] bpf: Add addr to bpf_trampoline_id object
Date:   Thu, 18 Nov 2021 12:24:37 +0100
Message-Id: <20211118112455.475349-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding addr to bpf_trampoline_id object so it's not associated
directly with trampoline directly. This will help us to easily
support multiple ids/addresses support for trampolines coming
in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  4 ++--
 kernel/bpf/trampoline.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2ce8b1c49af7..c57141a76e7b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -674,6 +674,7 @@ struct bpf_tramp_image {
 struct bpf_tramp_id {
 	u32 obj_id;
 	u32 btf_id;
+	void *addr;
 };
 
 struct bpf_trampoline {
@@ -685,11 +686,10 @@ struct bpf_trampoline {
 	struct bpf_tramp_id *id;
 	struct {
 		struct btf_func_model model;
-		void *addr;
 		bool ftrace_managed;
 	} func;
 	/* if !NULL this is BPF_PROG_TYPE_EXT program that extends another BPF
-	 * program by replacing one of its functions. func.addr is the address
+	 * program by replacing one of its functions. id->addr is the address
 	 * of the function it replaced.
 	 */
 	struct bpf_prog *extension_prog;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ae2573c36653..e19c5112be67 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -136,7 +136,7 @@ static int bpf_trampoline_module_get(struct bpf_trampoline *tr)
 	int err = 0;
 
 	preempt_disable();
-	mod = __module_text_address((unsigned long) tr->func.addr);
+	mod = __module_text_address((unsigned long) tr->id->addr);
 	if (mod && !try_module_get(mod))
 		err = -ENOENT;
 	preempt_enable();
@@ -164,7 +164,7 @@ static int is_ftrace_location(void *ip)
 
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
-	void *ip = tr->func.addr;
+	void *ip = tr->id->addr;
 	int ret;
 
 	if (tr->func.ftrace_managed)
@@ -179,7 +179,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 
 static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr)
 {
-	void *ip = tr->func.addr;
+	void *ip = tr->id->addr;
 	int ret;
 
 	if (tr->func.ftrace_managed)
@@ -192,7 +192,7 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 /* first time registering */
 static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 {
-	void *ip = tr->func.addr;
+	void *ip = tr->id->addr;
 	int ret;
 
 	ret = is_ftrace_location(ip);
@@ -410,7 +410,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
 					  &tr->func.model, flags, tprogs,
-					  tr->func.addr);
+					  tr->id->addr);
 	if (err < 0)
 		goto out;
 
@@ -478,7 +478,7 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
 			goto out;
 		}
 		tr->extension_prog = prog;
-		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
+		err = bpf_arch_text_poke(tr->id->addr, BPF_MOD_JUMP, NULL,
 					 prog->bpf_func);
 		goto out;
 	}
@@ -513,7 +513,7 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
 	mutex_lock(&tr->mutex);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
-		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
+		err = bpf_arch_text_poke(tr->id->addr, BPF_MOD_JUMP,
 					 tr->extension_prog->bpf_func, NULL);
 		tr->extension_prog = NULL;
 		goto out;
@@ -536,11 +536,11 @@ struct bpf_trampoline *bpf_trampoline_get(struct bpf_tramp_id *id,
 		return NULL;
 
 	mutex_lock(&tr->mutex);
-	if (tr->func.addr)
+	if (tr->id->addr)
 		goto out;
 
 	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
-	tr->func.addr = (void *)tgt_info->tgt_addr;
+	tr->id->addr = (void *)tgt_info->tgt_addr;
 out:
 	mutex_unlock(&tr->mutex);
 	return tr;
-- 
2.31.1

