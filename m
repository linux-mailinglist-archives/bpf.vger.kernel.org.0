Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E546E1874
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 01:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjDMXl7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 19:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDMXl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 19:41:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F1710C1
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 16:41:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so19938742pja.2
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681429316; x=1684021316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulqJBOxe2R1WB7ubIHijFA0IRLghmqezEGsJd863YjQ=;
        b=mb69KXH5PdX5pUvCoSwb/MPLOhuuZN7kopY7QP78XyycWuqPIfd95fX82jQGSLT95+
         F1kA1l+CS5XvzyusyMaqpAZ5qcEZ8Kc+I/pRwNUl6+uIA78D7llrauInNoLY2IEDjaEm
         KW46WIQZYgs3xsg3aj4gNMpDssqIQovwo8KjSS6GXDn3NONvMaDEoduQzFx837XjfVcs
         O+6+OLwOVYeCtbJmWecrWxOB+PkU3zDXJIXESbuxX3naPpA66/Ce79mAipYXpXqeesFW
         dPt164zfHtWIBOpFc9IsZZIzZFzKwSmzBBHVgq1ejhlCHRpHjc15XwZ91APTHd2AG/cx
         ax5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681429316; x=1684021316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulqJBOxe2R1WB7ubIHijFA0IRLghmqezEGsJd863YjQ=;
        b=Vwcgg/4T4OIrNOTLsGrtbnZGAQYtqwVAiTiSeA7eDg3r9MJ4oUDmoAx3D3R8aGgHcL
         ouayAj7kt2P926n5KREyNelqsBbk+RLt7iWF/Qj4lO72f/aho10EQrLiXprg9EaOhwvp
         XWrDCRxBdGx8YaMmgMRa0D50DpLAkk5XERy95QBZ/GdVqAK9Q/b/2AjeW/gT3jUfU/41
         zRA+YLZ8lvMCY9tbtDnVIftJtu/Wcuv9SDMRCJ8gX7zRjdVZ8RcAn2fL3T/Oi/r5LV48
         1DOYVV9zp6VRlunXb192GLcXwPeQgmwaNl2YFhOGUtl+sGPPI3CnVkUFWTTf62ooytL5
         S9Pg==
X-Gm-Message-State: AAQBX9f4oqOD9S7eWJKAxu1VAbXU04+RJq64pmc7U3kS9jwL0mrtLvkT
        J/5BDdxEz3j83aYDBSzR3SI=
X-Google-Smtp-Source: AKy350ZDBSXeZ6pHSsBwDIeCH7dL3mgCWyg55QlPtWETYNDWQKCVUCxZ+VMS9llYa7bbPdxlpVxBkQ==
X-Received: by 2002:a17:90b:3005:b0:247:ea8:1ac1 with SMTP id hg5-20020a17090b300500b002470ea81ac1mr3554021pjb.11.1681429316163;
        Thu, 13 Apr 2023 16:41:56 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5f5b])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090a0c4800b002469eea5559sm1774042pje.6.2023.04.13.16.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:41:55 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:41:52 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks
 in helpers and kfuncs
Message-ID: <20230413234152.c5canwh6imvbf5al@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-5-memxor@gmail.com>
 <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
 <20230407021519.j5esh3lbt6c6goz5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <wlbng3zbk63ezpy7bqv7oezcwc7ctgbp3wy7fvvdeh7cauejzi@ub67so7yzamb>
 <20230412194306.ltiiutzilk25hnll@macbook-pro-6.dhcp.thefacebook.com>
 <w6j2sqr77mtsldysqjx5fs4ohso45ac352azjpzneqdarm2mwh@2i7tnmwd35dr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6j2sqr77mtsldysqjx5fs4ohso45ac352azjpzneqdarm2mwh@2i7tnmwd35dr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 07:13:22PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Wed, Apr 12, 2023 at 09:43:06PM CEST, Alexei Starovoitov wrote:
