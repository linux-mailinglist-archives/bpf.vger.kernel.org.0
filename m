Return-Path: <bpf+bounces-19052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ECB824856
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D251F2526A
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003B28E0F;
	Thu,  4 Jan 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCHbLSeH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A1C28E14
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e353c8d75so5311135e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704393790; x=1704998590; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rklSCakDaeGHy68BC91VQXd9aBWHU5D0RsJkww2Wmj8=;
        b=KCHbLSeH5bEiJdBkV9gdy4FKsLrjStCDWA5IGAIhVPQLTn+PdLqysZOSg5n4XGv8Lv
         DRHauxtBociBQC/PlbLZNrlY9bSKcqBNEIPe+Qo7zfY2jZEJi/FL4btpz9ZPqti1dnhG
         xFTeYBWxmZ/D79qJeTkkZF5EuIfqA2yAft70/ecVgsX59BbIBu/MlMX0Fnv4XulQ07+0
         c6z32uLM+eWCKvrDo9uMQpH6igCZISV+Stssl8PH5YP8RqK46UMU4dhPHK8PWCxp3rEp
         1Ol40iQ/t55KbJbjuZhttMF/00x8E5yKKe8neWpyZsIoARhVfrXdGWvE8b34pXNOnNRP
         94Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393790; x=1704998590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rklSCakDaeGHy68BC91VQXd9aBWHU5D0RsJkww2Wmj8=;
        b=c56ZIKgo/DmR6QCwSUKd61N6tdn6ytiGiyRytTDKOWjiEdbGHf/y1W/FArydMwoSpu
         Ukdfbvzcrwa147iOiUJ5HqqgzY/8PgAFrsCF0ZduWyIQJGvc1DperDnCYKO3B6KQfOIj
         njUKTwDAIHbNgF/SiXPZYrH/BoTvBhVslV8kmqcdZ+XupWV/NBYV4pSSpybXM1rbgVME
         nkvXxNFy0IqCmN4HFXqRXAEJcST0Ddgxs0CmuuB/KHXKEJu3AnlxT2iAd/thWF8myPh1
         zmg5NSoLzaG8Jo4oxAnt7yQ4wbQWJKK3TyWeDR0UxCAG6vD7LX9L5hfDdaXQ5gejzqbQ
         6Uzg==
X-Gm-Message-State: AOJu0YwK/5r2lufs1NdiIlNSLWyhGb0lOtg0+rkZrlUCa0pwUKPPLb9e
	xtzEYkKSBftrR0RRF5dEnw0sahJpym3QZA==
X-Google-Smtp-Source: AGHT+IHwnpoRhv8FpzUvqv3lrWOEVzIwucn2im9a778MmzdbIdKD7r1Zuw41tElTbes0hhSRu9arRw==
X-Received: by 2002:a1c:7417:0:b0:40d:80f5:7765 with SMTP id p23-20020a1c7417000000b0040d80f57765mr575110wmc.46.1704393790467;
        Thu, 04 Jan 2024 10:43:10 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qw18-20020a170906fcb200b00a274f3396a0sm7963191ejb.145.2024.01.04.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:43:09 -0800 (PST)
Message-ID: <2ad8478ee9e730c0fdd0dcf6959f942d3937b445.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
Date: Thu, 04 Jan 2024 20:43:08 +0200
In-Reply-To: <01e43663-6df6-4563-9b0b-985f6787847f@linux.dev>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
	 <63b227a753c6e6e18acf808d1ac5a77fa922a655.camel@gmail.com>
	 <01e43663-6df6-4563-9b0b-985f6787847f@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-04 at 09:13 -0800, Yonghong Song wrote:
> On 1/4/24 8:37 AM, Eduard Zingerman wrote:

[...]

> > I agree with this change, but I don't understand under which conditions
> > current STACK_ZERO logic is sub-optimal.
> > I tried executing test case from patch #2 w/o applying patch #1 and it =
passes.
> > Could you please elaborate / conjure a test case that would fail w/o pa=
tch #1?
>=20
> The logic is similar to
>    https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kernel.org=
/
>=20
> STACK_ZERO logic is sub-optimal in some cases only w.r.t. the number of
> verifier states. So there is no correctness issue.
> Patch 2 is added in response to Andrii's request in
>    https://lore.kernel.org/all/CAEf4BzaWets3fHUGtctwCNWecR9ASRCO2kFagNy8j=
JZmPBWYDA@mail.gmail.com/
> Since with patch 1 the original STACK_ZERO case is converted to STACK_SPI=
LL,
> Patch 2 is added to cover STACK_ZERO case. So with or with patch 1, patch=
 2
> will succeed since it uses STACK_ZERO logic.

Understood, thank you.
Probably no need to add more tests then.

A patch [1] might be related, it handles STACK_ZERO vs zero spill vs
unbound scalar spill on regsafe side.

[1] https://lore.kernel.org/bpf/20231220214013.3327288-15-maxtram95@gmail.c=
om/


