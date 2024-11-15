Return-Path: <bpf+bounces-44996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D362F9CF9B0
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 23:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942452822CA
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A9618FC67;
	Fri, 15 Nov 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeITht12"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59B41C69
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709314; cv=none; b=dzXXqv6KttJ/j8KHi6nZo9uviX0vw3yufocZ0rpW73BK8Av9ir/2SIbiz8dgpQV53HF8Z/7mu0Ko/NKsmsw16G/on7vm8l/iXKeXtZF+nnboUTOafym98CSlg8Kdny4uV+aqpxHcyFrlobRQ7EgStW2F6X0eVxp3XI8dqOtpcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709314; c=relaxed/simple;
	bh=uLfXuZd/TgjVjPKxqTH/Q8hZxxbnrgOdSvLYsd6if60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEpxmsDmg1f8MCA4LofyHyxE1mjc+sUXZclioTbNeVdUZtZ2MSb0LEtIL5VpmehW/cSpkM8020kVRL4q+6EMpkDVwrVd5hQj92wvtQ61jB9FXKbTsZCBhQz8mWqb7Yca/5DhCPIFpncEJYIhuhgEbMSh7TiXamh6sBeKTWJhkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeITht12; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so90665a91.1
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 14:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731709312; x=1732314112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8o9k8Ys59yESAMO16ufRHPWhpQzIJYBgsrFOL1dbHc=;
        b=CeITht12dLMEEk/N6wH0YEG9qj2YBRbsOhiin9iGwBsy4MPilDRpLbPlt3zXSY+fMK
         zyZ1Ql0LoglNbVo4OxtJl8ROybgvimsYmMHTbscu5ZjeSWLS8PO3ovQuQ6eNFzjq0PA2
         UoF6smB+YR65kXuxYK9FZnHFAEBy+6CjrMvJw5J/g/YCQbRkU5ndOZ9hJ1SvXUARhP3k
         yfTA3PvFhyx1jbUkoxb2s8Sy2o1k1jNQ1DWTRgWb4Wuso0P5C+obyJyOeIM5DLBjh0EA
         fs68jgK8j06H5wnZPYVETMg31SRFxg9AJsXQR3CHlw/AjF4JJhwaHyFbPVPAMxICys5r
         OxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731709312; x=1732314112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8o9k8Ys59yESAMO16ufRHPWhpQzIJYBgsrFOL1dbHc=;
        b=bTJXiASbipg5/kkaTCjGPnkNwVKz0ubTOWTk5TPHUcu1y8HZVMBOhFcyU8nrKxbcDT
         0AJozVdW5xui0+9OEwEjNOCK8vI+soDHSNyTh3DdgrpcE7c9eS3IiIo57rhby4klP9g5
         jWFTBr2ggY14YF6tasWyaaUI69iCgqsDTrT7OdjNYsYCMUBGvd7B4MgTUeu1cOUrD0Lb
         ecInqgKcqSIdJJ4Qp3PBriRoWHHZtrr+XoRMO3ag6s9VcnV+xfI5v+rP7SRBoscmpk8n
         meSLojUJI9PrRbqJZYQkBzUDTqYBqerHj83qMHyYiNoeJAUQtBk/MvonQGPIffVV/6Dj
         uWmw==
X-Forwarded-Encrypted: i=1; AJvYcCUd7VfyRAkKSriZPAoDAmeLRkqA8Ig+1m2vtOdVXodhN7e88M0YNH1w9NZDGMYmfSprTPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyLFIHDjGdNLJt11wBIg4F7uB2wnuhERWkOCDVU9a75dhMwNU
	VIyGWoHCgArTg2Ta/+BCrXOI7s4qAqHKslxRyCviUVvmD9OcaQ09LAJK2gPUVr/OX5xupd7cwG5
	fFa3HEjOYkEjjgJ2gnGYnJlclWDXZvdOY
