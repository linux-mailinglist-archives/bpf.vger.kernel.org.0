Return-Path: <bpf+bounces-18974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EA8239A9
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0DD1C20A4F
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5C136A;
	Thu,  4 Jan 2024 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOOF+o1h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0207A47
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-556ab8b85e3so1778585a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 16:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704328083; x=1704932883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWZyS8AwiGZNJpOEgMYkF/uwEodAJXPGmk4XU+uW3qw=;
        b=HOOF+o1hT1xg9w4lgcb/IdFiA83Mw8EDimsG3pstf8QhyXpJW7PeVj5oJYfOau92tT
         1AkrbrKyaUj1OBeWqxBtEu9PZWhOHFmMuxJvG9QMs5hPfdIrGpVSPOxJLfKdVjN+foqt
         U6vtZ4jhj0jq1SF4tI5xPs2GaNEqvib/f2Y2JGWbt9niIoVBgBrnk5SqmYeex7eTuSXN
         5i1otvcwEmtepulmR5fo02oqvip/AzeaDme8iStLcaCR89J3e7pB/WXnmoxWh6Me/1jO
         nEN2kKpnN1BCqKmEi1zJq/l7wTNhoj5sv/cSLO1XSdLZZE8P2/WTwqXtR2B7GOl2OTlX
         74tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328083; x=1704932883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWZyS8AwiGZNJpOEgMYkF/uwEodAJXPGmk4XU+uW3qw=;
        b=E4Ck2MufG9I5N1lgjYiso+8IqT5XnyAYE5BKJIq2wN+YF9lVAIWy7v7z+wWvwO+V8r
         u7ApQ3qdNXPubNrXnyJRfyE9JDRqMnmblQfEUa3piu68/mruwz+gO/xaJZ8e39RvHl/l
         Jmf9yFO1aUZt1WqUI7NxKIHNX6irzPacwRDML0ONCu7pjl7JiGYdzqYgN4GsgPR0Y7aa
         Q8VrDlfzawFJoUARMUkMdInV9qDyIUwgYq1TSp0dEldciwl9/WY0Voa/qWYuNUnzCYIc
         FyoximkGJ/mQp2DrAfYJNmczWiDtE94aedf0xgKROuJiezfksNGY8gvScJzpG7QyfB4g
         G6fQ==
X-Gm-Message-State: AOJu0YxWwc8JL2obikG7wrugGB5Wavy7FLQGV6BALTIvFhk3T3+QaiQL
	6FMTXtZ7pD0S2Vk0rsd14q8QNl/eNaLGE+eMZwo=
X-Google-Smtp-Source: AGHT+IEeRCXdLTfdMliHuiyXxrvBqQDlpwtIWRgdGy3a+LCbu19ZDuq+mh4JD2MnJQgu24bau19wEYJSv2dnjZ2ZBik=
X-Received: by 2002:aa7:d6d0:0:b0:556:528d:7739 with SMTP id
 x16-20020aa7d6d0000000b00556528d7739mr1809274edr.15.1704328083071; Wed, 03
 Jan 2024 16:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-9-andrii@kernel.org>
 <75cad82e8e11b6049c99dcd2170fb445e2d3d2ee.camel@gmail.com>
 <CAEf4BzaB_dOz8QmG9kGM7ViD=iM7P-a1GsMAMyyJhdf1W2Kwng@mail.gmail.com>
 <7746c6fa67e655b288e069b0c1d6393dc8c46502.camel@gmail.com>
 <CAEf4BzaPhbRVEJ9o3UqP0q6Ot63BYdxw4UO8J94bQk2Waij+Zw@mail.gmail.com> <5e3dd1c0953d2311da52b3dda378362a4f118a4f.camel@gmail.com>
