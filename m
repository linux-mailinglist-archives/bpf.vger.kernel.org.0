Return-Path: <bpf+bounces-45649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36DA9D9E77
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8495C28380F
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546581D63F6;
	Tue, 26 Nov 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLgvL60p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60B8831
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653640; cv=none; b=LSZtIVB1JXnLwB9mJZdcegjiDGNckQtBvvV1iq735iGtlBxth0YjNJzfrsENAHKekNOR26ZT/ozddCJiQUQFosuVhNsCyQUlwXJcH5ppKc+kcyiTMQdssz1RaNXNNNahqF9OM32qkESQQ53hqbgGVv7prQM/TR4dFlFYf/4tk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653640; c=relaxed/simple;
	bh=s0JVKMaXoRzgZSHJcFghxhHcF7gRYLF2ySZhbN4SiAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dsc6XJmDE6VHkrMAstwxwFzu01Vdv7/7nkIXqPkyJIzBqmdO/P6Q7YTe0Ck2YiQWzUIMw6jYTcfjGR+CT9LKvnxAiaSHiPklYL1W/y2DYFdhA0fE/WRXUE4xi5toM6IxtnLrC7t+hvaaxCUJ94ZEAH1Zwu7qoEsn9wjRt6vdYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLgvL60p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349f160d62so24651995e9.2
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732653637; x=1733258437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plfSauly3IW4jmgTVUOyZlPD9fmE5Zl+rg+nRgZd0BE=;
        b=YLgvL60pPaUPio6u4NwHu0K554foCXswuqaC2GQCL8sNZLJdtwWqCuFOTZkvOUhoj+
         9KUpvtPXJZYqvPxesrCLLw0bUQMXMqqUhE8qHMFbmG/KSYjJe7RyaRCaKV5FBEWN7sDj
         l/Ih0XTiTSmalZ3OSSgtDL9SZHyn9/n+O+PWzTIcyqq/DUTQUr53/ig1de/ktajxjcN5
         TPcM7DUmYF+6cUG2Fid7+WKNXdPKtGDlX4DQfb6GSsBdL8EXEUFhmzYaf72cpc+fTK+x
         c0xcY8oxH+5oVk6P2QkrvtB2Lkm1GLQRd67U6i4Xtvz7Kwgw5SFH0AHcliYWd6hhRfl1
         ldpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732653637; x=1733258437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plfSauly3IW4jmgTVUOyZlPD9fmE5Zl+rg+nRgZd0BE=;
        b=ksWJtH8LFmAN+iWnKS8Vae7+uvZ1bXN+0yzfUXdaOVTwJE61RP6pXIH+6vnRNAmS7I
         MXRn/ZZ2B50gcW5smm0IbHHCaUeEgWnU3nFVPS64b1i+EGWab5aQVgO6xFcu6L8SjBhH
         b/lQqw1uZsbAJj945ocDbYGoGKBmnVEMVH+DLnenx09q1+kgJwG6IPnENeTUPR5AOW7l
         d1kkoWquG/EhXqo9mvfcngXh94BA/BBMuYasrjDC5tHnV657HtxI69WsEApctrxfE8XP
         lEwmmz6pb0IhepvzZx4hIFt8Kx+ffbBizU5TcWLHO7vZR2MREBal2KEVIvfL0vl4iAgq
         5nww==
X-Forwarded-Encrypted: i=1; AJvYcCXRkgadYBOpeXkWJloEsmTSXVRuPC/sYNjfPgZplCY+q1MsrYCu+e/DHOdy0WOMPOawbH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVm3g03CGq8Vatotwaajm6vLLIiTX7EDW5n+3GfWrnPZNbm0h
	Nryd+uLDuSpR/F34zm71B5IK5L7L3DCnxUeA8e9yZDy4rbuPKZvYBtV1rJ6/kZ45hM3ANCjKPa9
	Q3vqL9yZ/n1SIXVYdeXucFdK2l0TjGMui
X-Gm-Gg: ASbGncsx7myevoZ352FJ8z41uCNcqLbWoBcw/CvXcg11gR5vHkfn9jMICMeUvGtvDQD
	PEENVRU8R8djZebHi71F9eEPtRP4ip4JjkuXMw9/0v2PxbVM=
