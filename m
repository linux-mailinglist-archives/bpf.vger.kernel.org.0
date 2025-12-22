Return-Path: <bpf+bounces-77280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF801CD4898
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 02:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8FCC3006A9A
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C9322A0A;
	Mon, 22 Dec 2025 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApySHT/R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9D25334B
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766368709; cv=none; b=CZ3SN4nkrebMXBxdSJv6XrAC+hsxtMCHDDVig+E0g+57fZH/923jweH7qy4sUHWEZd1cWNRpku6D0PbKEvfzb95BJkOsD9KF1lmZYDXClYRC4OZx9ltNdXEj1/k7hKqsIq4QLbACZ6Qz+kqWTaISWErw4CZEIhF1R3XqRMLCQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766368709; c=relaxed/simple;
	bh=uXKHfLERLgB3DGxAOrhvyzv0XmoqF4QIKbz4QrnPE9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbvSs4+gHbSGXwvqvzZ8xQI5EwJ6wRdzHbpZhWYpHZz6P8zozQTp9ZuwoQL8tsG8bvbCvBQtlPGsUPG//TRUmmfL1QUm7n9jt7Cvcpb/ElkdjKQNB7tS3CzlRLbhjqgInaIEQ2e3DAz4g+Qx9x6vIHIA7Nkpk33vwf5u16TbnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApySHT/R; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b713c7096f9so565401066b.3
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 17:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766368705; x=1766973505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81XM2zUKYs2PnlWFYZCPBK53M8nkrXo3uV9yB4u+Hj0=;
        b=ApySHT/RCbN8w4+MI0+NOcc8V1VAr1kUe7fZw3OReipC5Fy4MavKiKUkwRX5VhatXU
         7lBoO9ihhggCc5nvvF2y2O30FvgVaUlfD3E+lpJq04qbOQaNmNHl6JV/DWsjENoDWxz3
         3wKZEhLu88JFr89WlXgw6kzYYMC2eltqZCyl7pha76idcF6Fz8ugKZAfAARMPOCboINj
         7vhMS5LHiZabCikbyto2d/Lb54fWrb19zHZk4QFMUKtvLTtN/lpT1YvS7Y05rYX+a03Q
         7L97hBtaKjGCKc9ug2ca6UelelfG0zT4H0kCQR20Kj2ijoyRX5oTH5u0oG0PWvdjRX4B
         xsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766368705; x=1766973505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81XM2zUKYs2PnlWFYZCPBK53M8nkrXo3uV9yB4u+Hj0=;
        b=PgIW++bn8Id1/4xKrwCmyslRC5Z3bUfhVUbsEsZhWHVzVSloWvGpGVt5CBxZ3M1hcS
         CboqES14KlYPb702J8v6acxRcK4ih8n6+hyKRaCagEDMFUx34urtThYGt5JS3lTV4liU
         JQK7taWrI3keNIdvqfhfMkTMfeJiHikzj5brp1eeDrBzOmLkTkTAdbp5MPnD+EVwrBfl
         iYF5qyYrynF/4uzKvB4HiXr7b5NjI+wYntIIXa1ZCYC5oxRm7no4QgLAZCBpwD6K8Ikg
         V4RvcxzxsZZ9Rdq1ehLjGmJW1IM7xDGU5b046Pvj6VVMabDW/zAwnESfGdF7wYLtGycc
         y2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUf3veBc6QgpIbQpFgfnumMoMKoDy/4m8Uv6k1nb06Wy5WDTNR3tT3uuay7QMHUbFafMa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0KtW9Jp2daJ9lufxXDx3hbr6o1kbvKtWTwUmaKNrAO9y70H+U
	+Q3wFdH9tKz5Q423sAbXCyDOvGKYYIerUbHAYX/URKAOt1ACrr0u2GXXimdw4Ie94rbMDPPGz4a
	Vj2V7+hKwdf4F2f3YmMLY7Y3oakB+yB0=
X-Gm-Gg: AY/fxX6F5fkoFxQVHTNAGFSepGLMaeFgMDy456c9xwHciYlYrvTvMdY4yqQpn8knVoB
	Wx0mF596OqhWDbcYX67scRk7Opw2S2bvuX5bMK8e3u6EdRmYkNK+gqr81GkNS3xroR4hQQ9JQY2
	3BmXKGWoTcUlofZWT4X4O/W2ZVdpaDatz986fLU3Z1Rf0tEUxkzgTfxu6rmtede1Y3PAGZtyTvw
	CIcj+OjuIxvrBqkj4z+J62VzVPlvB+noF1zWS8GWJhohAP/57sQPqe8qIpL0t6oTm0cBDVf
