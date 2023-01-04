Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3065E011
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 23:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjADWf1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 17:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjADWf0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 17:35:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E57C42E00
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 14:35:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o2so32291188pjh.4
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 14:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16xp0Ny29Nkv4172hDYB/4erWPv+elMmk2a21V3qfrg=;
        b=IYQc6/BR8oV/io1GlaxTrpE2Vv59OuuI1IfzO1Uclad7LwuMGaY52zuEGIXmkRB2nx
         bBKn9+Yu5Kb1ykw4heVhPOVxwIwqpmXAHi02hmDrNTsxMgz6W9sWqxR9mV0l2uNvdHYO
         PRgrQLDM7GoWVmYIcThimdyniFLJlsFWNbvqlsYwsMprYWQ1FKJ7GRHMj0/7xS8+KKhK
         4QNg8ul1awa2bXP95TPCFn4Q8MjAz3bxDW6kNYJpnhs7SvI7XhHgyU49brKfhvvh2pBA
         bG70oDMsXfuTZ+O6fTTxtkye8OVcZKRmhI62jBic38iptQKKdJ92cWCUQMengzbgiKp7
         Hx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16xp0Ny29Nkv4172hDYB/4erWPv+elMmk2a21V3qfrg=;
        b=Cd9syHV9qTn0boBmiksuU3teEPLBIsE4FydfvP+yW01h7emW/+mil31fgf6teEPqlk
         p3WGUb/BcpNwUKVsxqrUTERBeR6o5FsC9Si0iMY3zmvG/eaYGgBfpfgfzDLsYImkZDju
         C3n9II7zD1pUNk/A0bk9Vc76r64f/npWtf71z2YJ9GaokW5vAOSykS4Myn2f68LWy188
         HaPDh9gxPrxJj6tf4i3WPT9v+3l8lYAh2jmQ5+0ZOGPz2dd6pjLIaV2SNfBu1rxvgLmL
         cSnOrbGrj/CheiYxDiFmglOsIHnV+ctSJWmJchcxSMtJcGsr71fwr/bFxxPkwk5qfq5k
         AbRg==
X-Gm-Message-State: AFqh2kpQOKKuen2c44QJ/gzUtj5bEYSIzfQ9g97LtL9dxs2awUhsdYaS
        IrWt7g+f3HBforjlb1+jdXg=
X-Google-Smtp-Source: AMrXdXt2FLeMFLp51KfoM2qLNv4ZXGF3a2Lc7vxTmKQL37tG0378FmUs963AQ5dCmcXFY9g19zrkdQ==
X-Received: by 2002:a17:90a:d784:b0:226:a539:1dfe with SMTP id z4-20020a17090ad78400b00226a5391dfemr5593049pju.11.1672871724708;
        Wed, 04 Jan 2023 14:35:24 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id f62-20020a17090a704400b00225f49bd4b6sm50492pjk.36.2023.01.04.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:35:24 -0800 (PST)
Date:   Wed, 4 Jan 2023 14:35:21 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
Message-ID: <20230104223521.hi2wvabfn7ldgh6o@macbook-pro-6.dhcp.thefacebook.com>
References: <20221223054921.958283-1-andrii@kernel.org>
 <20221223054921.958283-8-andrii@kernel.org>
 <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com>
 <20221230021917.yuvm4g7sjj7vy5qc@MacBook-Pro-6.local>
 <CAEf4BzaaE1B0Xezb5jrH0p-my4_GEb7EPqfAQVBPLyLkq672=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaaE1B0Xezb5jrH0p-my4_GEb7EPqfAQVBPLyLkq672=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 03, 2023 at 02:04:44PM -0800, Andrii Nakryiko wrote:
> > It sounds logical, but it can get tricky with ranges and branch taken logic.
> > Consider something like:
> > R1=(min=2,max=8), R2=(min=1, max=10)
> > if (R1 within R2) // bpf prog is doing its own 'within'
> 
> a bit confused what is "R1 within R2" here and what you mean "bpf prog
> is doing its own 'within'"? Any sort of `R1 < R2` checks (and any
> other op: <=, >=, etc) can't really kick in branch elimination because
> R2_min=1 < R1_max=8, so arithmetically speaking we can't conclude that
> "R1 is always smaller than R2", so both branches would have to be
> examined.

