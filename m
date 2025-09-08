Return-Path: <bpf+bounces-67804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BBB49CD6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96FF4E6694
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7052EB857;
	Mon,  8 Sep 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT2lvzp7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3D1A9FAC;
	Mon,  8 Sep 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370759; cv=none; b=gvciQciQfEcvjIVCGOBqA7IWGG/xR83VEiq4lXUWBC342TUUdiP8PzMKBKa8benUMzMZt0wgO7g2YkvE939FDaFE/c1lRkDxN2Tbs8SFUlzCZRtoFei1m3M4PcGzEpVP7X9PrySCFx91K+Z5xSJuElxYKK6N1Cvl4iSoQIjduD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370759; c=relaxed/simple;
	bh=G+xoTVYPy+YnXzEfUjjBtjmQnKEcU0FD4dZ3YomcFCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxJgc3QYykZa+bd2Z4r+3wR/3St5HChouseApjYUievaUex08zgkMIhQCDMEzNdRFe2hXH62k2sifMCe+nT98hJ7ZQ6VSxCx/Ur+vxQMCH/uiBMrNRBqYOpRt+o+TrIMYzte5hlauP7rsoLdNTzrcg3TueuA2OEstVtOWehQ92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT2lvzp7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso2968443f8f.0;
        Mon, 08 Sep 2025 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757370756; x=1757975556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWDSb1eSfyIbNhJBQWycQp0U/Z0WU6t89hz9hGkU+As=;
        b=HT2lvzp7PtDLCGwoBxp3zJzsHQwiszs5veQp56mYsesP3uQ3+ktMuzYp9/nVq/FlbS
         XXisADy4EWLyfUr5LpMOA3GSl7j2yTv003gf3r4HAKpHO/GB+g/3vujcejuzjMxIkxJ5
         59tM4EoOj/3xdL8qOhfR+NjsYg6tqYLrPWDzS+okldyrbMTeaGf+VsG67RO4TrPGfDyY
         4L/Xw179qx0P1lTkQnOj3WRu1OpN+Q7+fa5IcDorf1gs9TTGGGmgVlNdlwaZs19mK0eE
         2z53X5hG9uXd6MWXckol0mVZI1pVPvaZ2zgLCZfapC6mK8w1RibvTjdltvICrr0krSNH
         xWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370756; x=1757975556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWDSb1eSfyIbNhJBQWycQp0U/Z0WU6t89hz9hGkU+As=;
        b=ci94M4qb/1EFXnZLy3qzhQDqBNxi2cXJnJetI9AzDpKZJIukRjbjry+3VdSS2IPsvv
         3dHvQ+Hdq08nmVva7mIbx1W6q1GE6YUSSzdv+816Dmyk4v0dqeXKmbZIUl0eMB4Fhe/z
         AK3Ky+/E9E2o67QBPMXtNMqvN8afqP5+jfY9CW6R6+p/BQclG1X+txI9uovdmrwAGWgw
         CYrr4AyRK9l5/s4vV/KT5UNS5k8q36Xr9fX7S0xAQGuZJ2Mg422/jNBGxhsr60vyakgU
         4TgVhZKX4qBsCd8zRbfBi9cBloCROMonzO7hlBjdIglD4VvE00pCm11RD+JE8YnyjWy5
         lAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9GY+ZvZyxbUE/GnJKM5cran8xA8XHj+Wyk3I/tMefYlOj0w7KBo4fCna4YHJ3BgTZq3H/yuzp2B1imYzI@vger.kernel.org, AJvYcCXyhQRo6SVINXAyiJOq2eKfW2IoqwoBcT1mv4/splYc5yrBCbupZ7gJHsjKghprnjY2fuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyjR3HkQiVpiOb7Y7lfFh1xUNKy3OF+KzMWDb1HMXfLCeaiED1
	PFV8TWC0WMKxDSsKm9rA/t0/vohSXMUoOwqxybmZKjKHlNVQfL11GYOLFji7y3Ev3sF4V2mnVsh
	PHjPEgn4vfgE5gLlBG48SvnNdbOZUstI=
X-Gm-Gg: ASbGncuw8ANcMZ/s3a4yEA7gmlWcaKCgMVRX3nxDakJl3UrVxergHN2ucygE2Z0pe7u
	qjrlo7S6EYroc8+lwwOwzyAobXseQI7mPZZOnHL4zUNNPm0X7cS4jUtjiSpDDCS5qbHYow97OWm
	TxbhYSygTL46mQ2PTAto0PkFZzOoBPY6l0C8RWdQyFafwjxb3C61tnZ8hh0ibLOhsDqExqXBSFt
	D091fhEZ0Ccqqt2Wf/DgWEwJpdTaMNe6mLD
X-Google-Smtp-Source: AGHT+IGvxEvSesWy1SFzicVmZYl53yXHLSvsgqJ/CfKAw3KWGaP78PY1mYBLV4Z+IcJ3+k4whze8cDVlY5VVnCr1/aM=
X-Received: by 2002:a5d:5850:0:b0:3e5:9ce:623a with SMTP id
 ffacd0b85a97d-3e643a21961mr6987680f8f.52.1757370755834; Mon, 08 Sep 2025
 15:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903172453.645226-1-irogers@google.com> <CAADnVQLkhysjnEsZACK-fgG3XBaHj1FqnhJdu+0V6PCbpKEK=g@mail.gmail.com>
 <CAP-5=fUm0-f6CW1DNKWK0Zv_4Hzqe5oV+d4ajhd3+XMdxXvu2Q@mail.gmail.com>
In-Reply-To: <CAP-5=fUm0-f6CW1DNKWK0Zv_4Hzqe5oV+d4ajhd3+XMdxXvu2Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 15:32:24 -0700
X-Gm-Features: AS18NWA-SIdg7ngEdMsxLxch3zgb5KMzWJ6tR3NOPo0MH5fecEGnUg0QB233z6E
Message-ID: <CAADnVQK_X7PnKwbrmS2sT+oV1ZVYfmnagt_Wi5wg2nO9vt=W6A@mail.gmail.com>
Subject: Re: [PATCH v1] bpf: Add kernel-doc for struct bpf_prog_info
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:01=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
>
> > >         __aligned_u64 prog_tags;
> > > +       /**
> > > +        * @run_time_ns: The total accumulated execution time of the =
program in
> > > +        * nanoseconds.
> > > +        */
> >
> > Missing critical detail that the kernel doesn't keep counting it all th=
e time.
>
> I'm not sure what you mean by this? Do you think the comment is saying
> that the run_time is the run_time since loading? But it says
> "accumulated execution time" which would imply only time spent
> executing. When is it not counting?
>
> > >         __u64 run_time_ns;
> > > +       /**
> > > +        * @run_cnt: The total number of times the program has been e=
xecuted.
> > > +        */
> >
> > ditto
>
> Shouldn't the purpose of run_time_ns and run_cnt to be to calculate an
> average run_time? If these are arbitrary values, what's the point?
> Again, why isn't this explained? Thank you for helping me to try to
> fix this. I'm also happy for others to fix this and this patch to be
> completely ignored. It can be ignored in all scenarios, I was just
> trying to be helpful to others and probably my future self at some
> point.

Posting a patch generated by AI without proof reading is not ok.
Wrong documentation is much worse than no documentation.
If you don't know what these fields do don't add random comments
to them. Read the code and document based on your understanding.
Copy pasting AI and throwing it at maintainers to review is inconsiderate.

