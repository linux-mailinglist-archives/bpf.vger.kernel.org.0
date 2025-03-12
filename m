Return-Path: <bpf+bounces-53915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE5A5E38E
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13CD7AC9D6
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704624E4DB;
	Wed, 12 Mar 2025 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aMUEVgNc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A21D95A9
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803609; cv=none; b=Ltq0uvQJMJ6xI9xo5nXDJBhscQw90MxZJoKsiItpHv5pE1yJjAOKW7BbqV8gbptJZzdONtiPohX/E5Tdlp6H7ESzGa/qByYOD9mt7jszBuqzoFYpy8MZvqzIjK3RdyvLUCwfb5dx83kHVZfaFv/yK9Wn2/HBlucd3MhFyYBDvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803609; c=relaxed/simple;
	bh=rVUmbO8wiVYpIIu+TAjlB1KoeGAG/thfpfVBxacDC3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go+iak4/xRimN0pz+znaFQudsMKc4Nc7cjhtizvM7KlfdocpNbTD68Q4W2VggeYzya8p5h2E8ODSMSTdJZHpcd/z537HCv3lPY1jiYeacXZaXFhLfXWJdgNunwrU8IjEpxoPQq2El130bbG0YMhsja1ZIS4//9ZKx0oca9dbI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aMUEVgNc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd1962a75bso1535026d6.3
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741803606; x=1742408406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JwrN6uiLsrlYFwVv4j7Y1nmGn+uYAElg71voRA6Tt8=;
        b=aMUEVgNcjpW2wh5DN54ySRLLfz9jqZfYZ8r+yiaBkZGmhiqSLAa3bJZPAIg6MxLDwF
         Yg45UuMiIN9FzYKoUvt5n9Hd+rsGfP3EgCFEXyFhvVKBQYuGmBg694sdt9dgN2b+chr/
         par7InLm7biuNsTHQOfxH5bzBY8CUWHiq+oT4Ko890d2fI6iEkyjW5RChWGOpCkJCfH5
         wIrE1DIDi8DhOmr2mFVFzo6XwLC8hElewBhfxDbdZ0u9wegWIJr4oYSq2lub56TCW7Yu
         4bi8xaFr/rLfS6muHcZ2vRHQY1zXw4rRlyS4VjJK6lWbQErnRMFHortK9w5IYJpidpBm
         H1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741803606; x=1742408406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JwrN6uiLsrlYFwVv4j7Y1nmGn+uYAElg71voRA6Tt8=;
        b=KaQPnfPxK0vDFciNLJ2uYZMVpgFji2Y6AYdvMFcAlfbsedbSQqIZAfVJCnuUEqCeGJ
         vl+bSI00Ktm5tNHD3yIUoLF8y1BYKdAy4etzzZKI5js4gXfVUgDd3US1y/s40FjQyXCu
         edKOOaw/1AwvRNAp8lb4Jzf+bTMpAbKAFn62m+rPPKsWN5EH5lKpy7CnG+CwMguMcao4
         Zony6c6ybWYE9P5UyVJt3AgOcTsVtrjxU5s/TcTwD2HBk6m0D1lIOFCgmLVJgE4FUO7a
         ctqhDX/b0ALfmwZ69AHZzjUSrcWlZTKRDtK6EuSJT9+Ud7KpHjY1NHBQAzAt7xTo6VKI
         3Xbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4OtWMMGekYHnBNUvo/rrmoOzkvJxlO8KH3SDpYjPDIFzDM4ombL+O3Y9lWWDli9jTN28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxixi/hzSxmzzsBsNo+QLwJ48EKBorXmWoyXt0v0A7oddjZsZF
	W4/PGCFrHskeUP6DLmjqF8HyNS/7fIKVvR/XdXkmRGW3yBq+6VhS/MhPI21pwiU=
X-Gm-Gg: ASbGncsZNjIPwAWdL2aR0pMTz0y5OTeJnRQIQvtaBIizO8Yn9xKl/aWTV+Wml2eCkxg
	sfCcJuqs9SVzPZi7+pkw1QeRMeK1FcWDiENi7ErfJx3PemwIg4f3wRh85DABDcXR5KaYD4s93k4
	0HxVHFyLhgGqlJnmdu3cCgTF0kPGn8mwKG5Pdp4b/EQx+TJ0QML/CGkIdV/ycMY5k38SxUZxgAi
	8CGJwSiLT6Lz+fiuCJeDRbO9Z+pRG6rDXFjEdaNsz4eBwXXEo34Y6xyfwm/ZXEEnrDT2Shy/Dw+
	f+eL8kWg4P/QpiJb6fp/mttBqEGewE5ilpPJmxIZ+jk6OXBVnYTAzqNa3qnseu1/MEKCgw==
X-Google-Smtp-Source: AGHT+IEmL1ZCGCLBq4/ccG5tQuyBD78RHYaCGzXZEzlXPe74r3o7UyCro4raW+D1b13M4Wt/YQDAlQ==
X-Received: by 2002:a05:6214:c83:b0:6e4:7307:51c6 with SMTP id 6a1803df08f44-6e90066b6famr409431866d6.34.1741803604661;
        Wed, 12 Mar 2025 11:20:04 -0700 (PDT)
