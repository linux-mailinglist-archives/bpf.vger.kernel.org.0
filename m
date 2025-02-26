Return-Path: <bpf+bounces-52682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BDCA46A14
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FDB16C855
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260EB236A7B;
	Wed, 26 Feb 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXUu1Vej"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C13235362
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595652; cv=none; b=QkLsRXwRFfP2DtcPYL7DEnjDv52yk/nimgsfOlVDjQ4GGCoY88UgdTpucB0CRljrWf/Rl+ssqJjHI0clfIZq2Hb2Q9RcQDCZD8K96NGVku0D0gOpofzIEOveHNyNxNQHvK/uf03VvIC9w8JiIcYdzSiP12B66EIn1i03HpWx0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595652; c=relaxed/simple;
	bh=OCi8S8YhSxUk8fZsSdzIECbkU7yLbub9eyvAYrVx6ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4UbvD21+qAiGXkzv4wQ67F/A7S9uTm9grTCakvAaS4vNycPPvjLcUg1rjmh2cKsMiyoiBjcoyciXV/MWxV8XMWG5Lp/kBwcA8jgQocMe9gmV1RHwGiRuOFFG53tYm5Vnccos5RG+fTUyJBgCxFtsOXUxLucJcnDqfh3jdece14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXUu1Vej; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso290246a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740595650; x=1741200450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DarJ9DkyyRlL+7I/NgHFkUceVYUcx6SgJ9TV8j88EWw=;
        b=dXUu1Vej58Z5QIsrTyTttraLYaH6Z34rmzFqNNviRrQjNhndcCKesyXKNfp8r83FzF
         lw0sB2ENE8827GfUvWQ2OXWObijRJ2jbjl2KK7se39Z7oL0sm0HSYcpBbdDc50+ROvrs
         7bwia9R9ijqIpT+BLZEZLGqt41dF6Y9PfS4HvbvEb7Ua6y2ATwfr20map4+JAcoxiI/N
         ZZhh0R8RHqnZORroyN7s42ITHfFMghgym6mgFk35CCFXXN6P9IxAInLUqV44DSh5cTwY
         jCrNqRvagB6Vz/xd78KzCz+g+o40CVPk7WylaFV47JyhHuKgN3UoCezi1PLApddj3cXb
         CQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595650; x=1741200450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DarJ9DkyyRlL+7I/NgHFkUceVYUcx6SgJ9TV8j88EWw=;
        b=T/0AX9f47aF0l9n9FW0ITD3cy669hjpRPWGhRPX7FDn11vYghSoXQ6ajDIT5f+BRqu
         TvVRRVAUFZWAPpQzo+IwAcLC9gbO4n8xrAHaTDAKyLTupAlCnHKrAT5HzdOFzphR8JXW
         U0SFjHaq2E4EvevA+wYhBcio/uBNeC3HgbDWOdR5LmmbCYqwmM4uLMi6nOG5fSrStkCT
         Qma7iRxkhAekhbIcwdhLZmBXb2NI03c1c30Sj8XsB6TPpvRPunEuU+fwqDyyVt8gQnyt
         Tm1puJo5Re/7ALgBkxRNEypL6QRyEXqWE67W7jdG1ITEIZBkSfoCn2AsC6gML1wu3EWj
         eBhA==
X-Forwarded-Encrypted: i=1; AJvYcCUp66VUsQrAjXxAI40pvplTbVEeoDxSXJop1dfohYgb7YSPxeXX0Y5Lxd136hq3eAex/iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUioLumfbME06ygvp4u12HIJkxy896HfNWAgpbniQ5zodDSw+
	Ob1j0cbxs/IBsQPrvLJ2WpgBriqmdTg63mcJ8ZPyMzHZyU31g47ff11ZgXceWDdUAjWVvGXktp2
	JyUKWHspPbp6L9GjELk112kP8T7k=
X-Gm-Gg: ASbGnctTe2wy6eil6fCpQNazifYeic4+bb+Dp1rdy8XX1eMNbpJPS81h1KOpQvcHg/F
	fsOpskVhYZtojRomtjfA9ANG/NExd7nhOrlqUS6tZIDu5pILF4aibAtss1ABi9YBXJywYK/CF45
	klkBCny4zbyq6Rq7cqEjd6ETI=
X-Google-Smtp-Source: AGHT+IH78NXIctil5dIDkte1Al1750ESTTHHW/zLhN5x8vz2R9EnEKpwml0Ai3mF6Fk2JDwVptHqECf0/EvZmYsN1fo=
X-Received: by 2002:a17:90b:2dc2:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2fe7e3b3240mr6930459a91.35.1740595650371; Wed, 26 Feb 2025
 10:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
 <20250225163101.121043-2-mykyta.yatsenko5@gmail.com> <b8b36cfa2700a753e85468591ac3ec458b3a5fa5.camel@gmail.com>
 <CAEf4BzbHLmDFeL1+24O_LtA6tKV7DDTEi2YzEhifrPX6Gu5mfw@mail.gmail.com>
