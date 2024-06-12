Return-Path: <bpf+bounces-31941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF10F905775
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707211F28158
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8642D182AF;
	Wed, 12 Jun 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbnbiOiw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BFC2D613
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207583; cv=none; b=YutH+lLhRe+QHYjGQs8bM7QaJE1omwV8iUy1l2kAiZrtQSMD9YO+a041ZF/s170r7zrSS3F30noqtN/EjeDxHrBL9czNIj+n762k0QySLVzxLXDslMHDbVh+aelQPN47MiL0z1aRfW0fy8qrTZwDPinQ8s8cd0BYmzCB8Xsy2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207583; c=relaxed/simple;
	bh=hBmlgHBemKGPiqk1y25CJqsDBdu37+FzSm7CgmqHRpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYB9PkRnyuzRx6RUZ1CiNanhVWvLqKROYuVOsdBNgrVuXeu3N6ShuCW+XvW7lvVsP7I4K+My87Y72RBXATHDSaH/m9ePa0oLkzJWvWVMJfp8kL0daodd7yE8rGd0cIt2OCGEMWDiLt28CHQVyTW2H8xd+My/vsEyFl82jgV5tnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbnbiOiw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so37292f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718207580; x=1718812380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkfPyy8faJryq2VF4MNTA0iKFjQZsS7+Iuka+D7aC1w=;
        b=HbnbiOiw4IVZqMrU7YynA9uV0O20ZpKWOkMNDe6YBFhHAzxWHcrcNlYKSB0n3gViFj
         35IU1O8PA6zgZzDGLG6HA9jwP0dP9tmE+BTO1LK5eyOktVtZNV6p6YIY56tQbid2Na5q
         5xZ3mtLMxlpGP6zDkpAGtAuvU6GqEPD6bRXDbNynlNZeIjJvAhXMl7K2KcGx831o/Bzp
         X3LWQ8tO08LGKueMXnCRdcMCXNPMbmGoL7yN5Ezn11fdGG/uKPQote+4AYzZEjzECR/R
         vHDwYUU+bugZZQC0ihpod1CiD/GELzkWuGWTiwP9t80Xg3kDTx6FcrYcT72EUmR9obpq
         s1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718207580; x=1718812380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkfPyy8faJryq2VF4MNTA0iKFjQZsS7+Iuka+D7aC1w=;
        b=ooJsjnnbCO8le/1JmvfCYiae+jDABhuuzgfoSN//vPMgzhJmbv7kXfvrxAgi66PUY3
         WuR1BPAqsPGZsSjvQMtYBXT/vwQq7SkyiMPH5A1q4gOuGLXthzn3kyKBy00wv+Zf6p/l
         5+VPe2ONB1pUb1N5CZL/LoYmuS3qPbrvGDPghqjmQbV+Lwq1jscdXyMBVu7G03Wbl9P/
         +PNOqIgGg2DR6d5MUmqeFLjbjveH9zygaOWmRgo4iJOZi6eaL+uxjgDAA3u4NZ0sxN2n
         9C4Dd8R1QbZiVahKHzr51z2h1NUThWew6ucn3ytSbQBChle7nTultx6eTLGb0fxMbYPM
         aUSw==
X-Gm-Message-State: AOJu0YyDxtCBCJfTRHn+nmix56IkIk03IUCTP+6oc6S56AxVMuVBbp1P
	GdsHnSXc4eZ2qnFHsl0MMgj6dMFywI1nVuA6DPATaAChBTJ3bkTHPH/GVqMI2kq1LFKfe2RxE0m
	tZDXAlpNfwmUZYSpH18j6F6gBy+RM0/tA
X-Google-Smtp-Source: AGHT+IFG7SY2WIC2Wp29GqjGVahtXRDupuCAqUNLQfq5yi+oMedMppOoC2aDeLB53l2Aq6d+dWcyb/EEbDsJSTSgedA=
X-Received: by 2002:adf:fc86:0:b0:360:703a:1d27 with SMTP id
 ffacd0b85a97d-360703a1d6amr778792f8f.51.1718207579386; Wed, 12 Jun 2024
 08:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
 <20240610230849.80820-3-alexei.starovoitov@gmail.com> <d454304daffd5fcd8b442f2e29aa493c426dc991.camel@gmail.com>
