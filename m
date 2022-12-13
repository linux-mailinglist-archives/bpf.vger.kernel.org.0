Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56E564BBE1
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiLMSZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 13:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiLMSZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 13:25:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E1186D2
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:25:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q6so6286885lfm.10
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+tJhcvoCftbKyLVpmqUPG0nhb05IX809QUuL/r9UEA=;
        b=qrFH26ie3CcCOcVrUG4vnyD2JxiozF1PVLfibl4f1kXDlIuhmemmQN1/UHh35Kpx4n
         Lc8vV5P0ZYFt8XEECdLw07rqRrR7aNDxBJrCRpvmIEr8KZiDZ/tORfd4sEVY4rxsc3hR
         Q9vufaKW5so88JHd1bcq9/5G2EfFqOhwmEyQCjM4iXKTu9KY4yFVlcgSpQ4VorK9OlU9
         UUw3awdKbZ+9mVyQQRIL8dDqAEN/iYYfiaL2bU0n8PZx4TcJmzhC0t3yEJEfjmkcT9rR
         hTeZyPCOApxsOReJBxfN6Ni7/GxllXjY544APewKAeJ6AMK5pT5bymtXPYiQokEfdb9D
         4DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+tJhcvoCftbKyLVpmqUPG0nhb05IX809QUuL/r9UEA=;
        b=HdAo/dp1mtLUq5LoL8HwWCd/Vm1acQznNl/VJPCque3fG1o2n/wfo1kHLq+NSSjCQ/
         sKI5Ooz+ebsoUfAuHZuY1Wf3jyMUuIFNFStNOyfitHRefByalYvKlB1ayT8VULqffwfu
         2J2w2A6orIwrv8LP8OtnmYZtYNyrO550dKhTTCcBPqYS4u3enqgS7pmrB3Cs7kh9Lvpx
         YckrqGYtfoXwW8XDi/UObBC87Zd2U65Loqxtu1a0iwnfjeNqFtuFKquTfeYi5V+xr/UE
         ckubs/mlQV6EA96fcCBcuVc6w9l+p2sUKN3Dj67oA0qiGHieCzujGAft/5n4Me9Xie6h
         ybzQ==
X-Gm-Message-State: ANoB5plMEQL8HkUXvoSya7jlRyJX9VZS3MRdRtCYftM81p5tyA7NPyy6
        alzRDZ8jSANlDsnS/MkpmdczcVX/Nf0/r0UipzzHsQ==
X-Google-Smtp-Source: AA0mqf54fWx+JdQpRsJbmZbNpAXNZNETXGzEuYrCQKr+l5J/l0Hn98WboIS4WiDW1e5CD8EA0vSS10ThteIZl6a4YbM=
X-Received: by 2002:a05:6512:3a86:b0:4b6:ec97:a621 with SMTP id
 q6-20020a0565123a8600b004b6ec97a621mr400080lfu.622.1670955903363; Tue, 13 Dec
 2022 10:25:03 -0800 (PST)
MIME-Version: 1.0
References: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
 <20221212210547.1105894-1-posk@google.com> <Y5hb05fll8jXc0Ck@hirez.programming.kicks-ass.net>
In-Reply-To: <Y5hb05fll8jXc0Ck@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 13 Dec 2022 10:24:51 -0800
Message-ID: <CAPNVh5fuwp70JHRocpDvN9X3iRLqV33v4=LhOSOvdGyYz+CSUA@mail.gmail.com>
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example scheduler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brho@google.com, bristot@redhat.com, bsegall@google.com,
        daniel@iogearbox.net, derkling@google.com,
        dietmar.eggemann@arm.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, dvernet@meta.com, haoluo@google.com,
        joshdon@google.com, juri.lelli@redhat.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        mgorman@suse.de, mingo@redhat.com, pjt@google.com,
        riel@surriel.com, rostedt@goodmis.org, tj@kernel.org,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, posk@posk.io
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

On Tue, Dec 13, 2022 at 3:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 12, 2022 at 01:05:47PM -0800, Peter Oskolkov wrote:
> > Peter Zijlstra wrote:
> >
> > > I long for the UMCG patches -- that
> > > at least was somewhat sane and trivially composes, unlike all this
> > > madness.
> >
> > A surprise, to be sure, but a welcome one!
>
> Well, I did somewhat like it as I put significant effort into it. In
> fact I was >.< near to merging the lot when you changed your mind and
> went the syscall route.

Yes, we are doing it via syscalls now, as managing pinned pages in the TLS
approach seemed ... excessive? Complicated? Not sure how to describe it.

But if you believe the TLS approach is sound, feel free to merge it, and we
will make it work on our side. :)

(Tejun, my apologies for hijacking your thread a bit...)

[...]
