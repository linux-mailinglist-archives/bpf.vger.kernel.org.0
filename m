Return-Path: <bpf+bounces-44391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EC9C269F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF82F1C2181A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B01C1F20;
	Fri,  8 Nov 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/Q4Wmh0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994E12D1F1
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098057; cv=none; b=ga6wYfT0P7BpZAtEJdrUboOhOlKHp827CLaB+hmuC8NoSzidIBrDkYycUUzxAcF2NtApamuBQ3URSGeoyDnZRW75V7XnLYvr3VGKZb8GpJt5qw+dgi6uJtLsaBJw42NNKkVU39lhtJwEmd0xkhC+Ndv5ki514fPJjiF4DEO1Qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098057; c=relaxed/simple;
	bh=I9UtMaVnLWJq1HHPD3dldmIi4jKg+YPw1TZ/iseR8gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWW68GeFhXLJGTzKohmcSxwA6awPMf9GrQUXZpFjsQH9Qfwmm5+0IH/ShvRh8QMnC/qWmmxLeuX36H1Yi61OuewwTaNwARY+ZUrkqtTiMdMLVP1QG3wddLGHqjLL38/M6Iw9PTaDVjYgWI8+Uiz0v1hqhkTbLbXIgOnmWGkGQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/Q4Wmh0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316cce103dso29731165e9.3
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098054; x=1731702854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5qH54nQAIEd/FZEboYHabkBp2OxI8z+hX3S+2K65CA=;
        b=U/Q4Wmh0mzByjjWhFI8VyqzgR23K5wonguSZpxM8Y2RkZgOt4GNB+tKDpplCgjUZaW
         vv7x7Owa6wmMqDtGaGgH8mhKEFdKp2ffVuIyVDvQCCkD37fvSl0A06m17rl9mX0QN1fk
         tumq1Fa/DQDprC30djXGH2CG8mEpbRyQHUYowpOafm9+RgcOudpP9T3RhqDjJSfGeZVa
         WX6nmCEBBsprQqGgvzM9DSiTGQdBdmRYBfqbGqIMAo2sLyuuS7cFtq9XDVCMPwndDWIk
         sgcoC2e5wsUG3SI9t+7MvUWPKElLnB16vDlBnBOY27iYLKS6TMR+IyCVS7XU/dSYlp8Q
         Vqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098054; x=1731702854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5qH54nQAIEd/FZEboYHabkBp2OxI8z+hX3S+2K65CA=;
        b=seBrI2SDLZ0o3/a1x/7pf3sn8s7VpDFqVpo22YNIbor9LgH7GUumwq3F4WaMmzf68R
         95avphzTnvm5nN4VCta8KHhCDQosPTfX7FtahkOxccNBjq4moRJ76PDYKSYnwz9Gp7KX
         kWli3urCGGDPTjNBLauRAD+RzXhIuj72pJP20l4xI0oHm4JAQpe6r9DUor+DN5SB7zmg
         BDwAci4Jezuwi9gEyqbVvkgaK5kCXYCvVEWXq1zrgVLqs0XIME1aNx/N7DV40zSgRbxc
         DGeo8PAWjQh9V7AyFJIb0HhNdoZE8cb3I5LerbyFlHqjPOKpjUNS/Rc+lFOSbndRmnug
         b/TA==
X-Forwarded-Encrypted: i=1; AJvYcCXVFyNhRio/Z5DKTCepsRwUQnaGai9AtsX7RvDqXwk7Tg8PLl+95kZYQ5gpMze9tWrx6ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTuV5UXG0uc/EGGUt63afy3b5Vw1wvibukXuq8VRoM6uWky6N
	Yg/lZzGwgZ07qyKVwxgZCkyjwhV0Mk34KqRW2YxjaweysaTBBjz2ncvnune1eMzwoEuGrGddIeX
	aO3m2puidflrXyi/9ADYatfBMWmk=
X-Google-Smtp-Source: AGHT+IFAI5rkjwf1qSkM1nPz7ZF1K2LzjOZH6ZWfrLKk3ZNN/1SCNN3lfVwdqwAIvZfgLCSWzgSlKquxukpYnXl0fAU=
X-Received: by 2002:a05:600c:458d:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-432b7505acemr44716725e9.12.1731098053536; Fri, 08 Nov 2024
 12:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev> <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
 <000c01db3186$1dd30930$59791b90$@gmail.com> <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
 <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
