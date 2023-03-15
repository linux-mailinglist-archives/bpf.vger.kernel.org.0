Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F86BBECD
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 22:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCOVSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 17:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCOVSi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 17:18:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E9A3B76;
        Wed, 15 Mar 2023 14:17:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4262176pjc.1;
        Wed, 15 Mar 2023 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678915074;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSX/fEnnalVAeOYQThdq5TF63kgG4Qs/Ci0lR/INyEk=;
        b=LtUsLt4Mz28poV022GnTaIe+/PdE8Eq3nNhevRm97TD4b3ySchsu0lWV36DgCzwISe
         D48dNf1tDZ2M1Ifba+03CskzrYf1ovpvfCTsdp8Bxgtmg5YwAAuEVHD5VTMsUNGqsZ+R
         PEvltDh7inWIZarmGXOFND0r3Z4nq4n+AUl6N5kDSbdrsxfyDwx8FlqmP2/n2WPFPcOu
         gUE0zXkDqJphNm7bTzspGnjvD0vuz2CMexXpP0kN2K1ey+w6/oMnblD6aSh0JwFUU0DX
         7SkeoeQKw+05T0OVxe/d6uN8GwSBh+tL5eur8rqK75eJ+SoSlC+sa0BYmng3CKxvY6ne
         DYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915074;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nSX/fEnnalVAeOYQThdq5TF63kgG4Qs/Ci0lR/INyEk=;
        b=FW3o9UC9Y3hO9BAa8SIVqjaGRSo5qQcsfFde3O6fg+MSil6jTgeO0Fx79ZKGCmZ1sI
         BPbghOETiEIWEymeCK15nmR1KqnccofmIEwdTtq8O0q5R90MOMwQUz1UcDbgF9FWSsUI
         NUGdSsltkYODaJoVMxzrT0a3tbEPPxXeWiXCLgQrwqpva7o5GgdNEETDCc0OO4z28Vne
         f/YjG+PyABtEt9Dx0959lT2lWRm9MDWf1GV5nebbBmS4dWMIPHD/VZNxvMRxdaC35OjV
         WFaOVoZTpZ3/6EaaQ4hvHSCkgq1vduHyCtXJVgV3vVQ+Nqu4F+R5pZPoCqqfztnyyXUi
         Al6Q==
X-Gm-Message-State: AO0yUKXpqyODfhEi6fjlf6KkMl+UbyMvTYYf6+X8Agqp0AXt+vy387KC
        yTVHL9XRCbMt0aLxyHaMSX8=
X-Google-Smtp-Source: AK7set+rxgJDU7o23PYQ3njqALfK8HAT6LClLXPp3icfiOHeReVTCwXXzWQBy92RMnG7t6QNNuGy2Q==
X-Received: by 2002:a17:902:f547:b0:19c:a9b8:4349 with SMTP id h7-20020a170902f54700b0019ca9b84349mr1046598plf.32.1678915074441;
        Wed, 15 Mar 2023 14:17:54 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902968e00b001992e74d058sm4099393plp.7.2023.03.15.14.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:17:53 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:17:52 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     starmiku1207184332@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Teng Qi <starmiku1207184332@gmail.com>
Message-ID: <641236007b4ca_63dce208c7@john.notmuch>
In-Reply-To: <20230315041721.1034794-1-starmiku1207184332@gmail.com>
References: <20230315041721.1034794-1-starmiku1207184332@gmail.com>
Subject: RE: [PATCH] kernel: bpf: stackmap: fix a possible sleep-in-atomic bug
 in bpf_mmap_unlock_get_irq_work()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

starmiku1207184332@ wrote:
> From: Teng Qi <starmiku1207184332@gmail.com>
> 
> bpf_mmap_unlock_get_irq_work() and bpf_mmap_unlock_mm() cooperate to safely
> acquire mm->mmap_lock safely. The code in bpf_mmap_unlock_get_irq_work():
>  struct mmap_unlock_irq_work *work = NULL;
>  bool irq_work_busy = false;
>  if (irqs_disabled()) {
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		work = this_cpu_ptr(&mmap_unlock_work);
>  		if (irq_work_is_busy(&work->irq_work)) {
>  			irq_work_busy = true;
>  		}
>  	} else {
>  		irq_work_busy = true;
>  	}
>  }
>  *work_ptr = work;
> 
> shows that the pointer of struct mmap_unlock_irq_work "work" is not NULL if
> irqs_disabled() == true and IS_ENABLED(CONFIG_PREEMPT_RT) == false or NULL in
> other cases. The "work" will be passed to bpf_mmap_unlock_mm() as the argument.
> The code in bpf_mmap_unlock_mm():
>  if (!work) {
>  	mmap_read_unlock(mm);
>  } else {
>  	work->mm = mm;
>  	rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
>  	irq_work_queue(&work->irq_work);
>  }
> 
> shows that mm->mmap_lock is released directly if "work" is NULL. Otherwise,
> irq_work_queue is called to avoid calling mmap_read_unlock() in an irq disabled
> context because of its possible sleep operation. However, mmap_read_unlock()
> is unsafely called in a preempt disabled context when spin_lock() or
> rcu_read_lock() has been called.
> 
> We found that some ebpf helpers that call these two functions may be invoked in
> preempt disabled contexts through various hooks. We can give an example:

Did you get a stack trace we could add to the commit message would be nice
to have.

>  SEC("kprobe/kmem_cache_free")
>  int bpf_prog1(struct pt_regs *ctx)
>  {
>  	char buff[50];
>  	bpf_get_stack(ctx, buff, sizeof(struct bpf_stack_build_id),
> 	              BPF_F_USER_BUILD_ID | BPF_F_USER_STACK);
>  	return 0;
>  }

How about add this as a selftest so we can ensure we keep this working.

> 
> The hook "kprobe/kmem_cache_free" is often called in preempt disabled contexts
> by many modules. To fix this possible bug, we add in_atomic() in
> bpf_mmap_unlock_get_irq_work().
> 
> 
> Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>

And a fixes tag so we get backports correct.

> ---
>  kernel/bpf/mmap_unlock_work.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
> index 5d18d7d85bef..3d472d24d88f 100644
> --- a/kernel/bpf/mmap_unlock_work.h
> +++ b/kernel/bpf/mmap_unlock_work.h
> @@ -26,7 +26,7 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
>  	struct mmap_unlock_irq_work *work = NULL;
>  	bool irq_work_busy = false;
>  
> -	if (irqs_disabled()) {
> +	if (in_atomic() || irqs_disabled()) {
>  		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  			work = this_cpu_ptr(&mmap_unlock_work);
>  			if (irq_work_is_busy(&work->irq_work)) {

Thanks.
