Return-Path: <bpf+bounces-49499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2C5A19759
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943577A4EC1
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631321517D;
	Wed, 22 Jan 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+oEs/Py"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA421369B4;
	Wed, 22 Jan 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566233; cv=none; b=HN5qX9PQHrpnto5/hjSgaSLa8eQlBPKT5G961pAkPlHXtyk1FGHit/DAshxtUri2L0Fx5bvTM4/ELYgwE9OSjZjHFwFwpFfwem0zgcAulppXZS52NfV19uKt0QSNzKnWrmJ9fYQA9LcyukOxeprfR1pVocEI5zCIA5uiW1rQLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566233; c=relaxed/simple;
	bh=o1SE3o3NcZUVY/hmBRha3xtrviGaumM9KPn/dAGuTFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPALcrurHa+hSdXZBvfFMCXO5VwzZAi6mJapAvxu2LhGlKau7NEESWeD6OYsEu9KyvOMEkSeewRI6M5BqSFaDpeAGB2CtoJv6MDjEUBwilBtcgucmsf7x1G9B9eF6g2Rpsr/3kLwDjPt4/440jX7zlHqb+Wb4DNel/7JwwhhFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+oEs/Py; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so99537a91.0;
        Wed, 22 Jan 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737566231; x=1738171031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFCVPvzzCocOSj8lSB1mfBdT82DT1p+MPx9OjvYvaR0=;
        b=F+oEs/Pyob0UjEyYbUJ7b0LWFxqk0BsDzJMcmqoEvmieb+0AUBSatVQVh6GQHDzDB4
         O1e9c+9bqlyy3wgtgvwIGGfdZ900KN7D1U6KnqUiu1dc1kopCO4eoxtTdyrMYgtWo9nl
         NkYVinvhuggjBYoqHGMC1JVxfE9zxlh5mHx2fxdLH8m0G1pa2gbBiYBefP+1FYeeiHM1
         U31OVehyRDCySW7yahEFHa14Zsd/rWHZF2p6hNk2q8nlsQ3lBncF+2/YE3J6fXMja5r8
         byImxHe5tuEoWtO+ODy5VVp9KXMOw/AA84KHZkpAP9fD3ycVPv1R3fyvbVs7ewiCWSDb
         5xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737566231; x=1738171031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFCVPvzzCocOSj8lSB1mfBdT82DT1p+MPx9OjvYvaR0=;
        b=WWbeUQpwAebWFAUH5ecySh9ANcKqrVa0jI407PAJXruUgdZRPWRNxu0PlgchR4gaOB
         ykNXkaf3LJIjDHeuJDCJy4PHNT71kFIKDbHqI1w9if4QAhfgIHRVphKMAWeMlZJbrYPy
         zetKRAtXY/fs2L4+DPEVwBA3I+53q1GR0zpvcWCvklEic+n3A7VmSIQzvZ+Hvs78PQrk
         lKk1DZfMYnM6p1p2JfJmc59qOxc89pG3xNwmu8uYuJfZ7uV5pJewT8K/xtqdztDjS4CJ
         D5s06k4qe1UVxbN5BpOnYcsSvJJbqfolXOjryCziJoyVkrNEi42AxzUglClucWfFGAdy
         ATkA==
X-Forwarded-Encrypted: i=1; AJvYcCUx/rankgafe8k97rzEUzy70NfVq8tio0S6kYkwkvWUzN+9nUukq7fX+RurkAXdy98PAfs=@vger.kernel.org, AJvYcCVKCN8zfFOOhjOBqyVavqpESeO87ivID2h3q4rpYBIfdvs04g2qCykzeWYS/nzcH4YbhXIJd9TzoJafmg==@vger.kernel.org, AJvYcCVKwfF6bG9kgmQWMdhl3YE6YRaLq9QLEq1PLkJLvvvJqcl3hJ9+NJO5h3cHTiw/4DvpVd7zp3TV@vger.kernel.org, AJvYcCXW4dveTUXyhF3G3PYBETze2Ch9HzEWgjuiOu8ZOB5j00p39D6o4r9tST0XeqCC5pWKr6UD/GzAHzBnow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK98E6JI84Op7m3lc6IXSYTOz9Ah8L4ERf46b6lvxeh/0OxikM
	z3m4U65bhX5ZO/fVIBPmmogkaiQFOe9xvL7hZ4IVff65Jt6+jO/jchyM2ECjEUkMi23B46tAkkR
	xKv2ikDWLA0cFZlUXXerVfm2gXfU=
X-Gm-Gg: ASbGncu2KqbgZWpWTAPRoFyyOpHc5N8AQJg3W/tidYBeAtHNWZ7e2VQ1q65U709SI3o
	h6aSKBiLZv2Va9mDtLMZldDzv2zEXBVP/I292rO9QKX6KejewKEzCVOz7AfvRELygKJQ=
X-Google-Smtp-Source: AGHT+IHTvHTC++TojYxC/UgWgVuinh02AQWbyRQC6b5Z9w3BtCafMdo3/RyX2E4nRXqJ2H6wOGvd5dmMFKUFBshJkuA=
X-Received: by 2002:a05:6a00:2184:b0:72a:8cc8:34aa with SMTP id
 d2e1a72fcca58-72daf88b65dmr33962621b3a.0.1737566230650; Wed, 22 Jan 2025
 09:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-5-alibuda@linux.alibaba.com> <CAEf4BzZvxqiQ2J1XQMm-ZDBjSsmtJJk6-_RbexPk9vWxAO=ksw@mail.gmail.com>
 <20250122024327.GA81479@j66a10360.sqa.eu95>
