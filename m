Return-Path: <bpf+bounces-10545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6FE7A99D9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2175B209F5
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A920319;
	Thu, 21 Sep 2023 17:26:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FD20313
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:26:31 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE56417E8
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:25:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so2576473a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317147; x=1695921947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+1s6ZC7yp8CfKx+LOBOAYyr+9GdpUHkmn0zWGUnGHAU=;
        b=FBxADsKf3vIh6dqIBTXw2sTXL9Kg0IX5a4ms2xgWAhJlFJy2KN+vXPAmHeGKt9Kdfs
         dv9toPyCcZu3J+rC+V1L5c+0teyJErLldQrLK9sETvZEk3XqNCoCiBLGj+x0q/Bu1pSu
         GHLhPNGRnec1/oiQxxoAILdpdsBlbhVI0jUywpWxTdQWAUfm1XAf3lMt0uyDR8OyIOwd
         SB/5wMJsIv6uNcu5qPWhLCnHT0TNIc8B2QbfJDrpWaORooDKiQJtfgqddkzRLQoo0j2K
         HlqbRpxrlKWJ3++XBWKXC8M7EWcu1Co+wsuBKxjwEKwHvfUoYaWZYIwK7V6ATyO3u/fz
         hgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317147; x=1695921947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1s6ZC7yp8CfKx+LOBOAYyr+9GdpUHkmn0zWGUnGHAU=;
        b=BANQQq3s4rGksvvXRJzk81iGJslQ7wK40x/iFJ2XDE/qzHGBTTBgV8cLP9MoRhEO4x
         UQa4AY/nIVrxjE4BrUDZPV7DAWGL8+008y1S3cdK4aX+kAGQxfkunuGxjijOrEgYac3q
         syfV6aYL0qIy2cUAOfQgJku9rt9MJJh305VfNsZLaYeWjvs8tQ9VFocA7MIIa8er+JVr
         CGd3WGGd/OUxcpb0/UmsluaJScIbVKu+oZsooicYPjzG7Y14rrexH0PC8VYncXAOMH+d
         vzO+8ERMsIn3KVQvTnX7x3oZwaPWis5nkgs43updu55/QRAU2zpwGurepWesuED/21Zi
         W8DQ==
X-Gm-Message-State: AOJu0Yxu7QeSWRXnFz9Su45KSJtb9oVZ6HwgIN6LkBmJW42vQ9LxdQTx
	9ZITkQJwKHB+TP5reSMKwsTRgf/RyDU=
X-Google-Smtp-Source: AGHT+IE9h/SjdDTU5nvR2mFDIKYwa2OrB0TE7+UTGCj9sETOM0jpxmnj74h2qn3utXttUnx8G5TYmw==
X-Received: by 2002:a17:907:9d17:b0:9ae:614f:b159 with SMTP id kt23-20020a1709079d1700b009ae614fb159mr2332808ejc.36.1695306535187;
        Thu, 21 Sep 2023 07:28:55 -0700 (PDT)
Received: from krava (253.252.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.252.253])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b009a5f7fb51d1sm1125911ejb.40.2023.09.21.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:28:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Sep 2023 16:28:52 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Message-ID: <ZQxTJGsiA1OWTT/Z@krava>
References: <20230920053158.3175043-1-song@kernel.org>
 <20230920053158.3175043-7-song@kernel.org>
 <ZQxSO/eR6NpZ/aBX@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQxSO/eR6NpZ/aBX@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 04:25:02PM +0200, Jiri Olsa wrote:
> On Tue, Sep 19, 2023 at 10:31:56PM -0700, Song Liu wrote:
> 
> SNIP
> 
> >  bool bpf_jit_supports_subprog_tailcalls(void)
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 5f7528cac344..eca561621e65 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2422,10 +2422,10 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
> >   * add rsp, 8                      // skip eth_type_trans's frame
> >   * ret                             // return to its caller
> >   */
> > -int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> > -				const struct btf_func_model *m, u32 flags,
> > -				struct bpf_tramp_links *tlinks,
> > -				void *func_addr)
> > +static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> > +					 const struct btf_func_model *m, u32 flags,
> > +					 struct bpf_tramp_links *tlinks,
> > +					 void *func_addr)
> >  {
> 
> hum, I dont understand what's the __arch_prepare_bpf_trampoline for,
> could we have just the arch_prepare_bpf_trampoline?

ok, in the next patch ;-) 

jirka

