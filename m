Return-Path: <bpf+bounces-77898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB25CF617E
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 01:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96BE7304F140
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 00:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3811A1C5D59;
	Tue,  6 Jan 2026 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJm70Sj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFED12B94
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 00:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659904; cv=none; b=QORGQpbpeKzfiuobnuJ1IeCSI2t0x2hLjz/aOaEO5DPUTE1P0ZmRA6+ifEcvy/xDcCTSLQ0RGU087DUOyqBD3QU/6fFsLb71eG9e/rwpFzrcqUkOIqqfZuBeUUw6v1jw+FNa09mVo5GDKDPt8UcJk26OHF5NxNIMvuxhjc1SUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659904; c=relaxed/simple;
	bh=rERWV7O0CcQsrfIouvXmvEXsone/7NEP1LFUUE6kado=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQzqepGjNfTGoRGHjsebiPVaAf212xs8CBac3RckplislrIzRvisMfPdKzYrqVpgA1/JkrYkIUW45ty2YebAflDU/hF4OZtnfztznh2bS2bSzF0GjIaB2nglBb2kLitTLsXwt/lDhG6zvAZVNf543upzQ+qDZUwUiZvtlhIk/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJm70Sj7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso524919a91.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 16:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767659902; x=1768264702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOiP6TQYlO4ogCR8ymysffKGJoXfH/tNjvvgGuMC2zA=;
        b=jJm70Sj7FGl3910dfLYyjsVbR7H8Nyrtb7+ZvfuuLIXWir5bmbD8kfiJoUy4Rzhh99
         ixqkgd9DvTM+a4j6LIzfiz4gY0jeRyFunQNa2LAUKPa39t7WWqGJ9N/1YQJvrAz4Z+em
         aY4SW5A2KLhqGY8WaacyUIgoU7gqjg9XX72Yn4q5182DNdbvuEINJ36YIEGnPy/rfhnq
         uRlTyBoXe/sbT6lc7kxbLTaTNNFdcip0D3fJWs2GGHNqMfZIe0QpQ/qQ51qaBj/B5NbM
         B/kBk9+2mRFI3tXICm/PW0Ilby6ILaWKDUmBORqavOd9xDayhmTTzH52aA8KTYnBs16a
         8VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767659902; x=1768264702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wOiP6TQYlO4ogCR8ymysffKGJoXfH/tNjvvgGuMC2zA=;
        b=lbkfTRjoIYSFHNMQ7XqLeNpWt1ezdP4dhERN5I5ogXzqDn8+v+GF1OUVcPxyUB1Xjf
         0UwQVmYJbg3D7WzYuo2CHQY0R5PD2PLDLqrPBxzVYEAQ1KGzv9reAOn8gwtZr4N/cM8+
         nMLeH9M+E7041h1qUeMtgkKt9Gaivt7rrJYQIjIsLIrA5/v4V3zAI7OMm/EIpZZ2BxF9
         NAb/c2UyyLceBGSQ9qCTUFLBLrWy7Gjhf3XHYQZ5RzsUMf7EZWoBIpjwoU2MUavLsT0+
         NmGIATj5TFuvDt5DtinEUTbpFPLRQnqVWEFn5oB5dP5a0vNvHGN13aVFqp4wGHre6g/C
         3zWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGF48SP7bWLG6Hi4cgRX+jBG7wMggddIXmmGSqaXgXNbdIs+hrvlVbc7Xb0FRpjQxiIik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKz7wN8yWQcZgGWewwl2k5ieYUzvBVdCJ6hUNjeFAo/8bKj8p
	CSAuC9UTSXdlLtMyB7AG/S7/3mxGrb1ZhY/DrssaAplIhfhdpFHlwyUZlTf7j9QC1voFQ5rwT2A
	XGtWBVab/oBBeeB1rVTW81ql4+PksVqk=
