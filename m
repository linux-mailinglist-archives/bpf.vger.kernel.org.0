Return-Path: <bpf+bounces-27530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E068AE3AF
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26471F24B70
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A37E10B;
	Tue, 23 Apr 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiZleyh7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9016E617
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871042; cv=none; b=hCfpei95h0XDQLjwEC2EoftDXOnqJxPneugkqDSun9N0rXWOExX5maBu4k1zsnICzwp3792U5CxnE85tOqyhj6LU5OIL7n/8Z9rje0Jqh/XNt4+4J/dv/lt01x0d9zcu0he1VetvluavwAxr/+sUQN9Yh7D1FRu3Rx8zkZ0LIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871042; c=relaxed/simple;
	bh=cbTJ/Yfz74eZYiG8w9ZOADryl1Zjd336QhWT3IrmNR8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYvnqRgC4UnEX5X4AsFELsghc+Y4wqByOBFi915kaB1qtnDwY7w7iDTKNIHd5Ngzs5IigBpetnzHxvgSiVy+1yWFo76IHlR0yPY7ObGI/1r+8mBfZYQR7U3ofiGT4cJNQP+zw48strizgqun+3XRRuDQ4DT0Uw42RUNRjo9cHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiZleyh7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so58370751fa.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713871039; x=1714475839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBZ3bEc7/BGJ+Zhw6Nf+sbXTKHbfD4qSzep/yTrkS5w=;
        b=ZiZleyh7LH2/67i8KpjOFPAUy1aHapHlYvTXfdPwyHbMnHZn1hD/atg5s/eG01/Ywy
         ArPfSXvVzRuioXKzkuBR7UaeU5fFxRZ9KPYDhOkk0ACpC4MpveWToUpCiutiU1AWyngN
         mIyf5rVN/aXQrZRV2XS9kJQypvUASTypJxXpB867MaMioo/3/4fM0h1bCV8r4bE9GljQ
         tlzgwbcLWBPOiBZ74W1oGWvvv42GCoYrBHL740CAMYK8/1q2LCNf1Z5/GAQ90NAE2KkK
         /Q3yfTaVQ42OPM9axgBgrqHwcDTGJ/INyZn4F0MI3G55k4QEbkyshFUsk5rKPZqNH4xo
         H+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871039; x=1714475839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBZ3bEc7/BGJ+Zhw6Nf+sbXTKHbfD4qSzep/yTrkS5w=;
        b=Sn396puoN+TlVuuJrlExTVvgkNUTYqEq2Z0FkQwiLv9hhHCqAvEhITssEzC4ppUVyG
         wKE+gaKPpSRJwumjbbC8RjjU1G9ph+vaIow1sHNjG1YFs2+rjANNIbkEN2o41HpweUMF
         jH4Q9M/RurvYPOOfwzEUvDTbaW4nJ7Brvu8yEVgyx/ca/ksPKaFGWRQPzpRHq9SaFYIY
         HoEA7fiCs3VG+SpoxhlMyQ6v9OnIoJ8qNK0aSh497s4ZzEOCQPxHeNhdGEGQ+Mn/O3tH
         A4stmFEyzhPzHsn+uRqHuA1aDNQEhf3eg4g+JrnzLlYLXr7U+vLz5DyAd636LLSv/ku6
         4gsQ==
X-Gm-Message-State: AOJu0YxXWwC4foPldIE0cCrBPK8s3TEtvADSMpFlrioSKePhjAc7fxIv
	aYa7ybHY9PhJt4Y237Tsnqh5QuCdNi144wQdhHkvwncSL9lpZ9sh
X-Google-Smtp-Source: AGHT+IGlbVg0277kN4gvNOgMjiuD2Vk9kLygmMvWDZZVa6fPcZTEJjRRGPePBTsRmIqdu8DUxOguqg==
X-Received: by 2002:a2e:8691:0:b0:2d8:5ca3:c360 with SMTP id l17-20020a2e8691000000b002d85ca3c360mr9955658lji.33.1713871038754;
        Tue, 23 Apr 2024 04:17:18 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b004190d7126c0sm15230032wmg.38.2024.04.23.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:17:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Apr 2024 13:17:16 +0200
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for preempt
 kfuncs
Message-ID: <ZieYvK0GXs4OkTy4@krava>
References: <20240423061922.2295517-1-memxor@gmail.com>
 <20240423061922.2295517-3-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423061922.2295517-3-memxor@gmail.com>

