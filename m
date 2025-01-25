Return-Path: <bpf+bounces-49759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F4CA1C099
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 04:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE1D7A49DE
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47C2046B7;
	Sat, 25 Jan 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FU8LpUgJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5C14A62B
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737774791; cv=none; b=dpjM3SSipIKOJl1mEJ9JT+QSlkreW9mn9ia9HjOLX5oDSGmYf6bpQuy4UoPI0FjzvtxKK7wnXWCP/pxvgJddfUQ0BcpX6iD+/rhi1b3KlsN/KPNPiNwfV6EBcadI8J5B7+SmZGarLMlSdfJ1ROBJOSI600HsnXU4eCW+syY4pv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737774791; c=relaxed/simple;
	bh=el4vgfpubsQQBBzi2DY5pPuT2LqEnHa2JRSCWp7m1B0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HYLBSkHaUqFbB5W8YJ+fyKNEhV3VYqPw947DR9FDR/1x7Uz78pDo7ujzNBT9n+EkQ9P9L0P0cynEkEh5NUfieh386DoIgaqtvhlbRsVNaJeDaYhuc0Nlmjqh4dtphvZAadspveedrXdNo5YuINGgnyYtK9U1MDj1OMhfE3nHZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FU8LpUgJ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d523822-4282-442a-b816-e674ba0814ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737774775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pktsqRhc3T1gmntmdMN3VhPXrceEVPXy5W4EiXeDWsk=;
	b=FU8LpUgJYcXdeKM2ihEYIp/ggYbZRHriz17BSH90o4XcmT8I+Ws9UgqR2XY95KsF/JFSNj
	fCSHlNKAdj1voyR08OB8sWfBk2Lk/djmqmL0eVf+B/b+lcTufgie/ARaeugbbw0ZyNOQFN
	1zU/QURApn31DWynQasFwfpuCshwkBo=
Date: Fri, 24 Jan 2025 19:12:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP
 fields in sock_op BPF CALLs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-5-kerneljasonxing@gmail.com>
 <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
 <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com>
 <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev>
Content-Language: en-US
In-Reply-To: <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/24/25 6:25 PM, Martin KaFai Lau wrote:
>>
>> Sorry, I don't think it can work for all the cases because:
>> 1) please see BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB,
>> if req exists, there is no allow_tcp_access initialization. Then
>> calling some function like bpf_sock_ops_setsockopt will be rejected
>> because allow_tcp_access is zero.
>> 2) tcp_call_bpf() only set allow_tcp_access only when the socket is
>> fullsock. As far as I know, all the callers have the full stock for
>> now, but in the future it might not.
> 
> Note that the existing helper bpf_sock_ops_cb_flags_set and 
> bpf_sock_ops_{set,get}sockopt itself have done the sk_fullsock() test and then 
> return -EINVAL. bpf_sock->sk is fullsock or not does not matter to these helpers.
> 
> You are right on the BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB 
> but the only helper left that testing allow_tcp_access is not enough is 
> bpf_sock_ops_load_hdr_opt(). Potentially, it can test "if (!bpf_sock- 
>  >allow_tcp_access && !bpf_sock->syn_skb) { return -EOPNOTSUPP; }".
> 
> Agree to stay with the current "bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB" 
> as in this patch. It is cleaner.

Also ignore my earlier comment on merging patch 3 and 4. Better keep patch 4 on 
its own since it is not reusing the allow_tcp_access test. Instead, stay with 
the "bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB" test.

