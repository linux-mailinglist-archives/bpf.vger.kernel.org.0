Return-Path: <bpf+bounces-59373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F3AC96A9
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 22:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7901C02075
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6565C283154;
	Fri, 30 May 2025 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c2sjHzJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3D2CCC0
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748637464; cv=none; b=ZVln0r7T6UNiboisMeq3PP9ZFrlFrOb4B4kNwP6aq9sfQJR7w6lMsY275HfJgfd3qVtBwUGJc1P7ydDV+N3TDF+ZPwHBKBLkoyqJ1mLCkOzBfprNROLX3JrN/3MBRQ+eJCMEhuqNaxThOK11zAPk4QjDAC4nC641+6HNqsMl8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748637464; c=relaxed/simple;
	bh=09yRdOfHBBD74x72EqLl8KAykD8f9mVnzkSL5l54rpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r654LGFTUoc/IAPvp/u6niv02X93TBxROFfSprXzi77j7ekNt/Ng+/8go5MsonZsrsXYmpmXdo4Sz032VfCFR5E+LeQDq/iJRXF4Y/1v3UJWbimlHse9A91gewUn29v5Aawd80z/7W/w8ptQBuwOH26ICmFFq8QDBKIje+u8Yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c2sjHzJ4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5ba363f1aso329853485a.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748637461; x=1749242261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s72Ujra1dO1NPQly4HIiBu9QKTze5HeShyxVLbJudtM=;
        b=c2sjHzJ4s0dBEI6hRzOHCmVa9MhGbPmygDaOCJgrRrtC+sYxRQlm5V1nb3vE6R/CYE
         oqu9GO6nYsoEqhjuxW3VG+g1IUDJcyB0ObbwGj6TqoESQkCMBR6mIj4pU4EQxUxAvlRT
         tU1NJ8ek6CdLMmusfs9udNKonTzfGBPg2WRg9NjuXMV+s+fSzAgrlUlnC1+e3hRkOzAG
         RkvrX8KEdpR/BBkUdCAccbXlTPis8q0cHFhrA6Hp/IQsccAZLzWlzbm3bJprSNUt0U6h
         7Zc73g8p1DnEu0lPrMejOARNOGUEB9XMgqAq4GrL5dIy7QTjAvXWoqVHK7wJW7d7XhgP
         Vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748637461; x=1749242261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s72Ujra1dO1NPQly4HIiBu9QKTze5HeShyxVLbJudtM=;
        b=DH1/0eAGdZ7D30cn/OGIZQSc1Ey2dC8bn0qGqe0QNB0Duwj7mBk8zT0F7gfMIcZ2H8
         Eenz/5NPDF5lu9d02iwuJprq6QZtKUMdiG63iaA4yd/FqAkj9uaaF7SIdNgdq7OkidHk
         KNeH6tN1QzOGscK03/i64Ye6mhTdPNOPwfrBnsFjo65OuOUSLRtuSFMrgCJ+1tNhnogU
         jS4UHIGktOq5YdsOcBtb3BiusbkNWrIAot2pxjMXJY4fryqgL6bSHhjibiuqiwVaXWhj
         UkXOWErcqPOiJaUvvEc+NwlmH+Z/GOIgMZZOuFAQQgxa1gVQiMtU+2RkXbIJR/1phGOJ
         3ewA==
X-Forwarded-Encrypted: i=1; AJvYcCVUuhNp7JBNmrHg+xFC3n3zfsrMQ/AYw2O1Eomn2wLXnSS8B64yBCVPfgaEIi0U4gJQF4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjxR1fzXNsWhn5f9uSj+RwLlBWwY8R3G72k9XPR2xg3YrR/mAs
	+uX/7uc2AWEYMufLZCyHcUlhc9qmRWMO9GwLfZ6IXdliz9iCt8ptiaxb2gWrq7Pjh7I=
X-Gm-Gg: ASbGncsfjmMpBnj2K2oe7YHa12OuMKJRq48o8xD/J+SrtVSH0XgS/up5vx31zyxt7gB
	3V5XOmIznn7WSYWKEtak0miS7d/S/Ae0UYS6hZO6UqjTUj2Zz2jOnhM9uGkGyGb/nOFqhNATKPg
	0+ep9Rqyi3gnRa6Cy+9sD6zjG0mItPQIVP+PVe4hyCdUPeF0Ojq8JtfTAI0UrjNTzeVX3mkEpp6
	G2MSLcyXwIhfwORhg1YQpJdXHb/rhBZnZA+CCeQv0tzgCpHcrZCSEJ4Gow4ogIW/3Dv/q2MQr0R
	jDs0yCnQTR0VGI8Zp7mtU4KUcJtXfJvvMAd+bP1SZ0K4XTluQ8hNyJkbcXoe4VaLm76RSKpgoVS
	djMO+dw==
