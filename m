Return-Path: <bpf+bounces-40077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419497C34B
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 06:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCA81C2150A
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 04:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF91803E;
	Thu, 19 Sep 2024 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKDGsZZI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39BB28EA;
	Thu, 19 Sep 2024 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726719672; cv=none; b=i0iz4YpEJA5V42Q7/ZgXV6BX9oCZcYLK//M2TWobRaL5sEvHZCcrZ+7myRPZQfLc4uOtXwQRNcq57joPY4YeJYdh1pV1bvJjc7/+GJKi6JZLZOUpYSLgAMMSEt+dYeGY4c6pljI9Jh2z1ecxfVMrW/ra7+2J1o6DTeemxFXT+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726719672; c=relaxed/simple;
	bh=8AIciPGsz4JbiYumMdGacVtdecMVW1sg5pCblgyNQLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxxHG7yYJr+6QLXf/cum2WltzQEbkVnLixycYh/M9NSO2UeqFKF1K6wUiKSjQzbM8NcvnEvAW5htqpJ/oGZFvNkGJvkW2/IIRk1IyWbD4uimkpisxgydoTJGxW79vuJHogNM1j3WpLYIeoN+KaS6Vo5XpJ3faDXShw5ojHlRmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKDGsZZI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so310244a91.1;
        Wed, 18 Sep 2024 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726719670; x=1727324470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c35lJhVYOqRiofOwrBye7t56BCz2AoWDtRPEI/zarqE=;
        b=cKDGsZZI4pHAmDpFi5HgWlc6U7Vm4OIA7NbKLd61NUYyWzfXhaAxw17zRG+5AiBsT3
         G/ykhVDXAR/l8oHf5bguc7NpJxrQv70DeUS4DbHrer/+bnyEgX0DOTtoINBSItbF599b
         M3rN8igv/NqqqW0aKJnXt8BLTmqBedAu5Kx50oCuv640bfUDkpaAvl0Epct/2owkHv2n
         txrGZQ1suGchPSMUvvFzl3vs2s00pJWhXplL8nta15XKQjJVIWpxdPerNdwQHf/l6lnT
         f59Pw7ot5boe4a+Vq4WfdmqZfFVdVBprTl6WeF9C9AVjG0oTq4a/1LnwwNk7rQiFOFJH
         3b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726719670; x=1727324470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c35lJhVYOqRiofOwrBye7t56BCz2AoWDtRPEI/zarqE=;
        b=aplfHHQD2rTQtApxqyFG7My1Z39Y8GfCNX3YFTYGyvzMWESuC1CiAc2E2YCveEsDov
         GzHG/u3c0a8LgzchiXJ+PHnN0AcpGtOT5tFRC9MxJbw4oeW0oC+mDrRwwLONhy+7IudP
         bhFBZ8lubIaZp6srMWvIf3tBbr3wyhbGqh1ghxuVfMmTyjNtXohAoYse50gvx8w5fB8S
         0kDrCHRbJk+JJBZ1DNj1QkVCTY6UYi94e316wqubnMORjo71u5naAhJcC6HkTGKTvC+t
         ISXdoHDcmJkUz5K/PFWFrokQDlN8OQOBbyMJQFAhEc0NSCDG0jE9HKoT9eAuC9IB4iUe
         2PIw==
X-Forwarded-Encrypted: i=1; AJvYcCUp64WZ9AmLp+F99AeYAGWswxCY1tYXmkbFiWtUe7v9WcBwXrJV5X2USgwnsd9hRtYJQNzymRfrfJtTzkI3@vger.kernel.org, AJvYcCXColgN+N4ku1d48h5DMVi3Q5y7tSRtX8kbn3vuihn+kZ+EJ8bwj4N3Lr5Mdb6PUX3/Uws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQg3Oar4YDfpMzAnMrrlEZsT9BVvSmkoigHLF4P5TDhAWgF+jQ
	AphpmdOfXsRunZpTfMGlQWWLnSS8HBxKg7fwOq7XpLb5RDDVyzcLuF3pXQyYl0Lh3whXGy7R2el
	WjRmGxXh3tSUKAwm/l418ELISkkQ=
