Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F404644E2C
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 22:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLFVo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 16:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiLFVoY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 16:44:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA72E9DB;
        Tue,  6 Dec 2022 13:44:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so19271481pje.5;
        Tue, 06 Dec 2022 13:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVHwH0VKlT9ImQq/qr6fMoMnZ6eF5jNSaI5hlJKoSSo=;
        b=OwJexiggMym4osrXLBMkrG6EExJXHvJ1fijFdCIdC5V3ivr9AAbWGOYWvXzKJyhEfZ
         uJrHNVi8pZKMdDY2jI0YbD8HDRrFteuub5lMHF+iLFTt+PvOH5k6v4MZ9U8cn1oVXr7g
         M0fBBdiAI4HdI8+ZPVhu2t6xZKrYSnkaAwMPICJfLusWi9FmbWkjrmemelxZx0D3fpW/
         ePKS0hygKFWbnMMvGnBo4pQQ8NyySETotE1+HJkB+oWDXSgnuoUaqtmc0yQRpxLT3VNd
         vgTGg+dr7M96Y/ZkMsJ0AowtbLnqNuFvPFj2RcohOhGxDrx9C86+jrJmqICfIi1+GOYH
         8pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVHwH0VKlT9ImQq/qr6fMoMnZ6eF5jNSaI5hlJKoSSo=;
        b=B3P4fQQOz5uV9ScWoPKG4sySDLbGLGgias9jC79Qawe0B3eOxnmGcOOX1VzRqz2Rns
         ZOAAXHGsvQ8RgUZbw1Ji51fWgKOuXmccZgGZZfPpGtcTU4UsIU9/JT+mjuXeqH0cXC4h
         FGfLL7J3Vq3mT5fD4d1YcKYo2jCHld0MlA52JyGAZCZQEvVGE6lx4yoXoUq8/vE3Pov2
         BwR3xtlP1VjSK46JDTP2qO/YiSvWCrFFdZ1e84DWcfUK4oOTcc4hCiBo/gM0cra+iaJX
         apSIeIHsifSAPUP3sCKWdK+zEDINkJM3O6em5reISVlj5ow5YQepT+shS3Caa9JumNzX
         ObXQ==
X-Gm-Message-State: ANoB5pmO3Kk1tmUlTueBUDVZ/+c4ABUszMkSBjOjD5iSgj4N7rioElmU
        AOZ7FhTcHCWQRtyE+29NCs8=
X-Google-Smtp-Source: AA0mqf4TKhnS7faYeNbd5hQ7hKecwEzkkQsTsDwcJE7Kg84few/gNg8jE3MyWv545wHBJKxbar5ISg==
X-Received: by 2002:a17:902:a718:b0:189:7722:99d7 with SMTP id w24-20020a170902a71800b00189772299d7mr51224854plq.96.1670363061785;
        Tue, 06 Dec 2022 13:44:21 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:841a])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b0018980f14ecfsm13212827plx.115.2022.12.06.13.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:44:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Dec 2022 11:44:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y4+3sw9wEUKJ0zh4@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-15-tj@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:56PM -1000, Tejun Heo wrote:
> +	/**
> +	 * dispatch - Dispatch tasks from the BPF scheduler into dsq's
> +	 * @cpu: CPU to dispatch tasks for
> +	 * @prev: previous task being switched out
> +	 *
> +	 * Called when a CPU can't find a task to execute after ops.consume().
> +	 * The operation should dispatch one or more tasks from the BPF
> +	 * scheduler to the dsq's using scx_bpf_dispatch(). The maximum number
> +	 * of tasks which can be dispatched in a single call is specified by the
> +	 * @dispatch_max_batch field of this struct.
> +	 */
> +	void (*dispatch)(s32 cpu, struct task_struct *prev);
> +
> +	/**
> +	 * consume - Consume tasks from the dsq's to the local dsq for execution
> +	 * @cpu: CPU to consume tasks for
> +	 *
> +	 * Called when a CPU's local dsq is empty. The operation should transfer
> +	 * one or more tasks from the dsq's to the CPU's local dsq using
> +	 * scx_bpf_consume(). If this function fails to fill the local dsq,
> +	 * ops.dispatch() will be called.
> +	 *
> +	 * This operation is unnecessary if the BPF scheduler always dispatches
> +	 * either to one of the local dsq's or the global dsq. If implemented,
> +	 * this operation is also responsible for consuming the global_dsq.
> +	 */
> +	void (*consume)(s32 cpu);
> +
> +	/**
> +	 * consume_final - Final consume call before going idle
> +	 * @cpu: CPU to consume tasks for
> +	 *
> +	 * After ops.consume() and .dispatch(), @cpu still doesn't have a task
> +	 * to execute and is about to go idle. This operation can be used to
> +	 * implement more aggressive consumption strategies. Otherwise
> +	 * equivalent to ops.consume().
> +	 */
> +	void (*consume_final)(s32 cpu);

Doesn't really change the big picture but I ended up merging
ops.consume[_final]() into ops.dispatch() which should make the dispatch
path both simpler and more flexible.

Thanks.

-- 
tejun
