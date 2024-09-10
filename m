Return-Path: <bpf+bounces-39515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A774974211
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC351C2546C
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538A18EFCE;
	Tue, 10 Sep 2024 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmJgthMN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBB16F27F
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992724; cv=none; b=ntnKnghfqkEQrtyfRTU8VCXdhBsoBusY7ppIFPRA2RA7GRJYpF4xgusXzS8QYibFV9hcTFKVlYdGjo4uXezTNodFvTjuny5vLVbO+YYD2UVjfEGdvyDreXm6TSgMO0KqjwyPNaTgBntsIsObnl9hITSKjrWZRlOz9l3SgwvuqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992724; c=relaxed/simple;
	bh=oHf6Hh/m2L/QQNprH0JsxML4Hc0lRd5EEBKP/oWHj/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrNt5/doc8AV8jhlQkkQIbGokO5hmEl4NWgvqROzk8eVnT+YNDLMl/4d+JDTOyP5TGJ1aZ6C3CVxYjNeomI1Cm3+ribicMTmLgBqXhHcTdDLMT944tf6AaBHXJdQ/uZ+n0ML/d/e1qFr+iuddbI978DZPeFw5JUSNtKcElbQV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmJgthMN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so15368415e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725992721; x=1726597521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwkr2wBhCT0ti9Aj3WStQe+4sTsxytapucgHWEAftZc=;
        b=lmJgthMNlTrWY8VbKBX/wBt1hdWz3jgcpkwot1zYgmC7GuFDcvaJBu+jWHxPOhwkju
         kAaJdGcgfk/A3FHFu2YdJL3Swdum7s5lyu44C9GBaKfi2EUycmkjBWH6ZNHRL2fDqhXn
         hkIKBnWiWIlyTq/LBa8fbGxuB2sPLT2eGTtjePHK1LNBbXGw0Stir+jPYr3nUWjVnx9j
         4V7kDhmuZLscvA+ne0qgSDhQbtUa9lInzG6nFDXRkuIBW8TturB/9X0pjtze5BaBusnA
         E/ZhEyxA2WaBJDPoTEm9w2QLtvTEZF82pL7oDJykAPLFZ+GS+ZL9mtb9xhL5xRN5j1eN
         vEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725992721; x=1726597521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwkr2wBhCT0ti9Aj3WStQe+4sTsxytapucgHWEAftZc=;
        b=M4gT/Qym0EMjggf19N3pNaWxoNJDHoGQgBV6RD24Zw1j8QKm1MCOacFwXDkD5J8tcw
         Y7JTKfRCpz1EUF2crrxrGJQbXuYvcljMF4QHwK91b4BTNiL1BsMVozbWqPeoLso+RcIY
         3bJz/GwJCzHfvX69V9tl+r9cuRpYavxg+3dGUel2LBNoFU+WKoNly5ewYnyKd7Pybj0Q
         yt2Y6wcUbRoMqEE15CoQdPH8EsBSARS4KzpQbF88AZf697ceP5le7j3Z7vGIic05JxWS
         LbXkP51H9fjS2hbVah1pNmpyQjJPfg+TnMqV9cg0/1WNGtEpNhWqXKhhYrxA0WyvKmPq
         Zh9A==
X-Forwarded-Encrypted: i=1; AJvYcCXCoHCEKv4OsimiA1tqZtVpWFNvL7preNYI1YvX1Jsi3INmSGWIxSdtze4CT2vu9/eVWmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuU999ARRcWSlSTjgg0m+NT5S6iozwy40sG3maX7kxHOHRny7W
	bJpiTJ2EP3pIZIJkCtmUIVJ5XuzM7zvT8ztoRS1j5BfI5PXk21JZq493wnCGGI5Qjvw6Hd4VRiA
	hzPNHjfBvRqFVcormDgkO6do5aCs=
X-Google-Smtp-Source: AGHT+IEdnuwZ+n63HOQ5VYjrIgJJJyIIATdrXxHV+xRocdDmuXa3bSz8pFYXy6kddQcuQI27iFR8yQL4wKD5zceoJfg=
X-Received: by 2002:a05:600c:4451:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-42cae76cfa5mr86207275e9.26.1725992720957; Tue, 10 Sep 2024
 11:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
 <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev> <CAADnVQJPnCvttM+yitHbLRNoPUPs6EK+5VG=-SDP3LVdD70jyg@mail.gmail.com>
 <b1619bd1-807a-44b7-bfe7-fc053a8122eb@linux.dev>
