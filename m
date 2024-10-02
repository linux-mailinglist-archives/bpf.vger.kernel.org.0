Return-Path: <bpf+bounces-40789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D098E401
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 22:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE903284C1D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA07216A30;
	Wed,  2 Oct 2024 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyAApmcm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F441D0E28
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900054; cv=none; b=KtcjpxANPQXFXR4IJyjNf+CrIfYvre//jzKcNNymIWNjncl4S/guPawSc9Rf5+ZPC/N1x8ne/Ncaj3oxbcoKbDK469dXnSGy11V2BMauTw8V6YEhMHKVbUGjb0vMaQMBf+mauHyBzg4qGg52/FGdGoyqhH2ePCs48p6tf5SSwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900054; c=relaxed/simple;
	bh=K2ON7g4iFfqDCmUv35gmHada2NPnaUDkGfhUOsGPMDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKkWNOJd0EkJwleNGRskJjfiJmTAMIWV9D+1o5zbE27G29sVKMo2ESVKEIXJDLYWPRMeVq4PIt8qVbrvO0LOdSgVUKTilqGQ991WbBOLoMigICCjigJQ8oxyN6BBQUen1yOTUgFrbq3+/tQCPHBGICbSUXlwOzCvFasq23rF2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyAApmcm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so1053635e9.3
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727900051; x=1728504851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60aPyFZu4LEJZ3NoEJXlgldS/ABC8PSGmDDpW20tAK4=;
        b=jyAApmcmXXQnaTY+eVqRnN7XFTHefhfkb+Ihz1mwDe0C2ZfujQhTIWA7ANKsLnELmi
         WwYeQRe/rMfkTZrf70F66CjfST8tFetn4AB/gsWlnduKSFq98zP7Xvk/QBOxVGa7TqL4
         zTUcrNZXhv0xGrujm7cJVb2N3GvtrAPXW3kKio6qJ2F42ygjXiG98eQKqJwH2b1BrWvw
         fW/hmEfUe2ubb6n/x5M0SPYlDpClBjh3lZNGfIGbKAxRrqT276dh/4mv4005X6qDx5p2
         YjvQzeUionUkopkAdTyVgWc/ZbBWTF6K+Eau/HSJF7jt61sRQ+TSiHPA83LlAQkFikm0
         XY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900051; x=1728504851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60aPyFZu4LEJZ3NoEJXlgldS/ABC8PSGmDDpW20tAK4=;
        b=GskeRIsaVjbN0JAdQSMczch86i9+yvWWtXvQnVlUOJZ08NiI42W8ZOKaF2UlH7t7fs
         LUUvFbZIPRNulItObsKxqTYwL20Q89EnADlJgWkAGs3AQNDFlLOYbIwCsuzFLYLA8XBk
         CtuYrC/mc4KGrkFFgJmUt5JejlZhrVe+LxGRqplExo872AwVg1zGjbJEfaFiBFuT352t
         6sHESNCW570rFWtq3fw7TjMKXBUxH6D056oFJ94nyHK7+kIszEFgnNPYukPx7fRQoJCj
         LX5VbObtDVUMDV6SVQDbOuMu5QQyfqJuP9ebd8+/4MaQZA1nQmjbJNA5U+h9TFafgE0q
         q0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSpku3rUb0ezYJzeC0SeOVKftZranJOxd9d8jqll2NJehDMlZC7V63e8iq/sn0nvA9vCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeaRS0eYk3VnE1tZ5XfxnJwiI+kCPGlYqEIYKKjeZRkzv12ihB
	rCSS21hIW9LbFyGeNYbi7v8CQC+7R163QDu0k6XeFWeHBrAwYHKyX2+ORV9e3qFJtZLyLXnI81N
	GU7s23/+yXXCUJLQhT10zT1p4XzQ=
X-Google-Smtp-Source: AGHT+IE9MTp/YZZXv7ZngEnj/6BOPPJvM2bKY0XNaaeB47qCt8xlKNRX/emFdzMF3HJ4bPp+wbA2vD5EajwibkG4hdw=
X-Received: by 2002:a05:6000:2a3:b0:37c:cec1:6292 with SMTP id
 ffacd0b85a97d-37cfb8a5e9amr2948597f8f.8.1727900050746; Wed, 02 Oct 2024
 13:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev> <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
