Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B104165E0AF
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 00:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjADXDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 18:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjADXDi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 18:03:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED922193DE
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 15:03:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z11so34873118ede.1
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 15:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCf5NogzK+8W+en9yrzm5jDjCXnqIJFYwrHR2icNJdo=;
        b=cEo1T6rnJBzhUtmuC3mtfTpg0b+K5w+VmkYPsGB+ZNtes795OuEm2e09vAxjHZsJ3h
         shJum+IE6MJfECKy+Cyasw8yxsIes1/V0Vkhp/q/Z2UhUvZW3ey/s0s/cX1nzYg4Szsp
         NL3gCANnlJTaeFmOod/Slse+n6b8cBW9RYR4HQdpGhjCVD2mvdIj/ZuFVlWLaXVUBK2o
         sET4XyU5tnjDDRwkate6UES5GWuaC4r6Sl7RgSv5OuqA7XNDKpd0pOFvVhzYAen+A25n
         1Ao3xzWNSxOh7Zc8oPVnpQ7DUZSIPK01XIUkUwEA7akWoY5KBlJYr8/OGfFGDx+oIoAk
         aY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCf5NogzK+8W+en9yrzm5jDjCXnqIJFYwrHR2icNJdo=;
        b=O/WsOustXQQYpqYMp3+mCIq1IUOcdVsxtHhKJRO1naAT1Ncwh/gByGCqW/MYDFC1Kn
         bxqHBthUV+3a/g5KHLM1QCnqddEBgOS+Sxo85KjQ8Y+MX3C4QStziJli0subFRbSHe6k
         2YN17gBGEcvQmUbRRLKYeK2ejaPoYJvW8M8JaQK9XVR73C/buE84yxjFEUc3GtjAG86A
         Zr+Yt1D7qnPMmMi7jTFswaKGdAUR+uH5Iat2jHtlYGrZPpyAD4HtczzuqRPif9fdi4S+
         s6aTlCLkbKkB1pykh5qpinsPI34ddBy32m8JuH6dE4KVd81ccUHLE+Sa1gFmQIKD7m/r
         Bd8g==
X-Gm-Message-State: AFqh2koCiAktpP8IbBDo0xp0hidTfasqXAId6bYGRwI0nQIFjtjHC/w4
        3ffpo9mI1M++6r8J/cm+Gc14gvxxgt6EsGLFoHT3uUEzQRU=
X-Google-Smtp-Source: AMrXdXsI1h1bWS0ZVExZuxg/k+4/upBK1YAxhiwmZoV5/LAYLPkhKVp/+/oeJ9xiIMoy+FNQ+8R1EhF5H60+xXSWKMA=
X-Received: by 2002:aa7:cb52:0:b0:484:93ac:33a6 with SMTP id
 w18-20020aa7cb52000000b0048493ac33a6mr2855123edt.81.1672873415484; Wed, 04
 Jan 2023 15:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20221223054921.958283-1-andrii@kernel.org> <20221223054921.958283-8-andrii@kernel.org>
 <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com>
 <20221230021917.yuvm4g7sjj7vy5qc@MacBook-Pro-6.local> <CAEf4BzaaE1B0Xezb5jrH0p-my4_GEb7EPqfAQVBPLyLkq672=g@mail.gmail.com>
 <20230104223521.hi2wvabfn7ldgh6o@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230104223521.hi2wvabfn7ldgh6o@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 15:03:23 -0800
Message-ID: <CAEf4BzYdaqF1yoXtEQSHLXmgEvWiieoKW=2xBM+iJuJt6ukTzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Wed, Jan 4, 2023 at 2:35 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 03, 2023 at 02:04:44PM -0800, Andrii Nakryiko wrote:
> > > It sounds logical, but it can get tricky with ranges and branch taken logic.
> > > Consider something like:
> > > R1=(min=2,max=8), R2=(min=1, max=10)
> > > if (R1 within R2) // bpf prog is doing its own 'within'
> >
> > a bit confused what is "R1 within R2" here and what you mean "bpf prog
> > is doing its own 'within'"? Any sort of `R1 < R2` checks (and any
> > other op: <=, >=, etc) can't really kick in branch elimination because
> > R2_min=1 < R1_max=8, so arithmetically speaking we can't conclude that
> > "R1 is always smaller than R2", so both branches would have to be
> > examined.
>
> Something like that. Details didn't matter to me.
> It was hypothetical 'within' operation just to illustrate the point.

I just don't know what kind of instruction has this "within"
semantics, that's why I was confused.

