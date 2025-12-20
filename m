Return-Path: <bpf+bounces-77242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4035CD2C63
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 10:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E17D300A40A
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EE304976;
	Sat, 20 Dec 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaMbpjPE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E87224B01
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766223524; cv=none; b=Z0P3Ddh6kP2VFqnBssd39GkFe5p/P3YIR4taxunvr+hnk1OX106Jri5PfcmDOZeHgXq4shjcldZEtehgxu96bSCaZyQfNoe9xWlr/Z7lUBRiWxp5j+uP80aVw/af4jqlEAe0pP/R0unuaEivkBBc6GobiIShfdoyWkLPNE5dp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766223524; c=relaxed/simple;
	bh=E9ejub5Gcj6DpddlPY6K3Xi+nK73rTOtKyv2V/zil+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfhns1OnFIT5Eco79dXbWgStpkMPEYunow8iNGV92tZb+DE/0KEEbX5qP3NYT5Bd8+na+DWI0cJajc9zuMM2IhQAQ6cMXfrul7nGEudH7vf7fpTPk1EN/6rfrObJF3rUr1mRFokciahvZjv+GHcIpteX4GyjUl5tf/isoTIevHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaMbpjPE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso3079317a12.0
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 01:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766223521; x=1766828321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr8tLg8opYjYhel08xQhnyz3YWZw0DZOlGI0dIw1a3w=;
        b=QaMbpjPEIfIJ1tynI2SIn2opgH5ZF+34E2sl/EW8xXsNf2aJhzacFr87+4xFAfmTre
         zoFzcAdIOLO0MdxfWPoHBMjevSIMjotiak6VZx9KbQr4KiEGG7drPpiWNHvhkO18LtOD
         bEnRheLkJVSi2Ioo3XdXY/u6CtZSNhiQvN9+j7XjzKevM4YZWkEt1sA2RINBUJnRK18O
         Hgn1j83cuhxUyWSn/oJ2xJoknuAmCjDfI5MZ2q6cRTMfxqiUpjs6+sxvMJ9ZPZbMs+Q9
         Kh7fcApO/ZGnqWe9OFJzmRzZKLiQD8Lesjzprp4FdEueuhTgt0gSJvhrHZkrDLAcoTOE
         XtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766223521; x=1766828321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cr8tLg8opYjYhel08xQhnyz3YWZw0DZOlGI0dIw1a3w=;
        b=NCa56qTyQUc0QdVm16/7pGySuOZJLicQRSQ9vcZboXuJ+sGpdhZ1Hmt6dmPzA8Rp03
         snr2JP3m4GLvCwXg8PA/9X9ilJ72qvY21N8TQk6g7QDOZoVbj4qBMvGQOqs2h1h10Aep
         ip0Sd4rAQiYs8QPXL4SDCNPHuDHHQChilueXx3eu8XnN29wIKce82Pqn003RMfazjHtv
         sk9/LXJcskuaPvT7oOmPKiIrOBcjDWzl71ssRyknLNoaN5Ed14LL1LtVlAQAKG37C4s/
         1VlilbxmS0568dCDiYhPUGcje4H0Z7ZiRnL30LTLrMIfarDFegoghIXWulcv81PgY+xD
         d1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCW4DKmqasAKPUT4l4zgJppxZBW2Uw8dTNB58IOouKkwxz5zdL4wpzUvRIheXn5lD5iJZtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHY6niRZdBOUD/FEOYixccAIuHlRPQBtIkGTA8xpKwjIVcNlF
	9HYSEZtcePUnjxRIdgDNX63k4vp5jEU/USg1hY8NoMxtXkoP+otwS8+xl61HxXolgb4Ayo0Rddz
	6dHHEu8bsVa8rQ1nB2IbTAMEljDI2wZ8=
X-Gm-Gg: AY/fxX71BOSJYCC51/gQrbD/1fqWRC7OI7rrTX9379gV66asMVcu5QV/iTKk/VcW3Hj
	NuXiaITmp+S9NSqpJSCMHEjIoG0z3xqXi3D4vYrmAzAVQQpIZISul9Oj9FLE5xjy1h+7ibJf0u3
	+eSTSN/YXH+/21hwFO786MgWz7Hi+apaOJSXz7X5vbLhry/y5goElMWaTIGIb2ON8QMJ/7x8k1R
	+S/hQ0Sawu2OBsGBn+w2Wu+6PYEX8E/r/ojcd6QluBblrf0W2kMf65Nk3sFyyHJoGAonxxMqyzO
	5hu/rwA=
X-Google-Smtp-Source: AGHT+IF9tdnOMa00I4abq/UILeD7zvauRjNo2FyYnd8GSGh0RaD0o2RaBQgz3oFY/uOPB2LkcyqnZFtpHMj95MM9uu8=
X-Received: by 2002:a17:907:608d:b0:b76:f57a:b0a7 with SMTP id
 a640c23a62f3a-b803705129emr622346066b.31.1766223520886; Sat, 20 Dec 2025
 01:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-5-dolinux.peng@gmail.com> <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
 <CAErzpmv1N1JA+=c6xxdYTqANqSBRaRauD2wzZiwUS+VeWQG14A@mail.gmail.com> <CAEf4BzZrZZ-YHHAUE-izLaAexm4VZ7aCurKnOofCtKaV=D9qvQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZrZZ-YHHAUE-izLaAexm4VZ7aCurKnOofCtKaV=D9qvQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 20 Dec 2025 17:38:27 +0800
