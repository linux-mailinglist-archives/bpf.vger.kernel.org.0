Return-Path: <bpf+bounces-62006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC2AF0502
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7211F17076E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA952F19A0;
	Tue,  1 Jul 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMKF/I0q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D181E1308;
	Tue,  1 Jul 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402294; cv=none; b=l02KSLbotLteCm67doCWTeLtNPZmAIgMEK1mXCUUzfbrMU4ElEZx08KpCC4DCsd9Qv+CQQ/ThWR9p1QUB+REUsEp3SCfVRjQ7EJwxGqJnGhPgW+9P1C/wyXoyoTp7izEgLl8pP8lgKuptlQH/DGshtaBf0RwG3Xu08g+HAI3meI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402294; c=relaxed/simple;
	bh=JV/Dv/M3FjyYs2f0qOZrD51SPDgYKMozWjcGHTUMldI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKVDRk0KvmvhtjDqvflbmpUp7/lsByVeAjb/k3E92aZKm8QrfULFBT54qWacACKssbQLKJN0jSMZ6lkTBW8iQ1HuMSSCOAdyfl0fNXvRlNx5aChVOkTdLFuCugEwI67krag2xSOrcjtz1LCkXHdE1ew//8i38XJheH+k2t1kRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMKF/I0q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so5642388b3a.1;
        Tue, 01 Jul 2025 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751402293; x=1752007093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI/FP5BRDRRHesZv1GSJWpfq1mk0uDVdJdgRpG3jdBA=;
        b=FMKF/I0qaqXT5o8JbSEUegfwWPBy0v7wYQNzwdg4STz7pPWTVDvBq6BxwgvNZzUzdW
         k8PlicDdgbWwMIhns2a/icbS/cInAmu//Zf2SAeGSNzpn/EqjLAh7vAqeaOt/YFH6IHW
         X1sP9cj2fNuivZ709lq1OLhqvQxPpf5WeEmE8/9FS81uPOowG1GtXS95tWMTGwhQzdQa
         il0e6ITYSGuaUJy+OWBwVQSj4io6wTYvpS6Fv4B47dT4JkO8/uULQNUznIXSB9Lqu50B
         7/uervSyhFm5KZe7I+kJpJpLZBI/yuI3S75Ng8XjoTi2jpoiBj493CTjsBv9Vepmb4jw
         +p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751402293; x=1752007093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI/FP5BRDRRHesZv1GSJWpfq1mk0uDVdJdgRpG3jdBA=;
        b=frrGq2OYO+Ja4fn9aJUIzWgozz1yzHgs4wXjOGJxVTwAwlgVvRACA+m+0xEK0DKklg
         6FSNXD2yiaC46lMBuDmuPZ7XK/K+R0GEBZ53oqaAcfrcwo644vAg9Hlb2zpKTVUrZNdz
         v9qIJShtUEtbXqXAYE7D43xVvHxcFdR2/a3W6GhEwi8jUud0Fj+TE+N4H0yK35x0LkjH
         jLz4ct30A+7r+fGmpnv2fkpB8Y+Ie4pnl0/8QC9W6w0lRI0yyfDy1WFtLGjvJyMG//rd
         XlpXZWvlADJiH9g2g6PJ8kmPM8SrY5TpAOgJfpOZtJUXFXl/4y8s95cchIHLU2D5JZtO
         3hFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrq6QkLcmYAsbIgtQxMP20beu2BAn2B7Wz/cfvhe8K9OBxX7+jCWB3XJCL9ocqRIZlY1mE/4At36hsQmij@vger.kernel.org, AJvYcCW1JQeCatDdQ5V6gISld+54K/fsGJw00/Hm3KyDVQJwFU7nfNQZ0KXvRvGW5h0iLecyhVA=@vger.kernel.org, AJvYcCW67eW88eNzicumtsGr6yWQZm/y04OHHIakxQk1EpvDYsQ4RCs6M6v30Fc6lHEkTtMXyDAmFwUvgjoX68Bj12HmKMXs@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBPxHKUdjz49witTuUfpyuzsoX5NOD+F9bgs+9xCRKNU71923
	wWyiXSy4Irn08I0kRFolpOgqhXAcOA7/DzxycbOfNNN6cC7UwrdNIR4s8a/+6irxTjBchMxkxUW
	WswB7VeaRt5MFyoxSBzhTGQR34EJcDZw=
