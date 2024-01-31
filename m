Return-Path: <bpf+bounces-20848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892548445DD
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286A21F29B29
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4172D12CD95;
	Wed, 31 Jan 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/zI9xlH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D522374D4
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721457; cv=none; b=c8cTwdYcJN9H53ezfy2H87ZGDZxBNMHelgy7BoVQjfUdXdlLV0cxUdZIjCdp5yMueZ5CRyLmZdSrTKbdQipXVcsga3yAkWTqAmaXdpq1gRuqNt8Bhr+uyqrYJyHM2A7pwNGBxVbRHSUQuLsYxd+91GvJTEFuSwdYZsMf5ekBdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721457; c=relaxed/simple;
	bh=/xSK3slDLqoog/D9NUpi6uNSRTi+DFQWsec+4dlU2bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDFA477qi0hu7mjltmvLQ2t5GRybCr+e6rSITdZNbELWNk4eF0N/EDLn4fY7gSp7qtAfZAFVrM4Tdl9fbr4vet8MBwD0y08x/JCl9F8klDOaymEa2xq4KqfHZDhut8JZehiG7fitgHHbBhLnEZRVehp6lygXA1WYNgK62gt6xr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/zI9xlH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ddcfda697cso4048284b3a.2
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706721455; x=1707326255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqmrikcEBlv98Prhlo9GrrnV9aeU6tJgvtSDi/yX/+M=;
        b=l/zI9xlHvDYMY1HtjNyPp5g0Vsm4QLH//vgip2jI6yCwcGlKocnJPx4e+aFpzFaSCf
         Tt8/YGkKyj7ODSjZo4wO6SwMOGP3H4LcVp1oeyCJXsh8VqSLmcFRDzrssG80b8BvKm31
         yg1C+/t2ZgTpFD8V314hzTKPC5jkf+M84BWsDvnUWomTsWg4X2vBEyywfmkvqhknIbES
         lysRumrgxh7tIDbGQGqlP5niLEB1JnTjyogrC4WpL2A/Id15ymjWDSHImlSwiAnnk5v9
         A177YedeTekshrz4Exn2WOpxXJ3+EH2FyzTLzMr4JI+ny3RGWdnzBp7KKYARSOLQcDjK
         aVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721455; x=1707326255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqmrikcEBlv98Prhlo9GrrnV9aeU6tJgvtSDi/yX/+M=;
        b=AEqeFIb6hDpSWtOA77Bf2r9PGpP0btgzyqzxdJg7S2MoyEFzU5OHzlOQNymbbPCp/c
         oTJRUwzNIvuxBXRc/0B2KZSzqV1q+E8CdBb5BW0Js/t/u0Mk0daieOuFYDDKOKByci2Z
         y5z7uvyekqVWytcI53ag/Q3kALTGlal96HM0WDw4RqnvyjNmseP4/IzQuCwvw4otYsri
         UlJvUCYVgPGv1WPzGYZ/4qCumfdpjYgiDSbifH04emIohimJMLYlC01j2+HpEbx4lpB5
         o1t1pDx5ZF0O8VG4GsoCteEN1jJg4dMybVsq7RFZZwtWeDbhpsvDpdPnj4BdHUTl1m8o
         Vp2g==
X-Gm-Message-State: AOJu0YyZqpHwXP0GGxISLlUq7gN8sHML/ycOAvvbSNprvxpc0Bk0gBai
	JElUHsqFcyc1Rq13NxcnNqxTLl6I2xkZMs+flz/KSPXoCf2Jt7oaGo1grvezPhIONXAdoop9/kC
	wjH6eyRVQLvW8g+myKwzls/Xbnkc//uaT
X-Google-Smtp-Source: AGHT+IH9TLcMzYs8xFRD1hhA30BEuFF3PtoxIyGy9szqIhGaRjtwVU/Cw36hSXA/ZVD75qZyRHCNPeFN686IK+wCgSg=
X-Received: by 2002:a05:6a00:23cb:b0:6db:d978:9047 with SMTP id
 g11-20020a056a0023cb00b006dbd9789047mr2731743pfc.1.1706721455459; Wed, 31 Jan
 2024 09:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130193649.3753476-1-andrii@kernel.org> <20240130193649.3753476-6-andrii@kernel.org>
 <dad95ccc-1e24-4994-ab37-44288d6ff26b@linux.dev>
In-Reply-To: <dad95ccc-1e24-4994-ab37-44288d6ff26b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jan 2024 09:17:23 -0800
Message-ID: <CAEf4BzbdNxWBijaJgmEEjEYjv4aSdH_Sw7AHOm3FiTNDRdnUEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: fix bench runner SIGSEGV
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:41=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> > Some benchmarks don't anticipate "consumer" and/or "producer" sides. Ad=
d
>
> For this, you mean some future potential benchmarks, right?

No, existing ones as well. Like trig-tp and other "trigger"
benchmarks. I ran into this when I was trying to set consumers to 0
explicitly, which wasn't allowed due to <=3D check. Then I fixed the
check, and I ran into SIGSEGV. So I decided to fix that up.

>
> > NULL checks in corresponding places and warn about inappropriate
> > consumer/producer count argument values.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > ---
> >   tools/testing/selftests/bpf/bench.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selfte=
sts/bpf/bench.c
> > index 73ce11b0547d..36962fc305eb 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -330,7 +330,7 @@ static error_t parse_arg(int key, char *arg, struct=
 argp_state *state)
> >               break;
> >       case 'c':
> >               env.consumer_cnt =3D strtol(arg, NULL, 10);
> > -             if (env.consumer_cnt <=3D 0) {
> > +             if (env.consumer_cnt < 0) {
> >                       fprintf(stderr, "Invalid consumer count: %s\n", a=
rg);
> >                       argp_usage(state);
> >               }
> > @@ -607,6 +607,10 @@ static void setup_benchmark(void)
> >               bench->setup();
> >
> >       for (i =3D 0; i < env.consumer_cnt; i++) {
> > +             if (!bench->consumer_thread) {
> > +                     fprintf(stderr, "benchmark doesn't have consumers=
!\n");
> > +                     exit(1);
> > +             }
> >               err =3D pthread_create(&state.consumers[i], NULL,
> >                                    bench->consumer_thread, (void *)(lon=
g)i);
> >               if (err) {
> > @@ -626,6 +630,10 @@ static void setup_benchmark(void)
> >               env.prod_cpus.next_cpu =3D env.cons_cpus.next_cpu;
> >
> >       for (i =3D 0; i < env.producer_cnt; i++) {
> > +             if (!bench->producer_thread) {
> > +                     fprintf(stderr, "benchmark doesn't have producers=
!\n");
> > +                     exit(1);
> > +             }
> >               err =3D pthread_create(&state.producers[i], NULL,
> >                                    bench->producer_thread, (void *)(lon=
g)i);
> >               if (err) {
>

