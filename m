Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E645BD4D0
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 20:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiISSgJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiISSgI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 14:36:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44424205CA;
        Mon, 19 Sep 2022 11:36:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so763627ejn.3;
        Mon, 19 Sep 2022 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xysQoAG8p++2395HYwD09N+AaN5kwY2ODmTAdpS3GA4=;
        b=i8Y6XgiE5SIkU2Jgqa5ydeIJWZzjno9Z6C8UHoyF27aIDGFqYb0xwIUNx1xiObiTcA
         pZYp+CeZjNWulZCWQfM1BZLMGZK+m4U2jmdhAnHs8x0k8c9RxzQOdlsZRmBhMCoeFzES
         u2wET8dDm0abuLMjUrpcJSb3P07OYHodvI9Ej/AiugO1FrcB+KyEtFneSuFXOj8rJtgl
         VyaTqgtX4Xj502OySsFJaddWjVOGRn7M0/kZEiuNhp0sXoTcWWXM6z7Gx46x2DC8Y9x5
         BneRTdT6Tvty25qV7c8UmFKPK3h9X8ZJUDfu7ZhnvoOZmFaqqkr6haE6kAmDsLwIbefA
         3W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xysQoAG8p++2395HYwD09N+AaN5kwY2ODmTAdpS3GA4=;
        b=F2qOYpCoOIKdqXE2Hcnq6ARyaABREymyr12HyRJ5743jVUHmL5yc1TeSBdEtamTxzH
         /xmOYp5xnBP7l23488uIM389DpzUhnBxhcx7svHTVhnyRqLNumR2xQtYyPswbCPeowj/
         QVuJN2Ui6wEiMjMOtf2dxrggVJ6tCl0meIk0ZKAQCLMMRw8qvC4g7hprEdbZmFEJWJtA
         XyFoNh5ie0YnSr5jLI347+jHUAju+dQ/FgswRAHnqMb9406H0idjRTE2kqlfp0e4I3gV
         7tsqIoTr4MtVOOJEGqkssM/Q6fadd1jkiitjghH8082IKgcQ+LtD/j4n2YjtYxszQXBC
         6t3A==
X-Gm-Message-State: ACrzQf0osy82mrQEACoVr1n3sCU9HJI4hY3JY5gQLNumAgZsOnhiyGQ9
        ii43DaF0+Emp5qHTvQKdrdmF9j/a9d2diGdQb49M6VKNCfe3fA==
X-Google-Smtp-Source: AMsMyM7OCjj0N2lq7ypdTFS9K9fbZtKqPqYIrGEwsOjGa9TK9uds8w2DeniWItXZkmVPW5Fx5OcFiYprKjIR0sXIzn0=
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e3 with SMTP id
 xc10-20020a170907074a00b0077e9455b4e3mr14078318ejb.471.1663612561632; Mon, 19
 Sep 2022 11:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220917014746.3828349-1-floridsleeves@gmail.com> <Yyh/BmvAHNMlENFw@hirez.programming.kicks-ass.net>
In-Reply-To: <Yyh/BmvAHNMlENFw@hirez.programming.kicks-ass.net>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Mon, 19 Sep 2022 11:36:13 -0700
Message-ID: <CAMEuxRrmNT6xdLDiHLKb9COkRO31QuvwMX5zPFKw0uVAnJ6Yjg@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/events/core: check return value of task_function_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 19, 2022 at 7:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 16, 2022 at 06:47:46PM -0700, Li Zhong wrote:
> > Check the return value of task_function_call(), which could be error
> > code when the execution fails.
>
> How is terminating the cgroup task iteration a useful thing? Also coding
> style fail for not adding { }

Thanks for your reply! Skip and continue the execution is more appropriate
here. Change it in v2 patch.

>
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> >  kernel/events/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2621fd24ad26..ac0cf611b12a 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -13520,7 +13520,8 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
> >       struct cgroup_subsys_state *css;
> >
> >       cgroup_taskset_for_each(task, css, tset)
> > -             task_function_call(task, __perf_cgroup_move, task);
> > +             if (!task_function_call(task, __perf_cgroup_move, task))
> > +                     return;
> >  }
> >
> >  struct cgroup_subsys perf_event_cgrp_subsys = {
> > --
> > 2.25.1
> >
