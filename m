Return-Path: <bpf+bounces-28036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CF68B495A
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 05:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB331C20EFA
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 03:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FC20ED;
	Sun, 28 Apr 2024 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsOZ18yC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91961854
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714274557; cv=none; b=q/XHp6QfeLg92uPkgAMWyZg+sHxb3bm+gGERxijIiL/HaVB4qSxNSnnOcpOMcgRXUafbczcRGUGYQ69yyXhwJv5/MS1hqHQlEjzLk0xyx94CaUiLbJpTIhLv2eH0kSNELIKmo2NCL3eRQXAmQBfxNdU92IedU/HEg0TiE8Mawr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714274557; c=relaxed/simple;
	bh=2gGxd1f4RUvDcw1H/+ViMXJc033pp7hSsNZt/K0AXpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxSSEfpmd6Csl5SDGgl78wwpd3Ub8+W+fvRYO7kER/cmvpZZ4C3pLtM36GWFa8SIzvWe7qzU3W+WzklAOcXnvdAurwMmGonB2oNTeoskHoEC9w6vzupYtu/wp46j2KySHVkZfP598YrtdgQf4LBwumAapuuN6lxIDTJeHsIRwaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsOZ18yC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2adce8f7814so2966175a91.0
        for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714274555; x=1714879355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3CWqSg/6g0kprGn/CXoYgIx4Aa3HOicfj3qvbeXy0g=;
        b=QsOZ18yC/+OmiVhvI+T/MTkMFLTjPh6qFQemYZSQLFPcW/2bfrOvCRrJkdScL6Cy/9
         9VKniA3NOtjXpzYBi7Fy41UG+OdomD8NDjx/Xl4n7aohcXzL694KJC2UiHVoualspltc
         v+D2N32AI97CeOQqTYOO44Oc1jiYWuW+lvQlsDIkISu0aAOixP1MNrPVV9wSqF5NcqbB
         fAeI5XSVbts9EVz3hkdvTUDW651abrC+Ra+XF0W7eZUbfcj1HMGzADX7kTi3eTS/nBtz
         6UsMAU9pm7fNIHfbjdan7SneGQIXfDOD/eSTO8gCiFv7OusbhwRbv2Unl21O4P2yeami
         GxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714274555; x=1714879355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3CWqSg/6g0kprGn/CXoYgIx4Aa3HOicfj3qvbeXy0g=;
        b=mjWG4NWXdbVGh52sski+zaabCORgV8OINUNDSqtxy/NFWX6zP+dr5IdvvW9P5evJM6
         1EwdabO7A430iopQBvXHn9CktmPaKCww9OIIDcYwM3nMO3y3X2DuSXdj1cRGRHayDLH0
         ehakFFX/ByK29WyEKzamMtqfNzTCrXqyvsXpMjK1QTD8y9uAxfT5G1hWRfvmqTn9xYFa
         80kxPnZl/c7aOfNVq/M72+zaNJe5pE1n+l7a9bkI7KQIsS1mYcvsR0ZrYqMJClYCjUp5
         dgjhLti4tgoyHSvsauwaqxKDGoU9AiqfojYlo6NesixlPctDkElmrD8+VEm9rxnfbYFv
         ufdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvewrh5e3v06iD86HtnSHoTeKvMvArRYDtRMqFyL2M/ZFIKfnPgU+EEDuVy+0ZM42Hkuy9//7kzAZAWhPvBndHWOiM
X-Gm-Message-State: AOJu0YzQlXqPbfZxsvHiD6vuObGFFcvDg6MQcqfN8BbQbtStFhZ0IQeA
	E2GZHRf/yJENigBXsma37O+B6rohUC+5ylR7nwVFMDdwmU8uTZIIk2dQ/k25xjpHI0dmZ2cEixf
	qEXMHHajGsPdtqfGdr+liO1aBOJU=
X-Google-Smtp-Source: AGHT+IFqHSphcBu/fLADNJtRCi+r8shmKQOyq/E3ZORp/2Rqi0IAF/K49ctNXDYoPwSYCyCRTr5ivMTWbbhauXpmDEA=
X-Received: by 2002:a17:90b:3a91:b0:2ad:ec71:b7e5 with SMTP id
 om17-20020a17090b3a9100b002adec71b7e5mr6160296pjb.33.1714274554930; Sat, 27
 Apr 2024 20:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
 <20240424224053.471771-3-cupertino.miranda@oracle.com> <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
 <87edasmnlr.fsf@oracle.com> <CAEf4BzazPWOgXFco=PJnGEAaJgjr2MG12=3Sr3=9gMckwTSDLg@mail.gmail.com>
 <CAADnVQ+mSfUbtgk9pD+j6b3XLZJ1w7mGzbh2+t40Q81jB==wLg@mail.gmail.com> <87a5lemnb3.fsf@oracle.com>
