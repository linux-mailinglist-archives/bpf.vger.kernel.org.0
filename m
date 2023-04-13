Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13A26E1344
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDMRNk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMRNj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 13:13:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5265AB
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 10:13:25 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id sg7so50577155ejc.9
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681406004; x=1683998004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2a9tpd3zneSP3CrmMO3TXDAz+kbg/RVYM/MPhtJjAY=;
        b=c59ZCjjGfUyZQFBWB7YuiYjIJqYm0oDUifXE9G9Fm2mw1pGNANmXiKvvugpyKBMzWG
         VGeebfwc21JCuNeH0tP5RNPyXUofNlYrrSh1nqYWiJVoApeWC8wznJpcQlmE7tvZLhHr
         o2K1nghHbd7rV1qFqjjt3luzXIPQHWwYczwQCFszQtYxHQaoSoFp3ZVBN9URki31AuW9
         B6kV9vA3IHCA9KVjJu0t1exC898NvLXbQnIZFzNgdTuZbCnWjfXT6y1U/4qAsHoIndK8
         HUJrUNdpIuvi2gGtjvHNQCPUteiu1I+l1LpGK+VnUMBI/K9JkS2B7hklm8sZeQzbMZiS
         n+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681406004; x=1683998004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2a9tpd3zneSP3CrmMO3TXDAz+kbg/RVYM/MPhtJjAY=;
        b=bKaImgijP/V3DsBMJuyjfdySWQlvh+UIo3BMwL4Q1ubPu5Y0TcQQh/n8rLoajzqSxq
         ls0yaLY2ryNFB88ksy9SG3xdk6pv6jjH+pEZYSI0fjrFTX+PFt+Oc4Y1OogH5PoCEao+
         rbXjGtlOh8CVwskiGN9YsdnVKTm7d9yl0V7jl/aj7HbSyXtUhAjHfAtwRvBEjjxtaeAl
         gVswcqWD46+UXi+HdRQmlCafCUybdM/Jhv4HsUDlCWP+jTxbyUSAM9igW+4Qlgq3fz+v
         qdsjx25ptD595t04GHK62VMi3eGEnFMD4Oi4krkEBtQkb9jhjipVG/39qyi1RWBEV+7e
         5CsA==
X-Gm-Message-State: AAQBX9e7RHYmU3Ymfee53WAHB7LmKKqUdyy11ftwn2x2hKL49tM3+50y
        sD9cz9u3t86iyU9xqyoGP5s=
X-Google-Smtp-Source: AKy350YcYx6gLH5LGjVpO3g1A/If8YDT6osPOmkZJtTGCTjhJSLgnTnbRGiLdzCM5tbFdcQbUDA31g==
X-Received: by 2002:a17:906:d8b1:b0:93f:505b:9742 with SMTP id qc17-20020a170906d8b100b0093f505b9742mr3372663ejb.65.1681406003469;
        Thu, 13 Apr 2023 10:13:23 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00947740a4373sm1218371ejm.81.2023.04.13.10.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 10:13:23 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:13:22 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks
 in helpers and kfuncs
Message-ID: <w6j2sqr77mtsldysqjx5fs4ohso45ac352azjpzneqdarm2mwh@2i7tnmwd35dr>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-5-memxor@gmail.com>
 <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
 <20230407021519.j5esh3lbt6c6goz5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <wlbng3zbk63ezpy7bqv7oezcwc7ctgbp3wy7fvvdeh7cauejzi@ub67so7yzamb>
 <20230412194306.ltiiutzilk25hnll@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412194306.ltiiutzilk25hnll@macbook-pro-6.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 09:43:06PM CEST, Alexei Starovoitov wrote:
