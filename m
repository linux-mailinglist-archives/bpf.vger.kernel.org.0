Return-Path: <bpf+bounces-41342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1272995DB4
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A737D286BF5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B5126BFF;
	Wed,  9 Oct 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ra/k8liZ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DE364BA;
	Wed,  9 Oct 2024 02:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440636; cv=none; b=dT3jEOVQRbLCAJEMVzfz4T8H0haSFE7OU14P6zwn8ajXlozHQ1U5yDdyZqx7sH84URwdXr9CHC67+8sncllK7atfmeuBJscuN3QSyNILPynS2QFe1q8dCSOHoiwF5ISv7rajzkldm9SCKddrLbbVGpKicvkpGDIfGSqZSj8Xqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440636; c=relaxed/simple;
	bh=knGaRzWiMt58OjjMDy6xjYY1UEFJWK7kbpikuX7QDxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt2fRxZdSuDfXBtGu6vPhD17AQL2jgDBJxw9gAdvaHzHsZBO04AMhvux8XB2E0h9h+E/W025CamBRe9ffRap67OCK6XsxFYJ7CC4MANs4meF8Da6Bl1rDHFcNFldGPFzAYksvUYlQgzim9U+5yR+Yd2rfnxxXW8loeMTuG9RtCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ra/k8liZ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728440631; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0oGkB/tDg0LkjjcyvIc/sA7bFYxjsoWvYZTsGCGfcnQ=;
	b=ra/k8liZHGPwYx3ximsb+j0KufEI/P0/s/EQW/KTbJ9cR3m3ppusRp4g+gU2MVa2RhFUaRZdzuLTl0VggkIq/gV9OU/bt+FwhSO2cOSZeRzyFB/z5T+lYWw2mryKZef5zEsGty4F/FANcD08cJU9AQ+1djJSf7QLh9Uef3JjSnQ=
Received: from 30.221.128.133(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WGgzOBr_1728440629)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 10:23:50 +0800
Message-ID: <2e3f676a-ef03-4618-852d-ceb3b620a640@linux.alibaba.com>
Date: Wed, 9 Oct 2024 10:23:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add rcu ptr in btf_id_sock_common_types
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008080916.44724-1-lulie@linux.alibaba.com>
 <80cb3d4b-cebb-4f08-865d-354110a54467@linux.dev>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <80cb3d4b-cebb-4f08-865d-354110a54467@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/9 03:05, Martin KaFai Lau wrote:
> On 10/8/24 1:09 AM, Philo Lu wrote:
>> Sometimes sk is dereferenced as an rcu ptr, such as skb->sk in tp_btf,
>> which is a valid type of sock common. Then helpers like bpf_skc_to_*()
>> can be used with skb->sk.
>>
>> For example, the following prog will be rejected without this patch:
>> ```
>> SEC("tp_btf/tcp_bad_csum")
>> int BPF_PROG(tcp_bad_csum, struct sk_buff* skb)
>> {
>>     struct sock *sk = skb->sk;
>>     struct tcp_sock *tp;
>>
>>     if (!sk)
>>         return 0;
>>     tp = bpf_skc_to_tcp_sock(sk);
> 
> If the use case is for reading the fields in tp, please use the 
> bpf_core_cast from the libbpf's bpf_core_read.h. bpf_core_cast is using 
> the bpf_rdonly_cast kfunc underneath.
> 

Thank you! This works for me so this patch is unnecessary then.

Just curious is there any technical issue to include rcu_ptr into 
btf_id_sock_common_types? AFAICT rcu_ptr should also be a valid ptr 
type, and then btf_id_sock_common_types will behave like (PTR_TO_BTF_ID 
+ &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON]) in bpf_func_proto.

Thanks.
-- 
Philo


