Return-Path: <bpf+bounces-52923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD5A4A61F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20E3189B68B
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F401DED48;
	Fri, 28 Feb 2025 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDjPMOhv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0D23F39A
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782656; cv=none; b=AO3F+UHGtCzzy31oBKNm2ZpYJPTV51wDgbVInDovMgAoLu6s2VCIuKUkYAh3ZbO+2aFdBr2213UMf82N8Sgere6d29nBByjX+FfW6dK7KgL8VmsPB2Pm025ogI+Hxemstf2Xg6qGdFjLGKRXLJIYOewbyFAL0eccC3NY+SuijqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782656; c=relaxed/simple;
	bh=dC0RQvDvF8AmRk+vJUoRC3gwgpIKQS36f5/l81uG74M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moTmCR2720nxmwAc2bT9x9kCLVoukKujs+scPfeOlYLjT9vRdYXVOLEAlEKe1kcYY/X30IyrFdp0bDMse5GDpe8fZQ2wqT9iykH2dI+w+d1jrKnOrDAyG1gbce2js03UQOqQtHd2ZG79vjPhAbSnXosQX/YkQ8gEdCg5GN/i6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDjPMOhv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2234e5347e2so55525045ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 14:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740782653; x=1741387453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZyhV5Wj1FoBi+tQFjUvzdP+muY0F+MsUItLKwXEYGY=;
        b=iDjPMOhvljoWRbtWvjPZrtn/2kYjkJaHjNfSLBgA1Osf8I/QxAqfTh7x24OgS+Bptz
         61g/AS8axrMpbVYZaG5EJRLxJA5x6ymXvh9HZyajmuxO8hZ2v/DUx9hDvKXd8GWu0dBF
         HctDvxz3kwwrcL/ARPfwTmXnZC0RNos+TfyU3n8v5fS42P2Q25PtC41fFM1+92aoyiIH
         ZY9eDjAXrxJF9jiCn5EoxpVFAReF+3btpfjsh/4OPi9sh/FxRs9XEz4vVUuyJ5YUDWZ6
         AChaytmKQ8y4aA4lTN735IUomt/tKiVtS3RwNHhMCzXCdSmw9+xVbAPn6FuwxmbZOEHR
         6qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782653; x=1741387453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZyhV5Wj1FoBi+tQFjUvzdP+muY0F+MsUItLKwXEYGY=;
        b=G/xezd6VbzhPPz0we2uLnX4PKK+K+2p7CNzRRASLwxBIIwe/tMEyOY4zTscPUghSh5
         MRjU29G7DpN+xuYp5wM4yLvnmYw+VQ8EYI4rP1ehgmo85QQt4w+FblB2J24221swek3q
         dUvV45A9zaCiHwUNiO1NWnUp+yvhKL+I5EF/mCmAU1HFBBreZt840XSlW5OM/1fTGrXF
         U0/msq0Flqi2Z2Qmo6IQlphNV2BaDzLIOf2wp/VKvny9dGFOX+QMP/jDwD7CIpymwtpc
         Y/DKZeHMEXzdizBBcpB5DfZU0PS8Irt8YghqVuzWgCQoBPPQqhgg4xAHN9rzGBYkPnIU
         LYXQ==
X-Gm-Message-State: AOJu0YwY92E27YiukYEYI7Yskw9w9Xleu+yduOrbUhkIIl1pqydJVUx8
	xSyu7DANSmB7KQvjg32jjnKHJnknOk4Zvhr0BLZV3PXD5NALsvGLw5Qz1reO1Nus7yCVAvQ4WTs
	KpuKThBib0vPaMF2Crn8kARDVpCY=
X-Gm-Gg: ASbGncuSUgJ2irnywRsRNWB44mnUayZUS1OcyFm89CTzR2WfPqmMY6KQVU7MnhOUcD8
	Jfbv/mWB3ZdE6tQ3bzvpN3NHxymVtP97BaJDkoWuTZjj4DRDpjKh+vXkxCeT+dLi9xlyesFvwPi
	HI1ph00+cdeYvTeZyn5/KCIghK4nJdG+hwtppDqKa10A==
X-Google-Smtp-Source: AGHT+IHX2+p9EXMucfjTW3oOcNttWixW9WOAPpDqBP3AHfCU/m0HMAH05P+XatLNWXZAYymzdvhQHNfRlOce/tgwCgY=
X-Received: by 2002:a17:90b:37cb:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-2febab61ec9mr8620145a91.11.1740782653238; Fri, 28 Feb 2025
 14:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228191220.1488438-1-eddyz87@gmail.com> <20250228191220.1488438-3-eddyz87@gmail.com>
In-Reply-To: <20250228191220.1488438-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 14:44:00 -0800
X-Gm-Features: AQ5f1JrW3cSXC9KU5LifEdT4wh_SpWiutVQT5q5L01fSN-r2yyDccwXQbVr-FAI
Message-ID: <CAEf4BzZJGYxQxjjc4p=kmN0aUVNCHeP5xgPtHEBteswjt=K_sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] veristat: strerror expects positive
 number (errno)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 11:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Before:
>
>   ./veristat -G @foobar iters.bpf.o
>   Failed to open presets in 'foobar': Unknown error -2
>   ...
>
> After:
>
>   ./veristat -G @foobar iters.bpf.o
>   Failed to open presets in 'foobar': No such file or directory
>   ...
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 8bc462299290..7d13b9234d2c 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -660,7 +660,7 @@ static int append_filter_file(const char *path)
>         f =3D fopen(path, "r");
>         if (!f) {
>                 err =3D -errno;
> -               fprintf(stderr, "Failed to open filters in '%s': %s\n", p=
ath, strerror(err));
> +               fprintf(stderr, "Failed to open filters in '%s': %s\n", p=
ath, strerror(errno));

errno is fragile, -err would be more robust, IMO

>                 return err;
>         }
>
> @@ -1422,7 +1422,7 @@ static int append_var_preset_file(const char *filen=
ame)
>         f =3D fopen(filename, "rt");
>         if (!f) {
>                 err =3D -errno;
> -               fprintf(stderr, "Failed to open presets in '%s': %s\n", f=
ilename, strerror(err));
> +               fprintf(stderr, "Failed to open presets in '%s': %s\n", f=
ilename, strerror(errno));
>                 return -EINVAL;
>         }
>
> --
> 2.48.1
>

