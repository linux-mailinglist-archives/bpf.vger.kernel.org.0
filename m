Return-Path: <bpf+bounces-41287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA5995731
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FE41C23B05
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583AC212F16;
	Tue,  8 Oct 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZsUIaEb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8141E0DBC;
	Tue,  8 Oct 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413610; cv=none; b=a+iWL906WApo90lhxTHUSJsV8hq5WmU8WcV3kIBYXHuYgmRMooSfYc7ETvGVf2J6Ik5cKgofCN27vO0QKd4R/cQRu5h790YOZdCZASvjbj6a9uU6NKb41L0hiqaNQaT/b5ADGfD7Mq7VSshEWZCyZ4Z1XZ38wcPd0ZKWvWqNDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413610; c=relaxed/simple;
	bh=KGoNBJ/yrsPNDVuXg/ycecnzbr5CFED/NOXAMtue9hE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CsqByaZJscfQpiYmIF/uUXeShLsoXa9sGlJlCKZLDEGmrQ47RffZITSdCfXnpvBedHhX5XOPIcnW/EMe3NdGwqEZxswPAWcnENpJauodvVK+znxKUPQeq/cSG+LFFZ0AqydkHujfkms1hILMytDVOJuv2kJbtu2R7oZWnR1zI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZsUIaEb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbbe3f6931so9192236d6.0;
        Tue, 08 Oct 2024 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728413608; x=1729018408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XGyoBfuElsWyctT3u1Z9dYYx4xNAXCTSvtWmXn5PB8=;
        b=cZsUIaEbHm4fUHk2xnFqwK27HXnIEM5VMLpI7ORRYpFvLTMSmA3OX3Dc1WdpTphXXJ
         VBEeAGTo5Q0WqQgy35nrYLzb5DzSZiSU+sIVpGuVEF/HPuyCqaU4LmHCklUU7Ss+bVoE
         XNG9BFmOY1UXPYQCyya5+9bXvFpVhw38QNkVIcO0Bhky0hXLpqaf70xMQcYjMZSRy3vj
         326IH/Fd91V/AloJCSn9Z90A6S9A/UqDjuR8cR9qNps5P7zN3uWubabLp/cUyAzLvuHS
         zxMryY1NyvsxDxMQvchAwTIFALfnJqXO5AkY7TpPE2dpzl0xSTKuP/xs9v6IU95gBy0R
         THEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728413608; x=1729018408;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2XGyoBfuElsWyctT3u1Z9dYYx4xNAXCTSvtWmXn5PB8=;
        b=Ief3XlK4aAYOBzpmsWaJB9JGuY+J04xXvdgfjCCWnYT/nRe+4g5xAUJmVn+y4A9qUK
         bNgjicCrOZ1xaSdjPMu0f5+tOsgOGeV2Ut006YRvpqrJpTbngtC9RpjxIMdvZHca0JGI
         SUtVBMnWVy+Mv6PJ0UxNwZvPkewvBOMzSZ1E07E00zZbbMU1NU3FXEbIQCgkq4+YLhCB
         fBM1NsUOe1hxnqhcNB6tIfn7K9qTKYMmrf77TE09kd+kLcENLOjUrdLPzhG1yHsmAWOT
         zNn63djeHy7UeKlB2sQeGLNTH6x8F5dSgE3tja3CBMHRnnLZ74Jdicv4vXxg4FIDrcp8
         r4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVDQ93aeR+TfV2S5tO0rkAqR+bhZrYVjT2VDFbJfkh3FqNftPaR+f2fTS1lfcHJYpm7hbJXcuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZWAMtNhkEVRLTZUf3NPSNe2ldTSCdxPTh2X0Ow8auJi/iZOa
	H/vTvJRr/PTkh7UlFoxI+jXGLa4JypkmIInZJ3wSlf+iJHXJNo6s
X-Google-Smtp-Source: AGHT+IFg6z2xnHs42GOM8zNIfptNFPO8BIaao6dI79HbBSfM6bwCG9m0B8S/M92lvOeML3N5lobXEw==
X-Received: by 2002:a05:6214:3c9d:b0:6c3:643d:3b with SMTP id 6a1803df08f44-6cb9a491b1cmr295120706d6.42.1728413608109;
        Tue, 08 Oct 2024 11:53:28 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4773f41sm37455176d6.142.2024.10.08.11.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:53:27 -0700 (PDT)
Date: Tue, 08 Oct 2024 14:53:27 -0400
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
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67057fa71f8a9_1a41992946d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008095109.99918-6-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-6-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 5/9] net-timestamp: ready to turn on the button
 to generate tx timestamps
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
> Once we set BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG flag here, there
> are three points in the previous patches where generating timestamps
> works. Let us make the basic bpf mechanism for timestamping feature
>  work finally.
> 
> We can use like this as a simple example in bpf program:
> __section("sockops")
> 
> case BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB:
> 	dport = bpf_ntohl(skops->remote_port);
> 	sport = skops->local_port;
> 	skops->reply = SOF_TIMESTAMPING_TX_SCHED;
> 	bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG);
> case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> 	bpf_printk(...);
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 82cc4a5633ce..ddf4089779b5 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -477,12 +477,37 @@ void tcp_init_sock(struct sock *sk)
>  }
>  EXPORT_SYMBOL(tcp_init_sock);
>  
> +static u32 bpf_tcp_tx_timestamp(struct sock *sk)
> +{
> +	u32 flags;
> +
> +	flags = tcp_call_bpf(sk, BPF_SOCK_OPS_TX_TS_OPT_CB, 0, NULL);
> +	if (flags <= 0)
> +		return 0;
> +
> +	if (flags & ~SOF_TIMESTAMPING_MASK)
> +		return 0;
> +
> +	if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> +		return 0;
> +
> +	return flags;
> +}
> +
>  static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>  {
>  	struct sk_buff *skb = tcp_write_queue_tail(sk);
>  	u32 tsflags = sockc->tsflags;
> +	u32 flags;
> +
> +	if (!skb)
> +		return;
> +
> +	flags = bpf_tcp_tx_timestamp(sk);
> +	if (flags)
> +		tsflags = flags;

So this feature overwrites the flags set by the user?

Ideally we would use an entirely separate field for BPF admin
timestamping requests.

>  
> -	if (tsflags && skb) {
> +	if (tsflags) {
>  		struct skb_shared_info *shinfo = skb_shinfo(skb);
>  		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);



