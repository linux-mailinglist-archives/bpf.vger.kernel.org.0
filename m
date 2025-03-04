Return-Path: <bpf+bounces-53255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96063A4F1A5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 00:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCDA7A1B3C
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44A205E20;
	Tue,  4 Mar 2025 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9VQM9Sr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F81FAC40
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131579; cv=none; b=fbwmPTV1iYSf2Pb7FQ06fIlegNmp/z24BnGScGE+c+Bxd+6n6YSZuJ8KUvBkHBvxeCu3wYBZjouSerhv2LMQ9SO5QWxetUfQ/zgZOZMGNps1Ph5teFR28uF9DOUwstIp+TxXwP3Z/AO/MrOYQC6ewibeTbkQYLVEsVoRIg/bU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131579; c=relaxed/simple;
	bh=YTIe+yLaIbhEbX2hF0udPDNsBEU1eWufeN0LwT64mBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8iPPYlLlZo7TPgjPAtelIF3xqzF1zrqDLZaF5b1wYVYpfkR0vl+A5XLAHggCwa8OQuZ7F2dIvHMd4FHWAruaEl+1zlvvFb+6b0aJtdOoB1lsIofnfaj+kRo2UhrKqZ66UPCg2hthcl/jKEo7xs50Lxeovy8+s1yiww0z8sHMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9VQM9Sr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef7c9e9592so47736177b3.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 15:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741131576; x=1741736376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy0avTCu9sgHjP4Ysm3CuWVmbQ7vQVhHv9G8SJhBakk=;
        b=S9VQM9SrNg96wblMpRXzkAtgR7rLkvO/ZafVTGYyp/JdSyLyQ1GhotV1hpV3N0VIz5
         oO1vDjPXviafq+D9WZWmAzZO5JI3uD+wBX7hkmq8/lublsYv90T2AUe40eQ3l3/dHL/C
         Hsxj6YN6AVmtCPPFJGhOzgNQKxKna1H7i75bev6H7Dud9H1ORM6z6n9i9jlRNCd8jThK
         7sphJkXqYnj6mUa5ujNT+rLE4GsNLk26nvCrkoH8gKIUhehdE0Vd7f/o/monoMwQhnTG
         h+tR0YsTKASIMYNbXfKH8HScqKrTi1R1d6ZipRyFe20cFq6NOBx3ULPQl97PfMCqDgGy
         WyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741131576; x=1741736376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy0avTCu9sgHjP4Ysm3CuWVmbQ7vQVhHv9G8SJhBakk=;
        b=aDD0NhPa9xY3yk3QxzdYjbPnEChfjM6Pc2II9oTPlyoW8KkWHmRUS82zRUCdb42Ucp
         njmC+UB3/pa21F7i/jaCMOxXQWGELRtRrVDosVhqi9fYssXxx5zLKLMT7/es8vNZcRnw
         +r3Rba497/tKySwEhUd5qrPoQjDjLt6xu1OpuG6SfXT7Ayj1B+yTi98MgwP320hlk00v
         ApGxf2axFiv3P0c/XFS/f4FMUvjZDoNothYoMiOll3r71nEOZThp+aqLvH31j5lTzTmw
         ye8u2BFw73kR1tQqm3UvHW9knCWRYvAzF93jwuHkesc2bH5rOqLYkDdT4mYSZP8AUfDL
         be4w==
X-Gm-Message-State: AOJu0Yzy7C4SlC6loIBQDkp3jxLa0CExV4EDggHbS0s6yDkS10uDzFBB
	+Nh+nOxPKHZHALiSVd+3kwLjDYnnCsfJTQh3yVdjj58mbwDDD1NNDbEr3d1bfAGxqxOfhfbGRpW
	xg1Z5CZV0398RV0R5ThzIt53+Wqg=
X-Gm-Gg: ASbGncuLIankgi9a/Ffx9uvwb/vBag/peS2XXVWXFDkK4+0hSQyks/9kqW9skBRMNwX
	YxM0qAe6hdCYInEiFkOSHD18UtoBmPd+yEYwRP/wDFJ1SVxrpb7/7jFo0DvSSodjl8/o6NApc+b
	fLuFUbKtlrfLtgMVbtwQmscOHyFw==
X-Google-Smtp-Source: AGHT+IFzloLMamkMN92SDyy8DVjCIP6W6xyhDCJwwq0kAudm0IYG7zCiWQXBmeC2Ts0PsOoOXrRaLDO34ZgTuwY/CqY=
X-Received: by 2002:a05:690c:4c04:b0:6f9:97af:b594 with SMTP id
 00721157ae682-6fda300fec4mr16264077b3.10.1741131576436; Tue, 04 Mar 2025
 15:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304163626.1362031-1-ameryhung@gmail.com> <891505bc040c9dd82814889b2da52e299132cc89.camel@gmail.com>
In-Reply-To: <891505bc040c9dd82814889b2da52e299132cc89.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Mar 2025 15:39:25 -0800
X-Gm-Features: AQ5f1JqI-3JfWcH5rztI60Z9GL2f_80wSTODTA6pudYDfy23jVwVoji6BjKidjE
Message-ID: <CAMB2axNvqyr-vnv5WcMMqykq6sCdnNYCOP4z1wsvO1GtrwGQyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Clean up call sites of stdio_restore()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-03-04 at 08:36 -0800, Amery Hung wrote:
> > There is no need to call a bunch of stdio_restore() in test_progs if th=
e
> > scope of stdio redirection is reduced to what it needs to be: only
> > hijacking tests/subtests' stdio.
> >
> > Also remove an unnecessary check of env.stdout_saved in the crash handl=
er.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> If anyone else would look at this commit, here is an alternative
> description:
> - functions reset_affinity() and restore_netns() are only called from
>   run_one_test();
> - beside other places stdio_restore() is called from reset_affinity(),
>   restore_netns() and run_one_test() itself;
> - this commit moves stdio_restore() call in run_one_test() so that
>   it executes before reset_affinity() and restore_netns().
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

I can improve the commit message in the next respin.

Thanks,
Amery

> [...]
>
> > @@ -1943,6 +1938,9 @@ int main(int argc, char **argv)
> >
> >       sigaction(SIGSEGV, &sigact, NULL);
> >
> > +     env.stdout_saved =3D stdout;
> > +     env.stderr_saved =3D stderr;
> > +
>
> Nit: why moving these?

If we assign env.stdout_saved at the very beginning, crash_handler()
can just call stdio_restore() without checking if env.stdout_saved is
set or not.

>
> >       env.secs_till_notify =3D 10;
> >       env.secs_till_kill =3D 120;
> >       err =3D argp_parse(&argp, argc, argv, 0, NULL, &env);
> > @@ -1969,9 +1967,6 @@ int main(int argc, char **argv)
> >               return -1;
> >       }
> >
> > -     env.stdout_saved =3D stdout;
> > -     env.stderr_saved =3D stderr;
> > -
> >       env.has_testmod =3D true;
> >       if (!env.list_test_names) {
> >               /* ensure previous instance of the module is unloaded */
>
>

