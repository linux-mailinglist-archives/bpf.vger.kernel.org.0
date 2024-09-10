Return-Path: <bpf+bounces-39549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5876974619
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8744B2881C4
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7B1AC422;
	Tue, 10 Sep 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCCbEUdt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099311F951
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008199; cv=none; b=mbCO7qZhLXOxR7GBUZ3yFvQtr97ivmht2osl6uW4BPC8ldRWp9R/Qt4bH+ybIK/AWovWHwewpbJdnrW8GM+7IDOJB5YPftD22nMEyf/JIlNBsJxwqrDu1XZKDeNgHdqEo+LLtfGe/wEioMmk5uIAcQ+boZudWAej3zQSikI59T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008199; c=relaxed/simple;
	bh=oSBtw/955kb3ftstqAmcicdRUSCLWMxjEPyBobDwnB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpmXoSSH45PzhKihoIzzoj3bTJAJOVobH8/bQDhaHtTU2bHVzo09SzJLxw6gTWoTG8V9ZB4OLg+wTF/u2YFBvR02kGDAuAKkF4ddUIg8fQmgRfs9BDpXlIIorZRkswbYzSTxHc2JcvIwjBJGCu8yuG8D02SDRQw6jIV/SmLwnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCCbEUdt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d885019558so4186579a91.2
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726008197; x=1726612997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zfczPxGhF83yn11mLvcyAyrzgs09dGYabDxobet3qQ=;
        b=iCCbEUdtsHKyYGGJtAW7vCi3JVFh2M1vRGVqnFbyi3djD1+YC9vzbDyvy6ydiUfv/K
         OQJXGut0ewVrwFUXnRV8/o0O42mp2Hd9zK9nWkigtrzBnbXB5LbrEokBOnGRqeSOIzNh
         KSNLcZV73GULsj4hawQNSEePQ3DD5e185g2eTMHxAG48KSKo6uJSZFmo3HB8BOIpuRhn
         7NSMZee/wFSaMq9B4Ii8MJRIlXyLWeRodlftrYwpHqYAzBeYMJX/4kbvujxj4RxbN6Ln
         /gPeptXqekBhsekWABwqLyIpGpHZypBf7uhfRpQIAcX/VhrTWwwTMCOinN/IAZEN4d+C
         5/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726008197; x=1726612997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zfczPxGhF83yn11mLvcyAyrzgs09dGYabDxobet3qQ=;
        b=CWlxOGmpsDi2rEE1bbRmznLeSDejHlY1L9IUn49PW7g4U8pZUaBytehkoqPrfH0vEv
         1xtMcL+w6RUwcP97CdPAllh30I5x8vS/DiT3Hy18pbTDWUWxpddrPlf1qWotdJRQH1lI
         fVNwyAojvXHZiFRJciisPop7i/t3d4ClpctxIJDIkrhRCf8tozIMD2JzT3rHvIGrctdG
         MrcwxYialFIqt97owsC/ekRTu+y25EEjALLo4UIllo0D17qIrYN74ld9gjbZNepHSR9A
         WFP8YHnKOiYOUp+dPzkefT+nDkSZvPO6YWcRLFB357sBMM4jHGAdmJ2BhYskwh/Fvo0P
         y8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV6lwow8ksYFJTfvVSIitX9sic9R/kmLUTha+wvNnsNWJyTDXpCEDacGHZukDF6XvNoKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Z2SXzAxtrJe7LahK3cylU8ktKrE+nDN3AGqM4UjYuFUrh4Ft
	3RGoQSWuOSJFOOncQ7hJ3POwJTK69yi07acTp36k5ubKTxpOpfJS8V5V/UcCVi3yBLVjMcbARnD
	M5gXFCkQEwB9vLhrlyNlv4c3t1blgVluI
X-Google-Smtp-Source: AGHT+IE4lBn2oxi3D+9Neg9IN7kZZbssFkHy/ec5ohbTPI5fIY/fcW4eT3kCgHTyAx696Rlm9VAOq4gRnMaD5x6BPjE=
X-Received: by 2002:a17:90b:388b:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2dad5083440mr16723683a91.1.1726008197138; Tue, 10 Sep 2024
 15:43:17 -0700 (PDT)
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
 <6d0e66f9-db1c-444c-b899-1961b41de7c5@linux.dev> <CAADnVQLwZNQkViS-c=BA-2Y7+0pqEpo78Otx9SPjaScF0CGvEw@mail.gmail.com>
