Return-Path: <bpf+bounces-77914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB41CF67F1
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 03:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46650302F804
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460423958A;
	Tue,  6 Jan 2026 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmIItohc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652322129F
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667339; cv=none; b=GVe5Bllzdezkmbduo0IqpwKwLDwHwOmeLHG0XZsyi8Q7YeBJ0DROylYMaLk9nqD62wqy1eBav9k8TCXgh1S74D3viwzS9Dd3mlGPoovBhdxbWDmkUpI35STtEiUTb/GTwfU5cOVorXGAjmmGS2wfDIa23vp9KyQfVVWGJM8/9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667339; c=relaxed/simple;
	bh=egowWEGGvld9LsOjvwUExY9qO/HqnBrY0nQfy9J9IFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oard03C3gsJIQhjMHzeF6nzqo44MS4sPRBkGg8lIzgymgD8O86gEld4NP+uxtT0o6yDzhVXFssT2HwwQeyg6ZPSAFhQln1KA+G0R0XMqGOh36Vb2UqD4wbOVU05+m+fvYrggt66D3/LvblelMxLZShM92v/a4RtopV2G9IMdFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmIItohc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7355f6ef12so110246866b.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 18:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767667336; x=1768272136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVm5nnyJeDI91cm8fdzWAUknzYuRuxp5niNwz67R+FQ=;
        b=NmIItohcD0AoOEuc1D7ecGanIrd02UEGtgnLQcKaR9p8Rw7siI/MCnGgSPoCrLok7d
         oDe9YCC7cveeHax+Fytat5gh3bSFkEHXnYX/oTxLL+C2XdNw2duqfDZjcjXkhV5nTh5C
         HdxxjYclkGGB4xo5Ik66lQrKmHH6Q5//5JUAcaI7xggRg/XVzqSXdZeoYouaE/cYM6Ec
         eEJADszqUuOLt7mx58PwoiNFApvmHkkNXznjI74Hu4f6Hv76n4mZjRorlXEJxg2louYl
         hTz/dDIK49zjYp+oia+J1cmCp/bQSq7Z9HAWuniNxvV/pSJwHAyWiOPmSGUaJvJR2o2c
         szkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767667336; x=1768272136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uVm5nnyJeDI91cm8fdzWAUknzYuRuxp5niNwz67R+FQ=;
        b=Ah+cm5ncqXTfOkhM2eVM9x5wSDg5irLWJlPNYbPbmiG84Z+K7zcdRjLrYXzyu1wDSv
         U1yf5RbPwe7g5hTjMx7N70iXQeNsRyONgW2Z1u+jryh4uy4UxGP0XzeXewmAJMbgB1Wq
         Mqvu7UaJECXGdj1KUTjW3P+wA33spGLpEjh9E15lbGkdFEMtfwKF9K+KhWYHrOuY+kL6
         HlheQLpLUZSK47+6l+boV3NHaj36+lHRkOJsLzt8FBI2blHMrVKxgG6H22IOkUUVu9G6
         5yEJKe8r6n3d5+Wa/XwEi5Jj6f5imnvge9x8bpWvh2e4SWPKEIndJG3hKL0ow5ZCACrb
         SQOw==
X-Forwarded-Encrypted: i=1; AJvYcCUy4n3Y2jZ9OVCzcQvPp85sCqNcKq9fR9NnV9hxC3HP5kRP9yYSVkyJHN4bJHgoCcOPzVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg3XCY0otIS2xZGVXUbCG8L2egkZ2G2U6kNO7GZoqzlST599HA
	c8MqJ5lrqobtz0PaSmYWFRxn360mmCbuJweSZrn0UXfa1949zq7J7fxeViqA2gBqjcEpFIUR1zt
	gC2BlqixsNeJDnOl0Xb/IA6jYtTwNw/4C9LH8Jck=
X-Gm-Gg: AY/fxX73btLIe39TTQ0X+RO78xkAtR8uue23Txxd5uccKIzF2ehWmC2dZJdb7TtO9aZ
	kF7wTirWo9sLjMV/2no1dMfBsJDJcwluVF6TcI+EhbE+Wa82Plc0Db7h2ALzRZNlzbSWgbuY912
	SIUPTJPZ1v7KCKXPprzg60vx21x4k1CrhcuFV8aMuFREGKUPbaXWU+P0Ge/T+ot919xHZzJ89Ca
	Ef+1JD8yB9fPVv4/DINpXyW0zpUk1e1+C3xPkAzqs6NBW3k7tXOF34gJIMhOx2566acyMrl
