Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECD674D70
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjATGjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATGji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:39:38 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759F11EB7
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:39:38 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id a9-20020a17090a740900b0022a0e51fb17so1439182pjg.3
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlJXpOq7X3rDmeSr6uv1NExNoJLfnAPwo/v5GrWgvHk=;
        b=B5re4SeNisfhY3pJabsT6J/Sr99A76TIPc45XjXvKXoDsDZZHDzMrb46EqZhGv07Fq
         q5jXVHRkSgNuk5SS6QKEqMP4zZqVi5cdltWoXDsRv6L2iu0GmHKzg06aEFJ9ZSie2m5u
         4BVHA7DywH4sySbHEgjzxCqKA9E2rNHI5o9SAYKsTDJUgZOKIqr00PzytED+lQQMC+q8
         KNPJ2muH/7/q9voPb0BSdkg6eG0K66UYNggTOtvhRY1ECGQ75mgWKJrg2Ur6myssksGq
         mctC7I5Ec5HXfOf/L5qNacd0QR1YvirIFZcJUtI3YPZhAsJb7FoMMcpuf6iVQzAakTdv
         8x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlJXpOq7X3rDmeSr6uv1NExNoJLfnAPwo/v5GrWgvHk=;
        b=C0oXPC75ZytyAB1ALxcvSienZb+8Zm76P+HrEOa/qfbPJlezvD5C4zHRve9GFSp0jz
         GJUiWTiYJT2VlsDw5wGU+q2XejIArPczPzFM0ZfDnO/9PycPcOXooHkGH1gmSai3pTPb
         OLD3pnB9jHuW7B5mv2J5xyqi3tqIV0OW6ReZYlGP8XTIgLFlr2BXIukiiTArb711aMHk
         x8c827qMbSHK/QPJdkilphSC81cM4d6DszHmR0r2GGuPqHmcHs7BZRByittElcIsJXB0
         jsN5DVc+P+Hdhmnnn3xs1aNlsZWUFHWsGT7dCKITzieEaBaksgU1mW/JqzvLJJzxtVKV
         sjgA==
X-Gm-Message-State: AFqh2kqNHIkC0DCm+5/EMkgNOv3rgDARC/xVvtFNABQZG6Dic7k7QhBV
        6Qgou3eY62qXbmCV4eClDxI=
X-Google-Smtp-Source: AMrXdXsCPgMT3kRpE3AXGNU//aQlE7SbHpsykwphkl9X9Lws2lkqGvFLkRVpbOeLreNJA6ZGQLoYfw==
X-Received: by 2002:a05:6a20:b71b:b0:b8:965a:ccb5 with SMTP id fg27-20020a056a20b71b00b000b8965accb5mr12307793pzb.24.1674196777436;
        Thu, 19 Jan 2023 22:39:37 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id q25-20020a631f59000000b004cffa8c0227sm4470233pgm.23.2023.01.19.22.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 22:39:36 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:39:34 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/12] selftests/bpf: Add dynptr pruning tests
Message-ID: <20230120063934.w6q7vioadgoctrwd@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
 <20230120034314.1921848-10-memxor@gmail.com>
 <20230120062041.x7aylmmpmnoh4igx@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <20230120063112.jslbuvyn2lfeps2x@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120063112.jslbuvyn2lfeps2x@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 12:01:12PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Fri, Jan 20, 2023 at 11:50:41AM IST, Alexei Starovoitov wrote:
> > On Fri, Jan 20, 2023 at 09:13:11AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > +
> > > +SEC("?tc")
> > > +__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
> > > +int dynptr_pruning_overwrite(struct __sk_buff *ctx)
> > > +{
> > > +	asm volatile (
> > > +		"r9 = 0xeB9F;"
> > > +		"r6 = %[ringbuf] ll;"
> > > +		"r1 = r6;"
> > > +		"r2 = 8;"
> > > +		"r3 = 0;"
> > > +		"r4 = r10;"
> > > +		"r4 += -16;"
> > > +		"call %[bpf_ringbuf_reserve_dynptr];"
> > > +		"if r0 == 0 goto pjmp1;"
> > > +		"goto pjmp2;"
> > > +	"pjmp1:"
> > > +		"*(u64 *)(r10 - 16) = r9;"
> > > +	"pjmp2:"
> > > +		"r1 = r10;"
> > > +		"r1 += -16;"
> > > +		"r2 = 0;"
> > > +		"call %[bpf_ringbuf_discard_dynptr];"
> >
> > It should still work if we remove "" from every line, right?
> > Would it be easier to read?
> 
> You mean write it like this?
> 
> 	asm volatile (
> 	       "r9 = 0xeB9F;				\
> 		r6 = %[ringbuf] ll;			\
> 		r1 = r6;				\
> 		r2 = 8;					\
> 		r3 = 0;					\
> 		r4 = r10;				\
> 		r4 += -16;				\
> 		call %[bpf_ringbuf_reserve_dynptr];	\
> 		if r0 == 0 goto pjmp1;			\
> 		goto pjmp2;				\
> 	pjmp1:						\
> 		*(u64 *)(r10 - 16) = r9;		\
> 	pjmp2:						\
> 		r1 = r10;				\
> 		r1 += -16;				\
> 		r2 = 0;					\
> 		call %[bpf_ringbuf_discard_dynptr];	"
> 		:
> 		: __imm(bpf_ringbuf_reserve_dynptr),
> 		  __imm(bpf_ringbuf_discard_dynptr),
> 		  __imm_addr(ringbuf)
> 		: __clobber_all
> 	);
> 
> I guess that does look a bit cleaner, if you think the same I can try converting
> them.

Only asking to consider different options because once we start adding tests
in this form everyone will copy paste the style.
In verifier/precise.c we use:
        .errstr =
        "26: (85) call bpf_probe_read_kernel#113\
        last_idx 26 first_idx 22\
        regs=4 stack=0 before 25\
        regs=4 stack=0 before 24\
        regs=4 stack=0 before 23\
        regs=4 stack=0 before 22\

so the following is another option:
 	asm volatile (
 	       "r9 = 0xeB9F;\
 		r6 = %[ringbuf] ll;\
 		r1 = r6;\
 		r2 = 8;\
 		r3 = 0;\
 		r4 = r10;\
 		r4 += -16;

My vote goes to your 2nd approach where every \ is tab-aligned to the right.
