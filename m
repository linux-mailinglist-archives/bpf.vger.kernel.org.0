Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8205F377D
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJCVLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 17:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJCVK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 17:10:27 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748018399;
        Mon,  3 Oct 2022 14:06:52 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id c11so7123648qtw.8;
        Mon, 03 Oct 2022 14:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZGTTcZ0p1fzzxUfCEqF3LCRMtlu9C10pzfekPEtmBr4=;
        b=V0EzfOQuDKunHPZKWULEd7KvJ/uLmWGKN5jAd5f6IWeC+ZSEFozJZniRBptr4SeW2h
         EJUtKsCuWts/zJie8c7mOeEQ2Xpx3S5QSURlubhm21cKClHPvX7/kEnZFTnbz+wHUqKs
         9l6MSXCnnVJIOHAYvIv1fbrKVSIw4fVwVjB/c8tvZPDpqryc0sqodZF0I++lamxm0/gI
         wGQmmQ1gA41DG7Vk0B7r0SzZJm7EXMnoLQ1OSB05ssVLzOEIf9nufl7sFruZIoZ/V5aR
         98OjA6zsYxNUPFNzMAL/ehzkN5ahcJoqRtROkckZ1j5B7+yCGwfBdwbqRvHFil4Z7Usy
         JR0A==
X-Gm-Message-State: ACrzQf0xtfbl/ndW8mSKZkH9Wwa9SGL0AeAeVYrM0yesI+zeVb/JpZmp
        vPu6taE7qF3Q8LedwdNjJ6c=
X-Google-Smtp-Source: AMsMyM5M8rqeL0NiM6ILOoCc4c0nPBBhT9Gh2GTAgZ0fOIeWVxZioGZ+g1VYRrL6YJ3TBdYMcZndtg==
X-Received: by 2002:ac8:5816:0:b0:35b:ad30:3297 with SMTP id g22-20020ac85816000000b0035bad303297mr17407493qtg.0.1664831211164;
        Mon, 03 Oct 2022 14:06:51 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::59bd])
        by smtp.gmail.com with ESMTPSA id e5-20020ac84e45000000b0035ccd148026sm10536232qtw.69.2022.10.03.14.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 14:06:50 -0700 (PDT)
Date:   Mon, 3 Oct 2022 16:06:57 -0500
From:   David Vernet <void@manifault.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        memxor@gmail.com
Subject: Re: [PATCH v2 1/2] bpf: Add kfuncs for storing struct task_struct *
 as a kptr
Message-ID: <YztO8Y07s12+iVh1@maniforge.dhcp.thefacebook.com>
References: <20221001144716.3403120-1-void@manifault.com>
 <20221001144716.3403120-2-void@manifault.com>
 <b27deaa1-7ab2-a969-3475-4fa78db34f86@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27deaa1-7ab2-a969-3475-4fa78db34f86@linux.dev>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 03, 2022 at 12:20:57PM -0700, Martin KaFai Lau wrote:
> On 10/1/22 7:47 AM, David Vernet wrote:
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index b069517a3da0..36cbe1b8f8b1 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1700,20 +1700,93 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >   	}
> >   }
> > -BTF_SET8_START(tracing_btf_ids)
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in vmlinux BTF");
> > +
> > +/**
> > + * bpf_task_acquire - Acquire a reference to a task. A task acquired by this
> > + * kfunc which is not stored in a map as a kptr, must be released by calling
> > + * bpf_task_release().
> > + * @p: The task on which a reference is being acquired.
> > + */
> > +__used noinline
> > +struct task_struct *bpf_task_acquire(struct task_struct *p)
> > +{
> > +	refcount_inc(&p->rcu_users);
> 
> This probably needs to be refcount_inc_not_zero() also for the cases like
> during the task free tracepoint ?

Thanks, you're probably right. As you pointed out offline as well, some
fentry functions may expect a NULL pointer, so we probably need to
update this to check for NULL and also return KF_RET_NULL. I'll take
care of that in v2 once we've aligned on the RCU / sleepable progs
question we're discussing with Kumar.