In-Reply-To: <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 12:34:02 -0800
Message-ID: <CAADnVQLbk9ogKn8kHBGiq8yNuugNQTfMcd5m9RHc9KmZhrxmNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:53=E2=80=AFAM Dave Thaler <dthaler1968@googlemail=
.com> wrote:
>
> > >
> > > My concern is that index.rst says:
> > > > This directory contains documents that are being iterated on as par=
t
> > > > of the BPF standardization effort with the IETF. See the `IETF BPF
> > > > Working Group`_ page for the working group charter, documents, and =
more.
> > >
> > > So having a document that is NOT part of the IETF BPF Working Group
> > > would seem out of place and, in my view, better located up a level (o=
utside
> > standardization).
> >
> > It's a part of bpf wg. It's not a new document.
>
> RFC 9669 is immutable.  Any additions require a new document, in
> IETF terminology, since would result in a new RFC number.

Sure. It's an IETF process. Not arguing about that.

> > > Here=E2=80=99s some examples of delta-based RFCs which explain the ga=
p and
> > > provide the addition or clarification, and formally Update (not
> > > replace/obsolete) the original
> > > RFC:
> > > * https://www.rfc-editor.org/rfc/rfc6585.html: Additional HTTP Status
> > > Codes
> > > * https://www.rfc-editor.org/rfc/rfc6840.html: Clarifications and Imp=
lementation
> > Notes
> > >    for DNS Security (DNSSEC)
> > > * https://www.rfc-editor.org/rfc/rfc9295.html: Clarifications for Ed2=
5519, Ed448,
> > >    X25519, and X448 Algorithm Identifiers
> > > * https://www.rfc-editor.org/rfc/rfc5756.html: Updates for RSAES-OAEP=
 and
> > >    RSASSA-PSS Algorithm Parameters
> > >
> > > Having a full document too is valuable but unless the IETF BPF WG
> > > decides to take on a -bis document, I'd suggest keeping it out of the
> > "standardization"
> > > (say up 1 level) to avoid confusion, and just have one or more
> > > delta-based rst files in the standardization directory.
> >
> > This patch is effectively a fix to the standard.
>
> Two of the examples I provided above fit into that category.
> Two are examples of adding new codepoints.
>
> > It's a standard git development process when fixes are applied to the e=
xisting
> > document.
> > Forking the whole doc into a different file just to apply fixes makes n=
o sense to me.
>
> Welcome to the IETF and immutable RFCs =F0=9F=98=8A
>
> > The formal delta-s for IETF can be created out of git.
>
> Not in the IETF per se, since a new document needs new boilerplate, with
> a new abstract, introduction, etc.  At most, part of the document could b=
e created
> out of git, but I'm not convinced that git diffs alone (as opposed to som=
e English
> prose too for each, as in the examples I cited) make for good content in =
an IETF document.

git diff might need another script :)
Just like you did earlier with an old script that took this .rst
and converted it to IETF suitable format.

Now we'd need a new script that will take git diff with new header/footer
and whatever extra words necessary.

> > We only need to tag the current version and then git diff rfc9669_tag..=
HEAD will give
> > us that delta.
> > That will satisfy IETF process and won't mess up normal git style kerne=
l
> > development.
>
> I am not convinced it is sufficient.  Can you point to any precedents in =
the IETF for
> such an approach?  I can't offhand... See the RFC 5756 reference above fo=
r what
> I mean by English prose for each diff.

It's all a matter of additional scripting.
We're not going to ask every kernel developer to learn IETF process.
People will be sending patches for instruction-set.rst and
this file will keep evolving.
As soon as we land Yonghong's patch it won't be 1-1 with RFC9669 and
it's fine.
Even today it's not 1-1 either. It needs to go through your
existing script to fit IETF rules.
The new patches will keep landing and the file will become a working
document towards the next delta RFC.

> > btw do we still need to do any minor edit/fixes to instruction-set.rst =
before tagging it
> > as RFC9669 ?
>
> Yes, we need to backport the formatting/nits from the RFC editor pass.

Ok. Please send the patch. Will wait for that first.