X-Gm-Gg: AY/fxX48c/MkrRvLmrTKAVOZXuB1lGr1A6VXkYIezpaZtvKv9ds3UfkKSTYigdKyiH7
	as/4RMZAhDYatOxdKUaYXbLJrfYIdxWIopBmCZ5YZXy7dRAL5ryGBr2Aw1DZtZXmyZwChascJdi
	63a5zh0zytP6cOvH9YRuPBKbNIdiWeWnmEOEW9rEJoQO9lY+vNzQwLGINUb1sgjesDTxyB6b0Gi
	vPYl3drFO0uzSNRTNnFtGRgkvC0mZaBcB8/6GVHiEghHZJqJf+9wMzMdjM0Y5CoquqLSSHXSvSL
	0hKkG+Cu31U=
X-Google-Smtp-Source: AGHT+IE0eHroknlvOLRLMPL0uinJx1nh+nJrugeGqg2K4J/onGIKUQHzLdNzZaTkGdjgENGb10MddeWBvMjAentrCnw=
X-Received: by 2002:a17:90b:4e8e:b0:341:ae23:85fd with SMTP id
 98e67ed59e1d1-34f5f28342amr730665a91.11.1767659902429; Mon, 05 Jan 2026
 16:38:22 -0800 (PST)
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
 <CAErzpmvpmx=WM7kHLC-WFbCx0=OpK5f8KJJuOA8gyb7LmRjk2g@mail.gmail.com> <CAErzpmuE+bKVn7_nx+Ug=3fGcOkNKGXNYk2pro8OM_EZOqzG4w@mail.gmail.com>
In-Reply-To: <CAErzpmuE+bKVn7_nx+Ug=3fGcOkNKGXNYk2pro8OM_EZOqzG4w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 16:38:10 -0800
X-Gm-Features: AQt7F2rJlOyKoUFvORCKEWJAG5w4R1JFmHEXrWXiWFyv40ZTKxQ_svqBZuIbbrU
Message-ID: <CAEf4BzZ-27YRE=XmxCmWpDkptu7PXEnrWn3KmUXOCJtJeGYpxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 5:58=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Sat, Dec 20, 2025 at 5:38=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Sat, Dec 20, 2025 at 1:28=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 6:53=E2=80=AFPM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Dec 19, 2025 at 7:29=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.pen=
g@gmail.com> wrote:
> > > > > >
> > > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > > >
> > > > > > This patch introduces binary search optimization for BTF type l=
ookups
> > > > > > when the BTF instance contains sorted types.
> > > > > >
> > > > > > The optimization significantly improves performance when search=
ing for
> > > > > > types in large BTF instances with sorted types. For unsorted BT=
F, the
> > > > > > implementation falls back to the original linear search.
> > > > > >
> > > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > ---
> > > > > >  tools/lib/bpf/btf.c | 103 ++++++++++++++++++++++++++++++++++--=
--------
> > > > > >  1 file changed, 80 insertions(+), 23 deletions(-)
> > > > > >
> > > > >
> > > > > [...]
> > > > >
> > > > > > +       l =3D start_id;
> > > > > > +       r =3D end_id;
> > > > > > +       while (l <=3D r) {
> > > > > > +               m =3D l + (r - l) / 2;
> > > > > > +               t =3D btf_type_by_id(btf, m);
> > > > > > +               tname =3D btf__str_by_offset(btf, t->name_off);
> > > > > > +               ret =3D strcmp(tname, name);
> > > > > > +               if (ret < 0) {
> > > > > > +                       l =3D m + 1;
> > > > > > +               } else {
> > > > > > +                       if (ret =3D=3D 0)
> > > > > > +                               lmost =3D m;
> > > > > > +                       r =3D m - 1;
> > > > > > +               }
> > > > > >         }
> > > > >
> > > > > this differs from what we discussed in [0], you said you'll use t=
hat
> > > > > approach. Can you please elaborate on why you didn't?
> > > > >
> > > > >   [0] https://lore.kernel.org/bpf/CAEf4Bzb3Eu0J83O=3DY4KA-LkzBMjt=
x7cbonxPzkiduzZ1Pedajg@mail.gmail.com/
> > > >
> > > > Yes. As mentioned in the v8 changelog [1], the binary search approa=
ch
> > > > you referenced was implemented in versions v6 and v7 [2]. However,
> > > > testing revealed a slight performance regression. The root cause wa=
s
> > > > an extra strcmp operation introduced in v7, as discussed in [3]. Th=
erefore,
> > > > in v8, I reverted to the approach from v5 [4] and refactored it for=
 clarity.
