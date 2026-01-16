Return-Path: <bpf+bounces-79230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB138D2F60D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D90BC30797A9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 10:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE127E074;
	Fri, 16 Jan 2026 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbM8eJ0/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D935FF7D
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558451; cv=pass; b=mHhOm/3h1kQ8+dqf0Y/pJcQr8GNZAdm1N7bQeVSbVT7ENGtQDJmhr4P0lxG/G1JvORz4jR278IAwRTMXWYrjyz/pQYDc3aqT8cgOdoG1SAIzu4wC1fb7sKQ6EFkRdfVkwyq7oLb6yFJyRc+87WcE1r7gwAoAHtVdRY4J/1kAn40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558451; c=relaxed/simple;
	bh=bk5/3lbjEMmyky8pBWHhH8r8X4gEVrOrHe0JTU5LCGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ju7459msA/Xl8P9Nf1ef9/b1iOhhE2v6C6/vzxkQmr4M4oySePoJ+RU3+peA3Awc1RYWJ9Z99X3RBWUCCK+GDtSn5Z5L7DTw9FZ1u87lRUdt0i1qZ1KsohBveAg1pRFCgeg7YivhTfrx92pM7ycEqVzEkE24VjI3YP6pPmagJoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbM8eJ0/; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-121a0bcd376so4793028c88.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 02:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768558449; cv=none;
        d=google.com; s=arc-20240605;
        b=guIhvuZSwdRENWamfLs/YoNWjV5LgF36HYSOs1bLRLrDDmS3zWZBXC6P8coKsqhSNk
         pvDYKetk0LC796oyCY24wM74Mu3JLFbI7BizEniSU1zZms61EMdGRBmSEAWF/dLstl5i
         M7DGH/W3t0SpjSD3j+QIlqfCI8yKf6PfaS44Dh0qMnKq2S6Ia/bG7boYoKViu6gK5WAC
         PzkIZ7PrZrTMPkdT5kZlY/nz3Nz68jEeltoslDihh7pgHiNN1pr1rAOk84+ZFRxjLvMk
         ykDNyYitSIgRcE3CknX5bL+XXdKLeATHPEGCZGWxu3Fpp946hs2yaIzRWNjeo/S7LsOO
         8Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R6JRLFxsvawK2lrd6X6b6x3zam0z5lOzXeW0w0nzBUs=;
        fh=cEE4CF8nf3mAf4cX61CFhrpAWWO4HTKDnfDc3YeFbCA=;
        b=XDFz+xWAbnlaN4YZwRM58Qh+mZ9RZarEW/lwykxJSkNis88BFVxd5OfVZ9xVSWSLUP
         25peiLWF7JRi/hQ8XmIUWwlj4AcksxdSt71BGHBZPqY11L2XiDuZRx94/wc29aU3SrEL
         loz0Ih8zb+cxsDKwaFw3BBy/HIogVh11361wUH5JsDjKjw9e4zRbSWesWw3Le7upYMAj
         9wuPRUal+Spqng252KUIb4MLSYytDv7UQWp6mvktMz2lWnfQWYH3ZtxIuMwke8SyWfB5
         MuzlK8uzShjHlndRoOJeViwS8zCvk9WXVQDKrTmq+wqpy9kIbo44GaqU9EWZl2Jyu0QW
         cerw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768558449; x=1769163249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R6JRLFxsvawK2lrd6X6b6x3zam0z5lOzXeW0w0nzBUs=;
        b=JbM8eJ0/roUCtCQe2GIWfTJGfJ5Xh8RU51dY0CTp3r49fuyX4+Mz3FAr19Rr6HN1sL
         6z9J8GfujODezY9qjd9wwxTtvHXWWnx7+X2NujN6haz7YhtLVsOGvxsHyffJADb/1ntq
         7n1i7kefpz1iZxADCnu35XVnnicIZWCJQbPAhgt4toAfFL6QT0bC/uBIxev0vQuE9ozk
         +s0LeXRej8hS/E1S6KiKHF02VM2Mnz5rY7SmGX5VXWQAYgXOy3EPN4w7e6LUCYPuZ6/z
         ysznDZLqDVzNNwFKE8qhutAzfqSa2g6CyDzJktWcHycEAeBUH0p1OxwoIsdM9SDRGfmA
         9JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768558449; x=1769163249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6JRLFxsvawK2lrd6X6b6x3zam0z5lOzXeW0w0nzBUs=;
        b=S4bmu9ETmYpSWdaG0arrg22dmOriB783MgzpX4KewbKGftYRjWpYXZRzgZ8Ka/9hG/
         zk//LHThDU18mW2Slsjk1V7Gvrg9vSVZXi4pMBfTYO0iSsv2aj62TNMkGZbODZKS/MRr
         GNWRJqhxHk9YCEvVwQYFt8KjtGZmv+gO8r0MFK9TSUQTRlV71lPWeeFxAF+pNpE12uuJ
         0HD2/VKJ61GxkCt2ZFJTOo2aVRuU9A2Wu4C2O5teHV+LBxjhEXZMosjGeqogZ8NCgdbd
         NSBfXMvEzAOB9PQwvZTmXorfT7kgdvfuHjxiSqUqtLqUItRGsxnA9g2Tat1ADHyC652f
         LNUA==
