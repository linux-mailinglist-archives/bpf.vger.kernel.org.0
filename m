Return-Path: <bpf+bounces-18961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CA82391A
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C318B24793
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0C1EB53;
	Wed,  3 Jan 2024 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwN3QdN7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53C1EB51
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso506197e87.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 15:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323877; x=1704928677; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3fD1kciZPEAf4Ee/FJGbnCGmPXbrutUTQB4FcxfXjWU=;
        b=iwN3QdN78cFnMGOk2akAdUbsPeet2FWWc6FDV/CAkcGnXIQg9qoUooIaO0R/LViCzF
         ZGMs4bplmY1t//3g20X2tvsF3hWwpht2IAkv2JmZPx8dvdqQF0IwNofXEGKa3uYiENh1
         BSOhB7+CG35n1mUlW8dYovWcKq5pAnihHUped69NgagdxfsaOdAvCZk21+ZNw+EEE6UX
         2Ls6pCQw4v+x91XpXutxlGhXNaNObcbfv92x7lW4FYhkOcot2A8iI3U1W9t+ChmTSfGm
         oOHI9SJxNqSwTmIxDcghtjHtYyTY66rVHdGkuk4pr4525Yxu1zUjRIThDvNGKnqC9HwD
         pIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323877; x=1704928677;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fD1kciZPEAf4Ee/FJGbnCGmPXbrutUTQB4FcxfXjWU=;
        b=anrk76Kbjq8HoTsCGPrRCmkjrzAeHecAARCA4PgWEAEc5pLak8P+OBRk+I+PdZFN7o
         eHIA0j5yt3MsBu7zdRaESTz4ybAo1OOHFukJ67VcuM5+IkIDTw5SHwPt6UbR0KEYBJXr
         5CZrzuPhuUfkPyaUgF2vhlZ3BKNS95IXbvFutMBjAc44Wio5PZkp5GF7GEiNO9ofMyi4
         JWgrUYidcx4gBq+exV+vKsb6RRjbe+JnaXhW3BJW1D34igchEY7/vJG1tSWtF/jI6GNI
         HIcDaZH8wpIyc22pubuGzg0YkbcmrwoJQhzQ3oC1II8BqnmC2ME6+zLLU5i7IFXelS/t
         2P5w==
X-Gm-Message-State: AOJu0YwTDdIJ5HdtybBgFVZyp0lilcaDVWBSCSHDrydgbAxxd9OXbFwV
	E1GNqLB1UlVkPQCuT+V90D0=
X-Google-Smtp-Source: AGHT+IF2FbFx1eIzX3RYhcTfXstpkzT4hLG3yQ8CkX/p7/jZvoY1/ONTK8Fxxr3723ycP3PQxhdiMA==
X-Received: by 2002:ac2:5e33:0:b0:50e:6b48:5407 with SMTP id o19-20020ac25e33000000b0050e6b485407mr7421617lfg.82.1704323877223;
        Wed, 03 Jan 2024 15:17:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id zv13-20020a170907718d00b00a26aeb9e37csm12355725ejb.6.2024.01.03.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:17:56 -0800 (PST)
Message-ID: <28d03d76c70881a739f2f0b745da1fba131d486f.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/9] libbpf: name internal functions
 consistently
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
	 <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 Kernel Team <kernel-team@meta.com>
Date: Thu, 04 Jan 2024 01:17:55 +0200
In-Reply-To: <CAADnVQ+XcewF3aQm1itG_8GDOEbgRZLknYPyK_JuCjzQJ4=+_w@mail.gmail.com>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-2-andrii@kernel.org>
	 <CAADnVQ+XcewF3aQm1itG_8GDOEbgRZLknYPyK_JuCjzQJ4=+_w@mail.gmail.com>
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

On Wed, 2024-01-03 at 15:12 -0800, Alexei Starovoitov wrote:
[...]
> At the same time I agree that a public function looking different from
> internal is a good thing to have.
> We have LIBBPF_API that is used in the headers.
> Maybe we should start using something similar in .c files
> than there will be no confusion.
>=20
> Not a strong opinion.
>=20
> Eduard,
> what's your take?

I kind-off like private vs. public method encoded as '_' vs. '__'.
But this seem to be a minor detail, personally I grep header file
each time to see if LIBBPF_API is used for certain function and
that is not a big deal.

