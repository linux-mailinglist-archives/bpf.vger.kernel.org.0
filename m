Return-Path: <bpf+bounces-11986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DAC7C62BF
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 04:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49132282739
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 02:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C37FC;
	Thu, 12 Oct 2023 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKO4PIEE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5C7E4
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:29:54 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25BA9
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 19:29:52 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65af7d102b3so2832996d6.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697077791; x=1697682591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2fPvOJjoRJvyuz6Z20tyXeXHsV+lgRWs8m9AYpQMrA=;
        b=BKO4PIEEAlBECtWTYJ3MQ2NIkO9V3Q9XjHll1BwytOtkg1V6lN7f4+vdFe/3FEgtM0
         tXC2EDa6dBd11XtLADGnJ4HD6HSucFznafAp6zLfxjgVGCTGDH/lLaz/oEN1qcPsjWmv
         +O9RSEgR9EyFL59eBWQMMoIDFYLxZSJm3NuN8tX98TuERz56BSMa6Vgi5Piiv5Y7/DOY
         Yrdk21w2D4avstRrtexQBKMniPUqb2OqNPT675QwyptefSiXArw4SUT5reEU7hL6/myR
         4jDHFbELVvZ3dTFatzlibXQLZcvqdOiVOvUMRLd0g50saPe0JhU99Fr6ziCPRQ9c+0M/
         lx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697077791; x=1697682591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2fPvOJjoRJvyuz6Z20tyXeXHsV+lgRWs8m9AYpQMrA=;
        b=hd+jbP0c7kQKGXmC/GCZFtAdGwSNKYoEAqR0sn+qIR5uuGCGTz+YmTOxWgV/jcCsiq
         VTNFIrmo543jtDypZTG8upyOSroGD6jt+vZawE2LiPEGF2QvAvE5/2imMHI9+J1RzuY+
         /xBMJshuqW5D3gteHTQO4qkA/VhMu0iup0TWBjNYHJpu9oyadOeDWFtNLo0RYFEjSVUp
         3rm453AymyuKmLEehlGB808e7jei5ohjU20YaaiMzQUgXpO3i6M5JfG3BjiebWwaRije
         19irtsrYhHpnNvsHQB5CaH/F0E+TOv52aFEw3nJjfkqkieIvru06Mn9qUtw68ZAGZGXS
         P/3Q==
X-Gm-Message-State: AOJu0Ywx1s21vc4cJzzW3zd9HjaxJ3HOTG5ugMSrwdGAfBnXueZbjIyv
	T5PvRDpvec9T+N2sWQAJwEHGC9Zog4ranncVGEU=
X-Google-Smtp-Source: AGHT+IFwFLSZpPtjrZRAJ162nB/Dj5HvcHyEgjUFZZkK0yBXvD/a3Lko3Zap0tjKppbKnnH+kPNznI5qF+WPMUw14KQ=
X-Received: by 2002:a0c:e246:0:b0:630:7d0:56f4 with SMTP id
 x6-20020a0ce246000000b0063007d056f4mr20609126qvl.49.1697077791200; Wed, 11
 Oct 2023 19:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com> <CAEf4Bza6UVUWqcWQ-66weZ-nMDr+TFU3Mtq=dumZFD-pSqU7Ow@mail.gmail.com>
In-Reply-To: <CAEf4Bza6UVUWqcWQ-66weZ-nMDr+TFU3Mtq=dumZFD-pSqU7Ow@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 12 Oct 2023 10:29:15 +0800
Message-ID: <CALOAHbA=-F=t7L=21PyGqro_=HQ8qfMMK7V1VeLWmp0opbr48A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Luis Gerhorst <gerhorst@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 6:53=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 5, 2023 at 1:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Currently, there exists a system-wide setting related to CPU security
> > mitigations, denoted as 'mitigations=3D'. When set to 'mitigations=3Dof=
f', it
> > deactivates all optional CPU mitigations. Therefore, if we implement a
> > system-wide 'mitigations=3Doff' setting, it should inherently bypass Sp=
ectre
> > v1 and Spectre v4 in the BPF subsystem.
> >
> > Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> > architectures, though it is not currently exported. For the time being,
> > let's disregard it.
> >
> > This idea emerged during our discussion about potential Spectre v1 atta=
cks
> > with Luis[1].
> >
> > [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@i=
ogearbox.net/
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Luis Gerhorst <gerhorst@cs.fau.de>
> > ---
> >  include/linux/bpf.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a82efd34b741..61bde4520f5c 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(void)
> >
> >  static inline bool bpf_bypass_spec_v1(void)
> >  {
> > -       return perfmon_capable();
> > +       return perfmon_capable() || cpu_mitigations_off();
>
> Should we check cpu_mitigations_off() first before perfmon_capable()
> to avoid unnecessary capability checks, which generate audit messages?

makes sense.
Should I send an additional patch, or you modify the original patch?

--=20
Regards
Yafang