X-Gm-Features: AQt7F2rOdVa0tLzJRlVZisBrGAmLwaReHjqlQiGeCmam4NMv_HPQrphQFUBjxXg
Message-ID: <CAErzpmvpmx=WM7kHLC-WFbCx0=OpK5f8KJJuOA8gyb7LmRjk2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 1:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 6:53=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Fri, Dec 19, 2025 at 7:29=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > >
> > > > This patch introduces binary search optimization for BTF type looku=
ps
> > > > when the BTF instance contains sorted types.
> > > >
> > > > The optimization significantly improves performance when searching =
for
> > > > types in large BTF instances with sorted types. For unsorted BTF, t=
he
> > > > implementation falls back to the original linear search.
> > > >
> > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c | 103 ++++++++++++++++++++++++++++++++++------=
----
> > > >  1 file changed, 80 insertions(+), 23 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > +       l =3D start_id;
> > > > +       r =3D end_id;
> > > > +       while (l <=3D r) {
> > > > +               m =3D l + (r - l) / 2;
> > > > +               t =3D btf_type_by_id(btf, m);
> > > > +               tname =3D btf__str_by_offset(btf, t->name_off);
> > > > +               ret =3D strcmp(tname, name);
> > > > +               if (ret < 0) {
> > > > +                       l =3D m + 1;
> > > > +               } else {
> > > > +                       if (ret =3D=3D 0)
> > > > +                               lmost =3D m;
> > > > +                       r =3D m - 1;
> > > > +               }
> > > >         }
> > >
> > > this differs from what we discussed in [0], you said you'll use that
> > > approach. Can you please elaborate on why you didn't?
> > >
> > >   [0] https://lore.kernel.org/bpf/CAEf4Bzb3Eu0J83O=3DY4KA-LkzBMjtx7cb=
onxPzkiduzZ1Pedajg@mail.gmail.com/
> >
> > Yes. As mentioned in the v8 changelog [1], the binary search approach
> > you referenced was implemented in versions v6 and v7 [2]. However,
> > testing revealed a slight performance regression. The root cause was
> > an extra strcmp operation introduced in v7, as discussed in [3]. Theref=
ore,
> > in v8, I reverted to the approach from v5 [4] and refactored it for cla=
rity.
>
> If you keep oscillating like that this patch set will never land. 4%
> (500us) gain on artificial and unrealistic micro-benchmark is
> meaningless and irrelevant, you are just adding more work for yourself
> and for reviewers by constantly changing your implementation between
> revisions for no good reason.

Thank you, I understand and will learn from it. I think the performance gai=
n
makes sense. I=E2=80=99d like to share a specific real-world case where thi=
s
optimization
could matter:  the `btf_find_by_name_kind()` function is indeed infrequentl=
y
used by the BPF subsystem, but it=E2=80=99s heavily relied upon by the ftra=
ce
subsystem=E2=80=99s features like `func-args`, `funcgraph-args` [1], and th=
e upcoming
`funcgraph-retval` [2]. These features invoke the function nearly once per
trace line when outputting, with a call frequency that can reach **100=E2=
=80=AFkHz**
in intensive tracing workloads.

In such scenarios, the extra `strcmp` operations translate to ~100,000
additional
string comparisons per second. While this might seem negligible in isolatio=
n,
the overhead accumulates under high-frequency tracing=E2=80=94potentially i=
mpacting
latency for users relying on detailed function argument/return value tracin=
g.

Thanks again for pushing for rigor=E2=80=94it helps make the code more clea=
ner
and robust.

[1] https://lore.kernel.org/all/20250227185822.639418500@goodmis.org/
[2] https://lore.kernel.org/all/20251215034153.2367756-1-dolinux.peng@gmail=
.com/