Something like that. Details didn't matter to me.
It was hypothetical 'within' operation just to illustrate the point.

> But I probably misunderstood your example, sorry.
> 
> >   // branch taken kicks in
> > else
> >   // issues that were never checked
> >
> > Now new state has:
> > R1=(min=4,max=6), R2=(min=5, max=5)
> >
> > Both R1 and R2 of new state individually range_within of old safe state,
> > but together the prog may go to the unverified path.
> > Not sure whether it's practical today.
> > You asked for hypothetical, so here it goes :)
> 
> No problem with "hypothetical-ness". But my confusion and argument is
> similarly "in principle"-like. Because if such an example above can be
> constructed then this would be an issue for SCALAR as well, right? And
> if you can bypass verifier's safety with SCALAR, you (hypothetically)
> could use that SCALAR to do out-of-bounds memory access by adding this
> SCALAR to some mem-like register.

Correct. The issue would apply to regular scalar if such 'within' operation
was available.

> So that's my point and my source of confusion: if we don't trust
> var_off+range_within() logic to handle *all* situations correctly,
> then we should be worried about SCALARs just as much as anything else
> (unless, as usual, I missed something).

Yes. I personally don't believe that doing range_within for all regtypes
by default is a safer way forward.
The example wasn't real. It was trying to demonstrate a possible issue.
You insist to see a real example with range_within.
I don't have it. It's a gut feel that it could be there because
I could construct it with fake 'within'.

> > More gut feel than real issue.
> >
> > >
> > > >
> > > > SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
> > > > Keeping default as regs_exact (that does ID match) is safer default.
> > >
> > > It's fine, though the point of this patch set was patch #7, enabling
> > > logic similar to PTR_TO_MAP_VALUE for PTR_TO_MEM and PTR_TO_BUF. I can
> > > send specific fixes for that, no problem. But as I said above, I'm
> > > really curious to understand what kind of situations will lead to
> > > unsafety if we do var_off+range_within checks.
> >
> > PTR_TO_MEM and PTR_TO_BUF explicitly are likely ok despite my convoluted
> > example above.
> > I'm less sure about PTR_TO_BTF_ID. It could be ok.
> > Just feels safer to opt-in each type explicitly.
> 
> Sure, I can just do a simple opt-in, no problem. As I said, mostly
> trying to understand the issue overall.
> 
> For PTR_TO_BTF_ID specifically, I can see how we can enable
> var_off+range_within for cases when we access some array, right? But
> then I think we'll be enforcing that we are staying within the
> boundaries of a single array field, never crossing into another field.

Likely yes, but why?
You're trying hard to collapse the switch statement in regsafe()
while claiming it's a safer way. I don't see it this way.
For example the upcoming active_lock_id would need its own check_ids() call.
It will be necessary for PTR_TO_BTF_ID only.
Why collapse the switch into 'default:' just to bring some back?
The default without checking active_lock_id through check_ids
would be wrong, so collapsed switch doesn't make things safer.

> But just to take a step back, from my perspective var_off and
> range_within are complementary and solve slightly different uses, but
> should be both satisfied:
>   - var_off is not precise with range boundaries (due to some bits too
> coarsely marked as unknown), but it's useful to enforce having a value
> being a multiple of some power-of-2 (e.g., knowing for sure that
> lowest 2 bits are zero means that value is multiple of 4; I haven't
> checked, but I assume we check with for various pointer accesses to
> ensure we don't have misaligned reads). They can be only approximately
> used for actual possible range of values.

Right. var_off is used for alignment checking too. grep tnum_is_aligned.
We have bare minimum of testing for that though.
Only few tests in the test_verifier use BPF_F_STRICT_ALIGNMENT

>   - range_within() can and should be used for *precise* range of value
> tracking, but it can't express that alignment restriction.

Right.

> So while I previously thought that we can do away without var_off, I
> now think there are cases when it's necessary. But if we are sure that
> we handle any SCALAR case correctly for any possible var_off +
> range_within situation, it should be fine to do that for any mem-like
> pointer just as much, as var_off+range_within is basically a MEM +
> SCALAR combined case.

Right. Likely true.

> Anyways, I'm not blocked on this, but I think we'll benefit from
> taking this discussion to its logical conclusion.

Not sure what conclusion you're looking for.
