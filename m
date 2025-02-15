Return-Path: <bpf+bounces-51661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C329A36F01
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98DC7A2C0F
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BA51DDA2D;
	Sat, 15 Feb 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp20iRyp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854F151991;
	Sat, 15 Feb 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632218; cv=none; b=GdJeb/UxjLKTfDYUwlR6S4G2iRAGE7TrqVVDZeK91Kf9xu+LSh8egIccq2KtWo1TPGvG6zYqghPZW2csPeQCkdIEF+7kii2kImPTjllHG7/hVP2szlWFh+q6A6qwwuNclJZ+dW5uoiIc6LtMCMYH36gKmpKiNg7uKTrwkNiW0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632218; c=relaxed/simple;
	bh=ekTWH3lKDaJiH2c39J2tqHshpjBNEsfQsqOQHndD1tg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eH6GVUQuH16LnLL/W4erHrcd6GNeLIhBKoEOTi5r7/pNKow+nnuUor/ww1Pd1RtNY7MdYAMq9gM8Q8QzazqAibjjE5SkMZTFF0eSnbvcgU3PnHe+dauYjChdQd0L89Dysi3C7DnDyEvaGPfOQZm6ltZsezHXnEaUhcbfJO5ADMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp20iRyp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471d0644aa0so13050841cf.1;
        Sat, 15 Feb 2025 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739632215; x=1740237015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ioj4pNprMXOHqvwKiBQ2e64iyV9YXXNdIdJg0yCVgeo=;
        b=Qp20iRypo31d4iWO7mJaEByitOfwAYnBTgT6ZIpVH2I0etPjjczrUs65Il6r9gXqRf
         1/Swz8Q6/Q0wrJ0nhMpP3stoq4pkfJGZorsTvXRM4kN5PwszX3HsQQoUxNllDcxo/W9S
         pHaPfnQbJVRD0OS/WMdR2+gY7w8GeWtFJpCyMtxbKrei6WPrBkXkKC9zohvbsPcSkPZi
         WN9/4Zw3w4I/xIfzLfTyxrQaxAqgm7xEB7FGpGk90qgx6LIOG/bJ+TREBgrBw9hpxiMv
         +S+jOqv1Sd/Jf/69sKBXPtTkoJely1GtruDtTXLW2118dirAppZFtNOfsCwqjFLaLo1u
         h+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739632215; x=1740237015;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ioj4pNprMXOHqvwKiBQ2e64iyV9YXXNdIdJg0yCVgeo=;
        b=qAZD4TpmDyont93wBZwNoeXUQ13tQF4RQhozBYmTb/Yyqq7e580sQQsEdQlwJhkkcU
         huA1AB92V+6LgsJxd25VXVDPAhuV91h6M5RUT5NCdJ6He1uHVfgijL40lKXqaZr4UrR3
         kZVmNJZR6VDxYplb7DZrDkv/j3T3ZvZAmfCzsj8q6JImvdJrWYNKLrlBvpWkbKcP3Wb6
         T50DJaJxwMrZCihilae+aEo0hsGXg60XsM6IbbV10U6/IXRnc3me6uuNfl3lR0reAjJH
         /dNLBDuHHdp8LMRYT7aYsyS+GaEhasv9INCxXh55w/Sb118M0mkfRIuNYZuQ1juPJbIs
         TIMw==
X-Forwarded-Encrypted: i=1; AJvYcCURLCqwlmoutdNQH4/YQHcXWXxixKCcXC9xy1vZUvSUrzKxOMYor/86WP1QSunFafWVb4rEJow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUu/qIUmf3mZeR8omof4oQBqJUlv/tWmMdBim65km6xm2hkGht
	dxWWrMmPQ9Kt78BV7AsE9CtRMcQfvCCIRWAz4GnNlmFg8OwZiNjW
X-Gm-Gg: ASbGncvjUEprLI4fPbxEaDs/LJ9rT/LYWvbzFN9mXWQ45m9c2CNKATqvWbOzk4M2PFu
	gEzPbKlKpyptWQ2U2wKd+12vqJ0/PRousDRiM7Gzx5Znf+1fyQV5vre3Uap8UuPx9S43zt7RW84
	7ODL4sjOIPxj0R6IRYxBPaZKaijtvupy4epWsH/xkZJYd+EH7DSGdiWZ0gkp+RO2HaFUWnMTOx5
	ugayyiZAEFcPG564DSAR82OSVqfUKxroVGVPPdVaGUAZquPbE5wgwtOyGDLTzkpLSAOz90jyv7W
	CZd0HoUVX0FkxNiizFrPMydMmee50ZStb18runkreviiH1U9+DYD5b8uAoLT8FM=
X-Google-Smtp-Source: AGHT+IH24AhhuPlq4Ct/8rxU2wjdn1kdNcq4q8LkjolVvrFJgQTxd6l1K7BozQCWXY5wQr1V0OoKlg==
X-Received: by 2002:ac8:5808:0:b0:466:9d0e:1920 with SMTP id d75a77b69052e-471dbd6fec7mr38132941cf.24.1739632215030;
        Sat, 15 Feb 2025 07:10:15 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779266sm32901786d6.25.2025.02.15.07.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:10:14 -0800 (PST)
Date: Sat, 15 Feb 2025 10:10:14 -0500
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
 horms@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b0ae562fc79_36e344294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214010038.54131-12-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-12-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v11 11/12] bpf: support selective sampling for
 bpf timestamping
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
> Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs to
> selectively enable TX timestamping on a skb during tcp_sendmsg().
> 
> For example, BPF program will limit tracking X numbers of packets
> and then will stop there instead of tracing all the sendmsgs of
> matched flow all along. It would be helpful for users who cannot
> afford to calculate latencies from every sendmsg call probably
> due to the performance or storage space consideration.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  kernel/bpf/btf.c  |  1 +
>  net/core/filter.c | 33 ++++++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9433b6467bbe..740210f883dc 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>  	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>  	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>  	case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +	case BPF_PROG_TYPE_SOCK_OPS:
>  		return BTF_KFUNC_HOOK_CGROUP;
>  	case BPF_PROG_TYPE_SCHED_ACT:
>  		return BTF_KFUNC_HOOK_SCHED_ACT;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f56d0bbeb00..3b4c1e7b1470 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12102,6 +12102,27 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
>  #endif
>  }
>  
> +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
> +					      u64 flags)
> +{
> +	struct sk_buff *skb;
> +	struct sock *sk;
> +
> +	if (skops->op != BPF_SOCK_OPS_TS_SND_CB)
> +		return -EOPNOTSUPP;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	skb = skops->skb;
> +	sk = skops->sk;

nit: not used

> +	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
> +	TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
> +	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;

Can this overwrite the seqno previously calculated by tcp_tx_timestamp?

I suppose that that is safe as long as both calculate the same value.
But good to have explicit.

> +
> +	return 0;
> +}
> +