X-Google-Smtp-Source: AGHT+IElJgWB1XUz5IRM3ItzNDoS5PMDGu+hbbN1c7qY+t1DwiRfglkfHjlRUuO3d12P3VerU46poFizm+kgyWKUeZQ=
X-Received: by 2002:a17:90b:48d1:b0:2d8:3fe8:a195 with SMTP id
 98e67ed59e1d1-2ea154be8f0mr4960059a91.4.1731709312065; Fri, 15 Nov 2024
 14:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115194841.2108634-1-vadfed@meta.com>
In-Reply-To: <20241115194841.2108634-1-vadfed@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Nov 2024 14:21:40 -0800
Message-ID: <CAEf4BzaMyG7NpD1ravdAZChenZe78c8Rxz2bZkekqQnsuY=zOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: add cpu cycles kfuncss
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:49=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> =
wrote:
>
> This patchset adds 2 kfuncs to provide a way to precisely measure the
> time spent running some code. The first patch provides a way to get cpu
> cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
> architecture it is effectively rdtsc_ordered() function while on other
> architectures it falls back to __arch_get_hw_counter(). The second patch
> adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
> constants discovered by kernel. JIT version is done for x86 for now, on
> other architectures it falls back to slightly simplified version of
> vdso_calc_ns.
>
> Selftests are also added to check whether the JIT implementation is
> correct and to show the simplest usage example.
>
> Change log:
> v5 -> v6:
> * added cover letter
> * add comment about dropping S64_MAX manipulation in jitted
>   implementation of rdtsc_oredered (Alexey)
> * add comment about using 'lfence;rdtsc' variant (Alexey)
> * change the check in fixup_kfunc_call() (Eduard)
> * make __arch_get_hw_counter() call more aligned with vDSO
>   implementation (Yonghong)
> v4 -> v5:
> * use #if instead of #ifdef with IS_ENABLED
> v3 -> v4:
> * change name of the helper to bpf_get_cpu_cycles (Andrii)
> * Hide the helper behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing
>   it on architectures which do not have vDSO functions and data
> * reduce the scope of check of inlined functions in verifier to only 2,
>   which are actually inlined.
> * change helper name to bpf_cpu_cycles_to_ns.
> * hide it behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing on
>   unsupported architectures.
> v2 -> v3:
> * change name of the helper to bpf_get_cpu_cycles_counter to
> * explicitly mention what counter it provides (Andrii)
> * move kfunc definition to bpf.h to use it in JIT.
> * introduce another kfunc to convert cycles into nanoseconds as
> * more meaningful time units for generic tracing use case (Andrii)
> v1 -> v2:
> * Fix incorrect function return value type to u64
> * Introduce bpf_jit_inlines_kfunc_call() and use it in
>         mark_fastcall_pattern_for_call() to avoid clobbering in case
>         of running programs with no JIT (Eduard)
> * Avoid rewriting instruction and check function pointer directly
>         in JIT (Alexei)
> * Change includes to fix compile issues on non x86 architectures
>
> Vadim Fedorenko (4):
>   bpf: add bpf_get_cpu_cycles kfunc
>   bpf: add bpf_cpu_cycles_to_ns helper
>   selftests/bpf: add selftest to check rdtsc jit
>   selftests/bpf: add usage example for cpu cycles kfuncs
>
>  arch/x86/net/bpf_jit_comp.c                   |  60 ++++++++++
>  arch/x86/net/bpf_jit_comp32.c                 |  33 ++++++
>  include/linux/bpf.h                           |   6 +
>  include/linux/filter.h                        |   1 +
>  kernel/bpf/core.c                             |  11 ++
>  kernel/bpf/helpers.c                          |  32 ++++++
>  kernel/bpf/verifier.c                         |  41 ++++++-
>  .../bpf/prog_tests/test_cpu_cycles.c          |  35 ++++++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/test_cpu_cycles.c     |  25 +++++
>  .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
>  11 files changed, 344 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycle=
s.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles=
.c
>
> --
> 2.43.5
>

typo in subject: kfuncss -> kfuncs

LGTM overall, thanks a lot for adding this!

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

