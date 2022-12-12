Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3935764A5BA
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiLLR1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLLR1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:27:45 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F7062D6;
        Mon, 12 Dec 2022 09:27:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so567569pjj.4;
        Mon, 12 Dec 2022 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8DG9o8qjQwU5nXIU0aeuoAhuzpievgxU8RuUe0b+YE=;
        b=j4Iysgj1xNpAx9uC7AfU564E/3aGcb87SdeVMapP7dPMeIsX+N5AV4ZMmIOF3NMUS4
         Wg6qi1h6rU25QQ+gq/al/++JPl1/3QrO6DeGAdquaIi0fG/fD8IwhLtkdmswvnmeV9t3
         s6RsLDWwUP6znKHPIrvsT0E5hH2yXyrDXyCJILJ+wta1nQ7rCP06nMkKe37D+E6A1yHF
         qG5oeCEEg2Dl9UIlcjyy7l15zN3I9OQaLrCiYxkS4hXiZW2bsBK/f3ZZKE7hpwCdT8z/
         omLL5u0LDvVfREFo60j/8mJmDpICRvpKe41ZOdOxH8FF1+IRzO8ZRhngqdFD8Z80lcSB
         HlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8DG9o8qjQwU5nXIU0aeuoAhuzpievgxU8RuUe0b+YE=;
        b=iKcZnB+TSRXKpsSTBKxDnn9+SuX7IpKGcgcSqOX2aOIoMWtm4BGnM/7eFeGya8YBrU
         Yjr06NIw2Jz77OTtgwQdRrxUzRBoV6ufkRAB5CdDgqBR/UrfZn8wlYnEIi7QJha4wqrH
         k9c7jeK3B8b7nxbTsI69w8xFOjug3pSGsZngRt/Hb3SuVtLe5Xz+e+hWnH/s+Jv6ywxz
         k7ewI1av3KnoB6knMT/AIslqoZsNcCzdm50wmnCrI6q06Esh1OAmjbEgmWcdWYBLsVm9
         WR9WybmPLgi2j4y2xTUn14p7o0gc21znKROSquuT8jEk6Z+H+fKXBnsfEvAS0e+TxSoH
         V+TA==
X-Gm-Message-State: ANoB5pmHqSyFnhh/XjqvWsRJvMOdYswa/tom/pEv+yXQ8pP2HN07ijly
        ZboRZqWH7V2aGuWyMx/tebQ=
X-Google-Smtp-Source: AA0mqf4YHqakeHkqzVupwy2mtrPkdpiZkZuwNLoMq4O1Aa6Dy3PknZ0J07uN0nhCh24FCCf98XbocA==
X-Received: by 2002:a17:90a:d594:b0:219:ed0b:f11a with SMTP id v20-20020a17090ad59400b00219ed0bf11amr17372588pju.8.1670866063517;
        Mon, 12 Dec 2022 09:27:43 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id sj1-20020a17090b2d8100b00218daa55e5fsm5791793pjb.12.2022.12.12.09.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:27:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 07:27:41 -1000
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
Subject: Re: [PATCHSET RFC] sched: Implement BPF extensible scheduler class
Message-ID: <Y5dkjYL/M+smPxeR@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <Y5b2btWFJeEfTyJg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5b2btWFJeEfTyJg@hirez.programming.kicks-ass.net>
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

On Mon, Dec 12, 2022 at 10:37:50AM +0100, Peter Zijlstra wrote:
> Anyway, I hate all of this. Linus NAK'ed loadable schedulers a number of
> times in the past and this is just that again -- with the extra downside
> of the whole BPF thing on top  :/

Yeah, the whole BPF thing is what made this interesting for me and while
there still are frustrating shortcomings, BPF does make iteration and
deployment drastically safer and faster and we can try out ideas which
didn't seem feasible before with relative ease. Given the history, I suppose
some of the decision is upto Linus.

> You look to be exposing a ton of stuff I've so far even refused
> tracepoints for :-(

I tried to keep the exposure limited and am sure it can be much improved. If
you have specific ideas, I'm all ears.

> Anyway, I'm just back from a heavy dose of Covid and still taking it
> easy, but I'll go read through the whole thing, hopefully I'll finish
> before vanishing again for the x-mas break.

Mine wasn't too bad but it still sucked mightily. I wish a quick and full
recovery and thanks for taking a look.

-- 
tejun