> > On Fri, Apr 07, 2023 at 04:57:48AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Fri, Apr 07, 2023 at 04:15:19AM CEST, Alexei Starovoitov wrote:
> > > > On Fri, Apr 07, 2023 at 02:07:06AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > On Thu, Apr 06, 2023 at 04:21:39AM CEST, Alexei Starovoitov wrote:
> > > > > > On Wed, Apr 05, 2023 at 02:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > > > @@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> > > > > > >
> > > > > > >  	for (i = 0; i < nr_loops; i++) {
> > > > > > >  		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> > > > > > > +		if (bpf_get_exception())
> > > > > > > +			return -EJUKEBOX;
> > > > > >
> > > > > > This is too slow.
> > > > > > We cannot afford a call and conditional here.
> > > > >
> > > > > There are two more options here: have two variants, one with and without the
> > > > > check (always_inline template and bpf_loop vs bpf_loop_except calling functions
> > > > > which pass false/true) and dispatch to the appropriate one based on if callback
> > > > > throws or not (so the cost is not paid for current users at all). Secondly, we
> > > > > can avoid repeated calls by hoisting the call out and save the pointer to
> > > > > exception state, then it's a bit less costly.
> > > > >
> > > > > > Some time ago folks tried bpf_loop() and went back to bounded loop, because
> > > > > > the overhead of indirect call was not acceptable.
> > > > > > After that we've added inlining of bpf_loop() to make overhead to the minimum.
> > > > > > With prog->aux->exception[] approach it might be ok-ish,
> > > > > > but my preference would be to disallow throw in callbacks.
> > > > > > timer cb, rbtree_add cb are typically small.
> > > > > > bpf_loop cb can be big, but we have open coded iterators now.
> > > > > > So disabling asserts in cb-s is probably acceptable trade-off.
> > > > >
> > > > > If the only reason to avoid them is the added performance cost, we can work
> > > > > towards eliminating that when bpf_throw is not used (see above). I agree that
> > > > > supporting it everywhere means thinking about a lot more corner cases, but I
> > > > > feel it would be less surprising if doing bpf_assert simply worked everywhere.
> > > > > One of the other reasons is that if it's being used within a shared static
> > > > > function that both main program and callbacks call into, it will be a bit
> > > > > annoying that it doesn't work in one context.
> > > >
> > > > I hope with open coded iterators the only use case for callbacks will be timers,
> > > > exception cb and rbtree_add. All three are special cases.
> > >
> > > There's also bpf_for_each_map_elem, bpf_find_vma, bpf_user_ringbuf_drain.
> > >
> > > > There is nothing to unwind in the timer case.
> > > > Certinaly not allowed to rethrow in exception cb.
> > > > less-like rbtree_add should be tiny. And it's gotta to be fast.
> > >
> > > I agree for some of the cases above they do not matter too much. The main one
> > > was bpf_loop, and the ones I listed (like for_each_map) seem to be those where
> > > people may do siginificant work in the callback.
> > >
> > > I think we can make it zero cost for programs that don't use it (even for the
> > > kernel code), I was just hoping to be able to support it everywhere as a generic
> > > helper to abort program execution without any special corner cases during usage.
> > > The other main point was about code sharing of functions which makes use of
> > > assertions. But I'm ok with dropping support for callbacks if you think it's not
> > > worth it in the end.
> >
> > I think the unexpected run-time slowdown due to checks is a bigger problem.
> > Since bpf_assert is a 'bad program detector' it should be as zero cost to run-time
> > as possible. Hence I'm advocating for single load+jmp approach of prog->aux->exception.
> 
> I 100% agree, slow down is a big problem and a downside of the current version.
> They need to be as lightweight as possible. It's too costly right now in this
> set.
> 
> > The run-time matter more than ability to use assert in all conditions. I think
> > we'd need two flavors of bpf_assert() asm macros: with and without
> > bpf_throw(). They seem to be useful without actual throw. They will help the
> > verifier understand the ranges of variables in both cases. The macros are the
> > 99% of the feature. The actual throw mechanism is 1%. The unwinding and
> > release of resource is a cost of using macros without explicit control flow in
> > the bpf programs. The macros without throw might be good enough in many cases.
> 
> Ok, I'll update to allow for both variants. But just to confirm, do you want to
> shelve automatic cleanup (part 2 for now), or want to add it? I'm not clear on
> whether you agree or disagree it's necessary.
> 
> I'll try the prog->aux->exception route, but I must say that we're sort of
> trading off simpler semantics/behavior for speedup in that case (which is
> necessary, but it is a cost IMO). I'll post a version using that, but I'll also
> add comparisons with the variant where we spill ptr to exception state and
> load+jmp. It's an extra instruction but I will try to benchmark and see how much
> difference it causes in practice (probably over the XDP benchmark using such
> exceptions, since that's one of the most important performance-critical use
> cases). If you agree, let's double down on whatever approach we choose after
> analysing the difference?

I think performance considerations dominate implementation and ease of use.
Could you describe how 'spill to exception state' will look like?
I think the check after bpf_call insn has to be no more than LD + JMP.
I was thinking whether we can do static_key like patching of the code.
bpf_throw will know all locations that should be converted from nop into check
and will do text_poke_bp before throwing.
Maybe we can consider offline unwind and release too. The verifier will prep
release tables and throw will execute them. BPF progs always have frame pointers,
so walking the stack back is relatively easy. Release per callsite is hard.

As far as benchmarking I'd use selftests/bpf/bench. No need for real network XDP.