In-Reply-To: <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Oct 2024 13:13:59 -0700
Message-ID: <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:54=E2=80=AFPM Dave Thaler <dthaler1968@googlemail=
.com> wrote:
>
> Yonghong Song <yonghong.song@linux.dev> wrote:
> > On 9/30/24 6:50 PM, Alexei Starovoitov wrote:
> > > On Thu, Sep 26, 2024 at 8:39=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev>
> > wrote:
> > >> Patch [1] fixed possible kernel crash due to specific sdiv/smod
> > >> operations in bpf program. The following are related operations and
> > >> the expected results of those operations:
> > >>    - LLONG_MIN/-1 =3D LLONG_MIN
> > >>    - INT_MIN/-1 =3D INT_MIN
> > >>    - LLONG_MIN%-1 =3D 0
> > >>    - INT_MIN%-1 =3D 0
> > >>
> > >> Those operations are replaced with codes which won't cause kernel
> > >> crash. This patch documents what operations may cause exception and
> > >> what replacement operations are.
> > >>
> > >>    [1]
> > >> https://lore.kernel.org/all/20240913150326.1187788-1-yonghong.song@l=
i
> > >> nux.dev/
> > >>
> > >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > >> ---
> > >>   .../bpf/standardization/instruction-set.rst   | 25 +++++++++++++++=
----
> > >>   1 file changed, 20 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > >> b/Documentation/bpf/standardization/instruction-set.rst
> > >> index ab820d565052..d150c1d7ad3b 100644
> > >> --- a/Documentation/bpf/standardization/instruction-set.rst
> > >> +++ b/Documentation/bpf/standardization/instruction-set.rst
> > >> @@ -347,11 +347,26 @@ register.
> > >>     =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>
> > >>   Underflow and overflow are allowed during arithmetic operations,
> > >> meaning -the 64-bit or 32-bit value will wrap. If BPF program
> > >> execution would -result in division by zero, the destination registe=
r is instead set
> > to zero.
> > >> -If execution would result in modulo by zero, for ``ALU64`` the valu=
e of
> > >> -the destination register is unchanged whereas for ``ALU`` the upper
> > >> -32 bits of the destination register are zeroed.
> > >> +the 64-bit or 32-bit value will wrap. There are also a few
> > >> +arithmetic operations which may cause exception for certain
> > >> +architectures. Since crashing the kernel is not an option, those op=
erations are
> > replaced with alternative operations.
> > >> +
> > >> +.. table:: Arithmetic operations with possible exceptions
> > >> +
> > >> +  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >> +  name   class       original                       replacement
> > >> +  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >> +  DIV    ALU64/ALU   dst /=3D 0                       dst =3D 0
> > >> +  SDIV   ALU64/ALU   dst s/=3D 0                      dst =3D 0
> > >> +  MOD    ALU64       dst %=3D 0                       dst =3D dst (=
no replacement)
> > >> +  MOD    ALU         dst %=3D 0                       dst =3D (u32)=
dst
> > >> +  SMOD   ALU64       dst s%=3D 0                      dst =3D dst (=
no replacement)
> > >> +  SMOD   ALU         dst s%=3D 0                      dst =3D (u32)=
dst
>
> All of the above are already covered in existing Table 5 and in my opinio=
n
> don't need to be repeated.
>
> That is, the "original" is not what Table 5 has, so just introduces confu=
sion
> in the document in my opinion.
>
> > >> +  SDIV   ALU64       dst s/=3D -1 (dst =3D LLONG_MIN)   dst =3D LLO=
NG_MIN
> > >> +  SDIV   ALU         dst s/=3D -1 (dst =3D INT_MIN)     dst =3D (u3=
2)INT_MIN
> > >> +  SMOD   ALU64       dst s%=3D -1 (dst =3D LLONG_MIN)   dst =3D 0
> > >> +  SMOD   ALU         dst s%=3D -1 (dst =3D INT_MIN)     dst =3D 0
>
> The above four are the new ones and I'd prefer a solution that modifies
> existing table 5.  E.g. table 5 has now for SMOD:
>
> dst =3D (src !=3D 0) ? (dst s% src) : dst
>
> and could have something like this:
>
> dst =3D (src =3D=3D 0) ? dst : ((src =3D=3D -1 && dst =3D=3D INT_MIN) ? 0=
 : (dst s% src))
>
> > > This is a great addition to the doc, but this file is currently being
> > > used as a base for IETF standard which is in its final "edit" stage
> > > which may require few patches, so we cannot land any changes to
> > > instruction-set.rst not related to standardization until RFC number i=
s
> > > issued and it becomes immutable. After that the same
> > > instruction-set.rst file can be reused for future revisions on the
> > > standard.
> > > Hopefully the draft will clear the final hurdle in a couple weeks.
> > > Until then:
> > > pw-bot: cr
> >
> > Sure. No problem. Will resubmit once the RFC number is issued.
>
> I'm adding bpf@ietf.org to the To line since all changes in the standardi=
zation
> directory should include that mailing list.
>
> The WG should discuss whether any changes should be done via a new RFC
> that obsoletes the first one, or as RFCs that Update and just describe de=
ltas
> (additions, etc.).
>
> There are precedents both ways and I don't have a strong preference, but =
I
> have a weak preference for delta-based ones since they're shorter and are
> less likely to re-open discussion on previously resolved issues, thus oft=
en
> saving the WG time.

Delta-based additions make sense to me.

>
> Also FYI to Linux kernel folks:
> With WG and AD approval, it's also possible (but not ideal) to take chang=
es
> at AUTH48.  That'd be up to the chairs and AD to decide though, and norma=
lly
> that's just for purely editorial clarifications, e.g., to confusion calle=
d out by the
> RFC editor pass.

Also agree. We should keep AUTH going its course as-is.
All ISA additions can be in the future delta RFC.

As far as file logistics... my preference is to keep
Documentation/bpf/standardization/instruction-set.rst
up to date.
Right now it's effectively frozen while awaiting changes (if any)
necessary for AUTH. After official RFC is issued
we can start landing patches into instruction-set.rst and
git diff 04efaebd72d1..whatever_future_sha instruction-set.rst
will automatically generate the future delta RFC.
Once RFC number is issued we can add a git tag for the particular
sha that was the base for RFC as a documentation step and to
simplify future 'git diff'.

