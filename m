Return-Path: <bpf+bounces-13732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D198B7DD4C9
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098EE1C20C9F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A540208C2;
	Tue, 31 Oct 2023 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypdxm6Vn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAB134BA
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:39:32 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40BF92
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:39:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-540fb78363bso10240382a12.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698773969; x=1699378769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuFqII5lx4gDj6l4552okZfPDfPOCS7K2TqGCI2kZek=;
        b=Ypdxm6VnpyjNtv0PQxK6VnQ24hUzhPeque7CsFrniIQpNV6oB3CXCbGFJgYbKjsKq3
         Ff3w6ZA7Ipo7pQLB93M4mOlmKaSXmk6v7NqEM+JUbCOS6/+s9VbfoBBqSW4ZU2DdttrK
         wP2AE1lmb9RdicksFtEX6I9hOIo6XUtBWa2xFH94fUai6WnefWhSvi1Kki9GcufjhT+G
         i9nwrJ9T6VO0bhs1peoYyvBuM/Z7OKSorf67n7HufeGWfEQfmCWy3bvEfzKcwsxAkhlh
         tOjBbrTeTj/VhlzRXE5z6bPiU0n5cE2++szXGAgPbBu1dUZwNG7T5AK0oK/hygr8MkwI
         IdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773969; x=1699378769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuFqII5lx4gDj6l4552okZfPDfPOCS7K2TqGCI2kZek=;
        b=tTXtoPH7g3YcvFSSRN3sZ9whXJ4o6bgAXsOpmR7IdP3wN8KZPvNfWZibgfdh6mi/9S
         97vh7hynJi3LZTFqNEomgbkw4/TLrKUTz5hbzOjfFuaFW+SWFnZQ5iAzG/laadn9ZE/5
         mrCjRR+lMUXkt3gwWABj8/S/S8mcj6H9X7y0+f0Onmo+r0Co88usUZed+/VFAvwcMNyX
         EPNav1f4+xKihn9OVLlTtTe6hTMuQo3I39ofxwiBmgAD11MnNkcXE2J873vLKKRXZ5ws
         2XoxtrgmRSpPArtaGmfLfdmj4jy0gQWesWj1uoBYFcuDk9a20PDURQOwJIDjp/b0YbKF
         g1HA==
X-Gm-Message-State: AOJu0YysyOcEfZkK2HNPEOi9is5CNhXaMymlGM98FSkYeuTIhQbGfhk4
	HV1AepMum6/AlI8ovkjEnaGSrRiptxAjRZNj0Wk=
X-Google-Smtp-Source: AGHT+IFO/uB7ycjwcekl+KjAasBwqdU0TYX+o+yK8A4PBVpR6lhoFcdef/tXfZq7JHHZNZFk+BO8JE+Zni2X72fuYoE=
X-Received: by 2002:a17:907:2da3:b0:9bd:c592:e0ce with SMTP id
 gt35-20020a1709072da300b009bdc592e0cemr16695ejc.51.1698773968897; Tue, 31 Oct
 2023 10:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-7-andrii@kernel.org>
 <d7af631802f0cfae20df77fe70068702d24bbd31.camel@gmail.com>
In-Reply-To: <d7af631802f0cfae20df77fe70068702d24bbd31.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 10:39:17 -0700
Message-ID: <CAEf4BzZVmEUP-+jP34H+UJF5qK2boKFHH3+rpKkjEVEKvN4eMQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 06/23] bpf: add special smin32/smax32
 derivation from 64-bit bounds
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 8:37=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > Add a special case where we can derive valid s32 bounds from umin/umax
> > or smin/smax by stitching together negative s32 subrange and
> > non-negative s32 subrange. That requires upper 32 bits to form a [N, N+=
1]
> > range in u32 domain (taking into account wrap around, so 0xffffffff
> > to 0x00000000 is a valid [N, N+1] range in this sense). See code commen=
t
> > for concrete examples.
> >
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> fwiw, an alternative explanation might be arithmetic based.
> Suppose:
> . there are numbers a, b, c
> . 2**31 <=3D b < 2**32
> . 0 <=3D c < 2**31
> . umin =3D 2**32 * a + b
> . umax =3D 2**32 * (a + 1) + c
>
> The number of values in the range represented by [umin; umax] is:
> . N =3D umax - umin + 1 =3D 2**32 + c - b + 1
> . min(N) =3D 2**32 + 0 - (2**32-1) + 1 =3D 2
> . max(N) =3D 2**32 + (2**31 - 1) - 2**31 + 1 =3D 2**32
> Hence [(s32)b; (s32)c] form a valid range.
>
> At-least that's how I convinced myself.

So the logic here follows the (visual) intuition how s64 and u64 (and
also u32 and s32) correlate. That's how I saw it. TBH, the above
mathematical way seems scary and not so straightforward to follow, so
I'm hesitant to add it to comments to not scare anyone away :)

I did try to visually represent it, but I'm not creative enough ASCII
artist to pull this off, apparently. I'll just leave it as it is for
now.

>
> > ---
> >  kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5082ca1ea5dc..38d21d0e46bd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2369,6 +2369,29 @@ static void __reg32_deduce_bounds(struct bpf_reg=
_state *reg)
> >                       reg->s32_max_value =3D min_t(s32, reg->s32_max_va=
lue, (s32)reg->smax_value);
> >               }
> >       }
> > +     /* Special case where upper bits form a small sequence of two
> > +      * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
> > +      * 0x00000000 is also valid), while lower bits form a proper s32 =
range
> > +      * going from negative numbers to positive numbers. E.g., let's s=
ay we
> > +      * have s64 range [-1, 1] ([0xffffffffffffffff, 0x000000000000000=
1]).
> > +      * Possible s64 values are {-1, 0, 1} ({0xffffffffffffffff,
> > +      * 0x0000000000000000, 0x00000000000001}). Ignoring upper 32 bits=
,
> > +      * we still get a valid s32 range [-1, 1] ([0xffffffff, 0x0000000=
1]).
> > +      * Note that it doesn't have to be 0xffffffff going to 0x00000000=
 in
> > +      * upper 32 bits. As a random example, s64 range
> > +      * [0xfffffff0ffffff00; 0xfffffff100000010], forms a valid s32 ra=
nge
> > +      * [-16, 16] ([0xffffff00; 0x00000010]) in its 32 bit subregister=
.
> > +      */
> > +     if ((u32)(reg->umin_value >> 32) + 1 =3D=3D (u32)(reg->umax_value=
 >> 32) &&
> > +         (s32)reg->umin_value < 0 && (s32)reg->umax_value >=3D 0) {
> > +             reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s3=
2)reg->umin_value);
> > +             reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s3=
2)reg->umax_value);
> > +     }
> > +     if ((u32)(reg->smin_value >> 32) + 1 =3D=3D (u32)(reg->smax_value=
 >> 32) &&
> > +         (s32)reg->smin_value < 0 && (s32)reg->smax_value >=3D 0) {
> > +             reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s3=
2)reg->smin_value);
> > +             reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s3=
2)reg->smax_value);
> > +     }
> >       /* if u32 range forms a valid s32 range (due to matching sign bit=
),
> >        * try to learn from that
> >        */
>
>
>

