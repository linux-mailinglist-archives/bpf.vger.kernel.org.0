Return-Path: <bpf+bounces-52542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A0EA4475E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597B719C492B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D1191461;
	Tue, 25 Feb 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNK+13wX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A281156236;
	Tue, 25 Feb 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503112; cv=none; b=kYFwWv08XPfLN4gY86sHBMvMpXv30TD8Nbs5AqbOky9fAk0ixnwBvxCmG1Gz3Kp35lcOkxtszMJHYj3RYh/ty9BdX/waEvrnlEWks0AdXMYWLcLuMj/Vc+ptt8OBeYQYucOlDDk4EsOihCOP5dBMBf4ZHvYlcY3oi8tLUYszWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503112; c=relaxed/simple;
	bh=fq4+RVVZIX5i5Gck6hREMqZyPIdiklA0DvYMnAD9QIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2qI24suz7W0BT8+g7igJl05ndIytbPSUH47T1t0018TBayIy3+0GY1Kjk3ZOcfptgUNFxAt3LR+wpuRsn32pwGt6j1buPXr2MDOWvkKcfm1SxThyol/sQYmYd2wvxyaMfj7ohNlGhR3hSmMZ0b4M/rT15X/LfBwh9UnpJTfzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNK+13wX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so11886057a91.1;
        Tue, 25 Feb 2025 09:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740503110; x=1741107910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1hW4LrkfwQANoXED9TNfHiDUbSzgSzM4yQIXlu9uQo=;
        b=fNK+13wXzKBI9NmmvMOdcRZG6d8S6ud9h2YmQ008mZhz0TF2sY04lUulGlQcHY3AyZ
         pwgLIi4pnS0lhvCYtNuiawKb4z7DAvxLWBxjbtktlxi/QlUGMaCJspMvTE27wWtb3Vmr
         KuPmxSGQl+ypD+P6FAekmPmMz7dqiKTF3A96WbQi2ayt3l3GGcjvK0h49naw8DNkfnhz
         tkyCTNkWhAuwLZrsw6zaH/ZOllepfYxVHmBMrg3EQsyNm3E5hdGLn60znt63xhzoVy5G
         qwq+u4Ul7GgrJZB0XeP6vC9VuXJDDdpRZjkHxxRc+ehr+nBbPgxrTSk+J6J8Vfae5HM2
         hdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503110; x=1741107910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1hW4LrkfwQANoXED9TNfHiDUbSzgSzM4yQIXlu9uQo=;
        b=hZWTUWtpz6HuPYT4wl3gJi/dBp58o7vZYh01dNvWk8lyeM1QfJ10aVstWNTHEyFC5f
         eoBeoe2jxv8Vr+MJvDbL722fsHXf5jEWvbvKWp63TT2tlAm1BXOh8/yGfELIX/egXdkc
         TISR8qBjAP8P0Kl4w8CjQ0mGacWsurquGb1SfUw+ykW1mdwfzLtMrD3Z4/M4ma8gr4mK
         9dNZQ8gBFE7JGtJwALL5QlEIpv1jrUWVq7//LtY+Nh5jx/97YCvtfDigrG1K1nCh6gTK
         9bo5VvIANxJODnrh6XVF30x0qmfsNn3xgQ5hWN1sEIFE5siaibAftjqrY5pIepzyKZVh
         XLQA==
X-Forwarded-Encrypted: i=1; AJvYcCUlJq82XEDJrKQOF5hz4FuezZavdooMZ7aTRkUOwkQS/+2OU81beu0jcxF7rVIGwtn8hJn04GRRMIrXp+Hr@vger.kernel.org, AJvYcCWabELrkjvJYQEL6u0NbXOBsr3xU4HbtGWI6ERaEJu7rP/tYrDzo617GTOD+xYLvIRoGP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTk75GJ4MyV83NgNsDSl6m38NJWcneEEdDXyW9D3GIcUikA4ME
	E+g1wP4Ksf1Ma+8w2nqXCACrtE4+Y2mLNdV04HLA374qA1C+swlZIt6tn8qoTghq9j+k+W1TW0p
	Kro4Ks8Zl9xyiqEzAMhYEge4GJ4M=
