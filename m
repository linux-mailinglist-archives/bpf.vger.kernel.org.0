Return-Path: <bpf+bounces-44688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E599C6608
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572AAB28C25
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 00:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659621C185;
	Wed, 13 Nov 2024 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd+tcUQG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657B230982
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456000; cv=none; b=ran0NcXQAcPsaV0FiRtg9e0aQ1xMwJT0KXCp+FAOHVw6oXmOoiD9cbT1Xziy6IVYlyqaRTWZTK7JsfES+hgJDDkLXjpnSe0eILT2oo2930vUw+PcYx1ABda2q+e8dRolfoRPDSBwgOXvNsx0I0TVOVht2dxLItP72SzeVIt0k8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456000; c=relaxed/simple;
	bh=P5xBgJuMQdbndW9JFsmTD4+hTkuzXBHcSCy71wJE6PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPTHyq5PVFDlpuR1fIqmFoUfG68c0VgZtXXI6T5rc6HKpzAeVL1akwRld8V1Amh7roXexN33Y38CzRHcDWfFBQUDY9SvwDHDkfWqwG42y2+zvhsJ2owovXRZfot/GV33d+NSkW2Y67nlZCnBANkGnfUbNyUr1TJufcShleEAkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd+tcUQG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so4948373a91.2
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 15:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731455998; x=1732060798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/Js+/WQZaT/u2+eatTDlHCKFkW0p8dw3T1fwgSNj9o=;
        b=Jd+tcUQGRTzkw70R52yEOae2bLR79j6xXEPvLy2O65gDZZjV/8vSAbR0ynZK+jCcgT
         0k49GjiQUupQoxF7Bdln+U/h4vpfjs1YwhtWnCTZvytXuSQpwNlLMw+w/0ZppMzy6NF1
         4H9kcU5kLxM0QNq6SPnXA4GqoyTnsFPqpQQnWcvAL3YcbgNjKESQhGk0y5ZE3M22sHu1
         m4rzjg+eEb+r3a8p+pf+fenQHnaANuvIsMNRGMNvV4QrxpCcywJriIinxjgMn/ll/eUK
         7D8h9HxIsBCJCg5qr4qALYcbi71924Sw1dVY7mNgyeEMSBg1WkdGgIG7XeT4SgLnHTKm
         lw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455998; x=1732060798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/Js+/WQZaT/u2+eatTDlHCKFkW0p8dw3T1fwgSNj9o=;
        b=UW6oOb53ylv1943xFTAcvJJw2i7EzSJzdp/+3iV/Up16Fu5NMu0HDMkApJ4RoZEoGW
         wJTui5mfIy/qWO8KJwwWLfdNhnvbmunA0XqLWKbK4CtBJkS3HKDqTF+ijpSHZ0LlX4X4
         4miONYL9j2irXh/PpvMWD/8hcVpK+qgMq7k++9tPSJrjdz73fGyzKx1WGHGp60egpzq2
         9/IrD5134hnjqsYZhMlO4xNCiSZYgAcZZbvZu4Ny8bu/TXQSwGH2pRzzNYaTf+Hvgymj
         rgqK4rYgAk7ykGdq7PmBEBU5je+GWqvqlMuQea2QDks9jv7WPyUCmf5Kon15lqgBi+Sq
         lFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEKSJnvYbELKYQ4AM0BqhqcUZUI9IhM/zfGPmxIm48Ye0zlkzQhz7JZjNLFamICK7NMQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKK7Oln4xRYE8Chz4n/B07jKP+I752sdZyd095n3NuNiLQlc8
	xNqXy8pBA549oD+aZc0uNWxSrb4iIetCYJ50eqjsrUEqHPYSIAktvubHnN57sgoryMWSbkvIiaL
	5OSyVxypgZyHK8E6jCnzapkWen5s=
X-Google-Smtp-Source: AGHT+IHxYZ0pCbuJwiLQ8eOQE3eaFrxSnqH760cvxGAyZL6g4BiLWqqI5N+JYkoYeGOun+mGq+2PJJJeJ6mXYQUWOkI=
X-Received: by 2002:a17:90b:5208:b0:2e2:e31a:220e with SMTP id
 98e67ed59e1d1-2e9b16f0b30mr22440257a91.8.1731455997907; Tue, 12 Nov 2024
 15:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109004158.2259301-1-vadfed@meta.com> <CAEf4BzaRb+fUK17wrj4sWnYM5oKxTvwZC=U-GjvsdUtF94PqrA@mail.gmail.com>
 <946c61c2-ab1e-43cb-adfd-cc5b7716b915@linux.dev>