X-Google-Smtp-Source: AGHT+IGZyi5LZ/JJwRsDNg0g5DsqwCg5tBuBsCGwJaLgYtecTvK77ooayzvoj9wwz0v5+xfUDGtuJw==
X-Received: by 2002:a05:620a:2996:b0:7c9:4d4d:206e with SMTP id af79cd13be357-7d0a49e68c6mr559805085a.6.1748637460855;
        Fri, 30 May 2025 13:37:40 -0700 (PDT)
Received: from [10.200.180.213] ([130.44.212.152])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a115a38sm291574585a.59.2025.05.30.13.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 13:37:40 -0700 (PDT)
Message-ID: <9e167af1-1265-4427-806e-67eac349cbf3@bytedance.com>
Date: Fri, 30 May 2025 13:37:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v3 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
To: John Fastabend <john.fastabend@gmail.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
 jakub@cloudflare.com, Amery Hung <amery.hung@bytedance.com>,
 Cong Wang <cong.wang@bytedance.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-5-xiyou.wangcong@gmail.com>
 <20250530200735.hhzeicomnb7mbwdl@gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20250530200735.hhzeicomnb7mbwdl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 1:07 PM, John Fastabend wrote:
> On 2025-05-19 13:36:28, Cong Wang wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The TCP_BPF ingress redirection path currently lacks the message corking
>> mechanism found in standard TCP. This causes the sender to wake up the
>> receiver for every message, even when messages are small, resulting in
>> reduced throughput compared to regular TCP in certain scenarios.
>>
>> This change introduces a kernel worker-based intermediate layer to provide
>> automatic message corking for TCP_BPF. While this adds a slight latency
>> overhead, it significantly improves overall throughput by reducing
>> unnecessary wake-ups and reducing the sock lock contention.
>>
>> Reviewed-by: Amery Hung <amery.hung@bytedance.com>
>> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> ---
>>   include/linux/skmsg.h |  19 ++++
>>   net/core/skmsg.c      | 139 ++++++++++++++++++++++++++++-
>>   net/ipv4/tcp_bpf.c    | 197 ++++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 347 insertions(+), 8 deletions(-)
> 
> [...]
> 
>> +	/* At this point, the data has been handled well. If one of the
>> +	 * following conditions is met, we can notify the peer socket in
>> +	 * the context of this system call immediately.
>> +	 * 1. If the write buffer has been used up;
>> +	 * 2. Or, the message size is larger than TCP_BPF_GSO_SIZE;
>> +	 * 3. Or, the ingress queue was empty;
>> +	 * 4. Or, the tcp socket is set to no_delay.
>> +	 * Otherwise, kick off the backlog work so that we can have some
>> +	 * time to wait for any incoming messages before sending a
>> +	 * notification to the peer socket.
>> +	 */
> 
> 
> OK this series looks like it should work to me. See one small comment
> below. Also from the perf numbers in the cover letter is the latency
> difference reduced/removed if the socket is set to no_delay?
> 

Even if the socket is set to no_delay, we still have minor latency diff.
The main reason is that we now have dynamic allocation for skmsg and
kworker in the middle, the path is more complex now.

>> +	nonagle = tcp_sk(sk)->nonagle;
>> +	if (!sk_stream_memory_free(sk) ||
>> +	    tot_size >= TCP_BPF_GSO_SIZE || ingress_msg_empty ||
>> +	    (!(nonagle & TCP_NAGLE_CORK) && (nonagle & TCP_NAGLE_OFF))) {
>> +		release_sock(sk);
>> +		psock->backlog_work_delayed = false;
>> +		sk_psock_backlog_msg(psock);
>> +		lock_sock(sk);
>> +	} else {
>> +		sk_psock_run_backlog_work(psock, false);
>> +	}
>> +
>> +error:
>> +	sk_psock_put(sk_redir, psock);
>> +	return ret;
>> +}
>> +
>>   static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   				struct sk_msg *msg, int *copied, int flags)
>>   {
>> @@ -442,18 +619,24 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   			cork = true;
>>   			psock->cork = NULL;
>>   		}
>> -		release_sock(sk);
>>   
>> -		origsize = msg->sg.size;
>> -		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
>> -					    msg, tosend, flags);
>> -		sent = origsize - msg->sg.size;
>> +		if (redir_ingress) {
>> +			ret = tcp_bpf_ingress_backlog(sk, sk_redir, msg, tosend);
>> +		} else {
>> +			release_sock(sk);
>> +
>> +			origsize = msg->sg.size;
>> +			ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
>> +						    msg, tosend, flags);
> 
> nit, we can drop redir ingress at this point from tcp_bpf_sendmsg_redir?
> It no longer handles ingress? A follow up patch would probably be fine.
> 

Indeed, we will do this in a follow up patch.

>> +			sent = origsize - msg->sg.size;
>> +
>> +			lock_sock(sk);
>> +			sk_mem_uncharge(sk, sent);
>> +		}
>>   
>>   		if (eval == __SK_REDIRECT)
>>   			sock_put(sk_redir);
> 
> Thanks.

Thanks for the review!


