Return-Path: <bpf+bounces-59371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4256AAC9659
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E919A17352F
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771352820D4;
	Fri, 30 May 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nniwo4Mi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC523815C;
	Fri, 30 May 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748635672; cv=none; b=pnRrLUiPH/AZz11ft3g8kr4YS7aMkGF0mT/vUGie6DAIbFidPiI5IhOr6y1mLfZFUgz1/ps6GQYQtoibWPpeI354KS8iCIkoJlrphl8EU+y/x5HSELZhUxoFlAjgK8r47zER4bOYpgElnqYdjr9VaPxvQ3kcokuCYnt4OxNXcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748635672; c=relaxed/simple;
	bh=ct6SQwoevQtBGTGnt34VdrBpbpGOKC4SFkv6MHopodI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtHBKV66XXy0JBpkhssazu7yP8BtnKzBZHHPQ3sXDIkOV+BEySg0x6wCJEy6I/gSVJAI4UvdJuHDj+JULrzxukl0rtFg4PXc9Wg/fZQ/ZWS7duzEoGYKSITckCNEsdRxuIpKGN+O1wY4Xeu44mfoxpuJCYa+gA7Ufz8qeigKubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nniwo4Mi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33677183so21430235ad.2;
        Fri, 30 May 2025 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748635670; x=1749240470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qrAgajVEjl6XH/LWK60rQI6fj3/gwI++K2zKdM+P6M=;
        b=Nniwo4MiTz1vHtWo8xk629bk72iPsCDfh2DIzGCFOEm7o7oJWBSpePBgCVKyH6iMRU
         R1kpp9XE9Km48zvkgZlc9YlZhnAW469UYO2PbrZSGXEurDU++qxz4Am3Wftt0M9kH18z
         /pv+w+Ufs4h/43RnxZWUW9zlbpIm3PWoaSRY1jba4azUa3rUWGjtGr+6nHq93++pDbXh
         rSc9pqG175kBYyMP3lZ2ve/sMGTqOGV8bDrGpWCS3CaVaQpaSrxrjRvFW+ch+U0PY9RI
         wlKmHOYFISOjXJ8Plv5gQeTOGm39rdNfHucj1zcVeo7X6jYOylkpsnZZNrsBHrCqmA4v
         OrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748635670; x=1749240470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qrAgajVEjl6XH/LWK60rQI6fj3/gwI++K2zKdM+P6M=;
        b=fv+iEbGM2uqmSADfoUjJUAbqdDJGZt1IDM85O0xmTtJwBrrs2KLVk8rAXJW6Cu9wNl
         NPP4LU9ahp6FB5H8C/aikNfHRxdDkz1cwGzJD+pyAaXtEX/73Bu0cE6XzFXB3veIjGVv
         l6hqAh7LFcf0WWPzXIezDlb/pQZKBJk+GmcgyFT2h27FSkpgwh1eytwWMb6KcuQPzcpw
         jZD/+kBb6WQzjuDO4n8Iw2APL6zwjbW+HXzyjhDSSTSEzo11vxBKuGvyxuSlppq+da1k
         yHGXows8QI7aso4von/kR+wn5Bp1n4bJDY6vf4gcfH2vA5ZC5FvixI7l5K67ZRwnksEd
         CGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUkBjRgu3WyWGeB05/MoprjpYJ50W7dgqgTizqBf2v69H+3v8GAfqYlKIX7tyKhWuMK9hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bETX2I0P2HvVdCEJXQ2lTJtunO7SkkMsJfq1KxBf9jVlfcis
	cMLGnh9CMUv5sekGAx05coZLBZrzulbsz5GZwWMISw1HyJB5cAZ54lU48ERCx1jG
X-Gm-Gg: ASbGnctGducuXCAG7lnPDukBLaXKLrU/dyCjp7vuAN9oAoSS6EhH0eIqq0oBqd3DPZ4
	iLPrRAGbYpKA7BoWndr9k2gsv98zi6YoHlfWo1g0WItlpKtt5WiULl7rhEek9lTlCfAuhCQSWd/
	k4LfQnSSN6Pd9DLTpXoD0YUIIpeWE+2GgQAoWE5RFXXqCedamlAteejkFmooseGn54mNhAwWP0o
	mK6QYZuWcRsKCvXPGK9nzV0iXbNxval8RSLBG6n2K5ieRaNc0gMtYoRxQIoxoPZJnfzfRkV6GEq
	QlOuBGrKDrtBCZsDY/VlSrd40pnDQil4DDk0O7iRVb1uhX+r7B9f2kngZEWwTCs=
