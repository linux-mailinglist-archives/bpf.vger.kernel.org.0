Return-Path: <bpf+bounces-16334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F697FFE84
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 23:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21807B20EFD
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5155C18;
	Thu, 30 Nov 2023 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTcyvKB3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4567F10FA
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 14:34:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40859dee28cso13163755e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701383648; x=1701988448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IrMr5l2P9m05xtUMwrw5ZrJ8IQBs+dnn6E2CEHelvKg=;
        b=QTcyvKB3mizNYAdbO2YkJB6lkqjUOmgPXkv1iELPp0vo9OFUQjIbydvypEh1JuyuiL
         c8qpjb5wcSJW9ludWLw4ZTwdNdCrA80Qjcv+Xb/T1IVW9TeuVHBgJX7k3QRbdv+HBiYH
         Smuoy97t0MJwH94XLu/ejhh7Gg/aV9/jQy2QYC5YvZWlioJCC38SfbE82tsycVvXQXfF
         aUcftMFy6HJzvwUnbYOgBJXUPvNMh76C2uK5+H6Upm6fNpqa+aUoSf1bcHlwXpC3t92M
         v5hCi+HgggbRsqx9dzvAy6tdGdMFDTQLae0taQbmYpWMd+oZDlvqkf+7wPHE5bGtL96/
         RjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701383648; x=1701988448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrMr5l2P9m05xtUMwrw5ZrJ8IQBs+dnn6E2CEHelvKg=;
        b=xGfrDw+Km7h1UE3emGdc1wtvjFQijhABXHMO49fXfyY5UMAMJ1+eIkzG5mFcY9wNOP
         kEWISeJqJ3O5CN0cP0IzBiNPgMR/4ow6IrWUj54zruxW3VAJg+QLH2FrdgxDsFW8cHxl
         3hCOaMMZTy8oCZ+dmF7oq94XY37ZlljyjbFz72BWHeOkCppw6UQPZ2GhqdxFX4nulcET
         eXR4/Lj/y2lqFx5wBgBbSp4I6wcvrY64+lgmOCrbRoWELc4ntBKRYdhgAQbRx9ih0z4I
         ByNCya8PYsuugWwwk5Hd0Id3/4PTlvHGUKqV7HzdXq3ZaqTT0XsRkMIz5CEB/oULTPrL
         iMgA==
X-Gm-Message-State: AOJu0Yy9swaIaWRvXRmbBAmMGuaxHOxAPIOPY7omOvHne2QnWot+jSbK
	jfLo2ZdS3408JysV4tARp+w=
X-Google-Smtp-Source: AGHT+IFsmdv7xRe2PAEhDjJpv5TJLR+TwZbR69+pGNAnSrVN/+9uOsQSf7NnBtrdbOm/QOzIdUekJw==
X-Received: by 2002:a5d:5583:0:b0:333:2fd2:813b with SMTP id i3-20020a5d5583000000b003332fd2813bmr137769wrv.88.1701383647460;
        Thu, 30 Nov 2023 14:34:07 -0800 (PST)
Received: from krava ([83.240.60.31])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d4527000000b00332fda15056sm2554919wra.110.2023.11.30.14.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:34:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Nov 2023 23:34:05 +0100
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, dan.carpenter@linaro.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZWkN3QMnAGwFo7JF@krava>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-2-9erthalion6@gmail.com>
 <ZWicjpfZlVpC7HhP@krava>
 <20231130185752.2fepd5wlospfzc53@erthalion.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130185752.2fepd5wlospfzc53@erthalion.local>

On Thu, Nov 30, 2023 at 07:57:52PM +0100, Dmitry Dolgov wrote:
> > On Thu, Nov 30, 2023 at 03:30:38PM +0100, Jiri Olsa wrote:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 8e7b6072e3f4..31ffcffb7198 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -20109,6 +20109,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >  	if (tgt_prog) {
> > >  		struct bpf_prog_aux *aux = tgt_prog->aux;
> > >
> > > +		if (aux->attach_depth >= 32) {
> > > +			bpf_log(log, "Target program attach depth is %d. Too large\n",
> > > +					aux->attach_depth);
> > > +			return -EINVAL;
> > > +		}
> >
> > IIUC the use case you have is to be able to attach fentry program on
> > another fentry program.. do you have use case that needs more than
> > that?
> >
> > could we allow just single nesting? that might perhaps endup in easier
> > code while still allowing your use case?
> 
> Right, there is no use case beyond attaching an fentry to another one,
> so having just a single nesting should be fine.
> 
> > > +			/*
> > > +			 * To avoid potential call chain cycles, prevent attaching programs
> > > +			 * of the same type. The only exception is standalone fentry/fexit
> > > +			 * programs that themselves are not attachment targets.
> > > +			 * That means:
> > > +			 *  - Cannot attach followed fentry/fexit to another
> > > +			 *    fentry/fexit program.
> > > +			 *  - Cannot attach program extension to another extension.
> > >  			 * It's ok to attach fentry/fexit to extension program.
> >
> > next condition below denies extension on fentry/fexit and the reason
> > is the possibility:
> >   "... to create long call chain * fentry->extension->fentry->extension
> >   beyond reasonable stack size ..."
> >
> > that might be problem also here with 32 allowed nesting
> 
> Reducing nesting to only one level probably will lift this question, but
> for posterity, what kind of problem similar to "fentry->extension->fentry->..."
> do you have in mind?

I meant that allowing that amount of nesting will make it easier to get
to a point where we use all the available stack size

jirka

