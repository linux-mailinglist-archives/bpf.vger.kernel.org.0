Return-Path: <bpf+bounces-64304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A41B11347
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 23:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736BC1CE5EA1
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 21:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7468230D0A;
	Thu, 24 Jul 2025 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwf7LWdH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8C215055
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393793; cv=none; b=BIWV1RHvp0V+iN+9T7ycaXMWxknnyV12Pfnm7y+aXvqA88fTV7A6GidNDou+nvU9mVwWtqQAIBlOcM22BMZ3CZEGXKAjwY/3EUAmWbtuKfb5NCu+idb5RUHO8cEM7cRYKpL/X+/E7aqQNl8NQOmSgadSu6WNmSHWF1IQjFhzRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393793; c=relaxed/simple;
	bh=PXyzyR1uY0f7fpqZ/TnSz5dYTZ2wjnXYZZYoK50tt4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRd+DSDzCgDeMlPmNM27EobzR1onKdaRFZRcI9qro0cKfI9An2d6FXbb394IKlXp7GCe7tMyaFfVgMT/awvdA9sJ07mEEECDZN6rwvRFyh5Akhzv5FqcDy3ayMIJxkVZjdg9nxPpvuxNb+b4CIdP0mLTnj1PePIrDfPlhypV6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwf7LWdH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74924255af4so1365721b3a.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753393791; x=1753998591; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7Tx0a+60qP+gXLKTjAez7IdWh38iGuYY/UIBjKt/NY=;
        b=Wwf7LWdHh5V/he4RWPDJyQJeMeokKNo+qn7ex3bmzQfTtRZXRwGyKp6XZpjXwQ5YMb
         TXvR7O1/2WAA7yuz3oXFq7tl34wZZQR8qtbXpHLMBu9480vyCq8PDo9l8d+3iYguFUb/
         3GzLO/vJ3Jtlz8fx5BoW7209IHy3xODvfDUbIJhSyRjCOjfycuqAYbXaJ9yMNjKOD0Ly
         khUuqSGztmm8d4GAnuPMzUutrLqYBYbVaH7iC6MG8uYiWNwbDoqUNynkBSiQ2SCvRR2Q
         wanHrV6+8YnGWjSCe/sggFx6qUZi0ccuSYpIbuqVYWqRWg4BEgtRqJtAd5ojgYrmU93x
         wTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753393791; x=1753998591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7Tx0a+60qP+gXLKTjAez7IdWh38iGuYY/UIBjKt/NY=;
        b=sE8vWFtHRXZQ7VZbdlUNf5OCN587XfRd5OHJ6gyWo9xHz5pwRiD6qghwoli5FCmDf4
         /Q92yhme0ec+eBwcXdu6+xJrhnBSczUNiyUFOGgyZv5fzFJkXCdO6+iZy77FlEtUZ38A
         Wutt67gQ2ZVmRfmMOkmuYjoG3fGSKi/BdLQVTN5gKwxbR+ndZnUl2igq0AH5n0cPzBbt
         rNWzIzxyD+Z7LFpQEX7Ea/scJ+10tV09jQ4vm11l0kYUxtJXNtK0J+c6zOOzhdAcnUfP
         htmVzjgKheSfqN9Tl2B4JepZqJadxuLohkSFQeyaAalXYUJs7sburaarLKKd8NUH0QCC
         /gXw==
X-Forwarded-Encrypted: i=1; AJvYcCW2AnyM0O6meFKa2mx8oHHHqGy6d6rMnKXGBnvB9lJknuckLnpC8sktS+aL9ezTTo1Bc5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQqwPQ3N6DhW0EM6iozKTxNRDk86xvfbS1m/AmLM93xICFYNw
	KuGGF2HdTJJD9NQ9Js95OfIoBE+W8AdeBA32774CEYscy38NtV32R7bW
X-Gm-Gg: ASbGncsTj7PAsDVKbe6ZxCI3WoNr/mQMRmN7L6zMW+6AjO2fTFfRewnE4orkgmZ6h7p
	0GlqOoadr9YTQ5ETA7ZURMd7bLtqPHiJXT1B4OI10JX/KL2SIXZe9AvwxC5sZTsvztlvKxme/3h
	nJA327zna8eRINzNvt+3OA3GPIfYQ7XyjY6aFJrtRkrM5ifQm4ktH2TmfhojWtg+VUF7EZ9anNB
	NPhf56/dP3LljhfVD016QaBZjcarOSVQstHy0X89j4X66sdlPvaabHKqs+j8G3KonVLtFS8odGj
	n7mFBChUKq5K9hdgMofsRRH2r5wf0SwKRvlzrJFNr99MIC7Z5gNOH57Ppyb2QIfcbPeYOlqAWRy
	pMA4cNU3l8LjJwRvljrjmefT5mYEZ
