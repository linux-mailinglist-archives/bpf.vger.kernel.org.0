Return-Path: <bpf+bounces-21932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC48540E6
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0804B22CFE
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B1385;
	Wed, 14 Feb 2024 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl1ExG8K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4E7F
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871680; cv=none; b=P8hXPnaaw6giF/M9kidcjs1FIxs8w1ldOSdFD1jNTsqOtjK7E88OTNlaaL1qAgMuvT1Tl9oqVl4SnxcIvvq+wy1piHLQ+7aU1vwCjMJ3u5oXi7XU4o94g2xgFwSXtE0pUFS8oV53hTma966Mg8ViNTY8BXilIQ08n65e583E6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871680; c=relaxed/simple;
	bh=sgDV6fYgMJxPRNckoNrlJVPfCxSqN4nvIK69EX0onhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXjWC+EvHDOWq1H+nQOOfOVgSiqonq991V1MDGwJRDkt0rPIbwCFfOnjpG+JlXYUTJiTOA59ZaHRstwffIWmuedj9tXZ3/WdAX14lP6eFIJD3G/NSnoS9HvHKgWdUwSe26DHsVp5GVvSnez7PdreOdT1B1/1/RPI39yzuxwsvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl1ExG8K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33cdedb40c4so629617f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707871676; x=1708476476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRN+LPbXAzEy4D3mDpxii0UBls8jla/cXo3p9LAOOOY=;
        b=Pl1ExG8KLckcJC2Zpn4NLQC6eJjW6GBn5h0XVHis/yq3ThSwTtAqzCHAfxRAV6bPY8
         Sa8Oq+zC05setU+ECJxdI6SsKFTqEjNFSxneQQVULUyQYWBqTw5ykn8jIqdb2PBFoIXX
         Q0W62BoW7LWjXgtAml/NVImkNxbxYDXtl36q7spztU+fAVx4yCQGpElCQ6aosLlW6YHe
         BIa/jd+6WfujCTufW1C+JSHUEqIAdwhOIyE82X/PDQawMXtHcAd4rSu4z6vccObG71SQ
         oVcpksgrTD2Y0L3+j4SRptTnqd1YuamvKELlQyPHTBieEDhAdKbWf+Ypc9u8luRG/Jkh
         5OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707871676; x=1708476476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRN+LPbXAzEy4D3mDpxii0UBls8jla/cXo3p9LAOOOY=;
        b=Dw3iXNKbvB71IkTSWCsL4OB3FodjB5aXJtJ9dfJv9J5JzvK+Od/z6pklvjOXPE2XKx
         YsDeI5+7IM3TudmnNPSWaD3TmsYOzh7tdHW2+NrftWkkDHe7ECj553ko1wFf0l249roy
         3/vkt3zcVaeT0lpuiebO6hgMbLl1CkSv9z+GwZxFgvJ9F2WyjtKOMHF7DrjQ1SH/+8Ci
         Z+qJXNBBRcNY8FtDsv7SWJlw9gnHZrZ64KknlEihRa+QrcJrsjxZ7Lwi4ZyvO4ywxCE8
         iIux18RCVrieQK2R2Oac9RXhfyCU9BmQf4+YN3LMXDw85uKb1rV/1mNoWOCgj3nlMrKi
         5qJg==
X-Gm-Message-State: AOJu0YzfkHJfqhOUk2aJTjGLNTzF8n/PtEgs8kcf3WziZ4jmm/faoUwC
	tYZOjjosXvMRf10ntRUb4rkliQWHPChKh7wXcYU1NJhBmoptoxwc6XU8lsNVitNJ9yDFEWjVa37
	Aip/O6cljZdwRXafhCTpSmfXtxHQ=
X-Google-Smtp-Source: AGHT+IEC3QK2Mfqok8OLcslIOgV1gXeytEhnQ4GyvF5tANXVZ9P685SV60tXbnSrrOY7f+kgrRI78AQJNx1rY4J6/yc=
X-Received: by 2002:adf:e6cc:0:b0:33b:10de:59a2 with SMTP id
 y12-20020adfe6cc000000b0033b10de59a2mr575521wrm.15.1707871676333; Tue, 13 Feb
 2024 16:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-14-alexei.starovoitov@gmail.com> <CAEf4BzZGLJfKRbZdbrZzkYeHfa0Dz8fDLSngv3k+t4b3f80ksg@mail.gmail.com>
In-Reply-To: <CAEf4BzZGLJfKRbZdbrZzkYeHfa0Dz8fDLSngv3k+t4b3f80ksg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 16:47:44 -0800
Message-ID: <CAADnVQLrR-pWQfOCknnu2A3=4NvQOnteJ2thWEFjys+g+hA+1g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 13/20] libbpf: Allow specifying 64-bit
 integers in map BTF.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 8, 2024 at 8:07=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > __uint() macro that is used to specify map attributes like:
