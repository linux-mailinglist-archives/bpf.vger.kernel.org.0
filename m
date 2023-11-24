Return-Path: <bpf+bounces-15792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028437F6AE1
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 04:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315391C20B2B
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 03:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65DF15BF;
	Fri, 24 Nov 2023 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nebPWkNK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE94D43
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:32:10 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50abb83866bso1926608e87.3
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796729; x=1701401529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kH/6zBDiLuYBmLKjS0UOMMsa9ZUaY8oh4+eiBZPDDw=;
        b=nebPWkNK33Tby2G/b74pqE5kNGz0n6xq39LLC31+zDuGvXlZlPVMom74XbEZcwhiFb
         P5CkX4zsRE16PciU79Atr9aOV4VZq4rWO7Gp5eK+o7DzFakEcRgLZs0CgjhvNMmVGRyi
         wUxSYGhzeE6tAlssBVLNvg/C+Ew2piJJNITIeZqupQ60QSh7eOxMbxfMb+U7gLq3wtp+
         ub6x/aMJqGsT/oZ4/PRYEY9/VPyYDkL2PSAbwolaTOog2/ucShbqiHpQToWaE/lCCLBT
         x4PfTwNzmt60WGkIwrz7LVbBangg9ugzTTaWiAyszZtCr1pkabzokV3QQAc0Z5I4A0KD
         TBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796729; x=1701401529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kH/6zBDiLuYBmLKjS0UOMMsa9ZUaY8oh4+eiBZPDDw=;
        b=GNxB3LsilO78/k/716ULPv9WuKtnYWQwJPRFPfAx9SdlGh1y3skS01UQHFGgzVZObm
         OuUzNWkksRexzROx5jc4Xnyihdi7RwL8sMkTA99SXUJqL4C+q9GDuXFkD5C3KMYlKakX
         nJVlj3GFFwufhocp4OmdP0QzqLG7z49ZswfzcG+MkHXtnfRDeb0fVmOE8mZFUYfG0gJf
         FdP4zQXdwELQ1BFwrtA8Ry8p1mqx2imC+OF8WwRCdun3LO8A7LNPufVbvUo4HGDwASll
         7d4lUHJNL0Hi4w0vuvFHoyMPmYcaJd1o1Yt7D1y9NvrcR4WXzcikxXyMmqsem2CaQblv
         8Ajg==
X-Gm-Message-State: AOJu0Ywonddv59jRqxtfxW1xATXYMqIMECMXZHovYfHQ57tvp94Dr3g3
	snHhtJO7+Q2cUzbfdh/pXj9TTKCXyzhpOFE6HFCTwl/hwqw=
X-Google-Smtp-Source: AGHT+IFMzamiujr6UPDX2cVj5XWnHplqdzQ/gvU77hIZhPyyFR1IlRrRauHFjYlryjanBAY0cT8J8fl0yG0bzC2+amo=
X-Received: by 2002:a05:6512:28e:b0:507:a1e0:22f4 with SMTP id
 j14-20020a056512028e00b00507a1e022f4mr673510lfp.29.1700796728555; Thu, 23 Nov
 2023 19:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122213112.3596548-1-andrii@kernel.org> <0117ddb8-4251-c4a1-1bb0-ca19769bd6b3@iogearbox.net>
In-Reply-To: <0117ddb8-4251-c4a1-1bb0-ca19769bd6b3@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Nov 2023 19:31:56 -0800
Message-ID: <CAEf4BzbCab-hmSDCSE2iOWTbm_59Znr5HoF2gj0PMdbt3qZVLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Verify global subprogs lazily
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 2:48=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 11/22/23 10:31 PM, Andrii Nakryiko wrote:
> > See patch #2 for justification. In few words, current eager verificatio=
n of
> > global func prevents BPF CO-RE approaches to be applied to global funct=
ions.
> >
> > Patch #1 is just a nicety to emit global subprog names in verifier logs=
.
> >
> > Patch #3 adds selftests validating new lazy semantics.
> >
> > Andrii Nakryiko (3):
> >    bpf: emit global subprog name in verifier logs
> >    bpf: validate global subprogs lazily
> >    selftests/bpf: add lazy global subprog validation tests
> >
> >   include/linux/bpf.h                           |  2 +
> >   kernel/bpf/verifier.c                         | 88 ++++++++++++++----
> >   .../selftests/bpf/prog_tests/verifier.c       |  2 +
> >   .../selftests/bpf/progs/test_global_func12.c  |  4 +-
> >   .../bpf/progs/verifier_global_subprogs.c      | 92 ++++++++++++++++++=
+
> >   .../bpf/progs/verifier_subprog_precision.c    |  4 +-
> >   6 files changed, 168 insertions(+), 24 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_=
subprogs.c
>
> Series looks good to me, ACK. It needs a rebase however after the fast
> forward of the bpf-next tree from today.

Sure, no problem.

>
>  > With BPF CO-RE approach, the natural way would be to still compile BPF
>  > object file once and guard calls to this global subprog with some CO-R=
E
>  > check or using .rodata variables. That's what people do to guard usage
>  > of new helpers or kfuncs, and any other new BPF-side feature that migh=
t
>  > be missing on old kernels.
>
> I was wondering for selftests, could we also add something similar to the
> above to guard calls via co-re? Just to have this use-case covered in CI.
> Also perhaps one global_bad function which is dead-code would be nice to
> have.
>

We already have that in patch #3. See `const volatile bool
skip_unsupp_global =3D true;` and then

if (!skip_unsupp_global)
    return global_unsupp(NULL);

Because skip_unsupp_global is true, we won't call global_unsupp() from
that main program and it will be dead-code eliminated.

This `const volatile` value can actually be set to false before
loading BPF program, though, and in that case global function will be
actually callable.

Keep in mind that each main (entry) BPF program gets its own copies of
each subprogram (global or static, doesn't matter). So global_bad() is
dead-code for guarded_unsupp_global_called main program, but is not a
dead-code for unguarded_unsupp_global_called prog, in which we
unconditionally call global_bad().

So this should cover all the use cases, I think.


> Thanks,
> Daniel
>