In-Reply-To: <20250122024327.GA81479@j66a10360.sqa.eu95>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Jan 2025 09:16:58 -0800
X-Gm-Features: AbW1kvZiku1BiieaalyxZJhB_Vt4Hw2HwinTvpys0Vs7Ip41IhYFnB8AF6RUhzc
Message-ID: <CAEf4Bzabc+83abj7gP0h0sCxp-Bajqhm0bdAyn1Gn5bNi5nNXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com, 
	yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:43=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> On Fri, Jan 17, 2025 at 10:36:50AM -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 15, 2025 at 11:45=E2=80=AFPM D. Wythe <alibuda@linux.alibab=
a.com> wrote:
> > >
> > > When a struct_ops named xxx_ops was registered by a module, and
> > > it will be used in both built-in modules and the module itself,
> > > so that the btf_type of xxx_ops will be present in btf_vmlinux
> > > instead of in btf_mod, which means that the btf_type of
> > > bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
> > >
> > > Here are four possible case:
> > >
> > > +--------+---------------+-------------+-----------------------------=
----+
> > > |        | st_ops_xxx_ops| xxx_ops     |                             =
    |
> > > +--------+---------------+-------------+-----------------------------=
----+
> > > | case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmli=
nux |
> > > +--------+---------------+-------------+-----------------------------=
----+
> > > | case 1 | btf_vmlinux   | bpf_mod     | INVALID                     =
    |
> > > +--------+---------------+-------------+-----------------------------=
----+
> > > | case 2 | btf_mod       | btf_vmlinux | reg in mod but be used both =
in  |
> > > |        |               |             | vmlinux and mod.            =
    |
> > > +--------+---------------+-------------+-----------------------------=
----+
> > > | case 3 | btf_mod       | btf_mod     | be used and reg only in mod =
    |
> > > +--------+---------------+-------------+-----------------------------=
----+
> > >
> > > At present, cases 0, 1, and 3 can be correctly identified, because
> > > +       if (ret < 0 || ret >=3D sizeof(stname))
> > > +               return -ENAMETOOLONG;
> >
> > see preexisting snprintf() above, we don't really handle truncation
> > errors explicitly, they are extremely unlikely and not expected at
> > all, and worst case nothing will be found and user will get some
> > -ENOENT or something like that eventually. I'd drop this extra error
> > checking and keep it streamlines, similar to tname
> >
>
> Sounds reasonable to me. I will remove the explicit error checks in the
> next version.
>
> > > +
> > > +       /* Look for the corresponding "map_value" type that will be u=
sed
> > > +        * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out t=
he btf
> > > +        * and the mod_btf.
> > > +        * For example, find "struct bpf_struct_ops_tcp_congestion_op=
s".
> > > +        */
> > > +       kern_vtype_id =3D find_ksym_btf_id(obj, stname, BTF_KIND_STRU=
CT,
> > >                                         &btf, mod_btf);
> >
> > nit: if this fits under 100 characters, keep it single line
> >
> > > +       if (kern_vtype_id < 0) {
> > > +               pr_warn("struct_ops init_kern: struct %s is not found=
 in kernel BTF\n",
> > > +                               stname);
> >
> > same nit about preserving single-line statements as much as possible,
> > they are much easier to read
>
> None of them exceed 100 lines. Usually, I would check patches with 85 lin=
es limitations,
> but since 100 lines is acceptable, we can modify it to a single line here=
 for
> better readability.
>
> And thanks very much for your suggestion, I plan to fix these style
> issues in next versions with you ack, is this okay for you?

yep, sgtm

>
> Best wishes,
> D. Wythe
> >
> > > +               return kern_vtype_id;
> > > +       }
> > > +       kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
> > > +
> > > +       kern_type_id =3D btf__find_by_name_kind(btf, tname, BTF_KIND_=
STRUCT);
> > >         if (kern_type_id < 0) {
> > >                 pr_warn("struct_ops init_kern: struct %s is not found=
 in kernel BTF\n",
> > >                         tname);
> > > @@ -1020,20 +1039,6 @@ find_struct_ops_kern_types(struct bpf_object *=
obj, const char *tname_raw,
> > >         }
> > >         kern_type =3D btf__type_by_id(btf, kern_type_id);
> > >
> > > -       /* Find the corresponding "map_value" type that will be used
> > > -        * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
> > > -        * find "struct bpf_struct_ops_tcp_congestion_ops" from the
> > > -        * btf_vmlinux.
> > > -        */
> > > -       kern_vtype_id =3D find_btf_by_prefix_kind(btf, STRUCT_OPS_VAL=
UE_PREFIX,
> > > -                                               tname, BTF_KIND_STRUC=
T);
> > > -       if (kern_vtype_id < 0) {
> > > -               pr_warn("struct_ops init_kern: struct %s%s is not fou=
nd in kernel BTF\n",
> > > -                       STRUCT_OPS_VALUE_PREFIX, tname);
> > > -               return kern_vtype_id;
> > > -       }
> > > -       kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
> > > -
> > >         /* Find "struct tcp_congestion_ops" from
> > >          * struct bpf_struct_ops_tcp_congestion_ops {
> > >          *      [ ... ]
> > > @@ -1046,8 +1051,8 @@ find_struct_ops_kern_types(struct bpf_object *o=
bj, const char *tname_raw,
> > >                         break;
> > >         }
> > >         if (i =3D=3D btf_vlen(kern_vtype)) {
> > > -               pr_warn("struct_ops init_kern: struct %s data is not =
found in struct %s%s\n",
> > > -                       tname, STRUCT_OPS_VALUE_PREFIX, tname);
> > > +               pr_warn("struct_ops init_kern: struct %s data is not =
found in struct %s\n",
> > > +                       tname, stname);
> > >                 return -EINVAL;
> > >         }
> > >
> > > --
> > > 2.45.0
> > >

