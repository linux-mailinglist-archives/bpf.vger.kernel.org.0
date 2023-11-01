Return-Path: <bpf+bounces-13851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76A47DE808
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13A32814A9
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B21C293;
	Wed,  1 Nov 2023 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9CPJqXN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E61B296
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:22:15 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF6124
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:22:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c603e235d1so40380866b.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698877329; x=1699482129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gRn5bB/T42A8p85gnIhq4kxwtnftEFFBkvmhUu10V4=;
        b=X9CPJqXNmSywmVtt1ZmkB7F+uj9N7FrmZC177DGQtybShURb6H53UwSxZlQ4ZwQyyv
         sZjsvvaLl/AGhrutLyvE4JzStJ5HPK8GptUVnqHL2KtySXpAjJXR/x8WivJ5MD7htUss
         mp3jteqm9htKcllYTT1C5MbJ8NStOHUrKadFmZOMPTzugWxB+IWb7hC2P6qo1yU4J1Ae
         pE/N9nCBZ+bCZrjt5JGwSZnr9ibJ0dT3vjY9eLZUzxLMgePh2IHj8zUzzKBccuuZhKXo
         k240Sd/y3T/KV3Ky8vFYfSqhHrlLNRL/CxuUa61ZLzknoqRVVfihy4XkhA1eqkckZbeH
         Urgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877329; x=1699482129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gRn5bB/T42A8p85gnIhq4kxwtnftEFFBkvmhUu10V4=;
        b=Nujn4598xNZDLRrUOLACdDFpctbJE9jlt+cyTvO+DG5PfNflicRzSmjSvQUFRX4hXd
         E/ZCp0X0U8rDkwSpal4qoxoxeVQzJM/uFXs5GTWTrZ1f6ZTKPh2WQ4VYdpQUvlO9yorw
         pnoDS9Dq/vTGSmQydyLM7dSgkJDY/wNhXVrN0mivohSqov+T3mvztgxvVOy19xMjqgbZ
         WD492qBQMaAEsQFO1jLTChiTn0itUDsIiGt4e8B0FM3tHsKtyI2f1avhWhV/JtwtG8yv
         2FzefdKQ9ytIdvSK/1ZHCNkC7BqJLlCuAuhK97j34hZkV+Yp1NaQol8i1V1tGKQBgvpO
         /Pzg==
X-Gm-Message-State: AOJu0Yyr7gUmTdeKMVK/yk9aob1ncui05x3bXdX2GvIWDBaLsoYTpdlF
	9T5Ju0mwbcxQpVjajI+qg+Zg/8gIsd7GCpZL3UI=
X-Google-Smtp-Source: AGHT+IFuxTCrF4XUkm+1a8ItMFYLIQg0wkKYhsS7rBtN1WqE0m4cKLGmZAsiGU3GHMDxm8ImH1ky8/bNoZgx/Gyp7A0=
X-Received: by 2002:a17:907:7e85:b0:9c3:b3cb:29ae with SMTP id
 qb5-20020a1709077e8500b009c3b3cb29aemr2534403ejc.47.1698877329651; Wed, 01
 Nov 2023 15:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-3-jolsa@kernel.org>
 <CAPhsuW7oOpsBhc=quoyzNgBFONdv=o67hHnieY1_kPyrZfLsQg@mail.gmail.com>
 <ZTvBhUP2uGqXAIRy@krava> <A7F70A35-B549-4162-9226-CAEF06E09BE0@fb.com>
In-Reply-To: <A7F70A35-B549-4162-9226-CAEF06E09BE0@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:21:58 -0700
Message-ID: <CAEf4BzaxSRhSVnM4FTynZf1ZtidrB_pLsQ6NDuzxNMchzoPuCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Store ref_ctr_offsets values in
 bpf_uprobe array
To: Song Liu <songliubraving@meta.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Martin Lau <kafai@meta.com>, 
	Yonghong Song <yhs@meta.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 7:24=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Oct 27, 2023, at 6:56=E2=80=AFAM, Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Thu, Oct 26, 2023 at 09:31:00AM -0700, Song Liu wrote:
> >> On Wed, Oct 25, 2023 at 1:24=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> w=
rote:
> >>>
> >>> We will need to return ref_ctr_offsets values through link_info
> >>> interface in following change, so we need to keep them around.
> >>>
> >>> Storing ref_ctr_offsets values directly into bpf_uprobe array.
> >>>
> >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>
> >> Acked-by: Song Liu <song@kernel.org>
> >>
> >> with one nitpick below.
> >>
> >>> ---
> >>> kernel/trace/bpf_trace.c | 14 +++-----------
> >>> 1 file changed, 3 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>> index df697c74d519..843b3846d3f8 100644
> >>> --- a/kernel/trace/bpf_trace.c
> >>> +++ b/kernel/trace/bpf_trace.c
> >>> @@ -3031,6 +3031,7 @@ struct bpf_uprobe_multi_link;
> >>> struct bpf_uprobe {
> >>>        struct bpf_uprobe_multi_link *link;
> >>>        loff_t offset;
> >>> +       unsigned long ref_ctr_offset;
> >>
> >> nit: s/unsigned long/loff_t/ ?
> >
> > hum, the single uprobe interface also keeps it as 'unsigned long'
> > in 'struct trace_uprobe' .. while uprobe code keeps both offset and
> > ref_ctr_offset values as loff_t
> >
> > is there any benefit by changing that to loff_t?
>
> We have "loff_t offset;" right above this line. So it is better to
> use same type for the two offsets.

but user is providing it as `unsigned long *` array, so instead of
relying on loff_t being the same as unsigned long, let's just keep the
original data type?

>
> Thanks,
> Song
>

