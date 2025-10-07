Return-Path: <bpf+bounces-70489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38559BC0205
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 06:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94203B5817
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413FF215075;
	Tue,  7 Oct 2025 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WYIeBfjg"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF21DF75D;
	Tue,  7 Oct 2025 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809886; cv=none; b=F5IUp+8llNVuqUieGEw8HuRa3WHHnyEF9y34fIe/FPyEeHKp3CpjE67ibrNE6NyPjxNlpRR5M/wOk3gBGBEGqy3pKCug42xJ4JPfh5AOEjrubnafTrE/K4cr6r3r1leO85M9XmDUVVB/A9bcDjsl3YZywQWWOBhgazbmxEkUSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809886; c=relaxed/simple;
	bh=56I4s3HvxAgS0aIw+n4myRt7GVO19xaC9A2ZiDs2V4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DSurCcNEvVlnbZ9/TDC8heFmDDohYfhsseEIZbNxGYJBpEtWHe0+uyu2A/3KShdS3rAE6BMjjkWSdmKnCcm+wM/7ZAIfBZO7kW8OtM932VP6wA7kNs6WY5gDdoFDnN08sE6o3kKEk9/Cpkn5k2/y+F/T1xZuf41p0zHTeKqBb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WYIeBfjg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79ffb312-4aa4-425e-b05b-02aee21acfe6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759809873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kq0DgSgOHHUgUa1+EG9O+3G05yFO+7v971HnhkIWDn8=;
	b=WYIeBfjgLtykIJpdBwefBmwfSyLWCGSI8NXU4Eu4OPndy6R94OQEJxk8W1QVCzEg+UlRJO
	rcx5GqplT2kabRZeT4h3wJw1yEqGJURU71EkAVN0PNcfSMP01bdJm5YnoZkdLAi2R3SPep
	cH400xvvTo2z6AJbmL+TcaJ9tg325yM=
Date: Mon, 6 Oct 2025 21:04:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for unpinning htab
 with internal timer struct
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, toke@redhat.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251007012235.755853-1-kafai.wan@linux.dev>
 <20251007012235.755853-3-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251007012235.755853-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/6/25 6:22 PM, KaFai Wan wrote:
> Add test to verify that unpinning hash tables containing internal timer
> structures does not trigger context warnings.
>
> Each subtest (timer_prealloc and timer_no_prealloc) can trigger the
> context warning when unpinning, but the warning cannot be triggered
> twice within a short time interval (a HZ), which is expected behavior.
>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Ack with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../selftests/bpf/prog_tests/pinning_htab.c   | 37 +++++++++++++++++++
>   .../selftests/bpf/progs/test_pinning_htab.c   | 25 +++++++++++++
>   2 files changed, 62 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_htab.c b/tools/testing/selftests/bpf/prog_tests/pinning_htab.c
> new file mode 100644
> index 000000000000..fc804bb87b26
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/pinning_htab.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "test_pinning_htab.skel.h"
> +
> +static void unpin_map(const char *map_name, const char *pin_path)
> +{
> +	struct test_pinning_htab *skel;
> +	struct bpf_map *map;
> +	int err;
> +
> +	skel = test_pinning_htab__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		return;
> +
> +	map = bpf_object__find_map_by_name(skel->obj, map_name);
> +	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
> +		goto out;
> +
> +	err = bpf_map__pin(map, pin_path);
> +	if (!ASSERT_OK(err, "bpf_map__pin"))
> +		goto out;
> +
> +	err = bpf_map__unpin(map, pin_path);
> +	if (!ASSERT_OK(err, "bpf_map__unpin"))
> +		goto out;

No need to have 'goto out'. Just do
	ASSERT_OK(err, "bpf_map__unpin"

> +out:
> +	test_pinning_htab__destroy(skel);
> +}
> +
> +void test_pinning_htab(void)
> +{
> +	if (test__start_subtest("timer_prealloc"))
> +		unpin_map("timer_prealloc", "/sys/fs/bpf/timer_prealloc");
> +	if (test__start_subtest("timer_no_prealloc"))
> +		unpin_map("timer_no_prealloc", "/sys/fs/bpf/timer_no_prealloc");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_pinning_htab.c b/tools/testing/selftests/bpf/progs/test_pinning_htab.c
> new file mode 100644
> index 000000000000..ae227930c73c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_pinning_htab.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct timer_val {
> +	struct bpf_timer timer;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, __u32);
> +	__type(value, struct timer_val);
> +	__uint(max_entries, 1);
> +} timer_prealloc SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, __u32);
> +	__type(value, struct timer_val);
> +	__uint(max_entries, 1);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +} timer_no_prealloc SEC(".maps");


