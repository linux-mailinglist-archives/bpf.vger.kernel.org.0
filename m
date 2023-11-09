Return-Path: <bpf+bounces-14541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6587E616A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 01:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6751C20B64
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229975C83;
	Thu,  9 Nov 2023 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6iz/UL+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F15663
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:31:00 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F8268E
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 16:30:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d267605ceeso48413466b.2
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 16:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699489858; x=1700094658; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=egjK0eLBfGZdNOos6dPhXTDiatJjDKwO2AhKpRbrDBs=;
        b=Q6iz/UL+LDO2vZwDgP7FSJt/MorMW2pdUdmt2SprGWIxg2z+u4dlQo38Fs8j96+om0
         Sasrz4/4+gkmjQ0+rmLR9j01mMxjYDMmH8UBX9GYBygmOrKRF9srBOKQA0PtPDc2ieJk
         pi3o2VpIn1OURh8/Ur0dM+iB+bJKqO3DKNZERWKpWc0DS3N3x5zhTZjRahqJWAkw1mpl
         jrvMmooESHz6rgYdtrN+riZSa7CTRGn2GImo8KptX95JR/w6u+z7dWQXpcFsCj7EVJwJ
         fdU/4OTDALr/a6ey6PzcmafCjeMesQJ7HVn3hu1oULlt9Nk6kOq852cH7FGlgORsnpvW
         YAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489858; x=1700094658;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egjK0eLBfGZdNOos6dPhXTDiatJjDKwO2AhKpRbrDBs=;
        b=UpYv2hqTavbriWVdXORA3ZaQO5AVJXmH7USipdxC1hI72UFLolRHYt1pzzO9v+db5D
         MkO78XiDJUXfhrRE1CkOXYnLOy/kcVBUytP5y9Kq6hC/FIZTxRP5wH8KYV4Eq39JxD6d
         zxiCLEN777H3huWpPvUCcx8jov/BhcbDfCUgjrcEG9QJtcdn/sMwD0MvpPUAS0nf2/SY
         6EaIWAZ0tpvDNiK82le8RfdzSg70vchn1LAhlsGLjlvjtKbnizyxqs5HBOTKJZi22w9q
         wwp8I7TO8+oPOeoHOoad6MEoxULTPwrdwxflFPABINJkfrfuZhmkirCc3Oqe2lrXDJTD
         l0jg==
X-Gm-Message-State: AOJu0Yxp6SrbUw3P9eok1AYhQjKQw+I5LLFWIF5LfpXfar2f2k1y0Xej
	UtslOQO3fhHa3fIqRHAfhCS6ZRRVALc=
X-Google-Smtp-Source: AGHT+IE+uXWLQa2F/0p92aN2V/ocXAYO0qnsyJkzU0xSkPknfci8Op1CFafQMVtSNeKQLEYtLr+zfQ==
X-Received: by 2002:a17:907:5cc:b0:9dd:7db7:a0af with SMTP id wg12-20020a17090705cc00b009dd7db7a0afmr2301084ejb.56.1699489857578;
        Wed, 08 Nov 2023 16:30:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906685100b009aa292a2df2sm1776211ejs.217.2023.11.08.16.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:30:57 -0800 (PST)
Message-ID: <28035bd765e9be61c43e60c5e4fa9cdf17adbc2b.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/23] selftests/bpf: BPF register range
 bounds tester
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Thu, 09 Nov 2023 02:30:55 +0200
In-Reply-To: <CAEf4BzacVodTEQX5S2nFd2Ndet-wU0JeNs9ZF54R=J+FOHRVmA@mail.gmail.com>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-11-andrii@kernel.org>
	 <e89051a718d676f6f73d354774c2161dfe562faf.camel@gmail.com>
	 <CAEf4BzacVodTEQX5S2nFd2Ndet-wU0JeNs9ZF54R=J+FOHRVmA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-08 at 15:23 -0800, Andrii Nakryiko wrote:
[...]

> > It is a maintenance burden in a way.
>=20
> It's unlikely to need changes, so I hope it won't be. But it's also
> good to have as a cross-check for future work, like Shung-Hsi Yu's
> attempt to make range tracking sign-agnostic.

Testing for non-functional changes is a good point.
Anyways, I don't have a better alternatives to suggest at the moment.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

