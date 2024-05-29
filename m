Return-Path: <bpf+bounces-30884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E006A8D41F7
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 01:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25272285EFA
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E51CB31C;
	Wed, 29 May 2024 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bjG1O2pe"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F116AB8
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717025518; cv=none; b=O4DkFQpJ0NrGXFI4j66iOmRfKL6AWj53RND8dEV4V4lU+8MwE35iynstPYT1P1IeK8JUTPPKFJSjavEzUk+tzr/PlAHTXEUx7gwxLQ5yartudwDFgb+IJfyTboulgNDzSU31tFWsZIK8+iiXevJ3AZUbPad1dFgcMg+4hi2LBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717025518; c=relaxed/simple;
	bh=GoVk3hNrKd3c6caDQ7OhCBjgqux/jYlC6OkQqSfhfUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUfhjhB5B5y/35ag324Kw1p8JQ2CFtja6FC5vKF0Ov8ey128ZZZSvNrq9CYpv4uayG3owrWr8zbQo6gk93L+JCfdrqQyR+qTSVCTNOfSSfUgRBwP7JEE7q+4i26QwwmU3CHd4wj/dIX/BxRcch+yd8BUqxTz5QnhPXSWiCHPN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bjG1O2pe; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717025514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0FFwBvD1ZO13tqatCTLyRIjujkFUNX3kU8lW2Xfe3w=;
	b=bjG1O2peWEi9z7e58KY4Cx1QmmMCC1YtHrtYYRaZ+oTuU39utOUJ09xQjz21HWcJtu0sD8
	ewHFZt6Z53oljObR2UMPqcCaUz3EzuIJpFKkk8pBNZBS0BVF0cvAfzEvofKcfL31EJieGw
	XbwhkLlZa21xc7UQ2Cl/u46oyt1lgUE=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: mptcp@lists.linux.dev
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <1808b186-27d3-4bb8-854e-5ce19920a0c9@linux.dev>
Date: Wed, 29 May 2024 16:31:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/8] selftests/bpf: Add unshare_netns helper
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <cover.1715821541.git.tanggeliang@kylinos.cn>
 <cf3c81f6014cfd1339622b1230e8dc9cca7a4440.1715821541.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cf3c81f6014cfd1339622b1230e8dc9cca7a4440.1715821541.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/15/24 6:13 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Many BPF selftests create new test network namespaces by using CLONE_NEWNET
> flag to unshare the network namespace, so that the calling process is moved
> into a new network namespace which is not shared with any previously
> existing process. So this patch adds a new helper in network_helpers.c
> named unshare_netns(), which create a new network namespace and set the
> net device lo up.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 19 +++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  1 +
>   2 files changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 35250e6cde7f..919bb2a0c6a6 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -670,3 +670,22 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
>   
>   	return err;
>   }
> +
> +int unshare_netns(void)
> +{
> +	int err;
> +
> +	err = unshare(CLONE_NEWNET);
> +	if (err) {
> +		log_err("unshare netns failed");
> +		return err;
> +	}
> +
> +	err = SYS_NOFAIL("ip link set dev lo up");

Losing useful error output is not good. Please find a way to keep them available 
such that it is easier to debug. The same goes for similar cases in this patch 
set. I think the only exception could be the "ip netns del" during cleanup.

Also, bpf CI reports a crash (should be the test #18 bpf_ip_check_defrag). Not 
sure how this set indirectly triggered it more easily:

https://github.com/kernel-patches/bpf/actions/runs/9290828674/job/25569002645

pw-bot: cr

> +	if (err) {
> +		log_err("set dev lo up failed");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 883c7ea9d8d5..b087330f2861 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -82,6 +82,7 @@ struct nstoken;
>   struct nstoken *open_netns(const char *name);
>   void close_netns(struct nstoken *token);
>   int send_recv_data(int lfd, int fd, uint32_t total_bytes);
> +int unshare_netns(void);
>   
>   static __u16 csum_fold(__u32 csum)
>   {


