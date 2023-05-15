Return-Path: <bpf+bounces-553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A847033E4
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF831C20C95
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D1FBEB;
	Mon, 15 May 2023 16:42:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B9FBEA
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:42:27 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B349C7
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:42:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so23812001a12.1
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684168942; x=1686760942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxOIAfioaPahJXcxGigF2yiKO4pDohBJo4OtYINqfn8=;
        b=exbkBY+h1KPDn/VX+xotwj1k6ZCDO4+MbnpWRc1qWroVM9AH/m+Am1M3BgitakjZWe
         hp6zK2gXeN+PLUN76qO2qDf9afLoLjGa6OCRTelbJBDqqPk6um1Zogsd6TQuakOv/03G
         0++hrbVvAf2SYFJCGzt5kLa7vtutP4e/4KRSrh5ijuGupIUM8Y5Bqr5dQS5acLWJV7GN
         TLy+/Pxi7ejRpAfw9tiLDB6WWC1MVA+tcxYJ7XDzQf689HrvO45DHbOP6eat30a/EiAD
         h3UYurXcYCKm/YTwdiTwrjWfRoreFVEWoEUCFMDuvWdY2/TWwIP05OFNuiycejxhfrab
         J8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684168942; x=1686760942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxOIAfioaPahJXcxGigF2yiKO4pDohBJo4OtYINqfn8=;
        b=Cye6soB5D+KwYCgpFflecUpPiZbFQ76goq4czoAwLenAsdXuFvSFy3XVz4MRpc+Qnr
         dAtAq3HMZVskthAXtSiVzLmnEyg3Gnu2jtIXouNPbiedqUItzdFxsSoZ9pNnGqsxx3g0
         UJi2PgxUADNV2uUCvCGp1fn8ARfYr/0GquXzU1fEF86g19QaYvdGDaIw0c+MRXtzs5FJ
         XrchMQFaPRIU3DxWtOMSOLHVjsLE6aitbdyzWNxvf7iZB5SrPXCkC/uiESvJT2TrE84U
         zqrSVSVWc+R4f2a58EbvoGREa9QUuchZ6FKFFcVcONFJRnVVWxbyn8s5sxj9HCXUSVdM
         qKQg==
X-Gm-Message-State: AC+VfDzwhLEfsfktO/54oxOr4Snflm+iN+MwqMyvfEe9VeHGJ0ovoJ3S
	/rvkCKqLts/DfdECI0215ds6BzIug9Wjiw8JpJY=
X-Google-Smtp-Source: ACHHUZ7JwKmQQwtff9oTfLybAJTLPxqPsjbirvIl+X4XVbBysGX6W77Ub/A/VSpY0v0YsWYwjpt2gcUXcCMqjFbmNbs=
X-Received: by 2002:a17:907:94d0:b0:96a:26af:b67e with SMTP id
 dn16-20020a17090794d000b0096a26afb67emr19644194ejc.2.1684168942195; Mon, 15
 May 2023 09:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-11-andrii@kernel.org>
 <CAADnVQJWbXvHqy4wdP3iC+UcewQNJbJ_rbGGLX5+sOUJ1+yeyg@mail.gmail.com>
In-Reply-To: <CAADnVQJWbXvHqy4wdP3iC+UcewQNJbJ_rbGGLX5+sOUJ1+yeyg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 May 2023 09:42:09 -0700
Message-ID: <CAEf4BzbxfvUQrjuo9XxP0TYm4F1Ek77RJ2qioLmAK5XczWLmvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded
 capabilities in BPF verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 11, 2023 at 9:21=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 2, 2023 at 4:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > @@ -18878,7 +18882,12 @@ int bpf_check(struct bpf_prog **prog, union bp=
f_attr *attr, bpfptr_t uattr, __u3
> >         env->prog =3D *prog;
> >         env->ops =3D bpf_verifier_ops[env->prog->type];
> >         env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
> > -       is_priv =3D bpf_capable();
> > +
> > +       env->allow_ptr_leaks =3D bpf_allow_ptr_leaks(*prog);
> > +       env->allow_uninit_stack =3D bpf_allow_uninit_stack(*prog);
> > +       env->bypass_spec_v1 =3D bpf_bypass_spec_v1(*prog);
> > +       env->bypass_spec_v4 =3D bpf_bypass_spec_v4(*prog);
> > +       env->bpf_capable =3D is_priv =3D (*prog)->aux->bpf_capable;
>
> Just remembered that moving all CAP* checks early
> (before they actually needed)
> might be problematic.
> See
> https://lore.kernel.org/all/20230511142535.732324-10-cgzones@googlemail.c=
om/
>
> This patch set is reducing the number of cap* checks which is
> a good thing from audit pov, but it calls them early before the cap
> is actually needed and that part is misleading for audit.
> I'm afraid we cannot do one big switch for all map types after bpf_capabl=
e.
> The bpf_capable for maps needs to be done on demand.
> For progs we should also do it on demand too.
> socket_filter and cg_skb should proceed without cap* checks.

Ok, fair enough. With BPF token approach this shouldn't be a big deal anywa=
ys.

Does patch #5 ("bpf: drop unnecessary bpf_capable() check in
BPF_MAP_FREEZE command") look good? I think it makes sense to land
either way, given any other map-related operation isn't privileged
once user has map FD. I'll send it separately.

