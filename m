Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AD64A605
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiLLRfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiLLRfJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:35:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE49813FA8;
        Mon, 12 Dec 2022 09:34:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so586650pjd.5;
        Mon, 12 Dec 2022 09:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA82WucYBjIvOjXFoqh37l7Ah3kRRiWR9kIqKPLQajw=;
        b=S+rhb35J1+gqdC9Cg24pBMiK/+6v3nTjzkizAnwCYQkZ/5b7bva2soRUr2vycrdahj
         MiyhXlrd9Uly7nvSqcnGO6QBl8Tyv8FA90zMZBpkxe6Kukg8Kh7ps+jwmUAf3ncXMpy3
         L63QitucKvWCt62RwS7BrZTWfzqz5kK5GIhGD1DHmnPRbbQwDuIRpZIVN+zBNsiqEt2j
         uwIhi0mZuaVWPUY/WViS5kH2V4P8K7C5cLFiz4ZTPRZOr4pk9t+1qD607nSqv0usSvuB
         Ccy/IMZAGY3/b5d0VUKGtMecRZda2Nv53v0LO8N+iIK/6cFQrrBts0d85iphQIS6h1Al
         dv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA82WucYBjIvOjXFoqh37l7Ah3kRRiWR9kIqKPLQajw=;
        b=PtbPFrI9Nas92J6P+0Ys0wUWd9SuyxL+8C1qVyku2ZFs2+iGoSGjEwmX+VcRM6PZBX
         SsG3Io43VWfaf211Fkwa6bR3qCbZAzFA5JKTvWUKQPP6kqfMptmFRGi0FhY6OOj+cc14
         BfNpQQPde50i2CvwL4BUYbaQMuDhLq0ab/P8KTEgLcPUnoiE5B8yt7RDvLEMa6iZXHzz
         xyqv4z9zqZN7ppBJ9cQFgfKNj7thXCErJIO0ACRQuiXhspuW5RpL3V7JxcC0W/Y3egZ2
         VX/9iXkXemu7ohiHPimZpRmPj1Z1bAwoXLWY2T+m86b+Qttot/hQpKp+ua+7WNRjNCM4
         YWyg==
X-Gm-Message-State: ANoB5plFHM4XwsTpbewCpoUTQIbwMeM+o+gHq5zs02qyH89qUbEjdqp1
        oB+0crqbusm7QmQxp2Ao7o4=
X-Google-Smtp-Source: AA0mqf6uqCKx5jRBmUHuRdevoFZ3OzexDOcQTIGL2Vusu0lLkkjOrWYce0fdO4hu9G2VX/wGlxVfpA==
X-Received: by 2002:a17:902:ce8e:b0:186:a990:3fac with SMTP id f14-20020a170902ce8e00b00186a9903facmr23279239plg.10.1670866469134;
        Mon, 12 Dec 2022 09:34:29 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b00189d4c666c8sm6647266plc.153.2022.12.12.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:34:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 07:34:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 05/31] sched: Add sched_class->reweight_task()
Message-ID: <Y5dmI3uAl/kYR5nQ@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-6-tj@kernel.org>
 <Y5cPA2L/G2GiRP9X@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cPA2L/G2GiRP9X@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Dec 12, 2022 at 12:22:43PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:22:47PM -1000, Tejun Heo wrote:
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index a4a20046e586..08799b2a566e 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2193,6 +2193,8 @@ struct sched_class {
> >  	 */
> >  	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
> >  	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
> > +	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
> > +			      int newprio);
> >  	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
> >  			      int oldprio);
> 
> Hurmph.. this further propagate the existing problem of thinking that
> 'prio' is a useful concept in general (it isn't).

I'm not quite following. Can you please expand on why prio isn't a generally
useful concept?

Thanks.

-- 
tejun
