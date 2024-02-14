Return-Path: <bpf+bounces-21933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E2E8540ED
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DD81F281C2
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E23625;
	Wed, 14 Feb 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gueHk0ZV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C5372
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871914; cv=none; b=LZhi79r7JJ69YkuttblvqpCxnfWys7l7L2HuEk9a9lLSAB1EtvM0Jcvxj/3MOIDO592r+7O8l3TJhDm9x2O+2/ATXKGhd99qj9K6D5anNAhTYrtI598P5Gw/tAe4BnTRpR7yYyHOtwixxFMEdalSOGP/FmAntB3R4Nz9hCXswDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871914; c=relaxed/simple;
	bh=SQKS172aDHZ1yLw/B+H+qhyMuUDWHV5flYuN9Ux1n1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFxed6QDjPa6uNaeEHCNZCaOMb3JJ4OYOd018TreTXSQQsSTpiTelulp+BX8KH0BwEIRm3EVPU9djHgZGP7zd12Yos8hZls7HncTeYrOBXbjeJMdz7ejr1LkNGdqzwgy55uPxOOvYDp7XHkU3QvgeJi6E1ZaWPZtOgAao7GGlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gueHk0ZV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dc4a487b1eso3566356a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707871912; x=1708476712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC1nMc7pTknOKkwzDFTIRsHpNbe/6K187I4SurZ5w94=;
        b=gueHk0ZVSCdo2SXbLonmodH+v3qAo1LuexBqHtfPvHRF8tD7QeJViRDVJiSiCptvyq
         /vCtIHZeSshPj6n+wzpopXh1clD1XTUL2Lgnhbf/+3x66P0vjRiJZv8xOXzohHWdIwD5
         OnqOG4AfZXXpyz40/OUh8x7CKI5ZWyBrbee6SE1+kVuyo/qYWRdk+24dQzSMolZnJy7l
         qwVxlto8WSCxQxbvt93UErbr5l4XYY3yD2PyARKE9STBzt0W4Vh5WO6mIu8KuArV3/Cb
         UFnggZ/nwgHMzy5mzoMS81LVtD+FrhzNuOk873h/6zUbu1Rz1F0gs8/2mRwbC7wNkiu0
         hj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707871912; x=1708476712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC1nMc7pTknOKkwzDFTIRsHpNbe/6K187I4SurZ5w94=;
        b=serFcHxEPSFEffyxO3deQPtNIc6MG8I/5JvQcR1fx5H5CUx+K6+YVQSVwh4VrveoQ6
         PjQJm12sCjFWkNVTbgJ0NoEsCKX650MIu3mlmbiEUjVAmpMqDPaXqg62w6VnCR2dpCCS
         lBCjh1eDGXEo0NN1Mg4ilU5T2eOtpYw0mxiGU5HUjtMDDyL+UH3vIemO4XKb6uAgVe+4
         UuO5XYMgX4Iyf1miEkE6UL2Ua9P3LdY8kQtDUUoioDGqD7ljTTMxY+Fbf9C4Wn5zaUvB
         izltJEHmrZN5suajrrPH6pUhtbgTmxBP+raBCxq5vp8Ygc46Hp0v9fJBMcROU8rd9qX4
         U97w==
X-Gm-Message-State: AOJu0YxgYsqVZwqX2fAXrqB8IBa6y30m4dhl3iojY2W8r6ilzqwbIo8I
	zd63P0V7ARkg+3MkxH1yilbZ1If23LbWYcwBnD+i3N+3J7Rg6r/W/DrHDGMoTOtC9zFwPP23sBX
	aC2+lewH9CP30BqpXoYSR1ZKfdaM=
X-Google-Smtp-Source: AGHT+IHhACzmU3aQSLzC8/ggDCQIWh1793NT5PEgliUAYx9/pkD8SJ81Uqqc5deCHSGZXPeyHxcnllORnbLSfrWbjTk=
X-Received: by 2002:a05:6a20:c68e:b0:19e:4e58:5026 with SMTP id
 gq14-20020a056a20c68e00b0019e4e585026mr1349286pzb.4.1707871912163; Tue, 13
 Feb 2024 16:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-14-alexei.starovoitov@gmail.com> <CAEf4BzZGLJfKRbZdbrZzkYeHfa0Dz8fDLSngv3k+t4b3f80ksg@mail.gmail.com>
 <CAADnVQLrR-pWQfOCknnu2A3=4NvQOnteJ2thWEFjys+g+hA+1g@mail.gmail.com>
In-Reply-To: <CAADnVQLrR-pWQfOCknnu2A3=4NvQOnteJ2thWEFjys+g+hA+1g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 16:51:40 -0800
Message-ID: <CAEf4Bza8GeomF77tqgwHVipq1Nb17SQbz6JryWJawk67U1YEhQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 13/20] libbpf: Allow specifying 64-bit
 integers in map BTF.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 13, 2024 at 3:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Feb 8, 2024 at 8:07=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > __uint() macro that is used to specify map attributes like:
