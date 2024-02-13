Return-Path: <bpf+bounces-21869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24278539A3
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434FF1F249F7
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BE605B6;
	Tue, 13 Feb 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+FJZ3cQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA90604D5
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847994; cv=none; b=oAtK5CTyqXZkeA8fFlSIM7AGcUAwj907LZEk5ka2B1fIWAXHD0U6eONuvE3PrpJ+J321YwQcdgt1cD8NTb8VrahRM4mY4AxFeHwhQsIRng/W4FpNdefu4OODJCWrk6NKEmn1Qdq4dorXhp2I8hzN6RDoJ0ZoapYnHyYVq+GlbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847994; c=relaxed/simple;
	bh=OL6J/fD0a9ilTXBLGDFfU5gwu2yFPacQ6KBucgSE3so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY2QDXg98omt+Zd0xaIAzLbLSvBK6jOklX9RPo77yyb97i1+3pnFoCEPJggeLFcl5pVOsmRFTPyqARJ5EanUxDNJFmNtC+PZjnc4pECncM5NDHHotIinjOuFZYEja93KcgGP4q4W3RjKBpQVOzEAp9XEHDVVFhIeg91Ls4wiT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+FJZ3cQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-298cc60ee66so138596a91.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 10:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707847992; x=1708452792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7380EUzN7R0ob1F5COBrce8UdDQYZcgLr8+BFm1VAo=;
        b=h+FJZ3cQBSmZ/cBbPKZeRmlfnniCnf3sIG2GWsAfTl0PNP4wl4ejx64oJb8FNBebDe
         2ecdHVg91vZggrTtjqMwOB0UT2R3eW/CVjcdMDQsYscoW/amdfsmHioEDycclbakTiSU
         9p1yj9S0QHoQeDEVnKA/6hxgJpQCGrvZuDVEwzPsMOLtcaZ4iWcLa+cHTDNgTo3mkGH1
         Dt/4hTESN8Z8bq49/zbqLd8D+Dni6j6luMAT0QCdWkJ+SxJsOWo3nEsC/yRlxRmg4MmV
         tZLgw5P0ePBJmY/ODOCOwElZWnxK9Ij6FTkkBpFWCH0kFOlX85+QRsuXkoqEldPcD0/6
         KP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847992; x=1708452792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7380EUzN7R0ob1F5COBrce8UdDQYZcgLr8+BFm1VAo=;
        b=dBbPRi7Iz3GVQrQqPkNBpFPbygpsa8LZwmZ7Nz6QgWwIaxi2oxV3KNjx1seGA8T+hf
         ouE+DLoo594afkbGHpuSW0Bmt/3VtJGYzuQTuvBPEaZTW9UyjSBD99wuxWINl3dItmxN
         LUCeYKPMaqVxCFoWKRHx0DLQNpls4csbbxNjjNxB/XTtuGecdIxvm9/WV0EZCluT0LmW
         jBWcGGhtv96EJlhaxtgEbtGUeLYCkVsVQy82Ix3S1MzKhsPswfu63lGMsv8vgRLqhJbD
         2uU0EJnWQnKggYZSdsWe7+CpJ0yy345akA1Ny+mu4Wuwu+KAHLE8DoZrQApiy5AwGwic
         pYvg==
X-Forwarded-Encrypted: i=1; AJvYcCWMdPSXDA9chmB+SW058ZhVpFoKhTXla7BMTbjGH3iJQwCAMBIQHWWtRjb+SU9KTRqeKf/jSlIiX8/RABKhXyaY9BcQ
X-Gm-Message-State: AOJu0YzOqKyK2zHdonfUXAPYWHdXzvVn+AB4iVnMid6BT2Er6heVDfRu
	aRpqeS8Kg+c0UUEQQ4HqxhEFvzPi5xRc7C04dZqtCrh0tP3GWVCxI5ITW7/xbAlsNWqjJ0ngYF+
	ubXLOjnjaBDadJEQDQ8FTSubg6Fmbp0yrCUs=
