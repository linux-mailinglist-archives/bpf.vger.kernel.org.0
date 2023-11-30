Return-Path: <bpf+bounces-16237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C647FE945
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 07:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064AC1C20D37
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609B1774A;
	Thu, 30 Nov 2023 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7zVmoim"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587E10D4
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 22:41:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a00b056ca38so72465466b.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 22:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701326517; x=1701931317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/BlhJ/DwhbIqkEY+dnaRzW/Wb3eTHZsWYaIt25goZg=;
        b=S7zVmoimDyVbaolStBdJMZxKy9mj0Lzx0uTjzkDmWKDhueIupcuqQgpdDc5Z9GtD0F
         W/ld5548AbTizptjdIsJJYu8czed/PPXuSai8rd3zv39Sgx65dWWn7cT+XoM4xG/+Hfp
         BYkF/+mRjJFdUC5JcDYnqcVRSsCUFcLzOc9Qd0tsxq3T4zCFgahYzDs+z+sJhSHdXmcs
         SnK7cJMavO5VXln/yJm/9Jrb0ntQkV/BEA7FXBZusO0P/FuPA4HMO9gSr4LvaqDEjtMd
         A+5GoOJBENgxrk5uc8FR1uNTwL6fLCIP5RYTKfwtb827o5vwv1amfkdXgubm/a/EzeX+
         W5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701326517; x=1701931317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/BlhJ/DwhbIqkEY+dnaRzW/Wb3eTHZsWYaIt25goZg=;
        b=gbw0FEWv10bkRNwAQ7yxcfoQaff9Ts5xk3EqowkvCvCrwwhX6fD7jr5p4xWgtGE1x3
         63kTyBq2L38oanjCL7V5GpnLJ7V+hiSka1qUwhn+JPE2jiavU4ExdDCBxeLKx9xS5L2t
         g0s2+7x1aXbF93w11ppQY0qMgbiZNYyEnAwOXQ/BhTckK7EKvWipjrGRL9xHMLN4hlf7
         HuoWuylBSiT7SOl1sBlrJjGGBGwf1cUiSGDRLZWlszJWA46DrlKTM5B1DyG/JwpTDyl5
         YzlPjH5p/BQxRoCCDiOZzqZR2t2ytJLU8pHvh4cezKQFMwECkHmd+yFdsxhQgUfBP4Oj
         FbFQ==
X-Gm-Message-State: AOJu0Yw+8jU2pqxxKH7vdL8XE/t/EMKfkmaRQGYOQo2jM3yEg6keVNKr
	ig7uv6cMl72ciYLg4gWIB51kRw5yLPIBA+Hx7Lg=
X-Google-Smtp-Source: AGHT+IG8P+c39hI+FntBbs0Jm6auop9p3e6qHfZwSfNAFtEL/sRE+SbLZySS80ncM3WaHHP3fbslx0T8q1zKW9fwC6w=
X-Received: by 2002:a17:906:1091:b0:a0c:c09f:65fe with SMTP id
 u17-20020a170906109100b00a0cc09f65femr9993717eju.38.1701326516868; Wed, 29
 Nov 2023 22:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130000406.480870-1-andrii@kernel.org> <20231130000406.480870-8-andrii@kernel.org>
 <dybeiygqc6qllxhuaagvylw4bgiyyqxzz6cu3vbvcloiz4mgux@qfzwtupey7p7>
In-Reply-To: <dybeiygqc6qllxhuaagvylw4bgiyyqxzz6cu3vbvcloiz4mgux@qfzwtupey7p7>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Nov 2023 22:41:45 -0800
Message-ID: <CAEf4BzZ2Wy5phbxw2T1JDWZUw4XeYPvWP5wnycgD7AL9=DbErw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/10] bpf: enforce precision of R0 on
 program/async callback return
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 10:33=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Wed, Nov 29, 2023 at 04:04:03PM -0800, Andrii Nakryiko wrote:
> > Given we enforce a valid range for program and async callback return
> > value, we must mark R0 as precise to avoid incorrect state pruning.
>
> Looking at previous discussion[1], this commit fixes the potential
> "out-of-range r0 got state pruned" issue. To my best knowledge that
> means this commit would be needed all the way back in
>
> Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
>
> Is this wildly off?

No, I think you are right. Added Fixes: tag as suggested.


>
> 1: https://lore.kernel.org/r/20231031050324.1107444-4-andrii@kernel.org
>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c54944af1bcc..2cd150d6d141 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15138,6 +15138,10 @@ static int check_return_code(struct bpf_verifi=
er_env *env, int regno, const char
> >               return -EINVAL;
> >       }
> >
> > +     err =3D mark_chain_precision(env, regno);
> > +     if (err)
> > +             return err;
> > +
> >       if (!retval_range_within(range, reg)) {
> >               verbose_invalid_scalar(env, reg, range, exit_ctx, reg_nam=
e);
> >               if (!is_subprog &&

