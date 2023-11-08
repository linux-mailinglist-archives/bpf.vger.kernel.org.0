Return-Path: <bpf+bounces-14522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A491A7E5EE9
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 21:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F6B20CF2
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E337163;
	Wed,  8 Nov 2023 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilcP6UIr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B73715B
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 19:59:54 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837A2118
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 11:59:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9d242846194so21204866b.1
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 11:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699473593; x=1700078393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKkmBpSzij44ROCXU9yQRVpVo0Y9Fje6BhwymiJUQ+M=;
        b=ilcP6UIrVMPKWkVekX/U9QHwj2ot15ilD2Bdv31wEw93KBFJ66lH1x2bP8veV6wQkM
         pCOjZsaR9hQElbgt4EvnzS7HzWv5tfFRitYT1MTnsqodVvaLvNiagcEK2/okRJoQi9/+
         1793UD+znxELgN4aYL1NQARo75jBjaULRh58F+6mElvftY8PAjrKf2h9ZalZe3d+6kxi
         7VKkRFd86uqjqpYJmRD/v/uCauBXPJgVWQY2qk+ly6JpZH1oPgtRaNSaUPNA7DE8lV2H
         lbzBme8BSII0jiUFY6YVNB52BaiTpbXTfmRjaeANzQfiYyDRXecjZlLk73pJ2eyKM70r
         ykmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699473593; x=1700078393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKkmBpSzij44ROCXU9yQRVpVo0Y9Fje6BhwymiJUQ+M=;
        b=QTVXKjUkp8M0L2NekstEDQg08EOOAQFPUCcKPmE4qpdoiNKoJtnLL8AKAUwPAe7REX
         /e8jnepRI3JXslGQZSZXt/fTCAPjr8ydBir+EJLOcOH/du55erdEal/wO2s0bXZtvBK6
         rX1/7jdycQOYVeyvroG1aLK7Y2dPKBvUNzhY8ei4u1sOvAatQjhJ3YeEnj7XhNB94ZUV
         Ky4GRjVjoHc4WAuONbaaM9BrlVReHwCWvhREg+ty3kUTf7oB1Ij2q/0zhFiS8rM2uWHU
         rBtsbC6ylc15IVJZwJt5aclrVzd22c1O1F9erwL9W2bmpvkDh1zXCimdmT4shyc+FWcq
         D/sQ==
X-Gm-Message-State: AOJu0Yx745laTPVgX9E1YfFAR6U/jJVpmikKFEUxdpovxVkKcylfDHf5
	8qn4YyyUXLW4cHYJyx0RebP0pY+ghrpJsiErC38Dz/05
X-Google-Smtp-Source: AGHT+IGqvutvnm3tjhCvYhjS/rm2CCnegB3895Ayks4/dBUz10SUN5TvCVYNuqt5/Voz3B1A9MIxnT1Y4lA4VdrqiMY=
X-Received: by 2002:a17:907:969f:b0:9d1:6780:fb31 with SMTP id
 hd31-20020a170907969f00b009d16780fb31mr2475190ejc.38.1699473592471; Wed, 08
 Nov 2023 11:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-22-andrii@kernel.org>
 <a54dfe9cf85c41508acc7b31a399d7477e667a1d.camel@gmail.com>
In-Reply-To: <a54dfe9cf85c41508acc7b31a399d7477e667a1d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 Nov 2023 11:59:40 -0800
Message-ID: <CAEf4BzZrg2zmG-gMNU3GZOG-+8Y_1FhysCTnERrub7JRabSzTQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 21/23] selftests/bpf: adjust OP_EQ/OP_NE
 handling to use subranges for branch taken
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 10:22=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > Similar to kernel-side BPF verifier logic enhancements, use 32-bit
> > subrange knowledge for is_branch_taken() logic in reg_bounds selftests.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/reg_bounds.c     | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tool=
s/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index ac7354cfe139..330618cc12e7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > @@ -750,16 +750,27 @@ static int reg_state_branch_taken_op(enum num_t t=
, struct reg_state *x, struct r
> >               /* OP_EQ and OP_NE are sign-agnostic */
> >               enum num_t tu =3D t_unsigned(t);
> >               enum num_t ts =3D t_signed(t);
> > -             int br_u, br_s;
> > +             int br_u, br_s, br;
> >
> >               br_u =3D range_branch_taken_op(tu, x->r[tu], y->r[tu], op=
);
> >               br_s =3D range_branch_taken_op(ts, x->r[ts], y->r[ts], op=
);
> >
> >               if (br_u >=3D 0 && br_s >=3D 0 && br_u !=3D br_s)
> >                       ASSERT_FALSE(true, "branch taken inconsistency!\n=
");
> > -             if (br_u >=3D 0)
> > -                     return br_u;
> > -             return br_s;
> > +
> > +             /* if 64-bit ranges are indecisive, use 32-bit subranges =
to
> > +              * eliminate always/never taken branches, if possible
> > +              */
> > +             if (br_u =3D=3D -1 && (t =3D=3D U64 || t =3D=3D S64)) {
> > +                     br =3D range_branch_taken_op(U32, x->r[U32], y->r=
[U32], op);
> > +                     if (br !=3D -1)
> > +                             return br;
> > +                     br =3D range_branch_taken_op(S32, x->r[S32], y->r=
[S32], op);
> > +                     if (br !=3D -1)
> > +                             return br;
>
> I'm not sure that these two checks are consistent with kernel side.
> In kernel:
> - for BPF_JEQ we can derive "won't happen" from u32/s32 ranges;
> - for BPF_JNE we can derive "will happen" from u32/s32 ranges.
>
> But here we seem to accept "will happen" for OP_EQ, which does not
> seem right. E.g. it is possible to have inconclusive upper 32 bits and
> equal lower 32 bits. What am I missing?

I think you are right, I should take into account OP_EQ vs OP_NE here
and the specific value of br. Will update. Nice catch!