In-Reply-To: <87a5lemnb3.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 27 Apr 2024 20:22:22 -0700
Message-ID: <CAEf4BzYRyAAv2an3+vq6sswM8Rx7Ys3qsz-9FUjGb4B6vgHYhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range computation
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 3:51=E2=80=AFPM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
>
> Alexei Starovoitov writes:
>
> > On Fri, Apr 26, 2024 at 9:12=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Fri, Apr 26, 2024 at 3:20=E2=80=AFAM Cupertino Miranda
> >> <cupertino.miranda@oracle.com> wrote:
> >> >
> >> >
> >> > Andrii Nakryiko writes:
> >> >
> >> > > On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
> >> > > <cupertino.miranda@oracle.com> wrote:
> >> > >>
> >> > >> Split range computation checks in its own function, isolating pes=
simitic
> >> > >> range set for dst_reg and failing return to a single point.
> >> > >>
> >> > >> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> >> > >> Cc: Yonghong Song <yonghong.song@linux.dev>
> >> > >> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> > >> Cc: David Faust <david.faust@oracle.com>
> >> > >> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> >> > >> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> >> > >> ---
> >> > >>  kernel/bpf/verifier.c | 141 +++++++++++++++++++++++-------------=
------
> >> > >>  1 file changed, 77 insertions(+), 64 deletions(-)
> >> > >>
> >> > >
> >> > > I know you are moving around pre-existing code, so a bunch of nits
> >> > > below are to pre-existing code, but let's use this as an opportuni=
ty
> >> > > to clean it up a bit.
> >> > >
> >> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> > >> index 6fe641c8ae33..829a12d263a5 100644
> >> > >> --- a/kernel/bpf/verifier.c
> >> > >> +++ b/kernel/bpf/verifier.c
> >> > >> @@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct b=
pf_reg_state *dst_reg,
> >> > >>         __update_reg_bounds(dst_reg);
> >> > >>  }
> >> > >>
> >> > >> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, boo=
l alu32,
> >> > >
> >> > > hm.. why passing reg_state by value? Use pointer?
> >> > >
> >> > Someone mentioned this in a review already and I forgot to change it=
.
> >> > Apologies if I did not reply on this.
> >> >
> >> > The reason why I pass by value, is more of an approach to programmin=
g.
> >> > I do it as guarantee to the caller that there is no mutation of
> >> > the value.
> >> > If it is better or worst from a performance point of view it is
> >> > arguable, since although it might appear to copy the value it also p=
rovides
> >> > more information to the compiler of the intent of the callee functio=
n,
> >> > allowing it to optimize further.
> >> > I personally would leave the copy by value, but I understand if you =
want
> >> > to keep having the same code style.
> >>
> >> It's a pretty big 120-byte structure, so maybe the compiler can
> >> optimize it very well, but I'd still be concerned. Hopefully it can
> >> optimize well even with (const) pointer, if inlining.
> >>
> >> But I do insist, if you look at (most? I haven't checked every single
> >> function, of course) other uses in verifier.c, we pass things like
> >> that by pointer. I understand the desire to specify the intent to not
> >> modify it, but that's why you are passing `const struct bpf_reg_state
> >> *reg`, so I think you don't lose anything with that.
> Well, the const will only guard the pointer from mutating, not the data
> pointed by it.

I didn't propose marking pointer const, but mark pointee type as const:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e474ef44e9c..de2bc6fa15da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -363,12 +363,14 @@ __printf(2, 3) static void verbose(void
*private_data, const char *fmt, ...)
 }

 static void verbose_invalid_scalar(struct bpf_verifier_env *env,
-                                  struct bpf_reg_state *reg,
+                                  const struct bpf_reg_state *reg,
                                   struct bpf_retval_range range,
const char *ctx,
                                   const char *reg_name)
 {
        bool unknown =3D true;

+       reg->smin_value =3D 0x1234;
+
        verbose(env, "%s the register %s has", ctx, reg_name);
        if (reg->smin_value > S64_MIN) {
                verbose(env, " smin=3D%lld", reg->smin_value);

$ make

...

/data/users/andriin/linux/kernel/bpf/verifier.c: In function
=E2=80=98verbose_invalid_scalar=E2=80=99:
/data/users/andriin/linux/kernel/bpf/verifier.c:372:25: error:
assignment of member =E2=80=98smin_value=E2=80=99 in read-only object
  372 |         reg->smin_value =3D 0x1234;
      |                         ^

...

Works as it logically should.

>
> >
> > +1
> > that "struct bpf_reg_state src_reg" code was written 7 years ago
> > when bpf_reg_state was small.
> > We definitely need to fix it. It might even bring
> > a noticeable runtime improvement.
>
> I forgot to reply to Andrii.
>
> I will change the function prototype to pass the pointer instead.
> In any case, please allow me to express my concerns once again, and
> explain why I do it.
>
> As a general practice, I personally will only copy a pointer to a
> function if there is the intent to allow the function to change the
> content of the pointed data.

I'm not sure why you have this preconception that passing something by
pointer is only for mutation. C language has a straightforward way to
express "this is not going to be changed" with const. You can
circumvent this, of course, but that's an entirely different story.

>
> In my understanding, it is easier for the compiler to optimize both the
> caller and the callee when there are less side-effects from that
> function call such as a possible memory clobbering.
>
> Since these particular functions are leaf functions (not calling anywhere=
),
> it should be relatively easy for the compiler to infer that the actual
> copy is not needed and will likely just inline those calls, resulting in
> lots of code being eliminated, which will remove any apparent copies.
>
> I checked the asm file for verifier.c and everything below
> adjust_scalar_min_max_vals including itself is inlined, making it
> totally irrelevant if you copy the data or the pointer, since the
> compiler will identify that the content refers to the same data and all
> copies will be classified and removed as dead-code.
>
> All the pointer passing in any context in verifier.c, to my eyes, is more
> of a software defect then a virtue.
> When there is an actual proven benefit, I am all for it, but not in all
> cases.
>
> I had to express my concerns on this and will never speak of it again.
> :)
>
> Thanks you all for the reviews. I will prepare a new version on Monday.

