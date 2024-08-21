Return-Path: <bpf+bounces-37761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08DD95A5A8
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 22:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B1C1F210DC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA916F0E8;
	Wed, 21 Aug 2024 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDWHyTF+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DDE1D12F4
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270917; cv=none; b=NbtqrHstbMbXYO8AuoS6zrjddk6aJesXzrYCc9dqiMNGp67mFiECHok3uI74tWxOEHDKEDDgP1o9RLqjkZb58ApN1Fm1AMFPe3VhuLRVwKR0URjlKDxVcvEOLDaAcQOKYptBSh5DKO1CnChO5uROkCPyxh8WZzylIl96RkjNIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270917; c=relaxed/simple;
	bh=yZooFYDavcBqqFWy4iQslolrmPpW0x4FRriZD+OUL1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwEsHfHEImZPKf3bEeWE8bEkOFFn1NahJPQbMzPYQndEgM6MI37SXwx5lT6fckNRA3cheoG9lhRFOO5ekonhZSlb3RvPlDO7ndFaEl7k71xfpDwvjDn33QFS7nHxx/MK5uXMl5CJoIW5t4ARsSnE2EL6n2gFLbpyvvgePWH0DoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDWHyTF+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so65849a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724270916; x=1724875716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0U6KTGcBl2TjlIbvK7iZzKkngJsRuPzhtgO+2yq+l0=;
        b=QDWHyTF+kZcb1kVXKNGf/rz00sQQU0pZdRYhFlUyX6TuuFVQ1Y4le8b6STIrMdAP10
         7pWt//YtjpWlxzRZgZS9korugoY89xmPL084IqNbeW0AkRhXbo0aqBfzycI02/p//FYv
         oLXSSjKaEUaqXk+ZvcYvT5WZBvdlZEb7se4LzoG3WwOjX9SdNEAc2vDiwdkH5UAihumi
         NfuEfNxzYLe2ICEaZ3BLRONwN9PaSmGhCNbBZrrN3qnrHIvPA6vEx4QUcdG4A+Esfz+4
         rDVkmTJvxW9EO0Jt9CAaOKIo+gd3lr8lHvLk0UNT4sA6XGaolmDKNw4ohud+qs4ABeyh
         STYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724270916; x=1724875716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0U6KTGcBl2TjlIbvK7iZzKkngJsRuPzhtgO+2yq+l0=;
        b=W+E5T5Vx9N8/Wz5uIEAicgDwZa9V8YfuVn90gAJC2LwzUtM3MzUpa3X3vpm2tT/iYc
         rgeosjGTsNodC2p8DBN8A8PYp0iTlVAXJVVuLK3ThmswHeBpvgNFbJdUcybK+W/2DFAn
         3zf9cZo+UgUF0cEssauMof0iqh2m4RlJI9Bopx+C9UFFufE7VCEbS6w3VZtvwRJGP/o+
         P6RNggzDg4rjJ6exUcgSkl0xIpKZ1mIC+AIfTLQviS0/p5nTVgGpK2emVhse2IM4WSs2
         2AyoAUZVKx/O98hjUoXwanP8qJzX4d7urx5KlUqWWd92e+7qW/j6ONZ/eXNmbJ61QIYg
         SRtA==
X-Gm-Message-State: AOJu0Yz3VeFUwfBVFlTUIwQeWHIevV859j+Xo+gfSt502x5qrrME4BaD
	LTUx7mzXyfphHfZaVT3J4PsNUp7yMpgkePE7UnAVK30YY3ch2p8rhadTFE//2ZscYfK8Bypxz/J
	NH/GTeJLky8CCfi4PIX+I8FjS9Rp4Ng==