X-Gm-Gg: ASbGncvWG9VRldpuxEPNxn4bIDTPe/brDpefb/vUzfEemaSkmWkyXSoQl4W1O1IIUtw
	SpjkMsNh2Vb3M4icOfiui2ktsF+C4S6emD37Fo1FQHuPFCej8wQezcoCWLRHJd9pZYkzio7ufUd
	MgZUjR+VmiC6eO63D0yK9wGi+b7SxKs1fcrIj/v3jeSnFrRvICov5GDLLuitY=
X-Google-Smtp-Source: AGHT+IHzVKDcsxHmS4QQ2DyQP5TkotM8rpULR4MR6WM5Bl0k9NHt9OKIMEk82tX7o1Jjm2++PjPkKjwtXHczS2ZK+mk=
X-Received: by 2002:a05:6a00:8702:b0:74a:cd4d:c0a6 with SMTP id
 d2e1a72fcca58-74b51f9da78mr48537b3a.5.1751402292586; Tue, 01 Jul 2025
 13:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627082252.431209-1-chen.dylane@linux.dev> <20250627082252.431209-3-chen.dylane@linux.dev>
In-Reply-To: <20250627082252.431209-3-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 13:37:58 -0700
X-Gm-Features: Ac12FXxRNft9dm42uB6QJHYIc7JiEbkxpBizbmm0SHGZGP06qzPi6SNd1l7zHIg
Message-ID: <CAEf4BzZYS52gztmLgQtsehNDVwv7NBETh97zMk73ZqLL9uJ50Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] bpf: Add show_fdinfo for kprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 1:23=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Show kprobe_multi link info with fdinfo, the info as follows:
>
> link_type:      kprobe_multi
> link_id:        1
> prog_tag:       33be53a4fd673e1d
> prog_id:        21
> kprobe_cnt:     8
> missed: 0
> cookie           func
> 1                bpf_fentry_test1+0x0/0x20
> 7                bpf_fentry_test2+0x0/0x20
> 2                bpf_fentry_test3+0x0/0x20
> 3                bpf_fentry_test4+0x0/0x20
> 4                bpf_fentry_test5+0x0/0x20
> 5                bpf_fentry_test6+0x0/0x20
> 6                bpf_fentry_test7+0x0/0x20
> 8                bpf_fentry_test8+0x0/0x10

two nits:

1) order of cookie. For uprobes you have cookie at the end, here in
the front. Given variable-sized func name, I'd move cookie to the
front for uprobes for consistency.

2) field sizing for cookie (16) is a) not sufficient for maximum
possible u64 (20 digits) and b) very wasteful in common case of small
numbers. So use tab instead of fixed-sized column? And why 16
character sizing for the func column? Just to have more spaces
emitted?


Other than that the series looks good to me.

pw-bot: cr


>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1c75f9c6c66..e8f070504c4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2622,10 +2622,37 @@ static int bpf_kprobe_multi_link_fill_link_info(c=
onst struct bpf_link *link,
>         return err;
>  }
>
> +#ifdef CONFIG_PROC_FS
> +static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
> +                                        struct seq_file *seq)
> +{
> +       struct bpf_kprobe_multi_link *kmulti_link;
> +
> +       kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
> +
> +       seq_printf(seq,
> +                  "kprobe_cnt:\t%u\n"
> +                  "missed:\t%lu\n",
> +                  kmulti_link->cnt,
> +                  kmulti_link->fp.nmissed);
> +
> +       seq_printf(seq, "%-16s %-16s\n", "cookie", "func");
> +       for (int i =3D 0; i < kmulti_link->cnt; i++) {
> +               seq_printf(seq,
> +                          "%-16llu %-16pS\n",
> +                          kmulti_link->cookies[i],
> +                          (void *)kmulti_link->addrs[i]);
> +       }
> +}
> +#endif
> +
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops =3D {
>         .release =3D bpf_kprobe_multi_link_release,
>         .dealloc_deferred =3D bpf_kprobe_multi_link_dealloc,
>         .fill_link_info =3D bpf_kprobe_multi_link_fill_link_info,
> +#ifdef CONFIG_PROC_FS
> +       .show_fdinfo =3D bpf_kprobe_multi_show_fdinfo,
> +#endif
>  };
>
>  static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, con=
st void *priv)
> --
> 2.48.1
>

