Return-Path: <bpf+bounces-43357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D989B3FB8
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990CA1F22B1A
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131647F53;
	Tue, 29 Oct 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEa3CK4c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9826289;
	Tue, 29 Oct 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165067; cv=none; b=cR+efO5M1cBYRGjj4dssWYLSQ0WiGAtIFrgs4HUy1YmC/5qfILNAhu5s4oQdwRWkYgKT8C4ik/9fEWZZrajxa5JrU0raSnStkRN0qGRtgsnQVVN5Gq8ZF+7Cwc3RIYlPLTeNuuBuFBUbVRbawB1j8LekWKuitMQg2BrPxdDcvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165067; c=relaxed/simple;
	bh=ytFWwk7jXC/P4HVfSyxAWCKqTM9/laBpuzv3n79BRs0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D+nhh0KR3pT+kgmsCZn9kg8987WAE6XIYU7P6Rnx81rCq8VdSN/0j+OIZp/5FoLct7SA7OSwyQ3797Y+Zi9Hj6E3NSeLG+qegbNBjuFgjW46CDFYE1aP8ZfBd2tu7K5tfq5JFVhrXfRVfF6uGgizUl390mEi/nFrR1KWsIJHtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEa3CK4c; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46094b68e30so36698361cf.0;
        Mon, 28 Oct 2024 18:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730165064; x=1730769864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soHeqvAnPFTUxu7+JQcDtlQRPi6VEx/QPfyZVJL0Zvw=;
        b=GEa3CK4cKFaXkgy5RbtIO41H0cm5jkOc624Z/neZq470tUCAhqV2/AN4ZB0ZDUGZWO
         U4tQWMB5DEXRr1YUOQMkcidBke1LRGpxCCcGAxdYkbylepncmAzCPDRhstjyoiQZw5xT
         7k0LZt0dkKZuWxwqeNQ0XvlfUEQxxYReQmoaT8xRwuGqV8vg2Riav1GSDTGlnkqjVVLe
         6kVB5ytufcATLMpKUxIXnLBOkLqe9C1BRarmatNf07E5Dyg2xSK/mgQ/GUq5Lp6y4jDX
         IkPrqIY0nSF5nJHU+CqKcd76IT4vheUWvzBhOu16PClWRV13ITkxnqJ6iF3CP/G744Qu
         SpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165064; x=1730769864;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=soHeqvAnPFTUxu7+JQcDtlQRPi6VEx/QPfyZVJL0Zvw=;
        b=kj5e9dr60VQ8+em6rSKj9gpPQXB6LSBQEqSVSgkxf42yjs7YIBH+7bsSEc0dTDEhmY
         e0t+4RchtKh1NR2aF5kH35D/PCr+heb5ZKEjbtYBC8wUIEDU8JSF6latMRziKYx7nduk
         RN7VFEdjvIpeAwGt1tz/0j2/OkCNoZAWcrzgxtA3hajdezx1xLJvH6qXhx+UyN/fksfj
         BmobB5I3WcQ4m+zst1ueMQju4LtkLcquiLZz28t28UOYcBMgtJz/OpeCO6DOkAJRWpx2
         UGlRzjaDUwLMEfq2oVjlqDnBRUESvu2+1PK6MSLCRoXPC8ubCAiGraFySgewRypCHwnv
         612w==
X-Forwarded-Encrypted: i=1; AJvYcCVEAvLJyO3VwVLz8+qKPafwsbiHQ3gRx1Xd52/Sopn7tZkzgxcoc8cUmH7THLxxmNHsZF2V04U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBdYGmdqi6AKFiBfexUt/kG5PDc/gPmkGZRnCHrABYUh66jy9
	uPuB2V3TBMOCcWm1GnFUh+3kIferGN2oUkSL2WEbhKHKAPfHLrsN
X-Google-Smtp-Source: AGHT+IGDnQYkkJMuUpQ6TlU6ovtwTTBKM3xDokprf5/+tD76pAqvpx+U+kAvCsag6AvYCfxso6zRmw==
X-Received: by 2002:ac8:5a56:0:b0:460:ac3e:cf6 with SMTP id d75a77b69052e-4613c1bacb7mr162122271cf.53.1730165064120;
        Mon, 28 Oct 2024 18:24:24 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613214d597sm40238641cf.37.2024.10.28.18.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:24:23 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:24:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6720394714070_24dce62944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241028110535.82999-11-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Use the offset to record the delta value between current socket key
