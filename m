Return-Path: <bpf+bounces-2347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D882072B2A7
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C05D1C20993
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D4C2C4;
	Sun, 11 Jun 2023 15:55:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34007BA57
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 15:55:46 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359EA8
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 08:55:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-62b671e0a0dso23949486d6.1
        for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686498944; x=1689090944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTAcpuVp7hbtEOtNl3IRY4gTSWnnNatjcQb494pw1RY=;
        b=aMCELl/yfS21gnRRLJZm9tBkUfzW1DmoviA8HbrY3S8l9fDz/rGkjl0ApXON/DQi3v
         KDy/szvwadPp110aj2vC3ild+12Y2KLS/9up6IyPoy5ErzP5jFRk/QnczWnqEFtYDzyV
         FAJPVnCxM+TGuhwMHni0nqvcBdgHSkwdfi9t0d1RB0T+FK/Yt6VVn+P08/6VcZ/A8MHy
         l4Db3F80qBYsMuqVH+DqU9nEmrTVHlpwtUIj28nzIyKJUPyVLSc2yR1xlDFwwHFk2+Qs
         AJ0Gz3ssYtydQ9NNiOBPvDE+Q5p6CqGDhitzL2D8dLTG+/UMhZfQ3n3j6gWMVXvMbdEv
         mmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686498944; x=1689090944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTAcpuVp7hbtEOtNl3IRY4gTSWnnNatjcQb494pw1RY=;
        b=HM6MpIaELFpNkBa0GG/YaTyv08wWx+OqZzHk0EgGcxRQkHLUcjnT1oNvMCWjvHwUaz
         6mJcuT6br7eYgDt3+0zPU7iHPqrS/mkhS493H7/fxHTy9vuIkLU7PHVmCbj0NhiGv+Ws
         wzTNhM2CckA7KgpLQRDzzFGg/S8sJakcAFrCZpunVt4rD24pEWbThZFOPoPnTMSLbqeJ
         xB/txuNa3Ngf/ywAyJoVHveudyWWGkghMgSyXj3l8qpTGsiCwv11l4menpVj54RRLVRz
         h6yieDAd7sKpFoAIE8BqOHV577PIodAmVF90Sev8bLQ1BALUe3S5KT4hUYSOAf5C7U4K
         4J0Q==
X-Gm-Message-State: AC+VfDxV1gkcCoj3siGOkjN/tu/quzCAS3R5/P84yJHhEIX60pC+yrA8
	W/G5Y/pPB5r8S1gJ5n/ZDXd2AaK0jiERTFnNhh0=
X-Google-Smtp-Source: ACHHUZ4cKDzu+b8bJUWT6CgeQYNvf4vk7Ipleh3B5s9NW4IIFGcMehLZ/B4agx9x6bomFMhEX+4WDGOmde97nO+6vqE=
X-Received: by 2002:a05:6214:212e:b0:5ea:9fc5:fca2 with SMTP id
 r14-20020a056214212e00b005ea9fc5fca2mr8872598qvc.45.1686498944034; Sun, 11
 Jun 2023 08:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-10-laoar.shao@gmail.com>
 <ZIT8qWzkl6P2wXmq@krava>
In-Reply-To: <ZIT8qWzkl6P2wXmq@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 11 Jun 2023 23:55:07 +0800
Message-ID: <CALOAHbBFQZm=c9Dsmztk_RFM7_HbDMZFV0+u0Djzq9WM-xXXCw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, quentin@isovalent.com, 
	bpf@vger.kernel.org, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 11, 2023 at 6:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jun 08, 2023 at 10:35:21AM +0000, Yafang Shao wrote:
> > Add libbpf API to get generic perf event name.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 107 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  tools/lib/bpf/libbpf.h   |  56 +++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.map |   6 +++
> >  3 files changed, 169 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 47632606..27d396f 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -119,6 +119,64 @@
> >       [BPF_STRUCT_OPS]                =3D "struct_ops",
> >  };
> >
> > +static const char * const perf_type_name[] =3D {
> > +     [PERF_TYPE_HARDWARE]            =3D "hardware",
> > +     [PERF_TYPE_SOFTWARE]            =3D "software",
> > +     [PERF_TYPE_TRACEPOINT]          =3D "tracepoint",
> > +     [PERF_TYPE_HW_CACHE]            =3D "hw_cache",
> > +     [PERF_TYPE_RAW]                 =3D "raw",
> > +     [PERF_TYPE_BREAKPOINT]          =3D "breakpoint",
> > +};
> > +
> > +static const char * const perf_hw_name[] =3D {
> > +     [PERF_COUNT_HW_CPU_CYCLES]              =3D "cpu_cycles",
>
> could you use '-' instead of '_' because that's what we do in perf
>
> actually would be great if you could use same names like in
>   tool/perf/util/parse-events.c  'event_symbols_*' arrays
>   tool/perf/util/evsel.c         'evsel__hw_cache' array
>
> so perf and bpftool would use same names and we have a chance
> to use same code for that in future

Good point. Will copy them :)

--=20
Regards
Yafang

