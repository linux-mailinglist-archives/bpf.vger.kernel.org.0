Return-Path: <bpf+bounces-75243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EABC7AF61
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 17:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11C67346AEB
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E92F2EE5FE;
	Fri, 21 Nov 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1B7yyRc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343012E427B
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744012; cv=none; b=qxTsKvBIs7Ojted6U3GvcNvW0KsBiFEyz/h1GHb+t8h4ZK8mUiGLe8ECES5AHtPX9DDmJ0McDbmVI/EJ3M+zsyTmlzo698YX5waDZJPuexCGWpp7ZXOVNWa1ZQY5Y9ppXVCCkNYGDsYgLpwC4QzlliAhDbTbpS0VBiOfJbZWwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744012; c=relaxed/simple;
	bh=WUhEvyV/rNC285W7T/Ap/9w7s+Pxx+9uAh8Ds6SA1OY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJSE9QVjfbFJtlauCZ/QZqfxvwPJwdEGqoth8Sj2EyXeXmWs6a96IX/JcXHAj8YGfjOx1UeUk2PNQNka1Z9APDPBNraOhzHuevH0V7LLsUb7xvVd5H8n5g922777tAK4B63igiC2YjTX+AVKpnCMUausnvP/tntjQqvHJK2rrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1B7yyRc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so8563935e9.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763744008; x=1764348808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PntvX+/OsU/aiydmY3ddy2EarUNLv9q+Is8Xk1h1LhQ=;
        b=j1B7yyRcIJ2VHYb3Q+AE+PiKZPaO/NomPV+VMGsxRsV1TPqOsQjfLeCj6BeyyHsUvf
         xQ0Rp4moa1IjAP4R3aqgJ90CLuT/rtK9MKTlThc5GlGh5JgQyLEnRzMDDfSzkeqLiUra
         goMDz7ADZ8SRhk8ZhK06Yq2D32SRMym/V7f1X+xaIZfHxGxk2b8Z1a0VPwBAFIbqhwGH
         ALcTAOmuRkbbDBhyuM1qvOyhNbUzvO1yff0izkpVfrcyi6lV0dW8HBrCy0PQErNgUSU2
         bYqZvs6+Ra4qLLwAg+uwlAKE+oQr9As/bC2n9iRhaJ9bzdVIInFxu18g73bG2zMMjvnr
         7FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744008; x=1764348808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PntvX+/OsU/aiydmY3ddy2EarUNLv9q+Is8Xk1h1LhQ=;
        b=QU9qoaHOQ+SvjNXwU9EdLYvq5UvB/NLiDRLXzv5+2ZeUXtcwU4KO+KWqbzQDVAzrXG
         5P66Lbyj8/srh2h8cNlpsIXv8LX8oBTTokK1hCgrSFxZl8jNLG1h02o31nXA9XQuvXhb
         UNMkVvyPtI4Qvza6o53gOD7cNLRwQbknwV6nviCjyFOEb3QXyHeoqj92FupEeHqGJ5S/
         KDJ4DqhoG+r/fv06CGzNo84WsNR0BKeD8r8wIBYh6nZ9l7a2oqAK5V/9LtooHFu30Wbc
         ADvkX+j5+LvHxzrjOXlwPVOOMZZKqHf5jZ2KGO9yjIabVV2jqxyWTAW6L70dZzqN9Pye
         +UJg==
X-Gm-Message-State: AOJu0Yy0QaYrCTfF9y1OnvTvj5XIvofIPP7pAvAt28OXGECS2HmVa3hn
	NoBp3dXLfaYzzWzzCAwTq4g3NG7G4hMTg2BdlHqKj4ORqmk2LTsYGg4f
X-Gm-Gg: ASbGnctBhILZ35GC54gF1SpAXUpOZwDiokxNpwG6m4poEQB2b7+y2ovWBGcKeYYWfPX
	WlcDrxKLge71rc9d/N2opnkde0U7AddrG4ShMBuOL/1mKpBS4a4Y/Yav/Jye7kevOr2xOlu0rsS
	Hxk3uEPpabINHNFbme60FHJ4/Uk4vfnT/YlcmZ72UM1QM3NjgXRoOdY2rsw8wsu0mPMiuvWBztZ
	ykQMcKigRAZgi9cH2EIJTR69yqmyPJ0uADaWREAbg9Zf0c0TZ4JoSjX/dXB4prSQmk6+RgSGgfA
	jBs0cNROBzN8xoyM+l+kwE+F764DWXf2wlQn7LtveFyaY5gagd4espYo2g+q3KRBUc7rCM98hTo
	fF3MRcKgcEKQ2jX9aCvVYh5N+FW/50foZqfav+5gBVRKXdzg9iJuNrooH2YvcNLP7BG/RoAoBxf
	fQcRSAAOI+CrDknv4=
X-Google-Smtp-Source: AGHT+IELJHOFFpeDTUf2IQreKa+KT+bQ32mut5d1EyjBlQmvzGHfbjWxJ65AMAjOt/IlrAK5BHK1TA==
X-Received: by 2002:a05:600c:3b2a:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-477c01f4eedmr40407255e9.30.1763744008384;
        Fri, 21 Nov 2025 08:53:28 -0800 (PST)
