Return-Path: <bpf+bounces-44594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB99C4E6B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 06:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2398B2188A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5E205AD9;
	Tue, 12 Nov 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp1QpyX/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CF4502F
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390642; cv=none; b=OVAcva637IS6+uAlebEDdMQIUrkfKTjCUT649gOjLnoZtVxFr2G1THjYenzBvB4SpDivFY2PJFjJXeugTrj8fTjUJYeZCrXqTR6zfUH27lf4ki+lZjbYy5+2LRUktdjdLvZbOxFiq5KYlD5nMRURGrJvn48TJdlq2U8P+IBeEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390642; c=relaxed/simple;
	bh=O1qMFbwg3lemh3gZEt42SRpu6sGoOpL1+Xk8pg+11YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAF30WExN//5nRyTNAjFN7r9JBts0RTznLJhpzgIG0UY9rT80NlYZDNwdJwzWd0GRYEBMqha8LvTLCBhpFitLyMfoq5furv5ndNl1yqjM/9INjHDXZUx0Qe8hoj4fCpgwC0kEKR3O5QSmpE5HfCyNEOpftJBZT1DM92IsTzzRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp1QpyX/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso5034074b3a.0
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731390640; x=1731995440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vm7spx7LJb7JQaIGq/8nVMJfyh4AF6FYZhix4XfniFk=;
        b=Gp1QpyX/SuIKow92tkkqaNp7TH0J6kjpIozxr9Nlvp5PpTwIBGaQMhRWmLWl8xw+s7
         uUpOaAY2w0IzWZJfQfPvfZX6me7GiByDn7CsqC2yypRaoqfIPk5dW4j86UnhMtlJFKct
         xepx7B0x489nqETXMGkpoR4fiptPB/iZJMzaiL/RD1989N7Hu2HJdhwywLXkdzN6lZI3
         hhWNpSdRFCnCGEgu/x/4MFLvkLxjuhv8YLP87DD+/4VBC1wvweVjSX0SjI2Z1uESYfhp
         i8nkq4hiZtnjtEzn3QnqvjSu2wiiAl1HZ6Buv2U9uQQjRvvJwIqtdjp4SnpQqdfnfTgm
         QEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731390640; x=1731995440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vm7spx7LJb7JQaIGq/8nVMJfyh4AF6FYZhix4XfniFk=;
        b=BN1qRMgsNKeVdBRLyIuuMSMV4sYNWO17oO/ih2E5vzLeal0Z0etz0Ckf1EKuyc+TsH
         76xdhY7cmV2rzsGrn5dfqfCCJg8RbNTG4AZyIdz6/Fl+DTAnCEL4tfr4PMXnv74otATE
         2x18ZH4TH87vsmHdYE9X6tE0l1XEBEc0Mr/3ucyd8rmc3nxiPeVWmoYMJV/rDe//wp0J
         gZhXszbzDuzwoQxwziC5JkrDgyJMTNYoUOVETwQX9Wl1alI9fR7Hu35X738KPHZIQnML
         nbEF5espFpX6H5r3jIZsZTjXom1TeKzgXA1IbQCte56K4HjP1dYHv0lOzNM1W9Agr9pj
         ELVA==
X-Forwarded-Encrypted: i=1; AJvYcCW0L1VfpmOG93Ehfsry8WT8iLzRKOpF/3h+3cYcuhBays3KqCmawebAPtmv49rfV5tpov0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ARbwQLEviSWEPiIs8kJgKUWb3PhDh8mJi3Q2Kfqvj3pFHyU2
	1vsVnwXstV9/otJwjxxQUkR1yPEgHjCJJXay2ojnQr54v1r2XmsX9DW3Y9rsMLEgfyNYtyGt4U5
	9z1rPPbQHoKmyXMxE9GyMEd7G4GM=