X-Google-Smtp-Source: AGHT+IG4c/8OreBafKDwWBf+2dZZXXaUnsTk5G2csYk2edaSDmgNBl8x4987U3gIu/7ElKKM6uA/NgqIchMCbw+63w8=
X-Received: by 2002:a17:907:3c89:b0:b7a:32:3d60 with SMTP id
 a640c23a62f3a-b8426a4f4damr170039666b.11.1767667335329; Mon, 05 Jan 2026
 18:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-5-dolinux.peng@gmail.com> <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
 <CAErzpmv1N1JA+=c6xxdYTqANqSBRaRauD2wzZiwUS+VeWQG14A@mail.gmail.com>
 <CAEf4BzZrZZ-YHHAUE-izLaAexm4VZ7aCurKnOofCtKaV=D9qvQ@mail.gmail.com>
 <CAErzpmvpmx=WM7kHLC-WFbCx0=OpK5f8KJJuOA8gyb7LmRjk2g@mail.gmail.com>
 <CAErzpmuE+bKVn7_nx+Ug=3fGcOkNKGXNYk2pro8OM_EZOqzG4w@mail.gmail.com> <CAEf4BzZ-27YRE=XmxCmWpDkptu7PXEnrWn3KmUXOCJtJeGYpxA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ-27YRE=XmxCmWpDkptu7PXEnrWn3KmUXOCJtJeGYpxA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 6 Jan 2026 10:42:04 +0800
X-Gm-Features: AQt7F2rekMFaDdBtO3eRW18Lv2MxQgj8KOfK-gDnofYvLD536k6w5w1bVykppKk
Message-ID: <CAErzpmv0KQh2-Yo1spHkTP-fkUiLeWVkJ4-R7toCUFrKVsgDhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Dec 21, 2025 at 5:58=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Sat, Dec 20, 2025 at 5:38=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > On Sat, Dec 20, 2025 at 1:28=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 18, 2025 at 6:53=E2=80=AFPM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Dec 19, 2025 at 7:29=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.p=
eng@gmail.com> wrote:
> > > > > > >
> > > > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > >
> > > > > > > This patch introduces binary search optimization for BTF type=
 lookups
> > > > > > > when the BTF instance contains sorted types.
> > > > > > >
> > > > > > > The optimization significantly improves performance when sear=
ching for
> > > > > > > types in large BTF instances with sorted types. For unsorted =
BTF, the
> > > > > > > implementation falls back to the original linear search.
> > > > > > >
> > > > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > > ---
> > > > > > >  tools/lib/bpf/btf.c | 103 ++++++++++++++++++++++++++++++++++=
----------
> > > > > > >  1 file changed, 80 insertions(+), 23 deletions(-)
> > > > > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > +       l =3D start_id;
> > > > > > > +       r =3D end_id;
> > > > > > > +       while (l <=3D r) {
> > > > > > > +               m =3D l + (r - l) / 2;
> > > > > > > +               t =3D btf_type_by_id(btf, m);
> > > > > > > +               tname =3D btf__str_by_offset(btf, t->name_off=
);
> > > > > > > +               ret =3D strcmp(tname, name);
> > > > > > > +               if (ret < 0) {
> > > > > > > +                       l =3D m + 1;
> > > > > > > +               } else {
> > > > > > > +                       if (ret =3D=3D 0)
> > > > > > > +                               lmost =3D m;
> > > > > > > +                       r =3D m - 1;
> > > > > > > +               }
> > > > > > >         }
> > > > > >
> > > > > > this differs from what we discussed in [0], you said you'll use=
 that