In-Reply-To: <946c61c2-ab1e-43cb-adfd-cc5b7716b915@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Nov 2024 15:59:45 -0800
Message-ID: <CAEf4BzZ88iLC+txV3TtO8m1V3=aV0t24b5M=bG7_M65TXa8Lpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Mykola Lysenko <mykolal@fb.com>, 
	Jakub Kicinski <kuba@kernel.org>, x86@kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:43=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 12/11/2024 05:50, Andrii Nakryiko wrote:
> > On Fri, Nov 8, 2024 at 4:42=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com=
> wrote:
> >>
> >> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT convert=
s
> >> it into rdtsc ordered call. Other architectures will get JIT
> >> implementation too if supported. The fallback is to
> >> __arch_get_hw_counter().
> >>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >
> > nit: please add cover letter for the next revision, multi-patch sets
> > generally should come with a cover letter, unless it's some set of
> > trivial and mostly independent patches. Anyways...
>
> Yeah, sure. This series has grown from the first small version...
>
> >
> > I haven't yet looked through the code (yet), but I was curious to
> > benchmark the perf benefit, so that's what I did for fun this evening.
> >
> > (!!!) BTW, a complete aside, but I think it's interesting. It turned
> > out that using bpf_test_prog_run() scales *VERY POORLY* with large
> > number of CPUs, because we start spending tons of time in
> > fdget()/fdput(), so I initially got pretty unscalable results,
> > profiled a bit, and then switched to just doing
> > syscall(syscall(__NR_getpgid); + SEC("raw_tp/sys_enter")). Anyways,
> > the point is that microbenchmarking is tricky and we need to improve
> > our existing bench setup for some benchmarks. Anyways, getting back to
> > the main topic.
> >
> > I wrote a quick two benchmarks testing what I see as intended use case
> > for these kfuncs (batching amortizes the cost of triggering BPF
> > program, batch_iters =3D 500 in my case):
> >
> > SEC("?raw_tp/sys_enter")
> > int trigger_driver_ktime(void *ctx)
> > {
> >          volatile __u64 total =3D 0;
> >          int i;
> >
> >          for (i =3D 0; i < batch_iters; i++) {
> >                  __u64 start, end;
> >
> >                  start =3D bpf_ktime_get_ns();
> >                  end =3D bpf_ktime_get_ns();
> >                  total +=3D end - start;
> >          }
> >          inc_counter_batch(batch_iters);
> >
> >          return 0;
> > }
> >
> > extern __u64 bpf_get_cpu_cycles(void) __weak __ksym;
> > extern __u64 bpf_cpu_cycles_to_ns(__u64 cycles) __weak __ksym;
> >
> > SEC("?raw_tp/sys_enter")
> > int trigger_driver_cycles(void *ctx)
> > {
> >          volatile __u64 total =3D 0;
> >          int i;
> >
> >          for (i =3D 0; i < batch_iters; i++) {
> >                  __u64 start, end;
> >
> >                  start =3D bpf_get_cpu_cycles();
> >                  end =3D bpf_get_cpu_cycles();
> >                  total +=3D bpf_cpu_cycles_to_ns(end - start);
> >          }
> >          inc_counter_batch(batch_iters);
> >
> >          return 0;
> > }
> >
> > And here's what I got across multiple numbers of parallel CPUs on our
> > production host.
> >
> > # ./bench_timing.sh
> >
> > ktime                 ( 1 cpus):   32.286 =C2=B1 0.309M/s  ( 32.286M/s/=
cpu)
> > ktime                 ( 2 cpus):   63.021 =C2=B1 0.538M/s  ( 31.511M/s/=
cpu)
> > ktime                 ( 3 cpus):   94.211 =C2=B1 0.686M/s  ( 31.404M/s/=
cpu)
> > ktime                 ( 4 cpus):  124.757 =C2=B1 0.691M/s  ( 31.189M/s/=
cpu)
> > ktime                 ( 5 cpus):  154.855 =C2=B1 0.693M/s  ( 30.971M/s/=
cpu)
> > ktime                 ( 6 cpus):  185.551 =C2=B1 2.304M/s  ( 30.925M/s/=
cpu)
> > ktime                 ( 7 cpus):  211.117 =C2=B1 4.755M/s  ( 30.160M/s/=
cpu)
> > ktime                 ( 8 cpus):  236.454 =C2=B1 0.226M/s  ( 29.557M/s/=
cpu)
> > ktime                 (10 cpus):  295.526 =C2=B1 0.126M/s  ( 29.553M/s/=
cpu)
> > ktime                 (12 cpus):  322.282 =C2=B1 0.153M/s  ( 26.857M/s/=
cpu)
> > ktime                 (14 cpus):  375.347 =C2=B1 0.087M/s  ( 26.811M/s/=
cpu)
> > ktime                 (16 cpus):  399.813 =C2=B1 0.181M/s  ( 24.988M/s/=
cpu)
> > ktime                 (24 cpus):  617.675 =C2=B1 7.053M/s  ( 25.736M/s/=
cpu)
> > ktime                 (32 cpus):  819.695 =C2=B1 0.231M/s  ( 25.615M/s/=
cpu)
> > ktime                 (40 cpus):  996.264 =C2=B1 0.290M/s  ( 24.907M/s/=
cpu)
> > ktime                 (48 cpus): 1180.201 =C2=B1 0.160M/s  ( 24.588M/s/=
cpu)
> > ktime                 (56 cpus): 1321.084 =C2=B1 0.099M/s  ( 23.591M/s/=
cpu)
> > ktime                 (64 cpus): 1482.061 =C2=B1 0.121M/s  ( 23.157M/s/=
cpu)
> > ktime                 (72 cpus): 1666.540 =C2=B1 0.460M/s  ( 23.146M/s/=
cpu)
> > ktime                 (80 cpus): 1851.419 =C2=B1 0.439M/s  ( 23.143M/s/=
cpu)
> >
> > cycles                ( 1 cpus):   45.815 =C2=B1 0.018M/s  ( 45.815M/s/=
cpu)
> > cycles                ( 2 cpus):   86.706 =C2=B1 0.068M/s  ( 43.353M/s/=
cpu)
> > cycles                ( 3 cpus):  129.899 =C2=B1 0.101M/s  ( 43.300M/s/=
cpu)
> > cycles                ( 4 cpus):  168.435 =C2=B1 0.073M/s  ( 42.109M/s/=
cpu)
> > cycles                ( 5 cpus):  210.520 =C2=B1 0.164M/s  ( 42.104M/s/=
cpu)
> > cycles                ( 6 cpus):  252.596 =C2=B1 0.050M/s  ( 42.099M/s/=
cpu)
> > cycles                ( 7 cpus):  294.356 =C2=B1 0.159M/s  ( 42.051M/s/=
cpu)
> > cycles                ( 8 cpus):  317.167 =C2=B1 0.163M/s  ( 39.646M/s/=
cpu)
> > cycles                (10 cpus):  396.141 =C2=B1 0.208M/s  ( 39.614M/s/=
cpu)
> > cycles                (12 cpus):  431.938 =C2=B1 0.511M/s  ( 35.995M/s/=
cpu)
> > cycles                (14 cpus):  503.055 =C2=B1 0.070M/s  ( 35.932M/s/=
cpu)
> > cycles                (16 cpus):  534.261 =C2=B1 0.107M/s  ( 33.391M/s/=
cpu)
> > cycles                (24 cpus):  836.838 =C2=B1 0.141M/s  ( 34.868M/s/=
cpu)
> > cycles                (32 cpus): 1099.689 =C2=B1 0.314M/s  ( 34.365M/s/=
cpu)
> > cycles                (40 cpus): 1336.573 =C2=B1 0.015M/s  ( 33.414M/s/=
cpu)
> > cycles                (48 cpus): 1571.734 =C2=B1 11.151M/s  ( 32.744M/s=
/cpu)
> > cycles                (56 cpus): 1819.242 =C2=B1 4.627M/s  ( 32.486M/s/=
cpu)
> > cycles                (64 cpus): 2046.285 =C2=B1 5.169M/s  ( 31.973M/s/=
cpu)
> > cycles                (72 cpus): 2287.683 =C2=B1 0.787M/s  ( 31.773M/s/=
cpu)
> > cycles                (80 cpus): 2505.414 =C2=B1 0.626M/s  ( 31.318M/s/=
cpu)
> >
> > So, from about +42% on a single CPU, to +36% at 80 CPUs. Not that bad.
> > Scalability-wise, we still see some drop off in performance, but
> > believe me, with bpf_prog_test_run() it was so much worse :) I also
> > verified that now we spend cycles almost exclusively inside the BPF
> > program (so presumably in those benchmarked kfuncs).
>
> Am I right that the numbers show how many iterations were done during
> the very same amount of time? It would be also great to understand if

yeah, it's millions of operations per second

> we get more precise measurements - just in case you have your tests
> ready...
>

not sure what precision you mean here?... I didn't plan to publish
tests, but I can push what I have into a local branch if you'd like to
play with this

