Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592D6682181
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 02:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjAaBqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 20:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjAaBqK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 20:46:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606D252BE
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 17:45:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m13so1675247plx.13
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 17:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbM1BOQ4XWE4OUgtCo6C4bdHxYq4OBKrEZY8jLQ57ds=;
        b=J7nzSQOGmpCmGBqVDqLzDaKqdmThacQyaLPB0hwEiZvvwznIEUic9aw+4OeNlfTMpM
         jqhHiNK6l7iTxBN6PudMuHzqECrXGGaV/v97OxIrG3237tUu4bmM3wiLV6SkBRnxKETM
         ghxsrAbZDpwBvLScb3jAYI/cSpbCILEEohizUJq8aF5WlgciyI6Ehl25zn52Y7mmnhLT
         iXiJ7nlbR+raD/8nKbEZJ5a1zULtWPWsW6gK1CfSE/xwE57rEBBmcRa/20jNRQGF/yhG
         AUAomNcMCNCDUAkshyxhy40wGcfGs8yYt5smnE0DKNcrT9DQy2VaYFiKdaEZxAi7pqlM
         +gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbM1BOQ4XWE4OUgtCo6C4bdHxYq4OBKrEZY8jLQ57ds=;
        b=bSNagmqXW2sAK/LeX/LuKnXiAMRyZA4fIiyWB62VmZfRM2/P7JEuAfC3c5kLrPMil+
         /Y9OmPUxe54F3DDwRtpMM/bKFz5NJKYMKSN+F9TZLB2r4rQznS2vXUDEq1AbXdnhCtmc
         ZWSp9zfhe6DeOAPbZcSVejOJxhk/7KFbE1bfK+dibJ/aSmBJXb4sp9EwJrx92UmngHrW
         BCaC2bCk/WbaU11EthIs3YTwtDw3ekSioX3Nwh5N2uRwfwEf1AnP+ckUGt1je/5y/BlF
         w/yWlBnnGME8pOqN15CIxyuSxf+WQvbGqLQ3vixigy1HVMMX3j2qR9I8v9s1zRgvzbd1
         Kbmg==
X-Gm-Message-State: AO0yUKV4izUtHAJDLROldueSsiURLVlWatKG5xnblh3XRi9mCJdV2X/9
        TrFu8WDLBIuO2pQzg5iPHjdiqyTvrdQtKjV5InLUWw==
X-Google-Smtp-Source: AK7set9N5P5ldD/yETehszirsCZuTnymewwCNrvHg2d+SXQHdcYE+TA92gT37/hltVGbBH/wAx6boLx8qdTaCxypjo8=
X-Received: by 2002:a17:902:714c:b0:196:3088:5def with SMTP id
 u12-20020a170902714c00b0019630885defmr3074407plm.32.1675129539114; Mon, 30
 Jan 2023 17:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20230128001639.3510083-1-tj@kernel.org> <20230128001639.3510083-28-tj@kernel.org>
 <CABk29Nt2-CCGnogpfEgJ3ZDk5Esk04n6EwsAqpw_vdeVfKuFUQ@mail.gmail.com> <Y9hgLENFI5y3Qtx2@slm.duckdns.org>
In-Reply-To: <Y9hgLENFI5y3Qtx2@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 30 Jan 2023 17:45:26 -0800
Message-ID: <CABk29NuwpSDAy6inXD5dPjtw9SqjxNr0hK5SkM98b7jHinWFFw@mail.gmail.com>
Subject: Re: [PATCH 27/30] sched_ext: Implement core-sched support
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 4:26 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Jan 30, 2023 at 01:38:15PM -0800, Josh Don wrote:
> > > The core-sched support is composed of the following parts:
> >
> > Thanks, this looks pretty reasonable overall.
> >
> > One meta comment is that I think we can shortcircuit from
> > touch_core_sched when we have sched_core_disabled().
>
> Yeah, touch_core_sched() is really cheap (it's just an assignment from an rq
> field to a task field) but sched_core_disabled() is also just a static
> branch. Will update.

Yep, true, I was just going through and reasoning about whether
anything needed to be done in the !sched_core_disabled() case.

> > Reviewed-by: Josh Don <joshdon@google.com>
> >
> > > +                       /*
> > > +                        * While core-scheduling, rq lock is shared among
> > > +                        * siblings but the debug annotations and rq clock
> > > +                        * aren't. Do pinning dance to transfer the ownership.
> > > +                        */
> > > +                       WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
> > > +                       rq_unpin_lock(rq, rf);
> > > +                       rq_pin_lock(srq, &srf);
> > > +
> > > +                       update_rq_clock(srq);
> >
> > Unfortunate that we have to do this superfluous update; maybe we can
> > save/restore the clock flags from before the pinning shenanigans?
>
> So, this one isn't really superflous. There are two rq's involved - self and
> sibling. self's rq clock is saved and restored through rq_unpin_lock() and
> rq_repin_lock(). We're transferring the lock owner ship from self to sibling
> without actually unlocking and relocking the lock as they should be sharing
> the same lock; however, that doesn't mean that the two queues share rq
> clocks, so the sibling needs to update its rq clock upon getting the lock
> transferred to it. It might make sense to make the siblings share the rq
> clock when core-sched is enabled but that's probably for some other time.

Yep, whoops, I forgot that part didn't make it.
