Return-Path: <bpf+bounces-49753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACDA1C079
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AB916CC01
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF320469D;
	Sat, 25 Jan 2025 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RYPFXTmu"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D21FA26C
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771959; cv=none; b=GfPM5ACPu82w2LOEHvGHX3ur7DYwnZlOdAoEMuIqGgIeopETweiU9B8xEJ6ZJwBhICX3T21y2kgKmNLqMi9hJUurIgV1XyffOySWDK6iaMjj0cwx7pE7zZxeoNsqWU9ADM/5ehQ472uUEzBxZggtSp0c4Da28lFKFVbwliWxlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771959; c=relaxed/simple;
	bh=sfbyUGNl3BV6cxE3z3Mz62fIxi69c1t5lU8wWDuMWyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyIV2uQrlM5J/7KefIJsSOnx7YDxgvJ0TxuZWTGPS3L7/jfBsvF7xNNEIWSgIzKcSX7rBpufq8BbQ6eLI+3rrmWKZB1ObO2IxLZkfQRFUgl4risNCD5J8kMh+dkmsLSqPsnCAjWc4FfUght+Sf6Yg4sfdvQ6EU0ADalAumZ/ZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RYPFXTmu; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737771954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ay1VXtsc9zMEJ5Y8hUSrlKQ//fWdWs0EUEFxmqfAedw=;
	b=RYPFXTmu3EYsLiXDo1MMCiV8pB7kaJ4yRpT2IzJTKhkivijjAxoNlXJcF5DKhAUtxkfAt9
	/oELO3CWB5dJQ21o/Mh0jxQGZjm6Mv+r9rm3Zn44D6PM2VXqR4y2/BHJ0qOjweTSrP3lHk
	vQou6jX2ofmVamHK0rqCknz6vdatGGA=
Date: Fri, 24 Jan 2025 18:25:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP
 fields in sock_op BPF CALLs
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/24/25 5:15 PM, Jason Xing wrote:
>>> +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
>>> +{
>>> +     return bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
>>
>> More bike shedding...
>>
>> After sleeping on it again, I think it can just test the
>> bpf_sock->allow_tcp_access instead.
> 
> Sorry, I don't think it can work for all the cases because:
> 1) please see BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB,
> if req exists, there is no allow_tcp_access initialization. Then
> calling some function like bpf_sock_ops_setsockopt will be rejected
> because allow_tcp_access is zero.
> 2) tcp_call_bpf() only set allow_tcp_access only when the socket is
> fullsock. As far as I know, all the callers have the full stock for
> now, but in the future it might not.

Note that the existing helper bpf_sock_ops_cb_flags_set and 
bpf_sock_ops_{set,get}sockopt itself have done the sk_fullsock() test and then 
return -EINVAL. bpf_sock->sk is fullsock or not does not matter to these helpers.

You are right on the BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB 
but the only helper left that testing allow_tcp_access is not enough is 
bpf_sock_ops_load_hdr_opt(). Potentially, it can test "if 
(!bpf_sock->allow_tcp_access && !bpf_sock->syn_skb) { return -EOPNOTSUPP; }".

Agree to stay with the current "bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB" 
as in this patch. It is cleaner.

>>> @@ -5673,7 +5678,12 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
>>>    BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>>>           int, level, int, optname, char *, optval, int, optlen)
>>>    {
>>> -     return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
>>> +     struct sock *sk = bpf_sock->sk;
>>> +
>>> +     if (is_locked_tcp_sock_ops(bpf_sock) && sk_fullsock(sk))
>>
>> afaict, the new timestamping callbacks still can do setsockopt and it is
>> incorrect. It should be:
>>
>>          if (!bpf_sock->allow_tcp_access)
>>                  return -EOPNOTSUPP;
>>
>> I recalled I have asked in v5 but it may be buried in the long thread, so asking
>> here again. Please add test(s) to check that the new timestamping callbacks
>> cannot call setsockopt and read/write to some of the tcp_sock fields through the
>> bpf_sock_ops.
>>
>>> +             sock_owned_by_me(sk);
>>
>> Not needed and instead...
> 
> Sorry I don't get you here. What I was doing was letting non
> timestamping callbacks be checked by the sock_owned_by_me() function.
> 
> If the callback belongs to timestamping, we will skip the check.

It will skip the sock_owned_by_me() test and
continue to do the following __bpf_setsockopt() which the new timetamping 
callback should not do, no?

It should be just this at the very beginning of bpf_sock_ops_setsockopt:

	if (!is_locked_tcp_sock_ops(bpf_sock))
		return -EOPNOTSUPP;
> 
>>
>>> +
>>> +     return __bpf_setsockopt(sk, level, optname, optval, optlen);
>>
>> keep the original _bpf_setsockopt().
> 
> Oh, I remembered we've already assumed/agreed the timestamping socket
> must be full sock. I will use it.
> 
>>
>>>    }
>>>
>>>    static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
>>> @@ -5759,6 +5769,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>>>           int, level, int, optname, char *, optval, int, optlen)
>>>    {
>>>        if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
>>> +         bpf_sock->sk->sk_protocol == IPPROTO_TCP &&
>>>            optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {
>>
>> No need to allow getsockopt regardless what SOL_* it is asking. To keep it
>> simple, I would just disable both getsockopt and setsockopt for all SOL_* for
> 
> Really? I'm shocked because the selftests in this series call
> bpf_sock_ops_getsockopt() and bpf_sock_ops_setsockopt() in patch
> [13/13]:

Yes, really. It may be late Friday for me here. Please double check your test if 
the bpf_set/getsockopt is called from the new timestamp callback or it is only 
called from the existing BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB callback.

Note that I am only asking to disable the set/getsockopt, 
bpf_sock_ops_cb_flags_set, and the bpf_sock_ops_load_hdr_opt for the new 
timestamping callbacks.