X-Google-Smtp-Source: AGHT+IHX1gxjfo5Bz3aqR70Ye2BBRiMZ6w1o4CH3j6NxKHeiqo4EDD4Hwh+5BrsTwP42p3psr6Dg9+F8npWWBrE2Qr4=
X-Received: by 2002:a05:6000:4802:b0:382:4460:49ad with SMTP id
 ffacd0b85a97d-385c6ec1167mr269532f8f.32.1732653637239; Tue, 26 Nov 2024
 12:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-4-aspsk@isovalent.com>
 <CAADnVQ+=SoVvmGizF8L78j=U+MWi1XnCQEdz9tJOxwYeKuZsJw@mail.gmail.com>
 <Z0X/8ufRfLOrEXfI@eis> <CAEf4BzYWWmiuUU7YizOVEC_qpuUsr8NQ5RcV9oLQYK5A7mgtWw@mail.gmail.com>
In-Reply-To: <CAEf4BzYWWmiuUU7YizOVEC_qpuUsr8NQ5RcV9oLQYK5A7mgtWw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Nov 2024 12:40:26 -0800
Message-ID: <CAADnVQLHBEN0mAuTMkFygcTb6H+bjKz3HR4uKN6s5CRsGM7qxg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for prog_load
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 10:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 26, 2024 at 9:27=E2=80=AFAM Anton Protopopov <aspsk@isovalent=
.com> wrote:
> >
> > On 24/11/25 05:38PM, Alexei Starovoitov wrote:
> > > On Tue, Nov 19, 2024 at 2:17=E2=80=AFAM Anton Protopopov <aspsk@isova=
lent.com> wrote:
> > > >
> > > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a s=
et
> > > > of file descriptors: maps or btfs. This field was introduced as a
> > > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > > present, indicates that the fd_array is a continuous array of the
> > > > corresponding length.
> > > >
> > > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > > bound to the program, as if it was used by the program. This
> > > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > > maps can be used by the verifier during the program load.
> > > >
> > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       |  10 ++++
> > > >  kernel/bpf/syscall.c           |   2 +-
> > > >  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-=
----
> > > >  tools/include/uapi/linux/bpf.h |  10 ++++
> > > >  4 files changed, 113 insertions(+), 15 deletions(-)
> > > >
>
> [...]
>
> > > > +/*
> > > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is =
given.  In
> > > > + * this case expect that every file descriptor in the array is eit=
her a map or
> > > > + * a BTF, or a hole (0). Everything else is considered to be trash=
.
> > > > + */
> > > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int =
fd)
> > > > +{
> > > > +       struct bpf_map *map;
> > > > +       CLASS(fd, f)(fd);
> > > > +       int ret;
> > > > +
> > > > +       map =3D __bpf_map_get(f);
> > > > +       if (!IS_ERR(map)) {
> > > > +               ret =3D add_used_map(env, map);
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > > +               return 0;
> > > > +
> > > > +       if (!fd)
> > > > +               return 0;
> > >
> > > This is not allowed in new apis.
> > > zero cannot be special.
> >
> > I thought that this is ok since I check for all possible valid FDs by t=
his
> > point: if fd=3D0 is a valid map or btf, then we will return it by this =
point.
> >
> > Why I wanted to keep 0 as a valid value, even if it is not pointing to =
any
> > map/btf is for case when, like in libbpf gen, fd_array is populated wit=
h map
> > fds starting from 0, and with btf fds from some offset, so in between t=
here may
> > be 0s. This is probably better to disallow this, and, if fd_array_cnt !=
=3D 0,
> > then to check if all [0...fd_array_cnt) elements are valid.
>
> If fd_array_cnt !=3D 0 we can define that fd_array isn't sparse anymore
> and every entry has to be valid. Let's do that.

Exactly.
libbpf gen_loader has a very simplistic implementation of
add_map_fd() and add_kfunc_btf_fd().
It leaves gaps only to keep implementation simple.
It can and probably should be changed to make it contiguous.

