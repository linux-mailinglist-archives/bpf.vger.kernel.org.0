Return-Path: <bpf+bounces-16609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF0803D16
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DE71C20B79
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5E2FC3B;
	Mon,  4 Dec 2023 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrM2QA/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB7B0
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 10:32:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50abb83866bso6149347e87.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701714725; x=1702319525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6zqY6thbbtdv8bFBG64n7K5kKUjA5vurF9+md8ou9c=;
        b=WrM2QA/N9q2JYUndyCbIp1C41obG/aqP1CBDwXZM9sugvFwNpQ7ayJ04yGiF+Mojow
         stmMbvQAfx2z40I3LznRFqCtKjuXlzYCtt8E5F+iHpSV8et/zELDQIvy8Hr6Of395wKm
         pSgZZgn9UuUuBtCw1yTfX44UiZGxSV59/vFcyzfANvBV6XzsjbZ9IuwEHXz87qOLh04x
         wQPAcdz+VSBtYLMrJmrTYazOnV+rjy0rxwjFGkfiaeGpMtWnPjZ0V+epsNxtXbIcFlWw
         fxLvrZ1gsPR131GkLI2T0hpD4ActTmz+s/bHiUUM3I5HIFjkU+HuDsyhIm7le0tHebEM
         w9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714725; x=1702319525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6zqY6thbbtdv8bFBG64n7K5kKUjA5vurF9+md8ou9c=;
        b=ZrGVTNJyJlJP8qTMNl+4T6BGgmFet1U7hu8ed2u6blCJkDMB6OC2S5KEFIan0zzBMi
         9xvlIe400OfyKBCAeX09Q1oQ4qHWMBdVdTSqLTZz3P2ktrnA6UL/xhb1Xqof8gZjJP1A
         pbFx51YkdTct+n1fVZ1jCbP6e+vXVlm5fge5YfkdsNCol5hNUaQGVld9oifxvWrZE6bW
         kjgrBS8dvZaljZMbFhmEMilCt9+7pBceNwQFdmh/i/a2VjOpRueyuz4rwHKeriax9eG1
         SWdxYFivSVpeunSrQ9fK0vBl9cHh0B4gzLbaxZspNW3P8hrBVwBu+f0pEApaTxTAXsN3
         NklQ==
X-Gm-Message-State: AOJu0YxaOgGhNUQM8EfofLaQLJ6/zRi7/4MyGuNHSaOz045Jjm1ZiIx2
	+G2n1YI/LZEdne1Xy162UEykFVd29+AMf9JRDpk=
X-Google-Smtp-Source: AGHT+IEO8/jonXbtHld/kbzXgXl7qMR2kcfaKO8Di8xfKTT8kSFnQ8S4xY9aNWdz7MLoeO5m1SVKz1dZ+2zmn+fUJ3Y=
X-Received: by 2002:a05:6512:31c6:b0:50b:fdc0:acb6 with SMTP id
 j6-20020a05651231c600b0050bfdc0acb6mr499543lfe.207.1701714725211; Mon, 04 Dec
 2023 10:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
In-Reply-To: <20231204153919.11967-1-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 10:31:52 -0800
Message-ID: <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:39=E2=80=AFAM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> This patch fixes a bug around the verification of possibly-zero-sized
> stack accesses. When the access was done through a var-offset stack
> pointer, check_stack_access_within_bounds was incorrectly computing the
> maximum-offset of a zero-sized read to be the same as the register's min
> offset. Instead, we have to take in account the register's maximum
> possible value.
>
> The bug was allowing accesses to erroneously pass the
> check_stack_access_within_bounds() checks, only to later crash in
> check_stack_range_initialized() when all the possibly-affected stack
> slots are iterated (this time with a correct max offset).
> check_stack_range_initialized() is relying on
> check_stack_access_within_bounds() for its accesses to the
> stack-tracking vector to be within bounds; in the case of zero-sized
> accesses, we were essentially only verifying that the lowest possible
> slot was within bounds. We would crash when the max-offset of the stack
> pointer was >=3D 0 (which shouldn't pass verification, and hopefully is
> not something anyone's code attempts to do in practice).
>
> Thanks Hao for reporting!
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=3Dh-efVogsRfK1FPx=
mkgb0Os_frnHiNdw@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index af2819d5c8ee..b646bdde09cd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6816,10 +6816,9 @@ static int check_stack_access_within_bounds(
>                         return -EACCES;
>                 }
>                 min_off =3D reg->smin_value + off;
> +               max_off =3D reg->smax_value + off;
>                 if (access_size > 0)
> -                       max_off =3D reg->smax_value + off + access_size -=
 1;
> -               else
> -                       max_off =3D min_off;
> +                       max_off +=3D access_size - 1;

this special casing of access_size =3D=3D 0 feels wrong (and I mean before
your patch as well).

Looking at the code, we only really calculate max_off to check that we
don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (and
beyond).

So given that, I propose to calculate max_off as an exclusive bound,
and instead of doing a mostly useless check_stack_slot_within_bounds()
call for it, just check that max_off is <=3D 0.

Something like this:

min_off =3D reg->smin_value + off;
max_off =3D reg->smax_value + off + access_size;
err =3D check_stack_slot_within_bounds(min_off, state, type);
if (!err && max_off > 0)
    err =3D -EINVAL; /* out of stack access into non-negative offsets */


Now, one more issue that jumped out at me is that we calculate min/max
off as a sum of smin/smax values (which are checked to be within
+/-1<<29, all good so far) *and* insn->off, which can be a full s32,
it seems. So we are running into overflow/underflow territory with
using int for min_off/max_off.

While you are at it, can you please use s64 for all these calculations? Tha=
nks!


>         }
>
>         err =3D check_stack_slot_within_bounds(min_off, state, type);
> --
> 2.40.1
>