X-Google-Smtp-Source: AGHT+IHLshkr0pR2jweJnGF6aZ9zlgZ3E/GHWHhhoanURuf6BXKGB7+2h9hQv/JeC1YMd21VRpVsM1CxC+rz37vwbNA=
X-Received: by 2002:a05:6300:808c:b0:1db:e16c:cd90 with SMTP id
 adf61e73a8af0-1dc229a6f96mr16321447637.17.1731390640421; Mon, 11 Nov 2024
 21:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109004158.2259301-1-vadfed@meta.com>
In-Reply-To: <20241109004158.2259301-1-vadfed@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 21:50:28 -0800
Message-ID: <CAEf4BzaRb+fUK17wrj4sWnYM5oKxTvwZC=U-GjvsdUtF94PqrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>, x86@kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:42=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> wr=
ote:
>
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

nit: please add cover letter for the next revision, multi-patch sets
generally should come with a cover letter, unless it's some set of
trivial and mostly independent patches. Anyways...

I haven't yet looked through the code (yet), but I was curious to
benchmark the perf benefit, so that's what I did for fun this evening.

(!!!) BTW, a complete aside, but I think it's interesting. It turned
out that using bpf_test_prog_run() scales *VERY POORLY* with large
number of CPUs, because we start spending tons of time in
fdget()/fdput(), so I initially got pretty unscalable results,
profiled a bit, and then switched to just doing
syscall(syscall(__NR_getpgid); + SEC("raw_tp/sys_enter")). Anyways,
the point is that microbenchmarking is tricky and we need to improve
our existing bench setup for some benchmarks. Anyways, getting back to
the main topic.

I wrote a quick two benchmarks testing what I see as intended use case
for these kfuncs (batching amortizes the cost of triggering BPF
program, batch_iters =3D 500 in my case):

SEC("?raw_tp/sys_enter")
int trigger_driver_ktime(void *ctx)
{
        volatile __u64 total =3D 0;
        int i;

        for (i =3D 0; i < batch_iters; i++) {
                __u64 start, end;

                start =3D bpf_ktime_get_ns();
                end =3D bpf_ktime_get_ns();
                total +=3D end - start;
        }
        inc_counter_batch(batch_iters);

        return 0;
}

extern __u64 bpf_get_cpu_cycles(void) __weak __ksym;
extern __u64 bpf_cpu_cycles_to_ns(__u64 cycles) __weak __ksym;

SEC("?raw_tp/sys_enter")
int trigger_driver_cycles(void *ctx)
{
        volatile __u64 total =3D 0;
        int i;

        for (i =3D 0; i < batch_iters; i++) {
                __u64 start, end;

                start =3D bpf_get_cpu_cycles();
                end =3D bpf_get_cpu_cycles();
                total +=3D bpf_cpu_cycles_to_ns(end - start);
        }
        inc_counter_batch(batch_iters);

        return 0;
}

And here's what I got across multiple numbers of parallel CPUs on our
production host.

# ./bench_timing.sh

