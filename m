Return-Path: <bpf+bounces-26449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C889FBC2
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39101F20FCC
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7C176FA4;
	Wed, 10 Apr 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAKuFDPy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43C17557C;
	Wed, 10 Apr 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763346; cv=none; b=TYGgyU8c1XBAIWVaIOQllysR11N50q0QQe5nsT7fq/UOS+EsP6amp6suXFu7bWHxfda/q0H385hLZujqETJFTDezhIUjxM6vOHwwjjUh5RwJyxj4tVj+4pDIwBPyps3fPpVY6ohGXi2X144+tGRqAXd3c57ayR7279bk1BQkkAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763346; c=relaxed/simple;
	bh=nQU/EW6RN6xfr3NljZXvjKCH5hp48r1P1JR1902wK0o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YohXIlUjbLlVL89LwtcTwozrTIqsRQDbZFfyw+RPsnqXp/TB5W2uSHQCZhO6PVS1GT7q3Cg/vrg7lIdrR6vmw7CywsuIuZ47aY1FBVs7RhSJKs7/Ok9K/dCinHQ8gAk1m1ICC+dqsHz6vBV4a9S/eRyn4alX/ASPfjGsMSVtFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAKuFDPy; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78d57bd577dso325162685a.2;
        Wed, 10 Apr 2024 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763344; x=1713368144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZzk1CbrJpsoJwc1KhYCyX8ST/kypCtDUY7G+Mt0LwQ=;
        b=AAKuFDPy94YBHZcr+b2HDxj1nlzT957uN4U6JTv5yEZPhs8amQvT30SzghQASa8mPS
         KXs+yytMbytFdG1vKFzUGbpzShAwye2Uyw6VZsvb6xr7G71hf3GLr6R8b0bd4hxbuFxq
         y46qYCssnvCjsYDbR31QpzhnUn4OuXSJCEZjPefzXAAfeQZGMoT5SQyICW3xNOIHBiXW
         X4eTP3A6JaCD/qINRqZiuUqHe35g2ZHHoVVI5T9T73mL6Pymvbr4g5q4Sl5U1ppNUKRi
         TEaa2PqdFODExvwFRNoxw6OlFEKCR/yzG4fLVML/y+epHN/OYhUHqU33MDSgWaD0l4LE
         8j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763344; x=1713368144;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FZzk1CbrJpsoJwc1KhYCyX8ST/kypCtDUY7G+Mt0LwQ=;
        b=sBAp+Cl8v56J/tpDiGkuFnyggX3eMoRD/efT2bD1aYipitzMUpV2cI8APIi5Av0NT9
         vt9NPlG1+FmZMDkTX+Qei6/gQ159w4JhPicG6YtKLcJWhH4SBzAmEHUsKTm05+PDb3CD
         /Q92kdEqrdwfqNM5Kk1HolSZWFfSfW+0BP6e++ca5NgmwybTPQmtct8teC6/yK4LFenH
         ZlFrfVZa2uMUKyvqZFvZSJMsatC8bOAKdP3W3NCPR6s2JYP65cU6Nbr23C2gYXFt9tzt
         /F7kTN+hw3+llcVIrFcdgJYV9YgWtB+6DjvmFDR+YP/84I76Ddoogt6bmvLRvz/q9FR/
         muTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOqNDca3LTe375gNa7ghNwA7cEukVa91u0qhpx/XJsVMeXYgKwBt1gEIJhnQUolPOQwjjvU71BVXE9+qpOpLU9V3aAQJJsQuzwdUEvDyRjoz0vh9BmoWKLwJxAzh2JjXK9BzAStT9G7+QKumKR8SJ1693wVhVUnYvn
X-Gm-Message-State: AOJu0Yw8W8q5l+paifq9PgQ+77Kuyjbj7TIeaUwicPJFhnWwzaqjOS8+
	yu39OeAl6UPpjKVPA6TZSU71EW7PkGQi6b5RfBe+NXKZkFxE4YGJ
X-Google-Smtp-Source: AGHT+IF4g21EZhMDy0RUgZgR2yA7BgTgDfggYa84U5aEPdrO1Rt7qPokIgxGiAhqsrp75GIxm7hU+Q==
X-Received: by 2002:a05:620a:27cd:b0:78e:b9ab:c823 with SMTP id i13-20020a05620a27cd00b0078eb9abc823mr1676656qkp.34.1712763343752;
        Wed, 10 Apr 2024 08:35:43 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a248500b0078d66d66d82sm3070614qkn.30.2024.04.10.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:35:43 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:35:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <6616b1ceeecad_2a98a529472@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409210547.3815806-3-quic_abchauha@quicinc.com>
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-3-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v1 2/3] net: assign enum to skb->tstamp_type
 to distinguish between tstamp
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> As we are renaming the mono_delivery_time to tstamp_type, it makes
> sense to start assigning tstamp_type based out if enum defined as
> part of this commit
> 
> Earlier we used bool arg flag to check if the tstamp is mono in
> function skb_set_delivery_time, Now the signature of the functions
> accepts enum to distinguish between mono and real time.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  include/linux/skbuff.h                     | 13 +++++++++----
>  net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          |  4 ++--
>  net/ipv4/ip_output.c                       |  2 +-
>  net/ipv4/tcp_output.c                      | 14 +++++++-------
>  net/ipv6/ip6_output.c                      |  2 +-
>  net/ipv6/tcp_ipv6.c                        |  2 +-
>  net/sched/act_bpf.c                        |  2 +-
>  net/sched/cls_bpf.c                        |  2 +-
>  10 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 8210d699d8e9..6160185f0fe0 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -701,6 +701,11 @@ typedef unsigned int sk_buff_data_t;
>  #else
>  typedef unsigned char *sk_buff_data_t;
>  #endif
> +
> 
> 
> +enum skb_tstamp_type {
> +	SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
> +	SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
> +};

I'd drop the RX_/TX_. This is just a version of clockid_t, compressed
to minimize space taken in sk_buff. Simpler to keep to the CLOCK_..
types. Where a clock was set (TX vs RX) is not relevant to the code
that later references skb->tstamp.

>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> -					 bool mono)
> +					enum skb_tstamp_type tstamp_type)
>  {
>  	skb->tstamp = kt;
> -	skb->tstamp_type = kt && mono;
> +	skb->tstamp_type = kt && tstamp_type;

Already introduce a switch here?



