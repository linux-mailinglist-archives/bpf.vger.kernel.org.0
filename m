Return-Path: <bpf+bounces-34111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CCE92A820
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C121F21B81
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BAB144307;
	Mon,  8 Jul 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxWmHxXb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B28AD55
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458961; cv=none; b=Ru5DLuKQrE9EwSPxq/bEBkAyBZlwhUAfeuFMpTEAPoVWKuRodgN6EA+W/bLQMnmveU/qfLUDRt+ZKya4lzvs3VqTOoe/0ledRZYtqREKCyYX0LQ+1BI9am6zubOaKHiEDGcgr0ImCroguH/5JdXIv7pSmOXPHVOIpsHoZA22dVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458961; c=relaxed/simple;
	bh=oi3WZkB3H7ywwLxSIO53BfLijIgxOKbqF3C0JeGY8A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9msSiTzrTmWhtYYZTGazaYEpc+ny2LN962MjOmiwD/VJsj59WoC8IunIFYulClxjxfE8iFpXHUVtBddbIRH8qH915V3SIzM7UgZjJK3appQpdVnbDqIUIwxQ1WiWFfCHidi2Vqq1/HpmWr052v+FoQ07hnFcVFhSo0X09x9l70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxWmHxXb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af81e8439so3431713b3a.0
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720458959; x=1721063759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0yMg1GTMuGSs9bpsuUgeQoQCMDqkD34vxN9KQhUnDQ=;
        b=IxWmHxXbZHolrARvGQNqNl+TL1HcEiV5fm5ZjBGMAP/Y/bBUKCZj3qlkv8zrGfKmVK
         C6OXcI1AZ7XDv7KC8j5vzPf54SfaBIJjXgz0Fm09Xe6hfHltreFCGF/CqqW42lX58Dey
         4hoXIzGDU0yknXqNGZEgFE8dhrfh6/U27a4NEvmSkpJGMLe9pLKwcdw5FJXgTPT80rPx
         f+Ma/1BF3VH6NvzV0rdGmcuQrDTvrJO9w/RzdJ4RpYBCb77OcXwUGCrc+vWkAuefvoHq
         bb+5iAWy1LklnIivhkiSZqv8Xb9Hq5zYpLTih5UwivlmiMdnOtg04ujBQ2lw3SSwz6Xo
         gzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720458959; x=1721063759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0yMg1GTMuGSs9bpsuUgeQoQCMDqkD34vxN9KQhUnDQ=;
        b=Cduh1Uwcpeq5jbdAChFIbsvIpJYRRkmHFsHqZInFrja6YKU0+TjVqpRs861oirPBdJ
         Idm2U8U74OylGBIxH8ZJ7Hqk7PeefBYdnZvN7f8CS317DJaA0uTuX7Z14O2DFLS6EzU1
         JUCD/0wVXpDzSU9E4D5X6qqT7z35tAIWbB4ebmRLANIIXmen+3TjjGL08Uk+ypkCajGv
         BOoD+3RgVvDBf9RoyV13VvCZSL5uVike9wHIM+RZ3F5E4ilMTxSMSL5eLmiYtjJFTF3f
         OgXmTxfS8FgeBfcMA28hIahRe+rJhE+RFZ6UyPjLL5/KSLB7GbURUanm0mzK/H8ACOzc
         AaNg==
X-Forwarded-Encrypted: i=1; AJvYcCWHIuAL0L1yXoA8f9vfEYegM2XD1WllqEht1RcDUR+9VxfsfCP4Ob63lsBftU9HgKkcer8Aqf/hHDKZ95tTrbzFr402
X-Gm-Message-State: AOJu0Yy4H6S9YWRXQG8TvLoqj2WPJ/54MbpknAHAQFl13gN/P9kEXhk0
	8N9OmSJv5HmmW8euwfsJfoGwXjGcvFkVWYh6q7ewHTlozg3FrsQjm824GfMAnDmSQC9lfxNiR8p
	UgN7MulyeRFCdmAiNN93eKg4RDrA=
X-Google-Smtp-Source: AGHT+IE72d0OyYpVFumMRbTu53kjg/KQ9n8SGni4EpuNgZfLvbP5ArzPFQ/lI/6h2jlfBgAnatzUPzG+Ho/LWVj2nZI=
X-Received: by 2002:a05:6a20:2d10:b0:1c0:bd6b:8554 with SMTP id
 adf61e73a8af0-1c29824bd82mr27578637.30.1720458959182; Mon, 08 Jul 2024
 10:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704001527.754710-1-andrii@kernel.org> <20240704001527.754710-2-andrii@kernel.org>
 <dbb10260a5c7df773f8205333e1433557a22d3c7.camel@gmail.com>
