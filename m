Return-Path: <bpf+bounces-18365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE73E8199EB
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 08:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BBF285A88
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C2168D7;
	Wed, 20 Dec 2023 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lULKCM5i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78290168D1
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e34a72660so4267480e87.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703059168; x=1703663968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljq2v8cSiMftZ/oYQbz6XwBie14+mlD1C2ReeGxW72g=;
        b=lULKCM5is8mbyJK4FCahulSH+sflCL9p3UuwEOXI3+8lc1IW+s80rGfdpa84NakX6j
         hu+SaNdPYcDUXVF+TiuBatrorsK/ElqRKuVh75eYySgc2BxgXcKni7J8IBTrHh5XqvVY
         l5pg0t22P8sIpDczOM0KmDHLlCfg6LXpJJxMFMtGTcggmTosiYVrpmwXrMBWcQexooUh
         GRaE7tQ+/rxGNYgS4bLgCYormxbkW/tCfT9FbMQhqBrlsZZwaaGDE/QmfpV1pTNt0Gxx
         8AY3i3Rvj8Mo0KX1bFIwg9bV35ij3YQqnOEzM6642gS5vVfJ6QsYKMjLfyGCxEP9m9LO
         l5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703059168; x=1703663968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljq2v8cSiMftZ/oYQbz6XwBie14+mlD1C2ReeGxW72g=;
        b=tTTRbHoFn8jrahpJwyXLPInYBExRDsUUkpgw7hIkYoDyyPRhAkIqf766Ak1DNsrZuF
         U5RTl3ZKMBoMeUlKWVbdLaHjn9DNv6IPSMIJ5V7d46dnqSl9nKNldKjGbFYJRaAwQ8ZI
         hVv5P2NXYVsAx3+XAnQQNNJr6KhJ76wZEAULusfSEmMWeJNHPrRnBIZsCts6M38IlYnV
         BIV5Tknzws4PCkeqlGGpCS+QbnWC/pMpGPhRbtV6ePwabQT9sYfu5BRoH7s/KumvqrTC
         hs/hYiV/R3JCWkazJWBJLw3R6hGsUuecSVYt4w770yFYYKVH6qDw8sK6f3hCxwX9sj1s
         DFIg==
X-Gm-Message-State: AOJu0YwilAu8eyfJcrDAnEVgmmIILK+WttJp9qu2gjC1DKKub5nFKHSM
	KbykNI4hZBcO8GZvMZPlYZ8=
X-Google-Smtp-Source: AGHT+IGZsrAS/NGbPEs4yI8AYUnuq/LFsWx7lZxMaUl/yhHpYJbBGuPW4NTHzJyhZN+XA+PkU+BOwA==
X-Received: by 2002:a05:6512:3056:b0:50e:16f4:5925 with SMTP id b22-20020a056512305600b0050e16f45925mr5585195lfb.112.1703059168069;
        Tue, 19 Dec 2023 23:59:28 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090680c500b00a236da2e591sm2201542ejx.19.2023.12.19.23.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:59:27 -0800 (PST)
Date: Wed, 20 Dec 2023 08:55:43 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231220075543.vcuasod3zyx6uqgp@erthalion.local>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
 <20231215200712.17222-2-9erthalion6@gmail.com>
 <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>
 <ZX9KY-uouFF1Doz3@krava>
 <CAPhsuW4SfDEPy3sxTTr2VPYCW7ysM+ACUHwzuAcniy9-cgan5A@mail.gmail.com>
 <ZX_5AhpYjcX06feL@krava>
 <20231218201019.a25qr3scjcturpt4@erthalion.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218201019.a25qr3scjcturpt4@erthalion.local>

> On Mon, Dec 18, 2023 at 09:10:19PM +0100, Dmitry Dolgov wrote:
> > > > I guess it's corner case that does not make much sense, but still it
> > > > feels more natural to me to set it in attach time
> > >
> > > If we set attach_tracing_prog at attach time, the following will
> > > succeed:
> > >
> > >   load (fentry1 -> kernel function)
> > >   load (fentry2 -> fentry1)
> > >   load (fentry3 -> fentry2)
> > >   attach (fentry1)
> > >   attach (fentry2)
> > >   attach (fentry3)
> > >
> > > We can even make attach chain longer, as long as we load
> > > the chain first. This is really confusing to me. So I think we should
> > > set the flag at load() time.
> > >
> > > Does this make sense?
> >
> > yes, I did not consider this option.. makes sense
>
> Thanks for pointing out this case folks, haven't thought about this
> either.
>
> Just for me to clarify explicitly, the reason why the case (loading a
> chain and only then attaching every program) would work is that there is
> no additional bpf_check_attach_target in bpf_tracing_prog_attach when
> the trampoline is getting reused. I've tried to change this a little, it
> seems to possible to prevent such situation, and still keep
> attach_tracing_prog flag at attach time if there will be one more
> bpf_check_attach_target.
>
> At the same time setting attach_tracing_prog flag at load time would be
> probably less invasive, making it more preferable I guess. Will post the
> new patch series with this change soon.

Thinking about this more, it seems setting attach_tracing_prog flag at
load time should be done not as a replacement (what I've assumed
originally), but in addition to setting it at attach time. Otherwise,
reattaching the same prog will lead to an inconsistency.

