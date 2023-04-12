Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12E6DFEE0
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 21:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDLTnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjDLTnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 15:43:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF282690
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:43:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h24so12702399plr.1
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681328589; x=1683920589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28TZJOkYW5LMQa1C0LfwcgqX6XcFZs5T8JNmhZUUYks=;
        b=EyJFPgLlm7y06xrXDDvn3a+yYvT4Aq86D6t/pOeApozYx9qypSi/KXfI6qap2F/3J8
         CA3yNvRpFEpqjrM/OZWu4RTKyj8mJ+BQuqdLp0sh+xjmxKr9SQoGiMjmLw68GnUfdkfF
         o9y41eTRptsSL9aHMoeA5JK7QDwXR6bIOs8NqEsoRtQcKFpX4e3c7T8OiW1hx33HA+8W
         sWWIwbnCur5nvY6d3ZNybIyNQLy8Qg8YfMKeqWY1+sAsoxlmNcbPc5ao+3fel9p4sZrd
         b964V9AaC+wYS+MG5hw/KmrYgYZO3N3UMtS5J90lMIqRhdOo53J5Id2l+o6H4ibbF5lI
         iOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328589; x=1683920589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28TZJOkYW5LMQa1C0LfwcgqX6XcFZs5T8JNmhZUUYks=;
        b=MJkN2MUzy1x64fr5TmsetYUu47bvrjgnuua7WzYsShMAvJaUwycLqMLqc3TR4I+x+C
         9jGCGP9V8p9h0sMYXKZORemt1icJVEvRvOFaQylM6LfvQGjMdDpLKb8c3hxjT+8YFAlB
         3QMQ6Kcd+GN1/03LclbhUr/lILXBlEA4H+wuRPv88YYcyjgPdtOXp7JacI7yr8AwtDKX
         laIbez3H9vMOE3ReSxMGb4B+eWQUnJNiAJXyYXINV8RqHTm/AYq6RkxIySC/Zl5O/5yF
         xsvYRPDipY/4onTStmrn9MTMCWqcHblen9jrCq2xLdV8FlmuVavSy9fbWqfOrTm6k3oQ
         4o3w==
X-Gm-Message-State: AAQBX9dHnUKgQCPd3Stq3feNUJGO5ooCgd9f+J5SELQhttxBed19Z5eM
        Ur5cwlWtYE9HPo7xCBfnr58=
X-Google-Smtp-Source: AKy350bVnMhIEdsbqLjHCu1zqRsi+tKBxhnQoP7a3SwY4fnJWgF9XUucIU+FSHsgLByENSrOwVatjA==
X-Received: by 2002:a17:903:2092:b0:1a2:8f43:5449 with SMTP id d18-20020a170903209200b001a28f435449mr17157180plc.54.1681328589425;
        Wed, 12 Apr 2023 12:43:09 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:5010])
        by smtp.gmail.com with ESMTPSA id b20-20020a170902b61400b001a65258011bsm4148540pls.26.2023.04.12.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:43:09 -0700 (PDT)
Date:   Wed, 12 Apr 2023 12:43:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks
 in helpers and kfuncs
Message-ID: <20230412194306.ltiiutzilk25hnll@macbook-pro-6.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-5-memxor@gmail.com>
 <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
 <20230407021519.j5esh3lbt6c6goz5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <wlbng3zbk63ezpy7bqv7oezcwc7ctgbp3wy7fvvdeh7cauejzi@ub67so7yzamb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wlbng3zbk63ezpy7bqv7oezcwc7ctgbp3wy7fvvdeh7cauejzi@ub67so7yzamb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 04:57:48AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, Apr 07, 2023 at 04:15:19AM CEST, Alexei Starovoitov wrote:
> > On Fri, Apr 07, 2023 at 02:07:06AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Thu, Apr 06, 2023 at 04:21:39AM CEST, Alexei Starovoitov wrote:
> > > > On Wed, Apr 05, 2023 at 02:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > @@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> > > > >
> > > > >  	for (i = 0; i < nr_loops; i++) {
> > > > >  		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> > > > > +		if (bpf_get_exception())
> > > > > +			return -EJUKEBOX;
> > > >
> > > > This is too slow.
> > > > We cannot afford a call and conditional here.
> > >
> > > There are two more options here: have two variants, one with and without the
> > > check (always_inline template and bpf_loop vs bpf_loop_except calling functions
> > > which pass false/true) and dispatch to the appropriate one based on if callback
> > > throws or not (so the cost is not paid for current users at all). Secondly, we
> > > can avoid repeated calls by hoisting the call out and save the pointer to
> > > exception state, then it's a bit less costly.
> > >
> > > > Some time ago folks tried bpf_loop() and went back to bounded loop, because
> > > > the overhead of indirect call was not acceptable.
> > > > After that we've added inlining of bpf_loop() to make overhead to the minimum.
> > > > With prog->aux->exception[] approach it might be ok-ish,
> > > > but my preference would be to disallow throw in callbacks.
> > > > timer cb, rbtree_add cb are typically small.
> > > > bpf_loop cb can be big, but we have open coded iterators now.
> > > > So disabling asserts in cb-s is probably acceptable trade-off.
> > >
> > > If the only reason to avoid them is the added performance cost, we can work
> > > towards eliminating that when bpf_throw is not used (see above). I agree that
> > > supporting it everywhere means thinking about a lot more corner cases, but I
> > > feel it would be less surprising if doing bpf_assert simply worked everywhere.
> > > One of the other reasons is that if it's being used within a shared static
> > > function that both main program and callbacks call into, it will be a bit
> > > annoying that it doesn't work in one context.
> >
> > I hope with open coded iterators the only use case for callbacks will be timers,
> > exception cb and rbtree_add. All three are special cases.
> 
> There's also bpf_for_each_map_elem, bpf_find_vma, bpf_user_ringbuf_drain.
> 
> > There is nothing to unwind in the timer case.
> > Certinaly not allowed to rethrow in exception cb.
> > less-like rbtree_add should be tiny. And it's gotta to be fast.
> 
> I agree for some of the cases above they do not matter too much. The main one
> was bpf_loop, and the ones I listed (like for_each_map) seem to be those where
> people may do siginificant work in the callback.
> 
> I think we can make it zero cost for programs that don't use it (even for the
> kernel code), I was just hoping to be able to support it everywhere as a generic
> helper to abort program execution without any special corner cases during usage.
> The other main point was about code sharing of functions which makes use of
> assertions. But I'm ok with dropping support for callbacks if you think it's not
> worth it in the end.

I think the unexpected run-time slowdown due to checks is a bigger problem.
Since bpf_assert is a 'bad program detector' it should be as zero cost to run-time
as possible. Hence I'm advocating for single load+jmp approach of prog->aux->exception.
The run-time matter more than ability to use assert in all conditions.
I think we'd need two flavors of bpf_assert() asm macros: with and without bpf_throw().
They seem to be useful without actual throw. They will help the verifier understand
the ranges of variables in both cases. The macros are the 99% of the feature.
The actual throw mechanism is 1%. The unwinding and release of resource is a cost
of using macros without explicit control flow in the bpf programs.
The macros without throw might be good enough in many cases.
