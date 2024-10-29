Return-Path: <bpf+bounces-43353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825259B3F91
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42635283667
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198CA15B0F7;
	Tue, 29 Oct 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWdUUMSG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6247F53;
	Tue, 29 Oct 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164071; cv=none; b=KezKBhJNbg1ii0acm1pGIqrO8A+S87T8z6pXL35EnmwrlLrU6rZjKwapJKRhGQsuGYYno7tGnFCRPl1AGatkOJCWl+G2+1t9ia1gAfcx7A881arNddMGmIpJtTGkuCAFUPAg+53TQgW26XrXZUdZfh6o9krTqEebvsFodn/JNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164071; c=relaxed/simple;
	bh=lCKmel2gg4yHLuTLnQQJTo768bUxPieuTBoYAzBi99c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g2s3M88NfCt5TuOa6jvejPbU/XAP6GPrq3NSb4dGCHRv2LzCN9MirUKSKgwsmNXekJQGkT7j6M4I/Y9mfbBu1MYqVx88xwIHpmlcI9fkQEVuJBDAUfel3VUCgIFdXPMB6moP+2/X81h2sUW/01FNZMLGa9f7rJJPL6xwGota/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWdUUMSG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460e6d331d6so28769611cf.2;
        Mon, 28 Oct 2024 18:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730164068; x=1730768868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AVwrzMEZZusvuwhJOBAIrEojmvlAlr3tlvhBYA+fb8=;
        b=bWdUUMSGCBZOfDgN7joxGfchU1cvNxoNuzxg9JkFXG6oE/ei9EoyNy8ZznFdKtaYDJ
         POWnrY5M8MqvTvOelgChg++Rg/f39n8+C81WU0kQQ0jWwBbkzsJOXbbXrfZ9mUegitgr
         Uum3GTWiZLqmwYIa3KyvlCRDHMH2uzHU7zE8Gjg3/C8pp+wYy1JclYMzQArGwozCxSeR
         dfLkW/K3OfCGWW+9kU7n+TMZMnQv8gMMVOkkuNjIs9245vSdy7YEFL9YxAm0v+qbYdqI
         gGyYXrfzbadgBwzkWhV36uhVUJnJMqvMLZSwePEnuEDSPBDPtHgUxREGI2d2xVZkls/R
         LlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730164068; x=1730768868;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2AVwrzMEZZusvuwhJOBAIrEojmvlAlr3tlvhBYA+fb8=;
        b=GiliV86L1BzxYORRxNcdOCBg6ZIomLNbGBKV14iF2BaR621mXzfgPo14yLjzNAighn
         FDrmLMSXpjoIBVG0iPH7Fe05NMETYuaUSQ/0xVSu33rotI1EHnLwghNWvUpJyP8YwpSv
         Si1Nq1Fc5rWJgGKP5pmMvTCXE6eijk0XQVPKl1m4BWAjhQDoh9JYk2Ds2eHcbQgqRJ36
         0yk/hcl5ICiN1A9O2v2pHmgHWiZzqXoux6oo4LSOucvhEIQ0x89RDSQdtkVMPDl+PUAF
         vJQro4BaYZ1jN36Vze96I1vRgxthxey7pq2Iy8zI1rq6NQRAHBIB9hYFVIuRlSADm/s9
         cFbA==
X-Forwarded-Encrypted: i=1; AJvYcCVTxSTnNp1wLAAS9LuvZqRs8oaxRdI2SRQtJjpKH3eeOoPgzDdDkaPBgmpXZB6B8c1NFP8oEB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywll/aXw7ZqdildsGAPT/f4BToY/I4QqS0ekXvKw5JFYhSDodiS
	dhkPgXiXUz5c7W4+re3j7kKFJe9FwOi77JB4/w3sSTHD0FIgJ4h9
X-Google-Smtp-Source: AGHT+IE/9RdLk9gPPQby8A/bUOadVjYbWeh+B8o4kWQXC0UYhKb2WvQ0s6F1lLH0yD1Kfg8k8qtCww==
X-Received: by 2002:a05:622a:579b:b0:461:5b0d:7918 with SMTP id d75a77b69052e-4615b0d7a59mr50862311cf.6.1730164068101;
        Mon, 28 Oct 2024 18:07:48 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132381501sm40136901cf.76.2024.10.28.18.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:07:47 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:07:47 -0400
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
Message-ID: <6720356328c26_24dce6294ce@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241028110535.82999-8-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-8-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 07/14] net-timestamp: add a new triggered
 point to set sk_tsflags_bpf in UDP layer
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
> This patch behaves like how cmsg feature works, that is to say,
> check and set on each call of udp_sendmsg before passing sk_tsflags_bpf
> to cork tsflags.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/sock.h             | 1 +
>  include/uapi/linux/bpf.h       | 3 +++
>  net/core/skbuff.c              | 2 +-
>  net/ipv4/udp.c                 | 1 +
>  tools/include/uapi/linux/bpf.h | 3 +++
>  5 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 062f405c744e..cf7fea456455 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2828,6 +2828,7 @@ static inline bool sk_listener_or_tw(const struct sock *sk)
>  }
>  
>  void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
> +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args);
>  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
>  		       int type);
>  
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6fc3bd12b650..055ffa7c965c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7028,6 +7028,9 @@ enum {
>  					 * feature is on. It indicates the
>  					 * recorded timestamp.
>  					 */
> +	BPF_SOCK_OPS_TS_UDP_SND_CB,	/* Called when every udp_sendmsg
> +					 * syscall is triggered
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8b2a79c0fe1c..0b571306f7ea 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5622,7 +5622,7 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>  	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
>  }
>  
> -static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
> +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>  {
>  	struct bpf_sock_ops_kern sock_ops;
>  
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 9a20af41e272..e768421abc37 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1264,6 +1264,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	if (!corkreq) {
>  		struct inet_cork cork;
>  
> +		timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB, 0, NULL);
>  		skb = ip_make_skb(sk, fl4, getfrag, msg, ulen,
>  				  sizeof(struct udphdr), &ipc, &rt,
>  				  &cork, msg->msg_flags);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 6fc3bd12b650..055ffa7c965c 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7028,6 +7028,9 @@ enum {
>  					 * feature is on. It indicates the
>  					 * recorded timestamp.
>  					 */
> +	BPF_SOCK_OPS_TS_UDP_SND_CB,	/* Called when every udp_sendmsg
> +					 * syscall is triggered
> +					 */

If adding a timestamp as close to syscall entry as possible, give it a
generic name, not specific to UDP.

And please explain in the commit message the reason for a new
timestamp recording point: with existing timestamping the application
can call clock_gettime before (and optionally after) the send call.
An admin using BPF does not have this option, so needs this as part of
the BPF timestamping API.


>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> -- 
> 2.37.3
> 