Received: from [10.73.223.214] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b809sm87107766d6.79.2025.03.12.11.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 11:20:04 -0700 (PDT)
Message-ID: <dffb3057-40cf-463b-a114-9c9c3770f09c@bytedance.com>
Date: Wed, 12 Mar 2025 11:20:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v2 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
To: John Fastabend <john.fastabend@gmail.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
 zhoufeng.zf@bytedance.com, Amery Hung <amery.hung@bytedance.com>,
 Cong Wang <cong.wang@bytedance.com>
References: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
 <20250306220205.53753-5-xiyou.wangcong@gmail.com>
 <20250311205426.h3rvfakthoa6usgr@gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20250311205426.h3rvfakthoa6usgr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 1:54 PM, John Fastabend wrote:
> On 2025-03-06 14:02:05, Cong Wang wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
[...]
>> +static int tcp_bpf_ingress_backlog(struct sock *sk, struct sock *sk_redir,
>> +				   struct sk_msg *msg, u32 apply_bytes)
>> +{
>> +	bool ingress_msg_empty = false;
>> +	bool apply = apply_bytes;
>> +	struct sk_psock *psock;
>> +	struct sk_msg *tmp;
>> +	u32 tot_size = 0;
>> +	int ret = 0;
>> +	u8 nonagle;
>> +
>> +	psock = sk_psock_get(sk_redir);
>> +	if (unlikely(!psock))
>> +		return -EPIPE;
>> +
>> +	spin_lock(&psock->backlog_msg_lock);
>> +	/* If possible, coalesce the curr sk_msg to the last sk_msg from the
>> +	 * psock->backlog_msg.
>> +	 */
>> +	if (!list_empty(&psock->backlog_msg)) {
>> +		struct sk_msg *last;
>> +
>> +		last = list_last_entry(&psock->backlog_msg, struct sk_msg, list);
>> +		if (last->sk == sk) {
>> +			int i = tcp_bpf_coalesce_msg(last, msg, &apply_bytes,
>> +						     &tot_size);
>> +
>> +			if (i == msg->sg.end || (apply && !apply_bytes))
>> +				goto out_unlock;
>> +		}
>> +	}
>> +
>> +	/* Otherwise, allocate a new sk_msg and transfer the data from the
>> +	 * passed in msg to it.
>> +	 */
>> +	tmp = sk_msg_alloc(GFP_ATOMIC);
>> +	if (!tmp) {
>> +		ret = -ENOMEM;
>> +		spin_unlock(&psock->backlog_msg_lock);
>> +		goto error;
>> +	}
>> +
>> +	tmp->sk = sk;
>> +	sock_hold(tmp->sk);
>> +	tmp->sg.start = msg->sg.start;
>> +	tcp_bpf_xfer_msg(tmp, msg, &apply_bytes, &tot_size);
>> +
>> +	ingress_msg_empty = list_empty(&psock->ingress_msg);
>> +	list_add_tail(&tmp->list, &psock->backlog_msg);
>> +
>> +out_unlock:
>> +	spin_unlock(&psock->backlog_msg_lock);
>> +	sk_wmem_queued_add(sk, tot_size);
>> +
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
> I think this could also be used to get the bpf_msg_cork_bytes working
> directly in receive path. This also means we can avoid using
> strparser in the receive path. The strparser case has noticable
> overhead for us that is significant enough we don't use it.
> Not that we need to do it all in one patch set.
> 

Sounds promising!

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
> 
> The only sticky bit here that is blocking folding this entire tcp_bpf_sendmsg_redir
> logic out is tls user right?
> 

Right, tls also uses tcp_bpf_sendmsg_redir.

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
> now sendmsg redir is really only for egress here so we can skip handling
> the ingress here. And the entire existing sk_psock_backlog work queue because
> its handled by tcp_bpf_ingress_backlog?
> 

Agreed, tcp_bpf_sendmsg_redir here is only for egress.

 From my understanding,
as for sk_psock_backlog, it handles the ingress skb in psock-
 >ingress_skb.
[skb RX->Redirect->sk_msg(skb backed-up) RX]

On the other hand, tcp_bpf_ingress_backlog mainly focus on moving the
corked sk_msg from sender socket queue "backlog_msg" to receiver socket
psock->ingress_msg. These sk_msgs are redirected using __SK_REDIRECT
by tcp_bpf_sendmsg, in other words, these sk_msg->skb should be NULL.
[sk_msg TX->Redirect->sk_msg(skb is NULL) RX]

IMHO, they are mostly mutually independent.

>> +			sent = origsize - msg->sg.size;
>> +
>> +			lock_sock(sk);
>> +			sk_mem_uncharge(sk, sent);
>> +		}
> 
> I like the direction but any blockers to just get this out of TLS as
> well? I'm happy to do it if needed I would prefer not to try and
> support both styles at the same time.

I haven't looked into TLS mainly because I'm not very familiar with it. 
If you're interested, it would be great if you could take a look in the
future :)


