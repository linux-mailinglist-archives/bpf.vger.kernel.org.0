Return-Path: <bpf+bounces-21427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBAE84D244
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 20:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EBF1F25CB3
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93C85947;
	Wed,  7 Feb 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIzP8aA4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475228564C
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334552; cv=none; b=XLLOU2M9dPtxPtPjgwTGqZnu9Q3wBIfYq0diuq7UsQyUvA1ziqxocU/v0cgBQ8+fI3giDaSv7jqbLCHuZPkfejuffpSeR/J77HRF/uoUa3QTJU3XGid+P8VRyQUnvUxvW0+Ega1hpEL74rARLbu9rtEWkKTPbHbFxZ5tRUcrScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334552; c=relaxed/simple;
	bh=gymLSMOYuo9RMTHJj3rA8OoUYWZDYFEmyLXn1Igok/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQtfw7RiqXBDv0cUd9jvwZtEahVyKbjywwfEavwOlyLglLsIxM9KLwiVkpuZ/Q9G0feGCi76pRRYp3s9HgP9m7g/QS5wJmJe7QF5sxOl4O+197jn8pszkLiAvBH/lL4Az2FscO2d8MAYHO6/BsnqUZaaALj5giUfl4mg5wCcryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIzP8aA4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604a05e26c3so3455057b3.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334549; x=1707939349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDImXhIFxKn0456gfXOEYJnt6aicaOs9/8Ai8GMv2Gs=;
        b=GIzP8aA4F/+yQLKy0D4eLQInoipGg6S6/AvEHhNoj3c2qVahB12JidtKXzyRefZU5C
         jn39DWmMKvNKe/WImFuLeI4uzYl95wRSdfWsLa0amVL8KdU4gWihjE/CHAj/yvTuSHVU
         YBLNYP6QjsNP+9KUwpl9ZZ6dps3EhFGIkZKqRXVOUYphnYt8Lyb/GW0ISnJKEY+wtSTy
         nBTGGCy6s3QX3C3Flm9O1nPpVuiriRYyWay8NWI/3Ao76/J5tIW092vk2HPnKBSwn1MW
         vljmx3cxnw6W3RuTc1mK78htRKESo68H7AT4+sMB24Vyd89FQH8l126hP2iSbOq2bdl0
         KHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334549; x=1707939349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDImXhIFxKn0456gfXOEYJnt6aicaOs9/8Ai8GMv2Gs=;
        b=f99YZWFaueTeuOMOVGDN+NCql9UUHS1UkZ3kuAjB3UBPmg624wrsRUmKzWcdQo60U1
         E1m7p5DTZTJEBIRib/ohJU0aLVkEHzV+iFMlASulnz5dxrNj26byXdAjTJGlo7vf/HK3
         0jel/JZ8q53MyGCG4DOaMnKASrxdVNa7yON53AdNjHBh23A2gALIuOVBUb6eq7tPSKzO
         M0JXxalNDeaI+4faezEVMaxIYLnsbMmQCHhLHLW59ijNuFeC1hNFKKG5m8ebX9kiB9wz
         gXKueZlZS8+K9h1Z6BLYBe8dgjf4U76sIOrmmXz3UjkbojlX7CczS91L7I+ovTSyc6XG
         L+UQ==
X-Gm-Message-State: AOJu0Yy4U6dstAkK6RJ4S74HqNaQ77I5gdvUdjvBZT7xrUAPIhktNy6s
	VEsmXyIK8V9UQbHHthXFsIYUU+IGTBPb06k5r+jsTeFk+bZ0M/F2
X-Google-Smtp-Source: AGHT+IHFxJTrSEOxPPoLpNlLeyJVgU1OZzuDuXwDUygbnpTHzsbw1OQyN50n05xvW/43MLvIWUW/Sw==
X-Received: by 2002:a05:690c:f8a:b0:5ff:b07c:adb4 with SMTP id df10-20020a05690c0f8a00b005ffb07cadb4mr7112579ywb.45.1707334548890;
        Wed, 07 Feb 2024 11:35:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKlgzgxtk6wmSaXCCXt+/MFe10vsFZXiTAYIiM6juEqmJZNjnriMk2xszhhDky3ar8eLbHByxGiwL91WBNf1F8Mh1cs5oKBNbDkvMluTyWa/79VbnKldhAbbFBf9SYQ5FwDx1drPtb/XIOirvCIjWZlc+OW6yI6lrSvTHKek99ULd3uUROoo9Fq2SXCzZXfYDqER70LTPgBfckRQu92j9Apc4cW2FQsfEl606ig+CLGJM/KzjZiS6q8AsVB121rvNwJk0wwf1gAnuuaGz63g==
Received: from ?IPV6:2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24? ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id ci22-20020a05690c0a9600b006040a13db84sm386643ywb.48.2024.02.07.11.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:35:48 -0800 (PST)
Message-ID: <65569020-d712-492a-91ff-9ca3f268bfeb@gmail.com>
Date: Wed, 7 Feb 2024 11:35:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test PTR_MAYBE_NULL
 arguments of struct_ops operators.
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, davemarchevsky@meta.com, dvernet@meta.com
Cc: kuifeng@meta.com
References: <20240206063833.2520479-1-thinker.li@gmail.com>
 <20240206063833.2520479-4-thinker.li@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240206063833.2520479-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/5/24 22:38, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Test if the verifier verifies nullable pointer arguments correctly for BPF
