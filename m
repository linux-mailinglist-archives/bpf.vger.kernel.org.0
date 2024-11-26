Return-Path: <bpf+bounces-45636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13F9D9DAC
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A4BB2B9DD
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15131DDC38;
	Tue, 26 Nov 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfo6Pw0i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46381DA614
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647115; cv=none; b=X0A+KU4o6XDVMngnsrc02AIQG+4JAyem/O/vIaz1F5D9pydzWHOczud67vt4MCC6Asd9ScIwaXKG2mlVOG7+qibT9yDsKJGMh6EGbYOSnV/l7dxFXBDLKYuPdZpMPKKs0pcTHqyR9HZRkLCX8UQ4XQMd4fOWpzep1NLPIvlgo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647115; c=relaxed/simple;
	bh=NoB7ZsHoLwQB0Ixz0GovEXcCYAZNkn7JOy7Tiw3OAkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwRkY0KcF2K12qQJ1ZDcZYCQbWZOjXa945cls4WU754KdLIR6PxB10PfdoCeRyOEvKUcpueMbe0dQFfhIFl7Pjr3lsiuex2hlWZIQXYDWYb/5aeyr9xVqOuJVF2QdN9skkPNT8yZEhJ2tFlu0+bLiXIfZsFtdJyFdtAgQCRcYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mfo6Pw0i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea1e605193so5050837a91.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732647113; x=1733251913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF7S4BnVEii5/RojOggyElXLrVnDDfMWNIEdNQwuocs=;
        b=Mfo6Pw0iQJrIuYGqFuVjdTGHEPxKjQOWoYAJqoOP3J+ioehOncjbecgaRRTUInG72/
         5ue5YPVAi0UHbm2v+5Njmc0bKB8CJqFocy/MWDx9tzkr0GCDrJq3o7CIacyNl3e8U8jz
         w6ffstVvQu4Z3+AM9GC+zmzTNkkNy4T3kbXG+YzGmOrpdaS0w27WATEI3m71DxA/nQBR
         m9kMxYBMjC3i7cQBnjIJhHs2fjBhd76020jSdGDw5Im7sxhZu2bEf13w5jDLfOn4tdRi
         LYBueLqsIe1/2uqGQRzngAPA9XWX6xNMixwpBxK+HoIcXfiQity79MwjpDDlettPFZ0g
         qDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732647113; x=1733251913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF7S4BnVEii5/RojOggyElXLrVnDDfMWNIEdNQwuocs=;
        b=JVrEHPxmRoHJrEzMaeCUcr9dbvNpdyyOt50pLZSthkUN9csl6RZqUf9Q8iqcy91IWS
         vxx+y016eJbqkTHic5py8JVa3pIcYW6LQNZbbYV9t38g0r0P6G5K9fk+E4UKdDXW5CA+
         DuWXY1cK5hjiiJ2GGlq05BnA075AAOQWZtyeU2kh3dQLTq0QKkralU7k4nqrBneBT/bC
         6HXoAnZJ4PZtreF7CtIAhbg5b3rzACoB9kihNk6bYa49ed15RizIEwTSLT6LT6X1YQSk
         qkd7PRnBigMu9XCWMcT+4dzTj/zpJpNFRGtW61eep7ctahylxYWH3+w4Sibzrj4dm0vN
         /6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYNOO2MukV98bmVXNfEAkRRH3RmzFPx4x1F4P/GYSw2h56FB6boKPSZ5oPVx+dbsWKqCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcA5nUMMe/OaEywR2p4Kz4YO9kHop+CxaMf34frG7F4okET62
	rPJm+GW2uLvj7aUQ7ON33tU9Dj73cAhO6s8/5vsAmiAU2wyFAubf69RfQ0XnUvJqpKwETxu1Hxc
	lWntZykR8AantAMdNJB3bbQ+k5S8onw==
X-Gm-Gg: ASbGncvcg1klb+B7aH5OUtG+vIDhD9OC+2imy3CRoHFhrKAs23AyjTExYZ2dvCgsHSD
	JRlkzi7YA9TtGP6rmjnsQmJT1b/T0dZhGWFLQ0SvcH+KlY+A=
