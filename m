Return-Path: <bpf+bounces-252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0FE6FCA01
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8691628132D
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325441800E;
	Tue,  9 May 2023 15:15:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532E8BE2
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 15:15:27 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600144AF
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 08:15:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6439df6c268so3507129b3a.0
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645325; x=1686237325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/5w29JDTg92RC5QIzYNc+90Gl1d3HCTz77GiE2o97g=;
        b=MC+naAcWHYH0TxRfsKSe8xbrIcKfRxO/l46Gm7gUfJynAAO2CsXa+6UOaqf80e9kA3
         MrSir8evOqJnfTXT+92D/H4dnAUrPb8oXWdcgFxnmu65nUQSK4Sa/REBQR4MfVFaBEm4
         Na90EIZei1g76+f7evVhFh7gvvhvEPM5bgQ+E3FKqxmqvgeltOM2tEJHzFf3Vd2/ebyu
         ZShq70co5FqoFajtsnQ+atbZJ7M7x3ON9GpdaxqwKi22DjrvEkMkE6z1nmalPItTICG0
         FAr8MjKu8cUefxLT9TnAqTeVgThd1SD0ROm09MUFg7GfBRvR8nxeCHQlsO+jmAtyF2nZ
         OCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645325; x=1686237325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/5w29JDTg92RC5QIzYNc+90Gl1d3HCTz77GiE2o97g=;
        b=Oxs3TUywJ5h82WTbaMx1q55c638lj0wl/GYih3JSik98UypNkcB7b5qwxaY5AwU21X
         00u4yACjrbEQ6nNzyiae2p90iYBzwmyrYkmcfftYgZDmhK3KSi/t5RD1vCXOY9EdiNd7
         WQTTWxrQw61Sa4LRF2vtXApKUo6y5MNOoRaUToFgX+U/OfI5V5xm8ZJScn9U33llODxd
         O0gPyZ3vzMUpySucHgAGymBcGAy39iFHVz1LBX6mZ2NuQtucILl92JxVm7/6s+sugscz
         KlxOKLttkCex9vv4n9+JvXPr9x3mYEbYwIpsmN3YtiuGcNHXQEKDZhnCfmrNsUTXqyLS
         HSNQ==
X-Gm-Message-State: AC+VfDxwalr40n7LFtPao781AaDalSTMCTcp0e9O3FbXglaG9RTaCdL/
	okjiKtt+2b67Rqb7HvKGo9A=
X-Google-Smtp-Source: ACHHUZ4g9z93NaWG2ZQ5Yuur3DXy4+Ljhqia/Tb0IusIXrnMI2gexFr0o4/nY85mwuF2U3+MO377XQ==
X-Received: by 2002:a17:903:41ca:b0:1a6:abac:9cc with SMTP id u10-20020a17090341ca00b001a6abac09ccmr17391496ple.66.1683645324675;
        Tue, 09 May 2023 08:15:24 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001aafc8cea5fsm1706349plo.148.2023.05.09.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:15:24 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] bpf: Show total linked progs cnt instead of selector in trampoline ksym
Date: Tue,  9 May 2023 15:15:11 +0000
Message-Id: <20230509151511.3937-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230509151511.3937-1-laoar.shao@gmail.com>
References: <20230509151511.3937-1-laoar.shao@gmail.com>
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
trampoline is freed, the count will start from 0 again.
So the count is a useless value to the user, we'd better
show a more meaningful value like how many progs are linked to this
trampoline. After that change, the selector can be removed eventally.
If the user want to check whether the bpf trampoline image has been updated
or not, the user can also compare the address. Each time the trampoline
image is updated, the address will change consequently.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h     | 1 -
 kernel/bpf/trampoline.c | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

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
index 7067cdf..be37d87 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -410,11 +410,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		err = unregister_fentry(tr, tr->cur_image->image);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
-		tr->selector = 0;
 		goto out;
 	}
 
-	im = bpf_tramp_image_alloc(tr->key, tr->selector);
+	im = bpf_tramp_image_alloc(tr->key, total);
 	if (IS_ERR(im)) {
 		err = PTR_ERR(im);
 		goto out;
@@ -451,8 +450,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 	set_memory_rox((long)im->image, 1);
 
-	WARN_ON(tr->cur_image && tr->selector == 0);
-	WARN_ON(!tr->cur_image && tr->selector);
+	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
 		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
@@ -482,7 +480,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (tr->cur_image)
 		bpf_tramp_image_put(tr->cur_image);
 	tr->cur_image = im;
-	tr->selector++;
 out:
 	/* If any error happens, restore previous flags */
 	if (err)
-- 
1.8.3.1


