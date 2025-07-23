Return-Path: <bpf+bounces-64188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505FB0F850
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F36586D40
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475591FC7C5;
	Wed, 23 Jul 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PbSs6it0"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D5C2E0
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288968; cv=none; b=NxcEtT92m0gzGwOmu9Em7/NQFC8DVEIbR8nhzA+HfFHpVqj+NRV+8eVkCxnRecIGRlnE/E/lNcu0+nFrywqnAFGCFClZIyRJdYUx3qxXMNS9EAurOfVKh9dm6YQY6Hs97vFFU0uO17UUrNYR9srVkx5tXa0eZRPwOMapP8ZJ3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288968; c=relaxed/simple;
	bh=weu515HxAHkuURPK86yXG/FVJJzKF9VdctGDpT2Tfw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GwPythwFeKsrORgPIjMmSVl/xTG/6fSzhNmt2LhhgfEb7/Ld2iUw6Ry2Q7LtbLrkMxPQZzJaq3A7WpriFE4xW8S8IsPnIGsxBRNWUacsGDzt2/zGmki/c+BXz6WEZg5aHiPXJLgpWDf5X4GZYit1Q3zWxI1IyaQwFllkBRnT2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PbSs6it0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af8ceac7-851c-438d-8112-c1586427f58a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753288964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8p3PgGx5kkSzSoyRaIEX9Hr5sjraoOmV1Zy/tziPlHM=;
	b=PbSs6it0tQ0Da21CUeFQxpFuNARhw1hxqMBnxLncorDOABNrr7lxhH1tJzV8wQ6RTpWUhk
	HL23U4KCEowdH3tCkS/AT8txUd9Py0VO8x/IHn+QAYAdRBjWBFVNCR/oqql+sbPPYsXXmM
	DMsH4LyH20OOAhb7raU0WJbHae4NHAo=
Date: Wed, 23 Jul 2025 09:42:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add selftest for attaching
 tracing programs to functions in deny list
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-4-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-4-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> The result:
>
>   $ tools/testing/selftests/bpf/test_progs -t tracing_failure/tracing_deny
>   #468/3   tracing_failure/tracing_deny:OK
>   #468     tracing_failure:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

LGTM but see a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../bpf/prog_tests/tracing_failure.c          | 33 +++++++++++++++++++
>   .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
>   2 files changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> index a222df765bc3..140fb0d175cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> @@ -28,10 +28,43 @@ static void test_bpf_spin_lock(bool is_spin_lock)
>   	tracing_failure__destroy(skel);
>   }
>   
> +static void test_tracing_deny(void)
> +{
> +	struct tracing_failure *skel;
> +	char log_buf[256];
> +	int btf_id, err;
> +
> +	/* migrate_disable depends on CONFIG_SMP */
> +	btf_id = libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTRY);
> +	if (btf_id <= 0) {
> +		test__skip();
> +		return;
> +	}

There is a discussion about inlining migrate_disable(). See
   https://lore.kernel.org/bpf/CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com/

Maybe trying to find a different function? Otherwise, if migrate_disable
is inlined and this test will become useless.

> +
> +	skel = tracing_failure__open();
> +	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
> +		return;
> +
> +	bpf_program__set_autoload(skel->progs.tracing_deny, true);
> +	bpf_program__set_log_buf(skel->progs.tracing_deny, log_buf, sizeof(log_buf));
> +
> +	err = tracing_failure__load(skel);
> +	if (!ASSERT_ERR(err, "tracing_failure__load"))
> +		goto out;
> +
> +	ASSERT_HAS_SUBSTR(log_buf,
> +			  "Attaching tracing programs to function 'migrate_disable' is rejected.",
> +			  "log_buf");
> +out:
> +	tracing_failure__destroy(skel);
> +}
> +
>   void test_tracing_failure(void)
>   {
>   	if (test__start_subtest("bpf_spin_lock"))
>   		test_bpf_spin_lock(true);
>   	if (test__start_subtest("bpf_spin_unlock"))
>   		test_bpf_spin_lock(false);
> +	if (test__start_subtest("tracing_deny"))
> +		test_tracing_deny();
>   }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
> index d41665d2ec8c..dfa152e8194e 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
> @@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
>   {
>   	return 0;
>   }
> +
> +SEC("?fentry/migrate_disable")
> +int BPF_PROG(tracing_deny)
> +{
> +	return 0;
> +}