In-Reply-To: <CAADnVQLwZNQkViS-c=BA-2Y7+0pqEpo78Otx9SPjaScF0CGvEw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 15:43:03 -0700
Message-ID: <CAEf4BzacmZ_Coua8iqhzmZoSwFW2+i=fMM2=QhywO1w1Kt0vMA@mail.gmail.com>
Subject: Re: Kernel oops caused by signed divide
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zac Ecob <zacecob@protonmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 10, 2024 at 12:32=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >
> >
> > On 9/10/24 11:25 AM, Alexei Starovoitov wrote:
> > > On Tue, Sep 10, 2024 at 11:02=E2=80=AFAM Yonghong Song <yonghong.song=
@linux.dev> wrote:
> > >>
> > >> On 9/10/24 8:21 AM, Alexei Starovoitov wrote:
> > >>> On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Yonghong Song <yonghong.son=
g@linux.dev> wrote:
> > >>>> On 9/9/24 10:29 AM, Alexei Starovoitov wrote:
> > >>>>> On Mon, Sep 9, 2024 at 10:21=E2=80=AFAM Zac Ecob <zacecob@protonm=
ail.com> wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> I recently received a kernel 'oops' about a divide error.
> > >>>>>> After some research, it seems that the 'div64_s64' function used=
 for the 'MOD'/'REM' instructions boils down to an 'idiv'.
