Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF1564A87C
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiLLUMT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiLLUMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:12:10 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575FB17A88;
        Mon, 12 Dec 2022 12:12:09 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c7so678288pfc.12;
        Mon, 12 Dec 2022 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JycGeHZQgGrR3Psb0cbPm6Vf1oXcF21kd3SE0DZ2yo4=;
        b=Kri5aIP83EFUaVFxglJ0ZLakLbzT8kxMysOZ3eCHzGn2x3oqajfeE4IRIYiMLYHqFU
         BZSVvsL6FfK5+Oy2D1a/oqNpoIWwfJYT2K5WPEf3hvJC6737OiosPtT4vBq0KFrEDY+y
         jneAMXdDKLOizabDJCxAR9DN4tf7SpQNYYiWSKQOEwdTmkSb8DhC1MWmyrvbQI+RC3CR
         xV1IMuZCUVPE+KBDnaVkkUMqNPY45FMNY7UofzUxxl1wh0G8eqkQoVOCozgvtO6AMraA
         eSorP+mLvTGP8PiwKs2aH9or25T4PM94bjhvHRUS0D0lhe50iQYM+6S0hU1M5meZIBkZ
         +44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JycGeHZQgGrR3Psb0cbPm6Vf1oXcF21kd3SE0DZ2yo4=;
        b=3H0hUKAVzpcf9ONY0uypPpKQR2bo3Jd9e4D2sNZTVkK5pHpgh07YhVNRQCTQHN7fjW
         2XNKxSMcdR4PKnPO5z8suR7eFK1VsCE73hDb2hvq244qUuaoU9mWHWZ4yJaH+E0njvFM
         SxVn5C9Umamw6+RMxh9B8koZpQGOw61LHB9GsP8MJEDpPQNfFvMfGiuT7GoHwEzPnbcb
         vuVIU4Z1COjHIOYeHIyMlrej+VMSjAYwFeE3CxBZ6Pq5roPgANPk+TSecfEPDRrLqMHB
         7rX0Vgw0lTIybwCJr59iuZELCL5sYOV9pZkfY1l8EdtigLSvrJRgZYHq5iv5gcYRtqPE
         muuA==
X-Gm-Message-State: ANoB5pnl10uwyt4H+l12JVWxFVoCVLpnZXtYoFS1yEmRJX0VfRh8MuN7
        Wm+Z0Mx50jxAIMwKgUnZwbM=
X-Google-Smtp-Source: AA0mqf4+OpCZs23r/RARw8lS96d+0eGJIKR4mL7IJE1PAG/OBUTkZg3Fb4ouNR+bCGHUouzIV7RPbQ==
X-Received: by 2002:a62:ee14:0:b0:566:900d:6073 with SMTP id e20-20020a62ee14000000b00566900d6073mr16634417pfi.24.1670875928671;
        Mon, 12 Dec 2022 12:12:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b6-20020a62cf06000000b00573eb4a775esm6400366pfg.17.2022.12.12.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:12:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 10:12:06 -1000
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
Subject: Re: [PATCH 04/31] sched: Allow sched_cgroup_fork() to fail and
 introduce sched_cancel_fork()
Message-ID: <Y5eLFi/Yot3XZj8O@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-5-tj@kernel.org>
 <Y5cM24M4007WcPod@hirez.programming.kicks-ass.net>
 <Y5ds7G7qTmpAyaKU@slm.duckdns.org>
 <Y5eJ75pH87c+ngmo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5eJ75pH87c+ngmo@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 09:07:11PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 12, 2022 at 08:03:24AM -1000, Tejun Heo wrote:
> > On Mon, Dec 12, 2022 at 12:13:31PM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 29, 2022 at 10:22:46PM -1000, Tejun Heo wrote:
> > > > A new sched_clas needs a bit more control over forking. This patch makes the
> > >                  ^
> > >                  (insufficient s's)
> > 
> > Will update.
> > 
> > > > following changes:
> > > > 
> > > > * Add sched_cancel_fork() which is called if fork fails after sched_fork()
> > > >   succeeds so that the preparation can be undone.
> > > > 
> > > > * Allow sched_cgroup_fork() to fail.
> > > > 
> > > > Neither is used yet and this patch shouldn't cause any behavior changes.
> > > 
> > > Fails to explain why this would be needed and why that would be a good
> > > thing. IOW, total lack of justification.
> > 
> > This is because sched_ext calls out to BPF scheduler's prepare_enable()
> > operation to prepare the task. The operation is allowed to fail (e.g. it
> > might need to allocate something which can fail), so we need a way back back
> > out of it.
> 
> sched_fork() can already fail; why isn't that a suitable location to do
> what needs doing?

Because SCX's ops.prepare_enable() wants the cgroup (p->sched_task_group) to
be initialized in case the BPF scheduler wants to perform cgroup related
initializations.

Thanks.

-- 
tejun
