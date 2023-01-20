Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D11674D5F
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjATGbR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATGbQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:31:16 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F8457F2
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:31:15 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v23so4544576plo.1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGyRU1WNsuE8ov8ULqACn584w4H+HPWKd0CH8fw/q4k=;
        b=gtEq9r/16K+k6wLDM1Uvt3J0eopvrVnvEwo+r9gqyp0DMsDDkE7s9niBLowZIW2V/n
         0QlVekbJaaPCVVJzHOe5JO3mLwaSW+tFTGlBQSTUbXFk6RiEtlDrFIpMMnp4WcYUTRIh
         Hg+hfrYrFTJ1YMP7gXw93es+EoxMoe07GHY54wtOSewZ8oCipb8kbHF+gIurq9VPsUMI
         ZAPX/P7YYj3hITpCGqBmpfoKGvkrF6SYa1CI2UiHRkLQmyhnGXHodqFAI8KRedDCHrEm
         FcAw92Bt3VpSlWdwCu31C84+eFyMVpcoNtKx43A/ykson7otDZfKcDniClA1K5/qYXQd
         rfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGyRU1WNsuE8ov8ULqACn584w4H+HPWKd0CH8fw/q4k=;
        b=wFgF4NtgOCdAEiLNF6P8eKIzVzZhjAd7zC4ErkmnI0z+P06yOIjKXwbwqLVZ5/MppN
         N0S0J/zVFVwPrG238f5MIF6JMUhM6CJwUwsiD+PJfgsvsAeLHpJz56z7gBEt6RSjfAUP
         548tZFUz+INGUPyYlTR1gEGIYaM4tkrwaCT1PI+bhlaUg4T8Wkgf/um5WugSNgsOyHhD
         kNoDQcTr7DNOQmYNsQK+KM6RVrWieOp2O5MRpCX6BswxONXwOfKkUKPVonsLLWcD3CoM
         rED3zZB8g8/u622BzRzZbYx2o9+0z3pMkDs14GpYrMTba06IDPGzTm+gM7vkIjVNwasM
         IbLA==
X-Gm-Message-State: AFqh2kqLVYxov8LW1jfzdZ9LkEWUb0fVRxT4fvojonFncJMdIvUEn01L
        NSDxhzrrFi0HN0+NKgsnw88=
X-Google-Smtp-Source: AMrXdXv6D2aYHv18D9unm1d6B/GwEAR342PxN4sZLT/AifGtqL6ZmvSJoTi0rsF4TyeU2yaSChOKsw==
X-Received: by 2002:a17:902:e812:b0:194:d7ed:9a6b with SMTP id u18-20020a170902e81200b00194d7ed9a6bmr5231551plg.30.1674196275307;
        Thu, 19 Jan 2023 22:31:15 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b00192d3e7eb8fsm26074646plx.252.2023.01.19.22.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 22:31:14 -0800 (PST)
Date:   Fri, 20 Jan 2023 12:01:12 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/12] selftests/bpf: Add dynptr pruning tests
Message-ID: <20230120063112.jslbuvyn2lfeps2x@apollo>
References: <20230120034314.1921848-1-memxor@gmail.com>
 <20230120034314.1921848-10-memxor@gmail.com>
 <20230120062041.x7aylmmpmnoh4igx@MacBook-Pro-6.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120062041.x7aylmmpmnoh4igx@MacBook-Pro-6.local.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 11:50:41AM IST, Alexei Starovoitov wrote:
> On Fri, Jan 20, 2023 at 09:13:11AM +0530, Kumar Kartikeya Dwivedi wrote:
> > +
> > +SEC("?tc")
> > +__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
> > +int dynptr_pruning_overwrite(struct __sk_buff *ctx)
> > +{
> > +	asm volatile (
> > +		"r9 = 0xeB9F;"
> > +		"r6 = %[ringbuf] ll;"
> > +		"r1 = r6;"
> > +		"r2 = 8;"
> > +		"r3 = 0;"
> > +		"r4 = r10;"
> > +		"r4 += -16;"
> > +		"call %[bpf_ringbuf_reserve_dynptr];"
> > +		"if r0 == 0 goto pjmp1;"
> > +		"goto pjmp2;"
> > +	"pjmp1:"
> > +		"*(u64 *)(r10 - 16) = r9;"
> > +	"pjmp2:"
> > +		"r1 = r10;"
> > +		"r1 += -16;"
> > +		"r2 = 0;"
> > +		"call %[bpf_ringbuf_discard_dynptr];"
>
> It should still work if we remove "" from every line, right?
> Would it be easier to read?

You mean write it like this?

	asm volatile (
	       "r9 = 0xeB9F;				\
		r6 = %[ringbuf] ll;			\
		r1 = r6;				\
		r2 = 8;					\
		r3 = 0;					\
		r4 = r10;				\
		r4 += -16;				\
		call %[bpf_ringbuf_reserve_dynptr];	\
		if r0 == 0 goto pjmp1;			\
		goto pjmp2;				\
	pjmp1:						\
		*(u64 *)(r10 - 16) = r9;		\
	pjmp2:						\
		r1 = r10;				\
		r1 += -16;				\
		r2 = 0;					\
		call %[bpf_ringbuf_discard_dynptr];	"
		:
		: __imm(bpf_ringbuf_reserve_dynptr),
		  __imm(bpf_ringbuf_discard_dynptr),
		  __imm_addr(ringbuf)
		: __clobber_all
	);

I guess that does look a bit cleaner, if you think the same I can try converting
them.