> > >   __uint(type, BPF_MAP_TYPE_ARRAY);
> > >   __uint(map_flags, BPF_F_MMAPABLE);
> > > is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of element=
s" field.
> > >
> > > Introduce __ulong() macro that allows specifying values bigger than 3=
2-bit.
> > > In map definition "map_extra" is the only u64 field.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  tools/lib/bpf/bpf_helpers.h |  5 +++++
> > >  tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++-=
--
> > >  2 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.=
h
> > > index 9c777c21da28..0aeac8ea7af2 100644
> > > --- a/tools/lib/bpf/bpf_helpers.h
> > > +++ b/tools/lib/bpf/bpf_helpers.h
> > > @@ -13,6 +13,11 @@
> > >  #define __uint(name, val) int (*name)[val]
> > >  #define __type(name, val) typeof(val) *name
> > >  #define __array(name, val) typeof(val) *name[]
> > > +#ifndef __PASTE
> > > +#define ___PASTE(a,b) a##b
> > > +#define __PASTE(a,b) ___PASTE(a,b)
> > > +#endif
> >
> > we already have ___bpf_concat defined further in this file (it's macro
> > so ordering shouldn't matter), let's just use that instead of adding
> > another variant
>
> Ohh. forgot about this one. will do.
>
> > > +#define __ulong(name, val) enum { __PASTE(__unique_value, __COUNTER_=
_) =3D val } name
> > >
> > >  /*
> > >   * Helper macro to place programs, maps, license in
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 4880d623098d..f8158e250327 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -2243,6 +2243,39 @@ static bool get_map_field_int(const char *map_=
name, const struct btf *btf,
> > >         return true;
> > >  }
> > >
> > > +static bool get_map_field_long(const char *map_name, const struct bt=
f *btf,
> > > +                              const struct btf_member *m, __u64 *res=
)
> > > +{
> > > +       const struct btf_type *t =3D skip_mods_and_typedefs(btf, m->t=
ype, NULL);
> > > +       const char *name =3D btf__name_by_offset(btf, m->name_off);
> > > +
> > > +       if (btf_is_ptr(t))
> > > +               return false;
> >
> > It's not great that anyone that uses __uint(map_extra, ...) would get
> > warnings now.
>
> What warning ?
> This specific check makes it fallback to ptr without warning.
> We have a bloom filter test that uses map_extra.
> No warnings there.

ah, right, forget about the warning, you exit early. But still makes
sense to handle ulong vs uint transparently


>
> > Let's just teach get_map_field_long to recognize __uint vs __ulong?
> >
> > Let's call into get_map_field_int() here if we have a pointer, and
> > then upcast u32 into u64?
>
> makes sense.
>
> > > +
> > > +       if (!btf_is_enum(t) && !btf_is_enum64(t)) {
> > > +               pr_warn("map '%s': attr '%s': expected enum or enum64=
, got %s.\n",
> >
> > seems like get_map_field_int() is using "PTR" and "ARRAY" all caps
> > spelling in warnings, let's use ENUM and ENUM64 for consistency?
>
> done.
>
> > > +                       map_name, name, btf_kind_str(t));
> > > +               return false;
> > > +       }
> > > +
> > > +       if (btf_vlen(t) !=3D 1) {
> > > +               pr_warn("map '%s': attr '%s': invalid __ulong\n",
> > > +                       map_name, name);
> > > +               return false;
> > > +       }
> > > +
> > > +       if (btf_is_enum(t)) {
> > > +               const struct btf_enum *e =3D btf_enum(t);
> > > +
> > > +               *res =3D e->val;
> > > +       } else {
> > > +               const struct btf_enum64 *e =3D btf_enum64(t);
> > > +
> > > +               *res =3D btf_enum64_value(e);
> > > +       }
> > > +       return true;
> > > +}
> > > +
> > >  static int pathname_concat(char *buf, size_t buf_sz, const char *pat=
h, const char *name)
> > >  {
> > >         int len;
> > > @@ -2476,10 +2509,15 @@ int parse_btf_map_def(const char *map_name, s=
truct btf *btf,
> > >                         map_def->pinning =3D val;
> > >                         map_def->parts |=3D MAP_DEF_PINNING;
> > >                 } else if (strcmp(name, "map_extra") =3D=3D 0) {
> > > -                       __u32 map_extra;
> > > +                       __u64 map_extra;
> > >
> > > -                       if (!get_map_field_int(map_name, btf, m, &map=
_extra))
> > > -                               return -EINVAL;
> > > +                       if (!get_map_field_long(map_name, btf, m, &ma=
p_extra)) {
> > > +                               __u32 map_extra_u32;
> > > +
> > > +                               if (!get_map_field_int(map_name, btf,=
 m, &map_extra_u32))
> > > +                                       return -EINVAL;
> > > +                               map_extra =3D map_extra_u32;
> > > +                       }
> >
> > with the above change it would be a simple
> > s/get_map_field_int/get_map_field_long/ (and __u32 -> __u64, of
> > course)
>
> so this logic will move into get_map_field_long.
> makes sense.

yep, seems good to not care about int vs long here

>
> I thought about making get_map_field_int() to handle enum,
> but way too many places need refactoring, since it's called like:
> get_map_field_int(map_name, btf, m, &map_def->map_type)
> get_map_field_int(map_name, btf, m, &map_def->max_entries)

yeah, not worth it

