Return-Path: <bpf+bounces-77897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F3CF6178
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 01:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2CA83046575
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E81BBBE5;
	Tue,  6 Jan 2026 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RegCasxz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56624A33
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659781; cv=none; b=EaciryKkkMFOgdHq3rcPTlwKdNxjHKJKYAUNmi+uY5ueERJQDEXNm16RMP6bWqE1mVcSwpU5iEOCYLKIELAXUapsZBFaozKD/LYP3ocK4k8tDm/ZxyimQ1NLoc4pgsmLw28xXJ+PuhyoubYcrTHL7jIrE5UE9QuAo4cgYoQZFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659781; c=relaxed/simple;
	bh=1luL4mdhsHlNFo6fvzhLuVz0DsEkiUFCsmlZ0pzsSrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nun8PBzwEklkVjKPIET+BEdaFUf5LDBUqrMHBykp4OijB9IcdmDwVon1YtwfCPSO8wS8XDW92DpCXawQnf46FdiZ01xV1hM0zqotUDhrpV6AvTEvijFV6AT9+EItygi4idubLQ3T3IqXZPpcu62W9qUUqQQ3Xjqgric/DeeXDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RegCasxz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so624039a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 16:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767659779; x=1768264579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzDWosFi526k2GTj3TOJmox+IqiH+JnvR+Pd+Lyo/TI=;
        b=RegCasxzmkErNkE4cK0zumMESazgHslo6/dSwP02byv3axaxKQ9HLob0I/alxF7F9D
         XXP2NIsmRs0bUSJQBoj/gHIN3DkifzileY085uOLtr4ckdNaUMW35W27NbRcv/lz9Mqt
         kfi97MDWuVEKGSyah2pYrE/mfxUsA6AzLbmyfyQe1+P+AvKKldw7ZTDRK3xdBWQwzPLq
         C7yoTPPezne2YQanJ8dWBLXHGrkj48PHe+nurr9jDo7tIJNMwtesPFYUyLofp7GpZfxp
         wDUnkvzUp+yHlVrQIHqfU0/8fZUqduv0Niqf5+gPyKmRMeuRdfKRDMRGAm0ODptK2qcG
         LVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767659779; x=1768264579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzDWosFi526k2GTj3TOJmox+IqiH+JnvR+Pd+Lyo/TI=;
        b=PsNGOr6V+DRNXQO/iyN0nemYQf4Ses1vyW0jH6zoFgi8BmLUqlchDqvzmpyUB/ngME
         xXYgY7O/T348mHiK1jAWqvXl8WL5eC46ckJGxw27V6nnXxBzrLDltQ4CKsR3FwUi0lzU
         COY6uDJ63DtLjm5DzR/BrzCnQ/cOaVrfRt2yF5mvHkE1lU5YQPyN7XrEgIy7S3Iu9tYi
         ZEGrw9BZH6YvZK6YmvVetnOKtivhf2Z5M6lVzoDnRiI6GQA1L+RjHhm62vYA+bAmc5zX
         dL9zl3Si7cpbRSAMse70aYgIXdimYmwM9RtxLLqcxdAOT1gg/w4C9L0jzu+Ij1vtPMxL
         M1eA==
X-Forwarded-Encrypted: i=1; AJvYcCXuUJyQ7/Pbvc7YAS+Da3aVkfkY47p8t9cnPG/kZfacRFP3UgSHVG6pC4RMNajyAIH4VWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySc7uQL5qpPzsI/wZiCb48CAKcrt4+cHlgMCdxSNIetDqw9nkD
	PRTcelH95sU2zU+j1ZtyQh8lgC9W6BxB0I8pCrcgXrCcj3Nj4rInd8PTdJS8V1tJmp91aKidYkL
	xLl/ZfCOeBIwj9h31Otp33tZrMYvWMzQ=
X-Gm-Gg: AY/fxX4GSj/lUudqXkMk8U+DcsxTcZRu65waw2PFZTXbOYZRZyLxf2Ph1yICPH6H7sQ
	JDitR3ZFiEKEKlU5bUQjYFLg5Qz9CKkWOWEcEwxAV5Pp9NuNdzRHOzOpjHp/wmjjY87xTqKVPTd
	fHrBXziR5PVw5PtSw9KetbpbD0f+/9qepRv4N/reNLdJZURYL6DresqEAJOzB6BNlyzvox5QD7B
	0hJYZQepFHlDXurzE1zM4Xo6AJEjqld8191/8FtK0NLyaVQfYjuxR9Dh3dKkqEEYfl2p5W/nGn5
	ZtFDnbB3QL0=
X-Google-Smtp-Source: AGHT+IGaq4nV9rT2IikXOLC5buF0kWJUKb6Pxr5o1fVAMfZzFiIuIaqDkHL0CEPQYno51nkfNN2TcDZe2Qyyt6XlNcY=
X-Received: by 2002:a17:90b:3843:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-34f5f26e0cfmr873124a91.4.1767659779081; Mon, 05 Jan 2026
 16:36:19 -0800 (PST)
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
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 16:36:07 -0800
X-Gm-Features: AQt7F2oo4zrqdALy9hXqYi2bNPhd4VHGmwOW0Y1qjwvkt9UBt3iFaAsqckLsq80
Message-ID: <CAEf4BzZ2suink0XjpZBZoLtDXHL3eKRJHwtmRQ4M2uuAhepwow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 1:38=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
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
>
> In such scenarios, the extra `strcmp` operations translate to ~100,000
> additional
> string comparisons per second. While this might seem negligible in isolat=
ion,

I'm pretty confident it is quite negligible compared to all other
*useful* work you'll have to do to use that BTF type to format those
arguments. Yes, 100KHz is pretty frequent, but it won't be anywhere
close to 4% if you profile the entire end-to-end overhead of emitting
arguments using func-args.

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

[...]

