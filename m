Return-Path: <bpf+bounces-30885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE08D4254
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 02:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A3AB23C54
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43368814;
	Thu, 30 May 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch0TOFUk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778A36B;
	Thu, 30 May 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028671; cv=none; b=XhDme1ppMOH036EKU0X5mYea9+wZvHPQBuoTMnKsmOqAEPCrc7vHCtedY+R7be4WD1yFDeZnwLMZDDUVgAlcpuD8I1+jrk4OKK2/oTbsjxkvyjP+z+pRTnq/VJ7uVaRU9shys2NCPdaamcP/byq4RBbLhk+Psg1xdqVS9e5XXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028671; c=relaxed/simple;
	bh=oJzuJ7oeKWDazzvBwNiTMmJHRKQNgxb7KiIbWwO9mWY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M8hSYaABPzkiaHMjL5YDiJPT/kWEJ41b4D2GzrWcDDQ059AzawpRk9ngvj0N9ZxxKdtXU2z8YfG3aQgQ8/A6rDaRhFRP+6ZYxbYa+ExICweruopNXDMg5BmoM0LVVdU1ffCYWgG/RThjhyEciBLCALoFgpEKrYMiPg6emczlUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch0TOFUk; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ae1059a62fso321186d6.1;
        Wed, 29 May 2024 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717028669; x=1717633469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daAIjqlAJvlh3DMCxt66Yxpteyun7KWAO+PmZTdsD1I=;
        b=Ch0TOFUkiNwKdiYfgoCdkAPpuXLkN8axkNPoHEVP1AAhEI/QHa3fTIOqheHi4f71Lg
         zxacXZFkrqHFcd68ik1lYWY3AM9ji4++268WapBICNudccr9pYhAl+PQ02HpI76amgS5
         P76BJKcb+5hPhWB2cNLORwq5Rr8csVBp2hvCk24ELwcibpU89LzxwEOAlfC1FK1+HIZZ
         DSa5sCGJYdB8YAyacFKjrUblcDFvn7MUVKi37HVSPkSODcQIcqJojYJ6tsF//IbtSqPb
         fS0JnaHcJLgSfRb4VZIlM6cRX248MV/JRAmkh7R9f482+X04OxmFLk+WpRQ/hnFoZ6zN
         UFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717028669; x=1717633469;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=daAIjqlAJvlh3DMCxt66Yxpteyun7KWAO+PmZTdsD1I=;
        b=P1k6/mNydmBXqSU9hmzB0lb5Fsf+pQrhxqpIdESD/8A93rilxW3BPuaZvuZ2R7bOWh
         ppoSjrqLFiGVshBM46pp9Aq9KCxjaEt8Q0LfUJhFq0y/bjccfKmBbJcG9Ae6dZm8Npgl
         gAjEkuRYI54vjcZgYBWqWMuNKaC3KXC7+LYg4Z1dkJrosxILKcFsVDrNWbAfqOKIETK1
         ocJLyBD5vp7WlWHFcIh4L2uYJO28+DFzJ+u1QOnt/SjKTanztuzM4h2VlOTPY/7k50aj
         E/neE7JBpNFev0x15uN4YSg1uW2/lU1po3AbFzfyygRKfxFtH3Kz96Pk1ExrObeBRF5W
         Nz8g==
X-Forwarded-Encrypted: i=1; AJvYcCUErO/+7XQtwQ+9NLxQLOGfV/tWIanQt0qYeafPaINnN7unDVg8kC8ie+sag0cFKGzcZLa8eY2a8u/GaJv029AFH1SYLao2EQAmVa+8YjZ+W9MU4T7bOwCuw/FCF2/YReaF2diTGuC67qgLd/FLmU2tWxOehgI9vWFL
X-Gm-Message-State: AOJu0YycbKEUMDLtpqN1rMQ1rV1h/fcQ+1OFFt9SF5woAluqWdzafXD7
	r91XnYIs72n/h2nk3PHEyyYqKU9rE8e5rkZCFZ66+mhVTcpVqOzL
X-Google-Smtp-Source: AGHT+IG+C1Xg2WHPIFFK/J6698OmEGL99j/gjiEVK3LndiZ2Lc26qXJB0evPDHhR26P3MoVNE9HeqA==
X-Received: by 2002:a05:6214:5c08:b0:6ad:6ea7:b261 with SMTP id 6a1803df08f44-6ae0cb1db63mr7390316d6.23.1717028668666;
        Wed, 29 May 2024 17:24:28 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm30592536d6.93.2024.05.29.17.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:24:28 -0700 (PDT)
Date: Wed, 29 May 2024 20:24:27 -0400
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
Cc: kernel@quicinc.com, 
 syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com, 
 syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
Message-ID: <6657c73bb72fa_37107c2948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240529183130.1717083-1-quic_abchauha@quicinc.com>
References: <20240529183130.1717083-1-quic_abchauha@quicinc.com>
Subject: Re: [PATCH net-next v2] net: validate SO_TXTIME clockid coming from 
 userspace
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
> Currently there are no strict checks while setting SO_TXTIME
> from userspace. With the recent development in skb->tstamp_type
> clockid with unsupported clocks results in warn_on_once, which causes
> unnecessary aborts in some systems which enables panic on warns.
> 
> Add validation in setsockopt to support only CLOCK_REALTIME,
> CLOCK_MONOTONIC and CLOCK_TAI to be set from userspace.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Link: https://lore.kernel.org/lkml/6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com/
> Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")
> Reported-by: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d7b227731ec589e7f4f0
> Reported-by: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=30a35a2e9c5067cc43fa
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> Changes since v1 
> - Moved from net to net-next since 
>   Fixes tag is available only on net-next
>   as mentioned by Martin 
> - Added direct link to design discussion as 
>   mentioned by Willem.
> - Parameter in the sockopt_validate_clockid
>   is of type __kernel_clockid_t so changed it from 
>   int to __kernel_clockid_t as mentioned by 
>   Willem.
> - Added Acked-by tag. 
> 
>  net/core/sock.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8629f9aecf91..d497285f283a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1083,6 +1083,17 @@ bool sockopt_capable(int cap)
>  }
>  EXPORT_SYMBOL(sockopt_capable);
>  
> +static int sockopt_validate_clockid(__kernel_clockid_t value)

The __kernel variants are UAPI. It looks odd to use this in kernel
internal code, and I don't see many examples immediately.

But I believe it is correct, as we're passing a sock_txtime.clockid
field, which has this (UAPI) type.

> +{
> +	switch (value) {
> +	case CLOCK_REALTIME:
> +	case CLOCK_MONOTONIC:
> +	case CLOCK_TAI:
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  /*
>   *	This is meant for all protocols to use and covers goings on
>   *	at the socket level. Everything here is generic.
> @@ -1497,6 +1508,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  			ret = -EPERM;
>  			break;
>  		}
> +
> +		ret = sockopt_validate_clockid(sk_txtime.clockid);
> +		if (ret)
> +			break;
> +
>  		sock_valbool_flag(sk, SOCK_TXTIME, true);
>  		sk->sk_clockid = sk_txtime.clockid;
>  		sk->sk_txtime_deadline_mode =
> -- 
> 2.25.1
> 