> >   __uint(type, BPF_MAP_TYPE_ARRAY);
> >   __uint(map_flags, BPF_F_MMAPABLE);
> > is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements"=
 field.
> >
> > Introduce __ulong() macro that allows specifying values bigger than 32-=
bit.
> > In map definition "map_extra" is the only u64 field.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/lib/bpf/bpf_helpers.h |  5 +++++
> >  tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++---
> >  2 files changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 9c777c21da28..0aeac8ea7af2 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -13,6 +13,11 @@
> >  #define __uint(name, val) int (*name)[val]
> >  #define __type(name, val) typeof(val) *name
> >  #define __array(name, val) typeof(val) *name[]
> > +#ifndef __PASTE
> > +#define ___PASTE(a,b) a##b
> > +#define __PASTE(a,b) ___PASTE(a,b)
> > +#endif
>
> we already have ___bpf_concat defined further in this file (it's macro
> so ordering shouldn't matter), let's just use that instead of adding
> another variant

Ohh. forgot about this one. will do.

> > +#define __ulong(name, val) enum { __PASTE(__unique_value, __COUNTER__)=
 =3D val } name
> >
> >  /*
> >   * Helper macro to place programs, maps, license in
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4880d623098d..f8158e250327 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2243,6 +2243,39 @@ static bool get_map_field_int(const char *map_na=
me, const struct btf *btf,
> >         return true;
> >  }
> >
> > +static bool get_map_field_long(const char *map_name, const struct btf =
*btf,
> > +                              const struct btf_member *m, __u64 *res)
> > +{
> > +       const struct btf_type *t =3D skip_mods_and_typedefs(btf, m->typ=
e, NULL);
> > +       const char *name =3D btf__name_by_offset(btf, m->name_off);
> > +
> > +       if (btf_is_ptr(t))
> > +               return false;
>
> It's not great that anyone that uses __uint(map_extra, ...) would get
> warnings now.

What warning ?
This specific check makes it fallback to ptr without warning.
We have a bloom filter test that uses map_extra.
No warnings there.

> Let's just teach get_map_field_long to recognize __uint vs __ulong?
>
> Let's call into get_map_field_int() here if we have a pointer, and
> then upcast u32 into u64?

makes sense.

> > +
> > +       if (!btf_is_enum(t) && !btf_is_enum64(t)) {
> > +               pr_warn("map '%s': attr '%s': expected enum or enum64, =
got %s.\n",
>
> seems like get_map_field_int() is using "PTR" and "ARRAY" all caps
> spelling in warnings, let's use ENUM and ENUM64 for consistency?

done.

> > +                       map_name, name, btf_kind_str(t));
> > +               return false;
> > +       }
> > +
> > +       if (btf_vlen(t) !=3D 1) {
> > +               pr_warn("map '%s': attr '%s': invalid __ulong\n",
> > +                       map_name, name);
> > +               return false;
> > +       }
> > +
> > +       if (btf_is_enum(t)) {
> > +               const struct btf_enum *e =3D btf_enum(t);
> > +
> > +               *res =3D e->val;
> > +       } else {
> > +               const struct btf_enum64 *e =3D btf_enum64(t);
> > +
> > +               *res =3D btf_enum64_value(e);
> > +       }
> > +       return true;
> > +}
> > +
> >  static int pathname_concat(char *buf, size_t buf_sz, const char *path,=
 const char *name)
> >  {
> >         int len;
> > @@ -2476,10 +2509,15 @@ int parse_btf_map_def(const char *map_name, str=
uct btf *btf,
> >                         map_def->pinning =3D val;
> >                         map_def->parts |=3D MAP_DEF_PINNING;
> >                 } else if (strcmp(name, "map_extra") =3D=3D 0) {
> > -                       __u32 map_extra;
> > +                       __u64 map_extra;
> >
> > -                       if (!get_map_field_int(map_name, btf, m, &map_e=
xtra))
> > -                               return -EINVAL;
> > +                       if (!get_map_field_long(map_name, btf, m, &map_=
extra)) {
> > +                               __u32 map_extra_u32;
> > +
> > +                               if (!get_map_field_int(map_name, btf, m=
, &map_extra_u32))
> > +                                       return -EINVAL;
> > +                               map_extra =3D map_extra_u32;
> > +                       }
>
> with the above change it would be a simple
> s/get_map_field_int/get_map_field_long/ (and __u32 -> __u64, of
> course)

so this logic will move into get_map_field_long.
makes sense.

I thought about making get_map_field_int() to handle enum,
but way too many places need refactoring, since it's called like:
get_map_field_int(map_name, btf, m, &map_def->map_type)
get_map_field_int(map_name, btf, m, &map_def->max_entries)

