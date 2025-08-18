Return-Path: <bpf+bounces-65843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCEB296C4
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 04:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020CD201529
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 02:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0224468D;
	Mon, 18 Aug 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRFX/fVI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F83211A28
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483126; cv=none; b=f5z2RJczTL2Blqta+vRVv5a/wmIrI1goDO2HyxtCgaymNI5yO7cMh9azCBV48H5Avfjn+ss6hbdsycr3i1DmdGrZ2hBuewsDZtTRiHwcQJQPnj3naCWK+YhNyhgoGJqGQQgRSgXLX643IKGJBfJJyZvy5wJbprGzdiuhrptJ/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483126; c=relaxed/simple;
	bh=naTlZRaUNlb8VeiuOF5c4OT0BEEzWNAidtdGjy0+xrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOk8HcA8FWXk9Yy3iW9hVczJSGDB0ip+emp7uULQSCcTPW/BWJ2ySDk55nyGrIfvcM8MLABNoBr/zYE6YrQvLT53HJjHcte4NBaVAGYekit8sEYrl+lnL2epj/rsuj14+1vzI11lSVsY43c9Scmfwjy8smE6Y8psn967WBAYCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRFX/fVI; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74381ff668cso1967029a34.3
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 19:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755483124; x=1756087924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGaDga5YtCG3CjiZzmlyFVzTESRt9bGTGLWDg3BgKEI=;
        b=jRFX/fVI/Kodbo8VWwo+5zAdWGMFcaQ7hMnTN9Xe14EZabemcxyXkzTBRBUC67TyAF
         bhdsnmEw0xX7++Q12rOqVolZGMIl79cmnFxzrnZR8OQHX96YWEf4Wnp4L2lKpyXZxL23
         lYjf7gVaFHxoYYEah6fia0DyoguQcbhFqxFkZB2nQ8B1gSypueMmS5zsRUFJAXrxDXSR
         pvwUH98vRjCfShIM3k+VJtglfy9LSpC4NVv9RQltKRvmZ+LbufYhqlYHQBDCfAQ1MFqv
         IRoTO9JFeLMI3kExHVhI6gKCfK4maby0gcmlCsw29+gvrvpmw45ITBLkMN29WCDdZuL1
         MFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755483124; x=1756087924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGaDga5YtCG3CjiZzmlyFVzTESRt9bGTGLWDg3BgKEI=;
        b=BEuH+Oya2J/xXbZs7W3yi8+ejgRUosZc1wC3o+TJ292+fWAWX0rCANGw7WgAtpxsFq
         86S2oP1PGD0dhvCZjLwxDoj4RrQ6DSMIT6wajfGhw4Q3JE3FfzxrerjP6/3JrLxVeYBM
         X7sVQFE1S0Fp1ytO08kSHjmwKg44dNhffYet5+FBvHLcBvzOF8Rvz9RomDEel82jAmG2
         Sw7r5AJteMf273187/wZ4linl/b2YBE5YkGcMw7Uy4YdU8L9J47KlwIMMLcFBZoWF6NQ
         6Lz+xoUsVXbPpUJvlh92TfINVMYoohq3fjJQFNIyV8EZD8M1i8S/tGBwMGtrJbQWmTYB
         NCFA==
X-Gm-Message-State: AOJu0YyGINIPl7tqh95qU44Gq/G2WP8Awt11rIt4x5DFmLW1ntMIMq+S
	s1V42xUuyAbZHvCPqTFOzlI4iAYyCLmjPGV0ow+OF5WdkYhVprsmkM4swgIh5Fn42pqnFakIxBF
	0Uqd5X1C+JYsrVTqzECEQ7odYALVwE7o=
X-Gm-Gg: ASbGnctQo67Hu/lA4wUAHD6Ue+PmnxSEQ2ioFs1sqZR3/c8IA+9C4eCkPlXBXafb3lP
	Qe9lNksil+frkeKIepj8rQyetzFhpuIr6Q6objb+FgtFjr6JN9vUHjNP72W7rTaQ1dEyFBNrc9X
	16d2910hoD4JBuVzjfdzT3DF4IOFX1uN5BaezSHJUgO2/PTbBuyX6SAT+lG7aAOCqW8mr9XmDLH
	uhMqqk=
X-Google-Smtp-Source: AGHT+IGqINgFJijiIbokUCFOoHWUi7FMHfjSvZurXNNJThNnfxFNZ9byd0YSePUbQ5z8QHdJjlewIxBuIfu8AOt2Vk4=
X-Received: by 2002:a05:6808:2123:b0:40b:2566:9569 with SMTP id
 5614622812f47-435ec4adc7bmr4925614b6e.24.1755483123556; Sun, 17 Aug 2025
 19:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807114732.410177-1-hengqi.chen@gmail.com> <CAADnVQKwZYxc64XLP=jGcx1N3sPHWUxmQRjmDu9M0xoOV5fHkg@mail.gmail.com>
In-Reply-To: <CAADnVQKwZYxc64XLP=jGcx1N3sPHWUxmQRjmDu9M0xoOV5fHkg@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 18 Aug 2025 10:11:52 +0800
X-Gm-Features: Ac12FXw-A_-Kbflxqj3srbbV2R3r0OtKapaguBdlpt98J-ekrejEJIwpTuBnI_Y
Message-ID: <CAEyhmHSFwJf1CJxY6hAd0BBKHdZnaPtg1Jf9nXYZiXC-zJaNWA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Use vmlinux.h for BPF programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:32=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 7, 2025 at 4:47=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
> >
> > Some of the bpf test progs still use linux/libc headers.
> > Let's use vmlinux.h instead like the rest of test progs.
> > This will also ease cross compiling.
>
> only if...
>
> > diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/=
selftests/bpf/progs/loop6.c
> > index e4ff97fbcce1..f8e2628c1083 100644
> > --- a/tools/testing/selftests/bpf/progs/loop6.c
> > +++ b/tools/testing/selftests/bpf/progs/loop6.c
> > @@ -1,8 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > -#include <linux/ptrace.h>
> > -#include <stddef.h>
> > -#include <linux/bpf.h>
> > +#include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include "bpf_misc.h"
> > @@ -26,12 +24,6 @@ char _license[] SEC("license") =3D "GPL";
> >  #define SG_CHAIN       0x01UL
> >  #define SG_END         0x02UL
> >
> > -struct scatterlist {
> > -       unsigned long   page_link;
> > -       unsigned int    offset;
> > -       unsigned int    length;
> > -};
> > -
>
> Pls test your patch before submitting, so that maintainers
> don't need to point to CI that complains about this.
>

Sorry, my bad.

> scetterlist here is not the same as in vmlinux.h which causes issues.
>

After some investigation (with GPT 5), it seems like the issue is raised by
__attribute__((preserve_access_index)) not struct size.

> --
> pw-bot: cr

