Return-Path: <bpf+bounces-15640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF57F4665
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 13:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C3B2810CC
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5534D126;
	Wed, 22 Nov 2023 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp9E6VJk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F319412A
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 04:38:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507975d34e8so9538255e87.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656717; x=1701261517; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eV+b+l3gJdfVPKLhJJN2QCzzct0TKU8Zql/mhbuxa84=;
        b=Kp9E6VJk7biVOXlWQ87dPOyqVANlp6kJQG+qQtTMExYDVXN42O6+I1D8qQoYxSaoYm
         w/a4QxpIy4+Vl2ky7bIuDWSu7wme0BpzHnbs39oPZgdesy4WUSkJ8Wks/aCdd83iSF17
         TaG22kP20NYegUi8BAHUqSD9op8oHJJpUGoMSO5D0nFJORtsulWNUwoLoU/fvBFz/756
         mhYJtlmJ0ls6YXceWpm2XilKVZMuISRMxVNWQ7z5cxNu+WyOV8J6rd8c28p5tuXrlC3x
         rYQ277Bj6jTuET6x0Y7L0Jv7tgU2MD26K+7wo8ehlqthX3Bp3RAYODMcwcSobhT+KHcN
         Khtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656717; x=1701261517;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eV+b+l3gJdfVPKLhJJN2QCzzct0TKU8Zql/mhbuxa84=;
        b=C8EDShIYyfj4xRT0zkTlWOTS2pSmlmD/ggERhg0HRj25qmbDH8oF1+loEsUodp4Izw
         jpfExtelewbH4t1EdnTkTSNHS0IP/b2B86u8iUuwPrdjYimuzYDSukeXuOytY25h//fq
         o7pOQWjfnCjZl2wRjGeyur/tMLniiUQJcq5D+yneUiaCIsq1X4wW+XbD/3vw+acUZcW6
         L97qoNFV0+SaJ7HP4dPeS5RhTNGzpGu7zMubQkdNHWJ2XVTsJdYUdoK6Q/18OIY8B3dg
         7gEE+UnUJ33JfulVSDgdoAfL5wwlvsBeOIfaacS2OiBNRI8DhsHm8mXrd/pRgJdHXse3
         70BA==
X-Gm-Message-State: AOJu0Yy1dhxp5qFXan5dQaiclBTrc7N3BHGPw0Begx3JcUGhOaRV+izE
	DKzASOoUdn7TbHNpWFwjBDKgld0Ezpg=
X-Google-Smtp-Source: AGHT+IFqMZfJ4EXodn49hWvtmptmW6HmXBmquiDe8dfp6As08xLL9LdvwhOWg5Jj6o834WPPjTsmUQ==
X-Received: by 2002:a05:6512:220a:b0:50a:68f0:fb94 with SMTP id h10-20020a056512220a00b0050a68f0fb94mr2125716lfu.9.1700656716867;
        Wed, 22 Nov 2023 04:38:36 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t19-20020a056512069300b0050aa8c0dfc3sm1325856lfe.31.2023.11.22.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:38:35 -0800 (PST)
Message-ID: <58e347045bb81f667f037f124d4dcfe9a2d3f336.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix tracking of stack size for var-off access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrei Matei
	 <andreimatei1@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	kernel-team@dataexmachina.dev
Date: Wed, 22 Nov 2023 14:38:34 +0200
In-Reply-To: <CAEf4BzaJ41MJKk71Ex_HmLyhcoe9a_2jhvLiYxcXNSvK=6oNmg@mail.gmail.com>
References: <20231113235008.127238-1-andreimatei1@gmail.com>
	 <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
	 <CACkBjsbWdOVMs7vRXvxi0MCoOAh+skYWFN1douBjkRzeTX=wvg@mail.gmail.com>
	 <CABWLsesztKnQosM+bkBq-H5yPvFNc02uh5hrEgwRBAz6ja9Q4g@mail.gmail.com>
	 <CAEf4BzaJ41MJKk71Ex_HmLyhcoe9a_2jhvLiYxcXNSvK=6oNmg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 13:55 -0800, Andrii Nakryiko wrote:
[...]
> > So, assuming that this tests (and a few others) are sane, Andrii's sugg=
estion
> > of calling grow_stack_state()/update_stack_depth() in
> > check_stack_access_within_bounds() does not immediately work: doing so
> > would change
> > the behavior in check_stack_range_initialized() and allow the access.
> >=20
> > On the other hand, perhaps the test is not sane and the access should b=
e
> > permitted, in the spirit of allowing reads of uninitialized stack? Perh=
aps the
> > different treatment of slots beyond state->allocated_stack and STACK_IN=
VALID
>=20
> yes, I think this divergence is not intentional, but maybe Eduard
> remembers some other quirks and why it is what it is, let's see.

Yes, this is probably an overlook from my side.
I should have allowed reads beyond allocated stack in this case when
doing changes for STACK_INVALID.
Sorry for delayed response.

[...]

