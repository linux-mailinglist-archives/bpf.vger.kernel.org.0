Return-Path: <bpf+bounces-56625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C0A9B41B
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385E21B66460
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6728DEE1;
	Thu, 24 Apr 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQtGz3Zi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF592820DA;
	Thu, 24 Apr 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512235; cv=none; b=jPnkaot1QZePafsz2taokstARPgzRq0yP8YynP7euqRUJG4NFR/qVrGLph+sYmgLtr8avhFioKssZ7BFao71ows6tS39FrdABEe5xW/ME0WTmVJGepA4RJ9eqaR9Ds3xUPgdU0f2SoYGdVGeeyGN48D0Hp3w3uHFQupv9hthPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512235; c=relaxed/simple;
	bh=gkgoI29nl3mSGCFDMPiXMHrPP8l/XhPBYatnb/F3jlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRUEdyBDe4Ha8cf2D7d5c9IatQrU5FEwaxnLLhmcI5wXi91XzFvYVzdiaAqQMCTrvOIQGSescpT/dV0Hi+4Cmz39LMaYcw2BRoljuU9mKIOrO1a94a4+agKTPXKOetbhhJyDZM+8MD7ytZ1eFyvmaQFmL3YBK5MI6oBCFHflDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQtGz3Zi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736b350a22cso1074562b3a.1;
        Thu, 24 Apr 2025 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745512233; x=1746117033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cssuPsgQyNe41/I1FihzTAF2D9xk/WnUmRiUzzfO9c=;
        b=CQtGz3ZiVTPqNcfBlFBwYrLZ/ZblkYJTQij9B/RGa7DRPXLeeNvQm7jXxpCWcXZjwd
         iiAGUVm9NZXOjQqTWGDnLAC4qyKQ0dVwBrnP6sORhuMSACJJOphZx44wd0jtueDgRvLl
         jlzp0BbutPbxxXp/EMBt3cjsBwSSR2+xj7WlNzp6DIEvM4IwklhrzrRPYSh0NCXit1PV
         Y0Nb8W8C6UTmXAj9U8FbJdiGBDk3GeFYUuykezvsCARENdrYnVfQ9zM8jvYDJ4NiECO7
         qUX3+psRtOHnsriD+rR4oDxao2XEDcI/2bHVWXBZ3kZ2QcNm/044czt8lk2ptNE8/HGg
         FT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745512233; x=1746117033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cssuPsgQyNe41/I1FihzTAF2D9xk/WnUmRiUzzfO9c=;
        b=uEN+9DafGDgjvHeKRTdqheSgiib23pryUtQhx0jh6GM4VxhaUzXiJsPdbmdfxcx2FA
         5QvbJG5i1wndXiybvK5MFWQnILrVaiSpkNzCfHUjgq9kD3R8nZNmDoUbog2GbQ+lA0/4
         06HMi4Ck7sgnPrhFC69R+egR3+F/PUYNGE5cTg1w3Y0LdcGJR8CIA44ZXr5zsYNOCgBf
         cSe2Tre8tC/ywdrqwlEDWOClsOFcSuGCLZepYHqBWxfF8jTVlH4WFDkeypqzO/Mfrh28
         axlcaOZMtq1hypE+xdQU+jBH2zjBlj6EWw7spOwzGv6+XmN0HfYvHUzEBJjglZ3UnH9j
         dsGA==
X-Forwarded-Encrypted: i=1; AJvYcCU+xfql2P2my5DK6pYvxo85MONfsIlwLzKQvM9j5Tfp8Yk+HnJzY4L1GkKj6e8w5hBzz/FMHvxltJQVzs1t3dWWiveX@vger.kernel.org, AJvYcCWQhTNUVJYssEo8uPYN1vZvom5TWdKqjj2pJ90ODxkG+oJPNM/OS1b/apteDWTKjq4pe8A=@vger.kernel.org, AJvYcCXJIodXqE3f8rqgb0TngWHwem5zCpt7ubf3OOZOcwpvfU7nFyFxXB+90x/K5hhc+3GKrLHH1qIfImYmE3CY@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJxck7BBJ9Q9a53jDLX8C+qWAQfLIsfFV7xVp+ECRfuTfFGtg
	728uhTvUpLZ34z+asB+ieX7KgPV1WSQA/r3Ozv90SI33b4T/m1oQqVoEKdtp6wLvUgbeWFVSphx
	oX0vSPOLa3+aa1cAzZm8XC99I97/w3D/R