> On Fri, Apr 07, 2023 at 04:57:48AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Fri, Apr 07, 2023 at 04:15:19AM CEST, Alexei Starovoitov wrote:
> > > On Fri, Apr 07, 2023 at 02:07:06AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Thu, Apr 06, 2023 at 04:21:39AM CEST, Alexei Starovoitov wrote:
> > > > > On Wed, Apr 05, 2023 at 02:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > > @@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> > > > > >
> > > > > >  	for (i = 0; i < nr_loops; i++) {
> > > > > >  		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> > > > > > +		if (bpf_get_exception())
> > > > > > +			return -EJUKEBOX;
> > > > >
> > > > > This is too slow.
> > > > > We cannot afford a call and conditional here.
> > > >
> > > > There are two more options here: have two variants, one with and without the
> > > > check (always_inline template and bpf_loop vs bpf_loop_except calling functions
> > > > which pass false/true) and dispatch to the appropriate one based on if callback
> > > > throws or not (so the cost is not paid for current users at all). Secondly, we
> > > > can avoid repeated calls by hoisting the call out and save the pointer to
> > > > exception state, then it's a bit less costly.
> > > >
> > > > > Some time ago folks tried bpf_loop() and went back to bounded loop, because
> > > > > the overhead of indirect call was not acceptable.
> > > > > After that we've added inlining of bpf_loop() to make overhead to the minimum.
> > > > > With prog->aux->exception[] approach it might be ok-ish,
> > > > > but my preference would be to disallow throw in callbacks.
> > > > > timer cb, rbtree_add cb are typically small.
> > > > > bpf_loop cb can be big, but we have open coded iterators now.
> > > > > So disabling asserts in cb-s is probably acceptable trade-off.
> > > >
> > > > If the only reason to avoid them is the added performance cost, we can work
> > > > towards eliminating that when bpf_throw is not used (see above). I agree that
> > > > supporting it everywhere means thinking about a lot more corner cases, but I
> > > > feel it would be less surprising if doing bpf_assert simply worked everywhere.
> > > > One of the other reasons is that if it's being used within a shared static
> > > > function that both main program and callbacks call into, it will be a bit
> > > > annoying that it doesn't work in one context.
> > >
> > > I hope with open coded iterators the only use case for callbacks will be timers,
> > > exception cb and rbtree_add. All three are special cases.
> >
> > There's also bpf_for_each_map_elem, bpf_find_vma, bpf_user_ringbuf_drain.
> >
> > > There is nothing to unwind in the timer case.
> > > Certinaly not allowed to rethrow in exception cb.
> > > less-like rbtree_add should be tiny. And it's gotta to be fast.
> >
> > I agree for some of the cases above they do not matter too much. The main one
> > was bpf_loop, and the ones I listed (like for_each_map) seem to be those where
> > people may do siginificant work in the callback.
> >
> > I think we can make it zero cost for programs that don't use it (even for the
> > kernel code), I was just hoping to be able to support it everywhere as a generic
> > helper to abort program execution without any special corner cases during usage.
> > The other main point was about code sharing of functions which makes use of
> > assertions. But I'm ok with dropping support for callbacks if you think it's not
> > worth it in the end.
>
> I think the unexpected run-time slowdown due to checks is a bigger problem.
> Since bpf_assert is a 'bad program detector' it should be as zero cost to run-time
> as possible. Hence I'm advocating for single load+jmp approach of prog->aux->exception.

I 100% agree, slow down is a big problem and a downside of the current version.
They need to be as lightweight as possible. It's too costly right now in this
set.

> The run-time matter more than ability to use assert in all conditions. I think
> we'd need two flavors of bpf_assert() asm macros: with and without
> bpf_throw(). They seem to be useful without actual throw. They will help the
> verifier understand the ranges of variables in both cases. The macros are the
> 99% of the feature. The actual throw mechanism is 1%. The unwinding and
> release of resource is a cost of using macros without explicit control flow in
> the bpf programs. The macros without throw might be good enough in many cases.

Ok, I'll update to allow for both variants. But just to confirm, do you want to
shelve automatic cleanup (part 2 for now), or want to add it? I'm not clear on
whether you agree or disagree it's necessary.

I'll try the prog->aux->exception route, but I must say that we're sort of
trading off simpler semantics/behavior for speedup in that case (which is
necessary, but it is a cost IMO). I'll post a version using that, but I'll also
add comparisons with the variant where we spill ptr to exception state and
load+jmp. It's an extra instruction but I will try to benchmark and see how much
difference it causes in practice (probably over the XDP benchmark using such
exceptions, since that's one of the most important performance-critical use
cases). If you agree, let's double down on whatever approach we choose after
analysing the difference?
