Return-Path: <bpf+bounces-48305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C5A066AC
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A752F188A776
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6FD20371F;
	Wed,  8 Jan 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUaGi2c/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5451ACEDC;
	Wed,  8 Jan 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369795; cv=none; b=IDgoB5rk0TI2Ey/JW2oWmgGVjAODCIl0N6p8tGFQb0U/DNPJEvhxGWMx33d9KvWLZFTRoaT6Vk5i9bAchWvxCFrUvO/l8ncN6UyPWWCD0ADgMy0CSXHYnIDawd9OpSl/eRrokOSa6CxRxxBdvrycLAWZTfH2CxRNj6Gao3JKLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369795; c=relaxed/simple;
	bh=P8IkcavraQ8tivVpHVJNx67O4hjnQ0inmfw84h3P5Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pME0SwE+BG8F/VvRGUyfG3wKeBW1XGaZXnrvmDHUPCV3UzSh2BJnzAuTVTVOXnTHgWGw9nTsK7H2gqPW2xW5EXJqsvfjETW5w6WaUm67i8uq3Oim1AI2LEh1CZ+7BO/U0zTq+hvkq4RrT9ALbzYLibyjawW8L4nt+FX4JPTEI04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUaGi2c/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C456DC4CEE5;
	Wed,  8 Jan 2025 20:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736369794;
	bh=P8IkcavraQ8tivVpHVJNx67O4hjnQ0inmfw84h3P5Ow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KUaGi2c/4T2zC0ddROt/Bys6xO04zQ2uQUW7bzCaXMsqeLrB8Rb6GKsgEFUvlA12r
	 pP4/Sl0BQ+v437KD6uWeecSvx8eV9PlaI17URYBLQyi7T4GtY3Smgys7qzvSGqYjRX
	 CP47K3ySXY2ZIlZ+TpgpDj5VxZJlGFp8SVfsadElp7q1BuDvTNhd/xno863Os2W/hf
	 wqeH4KvaGWqM0Tn9aLsnfMrcfY+G1wZ6ZHoiqfmd6eyggPjUgw5r+aiPCY479ShjPy
	 RC0jtXMi+BqUt2FgxqPjZynGyJ1/Yw/qTTgQoobG5oHlXGTlLNm9TFvwj7fSLpQnMA
	 XC1tnQQ7H5cMA==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ad272538e8so4655055ab.1;
        Wed, 08 Jan 2025 12:56:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbwybt6sMHPhQaAurVCSHd/+fnAtGSKDgP+o8CBOxAj4Yi0lAkgnIG0ZysrXtpZGwdnLa9j7v1zKjow3y7sbiFxw==@vger.kernel.org, AJvYcCXEM/Tv9Eef0R2DY8Aw+XKV+vgqzMDOQR9PCfQQGF/j76g6YswNgUdNAX5kYd120dfvc80=@vger.kernel.org
X-Gm-Message-State: AOJu0YytL1mUZPOlKPrYW+FAgro24JZAcNC7dTSQAWPcyP4MRjZd5YUW
	QwYU4NFNuqOpgmvMMGUwki8aRpbetjWXJsfBQP7U4mIb9YGINZnr5RnoSLCIP8lf5fU0eibHPVa
	wayyA1IqkKZcP8XYAvFa1y8XrU0U=
X-Google-Smtp-Source: AGHT+IH6BGyBMWkyUBSDz6QWt+ULF0P2eHviKybGN+es/ZDIMnlSuSsq8+pLyvRuKQ4C3b4/b3UueWHMea+Ni+KXjks=
X-Received: by 2002:a05:6e02:318b:b0:3ce:38f4:1cc4 with SMTP id
 e9e14a558f8ab-3ce4760424dmr7205845ab.12.1736369793997; Wed, 08 Jan 2025
 12:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106175048.1443905-1-jolsa@kernel.org> <CAPhsuW5p9C+0oLbec=bxZPvoEuPpAbDzbyPRD95ucBP=7HbO8A@mail.gmail.com>
 <Z35jyGWboftcEPRF@krava>
In-Reply-To: <Z35jyGWboftcEPRF@krava>
From: Song Liu <song@kernel.org>
Date: Wed, 8 Jan 2025 12:56:23 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7kH_6UpLrVYXMx08pTz3j21_RsHxm1oWgAHfP7M9qwmA@mail.gmail.com>
X-Gm-Features: AbW1kvZtHz-EudEHjGS48wQNt-EMWwP5uwqtaTzD2N-t6sn_9P7-D6sxNhWsZJo
Message-ID: <CAPhsuW7kH_6UpLrVYXMx08pTz3j21_RsHxm1oWgAHfP7M9qwmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Return error for missed kprobe multi
 bpf program execution
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 3:38=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
[...]
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 48db147c6c7d..1f3d4b72a3f2 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2797,7 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_mu=
lti_link *link,
> > >
> > >         if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1)) =
{
> > >                 bpf_prog_inc_misses_counter(link->link.prog);
> > > -               err =3D 0;
> > > +               err =3D 1;
> >
> > nit: Shall we return -EBUSY or some other error code?
>
> it's processed in __fprobe_handler and it's treated as bool, so technical=
ly
> it does not matter.. but I'd rather keep the 0/1 return values in here,
> because it's what the session program is forced to return

Got it. Thanks for the explanation.

Song