ktime                 ( 1 cpus):   32.286 =C2=B1 0.309M/s  ( 32.286M/s/cpu)
ktime                 ( 2 cpus):   63.021 =C2=B1 0.538M/s  ( 31.511M/s/cpu)
ktime                 ( 3 cpus):   94.211 =C2=B1 0.686M/s  ( 31.404M/s/cpu)
ktime                 ( 4 cpus):  124.757 =C2=B1 0.691M/s  ( 31.189M/s/cpu)
ktime                 ( 5 cpus):  154.855 =C2=B1 0.693M/s  ( 30.971M/s/cpu)
ktime                 ( 6 cpus):  185.551 =C2=B1 2.304M/s  ( 30.925M/s/cpu)
ktime                 ( 7 cpus):  211.117 =C2=B1 4.755M/s  ( 30.160M/s/cpu)
ktime                 ( 8 cpus):  236.454 =C2=B1 0.226M/s  ( 29.557M/s/cpu)
ktime                 (10 cpus):  295.526 =C2=B1 0.126M/s  ( 29.553M/s/cpu)
ktime                 (12 cpus):  322.282 =C2=B1 0.153M/s  ( 26.857M/s/cpu)
ktime                 (14 cpus):  375.347 =C2=B1 0.087M/s  ( 26.811M/s/cpu)
ktime                 (16 cpus):  399.813 =C2=B1 0.181M/s  ( 24.988M/s/cpu)
ktime                 (24 cpus):  617.675 =C2=B1 7.053M/s  ( 25.736M/s/cpu)
ktime                 (32 cpus):  819.695 =C2=B1 0.231M/s  ( 25.615M/s/cpu)
ktime                 (40 cpus):  996.264 =C2=B1 0.290M/s  ( 24.907M/s/cpu)
ktime                 (48 cpus): 1180.201 =C2=B1 0.160M/s  ( 24.588M/s/cpu)
ktime                 (56 cpus): 1321.084 =C2=B1 0.099M/s  ( 23.591M/s/cpu)
ktime                 (64 cpus): 1482.061 =C2=B1 0.121M/s  ( 23.157M/s/cpu)
ktime                 (72 cpus): 1666.540 =C2=B1 0.460M/s  ( 23.146M/s/cpu)
ktime                 (80 cpus): 1851.419 =C2=B1 0.439M/s  ( 23.143M/s/cpu)

cycles                ( 1 cpus):   45.815 =C2=B1 0.018M/s  ( 45.815M/s/cpu)
cycles                ( 2 cpus):   86.706 =C2=B1 0.068M/s  ( 43.353M/s/cpu)
cycles                ( 3 cpus):  129.899 =C2=B1 0.101M/s  ( 43.300M/s/cpu)
cycles                ( 4 cpus):  168.435 =C2=B1 0.073M/s  ( 42.109M/s/cpu)
cycles                ( 5 cpus):  210.520 =C2=B1 0.164M/s  ( 42.104M/s/cpu)
cycles                ( 6 cpus):  252.596 =C2=B1 0.050M/s  ( 42.099M/s/cpu)
cycles                ( 7 cpus):  294.356 =C2=B1 0.159M/s  ( 42.051M/s/cpu)
cycles                ( 8 cpus):  317.167 =C2=B1 0.163M/s  ( 39.646M/s/cpu)
cycles                (10 cpus):  396.141 =C2=B1 0.208M/s  ( 39.614M/s/cpu)
cycles                (12 cpus):  431.938 =C2=B1 0.511M/s  ( 35.995M/s/cpu)
cycles                (14 cpus):  503.055 =C2=B1 0.070M/s  ( 35.932M/s/cpu)
cycles                (16 cpus):  534.261 =C2=B1 0.107M/s  ( 33.391M/s/cpu)
cycles                (24 cpus):  836.838 =C2=B1 0.141M/s  ( 34.868M/s/cpu)
cycles                (32 cpus): 1099.689 =C2=B1 0.314M/s  ( 34.365M/s/cpu)
cycles                (40 cpus): 1336.573 =C2=B1 0.015M/s  ( 33.414M/s/cpu)
cycles                (48 cpus): 1571.734 =C2=B1 11.151M/s  ( 32.744M/s/cpu=
)
cycles                (56 cpus): 1819.242 =C2=B1 4.627M/s  ( 32.486M/s/cpu)
cycles                (64 cpus): 2046.285 =C2=B1 5.169M/s  ( 31.973M/s/cpu)
cycles                (72 cpus): 2287.683 =C2=B1 0.787M/s  ( 31.773M/s/cpu)
cycles                (80 cpus): 2505.414 =C2=B1 0.626M/s  ( 31.318M/s/cpu)

So, from about +42% on a single CPU, to +36% at 80 CPUs. Not that bad.
Scalability-wise, we still see some drop off in performance, but
believe me, with bpf_prog_test_run() it was so much worse :) I also
verified that now we spend cycles almost exclusively inside the BPF
program (so presumably in those benchmarked kfuncs).

