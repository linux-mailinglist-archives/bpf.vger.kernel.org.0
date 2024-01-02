Return-Path: <bpf+bounces-18778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA982205C
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 18:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7513283E9C
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264ED154BF;
	Tue,  2 Jan 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzoXn5+c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20515499;
	Tue,  2 Jan 2024 17:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE0DC433CC;
	Tue,  2 Jan 2024 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704216338;
	bh=Yk2WvWStKrh59dnz6K0iqdbE5KuKw/M+bXYxLDQ6XNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MzoXn5+czOwiwpIP4OmHi77HXaHlRjgNOzeyvMucJ8/29jK5+1Ylh64F4BqlVHSzE
	 0ToF+JcH3nlS0UH4M8Cja0L264d3WmHtxLSp716tXdFaTK9+mriccMiy7ZfWCnsNG3
	 lC0tG1kymlIXGHAVG09REvbrhwbNs1axKiNMcJ2jg+XISphn80bpqz03Htqblm2brN
	 G8Js3Jv3DgJm5QoFq6fcr3ZWUAnM5FboGXuk8WTnwq3yAet/KIHYHBzCVLvoVM5nZn
	 ItC+BWokeKYSGaY91jUiD5MrceBbydVgEgeW8VBTMju318sQQxr45mv+XvgUQajXz8
	 2DjysgDc61CAQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cce6c719caso44780761fa.2;
        Tue, 02 Jan 2024 09:25:37 -0800 (PST)
X-Gm-Message-State: AOJu0YzsP8jxtgTc+iMytXFDWdlRvPpv4tKHaO6fS6ZueY2zcYAR/s5/
	nwuSpOIqKMA1ndE7PY3jcATPnNwzpM079U01fRU=
X-Google-Smtp-Source: AGHT+IHfuPNVzd2ZDem2x58G2jeY3n6dgOHiGPMnVZyOqMge6oBAw/znigjup7FlcLmpGOW4aKT0WazvluZ3+xcqBh8=
X-Received: by 2002:a05:6512:3d01:b0:50e:76e0:a51f with SMTP id
 d1-20020a0565123d0100b0050e76e0a51fmr8185878lfv.100.1704216336217; Tue, 02
 Jan 2024 09:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de> <CAADnVQLq7RKV+RBJm02HwfXujaUwFXsD77BqJK6ZpLQ-BObCdA@mail.gmail.com>
 <dc0a1c9d-ceca-473d-9ad5-89b59e6af2e7@web.de>
In-Reply-To: <dc0a1c9d-ceca-473d-9ad5-89b59e6af2e7@web.de>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 09:25:24 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4J1+ZijLQ5d9+ZnNUHLCAG+0nwwcLkmGb9df-ioac7Nw@mail.gmail.com>
Message-ID: <CAPhsuW4J1+ZijLQ5d9+ZnNUHLCAG+0nwwcLkmGb9df-ioac7Nw@mail.gmail.com>
Subject: Re: [PATCH 0/5] bpf: Adjustments for four function implementations
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 1, 2024 at 1:10=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> >> A few update suggestions were taken into account
> >> from static source code analysis.
> >
> > Auto Nack.
> > Pls don't send such patches. You were told multiple
> > times that such kfree usage is fine.
>
> Some implementation details are improvable.
> Can you find an update step (like the following) helpful?
>
> [PATCH 2/5] bpf: Move an assignment for the variable =E2=80=9Cst_map=E2=
=80=9D in bpf_struct_ops_link_create()
> https://lore.kernel.org/bpf/ed2f5323-390f-4c9d-919d-df43ba1cad2b@web.de/

This change is not helpful at all. The use of "st_map" in current code as-i=
s
doesn't cause any confusion, i.e., it is always struct bpf_struct_ops_map *=
.
OTOH, this patch will make it harder for folks who use git-blame. Therefore=
,
it adds negative value to the code base.

Thanks,
Song

