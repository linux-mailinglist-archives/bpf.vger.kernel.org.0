Return-Path: <bpf+bounces-2339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A372AEAC
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56433280C4E
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F76FC00;
	Sat, 10 Jun 2023 20:35:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8C2564
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 20:35:05 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C82626B2
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 13:35:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977c72b116fso445639666b.3
        for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686429303; x=1689021303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td2WNh4cY1TVCn0GIJgrdiYt70ACnTWYnI8aZ/yGNfA=;
        b=M+9D+Jm1832EN9M9m61UzsKc2Z0yvF4vEvqMaQr+7qNAL9G2AhTUxcGO21Tx5Yw899
         hVRNm9ovENlOauk51mNy5KZR01aacRt1UTOlS5TLpuzuWhr0MjVwsWoHg0Ck7yNXOy/V
         Z03RtM3PGrtbacNdMZFFLjBZGZyuMkH5W1COq8jQ3W7rgXJ4UMwEhclAURZD/ecOkzmq
         ev3LW3mYZA6BPHiNYgv9eE2MDxBxP2F1tPuDTNdYKc63ldaaHpogAW8BfJo6AkHgZajq
         M8MTS2uoFpWXb2Yqad43tbtdmzEjweaOepOSf344iLi5s8PdNF8ZRZfbtHzHOyrZLRjG
         /qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686429303; x=1689021303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td2WNh4cY1TVCn0GIJgrdiYt70ACnTWYnI8aZ/yGNfA=;
        b=T7JVrqRgRRx6vV5iOWvNhlQ+RwOu3O53lvew0/ADgEnnqGIA1bm78QI2VXJMmWFMBw
         Arv3dlmguXBvGMKIj6CZ6Ee+ane7pc97Mxt+fkAO9MXJAb8kiu8bXzH+/BHKctpl/4B5
         CXKHfxAORaEbJCOwmZNYA9+MeWkRI4BFulP4YwJrPEWsH4b0WU4BT7q/Y5jg9WmFqYz/
         +tHAh/PFj9p/0tK0kUPEZ1SklC3oWZ16E6ojBnligZ7y2u6jZFv2Gw6PR1tHKlGJpcro
         QxGFBBuPZJVjt8E3dvEl/KTQ/I3LITZlSXcFzfk1wumq8Mi5vnGAnDkJjyWbgMyxktCt
         CfeQ==
X-Gm-Message-State: AC+VfDxF7tXYp98ktxK8RRDZuxoOpHQenH/NAmYrLkeGHYuv8gh9rZ0J
	taFv7t5hiL4hDC0Y3etetLxRJhtN+VtQ7LIu2PQM+g==
X-Google-Smtp-Source: ACHHUZ4k3wuNgSOvdyW0desrsXA7fsVmv/rGaeJPcLlqV0JV3ADBBIckeb7fM8y4HC+NeIWUnDjbtSYBq4ymgxfkaY4=
X-Received: by 2002:a17:907:1611:b0:969:f677:11b4 with SMTP id
 hb17-20020a170907161100b00969f67711b4mr5025552ejc.37.1686429302612; Sat, 10
 Jun 2023 13:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-10-laoar.shao@gmail.com>
 <CAEf4BzZtc+yfg7NgK5KG_sSLGSmBMW-ZBF2=qh32D_AW++FzOw@mail.gmail.com>
 <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com> <CALOAHbCeP3bf=Y1NuJh9MYXoinbi0+fRDANaTdBmOXi1DXz0vw@mail.gmail.com>
In-Reply-To: <CALOAHbCeP3bf=Y1NuJh9MYXoinbi0+fRDANaTdBmOXi1DXz0vw@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
Date: Sat, 10 Jun 2023 21:34:51 +0100
Message-ID: <CACdoK4L+pPFN=f6Q-KrZNVo5fwqxDBr51cuu_yz5W-GGumsmTQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 10 Jun 2023 at 03:22, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Fri, Jun 9, 2023 at 12:36=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Jun 8, 2023 at 4:14=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > Add libbpf API to get generic perf event name.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > >
> > > I don't think this belongs in libbpf and shouldn't be exposed as
> > > public API. Please move it into bpftool and make it internal (if
> > > Quentin is fine with this in the first place).

Fine by me

> >
> > Or maybe it belongs to libperf?
>
> I prefer to move it into libperf.  Then it may be reused by other tools.

Libperf sounds like a good place to have it, and I'm all in favour of
having the names available to other tools, too.

This being said, this would add a new dependency to bpftool. I'm not
sure it's worth building libperf from bpftool's Makefile like we do
for libbpf, just for getting the names: it would add to build time,
and I don't see an easy way to replicate it on the GitHub mirror
anyway. So the remaining option would be to use the library installed
on the system if available, and to have a new feature detection in
bpftool to figure out if the functions are available; but this also
means most users compiling locally wouldn't get the names by default.

Looking at the list in the UAPI header, it seems to be relatively
stable, so I'm fine with having it in bpftool, it shouldn't be too
much overhead to keep up-to-date.

Too bad these are enums and not macros in the UAPI, or we'd be able to
derive the name without these arrays, given that it's just trimming
the prefix and turning to lowercase. But maybe an alternative solution
would be to get the name of the enum members with BTF, and derive the
names from there? We already (optionally) rely on vmlinux.h at build
time, maybe we can just reuse it?

Quentin

