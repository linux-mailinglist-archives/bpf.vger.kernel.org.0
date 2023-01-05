Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0450F65E15E
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 01:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjAEAO5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 19:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjAEAOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 19:14:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E4C4730C
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 16:14:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v23so38149522pju.3
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 16:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpR+YuUZvl6NdWqBa+lSwaueNUgdlwl+GiOGfu/BhGE=;
        b=A5mF91xWH9tbxSYgUVEGjfpFe67ucAgvOPO2Y42pGxfqLDouAiYaiqM27HzDUSY7pU
         aD/pw4IXKd2MIrN0gWHWxoec1b/3bUbKE7oSjTi0ebfUjeK+o6UV8v5s7kBeJ4m7NVqB
         AfOVOYMO3gpvt7n+Q3y+wd3OTOY6UP0O2Zxlc4BxX7XbGrZ+Bz4gH/0rd3alGoM+wqgX
         QRm80wHsJ/F+YRZZpQR3fW1D0g5BrVRD0J8t6OC4EEIpSe+vX+a9xPZNzwzs51INgjd4
         EWKzmKbkE7mJpQRmrSnh4OmsgT6wNy86eeugx1diHJ0cKs8xFf1z6BKR7/ipGDXIc4we
         Cr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpR+YuUZvl6NdWqBa+lSwaueNUgdlwl+GiOGfu/BhGE=;
        b=6Vt/zitu9aTOQ6is+1qj2YlnBh9RslFDMdih5HvEff1rstHaSmsFK2rvyvPLemWAUQ
         T2E/zqU9AagIVBc/lo2Ne65xLJVaS/6nxR/Hc2bH5APwYSDmLHhs5YZRmZvWs29+Ct6n
         nWbMjBzDfTWFSd93mK3e2/N+JweinhtT91fruNeutHe1YpWkmnelphH9E/lVfpBrtpTl
         qUMTZhh/jyxJ8F24ITnwVVAkcGuLsQLFTkvcbXwO0s0zwl0p3Dv5fHq2FoQvCgbDgUJA
         gBx/9mOqowSbHepmrmFAEBK/GPptO3Y48Qw6qebJPZDQcDlQa7PW3SbhX+mBRo1u09a0
         5bwg==
X-Gm-Message-State: AFqh2kqNjRP6NTA2LmHJ9NW1m9ZJIoSqUKPMAoruHjoMpwebMKAqJ+0C
        M/+SExtmR+G7bzptJh+/SvE=
X-Google-Smtp-Source: AMrXdXv/slzMGsphwVcswBD9ndI1KROkJ+jdK93ygnZS9NEMz7CMFIBzD4RgqZX7LE6BIh65Q6ta2Q==
X-Received: by 2002:a17:90a:3e43:b0:225:b396:967f with SMTP id t3-20020a17090a3e4300b00225b396967fmr48950288pjm.23.1672877668891;
        Wed, 04 Jan 2023 16:14:28 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090a290100b002191a64b5d5sm123864pjd.18.2023.01.04.16.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:14:28 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:14:26 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
Message-ID: <20230105001426.x4e4hm573f72rywp@macbook-pro-6.dhcp.thefacebook.com>
References: <20221223054921.958283-1-andrii@kernel.org>
 <20221223054921.958283-8-andrii@kernel.org>
 <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com>
 <20221230021917.yuvm4g7sjj7vy5qc@MacBook-Pro-6.local>
 <CAEf4BzaaE1B0Xezb5jrH0p-my4_GEb7EPqfAQVBPLyLkq672=g@mail.gmail.com>
 <20230104223521.hi2wvabfn7ldgh6o@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYdaqF1yoXtEQSHLXmgEvWiieoKW=2xBM+iJuJt6ukTzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYdaqF1yoXtEQSHLXmgEvWiieoKW=2xBM+iJuJt6ukTzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 03:03:23PM -0800, Andrii Nakryiko wrote:
> On Wed, Jan 4, 2023 at 2:35 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jan 03, 2023 at 02:04:44PM -0800, Andrii Nakryiko wrote:
> > > > It sounds logical, but it can get tricky with ranges and branch taken logic.
> > > > Consider something like:
> > > > R1=(min=2,max=8), R2=(min=1, max=10)
> > > > if (R1 within R2) // bpf prog is doing its own 'within'
> > >
> > > a bit confused what is "R1 within R2" here and what you mean "bpf prog
> > > is doing its own 'within'"? Any sort of `R1 < R2` checks (and any
> > > other op: <=, >=, etc) can't really kick in branch elimination because
> > > R2_min=1 < R1_max=8, so arithmetically speaking we can't conclude that
> > > "R1 is always smaller than R2", so both branches would have to be
> > > examined.
> >
> > Something like that. Details didn't matter to me.
> > It was hypothetical 'within' operation just to illustrate the point.
> 
> I just don't know what kind of instruction has this "within"
> semantics, that's why I was confused.
> 
> >
> > > But I probably misunderstood your example, sorry.
> > >
> > > >   // branch taken kicks in
> > > > else
> > > >   // issues that were never checked
> > > >
> > > > Now new state has:
> > > > R1=(min=4,max=6), R2=(min=5, max=5)
> > > >
> > > > Both R1 and R2 of new state individually range_within of old safe state,
> > > > but together the prog may go to the unverified path.
> > > > Not sure whether it's practical today.
> > > > You asked for hypothetical, so here it goes :)
> > >
> > > No problem with "hypothetical-ness". But my confusion and argument is
> > > similarly "in principle"-like. Because if such an example above can be
> > > constructed then this would be an issue for SCALAR as well, right? And
> > > if you can bypass verifier's safety with SCALAR, you (hypothetically)
> > > could use that SCALAR to do out-of-bounds memory access by adding this
> > > SCALAR to some mem-like register.
> >
> > Correct. The issue would apply to regular scalar if such 'within' operation
> > was available.
> >
> > > So that's my point and my source of confusion: if we don't trust
> > > var_off+range_within() logic to handle *all* situations correctly,
> > > then we should be worried about SCALARs just as much as anything else
> > > (unless, as usual, I missed something).
> >
> > Yes. I personally don't believe that doing range_within for all regtypes
> > by default is a safer way forward.
> > The example wasn't real. It was trying to demonstrate a possible issue.
> > You insist to see a real example with range_within.
> > I don't have it. It's a gut feel that it could be there because
> > I could construct it with fake 'within'.
> 
> Ok, so some new instruction with "within" semantics would be
> necessary. I was just trying to see if I'm missing some existing
> potential case. Seems like not, that's fine.
> 
> >
> > > > More gut feel than real issue.
> > > >
> > > > >
> > > > > >
> > > > > > SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
> > > > > > Keeping default as regs_exact (that does ID match) is safer default.
> > > > >
> > > > > It's fine, though the point of this patch set was patch #7, enabling
> > > > > logic similar to PTR_TO_MAP_VALUE for PTR_TO_MEM and PTR_TO_BUF. I can
> > > > > send specific fixes for that, no problem. But as I said above, I'm
> > > > > really curious to understand what kind of situations will lead to
> > > > > unsafety if we do var_off+range_within checks.
> > > >
> > > > PTR_TO_MEM and PTR_TO_BUF explicitly are likely ok despite my convoluted
> > > > example above.
> > > > I'm less sure about PTR_TO_BTF_ID. It could be ok.
> > > > Just feels safer to opt-in each type explicitly.
> > >
> > > Sure, I can just do a simple opt-in, no problem. As I said, mostly
> > > trying to understand the issue overall.
> > >
> > > For PTR_TO_BTF_ID specifically, I can see how we can enable
> > > var_off+range_within for cases when we access some array, right? But
> > > then I think we'll be enforcing that we are staying within the
> > > boundaries of a single array field, never crossing into another field.
> >
> > Likely yes, but why?
> 
> No reason, just seems sane. But it also doesn't matter for the
> discussion at hand.
> 
> > You're trying hard to collapse the switch statement in regsafe()
> > while claiming it's a safer way. I don't see it this way.
> > For example the upcoming active_lock_id would need its own check_ids() call.
> > It will be necessary for PTR_TO_BTF_ID only.
> > Why collapse the switch into 'default:' just to bring some back?
> > The default without checking active_lock_id through check_ids
> > would be wrong, so collapsed switch doesn't make things safer.
> 
> I'm saying it's sane default and is better than what we have today.
> The reason I want(ed) to make default case doing proper range checks
> (if they are set) is so that we don't miss cases like PTR_TO_MEM and
> PTR_TO_BUF in the future.

Wait. What do you mean 'miss cases like PTR_TO_MEM' ?
With 'switch() default: regs_exact()'
it's not a safety issue that PTR_TO_MEM doesn't do range_within() like PTR_TO_MAP_KEY.
The verifier is unnecessary conservative with PTR_TO_MEM.
Applying range_within() will allow more valid programs to be accepted.
What did I miss?
Or all this time I've been misreading your 'saner' default as 'safer' default?