> > >
> > > If you keep oscillating like that this patch set will never land. 4%
> > > (500us) gain on artificial and unrealistic micro-benchmark is
> > > meaningless and irrelevant, you are just adding more work for yoursel=
f
> > > and for reviewers by constantly changing your implementation between
> > > revisions for no good reason.
> >
> > Thank you, I understand and will learn from it. I think the performance=
 gain
> > makes sense. I=E2=80=99d like to share a specific real-world case where=
 this
> > optimization
> > could matter:  the `btf_find_by_name_kind()` function is indeed infrequ=
ently
> > used by the BPF subsystem, but it=E2=80=99s heavily relied upon by the =
ftrace
> > subsystem=E2=80=99s features like `func-args`, `funcgraph-args` [1], an=
d the upcoming
> > `funcgraph-retval` [2]. These features invoke the function nearly once =
per
> > trace line when outputting, with a call frequency that can reach **100=
=E2=80=AFkHz**
> > in intensive tracing workloads.
>
> Hi Andrii,
> I think we can refactor the code based on your suggestion like this:
>
> 1. If the binary search finds the matching name type, return its index.
>     Else, return btf__type_cnt(btf). It will make the code streamlined.
> 2. Skip the name checking in the first loop to eliminate the extra strcmp=
.
>
> What do you think?
>
> tatic __s32 btf_find_by_name_bsearch(const struct btf *btf, const char *n=
ame,
>                                       __s32 start_id)
> {
>         const struct btf_type *t;
>         const char *tname;
>         __s32 end_id =3D btf__type_cnt(btf) - 1;
>         __s32 l, r, m, lmost =3D end_id + 1;
>         int ret;
>
>         l =3D start_id;
>         r =3D end_id;
>         while (l <=3D r) {
>                 m =3D l + (r - l) / 2;
>                 t =3D btf_type_by_id(btf, m);
>                 tname =3D btf__str_by_offset(btf, t->name_off);
>                 ret =3D strcmp(tname, name);
>                 if (ret < 0) {
>                         l =3D m + 1;
>                 } else {
>                         if (ret =3D=3D 0)
>                                 lmost =3D m;
>                         r =3D m - 1;
>                 }
>         }
>
>         return lmost;
> }
>
> static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
>                                    const char *type_name, __u32 kind)
> {
>        ......
>        if (btf_is_sorted(btf) && type_name[0]) {
>                 bool first_loop =3D true;
>
>                 start_id =3D max(start_id, btf_sorted_start_id(btf));
>                 idx =3D btf_find_by_name_bsearch(btf, type_name, start_id=
);
>                 for (; idx < btf__type_cnt(btf); idx++) {
>                         t =3D btf__type_by_id(btf, idx);
>                         tname =3D btf__str_by_offset(btf, t->name_off);
>                         if (!first_loop && strcmp(tname, type_name) !=3D =
0)
>                                 return libbpf_err(-ENOENT);

no, let's keep it simple, please revert to previous implementation we
agreed upon

>                         if (kind =3D=3D -1 || btf_kind(t) =3D=3D kind)
>                                 return idx;
>                         if (first_loop)
>                                 first_loop =3D false;
>                 }
>         } else {
>                 ......
>         }
>
>         return libbpf_err(-ENOENT);
> }
>
> >
> > In such scenarios, the extra `strcmp` operations translate to ~100,000
> > additional
> > string comparisons per second. While this might seem negligible in isol=
ation,
> > the overhead accumulates under high-frequency tracing=E2=80=94potential=
ly impacting
> > latency for users relying on detailed function argument/return value tr=
acing.
> >
> > Thanks again for pushing for rigor=E2=80=94it helps make the code more =
cleaner
> > and robust.
> >
> > [1] https://lore.kernel.org/all/20250227185822.639418500@goodmis.org/
> > [2] https://lore.kernel.org/all/20251215034153.2367756-1-dolinux.peng@g=
mail.com/
> >

[...]

