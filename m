Return-Path: <bpf+bounces-20456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71B83EB1F
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70A4B25219
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 04:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03BE12E41;
	Sat, 27 Jan 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xa00wmoO"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84D14A87
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706331389; cv=none; b=u3hIq8ZEoJAeOPmOhvytV3ibR4k7Y5C4hIxoOqJ7V7b83a1DcrNl3r8OofCjZ288zhQJrPtr8jb7ASS4LuC/kzi3m8YfCiTRSCzQIa1IV6jCgszPcl46NT/EgpTWniPLFGCP4zDbPqCjw61bzrVIf170+jhPi9GfjhVj44ZdJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706331389; c=relaxed/simple;
	bh=gjgfao9fcaJByFSjCYE6sqHrQv9wFAYfl9fNXTRp+to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+/GZsOlvxfmb5K5b+FIWPZFwsMim3C9QPo8NGmwDABcQ87EDMj9TbIM9SgDgBK28e7yUdvn8Gn7ZuBlztm9yRIcWZNDerz16iASsj/QA525Vo7cYJBGTgY858LZgU6pglaof+zsFxyQ/w0tCy3RL0P6Wkr9rTR94R7t3i5ZrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xa00wmoO; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <879d5e4f-f20d-460b-9fb3-e362c0324ca2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706331384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxAZEPdPvlM+hyM6eBlvhOMyJwIqsSlhB3yebo3Xtck=;
	b=Xa00wmoOgTZYy/v/K0AdeAAT6EcgC+LFxhGmPB6TzVkYX7xeYM7kiZf0/rC0KXmELa5oLB
	fp99HNDfBadfRAdc9fGr0Z4D6HbJX0MOMNxaYpyfVyX1sGm02bbb+fnAleZqgJFDG9heuj
	u0dUJSF+oyxGAe61GG5q3HfGyyqrw/U=
Date: Fri, 26 Jan 2024 20:56:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove "&>" usage in the
 selftests
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240127025017.950825-1-martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240127025017.950825-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/26/24 6:50 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> In s390, CI reported that the sock_iter_batch selftest
> hits this error very often:
>
> 2024-01-26T16:56:49.3091804Z Bind /proc/self/ns/net -> /run/netns/sock_iter_batch_netns failed: No such file or directory
> 2024-01-26T16:56:49.3149524Z Cannot remove namespace file "/run/netns/sock_iter_batch_netns": No such file or directory
> 2024-01-26T16:56:49.3772213Z test_sock_iter_batch:FAIL:ip netns add sock_iter_batch_netns unexpected error: 256 (errno 0)
>
> It happens very often in s390 but Manu also noticed it happens very
> sparsely in other arch also.
>
> It turns out the default dash shell does not recognize "&>"

Not sure whether it is feasible or not. But is it possible
for all our test VMs we run '/bin/bash' before everyting else
so we have a uniform bash environment so we do not need to
worry about other shells?

> as a redirection operator, so the command went to the background.
> In the sock_iter_batch selftest, the "ip netns delete" went
> into background and then race with the following "ip netns add"
> command.
>
> This patch replaces the "&> /dev/null" usage with ">/dev/null 2>&1"
> and does this redirection in the SYS_NOFAIL macro instead of doing
> it individually by its caller. The SYS_NOFAIL callers do not care
> about failure, so it is no harm to do this redirection even if
> some of the existing callers do not redirect to /dev/null now.
>
> It touches different test files, so I skipped the Fixes tags
> in this patch. Some of the changed tests do not use "&>"
> but they use the SYS_NOFAIL, so these tests are also
> changed to avoid doing its own redirection because
> SYS_NOFAIL does it internally now.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>   .../selftests/bpf/prog_tests/decap_sanity.c    |  2 +-
>   .../selftests/bpf/prog_tests/fib_lookup.c      |  2 +-
>   .../selftests/bpf/prog_tests/ip_check_defrag.c |  4 ++--
>   .../selftests/bpf/prog_tests/lwt_redirect.c    |  2 +-
>   .../selftests/bpf/prog_tests/lwt_reroute.c     |  2 +-
>   tools/testing/selftests/bpf/prog_tests/mptcp.c |  2 +-
>   .../selftests/bpf/prog_tests/sock_destroy.c    |  2 +-
>   .../selftests/bpf/prog_tests/sock_iter_batch.c |  4 ++--
>   .../selftests/bpf/prog_tests/test_tunnel.c     | 18 +++++++++---------
>   tools/testing/selftests/bpf/test_progs.h       |  7 ++++++-
>   10 files changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
> index 5c0ebe6ba866..dcb9e5070cc3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
> +++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
> @@ -72,6 +72,6 @@ void test_decap_sanity(void)
>   		bpf_tc_hook_destroy(&qdisc_hook);
>   		close_netns(nstoken);
>   	}
> -	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
> +	SYS_NOFAIL("ip netns del " NS_TEST);
>   	decap_sanity__destroy(skel);
>   }

[...]

> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 2f9f6f250f17..80df51244886 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -385,10 +385,15 @@ int test__join_cgroup(const char *path);
>   			goto goto_label;				\
>   	})
>   
> +#define ALL_TO_DEV_NULL " >/dev/null 2>&1"
> +
>   #define SYS_NOFAIL(fmt, ...)						\
>   	({								\
>   		char cmd[1024];						\
> -		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);		\
> +		int n;							\
> +		n = snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
> +		if (n < sizeof(cmd) && sizeof(cmd) - n >= sizeof(ALL_TO_DEV_NULL)) \
> +			strcat(cmd, ALL_TO_DEV_NULL);			\
>   		system(cmd);						\
>   	})
>   

