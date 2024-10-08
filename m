Return-Path: <bpf+bounces-41289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE69995763
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2936D28894D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198D2139B6;
	Tue,  8 Oct 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozaItHFB"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF81F472B
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414371; cv=none; b=sCm85Xj0E7kRDktNsnjMqri94G1Q+8DbLiIJCF02wMfOPiDikIKXFyzYFQO2LJqm0Soq1BM0xZMu6sOwHzdoTLIxoUAfXVI6WXj9amwfPMOO+O+ktWftS/lyHwl9QmKzP4cIWvOmv8oqtM6reDVibTpId3O/fJIiMiLz/YEEor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414371; c=relaxed/simple;
	bh=5KvCDrYsmVEvQOJdpgcn18Q0pvxqfpe7WxBjVnVzH9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkIki3iOpa0gVVpZNDgMAEFQa8FjjA9OB2VVGPOP+Lwt3QDzx/LB+FpUWA/j+SNOqOzEr58c6KDTClMIU6XnFUoudCCO4XiqBv2VXQ1gE1VJ4adbvt5Bb3frFOkIRsWsjk929F5LFrLc+W+1KCpKlLpRwHRxD5h8AC/qULc2DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozaItHFB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80cb3d4b-cebb-4f08-865d-354110a54467@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728414366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ni+aJGRqa2mg0vHffyWRXur4SC1MH0dJEEbAGiR80M8=;
	b=ozaItHFB/2BGM61ilYRQ2zY795ImSAUTnTY/dkYyvwBA/g6z6LzkTFpdLf7IbYUJAoO7CA
	1E6CxZl47f3x5o0LGIXjFAB9CU3cEFDukfauyKw9/+woKhDZxkiFCtw781VzVBsYqQXdtv
	TkNcQZQ0U99fNZVegPgCRDvYrnvLKf0=
Date: Tue, 8 Oct 2024 12:05:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add rcu ptr in btf_id_sock_common_types
To: Philo Lu <lulie@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008080916.44724-1-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241008080916.44724-1-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/8/24 1:09 AM, Philo Lu wrote:
> Sometimes sk is dereferenced as an rcu ptr, such as skb->sk in tp_btf,
> which is a valid type of sock common. Then helpers like bpf_skc_to_*()
> can be used with skb->sk.
> 
> For example, the following prog will be rejected without this patch:
> ```
> SEC("tp_btf/tcp_bad_csum")
> int BPF_PROG(tcp_bad_csum, struct sk_buff* skb)
> {
> 	struct sock *sk = skb->sk;
> 	struct tcp_sock *tp;
> 
> 	if (!sk)
> 		return 0;
> 	tp = bpf_skc_to_tcp_sock(sk);

If the use case is for reading the fields in tp, please use the bpf_core_cast 
from the libbpf's bpf_core_read.h. bpf_core_cast is using the bpf_rdonly_cast 
kfunc underneath.

pw-bot: cr


