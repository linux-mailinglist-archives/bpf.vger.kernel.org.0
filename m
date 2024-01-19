Return-Path: <bpf+bounces-19862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF98322B1
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD5EB2381F
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF4C80D;
	Fri, 19 Jan 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzOeiSqb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9E3FEC
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625001; cv=none; b=puMyJYupOX6G0f/jCm7K0MkRoH2Vd2Jxk2xwmXq/0ePP4zn2q4XP1ixIfSsWFHf8lBiUoQDXVsLNQPnyyCjCQ8+340sT+6bXVRFDSvXwQWk0uyclo6wCIXQW/S7LEisvIloCAzR3Iaj3zRdbh2MRdTGQ7TjT5AfXKD6lHETxNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625001; c=relaxed/simple;
	bh=kZbJ1cDxqRGeyGDnohiRVDSKjXw6oPd+1FnS4WIsUrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgcfZnkdkKDqGNmx7RqvSc0fGmMnQsafbRkhvBsg89cpRp1OPVq1i0h8ILMpxTDSjJuSZFo8q+CScigVG65+6CUe+hc7++4MBhywNuzTOQ/SmcGKKPmsY97REmdp9s3uYlHnQ9mRx+AkQWZNHfpDNQ9slqhOuat/mzf8h9HdkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzOeiSqb; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd562d17dcso227488b6e.3
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705624999; x=1706229799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SISXMbMfQAQi4yi/eu/1H8wtL+grA4vcZA7f7EHTxN4=;
        b=lzOeiSqbOf3QnNhJj5LaM5Q51fnuMbAC/TdjJ5trvo605Chl00kDarp0q69HDxyU2m
         13cum1CUBP4aZ9vkXHgw09qwUfw+XBnAynzD9DoPCCfOrGMwyOP2MlOphO80ertQzBfr
         wBgcdLi+PRXLfGH65yM8J6Swv+9QtNJB2lbAD6/KcPq0OtmATkh1x3tSPBVQ0FOjS6J+
         aPnjUNAzfaXN9yDiBqaev/T4whXBuhhPexU77T+BW2uGWikV/I8viSbJUtgFcx6DQF1Z
         JoQuNgarWXVRyL9a4F7IFm35L60ml5M2DFQybj0nxfasCUGZPzgl4sUbYqBb09tczZi8
         AZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705624999; x=1706229799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SISXMbMfQAQi4yi/eu/1H8wtL+grA4vcZA7f7EHTxN4=;
        b=ZDe67pLR08VyGfiHDy2eBtDvSHSRZSfyJRbmOdSxutClkUClvbqOux/w3ERDiGkg3X
         +bScucPX/CoSmoJiPKf6F5H8Gljx3H1rEVljcvgH0HfW9LL0X4QuaZPh8k+DX4YQNDpA
         EjKEFqHhbQubKFWWYYmfr4p0CVkmzqRarlwDr3RT/IRdtDrCWvYeBX9n3bOlQqdr/SSa
         fe3BH+lD8ASrMOEn2JN37Z732zK1VJhmfv0yCVQBLnkwu0ezNqnuTa3Nz2Woa9AeGTfs
         JMaY6fK0PMT+VJV5aApfbjt0rRQjifovTllaRr7o+avJzoTdCIIIyZ8/NguDEuhVHT6u
         05Pw==
X-Gm-Message-State: AOJu0Yyyx29aq0y5WzNZFEzcBAajJzFdS2vMZt4tDoxBZfjnV/6kScZH
	PzuzIBUBjtMer3QlNx30Bne0/I0mNgYCv0lBEZYk3kAA/9vfBKrVOgYGYwJQi2q46S5XwKLfsV/
	wWUmIQJINBoEAGgBTSATrhyUbx3A=
X-Google-Smtp-Source: AGHT+IHw3KZhHj+lwV7DgDHE8z+FICOlzHc2bho6G4JCLFc6mqvkJDeffVgeYQYv2weqUq1W2tC0rYR+hWlYWynA9CQ=
X-Received: by 2002:a05:6808:114e:b0:3bd:8ceb:da6d with SMTP id
 u14-20020a056808114e00b003bd8cebda6dmr2453528oiu.34.1705624999491; Thu, 18
 Jan 2024 16:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223340.1733595-1-andrii@kernel.org> <20240117223340.1733595-2-andrii@kernel.org>
 <3cb503acbd2d65dc08172d620fe5dfff5f51be0d.camel@gmail.com>
In-Reply-To: <3cb503acbd2d65dc08172d620fe5dfff5f51be0d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jan 2024 16:43:07 -0800
Message-ID: <CAEf4BzZ27fqvetYMQC4Y27pD40D4Fvu0mEPMf+4QJePChNHR4g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/5] libbpf: feature-detect arg:ctx tag support in kernel
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-01-17 at 14:33 -0800, Andrii Nakryiko wrote:
> [...]
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index c5a42ac309fd..61db92189517 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -6757,6 +6757,69 @@ static int clone_func_btf_info(struct btf *btf, =
int orig_fn_id, struct bpf_progr
> >       return fn_id;
> >  }
> >
> > +static int probe_kern_arg_ctx_tag(void)
>
> [...]
>
> > +     btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), str=
s, sizeof(strs));
> > +     if (btf_fd < 0)
> > +             return 0;
>
> Question:
>   suppose this is an old kernel and decl tags are not supported,
>   should negative result be cached as 0 in such case?

yep, it should, and it will be eventually when
probe_kern_arg_ctx_tag() will be plugged back into kernel_supports()
framework. For now this small inefficiency seems fine, given it's
temporary.

>
> [...]
>
>

