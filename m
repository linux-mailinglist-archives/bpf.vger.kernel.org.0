Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642B464BDF6
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 21:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiLMUdt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 15:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbiLMUdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 15:33:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B98D2FD;
        Tue, 13 Dec 2022 12:33:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so4859458pjd.0;
        Tue, 13 Dec 2022 12:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVo9tWO4+tFIzCaw7Dxokr33Yo7Hq5kcowYIl7lVu98=;
        b=EcQvr1YL+COLx3NsyZZRsqlApYino4TUJys6im598IJmBDmMbHsywpKq83MY7noaxF
         tFNntY0izm3v4V6Ho8pYKGXw3jVABTTIM9N7cvUCulUDJSxrCzbfqekNUCXUbEDFI16G
         Vdj4I/m6TQU7MAZeEEnSdsJyyjmpOzPIXfAR8Xg9ArvRe4Go0Jn0ymSC7W+fJZ50agy6
         rSppyL4h/QP/ZGPPJk8JgmBdY8xOysomjqsD/aVmik+XyQtMkjMCF9Un02C3b8+ltQkq
         qU4a9RQ2uvUPrDVqzrs+hpOuNLCmZqy6QkIpFzxukgus14LI6fSPTbhilH8JqkDsonox
         JHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVo9tWO4+tFIzCaw7Dxokr33Yo7Hq5kcowYIl7lVu98=;
        b=cbNLptTxoBtimYApYM2oWMqW77sl+sYcXchkyvqaBHlpTKgoqyfQsOICJWB81Dn91B
         K0KAJTE7eDZKSDQovn+gKswn3x+JOj13kP9R0bHUtWdesOPgEBEqN11Lhsqepq+jZhOX
         1Vl4bT3LFIKosE+Kkm9jJDwkuy62F/xkrSwmENvSNlZObzlY+Rlj5CWEpx3f/IyGIp4a
         F590fuF/ENMnSh021UXw6nyv9rMcYC/Nbpw1UWG/SaAMuo6ruOuBpBGCuNmVwoWSusvf
         hYbIRDOGu0GvgCUPkd62cMFjtg19dY6yI8bzepw6mvDGW366xTLCt4nmoWUMm6kvAPvY
         G+zA==
X-Gm-Message-State: ANoB5pmq03/n9/mU8uw2ukEuYyLDkWxQskX1oOvvm2quYNqUo0ycSmsY
        A6n1reoaMo3+olD8XoFhYr0=
X-Google-Smtp-Source: AA0mqf56z0lAldwwSpk9uf8fo52lyNErJJSQ+uBScPO++9AexA4M8F+CgqsWSrCNi5mxQg/hMODlbg==
X-Received: by 2002:a05:6a20:441e:b0:ac:16ae:1082 with SMTP id ce30-20020a056a20441e00b000ac16ae1082mr39495811pzb.32.1670963626206;
        Tue, 13 Dec 2022 12:33:46 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:c415])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b0018971fba556sm303846plk.139.2022.12.13.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:33:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Dec 2022 10:33:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Peter Oskolkov <posk@google.com>
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example
 scheduler
Message-ID: <Y5jhqOk1mRC+k72x@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-32-tj@kernel.org>
 <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
 <CABk29Nu5WiCmhNN2jZrTShELbCDOYUziUeW5xojkwB83R+VzEQ@mail.gmail.com>
 <Y5hiPqaT6UqaUcGK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5hiPqaT6UqaUcGK@hirez.programming.kicks-ass.net>
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

On Tue, Dec 13, 2022 at 12:30:06PM +0100, Peter Zijlstra wrote:
> ( Many were already noted by Linus when he NAK'ed loadable schedulers
>   previously. )

Yeah, many of the points Linus raised still stand. However, that was 15
years ago and the situation including hardware reality has changed a lot. As
stated in the cover letter, that makes us (and others) want to try out
various ideas but the barrier has often been too high to do so at any scale,
which BPF drasically improves. Given those, I think it'd be worthwhile to
revisit that discussion.

> sched_ext also sits at the very bottom of the class stack (it more or
> less has to) the result is that in order to use it at all, you have to
> have control over all runnable tasks in the system (a stray CFS task

> would interfere quite disastrously) but that is exactly the same
> constraint you need to make UMCG work.

One important distinction is that it's a lot easier to have control at the
system level than at the application code level. Even for us with pretty
good control over what runs in the fleet, it'd be practically impossible to
effect that level of application change across the board. The situation is
further complicated with containers which can be pretty opaque to the
system. I have a hard time seeing co-operative application-driven scheduling
working among mutiple applications across the whole system. If we get to
non-fleet use-cases, it becomes even worse as you don't have enough resource
on or control over the code base you're running.

There may be some overlapping areas between SCX and UMCG but they're very
different things. After all, we can't let go of system level scheduling
because some applications have better control over their own sequencing.

As for the CFS starvation issue, I obviously don't find the currently
proposed behavior too bad - CFS is always the default scheduler and we fall
back to it whenever the BPF scheduling isn't working out whether that's
outright bugs in the BPF scheduler implementation or starvation through CFS.
That said, this comes down to what kind of behavior we wanna show to
userspace and we can implement whatever is appropriate and acceptable.

Thanks.

--
tejun