In-Reply-To: <dbb10260a5c7df773f8205333e1433557a22d3c7.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:15:46 -0700
Message-ID: <CAEf4BzZVMRtcM6dtLApzjq5zd18Nw52dC0eOJRfHtW+uDaDkLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: improve skeleton backwards compat
 with old buggy libbpfs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-07-03 at 17:15 -0700, Andrii Nakryiko wrote:
> > Old versions of libbpf don't handle varying sizes of bpf_map_skeleton
> > struct correctly. As such, BPF skeleton generated by newest bpftool
> > might not be compatible with older libbpf (though only when libbpf is
> > used as a shared library), even though it, by design, should.
> >
> > Going forward libbpf will be fixed, plus we'll release bug fixed
> > versions of relevant old libbpfs, but meanwhile try to mitigate from
> > bpftool side by conservatively assuming older and smaller definition of
> > bpf_map_skeleton, if possible. Meaning, if there are no struct_ops maps=
.
> >
> > If there are struct_ops, then presumably user would like to have
> > auto-attaching logic and struct_ops map link placeholders, so use the
> > full bpf_map_skeleton definition in that case.
> >
> > Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Silly question, here is a fragment of the profiler.skel.h generated
> with bpftool build (tools/bpf/bpftool/profiler.skel.h):
>
> static inline int
> profiler_bpf__create_skeleton(struct profiler_bpf *obj)
> {
>         /* ... */
>
>         map =3D (struct bpf_map_skeleton *)((char *)s->maps + 0 * s->map_=
skel_sz);
>         map->name =3D "events";
>         map->map =3D &obj->maps.events;
>
>         /* ... 4 more like this ... */
>
>         /* ... */
>
>         s->progs[0].name =3D "fentry_XXX";
>         s->progs[0].prog =3D &obj->progs.fentry_XXX;
>         s->progs[0].link =3D &obj->links.fentry_XXX;
>
>         s->progs[1].name =3D "fexit_XXX";
>         s->progs[1].prog =3D &obj->progs.fexit_XXX;
>         s->progs[1].link =3D &obj->links.fexit_XXX;
>
>         /* ... */
> }
>
> Do we need to handle 'progs' array access in a same way as maps?

Given bpf_prog_skeleton has never been extended yet (and maybe never
will be), I chose not to uglify this unnecessarily. My thinking/hope
is that by the time we get to extending prog_skeleton struct, all
actively used libbpf versions will be patched up and will handle this
correctly without the hacks we have to do for map_skeleton.


>
> [...]
>
> > @@ -878,23 +895,22 @@ codegen_maps_skeleton(struct bpf_object *obj, siz=
e_t map_cnt, bool mmaped, bool
> >
> >               codegen("\
> >                       \n\
> > -                                                                     \=
n\
> > -                             s->maps[%zu].name =3D \"%s\";         \n\
> > -                             s->maps[%zu].map =3D &obj->maps.%s;   \n\
> > +                                                                 \n\
> > +                             map =3D (struct bpf_map_skeleton *)((char=
 *)s->maps + %zu * s->map_skel_sz);\n\
> > +                             map->name =3D \"%s\";                 \n\
> > +                             map->map =3D &obj->maps.%s;           \n\
> >                       ",
> > -                     i, bpf_map__name(map), i, ident);
> > +                     i, bpf_map__name(map), ident);
> >               /* memory-mapped internal maps */
> >               if (mmaped && is_mmapable_map(map, ident, sizeof(ident)))=
 {
> > -                     printf("\ts->maps[%zu].mmaped =3D (void **)&obj->=
%s;\n",
> > -                             i, ident);
> > +                     printf("\tmap->mmaped =3D (void **)&obj->%s;  \n"=
, ident);
>                                                                   ^^
>                                               nit: this generates extra w=
hite space
> >               }
> >
> >               if (populate_links && bpf_map__type(map) =3D=3D BPF_MAP_T=
YPE_STRUCT_OPS) {
> >                       codegen("\
> >                               \n\
> > -                                     s->maps[%zu].link =3D &obj->links=
.%s;\n\
> > -                             ",
> > -                             i, ident);
> > +                                     map->link =3D &obj->links.%s; \n\
> > +                             ", ident);
> >               }
> >               i++;
> >       }
>
> [...]