> and bpf socket key.
> 
> 1. If there is only bpf feature running, the socket key is bpf socket
> key and the offset is zero;
> 2. If there is only traditional feature running, and then bpf feature
> is turned on, the socket key is still used by the former while the offset
> is the delta between them;
> 3. if there is only bpf feature running, and then application uses it,
> the socket key would be re-init for application and the offset is the
> delta.

We need to also figure out the rare conflict when one user sets
OPT_ID | OPT_ID_TCP while the other only uses OPT_ID.

It is so obscure, that perhaps we can punt and say that the BPF
program just has to follow the application preference and be aware of
the subtle difference.

> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/sock.h |  1 +
>  net/core/skbuff.c  | 15 ++++++++---
>  net/core/sock.c    | 66 ++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 68 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 91398b20a4a3..41c6c6f78e55 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -469,6 +469,7 @@ struct sock {
>  	unsigned long		sk_pacing_rate; /* bytes per second */
>  	atomic_t		sk_zckey;
>  	atomic_t		sk_tskey;
> +	u32			sk_tskey_bpf_offset;
>  	__cacheline_group_end(sock_write_tx);
>  
>  	__cacheline_group_begin(sock_read_tx);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0b571306f7ea..d1739317b97d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5641,9 +5641,10 @@ void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>  }
>  
>  static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype,
> +				     struct sk_buff *skb,
>  				     struct skb_shared_hwtstamps *hwtstamps)
>  {
> -	u32 args[2] = {0, 0};
> +	u32 args[3] = {0, 0, 0};
>  	u32 tsflags, cb_flag;
>  
>  	tsflags = READ_ONCE(sk->sk_tsflags_bpf);
> @@ -5672,7 +5673,15 @@ static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype,
>  		args[1] = ts.tv_nsec;
>  	}
>  
> -	timestamp_call_bpf(sk, cb_flag, 2, args);
> +	if (tsflags & SOF_TIMESTAMPING_OPT_ID) {
> +		args[2] = skb_shinfo(skb)->tskey;
> +		if (sk_is_tcp(sk))
> +			args[2] -= atomic_read(&sk->sk_tskey);
> +		if (sk->sk_tskey_bpf_offset)
> +			args[2] += sk->sk_tskey_bpf_offset;
> +	}
> +
> +	timestamp_call_bpf(sk, cb_flag, 3, args);


So the BPF interface is effectively OPT_TSONLY: the packet data is
never shared.

Then OPT_ID should be mandatory, because it without it the data is
not actionable: which byte in the bytestream or packet in the case
of datagram sockets does a callback refer to.

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

Please explain in the commit message that these gymnastics are needed
because there can only be one tskey in skb_shared_info.

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
> +
>  int sock_set_tskey(struct sock *sk, int val, int bpf_type)
>  {
>  	u32 tsflags = bpf_type ? sk->sk_tsflags_bpf : sk->sk_tsflags;
> @@ -901,17 +944,13 @@ int sock_set_tskey(struct sock *sk, int val, int bpf_type)
>  
>  	if (val & SOF_TIMESTAMPING_OPT_ID &&
>  	    !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> -		if (sk_is_tcp(sk)) {
> -			if ((1 << sk->sk_state) &
> -			    (TCPF_CLOSE | TCPF_LISTEN))
> -				return -EINVAL;
> -			if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> -				atomic_set(&sk->sk_tskey, tcp_sk(sk)->write_seq);
> -			else
> -				atomic_set(&sk->sk_tskey, tcp_sk(sk)->snd_una);
> -		} else {
> -			atomic_set(&sk->sk_tskey, 0);
> -		}
> +		long int ret;
> +
> +		ret = sock_calculate_tskey_offset(sk, val, bpf_type);
> +		if (ret <= 0)
> +			return ret;
> +
> +		atomic_set(&sk->sk_tskey, ret);
>  	}
>  
>  	return 0;
> @@ -956,10 +995,15 @@ static int sock_set_timestamping_bpf(struct sock *sk,
>  				     struct so_timestamping timestamping)
>  {
>  	u32 flags = timestamping.flags;
> +	int ret;
>  
>  	if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
>  		return -EINVAL;
>  
> +	ret = sock_set_tskey(sk, flags, 1);
> +	if (ret)
> +		return ret;
> +
>  	WRITE_ONCE(sk->sk_tsflags_bpf, flags);
>  
>  	return 0;

I'm a bit hazy on when this can be called. We can assume that this new
BPF operation cannot race with the existing setsockopt nor with the
datapath that might touch the atomic fields, right?


