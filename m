Return-Path: <bpf+bounces-43492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17059B5B69
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 06:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37061C24843
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1CC1CF7C2;
	Wed, 30 Oct 2024 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qm2q3ikT"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061217BB21
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266935; cv=none; b=oVb05NF7GWLVsWgBgRnkdJEEwdeCqqclxX6kOGMcwYED3gRa9AJ3W6xrqOI3FgNFPXpa654H4FsLwHOekx9YVpwBqPpY8cCU4Q4qomfrrexzYyG9kK5+i/Od+RlSUF64tbzZlbAgt01E+2/63CEXZQHmjVS4Y894QYWbA8mKq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266935; c=relaxed/simple;
	bh=DXaotLrZvHO7/lZUMHrv9uM/LDut0NoMVmcxjtat8i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AczMhPen0AAMAqZgnUq0WUc5greiSfn9KuUxBRNBiw99Ee7eBQQ8my1j81FSgJJByh1GnSdOj6w3FQvxGFe1jgetcUwpS9RIEYMxdfo0eSHUBG5MPMqoZrbQS/suRy+VYM+v10BPMDYZaX6Aqq6d5wWzJJWBusa4YunEXPqx6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qm2q3ikT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730266931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ogkFKOEJkxZgIuGKDOrDeb3Unth/rF/JZaFzxLyOtc=;
	b=qm2q3ikTFDp/ARzgPDOxhfNOhd4Y0R5rqK5BdNmAUt6ieNrRYURc9Ox6t/qmWoYVSgb24x
	GbITVZbdnIhCDWCH1/P9JdWKJmgyqOJ+RF203pEZ6PXosrAyV/6LJCfBUSQhM8lmDQptQn
	mb7kf82WvuZsD2aQ0fEeZxkt+dlQGVU=
Date: Tue, 29 Oct 2024 22:42:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241028110535.82999-11-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/28/24 4:05 AM, Jason Xing wrote:
> +/* Used to track the tskey for bpf extension
> + *
> + * @sk_tskey: bpf extension can use it only when no application uses.
> + *            Application can use it directly regardless of bpf extension.
> + *
> + * There are three strategies:
> + * 1) If we've already set through setsockopt() and here we're going to set
> + *    OPT_ID for bpf use, we will not re-initialize the @sk_tskey and will
> + *    keep the record of delta between the current "key" and previous key.
> + * 2) If we've already set through bpf_setsockopt() and here we're going to
> + *    set for application use, we will record the delta first and then
> + *    override/initialize the @sk_tskey.
> + * 3) other cases, which means only either of them takes effect, so initialize
> + *    everything simplely.
> + */
> +static long int sock_calculate_tskey_offset(struct sock *sk, int val, int bpf_type)
> +{
> +	u32 tskey;
> +
> +	if (sk_is_tcp(sk)) {
> +		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> +			return -EINVAL;
> +
> +		if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> +			tskey = tcp_sk(sk)->write_seq;
> +		else
> +			tskey = tcp_sk(sk)->snd_una;
> +	} else {
> +		tskey = 0;
> +	}
> +
> +	if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> +		sk->sk_tskey_bpf_offset = tskey - atomic_read(&sk->sk_tskey);
> +		return 0;
> +	} else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPING_OPT_ID)) {
> +		sk->sk_tskey_bpf_offset = atomic_read(&sk->sk_tskey) - tskey;
> +	} else {
> +		sk->sk_tskey_bpf_offset = 0;
> +	}
> +
> +	return tskey;
> +}

Before diving into this route, the bpf prog can peek into the tcp seq no in the 
skb. It can also look at the sk->sk_tskey for UDP socket. Can you explain why 
those are not enough information for the bpf prog?