In-Reply-To: <CAEf4BzbHLmDFeL1+24O_LtA6tKV7DDTEi2YzEhifrPX6Gu5mfw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Feb 2025 10:47:18 -0800
X-Gm-Features: AQ5f1Jr44IDOm0UhbnSn8Il8ClNPgrQf1xH8MOw-3gQa2cE4wFETq7UJ1ml3t3c
Message-ID: <CAEf4BzaN+kuA_ez1_Mj4OZ5DPmr_n0K2A5xwpwfMR-6P+CFiwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 25, 2025 at 11:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >
> > On Tue, 2025-02-25 at 16:31 +0000, Mykyta Yatsenko wrote:
> >
> > New warning for trying to set non-enums from enumerators works fine.
> > This still can be abused if numeric value outside of the supported
> > range is specified, but that's fine, I think.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > [...]
> >
> > > @@ -1292,6 +1320,268 @@ static int process_prog(const char *filename,=
 struct bpf_object *obj, struct bpf
> > >       return 0;
> > >  };
> > >
> > > +static int append_var_preset(struct var_preset **presets, int *cnt, =
const char *expr)
> > > +{
> > > +     void *tmp;
> > > +     struct var_preset *cur;
> > > +     char var[256], val[256];
> > > +     long long value;
> > > +     int r, n, val_len;
> > > +
> > > +     tmp =3D realloc(*presets, (*cnt + 1) * sizeof(**presets));
> > > +     if (!tmp)
> > > +             return -ENOMEM;
> > > +     *presets =3D tmp;
> > > +     cur =3D &(*presets)[*cnt];
> > > +     cur->applied =3D false;
> > > +
> > > +     if (sscanf(expr, "%s =3D %s\n", var, val) !=3D 2) {
> > > +             fprintf(stderr, "Could not parse expression %s\n", expr=
);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     val_len =3D strlen(val);
> > > +     errno =3D 0;
> > > +     r =3D sscanf(val, "%lli %n", &value, &n);
> > > +     if (r =3D=3D 1 && n =3D=3D val_len) {
> > > +             if (errno =3D=3D ERANGE) {
> > > +                     /* Try parsing as unsigned */
> > > +                     errno =3D 0;
> > > +                     r =3D sscanf(val, "%llu %n", &value, &n);
> > > +                     /* Try hex if not all chars consumed */
> > > +                     if (n !=3D val_len) {
> > > +                             errno =3D 0;
> > > +                             r =3D sscanf(val, "%llx %n", &value, &n=
);
> >
> > The discrepancy between %lli accepting 0x but %llu not accepting 0x is
> > annoying unfortunate. Does not look simpler then before, but let's
> > merge this already.
>
> yeah... with sscanf() we at least get whitespace trimming at end, so
> don't need to check that. But I agree, doesn't look better.

While applying I realized that space trimming is not necessary,
because earlier sscanf() does that for us. So I rewrote this back to
something that looks like the earlier version. I think it's cleaner. I
ended up with this implementation of append_var_preset:

static int append_var_preset(struct var_preset **presets, int *cnt,
const char *expr)
{
        void *tmp;
        struct var_preset *cur;
        char var[256], val[256], *val_end;
        long long value;
        int n;

        tmp =3D realloc(*presets, (*cnt + 1) * sizeof(**presets));
        if (!tmp)
                return -ENOMEM;
        *presets =3D tmp;
        cur =3D &(*presets)[*cnt];
        memset(cur, 0, sizeof(*cur));
        (*cnt)++;

        if (sscanf(expr, "%s =3D %s %n", var, val, &n) !=3D 2 || n !=3D
strlen(expr)) {
                fprintf(stderr, "Failed to parse expression '%s'\n", expr);
                return -EINVAL;
        }

        if (val[0] =3D=3D '-' || isdigit(val[0])) {
                /* must be a number */
                errno =3D 0;
                value =3D strtoll(val, &val_end, 0);
                if (errno =3D=3D ERANGE) {
                        errno =3D 0;
                        value =3D strtoull(val, &val_end, 0);
                }
                if (errno || *val_end !=3D '\0') {
                        fprintf(stderr, "Failed to parse value '%s'\n", val=
);
                        return -EINVAL;
                }
                cur->ivalue =3D value;
                cur->type =3D INTEGRAL;
        } else {
                /* if not a number, consider it enum value */
                cur->svalue =3D strdup(val);
                if (!cur->svalue)
                        return -ENOMEM;
                cur->type =3D ENUMERATOR;
        }

        cur->name =3D strdup(var);
        if (!cur->name)
                return -ENOMEM;

        return 0;
}


I added memset() and early cnt++ to make error handling more correct
(we could have leaked cur->svalue if strdup(var) fails). And I added
%n to initial sscanf() to validate we parsed the entire string.

Oh, I also added back '-' or is_digit() detection, as otherwise users
can be confused due to a small typo in their integer (they'd get
something about enum, very confusing).

So that's what I applied before pushing to bpf-next. Yell if I messed
something up.

>
> >
> > > +                     }
> > > +             }
> > > +             if (errno || r !=3D 1 || n !=3D val_len) {
> > > +                     fprintf(stderr, "Could not parse value %s\n", v=
al);
> > > +                     return -EINVAL;
> > > +             }
> > > +             cur->ivalue =3D value;
> > > +             cur->type =3D INTEGRAL;
> > > +     } else {
> > > +             /* If not a number, consider it enum value */
> > > +             cur->svalue =3D strdup(val);
> > > +             if (!cur->svalue)
> > > +                     return -ENOMEM;
> > > +
> > > +             cur->type =3D ENUMERATOR;
> > > +     }
> > > +
> > > +     cur->name =3D strdup(var);
> > > +     if (!cur->name)
> > > +             return -ENOMEM;
> > > +
> > > +     (*cnt)++;
> > > +     return 0;
> > > +}
> >
> > [...]
> >