>
>
> >
> > Benchmark results show that v8 achieves a 4.2% performance improvement
> > over v7. If we don't care the performance gain, I will revert to the ap=
proach
> > in v7 in the next version.
> >
> > [1] https://lore.kernel.org/bpf/20251126085025.784288-1-dolinux.peng@gm=
ail.com/
> > [2] https://lore.kernel.org/all/20251119031531.1817099-1-dolinux.peng@g=
mail.com/
> > [3] https://lore.kernel.org/all/CAEf4BzaqEPD46LddJHO1-k5KPGyVWf6d=3DduD=
AxG1q=3DjykJkMBg@mail.gmail.com/
> > [4] https://lore.kernel.org/all/20251106131956.1222864-4-dolinux.peng@g=
mail.com/
> >
> > >
> > > >
> > > > -       return libbpf_err(-ENOENT);
> > > > +       return lmost;
> > > >  }
> > > >
> > > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int star=
t_id,
> > > >                                    const char *type_name, __u32 kin=
d)
> > >
> > > kind is defined as u32 but you expect caller to pass -1 to ignore the
> > > kind. Use int here.
> >
> > Thanks, I will fix it.
> >
> > >
> > > >  {
> > > > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > > +       const struct btf_type *t;
> > > > +       const char *tname;
> > > > +       __s32 idx;
> > > > +
> > > > +       if (start_id < btf->start_id) {
> > > > +               idx =3D btf_find_by_name_kind(btf->base_btf, start_=
id,
> > > > +                                           type_name, kind);
> > > > +               if (idx >=3D 0)
> > > > +                       return idx;
> > > > +               start_id =3D btf->start_id;
> > > > +       }
> > > >
> > > > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void")=
)
> > > > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =
=3D=3D 0)
> > > >                 return 0;
> > > >
> > > > -       for (i =3D start_id; i < nr_types; i++) {
> > > > -               const struct btf_type *t =3D btf__type_by_id(btf, i=
);
> > > > -               const char *name;
> > > > +       if (btf->sorted_start_id > 0 && type_name[0]) {
> > > > +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > > +
> > > > +               /* skip anonymous types */
> > > > +               start_id =3D max(start_id, btf->sorted_start_id);
> > >
> > > can sorted_start_id ever be smaller than start_id?
> > >
> > > > +               idx =3D btf_find_by_name_bsearch(btf, type_name, st=
art_id, end_id);
> > >
> > > is there ever a time when btf_find_by_name_bsearch() will work with
> > > different start_id and end_id? why is this not done inside the
> > > btf_find_by_name_bsearch()?
> >
> > Because the start_id could be specified by the caller.
>
> Right, start_id has to be passed in. But end_id is always the same, so
> maybe determine it internally instead? And let's not return -ENOENT

Thanks, I agree and will put the end_id into btf_find_by_name_bsearch.

> from btf_find_by_name_bsearch(), as I mentioned before, it would be
> more streamlined if you return btf__type_cnt(btf) if search failed.

Thanks, I agree.

>
> >
> > >
> > > > +               if (unlikely(idx < 0))
> > > > +                       return libbpf_err(-ENOENT);
> > >
> > > pass through error returned from btf_find_by_name_bsearch(), why rede=
fining it?
> >
> > Thanks, I will fix it.
> >
>
> see above, by returning btf__type_cnt() you won't even have this error
> handling, you'll just go through normal loop checking for a match and
> won't find anything, returning -ENOENT then.

Thanks, I agree.

>
> > >
> > > > +
> > > > +               if (unlikely(kind =3D=3D -1))
> > > > +                       return idx;
> > > > +
> > > > +               t =3D btf_type_by_id(btf, idx);
> > > > +               if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> > >
> > > use btf_kind(), but this whole extra check is just unnecessary, this
> >
> > Thanks, I will do it.
> >
> > > should be done in the loop below. We talked about all this already,
> > > why do I feel like I'm being ignored?..
> >
> > Sorry for the confusion, and absolutely not ignoring you.
> >
>
> If you decide to change implementation due to some unforeseen factors
> (like concern about 4% microbenchmark improvement), it would be
> helpful for you to call this out in a reply to the original
> discussion. A line somewhere in the cover letter changelog is way too
> easy to miss and that doesn't give me an opportunity to stop you
> before you go and produce another revision that I'll then be
> rejecting.

I will learn from it and thank you for the suggestion.

>
> > >
> > > > +                       return idx;
> > >
> > > drop all these likely and unlikely micro optimizations, please
> >
> > Thanks, I will do it.
> >
> > >
> > >
> > > > +
> > > > +               for (idx++; idx <=3D end_id; idx++) {
> > > > +                       t =3D btf__type_by_id(btf, idx);
> > > > +                       tname =3D btf__str_by_offset(btf, t->name_o=
ff);
> > > > +                       if (strcmp(tname, type_name) !=3D 0)
> > > > +                               return libbpf_err(-ENOENT);
> > > > +                       if (btf_kind(t) =3D=3D kind)
> > > > +                               return idx;
> > > > +               }
> > > > +       } else {
> > > > +               __u32 i, total;
> > > >
> > > > -               if (btf_kind(t) !=3D kind)
> > > > -                       continue;
> > > > -               name =3D btf__name_by_offset(btf, t->name_off);
> > > > -               if (name && !strcmp(type_name, name))
> > > > -                       return i;
> > > > +               total =3D btf__type_cnt(btf);
> > > > +               for (i =3D start_id; i < total; i++) {
> > > > +                       t =3D btf_type_by_id(btf, i);
> > > > +                       if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > >
> > > nit: kind < 0, no need to hard-code -1
> >
> > Good, I will fix it.
> >
> > >
> > > > +                               continue;
> > > > +                       tname =3D btf__str_by_offset(btf, t->name_o=
ff);
> > > > +                       if (strcmp(tname, type_name) =3D=3D 0)
> > > > +                               return i;
> > > > +               }
> > > >         }
> > > >
> > > >         return libbpf_err(-ENOENT);
> > > >  }
> > > >
> > >
> > > [...]

