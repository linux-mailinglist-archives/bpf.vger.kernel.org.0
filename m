Return-Path: <bpf+bounces-16319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E77FFB07
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 20:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EACA1C21197
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402495FF1D;
	Thu, 30 Nov 2023 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvz7fRCT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F841708
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 11:17:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bc2e7f1e4so1854533e87.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 11:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371874; x=1701976674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIZkGnfq4mBwDC8D7Uf/ALNXabEJwCx/lv3CEFm9yaU=;
        b=fvz7fRCT6VnOiH+i+eA6KH2BiqJ1spMwkh0+86vIshQwsutzVzzCxAYLDjM4Sjzsjq
         VCtRgQUPxu2LKtj+bCZ4BLcc7HD70PRH0Gh6XDErtSBJ7EoaLV0OUhajR78y1NXP5Su9
         69UDJFGacqljda4bNrhsqb1CViIK8aN3lvTargPLaWLK7t2QcuV6n2poL45BNydWrEld
         gaWi0F/oOgBI1W3RJfd1DBUy/nz1E9hptNmxM8bTM23HT0tFxMOrNxMIbdy3rUZRLn3T
         hiIIBcJBqudPxHrlf/p8F9vFjPdf7tP4VRVzjj0ejo1ygNLSteGg+t5No9HhXwhJx4vN
         p7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371874; x=1701976674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIZkGnfq4mBwDC8D7Uf/ALNXabEJwCx/lv3CEFm9yaU=;
        b=FiovfnRrkwUSeftDlUIEY2iFD3SQY38G/eLKw8pzIdtGtbjdG5sT4tRtWemL7sj+qi
         ROP4qnSvqswWO/BtyBN5UvXznfRMnER70Xo951nTxKyCc0UCYDU5WVQyZkywE4PsLEC7
         bnTPYBuD/LR3dyF1oFkMSz/dwtG3Sj1mvngPrmnHUvc5MHRZeniOIj+R6329cJVDoqCK
         uHPaKBprbC4wJhiWxjslLB8AbqXcfNqqeZsb2mGZ2DugwTn8lDz1SsYO8Zv3/fiKgQfA
         8YdcfDr+Vd4F0ogQk9f/w9GrFts8FQgwC5OUoNmCEmUouJ804CMyEWn480/vLmmoend/
         QN1Q==
X-Gm-Message-State: AOJu0YzejkQPUh2VLy42yWWqdEh/G/VRNoHzvdGOAaitwvrXl/3q/Dqi
	pTp32xadWkQj/vxpwqVEa87hM5oY7nYmSA==
X-Google-Smtp-Source: AGHT+IGv2CKZ55zUJwZA/6gRAH4kaMU1904kgMisaVCc3pYX+kl/DlJvatOaz9eLzcTED7U8wUa+bg==
X-Received: by 2002:a17:907:971d:b0:a19:a19b:78d8 with SMTP id jg29-20020a170907971d00b00a19a19b78d8mr10406ejc.155.1701370908715;
        Thu, 30 Nov 2023 11:01:48 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id gv11-20020a170906f10b00b009de11bcbbcasm996601ejb.175.2023.11.30.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:01:48 -0800 (PST)
Date: Thu, 30 Nov 2023 19:57:52 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231130185752.2fepd5wlospfzc53@erthalion.local>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-2-9erthalion6@gmail.com>
 <ZWicjpfZlVpC7HhP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWicjpfZlVpC7HhP@krava>

> On Thu, Nov 30, 2023 at 03:30:38PM +0100, Jiri Olsa wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8e7b6072e3f4..31ffcffb7198 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20109,6 +20109,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  	if (tgt_prog) {
> >  		struct bpf_prog_aux *aux = tgt_prog->aux;
> >
> > +		if (aux->attach_depth >= 32) {
> > +			bpf_log(log, "Target program attach depth is %d. Too large\n",
> > +					aux->attach_depth);
> > +			return -EINVAL;
> > +		}
>
> IIUC the use case you have is to be able to attach fentry program on
> another fentry program.. do you have use case that needs more than
> that?
>
> could we allow just single nesting? that might perhaps endup in easier
> code while still allowing your use case?

Right, there is no use case beyond attaching an fentry to another one,
so having just a single nesting should be fine.

> > +			/*
> > +			 * To avoid potential call chain cycles, prevent attaching programs
> > +			 * of the same type. The only exception is standalone fentry/fexit
> > +			 * programs that themselves are not attachment targets.
> > +			 * That means:
> > +			 *  - Cannot attach followed fentry/fexit to another
> > +			 *    fentry/fexit program.
> > +			 *  - Cannot attach program extension to another extension.
> >  			 * It's ok to attach fentry/fexit to extension program.
>
> next condition below denies extension on fentry/fexit and the reason
> is the possibility:
>   "... to create long call chain * fentry->extension->fentry->extension
>   beyond reasonable stack size ..."
>
> that might be problem also here with 32 allowed nesting

Reducing nesting to only one level probably will lift this question, but
for posterity, what kind of problem similar to "fentry->extension->fentry->..."
do you have in mind?