> > > > > > approach. Can you please elaborate on why you didn't?
> > > > > >
> > > > > >   [0] https://lore.kernel.org/bpf/CAEf4Bzb3Eu0J83O=3DY4KA-LkzBM=
jtx7cbonxPzkiduzZ1Pedajg@mail.gmail.com/
> > > > >
> > > > > Yes. As mentioned in the v8 changelog [1], the binary search appr=
oach
> > > > > you referenced was implemented in versions v6 and v7 [2]. However=
,
> > > > > testing revealed a slight performance regression. The root cause =
was
> > > > > an extra strcmp operation introduced in v7, as discussed in [3]. =
Therefore,
> > > > > in v8, I reverted to the approach from v5 [4] and refactored it f=
or clarity.
> > > >
> > > > If you keep oscillating like that this patch set will never land. 4=
%
> > > > (500us) gain on artificial and unrealistic micro-benchmark is
> > > > meaningless and irrelevant, you are just adding more work for yours=
elf
> > > > and for reviewers by constantly changing your implementation betwee=
n
> > > > revisions for no good reason.
> > >
> > > Thank you, I understand and will learn from it. I think the performan=
ce gain
> > > makes sense. I=E2=80=99d like to share a specific real-world case whe=
re this
> > > optimization
> > > could matter:  the `btf_find_by_name_kind()` function is indeed infre=
quently
> > > used by the BPF subsystem, but it=E2=80=99s heavily relied upon by th=
e ftrace
> > > subsystem=E2=80=99s features like `func-args`, `funcgraph-args` [1], =
and the upcoming
> > > `funcgraph-retval` [2]. These features invoke the function nearly onc=
e per
> > > trace line when outputting, with a call frequency that can reach **10=
0=E2=80=AFkHz**
> > > in intensive tracing workloads.
> >
> > Hi Andrii,
> > I think we can refactor the code based on your suggestion like this:
> >
> > 1. If the binary search finds the matching name type, return its index.
> >     Else, return btf__type_cnt(btf). It will make the code streamlined.
> > 2. Skip the name checking in the first loop to eliminate the extra strc=
mp.
> >
> > What do you think?
> >
> > tatic __s32 btf_find_by_name_bsearch(const struct btf *btf, const char =
*name,
> >                                       __s32 start_id)
> > {
> >         const struct btf_type *t;
> >         const char *tname;
> >         __s32 end_id =3D btf__type_cnt(btf) - 1;
> >         __s32 l, r, m, lmost =3D end_id + 1;
> >         int ret;
> >
> >         l =3D start_id;
> >         r =3D end_id;
> >         while (l <=3D r) {
> >                 m =3D l + (r - l) / 2;
> >                 t =3D btf_type_by_id(btf, m);
> >                 tname =3D btf__str_by_offset(btf, t->name_off);
> >                 ret =3D strcmp(tname, name);
> >                 if (ret < 0) {
> >                         l =3D m + 1;
> >                 } else {
> >                         if (ret =3D=3D 0)
> >                                 lmost =3D m;
> >                         r =3D m - 1;
> >                 }
> >         }
> >
> >         return lmost;
> > }
> >
> > static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
> >                                    const char *type_name, __u32 kind)
> > {
> >        ......
> >        if (btf_is_sorted(btf) && type_name[0]) {
> >                 bool first_loop =3D true;
> >
> >                 start_id =3D max(start_id, btf_sorted_start_id(btf));
> >                 idx =3D btf_find_by_name_bsearch(btf, type_name, start_=
id);
> >                 for (; idx < btf__type_cnt(btf); idx++) {
> >                         t =3D btf__type_by_id(btf, idx);
> >                         tname =3D btf__str_by_offset(btf, t->name_off);
> >                         if (!first_loop && strcmp(tname, type_name) !=
=3D 0)
> >                                 return libbpf_err(-ENOENT);
>
> no, let's keep it simple, please revert to previous implementation we
> agreed upon

Okay. I will do it.

>
> >                         if (kind =3D=3D -1 || btf_kind(t) =3D=3D kind)
> >                                 return idx;
> >                         if (first_loop)
> >                                 first_loop =3D false;
> >                 }
> >         } else {
> >                 ......
> >         }
> >
> >         return libbpf_err(-ENOENT);
> > }
> >
> > >
> > > In such scenarios, the extra `strcmp` operations translate to ~100,00=
0
> > > additional
> > > string comparisons per second. While this might seem negligible in is=
olation,
> > > the overhead accumulates under high-frequency tracing=E2=80=94potenti=
ally impacting
> > > latency for users relying on detailed function argument/return value =
tracing.
> > >
> > > Thanks again for pushing for rigor=E2=80=94it helps make the code mor=
e cleaner
> > > and robust.
> > >
> > > [1] https://lore.kernel.org/all/20250227185822.639418500@goodmis.org/
> > > [2] https://lore.kernel.org/all/20251215034153.2367756-1-dolinux.peng=
@gmail.com/
> > >
>
> [...]

