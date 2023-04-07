Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C226DA79B
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 04:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbjDGCPf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 22:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbjDGCP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 22:15:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB8AF25
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 19:15:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kx12so139869plb.12
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680833722; x=1683425722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAeRBwyKqOw4y6BrOG5zAA5PTY8wFZm1ZxV06U1RJ4A=;
        b=U4d6rh/FL1GWuZSVDAh/IRpbhBOBFGMWU7+HioR4V41pDt4PnSad00dmXjZNIMdcnE
         PPDvNeGHQZ+7RTYDvYw71r5Y2A5cSe8J1+Pc+cCTXiJICjR1XfB87caXDEFqTUYKqcZE
         baVlgRTcCbpATgPZCd5SrFaLr6ypl/boaxvz7eHHJEK9VHe6F0gTLmHOEViTqPvJBe4C
         hjAZl0nZhd8f9JInlaGBynAd6uFpX3fOITlSKVH2Cpf3HP9X51mKKHpu3DXnqjstFe7A
         a+LawM9Ws8EP/py68/HSq0GeeTFC1Zs/D/W7Z9buGVms487jC9HBm7UCOTTzSNfqWJRZ
         34fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680833722; x=1683425722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAeRBwyKqOw4y6BrOG5zAA5PTY8wFZm1ZxV06U1RJ4A=;
        b=qipGtZYP0RI0GyHa4DUQVLwPcz8a2MVL3ke4BTiprR/ItymlR9jE4/NWpSc2OqMSwp
         boDlQHMuWRdggUiddsM4ATXWiH6MvkOIzsegz9NN3HlD0OmflaLCcEXSZ2UIkkUvnVnz
         Z3BHi+obBtP4HufwpfWGc5nejEX7ECFCD2U/KEzyDYbq1koNJzYQsbjNhiHVhPg7plAx
         mAvOz2mj+23KD4AEhLb+KMVTzGtibml3Ky5B1HjwnQvfLTX+1cOoJhxpy51RwGxRy7k6
         ddMQFkUg6JIYEwi8utFd9pDTJ6q3jFmGRyx6u6sv/c12gaDzIJBMtWk8NauEumrjnh30
         AfDQ==
X-Gm-Message-State: AAQBX9ekAtBJB66vNGgjf3oVideyn5ZuHrikVN/g2/a2foFfMWBLesuA
        1wof543SuPn/7Pv9wLfGjQA=
X-Google-Smtp-Source: AKy350Zie6KUJWXBHnOg5g+3B1mioK0ULjENe/78ciTSzPe7gjunufC3/EuhuySlPtxakFAeyMMzZQ==
X-Received: by 2002:a05:6a20:f2a:b0:d7:3c1a:6ce5 with SMTP id fl42-20020a056a200f2a00b000d73c1a6ce5mr1286131pzb.47.1680833721537;
        Thu, 06 Apr 2023 19:15:21 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5abd])
        by smtp.gmail.com with ESMTPSA id j6-20020a62b606000000b0062e36fde14fsm1926632pff.194.2023.04.06.19.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:15:21 -0700 (PDT)
Date:   Thu, 6 Apr 2023 19:15:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks
 in helpers and kfuncs
Message-ID: <20230407021519.j5esh3lbt6c6goz5@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-5-memxor@gmail.com>
 <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 02:07:06AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, Apr 06, 2023 at 04:21:39AM CEST, Alexei Starovoitov wrote:
> > On Wed, Apr 05, 2023 at 02:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > @@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> > >
> > >  	for (i = 0; i < nr_loops; i++) {
> > >  		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> > > +		if (bpf_get_exception())
> > > +			return -EJUKEBOX;
> >
> > This is too slow.
> > We cannot afford a call and conditional here.
> 
> There are two more options here: have two variants, one with and without the
> check (always_inline template and bpf_loop vs bpf_loop_except calling functions
> which pass false/true) and dispatch to the appropriate one based on if callback
> throws or not (so the cost is not paid for current users at all). Secondly, we
> can avoid repeated calls by hoisting the call out and save the pointer to
> exception state, then it's a bit less costly.
> 
> > Some time ago folks tried bpf_loop() and went back to bounded loop, because
> > the overhead of indirect call was not acceptable.
> > After that we've added inlining of bpf_loop() to make overhead to the minimum.
> > With prog->aux->exception[] approach it might be ok-ish,
> > but my preference would be to disallow throw in callbacks.
> > timer cb, rbtree_add cb are typically small.
> > bpf_loop cb can be big, but we have open coded iterators now.
> > So disabling asserts in cb-s is probably acceptable trade-off.
> 
> If the only reason to avoid them is the added performance cost, we can work
> towards eliminating that when bpf_throw is not used (see above). I agree that
> supporting it everywhere means thinking about a lot more corner cases, but I
> feel it would be less surprising if doing bpf_assert simply worked everywhere.
> One of the other reasons is that if it's being used within a shared static
> function that both main program and callbacks call into, it will be a bit
> annoying that it doesn't work in one context.

I hope with open coded iterators the only use case for callbacks will be timers,
exception cb and rbtree_add. All three are special cases.
There is nothing to unwind in the timer case.
Certinaly not allowed to rethrow in exception cb.
less-like rbtree_add should be tiny. And it's gotta to be fast.