Received: from krava ([2a00:102a:500a:1917:4c7b:f90f:b94c:79b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3aef57sm48912755e9.11.2025.11.21.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:53:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Nov 2025 17:53:25 +0100
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH bpf-next] selftests/bpf: improve reliability of
 test_perf_branches_no_hw()
Message-ID: <aSCZBW9g51Sg6sU9@krava>
References: <20251119143540.2911424-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119143540.2911424-1-mattbobrowski@google.com>

On Wed, Nov 19, 2025 at 02:35:40PM +0000, Matt Bobrowski wrote:
> Currently, test_perf_branches_no_hw() relies on the busy loop within
> test_perf_branches_common() being slow enough to allow at least one
> perf event sample tick to occur before starting to tear down the
> backing perf event BPF program. With a relatively small fixed
> iteration count of 1,000,000, this is not guaranteed on modern fast
> CPUs, resulting in the test run to subsequently fail with the
> following:
> 
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> Successfully loaded bpf_testmod.ko.
> test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
> test_perf_branches_common:PASS:attach_perf_event 0 nsec
> test_perf_branches_common:PASS:set_affinity 0 nsec
> check_good_sample:PASS:output not valid 0 nsec
> check_good_sample:PASS:read_branches_size 0 nsec
> check_good_sample:PASS:read_branches_stack 0 nsec
> check_good_sample:PASS:read_branches_stack 0 nsec
> check_good_sample:PASS:read_branches_global 0 nsec
> check_good_sample:PASS:read_branches_global 0 nsec
> check_good_sample:PASS:read_branches_size 0 nsec
> test_perf_branches_no_hw:PASS:perf_event_open 0 nsec
> test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
> test_perf_branches_common:PASS:attach_perf_event 0 nsec
> test_perf_branches_common:PASS:set_affinity 0 nsec
> check_bad_sample:FAIL:output not valid no valid sample from prog
> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> Successfully unloaded bpf_testmod.ko.
> 
> On a modern CPU (i.e. one with a 3.5 GHz clock rate), executing 1
> million increments of a volatile integer can take significantly less
> than 1 millisecond. If the spin loop and detachment of the perf event
> BPF program elapses before the first 1 ms sampling interval elapses,
> the perf event will never end up firing. Fix this by bumping the loop
> iteration counter a little within test_perf_branches_common(), along
> with ensuring adding another loop termination condition which is
> directly influenced by the backing perf event BPF program
> executing. Notably, a concious decision was made to not adjust the
> sample_freq value as that is just not a reliable way to go about
> fixing the problem. It effectively still leaves the race window open.
> 
> Fixes: 67306f84ca78c ("selftests/bpf: Add bpf_read_branch_records() selftest")
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  .../selftests/bpf/prog_tests/perf_branches.c     | 16 ++++++++++++++--
>  .../selftests/bpf/progs/test_perf_branches.c     |  3 +++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> index bc24f83339d6..1d51ec5f171a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> @@ -15,6 +15,10 @@ static void check_good_sample(struct test_perf_branches *skel)
>  	int pbe_size = sizeof(struct perf_branch_entry);
>  	int duration = 0;
>  
> +	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
> +		  "checked sample validity before prog run"))
> +		return;
> +
>  	if (CHECK(!skel->bss->valid, "output not valid",
>  		 "no valid sample from prog"))
>  		return;
> @@ -45,6 +49,10 @@ static void check_bad_sample(struct test_perf_branches *skel)
>  	int written_stack = skel->bss->written_stack_out;
>  	int duration = 0;
>  
> +	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
> +		  "checked sample validity before prog run"))
> +		return;
> +
>  	if (CHECK(!skel->bss->valid, "output not valid",
>  		 "no valid sample from prog"))
>  		return;
> @@ -83,8 +91,12 @@ static void test_perf_branches_common(int perf_fd,
>  	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
>  	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
>  		goto out_destroy;
> -	/* spin the loop for a while (random high number) */
> -	for (i = 0; i < 1000000; ++i)
> +
> +	/* Spin the loop for a while by using a high iteration count, and by
> +	 * checking whether the specific run count marker has been explicitly
> +	 * incremented at least once by the backing perf_event BPF program.
> +	 */
> +	for (i = 0; i < 100000000 && !*(volatile int *)&skel->bss->run_cnt; ++i)
>  		++j;
>  
>  	test_perf_branches__detach(skel);
> diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> index a1ccc831c882..05ac9410cd68 100644
> --- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
> +++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> @@ -8,6 +8,7 @@
>  #include <bpf/bpf_tracing.h>
>  
>  int valid = 0;
> +int run_cnt = 0;
>  int required_size_out = 0;
>  int written_stack_out = 0;
>  int written_global_out = 0;
> @@ -24,6 +25,8 @@ int perf_branches(void *ctx)
>  	__u64 entries[4 * 3] = {0};
>  	int required_size, written_stack, written_global;
>  
> +	++run_cnt;
> +
>  	/* write to stack */
>  	written_stack = bpf_read_branch_records(ctx, entries, sizeof(entries), 0);
>  	/* ignore spurious events */
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 