In-Reply-To: <d454304daffd5fcd8b442f2e29aa493c426dc991.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jun 2024 08:52:47 -0700
Message-ID: <CAADnVQJgffK1GTgx79R1HfdpVwMy-bC+RP8N6WFx+qDZd0fGyA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Track delta between "linked" registers.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-06-10 at 16:08 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 50aa87f8d77f..2b54e25d2364 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -73,7 +73,10 @@ enum bpf_iter_state {
> >  struct bpf_reg_state {
> >       /* Ordering of fields matters.  See states_equal() */
> >       enum bpf_reg_type type;
> > -     /* Fixed part of pointer offset, pointer types only */
> > +     /*
> > +      * Fixed part of pointer offset, pointer types only.
> > +      * Or constant delta between "linked" scalars with the same ID.
> > +      */
> >       s32 off;
>
> After thinking about this some more I came to conclusion that ->off
> has to be checked for scalar registers in regsafe().
> Otherwise the following test is marked as safe:
>
> char buf[10] SEC(".data.buf");
>
> SEC("socket")
> __failure
> __flag(BPF_F_TEST_STATE_FREQ)
> __naked void check_add_const_regsafe_off(void)
> {
>         asm volatile (
>         "r8 =3D %[buf];"
>         "call %[bpf_ktime_get_ns];"
>         "r6 =3D r0;"
>         "call %[bpf_ktime_get_ns];"
>         "r7 =3D r0;"
>         "call %[bpf_ktime_get_ns];"
>         "r1 =3D r0;"              /* same ids for r1 and r0 */
>         "if r6 > r7 goto 1f;"   /* this jump can't be predicted */
>         "r1 +=3D 1;"              /* r1.off =3D=3D +1 */
>         "goto 2f;"
>         "1: r1 +=3D 100;"         /* r1.off =3D=3D +100 */
>         "goto +0;"              /* force checkpoint, must verify r1.off i=
n regsafe() here */

The goto +0 is unnecessary. It will force a checkpoint at the target.
Which is the next insn, but the next insn is 'if' already
which will be marked as a checkpoint.

But I'll keep it in the next version, since it makes the verifier log
easier to read.
Without goto +0 the verifier doesn't have a chance to print
the value of R1 after addition.
I'll only adjust the comment to say
/* verify r1.off in regsafe() after this insn */

>         "2: if r0 > 8 goto 3f;" /* r0 range [0,8], r1 range either [1,9] =
or [100,108]*/
>         "r8 +=3D r1;"
>         "*(u8 *)(r8 +0) =3D r0;"  /* potentially unsafe, buf size is 10 *=
/
>         "3: exit;"
>         :
>         : __imm(bpf_ktime_get_ns),
>           __imm_ptr(buf)
>         : __clobber_common);
> }
>
> Sorry for missing this yesterday.
> Something like below is necessary.
> (To trigger ((rold->id & BPF_ADD_CONST) !=3D (rcur->id & BPF_ADD_CONST))
>  a variation of the test where r1 +=3D 1 is not done is necessary).

Yes. Will copy paste into another test.

>
> ---
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ad11e5441860..70e44fa4f765 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16797,6 +16797,10 @@ static bool regsafe(struct bpf_verifier_env *env=
, struct bpf_reg_state *rold,
>                 }
>                 if (!rold->precise && exact =3D=3D NOT_EXACT)
>                         return true;
> +               if ((rold->id & BPF_ADD_CONST) !=3D (rcur->id & BPF_ADD_C=
ONST))
> +                       return false;
> +               if ((rold->id & BPF_ADD_CONST) && (rold->off !=3D rcur->o=
ff))
> +                       return false;

Thanks for the diff.
I haven't considered the case where explored state have
R1=3DPscalar(id=3D3)
and its boundaries were not adjusted by later find_equal_scalars().
Only precision was propagated.
And it will incorrectly match in regsafe() to current
R1=3Dscalar(id=3D3+any)

