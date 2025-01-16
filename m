Return-Path: <bpf+bounces-49015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE39A130A1
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 02:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31AB7A2768
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF422331;
	Thu, 16 Jan 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lqq/Y/90"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091029A1
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990310; cv=none; b=BWl8bFY2kAakdQh3RBs+Rz+4mdpvu2R80WyaZONsKlVSjQp+ZqUNBsmFDtA8MLGkXkEAct2WHiCO/LrSlPIOLc77HGbO2TEIm6/EJJKRCdKWmrv4M6nKIDUk4mCc/XeaMVW4TIDBZbZJ8assHTyg7XQjs7UkhcJBy5MrLRInq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990310; c=relaxed/simple;
	bh=svejckkpxT1tNqB6vLFqAhoPEzrsLt9DXVcYfXYAUf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lx+m9/kmd/r19nBvS4IELvRYUWgeTB31hbod3nMRcxmILleFiQe/XTiLZEGEkTc4bVkTyZpqN+1mgrbcxolEBaK2BV5R/GpNhX/Bx052yW+yG56xxT4D9X/3nqUoHxrmI60a1Aq90zNmjmCb1ihcisMbImrruS3CnlDMTBiz6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lqq/Y/90; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9601490-26f6-4aaf-80f0-0c92464e0c42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736990305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5t/XcH9zAzEGWfzylUtnUHKUkj+2hXiOa7AVb7ZOuQ=;
	b=Lqq/Y/90qwJJvRkRrVRlgef040PV2dUL0d9tRXBESabnTLObFX+dWxfFswTQoZEvaG4y/P
	4Hy+tTxMEwMLl1GHggEdzqoXMWcZADmLlIntIgrQsXPnr1YwaizO9HJ3003GaQIecFqwgb
	5uQFn/f/HyyJLM+MAmY9yixFxLkW/Hg=
Date: Wed, 15 Jan 2025 17:18:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 13/15] net-timestamp: support tcp_sendmsg for
 bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-14-kerneljasonxing@gmail.com>
 <5d9ba064-3288-4926-b9dc-3119bb3404c1@linux.dev>
 <CAL+tcoCe-Ee92r5B7LwV8GCxEBWDzq3X_g_oOWWzo7-u4wYZzw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoCe-Ee92r5B7LwV8GCxEBWDzq3X_g_oOWWzo7-u4wYZzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/25 4:41 PM, Jason Xing wrote:
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index a0aff1b4eb61..87420c0f2235 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -7037,6 +7037,9 @@ enum {
>>>                                         * feature is on. It indicates the
>>>                                         * recorded timestamp.
>>>                                         */
>>> +     BPF_SOCK_OPS_TS_TCP_SND_CB,     /* Called when every tcp_sendmsg
>>> +                                      * syscall is triggered
>>> +                                      */
>>
>> UDP will need this also?
> 
> Yep.

Then the TCP naming will need to be adjusted.

While on UDP, how the UDP bpf callback will look like during sendmsg?

>>> @@ -1067,10 +1068,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>>        int flags, err, copied = 0;
>>>        int mss_now = 0, size_goal, copied_syn = 0;
>>>        int process_backlog = 0;
>>> +     u32 first_write_seq = 0;
>>>        int zc = 0;
>>>        long timeo;
>>>
>>>        flags = msg->msg_flags;
>>> +     if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
>>> +             first_write_seq = tp->write_seq;
>>> +             bpf_skops_tx_timestamping(sk, NULL, BPF_SOCK_OPS_TS_TCP_SND_CB);
>>
>> My preference is to skip this bpf callout for now and depends on a bpf trace
>> program if it is really needed.
> 
> I have no idea if the bpf program wants to record the timestamp here
> without the above three lines? Please enlighten me more. Thanks in
> advance.
> 
> I guess there is one way which I don't know yet to monitor at the
> beginning of tcp_sendmsg_locked().

The tracing bpf program (fentry in particular here). Give the one-liner bpftrace 
script a try.

Take a look at trace_tcp_connect in test_sk_storage_tracing.c. It uses fentry 
and also bpf_sk_storage_get.

If tcp_sendmsg_locked is inline-d, it can go up to the tcp_sendmsg(). It would 
be nice to have a stable bpf callback if it is really useful but I suspect this 
can be revisited later with the UDP support.

[ I will followup other replies later. ]


