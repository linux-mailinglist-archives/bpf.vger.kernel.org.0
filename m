Return-Path: <bpf+bounces-39542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB05D974518
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7A81C257BF
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCF1AB51E;
	Tue, 10 Sep 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAKp0nRs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314E16C854
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005205; cv=none; b=S+GVzWdhTe+SInvLoC5FsAfJYi03MQKMSIN0q/KKRwvgrMmwi5KlCQpz0s3jzRlmcjeEJdarMoYOrYC65B+8aBzTMdZO5RMrDW6cPlfPg9ZG4UVkdvrDq8AKZUC7GxH+S9xkIs3CaPbyu5ymxGSXSdU4WOu/B9P4MnTSIZjx/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005205; c=relaxed/simple;
	bh=f+K67kUDJP5HSZEzk/0ar1SaW1kleFiuQ0ikvEiUQZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3DLJVMus1CQ589b6VCrGBycSjMUYOsZR7Ik13ZTkivd+BWdF6Jlzw2AM1X8gWDOWQFIXdqJouxMJ8mymVo4DaSbTlktX8vq4g61+lphJfsbUUhgONP3ZCjo/rt5aO2McNSsF62taFs7AVkJgwEYAlmf5Ls6/XeIMM5ElHrAe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAKp0nRs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374bb08d011so3473050f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726005202; x=1726610002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOqe6yAjfEq2dhqWIcYhc2yAg89jS9tawlBTCx3Nco8=;
        b=XAKp0nRsgE4Zzc84w3R54Lr7UOLc9wTUVQhF7vnqm7GSrITdW9gUZahx6AFOqf5Vd4
         aF/q+rUea1mKBRWb7cxvc7S86T1heK95MDcpalfBUroMHk65eVIEgfKL0RlTmTBP89md
         oOpSMiBvky7XDYejmUS4geqJQaW5Sp3PodTt0u5s6Wc3X1YiQjv+Qh3mNlld8FgwyFbr
         o6JUIOgxIVO+5oo7JCwh6fqr/goy5v6Ah7EV2V+RaQlCul5HCfFrN7JDvbX/pcuWIh9r
         upn7o6PlhAz1MoI82OzB4+drCt25s/ZJ7JVzZ5CL3rZzXblSoKjWiCWrxfVxiSAioMQc
         z6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726005202; x=1726610002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOqe6yAjfEq2dhqWIcYhc2yAg89jS9tawlBTCx3Nco8=;
        b=o4zlzoeLQqvaB7qRLhITb87B2zshfslO7DmnW1oc1+nxJxpsi4YBl90oY3AexaY/a1
         /y2tgSznoI5UE/gGlbj/n0Z/FU06cWbHgKIOYQFTuKrNn7Qpk0YRAUNo5LJf6lhRtNus
         tIhrL7ryRToJ0aP756RNeHn7lOAMgt1Z8WqXc2T+HJ7VaCpTKP/ehLdf3h2NdDT/Jn8o
         phuGcUgX9HoIJqlVJ9opNYkwpAp8DKe5sARqdhM9nkHY9XKAbAOrWfo+pDROGjjlYgIH
         bDcNswPxPTy80mRgyi3oCzFoLY3Vo/a8YOXHSbGCglcE9kINOndskPSvODTgjz6Vdn1S
         232Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5Veiks4F8uJ3NC21HZsHPFPG0kSgWSbL75a+dPXEMNbH+KhYht7h/RLnkTOXvIwMntQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygafgiqkY51j14i+3o3mdQZqpIdiNF3TlZ0vEWtoxViM6vT9ic
	NGTsCEl+qYpXV3b2yKblejwAemkdUcIsLYpEWTMqj4K7mGbgssKnQWhDlHh9h4HHatTKP0H0ooM
	wgYNJpVdsimWcy8j+82PPxyqqZfc=