X-Gm-Gg: ASbGnctwOLsiScdr79u5mjnw+/l4W0HHtj2uO6lt2qMLpu+3Pq89GNNOLZD+Q16awWx
	M7b5lexH/Z6Shc1nPvcBBaUpSEhLh4/WBSetyIXPph77Y5eM+JfT/GfvqlXNmHsULm+ZT3Ai68j
	28Gkp+RzisB6WrPKENEQWfGrEvMZO7MmuiM3M9sHrq6cTzSwc+
X-Google-Smtp-Source: AGHT+IGGekbwvhanq5AjI05sAoEBY5KX4C0V8/x4II22DmZPJubUV3X/sBf6Z53dNjKI/PYB8jlynI6ZpOUX010q0TI=
X-Received: by 2002:a05:6a00:4642:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-73e23ca12aamr4669351b3a.0.1745512233446; Thu, 24 Apr 2025
 09:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-16-jolsa@kernel.org>
 <CAEf4Bzb+LT2nTTjVXi3ATu9AsYSxZJr2XzegA09Cm8izNG=grg@mail.gmail.com> <aAozzY6ls7LLXNSc@krava>
In-Reply-To: <aAozzY6ls7LLXNSc@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Apr 2025 09:30:21 -0700
X-Gm-Features: ATxdqUG--vTtgMshkP8IXmG-Vh6Vpor73PMkwErJv3g312IkH3n-D6jCNe965e0
Message-ID: <CAEf4BzbLhc1PO=AfuavYhy+68Rj3u6d4OWpzZcExcOpdqMFMdA@mail.gmail.com>
Subject: Re: [PATCH perf/core 15/22] selftests/bpf: Add hit/attach/detach race
 optimized uprobe test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:51=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Apr 23, 2025 at 10:42:43AM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > +
> > > +static void test_uprobe_race(void)
> > > +{
> > > +       int err, i, nr_threads;
> > > +       pthread_t *threads;
> > > +
> > > +       nr_threads =3D libbpf_num_possible_cpus();
> > > +       if (!ASSERT_GE(nr_threads, 0, "libbpf_num_possible_cpus"))
> >
> > I hope there are strictly more than zero CPUs... ;)
> >
> > > +               return;
> > > +
> > > +       threads =3D malloc(sizeof(*threads) * nr_threads);
> > > +       if (!ASSERT_OK_PTR(threads, "malloc"))
> > > +               return;
> > > +
> > > +       for (i =3D 0; i < nr_threads; i++) {
> > > +               err =3D pthread_create(&threads[i], NULL, i % 2 ? wor=
ker_trigger : worker_attach,
> > > +                                    NULL);
> >
> > What happens when three is just one CPU?
> >
>
> right, we need at least 2 threads, how about the change below
>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index d55c3579cebe..c885f097eed4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -701,8 +701,9 @@ static void test_uprobe_race(void)
>         pthread_t *threads;
>
>         nr_threads =3D libbpf_num_possible_cpus();
> -       if (!ASSERT_GE(nr_threads, 0, "libbpf_num_possible_cpus"))
> +       if (!ASSERT_GT(nr_threads, 0, "libbpf_num_possible_cpus"))
>                 return;
> +       nr_threads =3D max(2, nr_threads);

yep, ack

>
>         threads =3D malloc(sizeof(*threads) * nr_threads);
>         if (!ASSERT_OK_PTR(threads, "malloc"))

