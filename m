Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D1674D7C
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjATGo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjATGo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:44:28 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4AC40D5
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:44:27 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id z13so4539322plg.6
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QDr48EKa8pr/3SSYr55inHsW8rtOiovtnThf8tBf38=;
        b=BozQTrikFeXMtsJo8hZmUklL8Ti8Xr2k/+5R3y0Yq/ONXtS8QKHobkISV+d0nUPcNP
         Vr/yz9tlnKKoPXSf8xsJh8H753tM2OOyVYcwKn8qrC0LQgKXhAYD15VURd42HZus13rp
         XofBJou13G1VFFtkjCmFBuEgCRa7XjYCxihcnbB1LZLH6BkOZyr/FQwg3YAhiIXJHun6
         daaLdQ57LKulrJ/OKH45iirNWdo1NkYwMQxq74qgOLyyMnTYwtnrSjk9A8x/Ke61Krln
         ze0R8lBNa+fj83/n3OLFJTvHRG4dUUbg1ojDcj8A3GNWBQGVuClaieMFDiytCfy4wm6b
         T2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QDr48EKa8pr/3SSYr55inHsW8rtOiovtnThf8tBf38=;
        b=IyCkI0MP43aMH2/EgWhhCEoDnbAiJOwK/gu3phVGOOy/Ph4/Bwk4G6qAlcLjc3VegF
         uneTuDo1NOmndXrZHfG9Tvc4inCrrFIMWv+RPnW8XDGQNe5QA7TNlunyHw0Dg44z4Vhh
         KQLZqpXCzJgNs3xRGYAEWmn4s3SP8PREROfp0kD93I2AbgQGneN7IwyOgZ0fEWBN1N16
         LdzskLzdBWURO5wJQy7HbARDFzYWg0+QJKH4/K+bQzKlsgnZR8DjL6FEFOoSBCGI0mlv
         mYrJbLbNktNpsRIuGkU5Rnu9jl5CrAIqwfPkCfbTh9IOLBYNLL0ogFT+eREXdZFawWOu
         EQRw==
X-Gm-Message-State: AFqh2kp4CZfOYi/OkNYWvAKaxdLUN5mCh7DN/12xRH9cYzDBpqNo0NOa
        Zg5Y1g41MdbyXRkgIVePMso=
X-Google-Smtp-Source: AMrXdXtYGyzp8B6hA9XEGBxewt4LfyuQj0tH2xdz177jh6SZEtvRyyoeL5MyDNfxasEvjn9v+547Zg==
X-Received: by 2002:a17:90a:51:b0:22b:b444:afc8 with SMTP id 17-20020a17090a005100b0022bb444afc8mr174042pjb.34.1674197067194;
        Thu, 19 Jan 2023 22:44:27 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a024c00b00228f45d589fsm693215pje.29.2023.01.19.22.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 22:44:26 -0800 (PST)
Date:   Fri, 20 Jan 2023 12:14:24 +0530
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
Message-ID: <20230120064424.3uldumqvlvxksiwb@apollo>
References: <20230120034314.1921848-1-memxor@gmail.com>
 <20230120034314.1921848-10-memxor@gmail.com>
 <20230120062041.x7aylmmpmnoh4igx@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <20230120063112.jslbuvyn2lfeps2x@apollo>
 <20230120063934.w6q7vioadgoctrwd@MacBook-Pro-6.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120063934.w6q7vioadgoctrwd@MacBook-Pro-6.local.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 12:09:34PM IST, Alexei Starovoitov wrote:
> On Fri, Jan 20, 2023 at 12:01:12PM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Fri, Jan 20, 2023 at 11:50:41AM IST, Alexei Starovoitov wrote:
> > > On Fri, Jan 20, 2023 at 09:13:11AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > +
> > > > +SEC("?tc")
> > > > +__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
> > > > +int dynptr_pruning_overwrite(struct __sk_buff *ctx)
> > > > +{
> > > > +	asm volatile (
> > > > +		"r9 = 0xeB9F;"
> > > > +		"r6 = %[ringbuf] ll;"
> > > > +		"r1 = r6;"
> > > > +		"r2 = 8;"
> > > > +		"r3 = 0;"
> > > > +		"r4 = r10;"
> > > > +		"r4 += -16;"
> > > > +		"call %[bpf_ringbuf_reserve_dynptr];"
> > > > +		"if r0 == 0 goto pjmp1;"
> > > > +		"goto pjmp2;"
> > > > +	"pjmp1:"
> > > > +		"*(u64 *)(r10 - 16) = r9;"
> > > > +	"pjmp2:"
> > > > +		"r1 = r10;"
> > > > +		"r1 += -16;"
> > > > +		"r2 = 0;"
> > > > +		"call %[bpf_ringbuf_discard_dynptr];"
> > >
> > > It should still work if we remove "" from every line, right?
> > > Would it be easier to read?
> >
> > You mean write it like this?
> >
> > 	asm volatile (
> > 	       "r9 = 0xeB9F;				\
> > 		r6 = %[ringbuf] ll;			\
> > 		r1 = r6;				\
> > 		r2 = 8;					\
> > 		r3 = 0;					\
> > 		r4 = r10;				\
> > 		r4 += -16;				\
> > 		call %[bpf_ringbuf_reserve_dynptr];	\
> > 		if r0 == 0 goto pjmp1;			\
> > 		goto pjmp2;				\
> > 	pjmp1:						\
> > 		*(u64 *)(r10 - 16) = r9;		\
> > 	pjmp2:						\
> > 		r1 = r10;				\
> > 		r1 += -16;				\
> > 		r2 = 0;					\
> > 		call %[bpf_ringbuf_discard_dynptr];	"
> > 		:
> > 		: __imm(bpf_ringbuf_reserve_dynptr),
> > 		  __imm(bpf_ringbuf_discard_dynptr),
> > 		  __imm_addr(ringbuf)
> > 		: __clobber_all
> > 	);
> >
> > I guess that does look a bit cleaner, if you think the same I can try converting
> > them.
>
> Only asking to consider different options because once we start adding tests
> in this form everyone will copy paste the style.
> In verifier/precise.c we use:
>         .errstr =
>         "26: (85) call bpf_probe_read_kernel#113\
>         last_idx 26 first_idx 22\
>         regs=4 stack=0 before 25\
>         regs=4 stack=0 before 24\
>         regs=4 stack=0 before 23\
>         regs=4 stack=0 before 22\
>
> so the following is another option:
>  	asm volatile (
>  	       "r9 = 0xeB9F;\
>  		r6 = %[ringbuf] ll;\
>  		r1 = r6;\
>  		r2 = 8;\
>  		r3 = 0;\
>  		r4 = r10;\
>  		r4 += -16;
>
> My vote goes to your 2nd approach where every \ is tab-aligned to the right.

Yeah, understood. I will convert to this style and respin. Thanks.