X-Google-Smtp-Source: AGHT+IEjDDGHQeghZ7b4nbjbbHtdGBarjj2EbBKsT3NoclN+G4RpMS/6tqU85EANe3e7llaxJgYOn5QGE1Xj24vNlvw=
X-Received: by 2002:a17:90b:4b4a:b0:2d4:921:dff1 with SMTP id
 98e67ed59e1d1-2d5e9a64825mr3626004a91.20.1724270915694; Wed, 21 Aug 2024
 13:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821164620.1056362-1-eddyz87@gmail.com> <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
 <a36a3307e4102c8f05df4e1d9fd44fc7b4f77c32.camel@gmail.com>
 <CAEf4BzZ9sYeYANVNd1RDZWc_4EqS4cpsc+DfSqnLBp9Qfh0VaA@mail.gmail.com> <98527d7adc2cc4880524caecc2f6e6d022bac210.camel@gmail.com>
In-Reply-To: <98527d7adc2cc4880524caecc2f6e6d022bac210.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 13:08:23 -0700
Message-ID: <CAEf4Bza9Y-JO0MeomB9S+6tOr-rRp0kDe_-1_tf2ArNddfUEpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify
 relocation type id
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Liu RuiTong <cnitlrt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-08-21 at 12:10 -0700, Andrii Nakryiko wrote:
> > On Wed, Aug 21, 2024 at 10:46=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Wed, 2024-08-21 at 09:59 -0700, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > > Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_=
type_by_id().")
> > > > > Reported-by: Liu RuiTong <cnitlrt@gmail.com>
> > > > > Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YL=
DoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com/
> > > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > > ---
> > > > >  tools/lib/bpf/relo_core.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.=
c
> > > > > index 63a4d5ad12d1..a04724831ebc 100644
> > > > > --- a/tools/lib/bpf/relo_core.c
> > > > > +++ b/tools/lib/bpf/relo_core.c
> > > > > @@ -1297,6 +1297,11 @@ int bpf_core_calc_relo_insn(const char *pr=
og_name,
> > > > >
> > > > >         local_id =3D relo->type_id;
> > > > >         local_type =3D btf_type_by_id(local_btf, local_id);
> > > > > +       if (!local_type) {
> > > >
> > > > This is a meaningless check at least for libbpf's implementation of
> > > > btf_type_by_id(), it never returns NULL. Commit you point to in Fix=
es
> > > > tag clearly states the differences.
> > >
> > > That is not true on kernel side.
> > > bpf_core_calc_relo_insn() is called from bpf_core_apply():
> > >
> > > int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_re=
lo *relo,
> > >                    int relo_idx, void *insn)
> > > {
> > >         bool need_cands =3D relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL;
> > >         ...
> > >         if (need_cands) {
> > >                 ...
> > >                 // code below would report an error if relo->type_id =
is bogus
> > >                 cc =3D bpf_core_find_cands(ctx, relo->type_id);
> > >                 if (IS_ERR(cc)) {
> > >                         bpf_log(ctx->log, "target candidate search fa=
iled for %d\n",
> > >                                 relo->type_id);
> > >                         err =3D PTR_ERR(cc);
> > >                         goto out;
> > >                 }
> > >                 ...
> > >         }
> > >
> > >         err =3D bpf_core_calc_relo_insn((void *)ctx->log, relo, relo_=
idx, ctx->btf, &cands, specs,
> > >                                       &targ_res);
> > >         ...
> > > }
> > >
> > > If `need_cands` is false the bogus type_id could reach into bpf_core_=
calc_relo_insn().
> > > Which is exactly the case with repro submitted by Liu.
> > > There is also a simplified repro here:
> > > https://github.com/kernel-patches/bpf/commit/017a9dcf17e572f9b7c32aa6=
2a81df8ef41cef17
> > > But I can't submit it as a test yet.
> > >
> > > >
> > > > So you'd need to validate local_id directly against number of types=
 in
> > > > local_btf.
> > >
> > > How is this better than a null check?
> > >
> >
> > because id check will be useful for both kernel and libbpf sides?..
>
> This would require a special case for BPF_CORE_TYPE_ID_LOCAL in
> bpf_core_calc_relo_insn(). If you don't like this null check I'll
> modify bpf_core_apply() instead to always check relo->type_id and
> report and error.
>
> This would also be in the line with what bpf_core_resolve_relo()
> does on libbpf side.

Ok, then let's do that. I don't want static analysers complaining
about this when checking libbpf code base.

>
> [...]
>

