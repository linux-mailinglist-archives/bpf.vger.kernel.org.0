Return-Path: <bpf+bounces-43349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8338D9B3F67
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069341F22CE2
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 00:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA791179A3;
	Tue, 29 Oct 2024 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnxq3gem"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D272D53F;
	Tue, 29 Oct 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163549; cv=none; b=hzcIMsjhGaUEcjlbH1IOPHztzfGUoELEnAGZxEC/Z6fSIQBBWt2xMr6pPY4Zu6Ql0RMLkCKymoWRBgsApcmrxHLQQblgLXIuPvnN9z6hWdolxRA1IDvmM49FPF4wNLMLLujINJ/KDxBm2rHbOo7IFZ4CpZuZannwJXTi/gZRm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163549; c=relaxed/simple;
	bh=9jBw8FT9ir6LALfRoy2oLZTmd7my/2OKUP0DwfvDqj0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RJ5hNOfQClh0i2p6inqm2rLNbigFV7NQ1/d28otPx0H/Rv5+pirM8TDASk+a8KcCtrXst0If6Xxq96f50hGMsIufM+CeNQON6v1GN/HFd4rLgQWpAkI+wi3wZ21tSfkpupXZH9w/aG96+PSdprxevjM16qYTzpO8Ia70Mw3mBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnxq3gem; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbce8d830dso33100266d6.1;
        Mon, 28 Oct 2024 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730163546; x=1730768346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjR45WoLmbB21NlZzj5DbErglWlj7M9tqOl7VHZZ+Rg=;
        b=Dnxq3gemPWvfhWsVbSAmq+M3fgDsZAUUMEZ2tWLb0LaYDhoe9ZaMJDYgaC5r3wVgwi
         nM3V7/3SnzrPwksKMZZzv+IBMvajve0bVDr8+8geu79l8C3rwv+tZSAZmtVhnVzMm6P/
         Zpi199pM5V7R9LdET5xqI93nJ7yb9ceFa+X6gnoKGaqgOXy4wk7VoSIk2xIfCYSzjimh
         N3K6eA1gUg8iYD2qLsuchxyXCI/0x+gbWKy34ypua+7T5Z/w/bwMptgOpk060cBR7bZ0
         qucZXUs2UGhFKEcGfihZdW/m5oRDGnn1B0VV8ePkJK/XEosgrtgQRLqez51xJ5sVT567
         YpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163546; x=1730768346;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sjR45WoLmbB21NlZzj5DbErglWlj7M9tqOl7VHZZ+Rg=;
        b=jgGE6kSa7xXNGHfiogSbNteuW7ZSQr8NPbYOco6gq6awMfRCe5CdJPnum4MQKGselQ
         QAYBXQfPzaiRShXwdBEClk+EQMJEbX9x313wzoukG7m+SiceWPxHlQ7aXJsY9Gjo2l5U
         Lv6yRzCHT4BEwpw2yhmxps3WjhD0zPu4sF6fe4Tu0nXFEf/tYKtZ3A4x6liL3qCMri1I
         AYAYWt8cXT54iwhIXuQ9ms3VE4BBrEgyzB3AofgxbJwuKUxvKGRZA7kdLBPi0VNyVia3
         JQQI0728b5ktJ8EzsQuVG6davZbiNJ7XoJG39cLN+mX7COsVW86InpTFbCuP+6jw819D
         mu5w==
X-Forwarded-Encrypted: i=1; AJvYcCUfnOh2KarFRkexxpIWO4JuryGOPqVUguGIQDyLWuiB0wK8KqyL+isYizofWqpRJoN8GL4QP7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkY1mas2FE5qYgD/KlHinjVPJtRTHDYNy966w7ZRZdhn+ShZ07
	Y59MIQEsc921fbPeEVRe6sjWudI3ni1t3/os7LffixkQ2otTsr/d
X-Google-Smtp-Source: AGHT+IHV+srostOItyrHY+ygjRFnUMLE3aUTY6HHUh2VFvU80DvRgB1KlQe91Y8PK3TtRRtA1V1INA==
X-Received: by 2002:a05:6214:5404:b0:6cd:faea:9f78 with SMTP id 6a1803df08f44-6d1856bf3e7mr184757516d6.12.1730163546190;
        Mon, 28 Oct 2024 17:59:06 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a0bec0sm37561586d6.88.2024.10.28.17.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:59:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:59:04 -0400
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
Message-ID: <67203358a4016_24dce62942@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241028110535.82999-4-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 03/14] net-timestamp: open gate for
 bpf_setsockopt/_getsockopt
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
> For now, we support bpf_setsockopt to set or clear timestamps flags.
> 
> Users can use something like this in bpf program to turn on the feature:
> flags = SOF_TIMESTAMPING_TX_SCHED;
> bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> The specific use cases can be seen in the bpf selftest in this series.
> 
> Later, I will support each flags one by one based on this.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/sock.h              |  4 ++--
>  include/uapi/linux/net_tstamp.h |  7 +++++++
>  net/core/filter.c               |  7 +++++--
>  net/core/sock.c                 | 34 ++++++++++++++++++++++++++-------
>  net/ipv4/udp.c                  |  2 +-
>  net/mptcp/sockopt.c             |  2 +-
>  net/socket.c                    |  2 +-
>  7 files changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 5384f1e49f5c..062f405c744e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1775,7 +1775,7 @@ static inline void skb_set_owner_edemux(struct sk_buff *skb, struct sock *sk)
>  #endif
>  
>  int sk_setsockopt(struct sock *sk, int level, int optname,
> -		  sockptr_t optval, unsigned int optlen);
> +		  sockptr_t optval, unsigned int optlen, bool bpf_timetamping);

timestamping, not timetamping

More importantly, is there perhaps a cleaner way to add a BPF
setsockopt than to have to update the existing API and all its
callers?

>  int sock_setsockopt(struct socket *sock, int level, int op,
>  		    sockptr_t optval, unsigned int optlen);
>  int do_sock_setsockopt(struct socket *sock, bool compat, int level,
> @@ -1784,7 +1784,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>  		       int optname, sockptr_t optval, sockptr_t optlen);
>  
>  int sk_getsockopt(struct sock *sk, int level, int optname,
> -		  sockptr_t optval, sockptr_t optlen);
> +		  sockptr_t optval, sockptr_t optlen, bool bpf_timetamping);
>  int sock_gettstamp(struct socket *sock, void __user *userstamp,
>  		   bool timeval, bool time32);
>  struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index 858339d1c1c4..0696699cf964 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -49,6 +49,13 @@ enum {
>  					 SOF_TIMESTAMPING_TX_SCHED | \
>  					 SOF_TIMESTAMPING_TX_ACK)
>  
> +#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWARE | \
> +					      SOF_TIMESTAMPING_TX_SCHED | \
> +					      SOF_TIMESTAMPING_TX_SOFTWARE | \
> +					      SOF_TIMESTAMPING_TX_ACK | \
> +					      SOF_TIMESTAMPING_OPT_ID | \
> +					      SOF_TIMESTAMPING_OPT_ID_TCP)
> +

We discussed the subtle distinction between OPT_ID and OPT_ID_TCP before.

Basically, OPT_ID_TCP is a fix for OPT_ID on TCP sockets, and should always be
passed. On a new API like this one, we can even require this.

Not super important, only if it does not make the code more complex.




