Return-Path: <bpf+bounces-18970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323F823956
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3EDFB23EC6
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA901F939;
	Wed,  3 Jan 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVZAavOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72721F92C
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5f402571so77516835e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 15:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704325899; x=1704930699; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uGoDEads02//ume8qCZqx+lM6wcr/vJOxYyiy7bhOX4=;
        b=hVZAavOmuGacOjRvuocKj8H5t3M51UzkoyXsECvyEXWJwOJ9FWxGWoZ9ft2NFwo44z
         myvEf5h0fY1gYHvp1gOQsiWDv5C5wJa8BCMuYCR9Mor8jnNP2qKhRU/FndEL5Iez3G7o
         t1Jcwsu7XZQaGif0jEapRDavDrvXAatMIo4wIxltCfQrhWIbgpbeMBTd+TurNaHsBLDk
         nPrDpxTfbtLrDIxcwKrtvkqCPZ9ljl316Yx2KO2eq7Znd3kxmYVawjhtSxHadAIgPbhW
         EtA1LRz6jMKnzUfbuiCL9DN8Df+vvtkCdtq+SuYiQZ1TudmizywJ5nYM191TbIQ5D2Vz
         8aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704325899; x=1704930699;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGoDEads02//ume8qCZqx+lM6wcr/vJOxYyiy7bhOX4=;
        b=HjjcmkHLlZyYbeyX5mXpfxbSp81/mWg/jSwqKDx38y5XgFfKLnrhgjoOjeYkY50rzj
         ogpJQPMnPcsuMCNhtnl2cIads6pyDXwTC+feBOS1axCg18/5UTUQT8CRArqmYZv6d+/U
         aL8bNq7OnYEbMGyC2DpvkKaghCF2sUa/ftl/wrJfejOwgimu2teFjbbFUO22eDZH/EvH
         4vNYeLyVvBY+Au9jj6v+HfshNr+rXHq+wwE3cu5GUUPkW7LaLm/mkZWMBQl9a3zcYku5
         RAbWiZXwJMtnzWWrzxN4X4MofEeAemZhoiYqvtNoLmc6S6GC0o3hlggWDx69V0n5Qwlu
         MvGw==
X-Gm-Message-State: AOJu0Yx+yc7VLnphwJ/ZTPYvCz8BGwOVYeyEKdVlhJzdAJWyMlD8wxHH
	eIAdLno1ujCdOTbCu2iwVgU=
X-Google-Smtp-Source: AGHT+IFe9hLlWKC0ZlhM0jloXt6lwFViBUljtLuzmfpJSFtgcKRXGYpFeK8ENy/n730VTUypWGo57A==
X-Received: by 2002:a05:600c:4f93:b0:40d:5d91:888a with SMTP id n19-20020a05600c4f9300b0040d5d91888amr5664646wmq.233.1704325898756;
        Wed, 03 Jan 2024 15:51:38 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id zv13-20020a170907718d00b00a26aeb9e37csm12375811ejb.6.2024.01.03.15.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:51:38 -0800 (PST)
Message-ID: <2f889478e7fc787dee74816f9f374284a94a3041.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: add arg:ctx cases to
 test_global_funcs tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Jiri Olsa <jolsa@kernel.org>
Date: Thu, 04 Jan 2024 01:51:37 +0200
In-Reply-To: <CAEf4Bzbj8Eeo=SNtRzk75ST8=BnPVJi9CNp4KKpPaT_fnhUymA@mail.gmail.com>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-10-andrii@kernel.org>
	 <2e7306da990a9b7af22d2af271dacb9723b067fc.camel@gmail.com>
	 <CAEf4Bzbj8Eeo=SNtRzk75ST8=BnPVJi9CNp4KKpPaT_fnhUymA@mail.gmail.com>
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

On Wed, 2024-01-03 at 15:17 -0800, Andrii Nakryiko wrote:
[...]
> > However, the transformation of the sub-program parameters happens
> > unconditionally. So it should be possible to read BTF for some of the
> > programs after they are loaded and check if transformation is applied
> > as expected. Thus allowing to check __arg_ctx handling on libbpf side
> > w/o the need to run on old kernel.
>=20
> Yes, but it's bpf_prog_info to get func_info (actually two calls due
> to how API is), parse func_info (pain without libbpf internal helpers
> from libbpf_internal.h, and with it's more coupling) to find subprog's
> func BTF ID and then check BTF.
>=20
> It's so painful that I don't think it's worth it given we'll test this
> in libbpf CI (and I did manual check locally as well).
>=20
> Also, nothing actually prevents us from not doing this if the kernel
> supports __arg_ctx natively, which is just a painful feature detector
> to write, using low-level APIs, which is why I decided that it's
> simpler to just do this unconditionally.

I agree that there is no need for feature detection in this case.

> > I think it's worth it to add such test, wdyt?
> >=20
>=20
> I feel like slacking and not adding this :) This will definitely fail
> in libbpf CI, if it's wrong.

Very few people look at libbpf CI results and those results would be
available only after sync.

Idk, I think that some form of testing is necessary for kernel CI.
Either this, or an additional job that executes selected set of tests
on old kernel.