X-Google-Smtp-Source: AGHT+IExqgS+QiIQaRgj6w2lMgt6QAD99sUUI7RmE+T/GB4UUMprWxGVBVKpKwR+Nz7Wap5PPwNzrg==
X-Received: by 2002:a17:902:f54a:b0:234:d292:be84 with SMTP id d9443c01a7336-23538ed9508mr54534975ad.10.1748635669584;
        Fri, 30 May 2025 13:07:49 -0700 (PDT)
Received: from gmail.com ([98.97.39.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14cb0sm32114995ad.218.2025.05.30.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 13:07:49 -0700 (PDT)
Date: Fri, 30 May 2025 13:07:35 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com, zijianzhang@bytedance.com,
	Amery Hung <amery.hung@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v3 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
Message-ID: <20250530200735.hhzeicomnb7mbwdl@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-5-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519203628.203596-5-xiyou.wangcong@gmail.com>

On 2025-05-19 13:36:28, Cong Wang wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> The TCP_BPF ingress redirection path currently lacks the message corking
> mechanism found in standard TCP. This causes the sender to wake up the
> receiver for every message, even when messages are small, resulting in
> reduced throughput compared to regular TCP in certain scenarios.
> 
> This change introduces a kernel worker-based intermediate layer to provide
> automatic message corking for TCP_BPF. While this adds a slight latency
> overhead, it significantly improves overall throughput by reducing
> unnecessary wake-ups and reducing the sock lock contention.
> 
> Reviewed-by: Amery Hung <amery.hung@bytedance.com>
> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---
>  include/linux/skmsg.h |  19 ++++
>  net/core/skmsg.c      | 139 ++++++++++++++++++++++++++++-
>  net/ipv4/tcp_bpf.c    | 197 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 347 insertions(+), 8 deletions(-)

[...]

> +	/* At this point, the data has been handled well. If one of the
> +	 * following conditions is met, we can notify the peer socket in
> +	 * the context of this system call immediately.
> +	 * 1. If the write buffer has been used up;
> +	 * 2. Or, the message size is larger than TCP_BPF_GSO_SIZE;
> +	 * 3. Or, the ingress queue was empty;
> +	 * 4. Or, the tcp socket is set to no_delay.
> +	 * Otherwise, kick off the backlog work so that we can have some
> +	 * time to wait for any incoming messages before sending a
> +	 * notification to the peer socket.
> +	 */


OK this series looks like it should work to me. See one small comment
below. Also from the perf numbers in the cover letter is the latency
difference reduced/removed if the socket is set to no_delay?

> +	nonagle = tcp_sk(sk)->nonagle;
> +	if (!sk_stream_memory_free(sk) ||
> +	    tot_size >= TCP_BPF_GSO_SIZE || ingress_msg_empty ||
> +	    (!(nonagle & TCP_NAGLE_CORK) && (nonagle & TCP_NAGLE_OFF))) {
> +		release_sock(sk);
> +		psock->backlog_work_delayed = false;
> +		sk_psock_backlog_msg(psock);
> +		lock_sock(sk);
> +	} else {
> +		sk_psock_run_backlog_work(psock, false);
> +	}
> +
> +error:
> +	sk_psock_put(sk_redir, psock);
> +	return ret;
> +}
> +
>  static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  				struct sk_msg *msg, int *copied, int flags)
>  {
> @@ -442,18 +619,24 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  			cork = true;
>  			psock->cork = NULL;
>  		}
> -		release_sock(sk);
>  
> -		origsize = msg->sg.size;
> -		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
> -					    msg, tosend, flags);
> -		sent = origsize - msg->sg.size;
> +		if (redir_ingress) {
> +			ret = tcp_bpf_ingress_backlog(sk, sk_redir, msg, tosend);
> +		} else {
> +			release_sock(sk);
> +
> +			origsize = msg->sg.size;
> +			ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
> +						    msg, tosend, flags);

nit, we can drop redir ingress at this point from tcp_bpf_sendmsg_redir?
It no longer handles ingress? A follow up patch would probably be fine.

> +			sent = origsize - msg->sg.size;
> +
> +			lock_sock(sk);
> +			sk_mem_uncharge(sk, sent);
> +		}
>  
>  		if (eval == __SK_REDIRECT)
>  			sock_put(sk_redir);

Thanks.