X-Google-Smtp-Source: AGHT+IGBorv9TBHVbxdie5vLEjrQlqrhYXFjsT14NDOdl0/Fa6Bkt8ZRcZm8nVutPrR/EvnEiNo1XNFztj6hQN02fPU=
X-Received: by 2002:a17:90b:3616:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2db9ffcab27mr25909340a91.15.1726719670045; Wed, 18 Sep 2024
 21:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914154040.276933-1-chen.dylane@gmail.com> <8bcac2c4-80fc-4807-9e77-5dc253b10568@gmail.com>
In-Reply-To: <8bcac2c4-80fc-4807-9e77-5dc253b10568@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Sep 2024 06:20:57 +0200
Message-ID: <CAEf4BzZpdMx7ZV6V6pJKLkq3BtdRrqj8Vo09YVSN5YApNtCa3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: Fix expected_attach_type set when
 kernel not support
To: Tao Chen <chen.dylane@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 4:05=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> =E5=9C=A8 2024/9/14 23:40, Tao Chen =E5=86=99=E9=81=93:
> > The commit "5902da6d8a52" set expected_attach_type again with
> > field of bpf_program after libpf_prepare_prog_load, which makes
> > expected_attach_type =3D 0 no sense when kenrel not support the
> > attach_type feature, so fix it.
> >
> > Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_prog=
ram__attach_usdt")
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > Change list:
> > - v2 -> v3:
> >      - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggedted by
> >        Andrri
> > - v1 -> v2:
> >      - restore the original initialization way suggested by Jiri
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 219facd0e66e..a78e24ff354b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct bpf_p=
rogram *prog,
> >               opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> >
> >       /* special check for usdt to use uprobe_multi link */
> > -     if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MU=
LTI_LINK))
> > +     if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MU=
LTI_LINK)) {
> > +             /* for BPF_TRACE_KPROBE_MULTI, user might want to query e=
xected_attach_type
> > +              * in prog, and expected_attach_type we set in kenrel is =
from opts, so we
> > +              * update both.
> > +              */
> >               prog->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;
> > +             opts->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;
> > +     }
> >
> >       if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
> >               int btf_obj_fd =3D 0, btf_type_id =3D 0, err;
> > @@ -7443,6 +7449,7 @@ static int bpf_object_load_prog(struct bpf_object=
 *obj, struct bpf_program *prog
> >       load_attr.attach_btf_id =3D prog->attach_btf_id;
> >       load_attr.kern_version =3D kern_version;
> >       load_attr.prog_ifindex =3D prog->prog_ifindex;
> > +     load_attr.expected_attach_type =3D prog->expected_attach_type;
> >
> >       /* specify func_info/line_info only if kernel supports them */
> >       if (obj->btf && btf__fd(obj->btf) >=3D 0 && kernel_supports(obj, =
FEAT_BTF_FUNC)) {
> > @@ -7474,9 +7481,6 @@ static int bpf_object_load_prog(struct bpf_object=
 *obj, struct bpf_program *prog
> >               insns_cnt =3D prog->insns_cnt;
> >       }
> >
> > -     /* allow prog_prepare_load_fn to change expected_attach_type */
> > -     load_attr.expected_attach_type =3D prog->expected_attach_type;
> > -
> >       if (obj->gen_loader) {
> >               bpf_gen__prog_load(obj->gen_loader, prog->type, prog->nam=
e,
> >                                  license, insns, insns_cnt, &load_attr,
>
> Hi, guys, please review this patch again, the previous versions:

It looks good, but bpf-next is closed right now due to merge window.
I'll apply when the tree is open again.

> v1:
> https://lore.kernel.org/bpf/20240913121627.153898-1-chen.dylane@gmail.com=
/
> v2:
> https://lore.kernel.org/bpf/20240913164355.176021-1-chen.dylane@gmail.com=
/
>
> --
> Best Regards
> Dylane Chen