X-Google-Smtp-Source: AGHT+IG0QJ3s0wVgm2urN0VGmWrcFCYZJ0fLY0ClVaThNE+GU/2lEupgtOFSNHQVcPXvzyolkJkT98+Apzy9aVtWkkg=
X-Received: by 2002:a17:907:7f0d:b0:b73:301c:b158 with SMTP id
 a640c23a62f3a-b8036ecdbf1mr922687566b.6.1766368704772; Sun, 21 Dec 2025
 17:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-5-dolinux.peng@gmail.com> <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
 <CAErzpmv1N1JA+=c6xxdYTqANqSBRaRauD2wzZiwUS+VeWQG14A@mail.gmail.com>
 <CAEf4BzZrZZ-YHHAUE-izLaAexm4VZ7aCurKnOofCtKaV=D9qvQ@mail.gmail.com> <CAErzpmvpmx=WM7kHLC-WFbCx0=OpK5f8KJJuOA8gyb7LmRjk2g@mail.gmail.com>
In-Reply-To: <CAErzpmvpmx=WM7kHLC-WFbCx0=OpK5f8KJJuOA8gyb7LmRjk2g@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 22 Dec 2025 09:58:13 +0800
X-Gm-Features: AQt7F2rKWemtIllZQRVK9LWPWkSG7mbOwNDVMQY0CSNBfjh0LKjslPo5ldBUjLM
Message-ID: <CAErzpmuE+bKVn7_nx+Ug=3fGcOkNKGXNYk2pro8OM_EZOqzG4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 5:38=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Sat, Dec 20, 2025 at 1:28=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 6:53=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > On Fri, Dec 19, 2025 at 7:29=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > >
> > > > > This patch introduces binary search optimization for BTF type loo=
kups
> > > > > when the BTF instance contains sorted types.
> > > > >
> > > > > The optimization significantly improves performance when searchin=
g for
> > > > > types in large BTF instances with sorted types. For unsorted BTF,=
 the
> > > > > implementation falls back to the original linear search.
> > > > >
> > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > ---
> > > > >  tools/lib/bpf/btf.c | 103 ++++++++++++++++++++++++++++++++++----=
------
> > > > >  1 file changed, 80 insertions(+), 23 deletions(-)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > +       l =3D start_id;
> > > > > +       r =3D end_id;
> > > > > +       while (l <=3D r) {
> > > > > +               m =3D l + (r - l) / 2;
> > > > > +               t =3D btf_type_by_id(btf, m);
> > > > > +               tname =3D btf__str_by_offset(btf, t->name_off);
> > > > > +               ret =3D strcmp(tname, name);
> > > > > +               if (ret < 0) {
> > > > > +                       l =3D m + 1;
> > > > > +               } else {
> > > > > +                       if (ret =3D=3D 0)
> > > > > +                               lmost =3D m;
> > > > > +                       r =3D m - 1;
> > > > > +               }
> > > > >         }
> > > >
> > > > this differs from what we discussed in [0], you said you'll use tha=
t
> > > > approach. Can you please elaborate on why you didn't?
> > > >
> > > >   [0] https://lore.kernel.org/bpf/CAEf4Bzb3Eu0J83O=3DY4KA-LkzBMjtx7=
cbonxPzkiduzZ1Pedajg@mail.gmail.com/
> > >
> > > Yes. As mentioned in the v8 changelog [1], the binary search approach
> > > you referenced was implemented in versions v6 and v7 [2]. However,
> > > testing revealed a slight performance regression. The root cause was
> > > an extra strcmp operation introduced in v7, as discussed in [3]. Ther=
efore,
> > > in v8, I reverted to the approach from v5 [4] and refactored it for c=
larity.
> >
> > If you keep oscillating like that this patch set will never land. 4%
> > (500us) gain on artificial and unrealistic micro-benchmark is
> > meaningless and irrelevant, you are just adding more work for yourself
> > and for reviewers by constantly changing your implementation between
> > revisions for no good reason.
>
> Thank you, I understand and will learn from it. I think the performance g=
ain
> makes sense. I=E2=80=99d like to share a specific real-world case where t=
his
> optimization
> could matter:  the `btf_find_by_name_kind()` function is indeed infrequen=
tly
> used by the BPF subsystem, but it=E2=80=99s heavily relied upon by the ft=
race
> subsystem=E2=80=99s features like `func-args`, `funcgraph-args` [1], and =
the upcoming
> `funcgraph-retval` [2]. These features invoke the function nearly once pe=
r
> trace line when outputting, with a call frequency that can reach **100=E2=
=80=AFkHz**
> in intensive tracing workloads.