> > >>>>>>
> > >>>>>> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, the=
n because of two's complement, there is no corresponding positive value, ca=
using the error (at least to my understanding).
> > >>>>>>
> > >>>>>>
> > >>>>>> Apologies if this is already known / not a relevant concern.
> > >>>>> Thanks for the report. This is a new issue.
> > >>>>>
> > >>>>> Yonghong,
> > >>>>>
> > >>>>> it's related to the new signed div insn.
> > >>>>> It sounds like we need to update chk_and_div[] part of
> > >>>>> the verifier to account for signed div differently.
> > >>>> In verifier, we have
> > >>>>      /* [R,W]x div 0 -> 0 */
> > >>>>      /* [R,W]x mod 0 -> [R,W]x */
> > >>> the verifier is doing what hw does. In this case this is arm64 beha=
vior.
> > >> Okay, I see. I tried on a arm64 machine it indeed hehaves like the a=
bove.
> > >>
> > >> # uname -a
> > >> Linux ... #1 SMP PREEMPT_DYNAMIC Thu Aug  1 06:58:32 PDT 2024 aarch6=
4 aarch64 aarch64 GNU/Linux
> > >> # cat t2.c
> > >> #include <stdio.h>
> > >> #include <limits.h>
> > >> int main(void) {
> > >>     volatile long long a =3D 5;
> > >>     volatile long long b =3D 0;
> > >>     printf("a/b =3D %lld\n", a/b);
> > >>     return 0;
> > >> }
> > >> # cat t3.c
> > >> #include <stdio.h>
> > >> #include <limits.h>
> > >> int main(void) {
> > >>     volatile long long a =3D 5;
> > >>     volatile long long b =3D 0;
> > >>     printf("a%%b =3D %lld\n", a%b);
> > >>     return 0;
> > >> }
> > >> # gcc -O2 t2.c && ./a.out
> > >> a/b =3D 0
> > >> # gcc -O2 t3.c && ./a.out
> > >> a%b =3D 5
> > >>
> > >> on arm64, clang18 compiled binary has the same result
> > >>
> > >> # clang -O2 t2.c && ./a.out
> > >> a/b =3D 0
> > >> # clang -O2 t3.c && ./a.out
> > >> a%b =3D 5
> > >>
> > >> The same source code, compiled on x86_64 with -O2 as well,
> > >> it generates:
> > >>     Floating point exception (core dumped)
> > >>
> > >>>> What the value for
> > >>>>      Rx_a sdiv Rx_b -> ?
> > >>>> where Rx_a =3D INT64_MIN and Rx_b =3D -1?
> > >>> Why does it matter what Rx_a contains ?
> > >> It does matter. See below:
> > >>
> > >> on arm64:
> > >>
> > >> # cat t1.c
> > >> #include <stdio.h>
> > >> #include <limits.h>
> > >> int main(void) {
> > >>     volatile long long a =3D LLONG_MIN;
> > >>     volatile long long b =3D -1;
> > >>     printf("a/b =3D %lld\n", a/b);
> > >>     return 0;
> > >> }
> > >> # clang -O2 t1.c && ./a.out
> > >> a/b =3D -9223372036854775808
> > >> # gcc -O2 t1.c && ./a.out
> > >> a/b =3D -9223372036854775808
> > >>
> > >> So the result of a/b is LLONG_MIN
> > >>
> > >> The same code will cause exception on x86_64:
> > >>
> > >> $ uname -a
> > >> Linux ... #1 SMP Wed Jun  5 06:21:21 PDT 2024 x86_64 x86_64 x86_64 G=
NU/Linux
> > >> [yhs@devvm1513.prn0 ~]$ gcc -O2 t1.c && ./a.out
> > >> Floating point exception (core dumped)
> > >> [yhs@devvm1513.prn0 ~]$ clang -O2 t1.c && ./a.out
> > >> Floating point exception (core dumped)
> > >>
> > >> So this is what we care about.
> > >>
> > >> So I guess we can follow arm64 result too.
> > >>
> > >>> What cpus do in this case?
> > >> See above. arm64 produces *some* result while x64 cause exception.
> > >> We do need to special handle for LLONG_MIN/(-1) case.
> > > My point about Rx_a that idiv will cause out-of-range exception
> > > for many other values than Rx_a =3D=3D INT64_MIN.
> > > I'm not sure that divisor -1 is the only such case either.
> > > Probably is, since intuitively -2 and all other divisors should fit f=
ine.
> > > So the check likely needs Rx_b =3D=3D -1 and a check for high bit in =
Rx_a ?
> >
> > Looks like only Rx_a =3D=3D INT64_MIN may cause the problem.
> > All other Rx_a numbers (from INT64_MIN+1 to INT64_MAX)
> > should be okay. Some selective testing below on x64 host:
> >
> > $ cat t5.c
> > #include <stdio.h>
> > #include <limits.h>
> >
> > unsigned long long res;
> > int main(void) {
> >    volatile long long a;
> >    long long i;
> >    for (i =3D LLONG_MIN + 1; i <=3D LLONG_MIN + 100; i++) {
> >      volatile long long b =3D -1;
> >      a =3D i;
> >      res +=3D (unsigned long long)(a/b);
> >    }
> >    for (i =3D LLONG_MAX - 100; i <=3D LLONG_MAX - 1; i++) {
>
> Changing this test to i <=3D LLONG_MAX
> and compiling with gcc -O0 or clang -O2 or clang -O0
> is causing an exception,
> because 'a' becomes LLONG_MIN.
> Compilers are doing some odd code gen.
> I don't understand how 'i' can wrap this way.
>
> >      volatile long long b =3D -1;
> >      a =3D i;
> >      res +=3D (unsigned long long)(a/b);
> >    }
> >    printf("res =3D %llx\n", res);
> >    return 0;
> > }
> > $ gcc -O2 t5.c && ./a.out
> > res =3D 64
> >
> > So I think it should be okay if the range is from LLONG_MIN + 1
> > to LLONG_MAX - 1.
> >
> > Now for LLONG_MAX/(-1)
> >
> > $ cat t6.c
> > #include <stdio.h>
> > #include <limits.h>
> > int main(void) {
> >    volatile long long a =3D LLONG_MAX;
> >    volatile long long b =3D -1;
> >    printf("a/b =3D %lld\n", a/b);
> >    return 0;
> > }
> > $ gcc -O2 t6.c && ./a.out
> > a/b =3D -9223372036854775807
> >
> > It is okay too. So I think LLONG_MIN/(-1) is the only case
> > we should take care of.
>
> The test shows that that's the case, but I still can wrap
> my head around that only LLONG_MIN/(-1) is a problem.
>
> Any math experts can explain this?
>

Not a math expert, but this is because LLONG_MIN / (-1) needs to be
-LLONG_MIN, right? But -LLONG_MIN is not representable in 2-complement
representation, because positive and negative sides are not
"symmetrical":

LLONG_MIN =3D -9,223,372,036,854,775,808
LLONG_MAX=3D 9,223,372,036,854,775,807

-LLONG_MIN would be 9,223,372,036,854,775,808, which is beyond the
representable range for 64-bit signed integer.

That's why Dave asked about BPF_NEG for LLONG_MIN, it's a similar
problem, its result is unrepresentable value. So in practice
-LLONG_MIN =3D=3D LLONG_MIN :)

$ cat main.c
#include <stdio.h>
#include <stdint.h>

int main()
{
        long long x =3D INT64_MIN;

        printf("%lld %llx %llx\n", x, x, -x);

        return 0;
}
$ cc main.c && ./a.out
-9223372036854775808 8000000000000000 8000000000000000

