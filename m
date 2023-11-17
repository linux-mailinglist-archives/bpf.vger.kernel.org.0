Return-Path: <bpf+bounces-15265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1017EF8AE
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7732810C0
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50F45BFE;
	Fri, 17 Nov 2023 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXHRZTtL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650E7120
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:29:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so324358566b.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252944; x=1700857744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP13sfVGQgEVCqreZERQYej1nWr+gi7eNqnP4SDrRak=;
        b=cXHRZTtL22HtnA6eRz7x5Qs2EPDmqMNRNioBrdOafM2Ihe+4YqowRGqgIevgI3Rz2O
         kFN/tfL6l1Ns3VchCn51ysyYvfAKR7NMs0MNmCdwnlhKiPsqfW99/RL/TSqGGR8l4SKy
         +zZq9/E4fRFLwDCb+pRhnzdeWSVPtgU+oI4lZiB5nrvpW+I3DgOrcv/wBknbBiW1Fzzz
         vwggEBYDByHDkyazWclIUYZnjDy9VoRJqmc0vttJIi6DmpgiVDg0vz76yfL+4rGkqX/T
         kTKTd4DkySACye/qqTKbinSMiH7DNAKPfT8u0F874rC5AfqCuKnf+8/AZV7jN5p3Brdo
         YHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252944; x=1700857744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP13sfVGQgEVCqreZERQYej1nWr+gi7eNqnP4SDrRak=;
        b=rG8yTp7cCW8nZWJUaLce2DDDr6TG9s3OkGBmy+Ny6PwDsIkIWp5f3yJ0JXx4EhI/Hm
         gKlzs0Fb2xcrM3HOseIwjQgxSWTTcWIH8h/EO/Xt2KNOBRHVuo6fq/Bx2yfPxYshkC7B
         trI5ijo88XmQbtX+PWnBMXpNDEqCSdXkySYaHCVDC9eazEVkwJZUnHenCb40R40lNvma
         cKPwVlw4rBYnMTzMLq5te87Vngk/qg3iS2Ds4z+yQ2Fxt+YF/ZYVYOnkDC5HFb05Rm7v
         PO7iMwtIS+4XsNPIBZ2BXn2hMMjbIYmjqvY86s1zqiyd3zmjti7hGPB9rbAgn8tx/xYI
         Oulg==
X-Gm-Message-State: AOJu0Yxo+e6RKdNtNxLb7x9KpW8PBs83awH35o1Q8tDVWsRVJwxe5ugO
	WL2MtOLmZS2OGqacdadBQKbEijmuN1a8t1BjBU8=
X-Google-Smtp-Source: AGHT+IGdIw2mA7yp//BVDm0BhFz10ShENtVaOlDptSbwz0j25qhKF8IXRSoRpr7hhVnFAv3CgSWCSrpZxJnt2IkTBTM=
X-Received: by 2002:a17:906:225b:b0:9d5:ecf9:e6a0 with SMTP id
 27-20020a170906225b00b009d5ecf9e6a0mr244430ejr.0.1700252943523; Fri, 17 Nov
 2023 12:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-10-eddyz87@gmail.com>
 <CAEf4BzZ+rMakBnBKnqOCsxM4XqSfraaqaEE1wdfrhAwLOP1x6A@mail.gmail.com> <8debf74caf92472d40e34fef20658727e541f3b1.camel@gmail.com>
In-Reply-To: <8debf74caf92472d40e34fef20658727e541f3b1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 15:28:52 -0500
Message-ID: <CAEf4BzYLVKah26=C-oZpOxRTvABuzDZHhB_Z2CcDp6a1FPiwuA@mail.gmail.com>
Subject: Re: [PATCH bpf 09/12] selftests/bpf: test widening for iterating callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 11:47 -0500, Andrii Nakryiko wrote:
> > On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > A test case to verify that imprecise scalars widening is applied to
> > > callback bodies on repetative iteration.
> >
> > typo: repetitive? repeating? successive? subsequent?
>
> I'll configure spell-checking, I promise.

no worries, I only notice it because gmail highlights it. I was rather
wondering if "repetitive iteration" is the right way to explain this.

>
> [...]
> > > +static int widening_cb(__u32 idx, struct num_context *ctx)
> > > +{
> > > +       ++ctx->i;
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("?raw_tp")
> > > +__success
> > > +int widening(void *unused)
> > > +{
> > > +       struct num_context loop_ctx =3D { .i =3D 0, .j =3D 1 };
> > > +
> > > +       bpf_loop(100, widening_cb, &loop_ctx, 0);
> > > +       /* loop_ctx.j is not changed during callback iteration,
> > > +        * verifier should not apply widening to it.
> > > +        */
> > > +       return choice_arr[loop_ctx.j];
> >
> > would the test be a bit more interesting if you use loop_ctx.i here?
> > `return choice_arr[loop_ctx.i & 1];` ?
>
> It would force precision for 'loop_ctx.i', precise values are not widened=
.

ah, right, ok

>
> >
> > > +}
> > > +
>
>

