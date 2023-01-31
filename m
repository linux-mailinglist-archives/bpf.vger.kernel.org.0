Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C506820B0
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjAaA0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjAaA0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:26:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3830279A9;
        Mon, 30 Jan 2023 16:26:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 88so12687457pjo.3;
        Mon, 30 Jan 2023 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4X71yW+81ncuvCPseVf6lCznJUzH/rxXjl9KCqExaY0=;
        b=TIfxkwx/xANTEfsSc0PRuvNsinabG2NUY1eDcze8MRiDG5i5BqCTZB6qajs+2pYYYL
         5fmGMXpZudKSfTQKvDFSYBXfkE12EtkZmGN3Gg9v7Fh2/fHg5umM13LR5UcuX1j9H7jv
         m4XzGYvls8MQD6X/txXhj+bgp2IwTnUdHI6K/poRYolI6PHq2AbsCFxb1xgZo8fpzP4+
         XCzE3dS8mY2vKOqzjFQj56i+05xdYuulAkToiTXvXpczmurMkQ8Byjwd336kJAhsWoi8
         uyNx8aYPDngmQ1JxeIobMgZ8jhu0kNbl7eeVCLudog4Pqx3uVFHXdTuo3Vo+1KqdX6nH
         9A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X71yW+81ncuvCPseVf6lCznJUzH/rxXjl9KCqExaY0=;
        b=H4jhFCHWXJIR1eiXIN/mrdKQO39QSI7ltf9hJ7cGXoPkH49VayDwYx/ACO+zu5s4gn
         Ix2cOFtkSZ+oKPhMOu6nSnZfhu7Ok4DnuohRBToafmo+2Jl6S58GMZRr+92hIKDB4GDO
         ZcD5VBc3BGaMYQSMZ1d1Q357ULdsnm3iazob6ZodWE5SVaiwvL++Ti9otOsRv1/J4/zM
         ShrdvO0u08iI8/eVtpeX7jvXZBSK+mH3ZY4JtE76jiKEMHp7qHu9i5nFLGO/Q3kVsspP
         cFetkI4rcTmLWTLJOUVi9PtynS6LCU7K0rK55ddKaEMzZCbm3DKbMbw7I7Z0eoZYnJAK
         2GSA==
X-Gm-Message-State: AO0yUKWeoj6sobBCd1ADbDbtgQxkhfGUJ3jWK1F+O5WWRrTETjDF8rQd
        AzMMS+7Vaq6LkdsXqHxJ6Lk=
X-Google-Smtp-Source: AK7set+MuWN68XESLk0gKAsijbyN2B18U0QO5uAflP9Yz84vvZW9zoljhjwTx75iHmZUeQox5UxijQ==
X-Received: by 2002:a17:903:120f:b0:196:2313:12c6 with SMTP id l15-20020a170903120f00b00196231312c6mr27095536plh.47.1675124781895;
        Mon, 30 Jan 2023 16:26:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902690a00b00196048cc113sm4833582plk.126.2023.01.30.16.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 16:26:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Jan 2023 14:26:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
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
Subject: Re: [PATCH 27/30] sched_ext: Implement core-sched support
Message-ID: <Y9hgLENFI5y3Qtx2@slm.duckdns.org>
References: <20230128001639.3510083-1-tj@kernel.org>
 <20230128001639.3510083-28-tj@kernel.org>
 <CABk29Nt2-CCGnogpfEgJ3ZDk5Esk04n6EwsAqpw_vdeVfKuFUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nt2-CCGnogpfEgJ3ZDk5Esk04n6EwsAqpw_vdeVfKuFUQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Jan 30, 2023 at 01:38:15PM -0800, Josh Don wrote:
> > The core-sched support is composed of the following parts:
> 
> Thanks, this looks pretty reasonable overall.
> 
> One meta comment is that I think we can shortcircuit from
> touch_core_sched when we have sched_core_disabled().

Yeah, touch_core_sched() is really cheap (it's just an assignment from an rq
field to a task field) but sched_core_disabled() is also just a static
branch. Will update.

> Reviewed-by: Josh Don <joshdon@google.com>
> 
> > +                       /*
> > +                        * While core-scheduling, rq lock is shared among
> > +                        * siblings but the debug annotations and rq clock
> > +                        * aren't. Do pinning dance to transfer the ownership.
> > +                        */
> > +                       WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
> > +                       rq_unpin_lock(rq, rf);
> > +                       rq_pin_lock(srq, &srf);
> > +
> > +                       update_rq_clock(srq);
> 
> Unfortunate that we have to do this superfluous update; maybe we can
> save/restore the clock flags from before the pinning shenanigans?

So, this one isn't really superflous. There are two rq's involved - self and
sibling. self's rq clock is saved and restored through rq_unpin_lock() and
rq_repin_lock(). We're transferring the lock owner ship from self to sibling
without actually unlocking and relocking the lock as they should be sharing
the same lock; however, that doesn't mean that the two queues share rq
clocks, so the sibling needs to update its rq clock upon getting the lock
transferred to it. It might make sense to make the siblings share the rq
clock when core-sched is enabled but that's probably for some other time.

> > +static struct task_struct *pick_task_scx(struct rq *rq)
> > +{
> > +       struct task_struct *curr = rq->curr;
> > +       struct task_struct *first = first_local_task(rq);
> > +
> > +       if (curr->scx.flags & SCX_TASK_QUEUED) {
> > +               /* is curr the only runnable task? */
> > +               if (!first)
> > +                       return curr;
> > +
> > +               /*
> > +                * Does curr trump first? We can always go by core_sched_at for
> > +                * this comparison as it represents global FIFO ordering when
> > +                * the default core-sched ordering is in used and local-DSQ FIFO
> > +                * ordering otherwise.
> > +                */
> > +               if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
> > +                                                    first->scx.core_sched_at))
> > +                       return curr;
> 
> So is this to handle the case where we have something running on 'rq'
> to match the cookie of our sibling (which had priority), but now we
> want to switch to running the first thing in the local queue, which
> has a different cookie (and is now the highest priority entity)? Maybe
> being slightly more specific in the comment would help :)

pick_task_scx() is to pick the next best candidate for the rq. The
candidates then compete to determine the next cookie. Here, as long as only
one task gets dispatched at any given time, the condition check shouldn't
really trigger - ie. if curr has slice remaining, balance_one() wouldn't
have populated the local DSQ anyway and first would be NULL.

However, the BPF scheduler is free to dispatch whatever tasks anytime (e.g.
scx_example_central), so it's possible that a task with an earlier timestamp
has been dispatched to the local DSQ since curr started executing, in which
case we likely want to return the first on DSQ as the CPU's candidate.

IOW, the time_before() is there mostly to cover unusual cases. Most should
either trigger !first before or fail the curr->scx.slice test. Will update
the comment to clarify.

Thanks.

-- 
tejun
