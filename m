Return-Path: <bpf+bounces-38903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A096C499
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57284B231B9
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAEF1DFE37;
	Wed,  4 Sep 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoArsho/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C71E133C
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469151; cv=none; b=mjUr2Ml8cqdNE4UbRK+PZu6V7z9/MxWH649NhnV7z2hWPsIm+am3/4MRGVIqlN/CsqQDtexvRBUQNk2V7HH171JFUXV487YRtm1lyBA28JGKNPsXfzOfRTUGXLsXmaBiayhtaT8O0Q/yrPdgLtzuRS/nJCGgxtRlQ8NgXjlgH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469151; c=relaxed/simple;
	bh=KMYb6B/OV7tCtwPaKibFdvTZ5Nyer8QJs504SeYo0OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrtlI217F96mSO5F0k+p7YGbo0xNkgNwwE/XUkz3fCjW3zgS19Q0kmwAcdNoOsOP2A1r3sl+QszCN29Uk04xXlFRJGSjopYQ9V7JlEBNogR0HdrG2409r8JYRMzzn6qs5KLwXRJnN5ZZII6E+jcnv1/9vAM+rBJYQCJdvlcf1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoArsho/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8684c31c60so800556166b.3
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725469148; x=1726073948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMYb6B/OV7tCtwPaKibFdvTZ5Nyer8QJs504SeYo0OY=;
        b=EoArsho/5fBGR8yvY9HjFqgRXoSfRh0ZVDfiTwmsneBYX3Y4WqziCQBt/V9Gu3wZHM
         xlCAJ0qB4bgLT74dfJ/7JU3G3tDh6x7CeKaYZpp8jWzxd2E8Ge+Hyvm4IIyww0W/u85e
         Um8YxQI10d4Y6ibVe8RwRkqPe5S76sF8ImZpDFqGOnQV+5QyJqrQuB3BrGOvfYPGGnEA
         lEf07TebJySHNkygd5vCEK/ZuRnxLpBo7shyZ69Yl+Q+yqm24rdwXjNb/dI8XD+1k4qL
         +2tUGPKdbf1j9DN/y1TsWKTWNrFnsuZV44V/thw6RB6Ar6HDLObW+nDRMhyALLnVhBxP
         SIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469148; x=1726073948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMYb6B/OV7tCtwPaKibFdvTZ5Nyer8QJs504SeYo0OY=;
        b=WKhFph+aVJYdJzbBWeqThtPfXnbbuMOgnH60r8jSoMsyvjL5Quywlx3dsU+a4jhYaP
         yGQuSPii/p7S95ToP2QhukpdhY5iYBSAI5uqvLkhAOl7DBmc6WM1sOZHuWsg6yFg5y+m
         /qotrWcoALXnHNFvzaGg3CxxXrdmgpj5nCCk11QyeXnhH8RdhG2mKRXGnaSslu5nw8q4
         6PlEoR8BiZ1liAQlJCdaHyRauxMDK1hLlvPoa5pDrMmuvi9oUcgoR56WcQTTAOxu/HvU
         IMfsBIGJZr5CVWm90DaDd81FBsbjFHihhEU6/whX1Baeu3LFB3tUURPbUXpd+AYkXCFn
         Qi/Q==
X-Gm-Message-State: AOJu0YxfBjFUEoYjD2klqDtBmF98FShd7bdbFKJ1to4z0w2W1gr7MoZX
	Gc/TmRS3qDTH4J2MQYbx/TOrxZzGE9SMoE5TSH5iysfobzKbZCJZjcLiTlbrN8wWcg4u5WjcoxP
	eyRJsNbdiN7bDvIYGXzRxokX/EU8=
X-Google-Smtp-Source: AGHT+IEyIchKRQAXi6F/9rLoUz92AZaZcHUl1AsrIsZHXS6g9EYBDoLWWCQAyqTj799A1KATN+DhRIPtMB2qfwYfZAY=
X-Received: by 2002:a17:907:2d07:b0:a7d:a29e:5c41 with SMTP id
 a640c23a62f3a-a897f8e7272mr1577474066b.40.1725469147932; Wed, 04 Sep 2024
 09:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903225949.2066234-1-yonghong.song@linux.dev> <20240903225954.2066646-1-yonghong.song@linux.dev>
In-Reply-To: <20240903225954.2066646-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Sep 2024 09:58:56 -0700
Message-ID: <CAADnVQKEbSrRjautnd7eb+zvNfRintUZTVfACKhVmsrfvN6pfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add a selftest for x86 jit
 convergence issues
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:00=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#if defined(__TARGET_ARCH_x86)

Does our test framework need this ifdef and dummy_test below?
There is __arch_x86_64 below.
Isn't it enough?

> +SEC("socket")
> +__description("bpf_jit_convergence je <-> jmp")
> +__success __retval(0)
> +__arch_x86_64

