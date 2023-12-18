Return-Path: <bpf+bounces-18236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA376817B9F
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 21:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5391C2374C
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211237204B;
	Mon, 18 Dec 2023 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekQSRxXh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4B7146E
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso35713455e9.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 12:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702930444; x=1703535244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tejjpoJ06rfKDRzKklgMCmGft7V6kVMqwyiKwWGsdOo=;
        b=ekQSRxXhCgPY1w7DFLJdn9w5XFvh+hGog/neTQIRQnzRmEPpBPMEVHi/ec7tZim0/1
         wqienm8NvDeBDQvNxfon0ymebRISk/B2SNYC+18knQ7f5QirbZNq441nnaEf7oN/jFtm
         vfI/+C4sabCMHa4xKoTOCnht1PNNzecKIm8fhasksHM8N2oTvKzM5tPWiwRThPVZljKm
         EBqLo06Q1YaCLwXzodWIUdAfRE1BSBLsk2oS39C7fquasH7gbymo+wWm5nCYGH7Prjql
         D6HPxfM8hxnKsjtmNqdzDfoYzjlgfih41EfQK534bZDgLfXJN+vyCr4At4J2ddCYhgRJ
         1s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702930444; x=1703535244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tejjpoJ06rfKDRzKklgMCmGft7V6kVMqwyiKwWGsdOo=;
        b=PfsCBNY/5aHZHggDsoN5OG/ib0zNNtgSEdXsrt3y8FRtT+9YFEBFM5z/YxOHgDDgVb
         QW7+xVYo1AGZL0Ys9AlSIdPjHPrL2Ygh8GXAxJeCL9zzY0jKlpI3WQRm0x/7f0UfkiwT
         DwDalUS2gmOI5mCW/z76U0vzyKBBi35YzjY2dUFsCtJwxUZY7r+yB1t3vbFUbBDCKPlw
         D16FQIS2eX7IB4Upgt7UyPE3VRfvWVUN6+/5KAarEetmoupBJtzb7nFoeDw25vCXK+AM
         KiVjGgHXKXyAWUjrOvwcXWyR89I/1fbCcflaZvSNxkDHNly8Ju4lP/GpitxT2JQZeWzQ
         wmUg==
X-Gm-Message-State: AOJu0YyGyNoKJi7IjTn0cJBmU6UtQL0UflCzaOx/UyU4TOOCbJ6asDbX
	M+y8Dmwl1/x2+mK/y9D7EG8=
X-Google-Smtp-Source: AGHT+IGG0Pgag5odvnUNdC57dvSQZbFkuX9yAVyYVgjtAbRB1iiMAW654GKq3h+b21ppwI+HY9T4TQ==
X-Received: by 2002:a05:600c:198a:b0:40d:161b:d130 with SMTP id t10-20020a05600c198a00b0040d161bd130mr1654179wmq.67.1702930444219;
        Mon, 18 Dec 2023 12:14:04 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906328a00b00a236f815a1csm251411ejw.105.2023.12.18.12.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:14:03 -0800 (PST)
Date: Mon, 18 Dec 2023 21:10:19 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231218201019.a25qr3scjcturpt4@erthalion.local>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
 <20231215200712.17222-2-9erthalion6@gmail.com>
 <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>
 <ZX9KY-uouFF1Doz3@krava>
 <CAPhsuW4SfDEPy3sxTTr2VPYCW7ysM+ACUHwzuAcniy9-cgan5A@mail.gmail.com>
 <ZX_5AhpYjcX06feL@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX_5AhpYjcX06feL@krava>

> On Mon, Dec 18, 2023 at 08:47:14AM +0100, Jiri Olsa wrote:
> > > > If we add
> > > >
> > > > + prog->aux->attach_tracing_prog = true;
> > > >
> > > > here. We don't need the changes in syscall.c, right?
> > > >
> > > > IOW, we set attach_tracing_prog at program load time, not attach time.
> > > >
> > > > Would this work?
> > >
> > > I think it'd work.. I can just think of a case where we'd not allow
> > > to attach fentry program (3) to another fentry (2) even if it's not
> > > attached, but just loaded, like:
> > >
> > >
> > > load (fentry1 -> kernel function)
> > >
> > > load (fentry2 -> fentry1)
> > >   fentry2->attach_tracing_prog = true
> > >
> > > load (fentry3 -> fentry2)
> > >   if (fentry2->aux->attach_tracing_prog)
> > >     return -EINVAL
> > >
> > >
> > > I guess it's corner case that does not make much sense, but still it
> > > feels more natural to me to set it in attach time
> >
> > If we set attach_tracing_prog at attach time, the following will
> > succeed:
> >
> >   load (fentry1 -> kernel function)
> >   load (fentry2 -> fentry1)
> >   load (fentry3 -> fentry2)
> >   attach (fentry1)
> >   attach (fentry2)
> >   attach (fentry3)
> >
> > We can even make attach chain longer, as long as we load
> > the chain first. This is really confusing to me. So I think we should
> > set the flag at load() time.
> >
> > Does this make sense?
>
> yes, I did not consider this option.. makes sense

Thanks for pointing out this case folks, haven't thought about this
either.

Just for me to clarify explicitly, the reason why the case (loading a
chain and only then attaching every program) would work is that there is
no additional bpf_check_attach_target in bpf_tracing_prog_attach when
the trampoline is getting reused. I've tried to change this a little, it
seems to possible to prevent such situation, and still keep
attach_tracing_prog flag at attach time if there will be one more
bpf_check_attach_target.

At the same time setting attach_tracing_prog flag at load time would be
probably less invasive, making it more preferable I guess. Will post the
new patch series with this change soon.