In-Reply-To: <b1619bd1-807a-44b7-bfe7-fc053a8122eb@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Sep 2024 11:25:09 -0700
Message-ID: <CAADnVQLaOCrxqz7rBjeTJe0EUyAGwtjDKQugyKmFdMGT5=XN4g@mail.gmail.com>
Subject: Re: Kernel oops caused by signed divide
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:02=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 9/10/24 8:21 AM, Alexei Starovoitov wrote:
> > On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> On 9/9/24 10:29 AM, Alexei Starovoitov wrote:
> >>> On Mon, Sep 9, 2024 at 10:21=E2=80=AFAM Zac Ecob <zacecob@protonmail.=
com> wrote:
> >>>> Hello,
> >>>>
> >>>> I recently received a kernel 'oops' about a divide error.
> >>>> After some research, it seems that the 'div64_s64' function used for=
 the 'MOD'/'REM' instructions boils down to an 'idiv'.
> >>>>
> >>>> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then be=
cause of two's complement, there is no corresponding positive value, causin=
g the error (at least to my understanding).
> >>>>
> >>>>
> >>>> Apologies if this is already known / not a relevant concern.
> >>> Thanks for the report. This is a new issue.
> >>>
> >>> Yonghong,
> >>>
> >>> it's related to the new signed div insn.
> >>> It sounds like we need to update chk_and_div[] part of
> >>> the verifier to account for signed div differently.
> >> In verifier, we have
> >>     /* [R,W]x div 0 -> 0 */
> >>     /* [R,W]x mod 0 -> [R,W]x */
> > the verifier is doing what hw does. In this case this is arm64 behavior=
.
>
> Okay, I see. I tried on a arm64 machine it indeed hehaves like the above.
>
> # uname -a
> Linux ... #1 SMP PREEMPT_DYNAMIC Thu Aug  1 06:58:32 PDT 2024 aarch64 aar=
ch64 aarch64 GNU/Linux
> # cat t2.c
> #include <stdio.h>
> #include <limits.h>
> int main(void) {
>    volatile long long a =3D 5;
>    volatile long long b =3D 0;
>    printf("a/b =3D %lld\n", a/b);
>    return 0;
> }
> # cat t3.c
> #include <stdio.h>
> #include <limits.h>
> int main(void) {
>    volatile long long a =3D 5;
>    volatile long long b =3D 0;
>    printf("a%%b =3D %lld\n", a%b);
>    return 0;
> }
> # gcc -O2 t2.c && ./a.out
> a/b =3D 0
> # gcc -O2 t3.c && ./a.out
> a%b =3D 5
>
> on arm64, clang18 compiled binary has the same result
>
> # clang -O2 t2.c && ./a.out
> a/b =3D 0
> # clang -O2 t3.c && ./a.out
> a%b =3D 5
>
> The same source code, compiled on x86_64 with -O2 as well,
> it generates:
>    Floating point exception (core dumped)
>
> >
> >> What the value for
> >>     Rx_a sdiv Rx_b -> ?
> >> where Rx_a =3D INT64_MIN and Rx_b =3D -1?
> > Why does it matter what Rx_a contains ?
>
> It does matter. See below:
>
> on arm64:
>
> # cat t1.c
> #include <stdio.h>
> #include <limits.h>
> int main(void) {
>    volatile long long a =3D LLONG_MIN;
>    volatile long long b =3D -1;
>    printf("a/b =3D %lld\n", a/b);
>    return 0;
> }
> # clang -O2 t1.c && ./a.out
> a/b =3D -9223372036854775808
> # gcc -O2 t1.c && ./a.out
> a/b =3D -9223372036854775808
>
> So the result of a/b is LLONG_MIN
>
> The same code will cause exception on x86_64:
>
> $ uname -a
> Linux ... #1 SMP Wed Jun  5 06:21:21 PDT 2024 x86_64 x86_64 x86_64 GNU/Li=
nux
> [yhs@devvm1513.prn0 ~]$ gcc -O2 t1.c && ./a.out
> Floating point exception (core dumped)
> [yhs@devvm1513.prn0 ~]$ clang -O2 t1.c && ./a.out
> Floating point exception (core dumped)
>
> So this is what we care about.
>
> So I guess we can follow arm64 result too.
>
> >
> > What cpus do in this case?
>
> See above. arm64 produces *some* result while x64 cause exception.
> We do need to special handle for LLONG_MIN/(-1) case.

My point about Rx_a that idiv will cause out-of-range exception
for many other values than Rx_a =3D=3D INT64_MIN.
I'm not sure that divisor -1 is the only such case either.
Probably is, since intuitively -2 and all other divisors should fit fine.
So the check likely needs Rx_b =3D=3D -1 and a check for high bit in Rx_a ?