In-Reply-To: <5e3dd1c0953d2311da52b3dda378362a4f118a4f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 16:27:50 -0800
Message-ID: <CAEf4Bzbr4WogHLY5wc98UzEReVgdAtLBCXiL5hdKxxLuzmddWA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: implement __arg_ctx fallback logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 4:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-01-03 at 15:59 -0800, Andrii Nakryiko wrote:
> [...]
> > > > > > +     fn_id =3D btf__add_func(btf, prog->name, btf_func_linkage=
(fn_t), fn_t->type);
> > > > >
> > > > > Nit: Why not call this function near the end, when fn_proto_id is=
 available?
> > > > >      Thus avoiding need to "guess" fn_t->type.
> > > > >
> > > >
> > > > I think I did it to not have to remember btf_func_linkage(fn_t)
> > > > (because fn_t will be invalidated) and because name_off will be reu=
sed
> > > > for parameters. Neither is a big deal, I'll adjust to your suggesti=
on.
> > > >
> > > > But note, we are not guessing ID, it's guaranteed to be +1, it's an
> > > > API contract of btf__add_xxx() APIs.
> > >
> > > Noted, well, maybe just skip this nit in such a case.
> > >
> >
> > I already did the change locally, as I said it's a small change, so no =
problem.
>
> Oh, ok, thanks.
>

np

> [...]
>
> > > > > > +             /* clone fn/fn_proto, unless we already did it fo=
r another arg */
> > > > > > +             if (func_rec->type_id =3D=3D orig_fn_id) {
> > > > > > +                     int fn_id;
> > > > > > +
> > > > > > +                     fn_id =3D clone_func_btf_info(btf, orig_f=
n_id, prog);
> > > > > > +                     if (fn_id < 0) {
> > > > > > +                             err =3D fn_id;
> > > > > > +                             goto err_out;
> > > > > > +                     }
> > > > > > +
> > > > > > +                     /* point func_info record to a cloned FUN=
C type */
> > > > > > +                     func_rec->type_id =3D fn_id;
> > > > >
> > > > > Would it be helpful to add a log here, saying that BTF for functi=
on
> > > > > so and so is changed before load?
> > > >
> > > > Would it? We don't have global subprog's name readily available, it
> > > > seems. So I'd need to refetch it by fn_id, then btf__str_by_offset(=
)
> > > > just to emit cryptic (for most users) notifications that something
> > > > about some func info was adjusted. And then the user would get this
> > > > same message for the same subprog but in the context of a different
> > > > entry program. Just confusing, tbh.
> > > >
> > > > Unless you insist, I'd leave it as is. This logic is supposed to be
> > > > bullet-proof, so I'm not worried about debugging regressions with i=
t
> > > > (but maybe I'm delusional).
> > >
> > > I was thinking about someone finding out that actual in-kernel BTF
> > > is different from that in the program object file, while debugging
> > > something. Might be a bit surprising. I'm not insisting on this, thou=
gh.
> >
> > Note the "/* check if existing parameter already matches verifier
> > expectations */", if program is using correct types, we don't touch
> > BTF for that subprog. If there was `void *ctx`, we don't really lose
> > any information.
>
> But `void *ctx` would be changed to `struct bpf_user_pt_regs_t *ctx`, rig=
ht?
> And that might be a bit surprising. But whatever, if you think that addin=
g
> log entry here is too much of hassle -- let's leave it as is.
>

Ok.

> > If they use `struct pt_regs *ctx __arg_ctx`, then yeah, it will be
> > updated to `struct bpf_user_pt_regs_t *ctx __arg_ctx`, but even then,
> > original BTF has original FUNC -> FUNC_PROTO definition. You'd need to
> > fetch func_info and follow BTF IDs (I'm not sure if bpftool even shows
> > this today).
> >
> > In short, I don't see why this would be a problem, but perhaps I
> > should just bite a bullet and do feature detector for this support.
>
> I like that current implementation does the transformation unconditionall=
y,
> it does no harm and avoids unnecessary branching.
>

ack

> [...]

