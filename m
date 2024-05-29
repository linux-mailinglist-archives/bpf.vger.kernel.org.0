Return-Path: <bpf+bounces-30808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 653318D2975
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 02:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE552B23E14
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CF15990E;
	Wed, 29 May 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBV6BM6l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA517E8E4
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716942892; cv=none; b=UiOiV+ZJOGCLs84IivGD32fJI6uqDaO2QfohFskfVPbeMi88DHHqz6jD3REz9X5RSVUwEJHO2MG2coRYlYL0nXkL0eIInn/1DBNj78R5w5EGOTqarcVz09U1RTjJeDeRekFZ/HMbU/l/a4ZpB3lZWS4PxCk5Q/BCB0LF7j53Dyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716942892; c=relaxed/simple;
	bh=nJNaCblzmyPN0lePCmnjzBJvkdSzkR330JMSR6UFCGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjP8aSU7eLbnv8yenwvXXdpFEBrbo8sk5K1EWalG4twCtvkLgNm9OPTAu2sRnyKI5J/80Bfc4PrVVWuoXOjS9dw3yZDqm2lEhQBDudxj884gKYiggYPg/twVHPzQklv0DKI/BWViMpMW/+JGSVDoNlackGzTcHOjPJFChxnHg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBV6BM6l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42121d28664so4917655e9.2
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716942889; x=1717547689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Wvlmtk32oh6HH26Fol6Sei9PSlA2+TVfr/8RPXaIYU=;
        b=kBV6BM6lQhdClllcVTk3OuFb3BkX7AKqftbPPY2hNImenrNCK2sKA/fOLL+PmE3PMq
         bYTedLj0OR+KWSdkPkjustNQU7yRur4PMbqiy4Pvexq29ssYO6HeHRq0hsSk9WdRyN5M
         fPmjuDSxdmG5L38HqBXeVzCLq0T9QvpyJt+L/DpYupquwx7QZYBvMNzztcvLluQtfYPi
         DNz9CSoIWqMKGO9VlPsFONUaoN3onZIfmjr8pBqkYCj2v3iE+Zg3hwLgyw0uibDXlsfW
         LauFSUY9Lw71GS3/67kafdUnEAB0hqJZ0k8uyX7DsU+En5Rm5W1hxDVGC0e/OG/8771y
         mHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716942889; x=1717547689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Wvlmtk32oh6HH26Fol6Sei9PSlA2+TVfr/8RPXaIYU=;
        b=vERdbKqCs1u97/HENGSI+GIVW1dF3pfGD9gPs6wuvtKfPl/s8FddZxQcTOo89b7BLp
         G/09DfN+c4cmhsHKJwh+py/0jdIJlkGrIFssZAtuu5eUvyqjDxtYqi/CzDmSQ2V8+SY6
         PDpAXWkLowncu49+eoO4eq/6A+5T+WQOgw11uyzYBB1E30Po0QGFMF+d9Evtpoj9h3Tk
         1TITnYYiscSdcoBvaUG9EbEsYr7qMMAFRNtxikNH6PH8ZHxr+QahFqQwXn7TVG4VS3he
         69TEux58Y5/Be2JQ0nVYT2NscQuiNCUeYS/X7tgs4nJqUZwTiiVp4IJjbSD782doy7Mb
         dk2g==
X-Gm-Message-State: AOJu0YwzMnFndiBJJgtZNeC56bDP+edgPIUdm8meDK1uXpsCJMTrUXHB
	gDWQa8un4fcpwxz2BSeee0V43P/usoK0SrDmPUpDnI+bc0NaEggIj5mp8qXamznyMC+ksd7MaFj
	t/WmsctjpT4/PiFWLVXo78VBH2A8=
X-Google-Smtp-Source: AGHT+IGgyxJmt3jm1YF0dmFxXxE5mFN6yxs01ZNJc9yDZ5wJCUIwhwfQ8JwfHDVbPS6mBsUJeNh0TejhmG+1k70Dlds=
X-Received: by 2002:a7b:cbd8:0:b0:421:50b:e200 with SMTP id
 5b1f17b1804b1-42108a20f2emr105849965e9.34.1716942888701; Tue, 28 May 2024
 17:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com> <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
