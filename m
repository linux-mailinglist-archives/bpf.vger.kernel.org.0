Return-Path: <bpf+bounces-43116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084409AF5C6
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFEC1C21CD4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 23:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458AF1C82F4;
	Thu, 24 Oct 2024 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM43l7eO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110E22B641
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729811884; cv=none; b=Yp25y/Tf5mozzKhk6/rPcm3H9li50DaXr7lqQnm9XHPnsy+VQ4oTz57+BpcBqUXizSYHr/IWsDFVpUgZNSl/0g9DNv0L8h6JiIevf0brI+o5rfzJkht0EhwPS5lHL358Y5NqV57eKEDtnYL2g3gHw29jYBXFSIUdI8e3RsnT0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729811884; c=relaxed/simple;
	bh=U1ZQHkykbuAfRptgMF+T8PWx2yXcd0FBn0hVoP75RFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kz7L7oQs5LF5Jaqs2QFZM77CN91RP95hrmsmMhUPYtAPlY28kUzhxziTf1mCZHsP9/EzXmdIXioWL8AdiAYwKlRDHEJhbtPQT9NwM/GqQcquLkIxwrolxGi9Z2BuqscrW9eyX9hdFhOl3zsm2wWPC9t2veBFIvEdo+0JFwS5PoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM43l7eO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71ea2643545so1123524b3a.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729811881; x=1730416681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oBvnK6FLPv6oFCsLfwDrov19TicSR3h5/hkygNoeAE=;
        b=fM43l7eO9l/tq1xyWGjE4qQ6OyeKqk/EnM3LYScQyj0020vKAW5XmlK26TtCY9Y5tg
         cVteEcmICa59ZOTT8ChpKjSSrQRuFLD0lpLD6KVrkWuoYWBy3VvioZNV5DnZVRwSDYJj
         SLtp+n3LB/4GJZVmhGUU3uS74s/S3e0NuycHqCOEDLKjQBUALjiUNOXLYy2URf8ZdMkW
         BCIizH4aa7TPb/9GWnlnr7tp7trxtMRJOoxSGLgOgkm4Qu0zR5rAcrSPIfbgbfYC4PMa
         +CqPpdzoP+y9t8l1MJSVd34IZMeOlnwQfuN0QXCuA6XGtgwmOXU675oJsHdMGafQ7FMZ
         JWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729811881; x=1730416681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oBvnK6FLPv6oFCsLfwDrov19TicSR3h5/hkygNoeAE=;
        b=t7g6feF5KVVUmtdOIGEJvUYBMJy+VE2w+9UM+BTPVtus+bELEmrKzKngH2+hBXTjiF
         rdikD+NSiHYjRPy/XV3wnjh1dhdDGgAu7tDKKL2tFl+1kSR9RyuxKcaFMLA/B/OlYSJC
         BwwjyFIGG0z7u+dK4HWlgIlNd2CMLuRMBtFJpomKYp9LQFakz3Qelz4bR/uzwmy28Nn0
         LVlYIjLFxHXi2p3PwQVO7mlc4RL9sbYjQ5lpzSWzUD3R4/fFNDqjayz/KbHZ7sie+8kG
         qZrDyZPdxeYjoE+6Gf9wOcfG27DSJUcgk44i6HxXoq7cEx45EKZyv0dB1Z6Pwy7n3x/a
         hAJg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1ukrUPsdO3oW4c3hz4S1k9SEUKkOzd1R0bGDhg+/U3b6fP+cifIiWNAvshfleRZLhwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3nd8CCYqXpSqXbskdRQ8lCD3/7LCQFA9Am6+x41sxOYaqvPVC
	kPRGnPbqwEUnTCF8PvOnM5vIJl93X8RCS40/3wrmp1w1HWrOZbPDReFI4fE0iromjPNthVVA8Bw
	N4wktIvyxDW1O7ZmIdBNzACDBjYY=
X-Google-Smtp-Source: AGHT+IHiL7ichk/XYmLZBTgf55Ppyyowuq7NLDa+C9hbVNCOgaydydnU9UMdEVlPqeDpM3l/swwj478Aayk+zB3DHmA=
X-Received: by 2002:a05:6a00:c8e:b0:71e:744a:3fbd with SMTP id
 d2e1a72fcca58-72045f52f82mr4534819b3a.20.1729811881360; Thu, 24 Oct 2024
 16:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205113.762622-1-vadfed@meta.com>
In-Reply-To: <20241024205113.762622-1-vadfed@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 16:17:48 -0700
Message-ID: <CAEf4BzZa8QCxFO0YPk3LQE2A_kp2yawN-h24V+RoiH7q8BLVVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, x86@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 1:51=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v1 -> v2:
> * Fix incorrect function return value type to u64
> * Introduce bpf_jit_inlines_kfunc_call() and use it in
>   mark_fastcall_pattern_for_call() to avoid clobbering in case of
>         running programs with no JIT (Eduard)
> * Avoid rewriting instruction and check function pointer directly
>   in JIT (Alexei)
> * Change includes to fix compile issues on non x86 architectures
> ---
>  arch/x86/net/bpf_jit_comp.c   | 30 ++++++++++++++++++++++++++++++
>  arch/x86/net/bpf_jit_comp32.c | 16 ++++++++++++++++
>  include/linux/filter.h        |  1 +
>  kernel/bpf/core.c             | 11 +++++++++++
>  kernel/bpf/helpers.c          |  7 +++++++
>  kernel/bpf/verifier.c         |  4 +++-
>  6 files changed, 68 insertions(+), 1 deletion(-)
>

[...]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 5c3fdb29c1b1..f7bf3debbcc4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> +#include <vdso/datapage.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, =
u32 dst__sz, const void __user
>         return ret + 1;
>  }
>
> +__bpf_kfunc u64 bpf_get_hw_counter(void)

Hm... so the main idea behind this helper is to measure latency (i.e.,
time), right? So, first of all, the name itself doesn't make it clear
that this is **time stamp** counter, so maybe let's mention
"timestamp" somehow?

But then also, if I understand correctly, it will return the number of
cycles, right? And users would need to somehow convert that to
nanoseconds to make it useful. Is it trivial to do that from the BPF
side? If not, can we specify this helper to return nanoseconds instead
of cycles, maybe?

It would be great if selftest demonstratef the intended use case of
measuring some kernel function latency (or BPF helper latency, doesn't
matter much).

[...]