> struct_ops programs.
> 
> "test_maybe_null" in struct bpf_testmod_ops is the operator defined for the
> test cases here. It has several pointer arguments to various types. These
> pointers are majorly classified to 3 categories; pointers to struct types,
> pointers to scalar types, and pointers to array types. They are handled
> sightly differently.
> 
> A BPF program should check a pointer for NULL beforehand to access the
> value pointed by the nullable pointer arguments, or the verifier should
> reject the programs. The test here includes two parts; the programs
> checking pointers properly and the programs not checking pointers
> beforehand. The test checks if the verifier accepts the programs checking
> properly and rejects the programs not checking at all.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 12 ++++-
>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  7 +++
>   .../prog_tests/test_struct_ops_maybe_null.c   | 47 +++++++++++++++++++
>   .../bpf/progs/struct_ops_maybe_null.c         | 31 ++++++++++++
>   .../bpf/progs/struct_ops_maybe_null_fail.c    | 25 ++++++++++
>   5 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index a06daebc75c9..891a2b5f422c 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -555,7 +555,10 @@ static int bpf_dummy_reg(void *kdata)
>   {
>   	struct bpf_testmod_ops *ops = kdata;
>   
> -	ops->test_2(4, 3);
> +	if (ops->test_maybe_null)
> +		ops->test_maybe_null(0, NULL);
> +	else
> +		ops->test_2(4, 3);
>   
>   	return 0;
>   }
> @@ -573,9 +576,16 @@ static void bpf_testmod_test_2(int a, int b)
>   {
>   }
>   
> +static int bpf_testmod_ops__test_maybe_null(int dummy,
> +					    struct task_struct *task__nullable)
> +{
> +	return 0;
> +}
> +
>   static struct bpf_testmod_ops __bpf_testmod_ops = {
>   	.test_1 = bpf_testmod_test_1,
>   	.test_2 = bpf_testmod_test_2,
> +	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
>   };
>   
>   struct bpf_struct_ops bpf_bpf_testmod_ops = {
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> index 537beca42896..c51580c9119d 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> @@ -5,6 +5,8 @@
>   
>   #include <linux/types.h>
>   
> +struct task_struct;
> +
>   struct bpf_testmod_test_read_ctx {
>   	char *buf;
>   	loff_t off;
> @@ -28,9 +30,14 @@ struct bpf_iter_testmod_seq {
>   	int cnt;
>   };
>   
> +typedef u32 (*ar_t)[2];
> +typedef u32 (*ar2_t)[];
> +
>   struct bpf_testmod_ops {
>   	int (*test_1)(void);
>   	void (*test_2)(int a, int b);
> +	/* Used to test nullable arguments. */
> +	int (*test_maybe_null)(int dummy, struct task_struct *task);
>   };
>   
>   #endif /* _BPF_TESTMOD_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
> new file mode 100644
> index 000000000000..1c057c62d893
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <time.h>
> +
> +#include "struct_ops_maybe_null.skel.h"
> +#include "struct_ops_maybe_null_fail.skel.h"
> +
> +/* Test that the verifier accepts a program that access a nullable pointer
> + * with a proper check.
> + */
> +static void maybe_null(void)
> +{
> +	struct struct_ops_maybe_null *skel;
> +
> +	skel = struct_ops_maybe_null__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
> +		return;
> +
> +	struct_ops_maybe_null__destroy(skel);
> +}
> +
> +/* Test that the verifier rejects a program that access a nullable pointer
> + * without a check beforehand.
> + */
> +static void maybe_null_fail(void)
> +{
> +	struct struct_ops_maybe_null_fail *skel;
> +
> +	skel = struct_ops_maybe_null_fail__open_and_load();
> +	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
> +		return;
> +
> +	struct_ops_maybe_null_fail__destroy(skel);
> +}
> +
> +void test_struct_ops_maybe_null(void)
> +{
> +	/* The verifier verifies the programs at load time, so testing both
> +	 * programs in the same compile-unit is complicated. We run them in
> +	 * separate objects to simplify the testing.
> +	 */
> +	if (test__start_subtest("maybe_null"))
> +		maybe_null();
> +	if (test__start_subtest("maybe_null_fail"))
> +		maybe_null_fail();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
> new file mode 100644
> index 000000000000..c5769c742900
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +u64 tgid = 0;
> +
> +/* This is a test BPF program that uses struct_ops to access an argument
> + * that may be NULL. This is a test for the verifier to ensure that it can
> + * rip PTR_MAYBE_NULL correctly. There are tree pointers; task, scalar, and
> + * ar. They are used to test the cases of PTR_TO_BTF_ID, PTR_TO_BUF, and array.

Just found I didn't remove this comment.  I will remove the last two
sentences from the next version.

> + */
> +SEC("struct_ops/test_maybe_null")
> +int BPF_PROG(test_maybe_null, int dummy,
> +	     struct task_struct *task)
> +{
> +	if (task)
> +		tgid = task->tgid;
> +
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_1 = {
> +	.test_maybe_null = (void *)test_maybe_null,
> +};
> +
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
> new file mode 100644
> index 000000000000..566be47fb40b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int tgid = 0;
> +
> +SEC("struct_ops/test_maybe_null_struct_ptr")
> +int BPF_PROG(test_maybe_null_struct_ptr, int dummy,
> +	     struct task_struct *task)
> +{
> +	tgid = task->tgid;
> +
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_struct_ptr = {
> +	.test_maybe_null = (void *)test_maybe_null_struct_ptr,
> +};
> +

