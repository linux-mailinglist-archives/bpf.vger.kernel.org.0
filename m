Return-Path: <bpf+bounces-51046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B39A2F9B3
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 21:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026461666F0
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7341C24BCFD;
	Mon, 10 Feb 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d27/wqQ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA80244EA1
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217937; cv=none; b=OA/XP42s08/BehijXsXGDsbNawmSsrG5I8Z2xC5/LraoliVxZ4pDcNx8qW317Kf8eqhKNfQuWYJgb2xNYyThMCUwCEqSQhAiWyCWSUn8aNmdP++iyJQvMsni0f+Fwh3Y7WD+pXkbQqcbc5m8ircfRNVNVok9IPQ9oVFhNFmNCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217937; c=relaxed/simple;
	bh=ztsITk4bsB1M6G3uG3jsPWumKcQdaz3iSg8BTysWjtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSk3zYwLJZS2+W82aO4ZMByPzSouAb1dxulZdZedPBcnHSnmmTnoe+GhF97m2JC2rGgoKnuaQ+50m51ZgsNECgUfv/gFXafxnP6SYfrb8gZAp325uJFgoahyyjnZSCLLGrtYZ7IfM6HbHNj6SzRrFITAdwU6/FsGaPWJABiFtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d27/wqQ4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de6e26d4e4so3734950a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739217933; x=1739822733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+EvipgGs6SqzrrOQp9hISk8PvHVSOd8gfyzyN9PmjA=;
        b=d27/wqQ4NImyyZa6WchCoTZCnB7fJ+R0316LVyXeqMgtRwj3qCz0FSYzTZIalrDC3a
         jf19Z/xB5J4EbqNiw748fdmscTZqp23Yremg/MWSY2MuOyWjQKAvWF09xuBluUDY0Fs5
         2gc0qgQY5IhcdBSqfBBnKd5QABnavLocG4YGQN0oVlGQEdawRzLy2+ViiT1TdtFHjTjz
         NxN5L9RuGGtI+l1bYXvMWDOmB1ydu+DTIOBhppY7CdbRuhuxRLyJTQAxrD6mE476V8jg
         NjyC0bZnAXeFnR7N0K7n29iMrFy66GV1Z+1yO4eRzZ8p2psdulw9ppPgD8qlpNLTuAbu
         2QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739217933; x=1739822733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+EvipgGs6SqzrrOQp9hISk8PvHVSOd8gfyzyN9PmjA=;
        b=WfwBOaFKocvDzweFd668Qu4M5NYvZBKsj2DQlbBJGYtvXPag1NrJCg+gFAFm6jXhCq
         LRb+q69wPNYOjcUuEbJ+9rKrbqcSpDAkCEI1j9nNGINCr4aV+PBYgMgzuR973/k6rDQc
         aJ2PXhyOtT8ntW91igXJJLII+iwiSmIYpEaRaLgo4AFw1Y4FajhHkl+j9AVTlJBmJfD4
         32uWfJuiZZVzAZ5PxLY5OB0/nlvMH+3mbZos8pN2qLGT8Fk7MXdepkGXb3cbXV/8it1x
         UgmLVKspptZDwBc2njtN+HTUN/vLnIVesouehxcVaQ+RciyA7x1rt6CpzbtrIPSzkLUi
         n3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM71A0WDptrRpSuZ0746e0lhHsfPo9YHcsuexs/GZYa4JHzO+gQbrn9HZYupBT9tM085Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxua9NB4f459Okdni3CrZZTfdGEgTIUnecScPovHVaw8G1SLw9p
	0HeMVnACAeK7gax2uWJvjVvjgUB4kHHQf8bpxxk/ZBJjG1Ewku2g0be6c3cjp29a39GJNjQ5haY
	3CdyQ8CemdAXa/gzIzGgeePRRSTQ=
X-Gm-Gg: ASbGnct4K6Y6lG6KEdC8gd3nkxxZh2aIVAJfmf16I/YDzJyv9+vzj6ewVDly+OsQ/sh
	90ypoG1tiikSNu304ueUPobi7OCUHRxtjBoTDmFl0W7rSN5/Q+usjGYuNVXvLO0/WieaQ5ZtVjT
	KOUdXHXLIL5llO
X-Google-Smtp-Source: AGHT+IEFQva++/rEKIbLFPH5Y8buG9vFB47mEFad00jOAnOf3jjc7+9q0i1Mayi443UHdFHql5abQj4+7wWsNxpeA8U=
X-Received: by 2002:a17:907:7b89:b0:ab7:d10b:e1de with SMTP id
 a640c23a62f3a-ab7d10be880mr245967766b.13.1739217933213; Mon, 10 Feb 2025
 12:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207014809.1573841-1-andrii@kernel.org> <58436ca32a9ba1fb1cad6d822d6dbbd926ac2375.camel@gmail.com>
