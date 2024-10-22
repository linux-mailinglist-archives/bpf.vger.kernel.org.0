Return-Path: <bpf+bounces-42846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981389AB9EB
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 01:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B96A1F23BBD
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE51CDFD6;
	Tue, 22 Oct 2024 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1hEZcPN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A3130AF6;
	Tue, 22 Oct 2024 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639110; cv=none; b=a51FIELc8XkcMQb+2R0riYW/zLR+KxkjB4b7d0l5p3mdHb/Yl/3eBUoKrLAp6gozmIRaVgozPMIupkkMuSc1HN7d6XLlLw1cRQ6K4cP8r7t9AS5fxAJHOh+0EpgHWSbL9bH72mBiW5nqK+yF9ZP3PGGZO7ARFH0EFKncpuoQtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639110; c=relaxed/simple;
	bh=iAcKPyuEyoAkuvh+EjwfcP4+vnkgpQ+2hEaApd6BQSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrwG4c1kcC2jCLEAuC41zuPFbLCp4V9Hc00qznNwPgNmfIecGYnDvR+MopDFgfSs7kAVFDVwgxR7OleSrj56yL9vdRXjFmjFuhMm3aatdl+nMc1wycCzL3S6rwFhiLttMdbZivwu5VdGIm8om/T6If4SasFU7UBAYd8kiTAElSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1hEZcPN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5130832aso4311330b3a.0;
        Tue, 22 Oct 2024 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729639108; x=1730243908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysViSwG1BhA6tHoLHBPKsSO3Yt9U7S8ZCuGDUMv5I5s=;
        b=E1hEZcPN7bh1H/OO4U+HDvqzJYteaPUUxC3RwtSDs1i7YholreO7TRIDJqgz/uHulJ
         wED1Efef38oRszdL+c3mlQg3hpQVSgTTU7dkfkUyrueO8JHdLc8wnIWcNE+JFbrIpOQm
         B27jBRzzhYM7kIogxXCenA12ahbEO1y8urhFmP0luC1BXjgx6BUuPljNX5iS30BcKVzh
         Jp8+la8AEy52jZM7zlNH4TrXbrG4Bi+MqUTGL9C+cXBm80AFG1JnCX5rmp7/NeTEQSOa
         K0e82+LYkYG62miXsEif3D15oyNCDKdWOU72LywGe0Ibp9o8vMMz+AUY4x/rNlDhsPfQ
         cw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729639108; x=1730243908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysViSwG1BhA6tHoLHBPKsSO3Yt9U7S8ZCuGDUMv5I5s=;
        b=v9UxA0AwSduXe+4ShBRLlhGuClyhDzRRG8pXssxn5TnjR2xU4+DMweHhNszQBa4THn
         0atxWC636DhpTXyHhgud68qubh/E//pJiq6M+pi6ebOPQMrm9DM4WpXic9NLWzwORJ3j
         7xB7OPvWxcX63sAlxfnwvEjvNmmP0gaRWLM3umNmo8bQDU5WISp0SFsohN4s9616wXA/
         NK1ih8j1i5j3ufYXVtCyWLZWch9o5Nu2Q7f4/TCEiYlvUl4hutvP9ScbyjCBE/fTOBOx
         Ve12xQNjwtN5e2/tU40ZOT09A8zWIl5JgiVod3PsylRbq5rD4aj+TFojjgNI1ZLp9de/
         nGug==
X-Forwarded-Encrypted: i=1; AJvYcCVDA+77jE/GuiaaO306fxtmzI3rRgH6bEe3iqKCXpE4sLoOMU8QLXk58AZDSvAbB3ytVPoS9KZ6DbGA+xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4rh+WSiS4ZuKBNAyRrh437p1s/xb+R9QeHi/6g7blc2wFu/i
	OB/B/VRX9RYUesT3n7b9ZAsNM4F/auIQTk+XYy4CNr3DFu/qDFnkoyep6N1P7Sy09jnDMvkDtas
	2jT9V4c7JsVtcelB5YAeJrUAblSM=
X-Google-Smtp-Source: AGHT+IHTGcZZxn3WDi1KmnRIfvMWHYAVEdFjzO8xlGcoBIU5v7KElLEPzrbMfbdit7ZKBc30F38wY+EvRiZ91pt0Bqo=
X-Received: by 2002:a05:6a00:4f90:b0:71d:f64d:ec60 with SMTP id
 d2e1a72fcca58-72030babcb0mr1243329b3a.7.1729639108262; Tue, 22 Oct 2024
 16:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022172329.3871958-1-ezulian@redhat.com> <20241022172329.3871958-4-ezulian@redhat.com>
In-Reply-To: <20241022172329.3871958-4-ezulian@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 16:18:15 -0700
Message-ID: <CAEf4BzbOMhw2yRTbN-n65TsDu+Zi8c-A6uVLN4SP7_Xpruttvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsubcmd: Silence compiler warning
To: Eder Zulian <ezulian@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, acme@redhat.com, vmalik@redhat.com, 
	williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:24=E2=80=AFAM Eder Zulian <ezulian@redhat.com> w=
rote:
>
> Initialize the pointer 'o' in options__order to NULL to prevent a
> compiler warning/error which is observed when compiling with the '-Og'
> option, but is not emitted by the compiler with the current default
> compilation options.
>
> For example, when compiling libsubcmd with
>
>  $ make "EXTRA_CFLAGS=3D-Og" -C tools/lib/subcmd/ clean all
>
> Clang version 17.0.6 and GCC 13.3.1 fail to compile parse-options.c due
> to following error:
>
>   parse-options.c: In function =E2=80=98options__order=E2=80=99:
>   parse-options.c:832:9: error: =E2=80=98o=E2=80=99 may be used uninitial=
ized [-Werror=3Dmaybe-uninitialized]
>     832 |         memcpy(&ordered[nr_opts], o, sizeof(*o));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   parse-options.c:810:30: note: =E2=80=98o=E2=80=99 was declared here
>     810 |         const struct option *o, *p =3D opts;
>         |                              ^
>   cc1: all warnings being treated as errors
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  tools/lib/subcmd/parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

First two patches look good, we can take them through bpf-next. What
do we do with this one? Arnaldo, would you like us to take it through
bpf-next as well (if yes, please give your ack), or you'd like to take
it through your tree?

> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-op=
tions.c
> index eb896d30545b..555d617c1f50 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -807,7 +807,7 @@ static int option__cmp(const void *va, const void *vb=
)
>  static struct option *options__order(const struct option *opts)
>  {
>         int nr_opts =3D 0, nr_group =3D 0, nr_parent =3D 0, len;
> -       const struct option *o, *p =3D opts;
> +       const struct option *o =3D NULL, *p =3D opts;
>         struct option *opt, *ordered =3D NULL, *group;
>
>         /* flatten the options that have parents */
> --
> 2.46.2
>

