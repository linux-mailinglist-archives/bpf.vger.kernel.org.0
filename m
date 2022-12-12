Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94564A891
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiLLUPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiLLUP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:15:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1362B0;
        Mon, 12 Dec 2022 12:15:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p24so13280892plw.1;
        Mon, 12 Dec 2022 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FHYQaECelaNtH5CB2bDo9uLzM9I49pjKixgEBaWRB8=;
        b=QBGGYFbr/Z82wnD98tLRe5+Xp2cudBtrbuEl1W4I9oF7ooOMtIzOsJNOlFDe9Jq51F
         mALPCy4pWnkD1rReho/uV7Fps3iu6KiLWL9bcPkOhcWpIAEVbisJS24ACbFQaTPSXwnk
         1pky+vYyDMJuNjL9koaEJONjvU8Li8MikL1IseAio1hvxffNSmq8mMmNXZFlMYwDuqP1
         aN0aAodRUh5pzUNckoaV5nYfE8fZfIw/tje2pX2Xvfel4Tin+ulJ4FPBeeGpGlbpTPUH
         0xaxflIR0c+Ofx+MytD0HR3A1jXdlOtLWmbt191vuK68BIslhMDm12C26UqYH1u3QUiu
         d7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FHYQaECelaNtH5CB2bDo9uLzM9I49pjKixgEBaWRB8=;
        b=Kr7B8hkOOWvOMFcyhLjI3VO9YG0Ms75i7WJqNyp/GtDhmOCP4fC2pF271iUZmRZyai
         AQDfQziTkbg9AKV+dUhois3YZ2OJ1Oyvbuw8abPPc86mlKpTstHWMSJkfMDbzb0yJhIN
         0JsziPNIF3L3+q0wzqfkwpYMAS+WkQT4OgVx2i5YKaXCogslJqoSZDDJzpsGVfKn+ETb
         J2kr9orSD8LbtWMvEcewgO8RKeNr4cul0wJDgev0oZQw+yVkCDOX0KLXlcILPzSvyUuo
         zeYY+Ik0Q1pJ4BEyLJHFgmeUEKGmy7PAgznDgB9uM+2OrKCKlv273AYHdBOybBKcnnK5
         RUUQ==
X-Gm-Message-State: ANoB5pliLmpDo1kjgehQRSgs2Zjmmggjapk/eQRQfvI8w/cwVXKlF5fW
        nkfCmKvA5MZPUDZkKVEQw58=
X-Google-Smtp-Source: AA0mqf5+IAeUPcqbnskdQ+WsN57U+BsRDb3McUq1ect6XnQsqta6yy6hwk6MqYK/n9klF3mr9TlTZw==
X-Received: by 2002:a17:90a:af84:b0:218:c8fd:c213 with SMTP id w4-20020a17090aaf8400b00218c8fdc213mr18224585pjq.36.1670876109548;
        Mon, 12 Dec 2022 12:15:09 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s1-20020a63f041000000b0045ff216a0casm5578797pgj.3.2022.12.12.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:15:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 10:15:07 -1000
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
Message-ID: <Y5eLyxSgjea/lt2g@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-6-tj@kernel.org>
 <Y5cPA2L/G2GiRP9X@hirez.programming.kicks-ass.net>
 <Y5dmI3uAl/kYR5nQ@slm.duckdns.org>
 <Y5eK+DwksKRYmhMJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5eK+DwksKRYmhMJ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 09:11:36PM +0100, Peter Zijlstra wrote:
> > > Hurmph.. this further propagate the existing problem of thinking that
> > > 'prio' is a useful concept in general (it isn't).
> > 
> > I'm not quite following. Can you please expand on why prio isn't a generally
> > useful concept?
> 
> The whole fixed vs dynamic priority scheduling thing. Specifically
> SCHED_DEADLINE implements a dynamic priority scheme using the sporadic
> task model which just doesn't map well to this single prio value
> (notably every SCHED_DEADLINE task has prio -1, making it impossible to
> order SCHED_DEADLINE tasks based on this).

I see, so the expressive power isn't sufficient to cover some use cases.
Yeah, I mean, it's limited and we can add whatever that's necessary but
given that there are many use cases that make use of priorities, I don't
think SCX can skip supporting it.

Thanks.

-- 
tejun