X-Google-Smtp-Source: AGHT+IFmLu1Z+tGoFvl4DAI19IeHC2DBF+V1qgImlLtZ2KBy8e3oTXFNQebSO7YZO/iwnQnc1SHeJdh9XKFJ/MDAKec=
X-Received: by 2002:a17:90b:3851:b0:2ea:5ff8:f325 with SMTP id
 98e67ed59e1d1-2ee08e5e394mr458846a91.8.1732647112959; Tue, 26 Nov 2024
 10:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-4-aspsk@isovalent.com>
 <CAADnVQ+=SoVvmGizF8L78j=U+MWi1XnCQEdz9tJOxwYeKuZsJw@mail.gmail.com> <Z0X/8ufRfLOrEXfI@eis>
In-Reply-To: <Z0X/8ufRfLOrEXfI@eis>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 10:51:40 -0800
Message-ID: <CAEf4BzYWWmiuUU7YizOVEC_qpuUsr8NQ5RcV9oLQYK5A7mgtWw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:27=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On 24/11/25 05:38PM, Alexei Starovoitov wrote:
> > On Tue, Nov 19, 2024 at 2:17=E2=80=AFAM Anton Protopopov <aspsk@isovale=
nt.com> wrote:
> > >
> > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > > of file descriptors: maps or btfs. This field was introduced as a
> > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > present, indicates that the fd_array is a continuous array of the
> > > corresponding length.
> > >
> > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > bound to the program, as if it was used by the program. This
> > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > maps can be used by the verifier during the program load.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  include/uapi/linux/bpf.h       |  10 ++++
> > >  kernel/bpf/syscall.c           |   2 +-
> > >  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++---=
--
> > >  tools/include/uapi/linux/bpf.h |  10 ++++
> > >  4 files changed, 113 insertions(+), 15 deletions(-)
> > >

[...]

> > > +/*
> > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is gi=
ven.  In
> > > + * this case expect that every file descriptor in the array is eithe=
r a map or
> > > + * a BTF, or a hole (0). Everything else is considered to be trash.
> > > + */
> > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd=
)
> > > +{
> > > +       struct bpf_map *map;
> > > +       CLASS(fd, f)(fd);
> > > +       int ret;
> > > +
> > > +       map =3D __bpf_map_get(f);
> > > +       if (!IS_ERR(map)) {
> > > +               ret =3D add_used_map(env, map);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +               return 0;
> > > +       }
> > > +
> > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > +               return 0;
> > > +
> > > +       if (!fd)
> > > +               return 0;
> >
> > This is not allowed in new apis.
> > zero cannot be special.
>
> I thought that this is ok since I check for all possible valid FDs by thi=
s
> point: if fd=3D0 is a valid map or btf, then we will return it by this po=
int.
>
> Why I wanted to keep 0 as a valid value, even if it is not pointing to an=
y
> map/btf is for case when, like in libbpf gen, fd_array is populated with =
map
> fds starting from 0, and with btf fds from some offset, so in between the=
re may
> be 0s. This is probably better to disallow this, and, if fd_array_cnt !=
=3D 0,
> then to check if all [0...fd_array_cnt) elements are valid.

If fd_array_cnt !=3D 0 we can define that fd_array isn't sparse anymore
and every entry has to be valid. Let's do that.

>
> > > +
> > > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n=
", fd);
> > > +       return PTR_ERR(map);
> > > +}
> > > +
> > > +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf=
_attr *attr, bpfptr_t uattr)
> >
> > What an odd name... why is 'env_' there?
>

[...]

> > I don't get this feature.
> > Why bother copying and checking for validity?
> > What does it buy ?
>
> So, the main reason for this whole change is to allow unrelated maps, whi=
ch
> aren't referenced by a program directly, to be noticed and available duri=
ng the
> verification. Thus, I want to go through the array here and add them to
> used_maps. (In a consequent patch, "instuction sets" maps are treated
> additionally at this point as well.)
>
> The reason to discard that copy here was that "old api" when fd_array_cnt=
 is 0
> is still valid and in this case we can't copy fd_array in full. Later dur=
ing
> the verification fd_array elements are accessed individually by copying f=
rom
> bpfptr. I thought that freeing this copy here is more readable than to ad=
d
> a check at every such occasion.

I think Alexei meant why you need to make an entire copy of fd_array,
if you can just read one element at a time (still with
copy_from_bpfptr_offset()), validate/add map/btf from that FD, and
move to the next element. No need to make a copy of an array.

>
> > pw-bot: cr
>

