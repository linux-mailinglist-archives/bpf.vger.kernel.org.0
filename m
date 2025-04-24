Return-Path: <bpf+bounces-56631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8277EA9B5AB
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 19:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693FC166D33
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4428A1DF;
	Thu, 24 Apr 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ/KlJ2N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD02820D5
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516926; cv=none; b=V2Ok8s/H9isTB1VITxVssmZLVmyd2xXYQnz30gL+v5RpSp6cbg78+83WUoJ9ECeRw5YgjrZdbS9Nd/PCtlKy/m69vzBqU4m5AdgR6DIIzxU6hPwiUhMKQg6aZmbX0RkDv/BmZbXSIJustKeeF4Lxct3m3TehvT4iFxLFz6d0w4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516926; c=relaxed/simple;
	bh=el19/R2k2fgPV1QXG1keuIDGamPMH88yoAQFwmq/wYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MESufjG79ZjBZFwo8zRVaFFF2LsUpjOctofyYtzlfbFj41RpYYC76yNODhGRB7172s44PQO7kYvSlKPPHEv2+wRku6BRM5979n5s0Qm0N0w2NyW/ngIsxY2+WdqjzN/ipuobjgwltbEYrwRU1acMkt8k3hgM8a/Gl+idUvo63bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ/KlJ2N; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso240824066b.3
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745516923; x=1746121723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhEYcWUMdaq0t2KNBcUXchjG9aVEAO3eWa9yGjQslmM=;
        b=SZ/KlJ2Nh6IBBlfd5/JrNwkZ2iWub2kjZYJInfqIG5fHGZRSnFJtu1zIv+Jr55sOJg
         eDQKClcwc47NLo14v/GhgViPDrQzO3Lg9UpLq7AB1rIR1iprW4bOe100TML+bfjUyc6x
         LJ7CtE2vsGb4F4ZnZe4CZbgU5vK5tm6ypdYkqcqSYwoGRau7Hbuy50n0PWdbMKOZDvRD
         of2g/DeLps2zh4ZDqE4cByt4zTmQ6nq0ZI2PdZ5S9j2h2Xx5jswbsb0/MXIhgr/N1mZc
         cZ0Ybo8aBrOt2aqtxyeMXNWMi5v2+vfUnWcYWsLhfT9wEGoe5Ffe2ArIZdYhncn256FX
         9sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516923; x=1746121723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhEYcWUMdaq0t2KNBcUXchjG9aVEAO3eWa9yGjQslmM=;
        b=AxIHTr2mAR0LTUlZ4PQVL86y49yYShPjCkYgsYkKwN5HqqD6S5G5wS/ddoceYGlRYx
         ysMydIq7maRxZgybBjk+OrtNyGRH6l6DERPcSsVPuNk0Ph2y1ObTNgHNYIueWaNqdZjJ
         MPpZsus7AiNtOS9C6S5b0HJ103F7T0KtGvRoOYicywz0TXnyggwhE3ETo2rydGrq8ZHB
         T0hhWZYx5Csjz/UF1df6/n8sFofj1h60mbeaG5hidvaQHwNGcTEUpdbzCFeFIUi/UBzL
         pdVF//dTMtKTGonKnFiHZVE6Ky9VYmXIewSmzRC5+0UMnjJoaJIy09K1vPsds2nC1tth
         Z9Yg==
X-Gm-Message-State: AOJu0YzndloToCsRTTv9sYXV+FiRgVmw0Aj9Ga8k7HNeBSjHpLCL5+MF
	ficMCn9VR6S18yjsAeyrmS4ALM6rAfmN2WIuI/V7heZKUlTdEREncuDwcQ3KgyoWT3MhsWQ96iV
	GSSyGAEaDmoqz+hL8Mej12qw4V/mr44n0
X-Gm-Gg: ASbGncuaAZh7MnkPwJc/up+59qoNWcqW8/nnGMH2ODvPXhCrFXUSmxsyaOuD2GdpIEo
	KcNlMXX1lUbw/V+DoJGrEbOSRXMqAgkMd87RvMTIT7aWpZ6JVSfuCzT1E+/r5/+0nFInNHBfVBB
	92mZbHba/13Q3rwKOJFkMDIHZq+MAElt1geCdEe5PieAbvmIMp
X-Google-Smtp-Source: AGHT+IEGbjyVBY0HJdlJQjFW1IqB28KuCK/U5EDNiIcKsR5hHvtGkXnc9T92BGruPz9evRgYWovBbM2TBXOTJGpVWcM=
X-Received: by 2002:a17:906:9f86:b0:ac1:dd6f:f26c with SMTP id
 a640c23a62f3a-ace5737b423mr397746566b.46.1745516922935; Thu, 24 Apr 2025
 10:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422003134.68527-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250422003134.68527-1-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Apr 2025 10:48:17 -0700
X-Gm-Features: ATxdqUFBBHTZEsQS5SEfMxLB6Qcxhdh7ORZ5Un5Y6RL9cgowaBSY8Nuc1CuRi3k
Message-ID: <CAEf4Bzb7Qa_=08sg=P1atM0X0wCrEG-5qPqRHYQA5mt79xUUJw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Add namespace to BPF internal symbols
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 5:31=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add namespace to BPF internal symbols used by light skeleton
> to prevent abuse and document with the code their allowed usage.
>
> Fixes: b1d18a7574d0 ("bpf: Extend sys_bpf commands for bpf_syscall progra=
ms.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/preload/bpf_preload_kern.c |  1 +
>  kernel/bpf/syscall.c                  | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/b=
pf_preload_kern.c
> index 2fdf3c978db1..6657b272bb51 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -89,5 +89,6 @@ static void __exit fini(void)
>  }
>  late_initcall(load);
>  module_exit(fini);
> +MODULE_IMPORT_NS("BPF_SKEL_INTERNAL");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Embedded BPF programs for introspection in bpffs");
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9794446bc8c6..bf19b9d68699 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1583,7 +1583,11 @@ struct bpf_map *bpf_map_get(u32 ufd)
>
>         return map;
>  }
> -EXPORT_SYMBOL(bpf_map_get);
> +/*
> + * Only light skeleton is allowed to call functions from
> + * BPF_SKEL_INTERNAL namespace. It's an internal API.
> + */

The change makes sense, but can you please move this comment (perhaps
a bit more expanded) into documentation?
Documentation/bpf/bpf_devel_QA.rst sounds like a good enough fit.

pw-bot: cr

> +EXPORT_SYMBOL_NS(bpf_map_get, "BPF_SKEL_INTERNAL");
>
>  struct bpf_map *bpf_map_get_with_uref(u32 ufd)
>  {
> @@ -3364,7 +3368,7 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
>         bpf_link_inc(link);
>         return link;
>  }
> -EXPORT_SYMBOL(bpf_link_get_from_fd);
> +EXPORT_SYMBOL_NS(bpf_link_get_from_fd, "BPF_SKEL_INTERNAL");
>
>  static void bpf_tracing_link_release(struct bpf_link *link)
>  {
> @@ -6020,7 +6024,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, uns=
igned int size)
>                 return ____bpf_sys_bpf(cmd, attr, size);
>         }
>  }
> -EXPORT_SYMBOL(kern_sys_bpf);
> +EXPORT_SYMBOL_NS(kern_sys_bpf, "BPF_SKEL_INTERNAL");
>
>  static const struct bpf_func_proto bpf_sys_bpf_proto =3D {
>         .func           =3D bpf_sys_bpf,
> --
> 2.47.1
>

