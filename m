Return-Path: <bpf+bounces-10061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B767A0B49
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F37CB20CEB
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C1262A9;
	Thu, 14 Sep 2023 17:06:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2DD241E8
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 17:06:00 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E631FEB
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 10:05:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26fc9e49859so1015558a91.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694711159; x=1695315959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACnGDvO4UdzljeQyTb/RRh5LQy8tu22rKTkwltqG0Ho=;
        b=A+98zkLrLIqFQRG2qtHyYhTf1K08tU35To5JZaBVdzpIsqq/+OPOS1QjFPrdwxyFe6
         gNmzJrhg94ed5xijOUkSHk3tmYdLm+X0XknXINKL32Nu7PV45hx7TaBvXE4e88NQk3U8
         rIsIQ7bqVzQlxH0zG/M17far7Z1nbY9i4O3YPBDeisq4Uu/Y90FiGTTPzAiBcNbQ3WLJ
         9GfVGVeuZj3NGLnLPpSN73UDfBt8zo3r4jOJQyWt4hcHNMnnYRQh2z0fzeDRu+BWAzL+
         Qp7VWcXjHp2qWrwEVI/nfykM10cEgHSvOG6HbBFNKWxbjgi4UigoDqOMsrLBR1t3usL4
         Jc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694711159; x=1695315959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACnGDvO4UdzljeQyTb/RRh5LQy8tu22rKTkwltqG0Ho=;
        b=SdJN1VEDiYf0FEnwbM2Pn9HEgpDhH8XGYwBwXjAtmbijjuDAoii+wztZ+8Pgf4jj3h
         LB37/Ln7LjFOOJYjuBGzjcAGFzw2jS/gNP8vJhtT2DSHOXCVi2YPV37lThT1Pd2InBiv
         rNYLYe6alVNGcW+aFIuFQEo3zI/SsknN+ZC4sQaPvtU0bc0Vd8CEY1FWKEDK96xsSzBN
         rb3kEakcFBsqnb7Aj3qe4S6dHNyJT05R/K1+UahvNb3rY8L9HRxjFCueIkKduFx2wC5g
         bNtKUIx63i6yOogTfoePVUjbYPnfy613CLK50B/+Gih1fRnH7bAdlMShRgE+thzOfRt2
         4QrA==
X-Gm-Message-State: AOJu0YxxnYnSkMRKPz3kaZYCPwMT+EFI21j9yfl0TAxdbSk50iC2HxSy
	ZB3y8BPP+ymo7Xl7SZ4+HGFxAMtMSUVN+ZzAGgvdzw==
X-Google-Smtp-Source: AGHT+IE3SeljEZBVjgSPFmQYSU3VIvBk/LO658+eF0c5YErcCOq6SFiu9VBpZHQowXDraXVuPEsTNvPjl3W77446uAI=
X-Received: by 2002:a17:90a:bc89:b0:274:7b85:eae6 with SMTP id
 x9-20020a17090abc8900b002747b85eae6mr1570581pjr.34.1694711158726; Thu, 14 Sep
 2023 10:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914083716.57443-1-larysa.zaremba@intel.com>
 <ZQM1BUzcZQtXusA3@google.com> <ZQM5kt8qHKUH0Iob@lincoln>
In-Reply-To: <ZQM5kt8qHKUH0Iob@lincoln>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 14 Sep 2023 10:05:47 -0700
Message-ID: <CAKH8qBuw68AixQabgP5wNfAQBcc0RuVNEyV9rf9vgVi__c4Y9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags together
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:55=E2=80=AFAM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Thu, Sep 14, 2023 at 09:29:57AM -0700, Stanislav Fomichev wrote:
> > On 09/14, Larysa Zaremba wrote:
> > > There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX=
 hints
> > > cannot coexist in a single program.
> > >
> > > Allow those features to be used together by modifying the flags condi=
tions.
> > >
> > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=3DOKMdsxEkyML36VsAuZp=
crsXcyqjdKXSJCBq=3DQ@mail.gmail.com/
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  kernel/bpf/offload.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > index ee35f33a96d1..43aded96c79b 100644
> > > --- a/kernel/bpf/offload.c
> > > +++ b/kernel/bpf/offload.c
> > > @@ -232,7 +232,11 @@ int bpf_prog_dev_bound_init(struct bpf_prog *pro=
g, union bpf_attr *attr)
> > >         attr->prog_type !=3D BPF_PROG_TYPE_XDP)
> > >             return -EINVAL;
> > >
> > > -   if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> > > +   if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS=
_FRAGS))
> > > +           return -EINVAL;
> > > +
> >
> > [..]
> >
> > > +   if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> > > +       !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
> > >             return -EINVAL;
> >
> > Any reason we have 'attr->prog_flags & BPF_F_XDP_HAS_FRAGS' part here?
> > Seems like doing '!(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)' shoul=
d
> > be enough, right? We only want to bail out here when BPF_F_XDP_DEV_BOUN=
D_ONLY
> > is not set and we don't really care whether BPF_F_XDP_HAS_FRAGS is set
> > or not at this point.
>
> If !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY) at this point, program =
could
> be requesting offload.
>
> Now I have thought about those conditions once more and they could be red=
uced to
> this:
>
> if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY) &&
>     attr->prog_flags !=3D (BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS=
))
>         return -EINVAL;
>
> What do you think?

Ah, so this check is here to protect against the mbuf+offloaded
combination? (looking at that other thread with Maciej)
Let's keep your current way with two separate checks, but let's add
your "/* Frags are allowed only if program is dev-bound-only, but not
if it is requesting
bpf offload. */" as a comment to the second check?

