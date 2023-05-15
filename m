Return-Path: <bpf+bounces-517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B143A702DA2
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09481C20AA5
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5288CC8FB;
	Mon, 15 May 2023 13:09:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502CC8F0
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:09:24 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA32706
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e2b2a27ebso11843918a91.3
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684156142; x=1686748142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1zxgFA/RYniDFm8rB33KhKyBx/11A9AN1LlDpM6cgs=;
        b=J3FvBbUK4hwiNEzIybZXWHuVGrN9lHCYMwJTiDP4YOEMOAkVkqz2wV18cy78q6byIh
         g1qDcji+VBztImF9CYKETOSlhLt6ejg1rgRM+mW1eS84nIFE8QgrDwKMfvb/BQ/8s00L
         P7JRaLqFNX4nGlXNf+uTRcS5frszTRXJz9XJOHxW/CcS5rL13pxFNa461R/IqXdFarL/
         ZZq/pvM9QaeTgHZ2RMFH41JzOCcb/5KKbkpHBODeEPyfcC5EtJDWdapNHyfYas1Xo+7/
         DAK2CVcABKqPA0hAs+pRusPV0odrudrHUNWjMW/5RdAJJHRuigFhJkoFwroBkP9/BcYd
         hWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156142; x=1686748142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1zxgFA/RYniDFm8rB33KhKyBx/11A9AN1LlDpM6cgs=;
        b=WVnpwO6bT657HA9KiTulVDTjNZauCFJpOaaxyiOb28AxV4OjkQ/VcHFkA251jQ5xUA
         uRY8j4AyqN/RGbNmU3O46xWHhYW9oSCpJX2S1riUoAE63GGBU+ITktnnKOvPew7rYJMl
         vOOkNI/W4YkhCX8Sx6Tza6ujcCLSME2c35/AJ8oiXwvbfkJdIQDQwD+zFOrKxDEPaJxi
         jrcJjK8N7GHMM+iNY5/uaf4MsJgqdA0Eq08ySCUBo8IF45B7V9kdyoka5Wb7sKbKg/rw
         JdULQleD/4g98j11A/PtODBddjVvJQkddE18jkynMPJ4wrMWs2vZ764MRSHjOTAkkQgB
         C9ow==
X-Gm-Message-State: AC+VfDz8Fb4fsVM1sAQS5zh2Jf8HwvPZeI71PNVFpL10jfTVHoRg31rK
	7Qv4ksoYm4bGfVcPA8yz3O4=
X-Google-Smtp-Source: ACHHUZ6k/fPjLOGfx+8yYH/VY765dpiOneJ4n9Hp7vQA0qbT9D2ztb6+H61I6BIXsrzh2ee63QBYMw==
X-Received: by 2002:a17:90b:ecd:b0:252:a7b3:c24c with SMTP id gz13-20020a17090b0ecd00b00252a7b3c24cmr12698286pjb.20.1684156142061;
        Mon, 15 May 2023 06:09:02 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:991:5400:4ff:fe70:1e06])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001ac2a73dbf2sm13458723pll.291.2023.05.15.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:09:01 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH bpf-next v2 2/3] bpf: Remove bpf trampoline selector
Date: Mon, 15 May 2023 13:08:48 +0000
Message-Id: <20230515130849.57502-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230515130849.57502-1-laoar.shao@gmail.com>
References: <20230515130849.57502-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selector
is only used to indicate how many times the bpf trampoline image are
updated and been displayed in the trampoline ksym name. After the
trampoline is freed, the selector will start from 0 again. So the
selector is a useless value to the user. We can remove it.
If the user want to check whether the bpf trampoline image has been updated
or not, the user can compare the address. Each time the trampoline image
is updated, the address will change consequently.

Jiri pointed out antoher issue that perf is still using the old name
"bpf_trampoline_%lu", so this change can fix the issue in perf.

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
---
 include/linux/bpf.h     |  1 -
 kernel/bpf/trampoline.c | 11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 456f33b..36e4b2d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1125,7 +1125,6 @@ struct bpf_trampoline {
 	int progs_cnt[BPF_TRAMP_MAX];
 	/* Executable image of trampoline */
 	struct bpf_tramp_image *cur_image;
-	u64 selector;
 	struct module *mod;
 };
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2a3849c..78acf28 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -349,7 +349,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 }
 
-static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
+static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_ksym *ksym;
@@ -376,7 +376,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 
 	ksym = &im->ksym;
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
-	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu_%u", key, idx);
+	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu", key);
 	bpf_image_ksym_add(image, ksym);
 	return im;
 
@@ -406,11 +406,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		err = unregister_fentry(tr, tr->cur_image->image);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
-		tr->selector = 0;
 		goto out;
 	}
 
-	im = bpf_tramp_image_alloc(tr->key, tr->selector);
+	im = bpf_tramp_image_alloc(tr->key);
 	if (IS_ERR(im)) {
 		err = PTR_ERR(im);
 		goto out;
@@ -447,8 +446,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 	set_memory_rox((long)im->image, 1);
 
-	WARN_ON(tr->cur_image && tr->selector == 0);
-	WARN_ON(!tr->cur_image && tr->selector);
+	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
 		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
@@ -478,7 +476,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (tr->cur_image)
 		bpf_tramp_image_put(tr->cur_image);
 	tr->cur_image = im;
-	tr->selector++;
 out:
 	/* If any error happens, restore previous flags */
 	if (err)
-- 
1.8.3.1


