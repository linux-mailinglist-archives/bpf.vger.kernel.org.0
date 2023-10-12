Return-Path: <bpf+bounces-11988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1D47C642C
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A381C20F6A
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 04:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3553A6;
	Thu, 12 Oct 2023 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Immu1NZH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC6CA44
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 04:42:41 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502B8B8
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 21:42:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso1035207a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697085759; x=1697690559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An3A61D6+2adp3IrcxTXXRjRh8D6N0hbcY0BK254ifo=;
        b=Immu1NZHJ7R5VLUhT9VHrwtQOXmbH2c15NDDh/rnRiK7wN2w+jODRea4dAkAVJ8GbN
         R81PeGqixqJdqal+0UOWnEcAxpgObH6HPssusbXCHsxBYtcGALxYWbFBZSWsD3t+liDj
         jrBsY9Q1Tbln6lhd9DhqCBmRWSZDLeMdlQz4Gc7Kus/RCwskUJgAy8NWi2CxZxeZ6/PK
         gbPx/DxzV/aT7j866Y+KI8DeOj+4LIRnrSgDTCiJWGUzoBfDf6T2YmxEqIwcy9Bgf5vQ
         pqV5i8wkHb10KCA1DtQ/cGzwc2CGFGrL08YMebkzucydohSwHnTX5N1rIF/ZH2hY5TUk
         u4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085759; x=1697690559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An3A61D6+2adp3IrcxTXXRjRh8D6N0hbcY0BK254ifo=;
        b=Y/VlpQ6CTj3MywPTRk+DyQopI+sy+eYzCJKF/g9cNkNkDCwWgeed7DvI7YWL50quJX
         4LjW4Ikfol84ujS32ihG9YtECx5QQNxcTnyxppIcsAlQWj3vcQbwGNwRZyGPQYn4vIyL
         li+EIgstIZk+MsVxXCz5T89ANxlJ93rCzegliYo7xmC+ARdaRjLehfiWjkBydgFV1+Wt
         JVoaRzoJhkWNj7h+O0a3HAdKQEZI+quj3PqHCGHddQKxqkSsYs33ZHRMBHHVS64IqZKX
         3R72eGkpMUGKVo9QxFTo5dGXs5J9aGEtTCBvxOh9hJSJucD1Xug7byO9QquD2HY11/oI
         SRog==
X-Gm-Message-State: AOJu0YxMkxdHB+j0sUGJT5MNlePlMtYDNEXRDhu8uvVYfWnJq9Qa8uVk
	ahVgTeglWvXDR6cIIKli/APwUsg7uVmSKKTt502XePGg
X-Google-Smtp-Source: AGHT+IFGoRY5ckDOnx15l70Ja1ML515c24uNEMrNXqzM3Pf+bN5/sDpM86WhatLgrmp7hdHTIRDAGzCyezaSC2dV1/Y=
X-Received: by 2002:a05:6402:550b:b0:53d:b59c:8f8d with SMTP id
 fi11-20020a056402550b00b0053db59c8f8dmr5040840edb.8.1697085758508; Wed, 11
 Oct 2023 21:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com> <CAEf4Bza6UVUWqcWQ-66weZ-nMDr+TFU3Mtq=dumZFD-pSqU7Ow@mail.gmail.com>
 <CALOAHbA=-F=t7L=21PyGqro_=HQ8qfMMK7V1VeLWmp0opbr48A@mail.gmail.com>
In-Reply-To: <CALOAHbA=-F=t7L=21PyGqro_=HQ8qfMMK7V1VeLWmp0opbr48A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 21:42:27 -0700
Message-ID: <CAEf4BzYx5DMUasdJZrEKuoC=S8V_mviDXyJdA5A6zU+aCUa3AA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
To: Yafang Shao <laoar.shao@gmail.com>
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

On Wed, Oct 11, 2023 at 7:29=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Oct 12, 2023 at 6:53=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 5, 2023 at 1:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > Currently, there exists a system-wide setting related to CPU security
> > > mitigations, denoted as 'mitigations=3D'. When set to 'mitigations=3D=
off', it
> > > deactivates all optional CPU mitigations. Therefore, if we implement =
a
> > > system-wide 'mitigations=3Doff' setting, it should inherently bypass =
Spectre
> > > v1 and Spectre v4 in the BPF subsystem.
> > >
> > > Please note that there is also a 'nospectre_v1' setting on x86 and pp=
c
> > > architectures, though it is not currently exported. For the time bein=
g,
> > > let's disregard it.
> > >
> > > This idea emerged during our discussion about potential Spectre v1 at=
tacks
> > > with Luis[1].
> > >
> > > [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb=
@iogearbox.net/
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Luis Gerhorst <gerhorst@cs.fau.de>
> > > ---
> > >  include/linux/bpf.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index a82efd34b741..61bde4520f5c 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(voi=
d)
> > >
> > >  static inline bool bpf_bypass_spec_v1(void)
> > >  {
> > > -       return perfmon_capable();
> > > +       return perfmon_capable() || cpu_mitigations_off();
> >
> > Should we check cpu_mitigations_off() first before perfmon_capable()
> > to avoid unnecessary capability checks, which generate audit messages?
>
> makes sense.
> Should I send an additional patch, or you modify the original patch?

please send a patch

>
> --
> Regards
> Yafang

