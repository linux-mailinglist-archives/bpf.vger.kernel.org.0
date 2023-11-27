Return-Path: <bpf+bounces-15960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4787FA907
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3454281737
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A13158A;
	Mon, 27 Nov 2023 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYE0LsE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE219B
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:39:49 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so55690291fa.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701110387; x=1701715187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ptgqBPLTLHByvbrwMBObKBQ+dalmnXm+Tu/Tl4Uxc0=;
        b=UYE0LsE9NHO4aMSyYzS5sx7rCg/+6LAQ60X8eMABjgH2uk61VURaoF6XuWukitx8Kz
         oXqHXkU+ayGtDnNSFlEP7hCIhuAlObG5LkBKIENInpua5XlIInltrbGqQ15jvqMPniDo
         IOLcKQuB2S6JHibIBsE0rN3Wj+01ROI4y+MXOPcs4F1RJ6xgNZT8zo9L9WP8dAF+WAOH
         WzvhQoa5bZLR20LUzk6Eq3YH5TOcAsCZbcvR48AfMRmWWTfNO+RE0wX85iTz2TQP/o5l
         37tUMhIE2+BkH3+PPWXolFKowOf95SQ441C309AIRTZ4WeW/UtjQRYuS3q3AFFZAB7Y5
         Df1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701110387; x=1701715187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ptgqBPLTLHByvbrwMBObKBQ+dalmnXm+Tu/Tl4Uxc0=;
        b=Jvw+LEvw4pXd/4a/FdbvH45WJIricj4JfMaTUF+D4K0GoEz6hXu3qC3N/1XztZ/uPQ
         DPAXIQtd5sZD/9uR09nYWbeuvtc5LfvA3yjdGN4Sjp8chiOASrO/dBIvaHfAUm8WG7DQ
         v27p5H4SforOWza5kw9hlFzT9yKg4a326+BbGvBIYvBwqmqJ24xmlWxwbvepDFc178XM
         CgCq9lpB2A/+tnIAha5sIfwV6n8vM3B3brYWijGSjEtpiddYGULfa6Uiii1BoapODp0k
         FQMWRwPvgkWJx11kYfFzyw1PYyieE4BwfyevPuJGCPrFCo/iephciKR81XVpMSyW85B9
         GpFQ==
X-Gm-Message-State: AOJu0YzZE3ayRcF2yPfkBSM5QVVMvOHKqVC8njxA3lAZ9201y0ozDrBt
	Yoo4a5JwIiH0Yl+UP1lEUmu2mbVj32izSw199xc=
X-Google-Smtp-Source: AGHT+IExVLrUxugefwJ63tSgBChXFSCRoxZImybH5sm/NMokzP3pmT8iV8nTuSaqmOGMuYJ1PTfMXHMuw++nkToHvh0=
X-Received: by 2002:a2e:3502:0:b0:2c8:881c:28e3 with SMTP id
 z2-20020a2e3502000000b002c8881c28e3mr8228190ljz.23.1701110387193; Mon, 27 Nov
 2023 10:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116194236.1345035-1-chantr4@gmail.com> <20231116194236.1345035-2-chantr4@gmail.com>
 <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
 <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com> <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
 <CAEf4BzZMDfBao58ynxAKys3bB=A+SRLORz65Ce4ron60m=NojQ@mail.gmail.com> <0ab6a40e-c1a7-4313-ad01-1d2d86835fb3@isovalent.com>
In-Reply-To: <0ab6a40e-c1a7-4313-ad01-1d2d86835fb3@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Nov 2023 10:39:34 -0800
Message-ID: <CAEf4Bzam5iYxoBeJgLO+cb0LuR2=LqN18OwVDxZwRBqfKVpBMA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Manu Bretelle <chantr4@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 9:07=E2=80=AFAM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-11-21 19:50 UTC+0000 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Tue, Nov 21, 2023 at 8:42=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue, Nov 21, 2023 at 8:26=E2=80=AFAM Quentin Monnet <quentin@isoval=
ent.com> wrote:
> >>>
> >>>>
> >>>> Does it have to leave in the kernel tree?
> >>>> We have bpftool on github, maybe it can be there?
> >>>> Do you want to run bpftool tester as part of BPF CI and that's why
> >>>> you want it to be in the kernel tree?
> >>>
> >>> It doesn't _have_ to be in the kernel tree, although it's a nice plac=
e
> >>> where to have it. We have bpftool on GitHub, but the CI that runs the=
re
> >>> is triggered only when syncing the mirror to check that mirroring is =
not
> >>> broken, so after new patches are applied to bpf-next. If we want this=
 on
> >>> GitHub, we would rather target the BPF CI infra.
> >>>
> >>> A nice point of having it in the repo would be the ability to add tes=
ts
> >>> at the same time as we add features in bpftool, of course.
> >>
> >> Sounds nice in theory, but in practice that would mean that
> >> every bpftool developer adding a new feature would need to learn rust
> >> to add a corresponding test?
> >> I suspect devs might object to such a requirement.
> >> If tester and bpftool are not sync then they can be in separate repos.
> >
> > I'm also wondering what Rust and libbpf-rs dependency adds here? It
> > feels like bash+jq or Python script should be able to "drive" bpftool
> > CLI and validate output, no?
>
> As I understand, one advantage is to get an easy way to tap into
> libbpf's functions to load the objects we need in order to test the
> different bpftool features. There are a number of program/map types that
> we just cannot load with bpftool at this time, so we need to set up the
> objects we need with another loader. Libbpf-rs allows to do that, and
> the "cargo test" infra seems like a convenient way to focus on the tests
> only. Bash+jq wouldn't allow to load objects unsupported by bpftool, for
> example.

Can we use veristat to load BPF object files? we might need some
option to auto-pin programs in some directory or something to keep
them live long enough, I suppose, but it's totally in our control.

>
> Manu, did you have other reasons in mind?