>
> > But I probably misunderstood your example, sorry.
> >
> > >   // branch taken kicks in
> > > else
> > >   // issues that were never checked
> > >
> > > Now new state has:
> > > R1=(min=4,max=6), R2=(min=5, max=5)
> > >
> > > Both R1 and R2 of new state individually range_within of old safe state,
> > > but together the prog may go to the unverified path.
> > > Not sure whether it's practical today.
> > > You asked for hypothetical, so here it goes :)
> >
> > No problem with "hypothetical-ness". But my confusion and argument is
> > similarly "in principle"-like. Because if such an example above can be
> > constructed then this would be an issue for SCALAR as well, right? And
> > if you can bypass verifier's safety with SCALAR, you (hypothetically)
> > could use that SCALAR to do out-of-bounds memory access by adding this
> > SCALAR to some mem-like register.
>
> Correct. The issue would apply to regular scalar if such 'within' operation
> was available.
>
> > So that's my point and my source of confusion: if we don't trust
> > var_off+range_within() logic to handle *all* situations correctly,
> > then we should be worried about SCALARs just as much as anything else
> > (unless, as usual, I missed something).
>
> Yes. I personally don't believe that doing range_within for all regtypes
> by default is a safer way forward.
> The example wasn't real. It was trying to demonstrate a possible issue.
> You insist to see a real example with range_within.
> I don't have it. It's a gut feel that it could be there because
> I could construct it with fake 'within'.

Ok, so some new instruction with "within" semantics would be
necessary. I was just trying to see if I'm missing some existing
potential case. Seems like not, that's fine.

>
> > > More gut feel than real issue.
> > >
> > > >
> > > > >
> > > > > SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
> > > > > Keeping default as regs_exact (that does ID match) is safer default.
> > > >
> > > > It's fine, though the point of this patch set was patch #7, enabling
> > > > logic similar to PTR_TO_MAP_VALUE for PTR_TO_MEM and PTR_TO_BUF. I can
> > > > send specific fixes for that, no problem. But as I said above, I'm
> > > > really curious to understand what kind of situations will lead to
> > > > unsafety if we do var_off+range_within checks.
> > >
> > > PTR_TO_MEM and PTR_TO_BUF explicitly are likely ok despite my convoluted
> > > example above.
> > > I'm less sure about PTR_TO_BTF_ID. It could be ok.
> > > Just feels safer to opt-in each type explicitly.
> >
> > Sure, I can just do a simple opt-in, no problem. As I said, mostly
> > trying to understand the issue overall.
> >
> > For PTR_TO_BTF_ID specifically, I can see how we can enable
> > var_off+range_within for cases when we access some array, right? But
> > then I think we'll be enforcing that we are staying within the
> > boundaries of a single array field, never crossing into another field.
>
> Likely yes, but why?

No reason, just seems sane. But it also doesn't matter for the
discussion at hand.

> You're trying hard to collapse the switch statement in regsafe()
> while claiming it's a safer way. I don't see it this way.
> For example the upcoming active_lock_id would need its own check_ids() call.
> It will be necessary for PTR_TO_BTF_ID only.
> Why collapse the switch into 'default:' just to bring some back?
> The default without checking active_lock_id through check_ids
> would be wrong, so collapsed switch doesn't make things safer.

I'm saying it's sane default and is better than what we have today.
The reason I want(ed) to make default case doing proper range checks
(if they are set) is so that we don't miss cases like PTR_TO_MEM and
PTR_TO_BUF in the future.

Your point is that some register will need a custom/extra check is
correct, obviously (just like we have PTR_TO_STACK extra frameno
check), and doesn't contradict what I'm saying. We still need to be
careful for new register types or further changes to existing ones.

>
> > But just to take a step back, from my perspective var_off and
> > range_within are complementary and solve slightly different uses, but
> > should be both satisfied:
> >   - var_off is not precise with range boundaries (due to some bits too
> > coarsely marked as unknown), but it's useful to enforce having a value
> > being a multiple of some power-of-2 (e.g., knowing for sure that
> > lowest 2 bits are zero means that value is multiple of 4; I haven't
> > checked, but I assume we check with for various pointer accesses to
> > ensure we don't have misaligned reads). They can be only approximately
> > used for actual possible range of values.
>
> Right. var_off is used for alignment checking too. grep tnum_is_aligned.
> We have bare minimum of testing for that though.
> Only few tests in the test_verifier use BPF_F_STRICT_ALIGNMENT
>
> >   - range_within() can and should be used for *precise* range of value
> > tracking, but it can't express that alignment restriction.
>
> Right.
>
> > So while I previously thought that we can do away without var_off, I
> > now think there are cases when it's necessary. But if we are sure that
> > we handle any SCALAR case correctly for any possible var_off +
> > range_within situation, it should be fine to do that for any mem-like
> > pointer just as much, as var_off+range_within is basically a MEM +
> > SCALAR combined case.
>
> Right. Likely true.
>
> > Anyways, I'm not blocked on this, but I think we'll benefit from
> > taking this discussion to its logical conclusion.
>
> Not sure what conclusion you're looking for.

Seeing if I'm missing something. Now I don't think I am. That's the
conclusion I was looking for.

We don't have to make the default case do range_within(), I'll just
explicitly add PTR_TO_MEM and PTR_TO_BUF into PTR_TO_MAP_{VALUE,KEY}
case in a future patch set.