X-Gm-Gg: ASbGncsyhzUwMeygmbpUvn11tkt9Qv8A1IH9KVNqZB2xvlOL/8iaFbnIjcfxEzlv2e0
	gxvf8vjXvfNxY1vrit+3X4oZDYmPyN0LcxZbhL+3bXkX3ztziAvmJrUaV2RV6BZKctX8sJBbQxZ
	fQzC2BXfOhd+oabJ3JuRTwTlM=
X-Google-Smtp-Source: AGHT+IH6/ohgHqXo49oM5jaOaaX0/BJzaXBS0M10ZKu9saN+2Hq6NxdAPGJSAxeEYQHjeWXYy+3C083Sg/keoG8Ikbw=
X-Received: by 2002:a17:90b:2792:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-2fce7b74fbbmr29897322a91.17.1740503110572; Tue, 25 Feb 2025
 09:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224165912.599068-1-chen.dylane@linux.dev>
 <20250224165912.599068-5-chen.dylane@linux.dev> <CAEf4BzYz9_0Po-JLU+Z4kB7L5snuh2KFSTO0X9KK00GKSq91Sw@mail.gmail.com>
 <d25b468f-0a84-45c9-b48e-9fd3b9f65b54@linux.dev>
In-Reply-To: <d25b468f-0a84-45c9-b48e-9fd3b9f65b54@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 09:04:58 -0800
X-Gm-Features: AWEUYZnN-QvB3viKsTYXFHCD7C7YbB2Ob9O2Vp58KqrvCs5XR_Y3tmjaThUXwQQ
Message-ID: <CAEf4BzY85DmfwRruD4tnTj+UiRTk64k1N5vO69cdL1T7H+QTXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/5] libbpf: Init kprobe prog
 expected_attach_type for kfunc probe
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chen.dylane@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:44=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/2/25 09:15, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Mon, Feb 24, 2025 at 9:03=E2=80=AFAM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> Kprobe prog type kfuncs like bpf_session_is_return and
> >> bpf_session_cookie will check the expected_attach_type,
> >> so init the expected_attach_type here.
> >>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   tools/lib/bpf/libbpf_probes.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_prob=
es.c
> >> index 8efebc18a215..bb5b457ddc80 100644
> >> --- a/tools/lib/bpf/libbpf_probes.c
> >> +++ b/tools/lib/bpf/libbpf_probes.c
> >> @@ -126,6 +126,7 @@ static int probe_prog_load(enum bpf_prog_type prog=
_type,
> >>                  break;
> >>          case BPF_PROG_TYPE_KPROBE:
> >>                  opts.kern_version =3D get_kernel_version();
> >> +               opts.expected_attach_type =3D BPF_TRACE_KPROBE_SESSION=
;
> >
> > so KPROBE_SESSION is relative recent feature, if we unconditionally
> > specify this, we'll regress some feature probes for old kernels where
> > KPROBE_SESSION isn't supported, no?
> >
>
> Yeah, maybe we can detect the kernel version first, will fix it.

Hold on. I think the entire probing API is kind of unfortunately
inadequate. Just the fact that we randomly pick some specific
expected_attach_type to do helpers/kfunc compatibility detection is
telling. expected_attach_type can change a set of available helpers,
and yet it's not even an input parameter for either
libbpf_probe_bpf_helper() or kfunc variant you are trying to add.

Basically, I'm questioning the validity of even adding this API to
libbpf. It feels like this kind of detection is simple enough for
application to do on its own.

>
> +               if (opts.kern_version >=3D KERNEL_VERSION(6, 12, 0))
> +                       opts.expected_attach_type =3DBPF_TRACE_KPROBE_SES=
SION;

no, we shouldn't hard-code kernel version for feature detection (but
also see above, I'm not sure this API should be added in the first
place)

>
> > pw-bot: cr
> >
> >>                  break;
> >>          case BPF_PROG_TYPE_LIRC_MODE2:
> >>                  opts.expected_attach_type =3D BPF_LIRC_MODE2;
> >> --
> >> 2.43.0
> >>
>
>
> --
> Best Regards
> Tao Chen

