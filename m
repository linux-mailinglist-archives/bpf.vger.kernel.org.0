Return-Path: <bpf+bounces-20460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39183EB5F
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 07:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0886FB244D8
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0366C14A8C;
	Sat, 27 Jan 2024 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDawQ+Eu"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C58D2F7
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706335713; cv=none; b=R6kVPayxCOOsK231rM2XD13wHJrhLTCV0eknCqcQOE4toZAyoA1QxJitTsrwKLXCPFTB1sazfRFtgnRZclK8+fnn/E97vUPmuAwRH8OBc371JJ1gQCAmgpuF0ellN+Oms9ktgoaZ0YlOvbNgNnnxar5x+2VdsI6qkZZVUR3sKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706335713; c=relaxed/simple;
	bh=N+X4uBma0AWr8IyKT49y4TeOdk3wQbVWBkdQ1XSRhBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HAecChxJXNIdgFi9LNJJoooYLhY3rn4UVUPD20SZdSfoEvAlk2hligBAlRnD119l7A/RMiFrb1GIMuHCLiE52/bf89ea3jOYE6q6zaryLZPRXTdPcWzq+NAVbbwrMg3S8hn0Lb+SMJnA+Lvr0ndugpPRvey6jfI9XNdiaP9rCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDawQ+Eu; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <330bfcd9-452c-49ac-9651-b33f0f7c3421@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706335708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6YbU2QxJRaNUDFHu/50AnCeK756rNbqagvxsDSwPt0=;
	b=cDawQ+EuMsM+uFwtBqfNAjoYimDeUoaImMRTUsVLHvg0wZUO2A1bfBZHupPfEdaTTtq/pO
	MYuFockJm1brlP9KS9T5oM+cqC1IAGDhqNIGPhQOtwds6slvbGbMtLGYfig2l+rVFH4HnC
	5zYXOjK8vKr/wXw5UYvgbVk15/idOFk=
Date: Fri, 26 Jan 2024 22:08:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove "&>" usage in the
 selftests
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240127025017.950825-1-martin.lau@linux.dev>
In-Reply-To: <20240127025017.950825-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/26/24 6:50 PM, Martin KaFai Lau wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> index 59b38569f310..beeb3ac1c361 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> @@ -85,7 +85,7 @@ static void ping_dev(const char *dev, bool is_ingress)
>   		snprintf(ip, sizeof(ip), "20.0.0.%d", link_index);
>   
>   	/* We won't get a reply. Don't fail here */
> -	SYS_NOFAIL("ping %s -c1 -W1 -s %d >/dev/null 2>&1",
> +	SYS_NOFAIL("ping %s -c1 -W1 -s %d",
>   		   ip, ICMP_PAYLOAD_SIZE);
>   }

The "lwt_redirect/lwt_redirect_normal" is flaky now in s390.
I don't see how this change affected it other than
moving the ">/dev/null 2>&1" part to SYS_NOFAIL.

====
Error: #142/1 lwt_redirect/lwt_redirect_normal
test_lwt_redirect_run:PASS:netns_create 0 nsec
open_netns:PASS:malloc token 0 nsec
open_netns:PASS:open /proc/self/ns/net 0 nsec
open_netns:PASS:open netns fd 0 nsec
open_netns:PASS:setns 0 nsec
test_lwt_redirect_run:PASS:setns 0 nsec
open_tuntap:PASS:open(/dev/net/tun) 0 nsec
open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
setup_redirect_target:PASS:open_tuntap 0 nsec
setup_redirect_target:PASS:if_nametoindex 0 nsec
setup_redirect_target:PASS:ip link add link_err type dummy 0 nsec
setup_redirect_target:PASS:ip link set lo up 0 nsec
setup_redirect_target:PASS:ip addr add dev lo 10.0.0.1/32 0 nsec
setup_redirect_target:PASS:ip link set link_err up 0 nsec
setup_redirect_target:PASS:ip link set tap0 up 0 nsec
setup_redirect_target:PASS:ip route add 10.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_ingress 0 nsec
setup_redirect_target:PASS:ip route add 20.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_egress 0 nsec
test_lwt_redirect_normal:PASS:setup_redirect_target 0 nsec
ping_dev:PASS:if_nametoindex 0 nsec
send_and_capture_test_packets:FAIL:wait_for_epacket unexpected wait_for_epacket: actual 0 != expected 1
(/tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c:175: errno: Success) test_lwt_redirect_normal egress test fails
====

May be the timeout is too short...

static void send_and_capture_test_packets(const char *test_name, int tap_fd,
					const char *target_dev, bool need_mac)
{
	int psock = -1;
	struct timeval timeo = {
		.tv_sec = 0,
		.tv_usec = 250000,
	};

	/* ... */
}

[ ... ]

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


