Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949F662AF67
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 00:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKOX04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 18:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiKOX0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 18:26:34 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9E27908
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 15:26:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f18so7061825ejz.5
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 15:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DY++N/b93BxdltXMTeLdUPgzPkCVBFPWyIHIT+cRgeQ=;
        b=UfLpknoHmLMzJZwKQ0I/rchQv4UdGcbstofMOgR3/JRLKdD3mAfexK6TFqArJ1aVLd
         AkbA9FI7twN6R5Bf+1wqFhirLiCG+cBApyGM5TPp+VZknPfwCL8zR75eVR71GRB8Qo24
         t/m1UTe21EKBTJVY9LTr8kUx3fd9cT/L5BCD/1JFpnKyQXduvEN0I9We3BuOUHoduWEJ
         wlUNmgO2kNXat+N6veY4hGr2kFl4jwmOHAJdXb232ah6Rl9v+Guo0cQwPJm39VznlKD1
         vVTZurhQn3OrvqnAAx6802UIUtelimet+Cg3dAbegcTBxhpKUZDNTnaXgY+A29/wanCz
         Xm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY++N/b93BxdltXMTeLdUPgzPkCVBFPWyIHIT+cRgeQ=;
        b=FU1Emhzt53i959MkbzAsB3AthuZfIC/09Bo3LNcHWr4KsLxFR7/lG18/0sZwOxcIaQ
         2wCGlpMLF+n8BeQ4nWWXrGW5awrHBhFWSOU+QjIgdo0Zmk0fDIZRjqHry+AwWLC3OX4T
         apF7Yw2mxY+GVk7wAxuvld43+ZhTvNmyWcn9TVjAUewgG3+DHhHuSIuTdCAJyUh2ZepA
         qWg5Vt3RXI3ya66OaOl05QNtwYhHgCpFRHbgLfdrSAi0mmRZ8GgTxk9dWoCWzZDIf7Ch
         nOWeYkcAC7Z/joQAQOwZ8Iqvo9cJgE8sMpLLsC/DJzn3TeDcuBGfYAXXbrGSaMaEZSM1
         ymvA==
X-Gm-Message-State: ANoB5pk2Bx2rFaubxgKsX2ApcECyZs53oAG1SjemvYGhsEEUGjDxClcI
        PRgCNnD8rMyqiLCnzEBqTys=
X-Google-Smtp-Source: AA0mqf7IZ9q1lqJm7/yPihcbLxDnHT5VMy7I5LfhDM+o3Khg484ZdDpTKwoCcvwDggcR6tY8jKHFXQ==
X-Received: by 2002:a17:906:3e05:b0:78d:aaf9:7b8c with SMTP id k5-20020a1709063e0500b0078daaf97b8cmr16155052eji.229.1668554791006;
        Tue, 15 Nov 2022 15:26:31 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id la8-20020a170907780800b00781b589a1afsm6110483ejc.159.2022.11.15.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:26:30 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 16 Nov 2022 00:26:28 +0100
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC bpf-next] bpf: Fix perf bpf event and audit prog id logging
Message-ID: <Y3QgJMsknnAvvYqU@krava>
References: <20221115095043.1249776-1-jolsa@kernel.org>
 <4d91b1d3-3ffc-11f9-50a6-bfb503e4b3cd@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d91b1d3-3ffc-11f9-50a6-bfb503e4b3cd@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 01:49:54PM +0100, Daniel Borkmann wrote:
> On 11/15/22 10:50 AM, Jiri Olsa wrote:
> > hi,
> > perf_event_bpf_event and bpf_audit_prog calls currently report zero
> > program id for unload path.
> > 
> > It's because of the [1] change moved those audit calls into work queue
> > and they are executed after the id is zeroed in bpf_prog_free_id.
> > 
> > I originally made a change that added 'id_audit' field to struct
> > bpf_prog, which would be initialized as id, untouched and used
> > in audit callbacks.
> > 
> > Then I realized we might actually not need to zero prog->aux->id
> > in bpf_prog_free_id. It seems to be called just once on release
> > paths. Tests seems ok with that.
> > 
> > thoughts?
> > 
> > thanks,
> > jirka
> > 
> > 
> > [1] d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> > ---
> >   kernel/bpf/syscall.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index fdbae52f463f..426529355c29 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1991,7 +1991,6 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
> >   		__acquire(&prog_idr_lock);
> >   	idr_remove(&prog_idr, prog->aux->id);
> > -	prog->aux->id = 0;
> 
> This would trigger a race when offloaded progs are used, see also ad8ad79f4f60 ("bpf:
> offload: free program id when device disappears"). __bpf_prog_offload_destroy() calls
> it, and my read is that later bpf_prog_free_id() then hits the early !prog->aux->id
> return path. Is there a reason for irq context to not defer the bpf_prog_free_id()?

there's comment saying:
  /* bpf_prog_free_id() must be called first */

it was added together with the BPF_(PROG|MAP)_GET_NEXT_ID api:
  34ad5580f8f9 bpf: Add BPF_(PROG|MAP)_GET_NEXT_ID command

Martin, any idea?

while looking on this I noticed we can remove the do_idr_lock argument
(patch below) because it's always true and I think we need to upgrade
all the prog_idr_lock locks to spin_lock_irqsave because bpf_prog_put
could be called from irq context because of d809e134be7a

thanks,
jirka


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 49f9d2bec401..50c71ce698d0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1761,7 +1761,7 @@ void bpf_prog_inc(struct bpf_prog *prog);
 struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
 
-void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
+void bpf_prog_free_id(struct bpf_prog *prog);
 void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
 
 struct btf_field *btf_record_find(const struct btf_record *rec,
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 13e4efc971e6..327dab644200 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -217,7 +217,7 @@ static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
 		offload->offdev->ops->destroy(prog);
 
 	/* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
-	bpf_prog_free_id(prog, true);
+	bpf_prog_free_id(prog);
 
 	list_del_init(&offload->offloads);
 	kfree(offload);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fdbae52f463f..9b929d8ab06d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1973,7 +1973,7 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
 	return id > 0 ? 0 : id;
 }
 
-void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
+void bpf_prog_free_id(struct bpf_prog *prog)
 {
 	unsigned long flags;
 
@@ -1985,18 +1985,12 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
 	if (!prog->aux->id)
 		return;
 
-	if (do_idr_lock)
-		spin_lock_irqsave(&prog_idr_lock, flags);
-	else
-		__acquire(&prog_idr_lock);
+	spin_lock_irqsave(&prog_idr_lock, flags);
 
 	idr_remove(&prog_idr, prog->aux->id);
 	prog->aux->id = 0;
 
-	if (do_idr_lock)
-		spin_unlock_irqrestore(&prog_idr_lock, flags);
-	else
-		__release(&prog_idr_lock);
+	spin_unlock_irqrestore(&prog_idr_lock, flags);
 }
 
 static void __bpf_prog_put_rcu(struct rcu_head *rcu)
@@ -2048,7 +2042,7 @@ static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
 
 	if (atomic64_dec_and_test(&aux->refcnt)) {
 		/* bpf_prog_free_id() must be called first */
-		bpf_prog_free_id(prog, do_idr_lock);
+		bpf_prog_free_id(prog);
 
 		if (in_irq() || irqs_disabled()) {
 			INIT_WORK(&aux->work, bpf_prog_put_deferred);