Hi Andrii,
I think we can refactor the code based on your suggestion like this:

1. If the binary search finds the matching name type, return its index.
    Else, return btf__type_cnt(btf). It will make the code streamlined.
2. Skip the name checking in the first loop to eliminate the extra strcmp.

What do you think?

tatic __s32 btf_find_by_name_bsearch(const struct btf *btf, const char *nam=
e,
                                      __s32 start_id)
{
        const struct btf_type *t;
        const char *tname;
        __s32 end_id =3D btf__type_cnt(btf) - 1;
        __s32 l, r, m, lmost =3D end_id + 1;
        int ret;

        l =3D start_id;
        r =3D end_id;
        while (l <=3D r) {
                m =3D l + (r - l) / 2;
                t =3D btf_type_by_id(btf, m);
                tname =3D btf__str_by_offset(btf, t->name_off);
                ret =3D strcmp(tname, name);
                if (ret < 0) {
                        l =3D m + 1;
                } else {
                        if (ret =3D=3D 0)
                                lmost =3D m;
                        r =3D m - 1;
                }
        }

        return lmost;
}

static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
                                   const char *type_name, __u32 kind)
{
       ......
       if (btf_is_sorted(btf) && type_name[0]) {
                bool first_loop =3D true;

                start_id =3D max(start_id, btf_sorted_start_id(btf));
                idx =3D btf_find_by_name_bsearch(btf, type_name, start_id);
                for (; idx < btf__type_cnt(btf); idx++) {
                        t =3D btf__type_by_id(btf, idx);
                        tname =3D btf__str_by_offset(btf, t->name_off);
                        if (!first_loop && strcmp(tname, type_name) !=3D 0)
                                return libbpf_err(-ENOENT);
                        if (kind =3D=3D -1 || btf_kind(t) =3D=3D kind)
                                return idx;
                        if (first_loop)
                                first_loop =3D false;
                }
        } else {
                ......
        }

        return libbpf_err(-ENOENT);
}

>
> In such scenarios, the extra `strcmp` operations translate to ~100,000
> additional
> string comparisons per second. While this might seem negligible in isolat=
ion,
> the overhead accumulates under high-frequency tracing=E2=80=94potentially=
 impacting
