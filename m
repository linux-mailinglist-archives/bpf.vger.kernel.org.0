Return-Path: <bpf+bounces-15852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B297F8EEB
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 21:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE962814D4
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9782EB0E;
	Sat, 25 Nov 2023 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFnOov1o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B002D05C
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 20:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC216C433C8
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 20:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700944785;
	bh=Ilg98n8WjAW4FhP9VVOuts2vPXDA+pryxkf/R/kQrvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SFnOov1o2tZCEg1uRvpvp2wf6QxifEla+42Sy+2kOpse2aU7l0wTpaW+WM1/NES9C
	 i9DzjM/KN9py1NTVX2tlEVNlhM1XHofpV49ojYfDgY8WWTkaRiRdaNIov233X/bPTc
	 8TyGrQhn5DmTVkiVnNuSE62qh0YrtCUDhOIApOL+hyusP/gBkDISlYCA42H8QPrPbN
	 cC9ba7eLWFhwAg13ZE9c1HdIuWa43WFflHW92jPVWV/B3fhBIEuVc+FGb6NXW0jYf2
	 77/G3PTcIg+Bw0bGYHwAGDeU2ebsKTNPG7wdjZsq4n85nCr9RMTi5PYzGOilB/OZuX
	 SciEbwbvCjm4A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5079f6efd64so4051509e87.2
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 12:39:44 -0800 (PST)
X-Gm-Message-State: AOJu0YyRiHlMLRkqCXD9EiNY/s/zdVagrRImuZ3Sxr/YDGUb2MtVDDxN
	dv6nTPlExEq50Z3uMpbJVt4uLN+0DSP0mpAqPns=
X-Google-Smtp-Source: AGHT+IGvU5IJNaz+KUeo0CE1nMrxwsxhlucngPLwBdnkGPStBWHRaIfbxfRsfSjMlTVA7HPIzDicLGy++EUrM17k9aA=
X-Received: by 2002:a05:6512:280e:b0:507:b17a:709e with SMTP id
 cf14-20020a056512280e00b00507b17a709emr5747266lfb.1.1700944783213; Sat, 25
 Nov 2023 12:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122191816.5572-1-9erthalion6@gmail.com> <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>
 <20231124211631.ktwsigoafnnbhpyt@erthalion.local>
In-Reply-To: <20231124211631.ktwsigoafnnbhpyt@erthalion.local>
From: Song Liu <song@kernel.org>
Date: Sat, 25 Nov 2023 12:39:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4__NTrdz9tETEGCMHR5oOQDQMLXb+2jKdjotLta-ifog@mail.gmail.com>
Message-ID: <CAPhsuW4__NTrdz9tETEGCMHR5oOQDQMLXb+2jKdjotLta-ifog@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach rules
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 1:20=E2=80=AFPM Dmitry Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> > On Thu, Nov 23, 2023 at 11:24:34PM -0800, Song Liu wrote:
> > > Following the corresponding discussion [1], the reason for that is to
> > > avoid tracing progs call cycles without introducing more complex
> > > solutions. Relax "no same type" requirement to "no progs that are
> > > already an attach target themselves" for the tracing type. In this wa=
y
> > > only a standalone tracing program (without any other progs attached t=
o
> > > it) could be attached to another one, and no cycle could be formed. T=
o
> >
> > If prog B attached to prog A, and prog C attached to prog B, then we
> > detach B. At this point, can we re-attach B to A?
>
> Nope, with the proposed changes it still wouldn't be possible to
> reattach B to A (if we're talking about tracing progs of course),
> because this time B is an attachment target on its own.
>
> > > +       if (tgt_prog) {
> > > +               /* Bookkeeping for managing the prog attachment chain=
. */
> > > +               tgt_prog->aux->follower_cnt++;
> > > +               prog->aux->attach_depth =3D tgt_prog->aux->attach_dep=
th + 1;
> > > +       }
> > > +
> >
> > attach_depth is calculated at attach time, so...
> >
> > >                 struct bpf_prog_aux *aux =3D tgt_prog->aux;
> > >
> > > +               if (aux->attach_depth >=3D 32) {
> > > +                       bpf_log(log, "Target program attach depth is =
%d. Too large\n",
> > > +                                       aux->attach_depth);
> > > +                       return -EINVAL;
> > > +               }
> > > +
> >
> > (continue from above) attach_depth is always 0 at program load time, no=
?
>
> Right, it's going to be always 0 for the just loaded program -- but here
> in verifier we check attach_depth of the target program, which is
> calculated at some point before. Or were you asking about something else?

Actually, I was wrong. attach_depth is checked at BPF_LINK_CREATE. So
never mind about this one.