X-Google-Smtp-Source: AGHT+IGDGTyNz/VwKSkmVB723tH4aB+LeaGNq3SvvKCqRtxlD52MJZ3VqhzkKyda7PKPKB5xiQAVzOutMU1oPVFPKkg=
X-Received: by 2002:a17:90a:bd95:b0:298:ca3e:a06d with SMTP id
 z21-20020a17090abd9500b00298ca3ea06dmr262858pjr.19.1707847991782; Tue, 13 Feb
 2024 10:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212233221.2575350-1-andrii@kernel.org> <20240212233221.2575350-3-andrii@kernel.org>
 <e3b68a899b8ade18addd198d6f33dcbbed473c3c.camel@gmail.com>
 <CAEf4Bza5yWU0Tu18ZfPB_XJeAKx_iKyR=FCkSvWXE17vPa73DA@mail.gmail.com> <4950b053549136fbf852160aa64676e2003c4255.camel@gmail.com>
In-Reply-To: <4950b053549136fbf852160aa64676e2003c4255.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 10:12:59 -0800
Message-ID: <CAEf4Bzbs=1xJmJRinNPGG+Ug8k71060CnCp1psOWCqFdxOOKnA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: handle bpf_user_pt_regs_t typedef
 explicitly for PTR_TO_CTX global arg
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-02-13 at 09:02 -0800, Andrii Nakryiko wrote:
> [...]
>
> > >         t =3D btf_type_by_id(btf, t->type);
> > > -       while (btf_type_is_modifier(t))
> > > -               t =3D btf_type_by_id(btf, t->type);
> > > -       if (!btf_type_is_struct(t)) {
> > > +
> > > +       /* Skip modifiers, but stop if skipping of typedef would
> > > +        * lead an anonymous type, e.g. like for s390:
> > > +        *
> > > +        *   typedef struct { ... } user_pt_regs;
> > > +        *   typedef user_pt_regs bpf_user_pt_regs_t;
> > > +        */
> > > +       t =3D __btf_type_skip_qualifiers(btf, t);
> > > +       while (btf_type_is_typedef(t)) {
> > > +               const struct btf_type *t1;
> > > +
> > > +               t1 =3D btf_type_by_id(btf, t->type);
> > > +               t1 =3D __btf_type_skip_qualifiers(btf, t1);
> > > +               tname =3D btf_name_by_offset(btf, t1->name_off);
> > > +               if (!tname || tname[0] =3D=3D '\0')
> > > +                       break;
> > > +               t =3D t1;
> > > +       }
> > > +       if (!btf_type_is_struct(t) && !btf_type_is_typedef(t)) {
> >
> > and now we potentially are intermixing structs and typedefs and don't
> > really distinguish them later (but struct abc is not the same thing as
> > typedef abc), which is probably not what we want.
>
> Yes, need a condition in the end to check that 'ctx_type' and 't' have
> same kind.

Yeah, and then special case, for KPROBE that `struct
bpf_user_pt_regs_t` (not a typedef!) is also acceptable. Hopefully you
see why I'm saying that the early special case of `bpf_user_pt_regs_t`
typedef is much easier to reason about.

>
> > Also, we resolve typedef to its underlying type *or* typedef, right?
> > So if I have typedef A -> typedef B -> struct C, we won't get to
> > struct C, even if struct C is the expected correct context type for a
> > given program type (and it should work).
>
> For code above we would get to 'struct C'.

ha, right, it's "break if empty name", not the other way.

So basically in `typedef A -> typedef B -> struct C` we get `typedef
B` if C is anon, otherwise it's `struct C`. It will be a slightly
different behavior for bpf_user_pt_regs_t if the user typedef'ed it
(for whatever reason).

>
> > So in general, yes, I think this code could be changed to not ignore
> > typedefs and do the right thing, but we'd need to be very careful to
> > not allow unexpected things for all program types. Given only kprobes
> > define context as typedef, it's simpler and more reliable to special
> > case kprobe, IMO.
>
> Maybe, I do not insist.

Great.

