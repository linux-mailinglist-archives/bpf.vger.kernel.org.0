Return-Path: <bpf+bounces-13918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6F7DECC7
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACB71C20ED6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDF7524C;
	Thu,  2 Nov 2023 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC4z5hZ/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF180523D
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1F9C433CD
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698905388;
	bh=TblzIDLypza3g6ycR/vbxulyfiXjkFNobs+94S5fM10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XC4z5hZ/tRMCrJ3ObeSTIprXRykwLCphz390UqAk838p3yPA/NYRocOabzfFpyaGV
	 FUY3Lk+GUTsM8w2PPAoTlKK9f4GFC4cHUyMDNrO4yV+l0GgohvAXR8NlctyFWMZJiv
	 0O4uuWkbXxUSkeBaQYT5MsgdzuWc66GLWskSuHdFPur+wIrZkf+N88kQlhSbQSN/Zl
	 preDQgf+swbMpdnMDAqo3ka5jinWwEksYhb+dYkQEwaTOoHlIYqjqTKfrH3MewyvuH
	 3jLVciW4gqKmu9U8axMyUP6NR6xI06u/9fIDWXPiYp9gSndTWqu9qv+Wqld/ukny/y
	 DChZXRoeaVIFw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50931355d48so645264e87.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 23:09:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YwxyoZ7qTMfuniwwRnuZw/JTCAbU/7x1skhQ6SNCpSCaQ6ZaW1Y
	Fzb1Y5MinW8JVoB88TY7yDJeNW+fhhu+JRtWXUs=
X-Google-Smtp-Source: AGHT+IG1gwNHXqEhZ61zlRvIzJxIIB8C63lcqLbpz7H/S7hS5sSK8hoSRPW10trvT2BtDth/7mba7U4ODLXjsFelx5g=
X-Received: by 2002:a05:6512:1081:b0:507:a5e7:724 with SMTP id
 j1-20020a056512108100b00507a5e70724mr15258731lfg.38.1698905386393; Wed, 01
 Nov 2023 23:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-4-song@kernel.org>
 <CAADnVQ+rqwPARuwkuRJLJSYN45m7vC1sLkiVX=BQbP0ho+3DJQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+rqwPARuwkuRJLJSYN45m7vC1sLkiVX=BQbP0ho+3DJQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 1 Nov 2023 23:09:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6r_XAyXZ89zEi=63w=Li0OcQRXBKLn8HXNqYiHPzPEtQ@mail.gmail.com>
Message-ID: <CAPhsuW6r_XAyXZ89zEi=63w=Li0OcQRXBKLn8HXNqYiHPzPEtQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 10:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> >
> > +2.2.5 __const_str Annotation
> > +----------------------------
> > +This annotation is used to indicate that the argument is a constant st=
ring.
> > +
> > +An example is given below::
> > +
> > +        __bpf_kfunc bpf_get_file_xattr(..., const char *name__const_st=
r, ...)
>
> After sleeping on it this still looks too verbose to me.
> 'const' is repeated back to back.
> Let's use __str suffix?

Yeah, the first const should be enough. Let's use __str.

Thanks,
Song

>
> > +                       ret =3D check_reg_const_str(env, reg, regno);
>
> I don't mind that helper has a more verbose name.

