Return-Path: <bpf+bounces-77916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE762CF683C
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 03:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D3D30255AC
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 02:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92F224B15;
	Tue,  6 Jan 2026 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBXqrP3x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDBA13C918
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667837; cv=none; b=Pm48IL7cn0+hziDfpbK+tYw2ZQCAiAKFnodb0nR8HKPWDQWPUOS0Cop2VcfSxA5I1ie4/tSbJDyfOKVv9NtJmUKCY8ZnT+krz69NnXFU9YKUncsNEMB+0BUPK93OkV6IyWEhrsbFahCn6D+PTaK2639Yph+QyLOrntgIGCT0MWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667837; c=relaxed/simple;
	bh=M6TdcvW9br3d58EuKZlBNM+w9P0deZsxZ27XKJHcluc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZZ+Sdh20OzU/0Z60y7jFfgzjJaK3AQO3p95yd7pd6zEJ/bZncQ0R1JEeKUnGekRqZ+5K33sH9MsaYS2o4QasL7PO4hu5/BPm5viIoLxHQRH4ZJwOT2EkzYngbg726SvS/6/PTPrSFDoftVSu/onPjD0GIEo6DSo3d2aDpEyo70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBXqrP3x; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7355f6ef12so110957566b.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 18:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767667833; x=1768272633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOZoIiXwK5nPtsxhsqLeFedJ6hc7OhvsLcIoj762iq8=;
        b=bBXqrP3xHM20xxQlybU7JrEyw8yMjjCxROI+Pf7fQIabgatR6oESVhVuPCz/j/6wXB
         70wlaWgJlqYKPjrMzyyVf1Si1mkZQDWYH0ZuQ5cCqMo9XFJw7h5sVhxtG6QY7GHHE/oI
         PB0sRDKDs6NZIH2Vd7k4rBaKY9/lGFb0Gi/BR+oaZb/Ub0K0dJzbAnKwRAWQGCSkcMGM
         raMJUtRWKpakDq9ginYLLrtQrL7JENFNEOS+QY787b8q3DyAVR8UAcz58kV04BbxeTut
         htsdFnrjAuVx8mVEplZmkz51yAymU77j9D+Ms4z/CdthT+JD+C6Fh709P9sBulzFXE9v
         wo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767667833; x=1768272633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOZoIiXwK5nPtsxhsqLeFedJ6hc7OhvsLcIoj762iq8=;
        b=ZHeGCPDzOYpi8gp9Gkc5TAUPulNC5KcvcV3Wv8ItcCCZqbTBhYu8qDwh6PdMKHnVDZ
         lMbFuKtOTXmKHx6NOowpWWfa+2UNYTNoZgeYF6Hcim5jkP43ttXtFgGh5UA74fjFjKVM
         1RXJ4bnjwIK7lL5cj35CmPz9SCpVsmtj2ec/6GIOh/TC7VIDsOijp26uUYyBnl2hF0p5
         Uxu16YhQxCnMxoSktGLc+EwpjKPeOJNrW9wpr2Iz28Udywip0sgMe5PTW1cFJtCXXcQA
         kfx1nEp+173D1QZRtbI8Pn0u2KcizB9XczDQ6hV4QeOYXsBSS1YWRj3fwQwE3gPcxwLO
         tnBg==
X-Forwarded-Encrypted: i=1; AJvYcCXzi+rzbcTLsBmkNrUISkvSA0FOXPJ7manZn1hz/HXEoVmorEn+euYbxsHhDlUEtN0UNX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzaCvbEiwHgRoxJt+b536+kbpfGc9wFooatsSkbJ+EDXPUWMj9
	6t48a984WZ2lquOKYovxYfRKUtK2Xvv1Ygsz+Qr8Vvl+jZ14LnmlB1/8w2uPE9k3GOrbIbTMSxZ
	2d57eMQ2prH1+fdQ0Pp7fXPXEz8xMwT2J7qzwsCtzlA==
X-Gm-Gg: AY/fxX5WrwHNrvY3N57snZsS9u6mB56tKzmDW9waTA/5rAamPKR5/XcDX/Of2tCJGnP
	hifX8INeGHbQ4hnNDjRCYkmbA9pPpAS2pXLWPS6yafhy4EGG7cs6jPLiBbetZTHs2L3quOvxdrs
	PwXk17WXU1Ucc7WbpMQ35BRLhQUjpTv0ict0oPez3G70jr3cX0g5wjdvJPzn6BV33Hb/KeVYcE2
	eI6oFI4y/wRsQBtDPzhdcQYaBxPshm2mes5Wjy2iTiqO2mShFCOkyJRyJfzDWLCh9bmRWaH
X-Google-Smtp-Source: AGHT+IHywyfNMPbNgIO3gpW90SH/rMd02UGzRPSVmmS1HOF6V5p6nkvGc9AGN0KfepU8HdwrR3l5Be6JNOoRIdetMc0=
X-Received: by 2002:a17:907:6d13:b0:b7c:e320:5250 with SMTP id
 a640c23a62f3a-b8426a4edbfmr193665166b.7.1767667833446; Mon, 05 Jan 2026
 18:50:33 -0800 (PST)
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
 <CAErzpmvpmx=WM7kHLC-WFbCx0=OpK5f8KJJuOA8gyb7LmRjk2g@mail.gmail.com> <CAEf4BzZ2suink0XjpZBZoLtDXHL3eKRJHwtmRQ4M2uuAhepwow@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2suink0XjpZBZoLtDXHL3eKRJHwtmRQ4M2uuAhepwow@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 6 Jan 2026 10:50:22 +0800
X-Gm-Features: AQt7F2rF0O9piIaf6vYeIIRemjSlAuWBkCTZN5TLCHa8C0xoyRba7N8ysmVEh7E
Message-ID: <CAErzpmvp53j0XrT=tyDH6wdrWejdVpJxd_1P6gO_-97-z5JsgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Dec 20, 2025 at 1:38=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
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
> >
> > In such scenarios, the extra `strcmp` operations translate to ~100,000
> > additional
> > string comparisons per second. While this might seem negligible in isol=
ation,
>
> I'm pretty confident it is quite negligible compared to all other
> *useful* work you'll have to do to use that BTF type to format those
> arguments. Yes, 100KHz is pretty frequent, but it won't be anywhere
> close to 4% if you profile the entire end-to-end overhead of emitting
> arguments using func-args.

Thanks, I agree.

>
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
> > >
> > >
> > > >
> > > > Benchmark results show that v8 achieves a 4.2% performance improvem=
ent
> > > > over v7. If we don't care the performance gain, I will revert to th=
e approach
> > > > in v7 in the next version.
> > > >
> > > > [1] https://lore.kernel.org/bpf/20251126085025.784288-1-dolinux.pen=
g@gmail.com/
> > > > [2] https://lore.kernel.org/all/20251119031531.1817099-1-dolinux.pe=
ng@gmail.com/
> > > > [3] https://lore.kernel.org/all/CAEf4BzaqEPD46LddJHO1-k5KPGyVWf6d=
=3DduDAxG1q=3DjykJkMBg@mail.gmail.com/
> > > > [4] https://lore.kernel.org/all/20251106131956.1222864-4-dolinux.pe=
ng@gmail.com/
> > > >
>
> [...]

