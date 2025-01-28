Return-Path: <bpf+bounces-49991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB9A2149C
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 23:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE16B166735
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B491E1C22;
	Tue, 28 Jan 2025 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVhKKmVD"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD719D892
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104572; cv=none; b=qZFhL6ZDMSJOWKJzHjd3GIkiBzVIhL96vkQdzWXWxuKEfld7O7BtEnpgBGACZEit6zp8in6+bVxl2s8E2Q2B+Ns/Hi8SPEhKL19AM3vsrPAWgn+XkIBzLOxyrNOrA2gbjc54xgL3yqF59JJlodf6fzqtjOR1+WLo3StgspWsN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104572; c=relaxed/simple;
	bh=0z1Uu2ZoNK4FMlqQYppsrJJjYCmDj0CbPV0ZLW+wLgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7DieES8iZ6YRgSxZqK9lZmZL6/PW2qpJRJ4YtRdbujvzShC3sw8E4qacm0UE1F6tZeQKiTh7nHBwAM+5QGOcnVr1Klf2Lf7ZEosEOcHSIxqO+uuGnFJR3xSw0Haz2l7KUEzJfUzt5c4gv8VQwvS2d0MWyPWRO8AW8vyR734Fok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVhKKmVD; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e03f6c1d-37c3-4d0b-8e42-1f8980ed379a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738104558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylNTxkBjhSFS6U9A/qTUzi5AjkmPH4/OseDQKYmB8n0=;
	b=YVhKKmVDZ2GYQ86Ja4x+ridvVmRjz8qkKsXJtXzCsLrHv03xzQZFJewvKpJtxIWSpv8qcs
	03tp/WBNyWoFsY4lEB7ooopBor6e02tV5FxIMOkixgRI2F/V9tKzVsIrnKjow2lHSCRPwA
	3VpInGxoaY1FUSTMWTryzqidmkT32OE=
Date: Tue, 28 Jan 2025 14:49:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/14] selftests/bpf: helpers: Add
 append_tid()
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
 <20250128-redirect-multi-v3-1-c1ce69997c01@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128-redirect-multi-v3-1-c1ce69997c01@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 1:57 AM, Bastien Curutchet (eBPF Foundation) wrote:
> Some tests can't be run in parallel because they use same namespace
> names or veth names.
> 
> Create an helper that appends the thread ID to a given string. 8
> characters are used for it (7 digits + '\0')
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 11 +++++++++++
>   tools/testing/selftests/bpf/network_helpers.h | 10 ++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 80844a5fb1feef2ff73c2f0293e52495803ab769..d2ff7521aaa696ed04d8f1308394b4c01c1c038b 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -446,6 +446,17 @@ char *ping_command(int family)
>   	return "ping";
>   }
>   
> +int append_tid(char *str, size_t offset)
nit. offset should always be strlen(str) now. The append_tid will be easier to 
use if the append_tid always does the strlen() itself to figure out the end of 
the str.

It will be useful to replace the "size_t offset" arg with "size_t sz" which 
tells the max size of the "char *str" and the append_tid does a check to ensure 
there is enough space to append the "%07d" tid.

> +{
> +	if (!str)
> +		return -1;
> +
> +	sprintf(&str[offset], "%07d", gettid());
> +	str[offset + 7] = '\0';
> +
> +	return 0;
> +}
> +
>   int remove_netns(const char *name)
>   {
>   	char *cmd;
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index ebec8a8d6f81e9d079a3b087127a37885c656856..b2451dd00594190e1dcb58498d70dd80c0e7c51c 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -98,6 +98,16 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes);
>   int make_netns(const char *name);
>   int remove_netns(const char *name);
>   
> +/**
> + * append_tid() - Append thread ID to the given string.
> + *
> + * /!\ the appended thread ID is 8 characters long
> + *     so the input string must be allocated accordingly
> + *
> + * Returns -1 if input is NULL, 0 otherwise
> + */
> +int append_tid(char *str, size_t offset);
> +
>   static __u16 csum_fold(__u32 csum)
>   {
>   	csum = (csum & 0xffff) + (csum >> 16);
> 