X-Google-Smtp-Source: AGHT+IHsS6aGi19nfzfxitXflmTLn5qjHh+Z8kASK+G/cvTm5J64O16f07bLJNaUlHmaZqjbS/Qj9LKvovGfp4QDOu4=
X-Received: by 2002:a5d:4101:0:b0:375:1b02:1e3c with SMTP id
 ffacd0b85a97d-37889674984mr9758429f8f.45.1726005201642; Tue, 10 Sep 2024
 14:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
 <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev> <CAADnVQJPnCvttM+yitHbLRNoPUPs6EK+5VG=-SDP3LVdD70jyg@mail.gmail.com>
 <b1619bd1-807a-44b7-bfe7-fc053a8122eb@linux.dev> <CAADnVQLaOCrxqz7rBjeTJe0EUyAGwtjDKQugyKmFdMGT5=XN4g@mail.gmail.com>
 <6d0e66f9-db1c-444c-b899-1961b41de7c5@linux.dev>
In-Reply-To: <6d0e66f9-db1c-444c-b899-1961b41de7c5@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Sep 2024 14:53:10 -0700
Message-ID: <CAADnVQLwZNQkViS-c=BA-2Y7+0pqEpo78Otx9SPjaScF0CGvEw@mail.gmail.com>
Subject: Re: Kernel oops caused by signed divide
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:32=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 9/10/24 11:25 AM, Alexei Starovoitov wrote:
> > On Tue, Sep 10, 2024 at 11:02=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>
> >> On 9/10/24 8:21 AM, Alexei Starovoitov wrote:
> >>> On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> >>>> On 9/9/24 10:29 AM, Alexei Starovoitov wrote:
> >>>>> On Mon, Sep 9, 2024 at 10:21=E2=80=AFAM Zac Ecob <zacecob@protonmai=
l.com> wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> I recently received a kernel 'oops' about a divide error.
> >>>>>> After some research, it seems that the 'div64_s64' function used f=
or the 'MOD'/'REM' instructions boils down to an 'idiv'.
> >>>>>>
> >>>>>> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then =
because of two's complement, there is no corresponding positive value, caus=
ing the error (at least to my understanding).
> >>>>>>
> >>>>>>
> >>>>>> Apologies if this is already known / not a relevant concern.
> >>>>> Thanks for the report. This is a new issue.
> >>>>>
> >>>>> Yonghong,
> >>>>>
> >>>>> it's related to the new signed div insn.
> >>>>> It sounds like we need to update chk_and_div[] part of
> >>>>> the verifier to account for signed div differently.
> >>>> In verifier, we have
> >>>>      /* [R,W]x div 0 -> 0 */
> >>>>      /* [R,W]x mod 0 -> [R,W]x */
> >>> the verifier is doing what hw does. In this case this is arm64 behavi=
or.
> >> Okay, I see. I tried on a arm64 machine it indeed hehaves like the abo=
ve.
> >>
> >> # uname -a
> >> Linux ... #1 SMP PREEMPT_DYNAMIC Thu Aug  1 06:58:32 PDT 2024 aarch64 =
aarch64 aarch64 GNU/Linux
> >> # cat t2.c
> >> #include <stdio.h>
> >> #include <limits.h>
> >> int main(void) {
> >>     volatile long long a =3D 5;
> >>     volatile long long b =3D 0;
> >>     printf("a/b =3D %lld\n", a/b);
> >>     return 0;
> >> }
> >> # cat t3.c
> >> #include <stdio.h>
> >> #include <limits.h>
> >> int main(void) {
> >>     volatile long long a =3D 5;
> >>     volatile long long b =3D 0;
> >>     printf("a%%b =3D %lld\n", a%b);
> >>     return 0;
> >> }
> >> # gcc -O2 t2.c && ./a.out
> >> a/b =3D 0
> >> # gcc -O2 t3.c && ./a.out
> >> a%b =3D 5
> >>
> >> on arm64, clang18 compiled binary has the same result
> >>
> >> # clang -O2 t2.c && ./a.out
> >> a/b =3D 0
> >> # clang -O2 t3.c && ./a.out
> >> a%b =3D 5
> >>
> >> The same source code, compiled on x86_64 with -O2 as well,
> >> it generates:
> >>     Floating point exception (core dumped)
> >>
> >>>> What the value for
> >>>>      Rx_a sdiv Rx_b -> ?
> >>>> where Rx_a =3D INT64_MIN and Rx_b =3D -1?
> >>> Why does it matter what Rx_a contains ?
> >> It does matter. See below:
> >>
> >> on arm64:
> >>
> >> # cat t1.c
> >> #include <stdio.h>
> >> #include <limits.h>
> >> int main(void) {
> >>     volatile long long a =3D LLONG_MIN;
> >>     volatile long long b =3D -1;
> >>     printf("a/b =3D %lld\n", a/b);
> >>     return 0;
> >> }
> >> # clang -O2 t1.c && ./a.out
> >> a/b =3D -9223372036854775808
> >> # gcc -O2 t1.c && ./a.out
> >> a/b =3D -9223372036854775808
> >>
> >> So the result of a/b is LLONG_MIN
> >>
> >> The same code will cause exception on x86_64:
> >>
> >> $ uname -a
> >> Linux ... #1 SMP Wed Jun  5 06:21:21 PDT 2024 x86_64 x86_64 x86_64 GNU=
/Linux
> >> [yhs@devvm1513.prn0 ~]$ gcc -O2 t1.c && ./a.out
> >> Floating point exception (core dumped)
> >> [yhs@devvm1513.prn0 ~]$ clang -O2 t1.c && ./a.out
> >> Floating point exception (core dumped)
> >>
> >> So this is what we care about.
> >>
> >> So I guess we can follow arm64 result too.
> >>
> >>> What cpus do in this case?
> >> See above. arm64 produces *some* result while x64 cause exception.
> >> We do need to special handle for LLONG_MIN/(-1) case.
> > My point about Rx_a that idiv will cause out-of-range exception
> > for many other values than Rx_a =3D=3D INT64_MIN.
> > I'm not sure that divisor -1 is the only such case either.
> > Probably is, since intuitively -2 and all other divisors should fit fin=
e.
> > So the check likely needs Rx_b =3D=3D -1 and a check for high bit in Rx=
_a ?
>
> Looks like only Rx_a =3D=3D INT64_MIN may cause the problem.
> All other Rx_a numbers (from INT64_MIN+1 to INT64_MAX)
> should be okay. Some selective testing below on x64 host:
>
> $ cat t5.c
> #include <stdio.h>
> #include <limits.h>
>
> unsigned long long res;
> int main(void) {
>    volatile long long a;
>    long long i;
>    for (i =3D LLONG_MIN + 1; i <=3D LLONG_MIN + 100; i++) {
>      volatile long long b =3D -1;
>      a =3D i;
>      res +=3D (unsigned long long)(a/b);
>    }
>    for (i =3D LLONG_MAX - 100; i <=3D LLONG_MAX - 1; i++) {

Changing this test to i <=3D LLONG_MAX
and compiling with gcc -O0 or clang -O2 or clang -O0
is causing an exception,
because 'a' becomes LLONG_MIN.
Compilers are doing some odd code gen.
I don't understand how 'i' can wrap this way.

>      volatile long long b =3D -1;
>      a =3D i;
>      res +=3D (unsigned long long)(a/b);
>    }
>    printf("res =3D %llx\n", res);
>    return 0;
> }
> $ gcc -O2 t5.c && ./a.out
> res =3D 64
>
> So I think it should be okay if the range is from LLONG_MIN + 1
> to LLONG_MAX - 1.
>
> Now for LLONG_MAX/(-1)
>
> $ cat t6.c
> #include <stdio.h>
> #include <limits.h>
> int main(void) {
>    volatile long long a =3D LLONG_MAX;
>    volatile long long b =3D -1;
>    printf("a/b =3D %lld\n", a/b);
>    return 0;
> }
> $ gcc -O2 t6.c && ./a.out
> a/b =3D -9223372036854775807
>
> It is okay too. So I think LLONG_MIN/(-1) is the only case
> we should take care of.

The test shows that that's the case, but I still can wrap
my head around that only LLONG_MIN/(-1) is a problem.

Any math experts can explain this?