X-Google-Smtp-Source: AGHT+IGRQCReKUPWLRiAQihMydnHXuBH2q37T5y2N4MfFqh0M8pSm0vqo1irUtf1nW5kJJngFTsOXw==
X-Received: by 2002:a05:6a21:7a45:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-23d4916b297mr12693889637.42.1753393790998;
        Thu, 24 Jul 2025 14:49:50 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b04b3523sm2417871b3a.72.2025.07.24.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 14:49:50 -0700 (PDT)
Message-ID: <4da44707e926d2b2cb7e1d19572d006d7b7c06bd.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Simplify bounds refinement from s32
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Thu, 24 Jul 2025 14:49:47 -0700
In-Reply-To: <aIJwnFnFyUjNsCNa@mail.gmail.com>
References: <aIJwnFnFyUjNsCNa@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-24 at 19:42 +0200, Paul Chaignon wrote:
> During the bounds refinement, we improve the precision of various ranges
> by looking at other ranges. Among others, we improve the following in
> this order (other things happen between 1 and 2):
>=20
>   1. Improve u32 from s32 in __reg32_deduce_bounds.
>   2. Improve s/u64 from u32 in __reg_deduce_mixed_bounds.
>   3. Improve s/u64 from s32 in __reg_deduce_mixed_bounds.
>=20
> In particular, if the s32 range forms a valid u32 range, we will use it
> to improve the u32 range in __reg32_deduce_bounds. In
> __reg_deduce_mixed_bounds, under the same condition, we will use the s32
> range to improve the s/u64 ranges.
>=20
> If at (1) we were able to learn from s32 to improve u32, we'll then be
> able to use that in (2) to improve s/u64. Hence, as (3) happens under
> the same precondition as (1), it won't improve s/u64 ranges further than
> (1)+(2) did. Thus, we can get rid of (3).
>=20
> In addition to the extensive suite of selftests for bounds refinement,
> this patch was also tested with the Agni formal verification tool [1].
>=20
> Link: https://github.com/bpfverif/agni [1]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

So, the argument appears to be as follows:

Under precondition `(u32)reg->s32_min <=3D (u32)reg->s32_max`
__reg32_deduce_bounds produces:

  reg->u32_min =3D max_t(u32, reg->s32_min, reg->u32_min);
  reg->u32_max =3D min_t(u32, reg->s32_max, reg->u32_max);

And then first part of __reg_deduce_mixed_bounds assigns:

  a. reg->umin umax=3D (reg->umin & ~0xffffffffULL) | max_t(u32, reg->s32_m=
in, reg->u32_min);
  b. reg->umax umin=3D (reg->umax & ~0xffffffffULL) | min_t(u32, reg->s32_m=
ax, reg->u32_max);

And then second part of __reg_deduce_mixed_bounds assigns:

  c. reg->umin umax=3D (reg->umin & ~0xffffffffULL) | (u32)reg->s32_min;
  d. reg->umax umin=3D (reg->umax & ~0xffffffffULL) | (u32)reg->s32_max;

But assignment (c) is a noop because:

   max_t(u32, reg->s32_min, reg->u32_min) >=3D (u32)reg->s32_min

Hence RHS(a) >=3D RHS(c) and umin=3D does nothing.

Also assignment (d) is a noop because:

  min_t(u32, reg->s32_max, reg->u32_max) <=3D (u32)reg->s32_max

Hence RHS(b) <=3D RHS(d) and umin=3D does nothing.

Plus the same reasoning for the part dealing with reg->s{min,max}_value:

  e. reg->smin_value smax=3D (reg->smin_value & ~0xffffffffULL) | max_t(u32=
, reg->s32_min_value, reg->u32_min_value);
  f. reg->smax_value smin=3D (reg->smax_value & ~0xffffffffULL) | min_t(u32=
, reg->s32_max_value, reg->u32_max_value);

    vs

  g. reg->smin_value smax=3D (reg->smin_value & ~0xffffffffULL) | (u32)reg-=
>s32_min_value;
  h. reg->smax_value smin=3D (reg->smax_value & ~0xffffffffULL) | (u32)reg-=
>s32_max_value;

    RHS(e) >=3D RHS(g) and RHS(f) <=3D RHS(h), hence smax=3D,smin=3D do not=
hing.

This appears to be correct.

Shung-Hsi, wdyt?

[...]

