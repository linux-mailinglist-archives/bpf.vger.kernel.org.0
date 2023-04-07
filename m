Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9F16DA7DB
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDGC5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 22:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDGC5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 22:57:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E7D5FE4
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 19:57:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-4fa81d4f49cso1516559a12.1
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 19:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680836271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+a4eZSgn83XF54YAmorsBKeYT+C6PFcM0JZU4j//Jg=;
        b=LWxeatE4ETpL++9O+k5USOdpqK74ADTXHrBIiVAGXizpfUV6r//biYzmajhoYB5/Hv
         1plxv23CY2+0uC5CRQv/PRujU/6r+vPeOmBBck2pEEjNHgGvHjxM2+2nZEiMSdyBofqf
         8glz4U8fC/ZsqH0D78MQAL6RA29xS8bLRPKq24Gwx/IsMOGDpaoSqRtBq8X6wTdz2OHD
         kAUVgEtV5g1piWuIjmVOfUCwcXEZUhAUMPlM57H4reV+VowJK6xjrfJxB/+wiSK6cbgT
         PeNa4t6VWEwHF/woGVgG+C7OGct6olPH2heIuHPmhiC3n0weAiJtk9jGkEsBuIEkmnIQ
         NVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680836271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+a4eZSgn83XF54YAmorsBKeYT+C6PFcM0JZU4j//Jg=;
        b=6k6Ea0YmgZ188fb1Y3Sxpb/jXT5OMIHtwvHSNI4SClNJZMkOUFu6aAFW0ucPP3/ArS
         qF9zF7bFtitjpgPSASogFtUb8rs06JI20U6/XOc4xJQt8pAjXEBwIe4fV8zeaBif6o4q
         V1+tS0hIp6gYiRMoxaEl5FGCUqINxvvfVvnolNN1fYrkBWnvao/X1cvgJVfuzDeL74RA
         wHLNMUvWdaekNh7Clj9NybK/0J7LbjI8FZ0+ONYCZoXwctuenirfj2zHIYMckPf1Tc0e
         WUYL4sxt8qX++pzcnqacgJcZ4ZQ9mRgJrTmOBDN+wuHQ73geAbLsuW4LDsoRCMmgtyFu
         U/qA==
X-Gm-Message-State: AAQBX9d2Wp1tJcv2vp9gZgUUJ/mw+lKgeR0PTbhbZ+jNgs4xQJOzj0X0
        Cv4E3E3PhRvYsJyKTB79p1avIB5zVjqxsg==
X-Google-Smtp-Source: AKy350ZXAXKadkBAFGIMXABQGxda++QELJIvYkHfNOJNgbOYjKqiJDYEPZVcUfavxQJJom6ztNlmYg==
X-Received: by 2002:aa7:d891:0:b0:4fa:ee01:a0cb with SMTP id u17-20020aa7d891000000b004faee01a0cbmr296153edq.32.1680836270441;
        Thu, 06 Apr 2023 19:57:50 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id i17-20020a50d751000000b004fa19f5ba99sm1416105edj.79.2023.04.06.19.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:57:49 -0700 (PDT)
Date:   Fri, 7 Apr 2023 04:57:48 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks
 in helpers and kfuncs
Message-ID: <wlbng3zbk63ezpy7bqv7oezcwc7ctgbp3wy7fvvdeh7cauejzi@ub67so7yzamb>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-5-memxor@gmail.com>
 <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
 <20230407021519.j5esh3lbt6c6goz5@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407021519.j5esh3lbt6c6goz5@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 04:15:19AM CEST, Alexei Starovoitov wrote:
> On Fri, Apr 07, 2023 at 02:07:06AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Apr 06, 2023 at 04:21:39AM CEST, Alexei Starovoitov wrote:
> > > On Wed, Apr 05, 2023 at 02:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > @@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> > > >
> > > >  	for (i = 0; i < nr_loops; i++) {
> > > >  		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> > > > +		if (bpf_get_exception())
> > > > +			return -EJUKEBOX;
> > >
> > > This is too slow.
> > > We cannot afford a call and conditional here.
> >
> > There are two more options here: have two variants, one with and without the
> > check (always_inline template and bpf_loop vs bpf_loop_except calling functions
> > which pass false/true) and dispatch to the appropriate one based on if callback
> > throws or not (so the cost is not paid for current users at all). Secondly, we
> > can avoid repeated calls by hoisting the call out and save the pointer to
> > exception state, then it's a bit less costly.
> >
> > > Some time ago folks tried bpf_loop() and went back to bounded loop, because
> > > the overhead of indirect call was not acceptable.
> > > After that we've added inlining of bpf_loop() to make overhead to the minimum.
> > > With prog->aux->exception[] approach it might be ok-ish,
> > > but my preference would be to disallow throw in callbacks.
> > > timer cb, rbtree_add cb are typically small.
> > > bpf_loop cb can be big, but we have open coded iterators now.
> > > So disabling asserts in cb-s is probably acceptable trade-off.
> >
> > If the only reason to avoid them is the added performance cost, we can work
> > towards eliminating that when bpf_throw is not used (see above). I agree that
> > supporting it everywhere means thinking about a lot more corner cases, but I
> > feel it would be less surprising if doing bpf_assert simply worked everywhere.
> > One of the other reasons is that if it's being used within a shared static
> > function that both main program and callbacks call into, it will be a bit
> > annoying that it doesn't work in one context.
>
> I hope with open coded iterators the only use case for callbacks will be timers,
> exception cb and rbtree_add. All three are special cases.

There's also bpf_for_each_map_elem, bpf_find_vma, bpf_user_ringbuf_drain.

> There is nothing to unwind in the timer case.
> Certinaly not allowed to rethrow in exception cb.
> less-like rbtree_add should be tiny. And it's gotta to be fast.

I agree for some of the cases above they do not matter too much. The main one
was bpf_loop, and the ones I listed (like for_each_map) seem to be those where
people may do siginificant work in the callback.

I think we can make it zero cost for programs that don't use it (even for the
kernel code), I was just hoping to be able to support it everywhere as a generic
helper to abort program execution without any special corner cases during usage.
The other main point was about code sharing of functions which makes use of
assertions. But I'm ok with dropping support for callbacks if you think it's not
worth it in the end.