X-Forwarded-Encrypted: i=1; AJvYcCVAJHH5nQ5b9Knlr6QMJoE0gEfxAsjqUXMUwK1xdK+ClMC/RrGD1ZunkZHRAp5FHHoDJis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxIGNfkgk8C0cTfeHVoclFRvvKhhRkTYtLI+ulIpuU0VkksbW
	yQLPeYKhzvJxXjuESxKziomzoq3YH6qgnoKyp0zhA7QiGky9IgmEYLJI3cEyCxr+lMHBwqeEjLB
	BFhIXRLoPQI1eW7pxoLPA0+27DTx/RZx7FEIUuitD
X-Gm-Gg: AY/fxX6Sodnyftnr4uFEqbjzJIbb91d4hB2xcCSBlgo+lLdeXEv1hinQB+zdV66d8Ye
	JACA+vSdT5bCocrPxcv70w5w8JeJGBTDbcbrpo+eqA8jVaB/kMdSvvxz5ISaEZ2dPEA9wbjNkEn
	zbbqMEvDgE9ZFvYEHtSiOOOYLNUpL1pSJv4Eb2JRzjEP3/p5rtkuXaF/tWS+cX6n244JuhGhkTM
	a43yWpaPGgMBt43Zwso3b0Xj2fJjFCElpNAs54dP/T1zpdfFUFw3D2PlSS4tvsTt/duR/4+jyLx
	//2FgzXGzeSTbL02Y39EJYVhTTM=
X-Received: by 2002:a05:7022:2490:b0:11b:9386:7ed0 with SMTP id
 a92af1059eb24-1244a75ccb0mr1972499c88.45.1768558448271; Fri, 16 Jan 2026
 02:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091730.324322-1-alan.maguire@oracle.com>
In-Reply-To: <20260116091730.324322-1-alan.maguire@oracle.com>
From: Marco Elver <elver@google.com>
Date: Fri, 16 Jan 2026 11:13:32 +0100
X-Gm-Features: AZwV_QgPQtH397zV3jG8ReUSm2lFJl74Uk7P3X1iMiHb7yMVzpdh6cWgNE1o75c
Message-ID: <CANpmjNM=w46BDuLsvAW6oM7JbPvrhN1ddaEUNSvsfZVU-514cQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in BPF
 Type Format
To: Alan Maguire <alan.maguire@oracle.com>
Cc: kees@kernel.org, nathan@kernel.org, peterz@infradead.org, ojeda@kernel.org, 
	akpm@linux-foundation.org, ubizjak@gmail.com, Jason@zx2c4.com, 
	Marc.Herbert@linux.intel.com, hca@linux.ibm.com, hpa@zytor.com, 
	namjain@linux.microsoft.com, paulmck@kernel.org, linux-kernel@vger.kernel.org, 
	andrii.nakryiko@gmail.com, yonghong.song@linux.dev, ast@kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org, 
	nilay@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 at 10:17, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Enabling KCSAN is causing a large number of duplicate types
> in BTF for core kernel structs like task_struct [1].
> This is due to the definition in include/linux/compiler_types.h
>
> `#ifdef __SANITIZE_THREAD__
> ...
> `#define __data_racy volatile
> ..
> `#else
> ...
> `#define __data_racy
> ...
> `#endif
>
> Because some objects in the kernel are compiled without
> KCSAN flags (KCSAN_SANITIZE) we sometimes get the empty
> __data_racy annotation for objects; as a result we get multiple
> conflicting representations of the associated structs in DWARF,
> and these lead to multiple instances of core kernel types in
> BTF since they cannot be deduplicated due to the additional
> modifier in some instances.
>
> Moving the __data_racy definition under CONFIG_KCSAN
> avoids this problem, since the volatile modifier will
> be present for both KCSAN and KCSAN_SANITIZE objects
> in a CONFIG_KCSAN=y kernel.

"KCSAN and KCSAN_SANITIZE objects" doesn't make sense.
"KCSAN_SANITIZE.. := n" objects?
Or just "instrumented and uninstrumented source files".
Anyway, I know what you mean, but others might not. :-)

> Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/compiler_types.h | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index d3318a3c2577..86111a189a87 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -303,6 +303,22 @@ struct ftrace_likely_data {
>  # define __no_kasan_or_inline __always_inline
>  #endif
>
> +#ifdef CONFIG_KCSAN
> +/*
> + * Type qualifier to mark variables where all data-racy accesses should be
> + * ignored by KCSAN. Note, the implementation simply marks these variables as
> + * volatile, since KCSAN will treat such accesses as "marked".
> + *
> + * Defined here because defining __data_racy as volatile for KCSAN objects only
> + * causes problems in BPF Type Format (BTF) generation since struct members
> + * of core kernel data structs will be volatile in some objects and not in
> + * others.  Instead define it globally for KCSAN kernels.
> + */
> +# define __data_racy volatile
> +#else
> +# define __data_racy
> +#endif
> +
>  #ifdef __SANITIZE_THREAD__
>  /*
>   * Clang still emits instrumentation for __tsan_func_{entry,exit}() and builtin
> @@ -314,16 +330,9 @@ struct ftrace_likely_data {
>   * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
>   */
>  # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
> -/*
> - * Type qualifier to mark variables where all data-racy accesses should be
> - * ignored by KCSAN. Note, the implementation simply marks these variables as
> - * volatile, since KCSAN will treat such accesses as "marked".
> - */
> -# define __data_racy volatile
>  # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
>  #else
>  # define __no_kcsan
> -# define __data_racy
>  #endif
>
>  #ifdef __SANITIZE_MEMORY__
> --
> 2.39.3
>