On Tue, Apr 23, 2024 at 06:19:22AM +0000, Kumar Kartikeya Dwivedi wrote:
> Add tests for nested cases, nested count preservation upon different
> subprog calls that disable/enable preemption, and test sleepable helper
> call in non-preemptible regions.
> 
> 181/1   preempt_lock/preempt_lock_missing_1:OK
> 181/2   preempt_lock/preempt_lock_missing_2:OK
> 181/3   preempt_lock/preempt_lock_missing_3:OK
> 181/4   preempt_lock/preempt_lock_missing_3_minus_2:OK
> 181/5   preempt_lock/preempt_lock_missing_1_subprog:OK
> 181/6   preempt_lock/preempt_lock_missing_2_subprog:OK
> 181/7   preempt_lock/preempt_lock_missing_2_minus_1_subprog:OK
> 181/8   preempt_lock/preempt_balance:OK
> 181/9   preempt_lock/preempt_balance_subprog_test:OK
> 181/10  preempt_lock/preempt_sleepable_helper:OK

should we also check that the global function call is not allowed?

jirka

> 181     preempt_lock:OK
> Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/preempt_lock.c   |   9 ++
>  .../selftests/bpf/progs/preempt_lock.c        | 119 ++++++++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
>  create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/preempt_lock.c b/tools/testing/selftests/bpf/prog_tests/preempt_lock.c
> new file mode 100644
> index 000000000000..02917c672441
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/preempt_lock.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include <preempt_lock.skel.h>
> +
> +void test_preempt_lock(void)
> +{
> +	RUN_TESTS(preempt_lock);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
> new file mode 100644
> index 000000000000..53320ea80fa4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +void bpf_preempt_disable(void) __ksym;
> +void bpf_preempt_enable(void) __ksym;
> +
> +SEC("?tc")
> +__failure __msg("1 bpf_preempt_enable is missing")
> +int preempt_lock_missing_1(struct __sk_buff *ctx)
> +{
> +	bpf_preempt_disable();
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("2 bpf_preempt_enable(s) are missing")
> +int preempt_lock_missing_2(struct __sk_buff *ctx)
> +{
> +	bpf_preempt_disable();
> +	bpf_preempt_disable();
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("3 bpf_preempt_enable(s) are missing")
> +int preempt_lock_missing_3(struct __sk_buff *ctx)
> +{
> +	bpf_preempt_disable();
> +	bpf_preempt_disable();
> +	bpf_preempt_disable();
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("1 bpf_preempt_enable is missing")
> +int preempt_lock_missing_3_minus_2(struct __sk_buff *ctx)
> +{
> +	bpf_preempt_disable();
> +	bpf_preempt_disable();
> +	bpf_preempt_disable();
> +	bpf_preempt_enable();
> +	bpf_preempt_enable();
> +	return 0;
> +}
> +
> +static __noinline void preempt_disable(void)
> +{
> +	bpf_preempt_disable();
> +}
> +
> +static __noinline void preempt_enable(void)
> +{
> +	bpf_preempt_enable();
> +}
> +
> +SEC("?tc")
> +__failure __msg("1 bpf_preempt_enable is missing")
> +int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
> +{
> +	preempt_disable();
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("2 bpf_preempt_enable(s) are missing")
> +int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
> +{
> +	preempt_disable();
> +	preempt_disable();
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("1 bpf_preempt_enable is missing")
> +int preempt_lock_missing_2_minus_1_subprog(struct __sk_buff *ctx)
> +{
> +	preempt_disable();
> +	preempt_disable();
> +	preempt_enable();
> +	return 0;
> +}
> +
> +static __noinline void preempt_balance_subprog(void)
> +{
> +	preempt_disable();
> +	preempt_enable();
> +}
> +
> +SEC("?tc")
> +__success int preempt_balance(struct __sk_buff *ctx)
> +{
> +	bpf_preempt_disable();
> +	bpf_preempt_enable();
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__success int preempt_balance_subprog_test(struct __sk_buff *ctx)
> +{
> +	preempt_balance_subprog();
> +	return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +__failure __msg("sleepable helper bpf_copy_from_user#")
> +int preempt_sleepable_helper(void *ctx)
> +{
> +	u32 data;
> +
> +	bpf_preempt_disable();
> +	bpf_copy_from_user(&data, sizeof(data), NULL);
> +	bpf_preempt_enable();
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.43.0
> 
> 

