Return-Path: <bpf+bounces-31935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8889055CA
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FBE1C22937
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2317F374;
	Wed, 12 Jun 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPGeWD3s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3A17DE21;
	Wed, 12 Jun 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203995; cv=none; b=VScqdtZTT2NgwHaNByKaP4i9ICHZ0S9uspzzKjh+lFH7kHoa6vnwliU1/1zuJDWhOEwhWpjs8BBnaMEhJ+jZpI3H/jd2yUVqMyH7XPGnNa39OWBmhKiI6t44qXTnChP/UYq2dgnLQPqH7VXOVrcPImGjnU/InNKaim7VI0qCdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203995; c=relaxed/simple;
	bh=CV7A6h7Ej/JI3EvTIGvVnDsWenKFFHJmc2Q7IgFEoqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfiFfk6p5eGzmcUg1Q+ezKvDAdGNIrx8mXKadcor67BwhXYxHHL8kYV/2FJPok7iDZLGz0A7UGCrAzD/a94hsnpzk3sMDOlgEo31WpzjNXXImWSrIUOXX6+d20lXv218Li8F8NMeWfOprq5ks8M/8M+VC2FMRMmQWzMLylYhmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPGeWD3s; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-356c4e926a3so2554714f8f.1;
        Wed, 12 Jun 2024 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718203992; x=1718808792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjlN83lPIOr4ltIrDkbCr9NcIIfgwrCEwftXlf1Dyvg=;
        b=HPGeWD3srlC3q5EGEza2ITcOJR2EFJiYeXGRDCQy3GYrKAy2UzJmFD430sJgYDHHx4
         Quj4aNfvMZNq6c/crItGBYyzWKwIrguKNR1U/8AJExdGmqULCOWAdDEuoEvih1kGHj9F
         0CntlLe3e26NPP6QklOZXPBTsej8pn4SN3B8Mh8G5qFLSNCT+mzdIrf9yIzbHj87FWsC
         c8ZPK2VkDg5MzPCg47dcU4W9MGBhuLYP4QeKgXMLgw68bVAmN+E8KQLXKfSa7YHTxzOK
         yGfJHH10on+HnvOKQ0gjq4hAmAnMmSAA8snzesghzsc+AosTgA0HHn9rVlmKfhCwIxv0
         PPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203992; x=1718808792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjlN83lPIOr4ltIrDkbCr9NcIIfgwrCEwftXlf1Dyvg=;
        b=sIiZ/XFgso09qXBxkfAHBY8S/JiXmRhk9GOHoAzoC2D44Grlz2oc+yaYnxxrd7yhbi
         vwTOzhfXF+oGN2XQgNsxoUMHdKWWnSon/M4Ff5arjxJqxM7pEriD5L21gFE1jhju8gCR
         fCELDmDecbl3zdgPbeNGLhjEWeU7nCDEX9VxYqC1i/fPJRRF9WFo3QUahRGENBr2k7DR
         9Mr7mfJvXINnf43A3IUmltSutYwPbxh+FjLabtFDGVt0hqHS9ILaL+PLsbWK3G9ugS+7
         2sCJcklR8SZUkcVQXPphuwJMzwpi4y2MKc4k278io7fmxDfnLW5dXITUjZLTntBgIH0O
         yoTA==
X-Forwarded-Encrypted: i=1; AJvYcCVMvrlunpAFFC1uVqrohtYjRYYw4uJRzuniJ94+b8jfGHSz5BYpZg7hzWJ6m2WG8gI9NqOHMoR4vqLE+YvYiT/co4bWCDudBe3EKZP7brr58nXh0lpahZ8Sl2z+AotjEwbJ
X-Gm-Message-State: AOJu0YyUxvAyLZyHtZ6BGIGTsNELIdkGJ1iAQFVDkKxGVYBTG6wm3lwQ
	1vV4NGmnPkWlaQijoAy1QXMis7KKT9RQgoQCrtFPSO1LdG0M9K8NGLSisMPWZTaOXKviJjvVArx
	TgYgAHNoPow1Ou76VGAYMsUaO8q8=
X-Google-Smtp-Source: AGHT+IEd4n+XPIwBn+v+LL+Ojvsu3xO9fas8ggtkreZ08f3keaLg6Vzs5Zl9RbMU/yMnOZm0nXtQbZqww/eUVIyV3x4=
X-Received: by 2002:adf:e5d2:0:b0:35f:1d67:cdb4 with SMTP id
 ffacd0b85a97d-35fdf7adde2mr1394282f8f.37.1718203991639; Wed, 12 Jun 2024
 07:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-master-v1-1-a95f24339dab@gmail.com>
In-Reply-To: <20240612-master-v1-1-a95f24339dab@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jun 2024 07:53:00 -0700
Message-ID: <CAADnVQJLgo4zF5SVf-P5U_nOaiFW--mCe-zY6_Dec98z_QE24A@mail.gmail.com>
Subject: Re: [PATCH RESEND] bpf: fix order of args in call to bpf_map_kvcalloc
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:51=E2=80=AFAM Mohammad Shehar Yaar Tausif
<sheharyaar48@gmail.com> wrote:
>
> The original function call passed size of smap->bucket before the number =
of
> buckets which raises the error 'calloc-transposed-args' on compilation.
>
> Fixes: 62827d612ae5 ("bpf: Remove __bpf_local_storage_map_alloc")
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
> - already merged in linux-next
> - [1] suggested sending as a fix for 6.10 cycle

No. It's not a fix.

pw-bot: cr

>
> [1] https://lore.kernel.org/all/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@inte=
l.com/
> ---
>  kernel/bpf/bpf_local_storage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 976cb258a0ed..c938dea5ddbf 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>         nbuckets =3D max_t(u32, 2, nbuckets);
>         smap->bucket_log =3D ilog2(nbuckets);
>
> -       smap->buckets =3D bpf_map_kvcalloc(&smap->map, sizeof(*smap->buck=
ets),
> -                                        nbuckets, GFP_USER | __GFP_NOWAR=
N);
> +       smap->buckets =3D bpf_map_kvcalloc(&smap->map, nbuckets,
> +                                        sizeof(*smap->buckets), GFP_USER=
 | __GFP_NOWARN);
>         if (!smap->buckets) {
>                 err =3D -ENOMEM;
>                 goto free_smap;
>
> ---
> base-commit: 2ef5971ff345d3c000873725db555085e0131961
> change-id: 20240612-master-fe9e63ab5c95
>
> Best regards,
> --
> Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
>