In-Reply-To: <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 May 2024 17:34:37 -0700
Message-ID: <CAADnVQJdaQT_KPEjvmniCTeUed3jY0mzDNLUhKbFjpbjApMJrA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 9:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-05-24 at 20:11 -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
>
> [...]
>
> > With that the get_loop_entry() can be used to gate is_branch_taken() lo=
gic.
> > When the verifier sees 'r1 > 1000' inside the loop and it can predict i=
t
> > instead of marking r1 as precise it widens both branches, so r1 becomes
> > [0, 1000] in fallthrough and [1001, UMAX] in other_branch.
> >
> > Consider the loop:
> >     bpf_for_each(...) {
> >        if (r1 > 1000)
> >           break;
> >
> >        arr[r1] =3D ..;
> >     }
> > At arr[r1] access the r1 is bounded and the loop can quickly converge.
> >
> > Unfortunately compilers (both GCC and LLVM) often optimize loop exit
> > condition to equality, so
> >  for (i =3D 0; i < 100; i++) arr[i] =3D 1
> > becomes
> >  for (i =3D 0; i !=3D 100; i++) arr[1] =3D 1
> >
> > Hence treat !=3D and =3D=3D conditions specially in the verifier.
> > Widen only not-predicted branch and keep predict branch as is. Example:
> >   r1 =3D 0
> >   goto L1
> > L2:
> >   arr[r1] =3D 1
> >   r1++
> > L1:
> >   if r1 !=3D 100 goto L2
> >   fallthrough: r1=3D100 after widening
> >   other_branch: r1 stays as-is (0, 1, 2, ..)
>
> [...]
>
> I'm not sure how much of a deal-breaker this is, but proposed
> heuristics precludes verification for the following program:

not quite.

>   char arr[10];
>
>   SEC("socket")
>   __success __flag(BPF_F_TEST_STATE_FREQ)
>   int simple_loop(const void *ctx)
>   {
>         struct bpf_iter_num it;
>         int *v, sum =3D 0, i =3D 0;
>
>         bpf_iter_num_new(&it, 0, 10);
>         while ((v =3D bpf_iter_num_next(&it))) {
>                 if (i < 5)
>                         sum +=3D arr[i++];
>         }
>         bpf_iter_num_destroy(&it);
>         return sum;
>   }
>
> The presence of the loop with bpf_iter_num creates a set of states
> with non-null loop_header, which in turn switches-off predictions for
> comparison operations inside the loop.

Is this a pseudo code ?
Because your guess at the reason for the verifier reject is not correct.
It's signed stuff that is causing issues.
s/int i/__u32 i/
and this test is passing the verifier with just 143 insn processed.

> This looks like a bad a compose-ability of verifier features to me.

As with any heuristic there are two steps forward and one step back.
The heuristic is trying to minimize the size of that step back.
If you noticed in v1 and v2 I had to add 'if (!v) break;'
to iter_pragma_unroll_loop().
And it would have been ok this way.
It is a step back for a corner case like iter_pragma_unroll_loop().
Luckily this new algorithm in v3 doesn't need this if (!v) workaround
anymore. So the step back is minimized.
Is it still there? Absolutely. There is a chance that some working prog
will stop working. (as with any verifier change).


> --
>
> Instead of heuristics, maybe rely on hints from the programmer?
> E.g. add a kfunc `u64 bpf_widen(u64)` which will be compiled as an
> identity function, but would instruct verifier to drop precision for a
> specific value. When work on no_caller_saved_registers finishes this
> even could be available w/o runtime cost.
> (And at the moment could be emulated by something like `rX /=3D 1`).

No way. i =3D zero is an unpleasant enough workaround.
The verifier precision tracking is not something users understand.
Using i=3Dzero is not pretty, but asking them doing i =3D bpf_widen(0)
or i =3D 0; asm("i /=3D 1") is definitely no go.
The main issue is that users don't know when to do that.
bpf_widen(0) is magic. People will be just guessing.
Just like i=3Dzero is magical.
All such magic has to go. The users should write normal C.