> latency for users relying on detailed function argument/return value trac=
ing.
>
> Thanks again for pushing for rigor=E2=80=94it helps make the code more cl=
eaner
> and robust.
>
> [1] https://lore.kernel.org/all/20250227185822.639418500@goodmis.org/
> [2] https://lore.kernel.org/all/20251215034153.2367756-1-dolinux.peng@gma=
il.com/
>
> >
> >
> > >
> > > Benchmark results show that v8 achieves a 4.2% performance improvemen=
t
> > > over v7. If we don't care the performance gain, I will revert to the =
approach
> > > in v7 in the next version.
> > >
> > > [1] https://lore.kernel.org/bpf/20251126085025.784288-1-dolinux.peng@=
gmail.com/
> > > [2] https://lore.kernel.org/all/20251119031531.1817099-1-dolinux.peng=
@gmail.com/
> > > [3] https://lore.kernel.org/all/CAEf4BzaqEPD46LddJHO1-k5KPGyVWf6d=3Dd=
uDAxG1q=3DjykJkMBg@mail.gmail.com/
> > > [4] https://lore.kernel.org/all/20251106131956.1222864-4-dolinux.peng=
@gmail.com/
> > >
> > > >
> > > > >
> > > > > -       return libbpf_err(-ENOENT);
> > > > > +       return lmost;
> > > > >  }
> > > > >
> > > > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int st=
art_id,
> > > > >                                    const char *type_name, __u32 k=
ind)
> > > >
> > > > kind is defined as u32 but you expect caller to pass -1 to ignore t=
he
> > > > kind. Use int here.
> > >
> > > Thanks, I will fix it.
> > >
> > > >
> > > > >  {
> > > > > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > > > +       const struct btf_type *t;
> > > > > +       const char *tname;
> > > > > +       __s32 idx;
> > > > > +
> > > > > +       if (start_id < btf->start_id) {
> > > > > +               idx =3D btf_find_by_name_kind(btf->base_btf, star=
t_id,
> > > > > +                                           type_name, kind);
> > > > > +               if (idx >=3D 0)
> > > > > +                       return idx;
> > > > > +               start_id =3D btf->start_id;
> > > > > +       }
> > > > >
> > > > > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void=
"))
> > > > > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void"=
) =3D=3D 0)
> > > > >                 return 0;
> > > > >
> > > > > -       for (i =3D start_id; i < nr_types; i++) {
> > > > > -               const struct btf_type *t =3D btf__type_by_id(btf,=
 i);
> > > > > -               const char *name;
> > > > > +       if (btf->sorted_start_id > 0 && type_name[0]) {
> > > > > +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > > > +
> > > > > +               /* skip anonymous types */
> > > > > +               start_id =3D max(start_id, btf->sorted_start_id);
> > > >
> > > > can sorted_start_id ever be smaller than start_id?
> > > >
> > > > > +               idx =3D btf_find_by_name_bsearch(btf, type_name, =
start_id, end_id);
> > > >
> > > > is there ever a time when btf_find_by_name_bsearch() will work with
> > > > different start_id and end_id? why is this not done inside the
> > > > btf_find_by_name_bsearch()?
> > >
> > > Because the start_id could be specified by the caller.
> >
> > Right, start_id has to be passed in. But end_id is always the same, so
> > maybe determine it internally instead? And let's not return -ENOENT
>
> Thanks, I agree and will put the end_id into btf_find_by_name_bsearch.
>
> > from btf_find_by_name_bsearch(), as I mentioned before, it would be
> > more streamlined if you return btf__type_cnt(btf) if search failed.
>
> Thanks, I agree.
>
> >
> > >
> > > >
> > > > > +               if (unlikely(idx < 0))
> > > > > +                       return libbpf_err(-ENOENT);
> > > >
> > > > pass through error returned from btf_find_by_name_bsearch(), why re=
defining it?
> > >
> > > Thanks, I will fix it.
> > >
> >
> > see above, by returning btf__type_cnt() you won't even have this error
> > handling, you'll just go through normal loop checking for a match and
> > won't find anything, returning -ENOENT then.
>
> Thanks, I agree.
>
> >
> > > >
> > > > > +
> > > > > +               if (unlikely(kind =3D=3D -1))
> > > > > +                       return idx;
> > > > > +
> > > > > +               t =3D btf_type_by_id(btf, idx);
> > > > > +               if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> > > >
> > > > use btf_kind(), but this whole extra check is just unnecessary, thi=
s
> > >
> > > Thanks, I will do it.
> > >
> > > > should be done in the loop below. We talked about all this already,
> > > > why do I feel like I'm being ignored?..
> > >
> > > Sorry for the confusion, and absolutely not ignoring you.
> > >
> >
> > If you decide to change implementation due to some unforeseen factors
> > (like concern about 4% microbenchmark improvement), it would be
> > helpful for you to call this out in a reply to the original
> > discussion. A line somewhere in the cover letter changelog is way too
> > easy to miss and that doesn't give me an opportunity to stop you
> > before you go and produce another revision that I'll then be
> > rejecting.
>
> I will learn from it and thank you for the suggestion.
>
> >
> > > >
> > > > > +                       return idx;
> > > >
> > > > drop all these likely and unlikely micro optimizations, please
> > >
> > > Thanks, I will do it.
> > >
> > > >
> > > >
> > > > > +
> > > > > +               for (idx++; idx <=3D end_id; idx++) {
> > > > > +                       t =3D btf__type_by_id(btf, idx);
> > > > > +                       tname =3D btf__str_by_offset(btf, t->name=
_off);
> > > > > +                       if (strcmp(tname, type_name) !=3D 0)
> > > > > +                               return libbpf_err(-ENOENT);
> > > > > +                       if (btf_kind(t) =3D=3D kind)
> > > > > +                               return idx;
> > > > > +               }
> > > > > +       } else {
> > > > > +               __u32 i, total;
> > > > >
> > > > > -               if (btf_kind(t) !=3D kind)
> > > > > -                       continue;
> > > > > -               name =3D btf__name_by_offset(btf, t->name_off);
> > > > > -               if (name && !strcmp(type_name, name))
> > > > > -                       return i;
> > > > > +               total =3D btf__type_cnt(btf);
> > > > > +               for (i =3D start_id; i < total; i++) {
> > > > > +                       t =3D btf_type_by_id(btf, i);
> > > > > +                       if (kind !=3D -1 && btf_kind(t) !=3D kind=
)
> > > >
> > > > nit: kind < 0, no need to hard-code -1
> > >
> > > Good, I will fix it.
> > >
> > > >
> > > > > +                               continue;
> > > > > +                       tname =3D btf__str_by_offset(btf, t->name=
_off);
> > > > > +                       if (strcmp(tname, type_name) =3D=3D 0)
> > > > > +                               return i;
> > > > > +               }
> > > > >         }
> > > > >
> > > > >         return libbpf_err(-ENOENT);
> > > > >  }
> > > > >
> > > >
> > > > [...]

