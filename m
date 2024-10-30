Return-Path: <bpf+bounces-43494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D69B5B8A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 06:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330B71C21013
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE481D0E2C;
	Wed, 30 Oct 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DNqSCMCq"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6A1D0E1C
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267891; cv=none; b=Wuuy5s3rVn2uJJcuSY9Hp55ZKGiSWrJLro97feMLeZD/fZRvlYLABR8BheW1vq1ICjXYdgw8bPpzkc7RegfxU1hQXTEPD7rwbvKk8VgaYEayKqn6e3QMybKkAaX39TfNSRLo2IjHsMKGFXPvAaMdlAMabGXr9ch7CqhPrZ6pks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267891; c=relaxed/simple;
	bh=wAJ0wngAd+u8LnoHa24U6WKQf1CZf8H5rbbrYj5VeME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOeJUBByrC9wiOn1dMfH/vU9VhwLdgeNWIZVlob/yQgjy7G/K8KlEv2JZrBDUQjpHuWBh77eQgYf2ow4tyoBJNBnVpO9in+hlGmw9zkI9J5s3qs8E7DBH9y4yPk7rtKAzzDdkLRXHOnzGeyV7D1KqbXfc/EJ38tYrhgiQoPXTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DNqSCMCq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d443142f-c7a1-46f8-8c8f-ee0172e10bdf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730267886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6vXSKk7hz6rSCCix/eChaLjODQNU6FyWlHSUQ49QuI=;
	b=DNqSCMCq6sZeTTAmRaoNqCK3DqVDDJdz1sALJvvvTOYSGEkuQXBs1QEuVn0MpRGffC5jhZ
	q+ky1v8MpgDitb6u3TetpAuLnjNhJdXqOiz5qBgT6JAzv04mg5V4I52YhPd9rXVEd0LHDE
	pzbAjHnkqbjAebXKFX8MUZF69dw10Dk=
Date: Tue, 29 Oct 2024 22:57:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 14/14] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
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
 <20241028110535.82999-15-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241028110535.82999-15-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/28/24 4:05 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Only check if we pass those three key points after we enable the
> bpf extension for so_timestamping. During each point, we can choose
> whether to print the current timestamp.

The bpf prog usually does more than just print. The bpf prog aggregates data 
first before sending all raw data to the user space.

The selftests will be more useful for the reviewer and the future user if it can 
at least show how it can calculate the tx delay between [sendmsg, SCHED], 
[SCHED, SND], [SND, ACK].

[ ... ]

> +SEC("sockops")
> +int skops_sockopt(struct bpf_sock_ops *skops)
> +{
> +	struct bpf_sock *bpf_sk = skops->sk;
> +	struct sock *sk;
> +
> +	if (!bpf_sk)
> +		return 1;
> +
> +	sk = (struct sock *)bpf_skc_to_tcp_sock(bpf_sk);
> +	if (!sk)
> +		return 1;
> +
> +	switch (skops->op) {
> +	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> +		nr_active += !bpf_test_sockopt(skops, sk);
> +		break;
> +	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> +		nr_passive += !bpf_test_sockopt(skops, sk);
> +		break;
> +	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> +		nr_sched += 1;
> +		break;
> +	case BPF_SOCK_OPS_TS_SW_OPT_CB:
> +		nr_txsw += 1;
> +		break;
> +	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> +		nr_ack += 1;

> +		break;
> +	}
> +
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";