In-Reply-To: <58436ca32a9ba1fb1cad6d822d6dbbd926ac2375.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Feb 2025 12:05:18 -0800
X-Gm-Features: AWEUYZlcKbKA5TuxItrDou8i1DGNYCjxbKXt1rHcTSY3vMULlHRgbdCwnUqBYoo
Message-ID: <CAEf4Bzb=31e3sLsVsxy_XCrccBt+EzLEnhf17b03CH1XVzKoGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: fix LDX/STX/ST CO-RE relocation size
 adjustment logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 1:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2025-02-06 at 17:48 -0800, Andrii Nakryiko wrote:
> > Libbpf has a somewhat obscure feature of automatically adjusting the
> > "size" of LDX/STX/ST instruction (memory store and load instructions),
> > based on originally recorded access size (u8, u16, u32, or u64) and the
> > actual size of the field on target kernel. This is meant to facilitate
> > using BPF CO-RE on 32-bit architectures (pointers are always 64-bit in
> > BPF, but host kernel's BTF will have it as 32-bit type), as well as
> > generally supporting safe type changes (unsigned integer type changes
> > can be transparently "relocated").
> >
> > One issue that surfaced only now, 5 years after this logic was
> > implemented, is how this all works when dealing with fields that are
> > arrays. This isn't all that easy and straightforward to hit (see
> > selftests that reproduce this condition), but one of sched_ext BPF
> > programs did hit it with innocent looking loop.
> >
> > Long story short, libbpf used to calculate entire array size, instead o=
f
> > making sure to only calculate array's element size. But it's the elemen=
t
> > that is loaded by LDX/STX/ST instructions (1, 2, 4, or 8 bytes), so
> > that's what libbpf should check. This patch adjusts the logic for
> > arrays and fixed the issue.
> >
> > Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Do I understand correctly, that for nested arrays relocation size
> would be resolved to the innermost element size?
> To allow e.g.:
>
>     struct { int a[2][3]; }
>     ...
>     int *a =3D __builtin_preserve_access_index(({ in->a; }));
>     a[0] =3D 42;
>
> With a justification that nothing useful could be done with 'int **a'
> type when dimensions are not known?
> I guess this makes sense.

Known or not, a multi-dimensional array at the lowest level is still
an array of elements, and it is the elements that will be read (up to
u64), so that's why I'm flattening the array and getting to the actual
item.

>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>?
>
> >  tools/lib/bpf/relo_core.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> > index 7632e9d41827..2b83c98a1137 100644
> > --- a/tools/lib/bpf/relo_core.c
> > +++ b/tools/lib/bpf/relo_core.c
> > @@ -683,7 +683,7 @@ static int bpf_core_calc_field_relo(const char *pro=
g_name,
> >  {
> >       const struct bpf_core_accessor *acc;
> >       const struct btf_type *t;
> > -     __u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id;
> > +     __u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id, elem_id;
> >       const struct btf_member *m;
> >       const struct btf_type *mt;
> >       bool bitfield;
> > @@ -706,8 +706,14 @@ static int bpf_core_calc_field_relo(const char *pr=
og_name,
> >       if (!acc->name) {
> >               if (relo->kind =3D=3D BPF_CORE_FIELD_BYTE_OFFSET) {
> >                       *val =3D spec->bit_offset / 8;
> > -                     /* remember field size for load/store mem size */
> > -                     sz =3D btf__resolve_size(spec->btf, acc->type_id)=
;
> > +                     /* remember field size for load/store mem size;
> > +                      * note, for arrays we care about individual elem=
ent
> > +                      * sizes, not the overall array size
> > +                      */
> > +                     t =3D skip_mods_and_typedefs(spec->btf, acc->type=
_id, &elem_id);
> > +                     while (btf_is_array(t))
> > +                             t =3D skip_mods_and_typedefs(spec->btf, b=
tf_array(t)->type, &elem_id);
> > +                     sz =3D btf__resolve_size(spec->btf, elem_id);
>
> Nit: while trying to figure out what this change is about
>      I commented out the above hunk and this did not trigger any test fai=
lures.

I don't remember exactly under which conditions we'll have this
branch, something about array element access. But this whole logic has
to stay in sync with non-array-element CO-RE relocation.

>
> [...]
>

