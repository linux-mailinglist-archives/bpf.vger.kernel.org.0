Return-Path: <bpf+bounces-30841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C058D3880
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACFA1F248D0
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCF1C696;
	Wed, 29 May 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnQ4NVLP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5D1BC2F;
	Wed, 29 May 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991115; cv=none; b=I/8Xx1IXzH//O49NRt80pYYY+KX3IDcu9NY2/fbp2yGvtNzwoocmf9MYmD55UmwYnKXnkIytfncBTDnr7SQODRLH2QFR1vv0i3NRaIO0HKoOIJMbl/gcf36In1UeiGARnVYTlC1xauTZe8M9wJozTfOAT1EzPz/872NsfQCcxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991115; c=relaxed/simple;
	bh=WNzkX3kQmAm6xhlUmSgtHXFFi9rlz3l8gFZLSArBK1A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Y0NWmrrYn4xg84MfknDkVZKV32ik/hcrXiAp+RsIjRc6L+nNDXHssmuLWtXF2iW6vAsXcNiJL2Zu+oVViMGSWK0pBC3lP1SF9BQh0HXDfqPOnWzz7YFZs0rX6VMiz013+C9O0sf0uesupVh6lSk41h3sSUeAwurw3fBNDYKVNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnQ4NVLP; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43fc2ad049aso10849681cf.3;
        Wed, 29 May 2024 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991113; x=1717595913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnVsuijST4Uccd/R/BYvy+sfPi8n/4n1QlcexbPNowQ=;
        b=EnQ4NVLP8rHg2zTx6yOWZHTqkU77zgNxeoH2YmLP2nND3tVPMkwirK7wyqQ1jDi0MQ
         4wyC4bIZpdjOPR4KZIfyOj1MCS0vcOD5rb8558hLs9Du+csFkBjn2QCnUL6rdkcKsehM
         n+/bkp4lCdwKpawY7uKV6hAnmX0l9gphzdAN/OywHWtKc6ihsqJe3Y14tPRhzVLMl6nc
         /yP3xnjyKe9Hos3Zmb3wql8hGNHkjxcCJ1yVZJec+UEtotQ6phAdy+IwSa+Zzy5H5jhN
         OQB9WcEKxn2AifUnUFz6aQdRmAo92lRbEu56UYx7z4Q1jjMmPm7z5CVmizrXb4C724ZU
         ECrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991113; x=1717595913;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jnVsuijST4Uccd/R/BYvy+sfPi8n/4n1QlcexbPNowQ=;
        b=Yu6cCW9G1IzBS5335BaFlx4WwyJBB+i7iNuvWqDc65GSvEHmioQX41Ee4t2U+rLzf9
         AcvUDVG39Z0a1w/vt6P4K4uUlv++AFauX4SnylpqIWZ2e41ssiaJZD8MvSeng0kfNlMF
         GA/syufWuwwa/AQiaSewqxdW4oYU64HPOSgELwBr9pEGMHlWL633w2Xg1Mxde0nEVAOL
         gmm9dh1jA4OJaljLztxdp6eH90n4CfeCdj6sc31HViiTmw5+x2gYeOYpntr5ttbuPOKY
         7xV85UmeMV2YHf4aE80WIYkqAiXc3jqTrsjwxKUv3kr2R9hYjwW1tZyukNTQd5+GA8X1
         9vMA==
X-Forwarded-Encrypted: i=1; AJvYcCVbsc2Jco+u32WaemIzs1Y5u0JmZxUfHoLWP4F/YnX397ecwZLjv10jDTQmm09ne6TTuuspRYmbPTp2t2IGp6HjOD7jA+aPoK+XULMzcSfxrcWk7CLcVFtDKIyoYTdHyXTn1d/IkJk8dSZ0dg0PyU9K134Yvnn7O3Cn
X-Gm-Message-State: AOJu0YwmAG+3I8GxfQgcwsgzJdJqbgzdtdfH9oo4mmVeq1wURHmnK9Q5
	Blgeg9SbMq/uRQZS8yw/RkGCEv1e6NvQrWSf5uU68x/jKHu1BKaW
X-Google-Smtp-Source: AGHT+IHLX9s5HgTIP5hLEXBAHKuHHJJoB1TTaV997mUIdfzfFpIVnL2kUl2gcpyBUJWz5Ry8BMjC4A==
X-Received: by 2002:ac8:5892:0:b0:43a:dc29:a219 with SMTP id d75a77b69052e-43fb0e221c9mr166332311cf.2.1716991113113;
        Wed, 29 May 2024 06:58:33 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fd9ab321fsm17099551cf.95.2024.05.29.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:58:32 -0700 (PDT)
Date: Wed, 29 May 2024 09:58:32 -0400
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
Message-ID: <665734886e2a9_31b2672946e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
References: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
Subject: Re: [PATCH net] net: validate SO_TXTIME clockid coming from 
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

minor: double space before userspace

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
> Link: https://lore.kernel.org/lkml/20240509211834.3235191-1-quic_abchauha@quicinc.com/

These discussions can be found directly from the referenced commit?
If any, I'd like to the conversation we had that arrived at this
approach.

> Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")
> Reported-by: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d7b227731ec589e7f4f0
> Reported-by: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=30a35a2e9c5067cc43fa
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  net/core/sock.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8629f9aecf91..f8374be9d8c9 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1083,6 +1083,17 @@ bool sockopt_capable(int cap)
>  }
>  EXPORT_SYMBOL(sockopt_capable);
>  
> +static int sockopt_validate_clockid(int value)

sock_txtime.clockid has type __kernel_clockid_t.

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



