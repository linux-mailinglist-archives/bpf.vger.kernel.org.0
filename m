Return-Path: <bpf+bounces-22382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1B85D11A
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 08:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6D1284640
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6C3A8DD;
	Wed, 21 Feb 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiASDH47"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E839879;
	Wed, 21 Feb 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499920; cv=none; b=BNluWrTr6iGYKx/MuDGBrgYP1Pn3rHBa/soKfF/sOpV7b09QOfZrZVOmKgvUxs7SmCKucyncl3zkdarIzwCuxT9C77Q0TpsoeX9d8x2wQQ/qaG9qtqhAWwVpMVv6p8RW/cfta44bDtSoeD7xmBlTqBFev/ZAccZJt3ZuSyLf81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499920; c=relaxed/simple;
	bh=X6Cq+RW0HDSyeBS3C6pwEfX3WHpgDSCQAseO5Swl1dA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cKXtc9df4/lH1FAL6k/+Vqdiqu5IzIP9Y/R7s9jGBK4BMQCC0GywAcW61ljkZD4Ls61Lp7dyA5DuYH44IqZqp2qXm0bW5rMoAkKnATkH7S7OSWrE07ugoqdZBM9FFyaWU29Yit3CQ6RGMh3YsbvxJ5R1jgamDm9Adtxpmgg5CLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiASDH47; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e486abf3a5so702023b3a.0;
        Tue, 20 Feb 2024 23:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708499918; x=1709104718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh6UXdERl+gUl9cBq4S+KjIngsWFhxQy1ohOrIZDnMw=;
        b=BiASDH47jvZkJ0z52bxcHNEpXdseRGf2OkI4M/G9EnDKIjEWrXtaRd+NWijJNpBmxf
         x5BHcRRzmwPq/dzRmhWb8tv5iVTkWiMdJA1S2nrp1fBPyp6mVN0rKnb8skO0P7IM3dru
         wPIOWqEKypah3dx7hckfQLwFH4KloObmXI69q6OHG+BVyk2Gy5094pDBX3qnx5B2x4cc
         oMR6UT5wD9Uz9SiRKH48eLuMqsHeVaqUYO3dB8a3QgsTraL5+brTitI+8iTiml1+80O9
         6hbYVqXPJBEv6oIR0SBzpGyrDImpEQMsglAXxh26N9FJ89mnlCOd0qB96ixHdZMc6aTL
         kNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499918; x=1709104718;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vh6UXdERl+gUl9cBq4S+KjIngsWFhxQy1ohOrIZDnMw=;
        b=kZaEhT01vhKL/0O5nJSs/QxEdaupsUO/r71TfBgTuLQnpbH9Cs6lURWpD93QAG1Ss/
         Q9nsGEinN0k5wVAOInWq9TzZcr6fTLg5kmUbDNbufCGymFL4TggTIh6VvSk8VGPoxcMe
         hLbMTlOtWirNPPZO7yfAuL1zg5bHUrZOJJ2i/bvBV2mP6NI2OIsmZoxcCNrkfTmD9jC+
         +AmpGWprY/cj58ksr0uPIs3ioa0lc3remohP+pq7RJXA3qsnTL1n89I1l2pfJry7csBz
         dxJ2JGum3jlLrBU3DaSBXG/XLl/AAo7TJLjiAAWhT3za/gmITWFcL3Fc41MBPb5wi4X8
         xkLg==
X-Forwarded-Encrypted: i=1; AJvYcCWoG+TC0zSXXWDilnVmKZhwkTEZgi3U0gRKaNFim8MHF+3F1CK6gjFGtxD18ynQKIXCpxnnwcdROg4EkmLWolVE3hQ10EetEk7injq0L+SnH7jCaA2iwa5HmfrS95ORGaf2v4RnFAAyI2L0AdvvXMkQjT4adpnAhg2n
X-Gm-Message-State: AOJu0Yz3NKJsDDzKchmB58HMV9p6WzBpr16D6k1tKSBFyA9XKcnWo0ui
	+xVOWEj+j5mh5HIy1mYB6G+LqYhTjOO4NdtDM4bFgcgm4PfKkfUr
X-Google-Smtp-Source: AGHT+IEsDwnkEgqxa8FKaQSFlLHTLHQYY7+7eWZBn1A6weVllWR2ITEMm/gF7mdKILPGjLUPblDM+Q==
X-Received: by 2002:a05:6a00:2d89:b0:6e4:8d1d:7770 with SMTP id fb9-20020a056a002d8900b006e48d1d7770mr1622981pfb.3.1708499917882;
        Tue, 20 Feb 2024 23:18:37 -0800 (PST)
Received: from localhost ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id v2-20020a62a502000000b006e4362d0d8csm6156788pfm.36.2024.02.20.23.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:18:36 -0800 (PST)
Date: Tue, 20 Feb 2024 23:18:35 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Shigeru Yoshida <syoshida@redhat.com>, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Shigeru Yoshida <syoshida@redhat.com>, 
 syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
Message-ID: <65d5a3cbac150_5fc5920879@john.notmuch>
In-Reply-To: <20240218150933.6004-1-syoshida@redhat.com>
References: <20240218150933.6004-1-syoshida@redhat.com>
Subject: RE: [PATCH bpf] bpf, sockmap: Fix NULL pointer dereference in
 sk_psock_verdict_data_ready()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shigeru Yoshida wrote:
> syzbot reported the following NULL pointer dereference issue [1]:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> RIP: 0010:0x0
> ...
> Call Trace:
>  <TASK>
>  sk_psock_verdict_data_ready+0x232/0x340 net/core/skmsg.c:1230
>  unix_stream_sendmsg+0x9b4/0x1230 net/unix/af_unix.c:2293
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> 
> If sk_psock_verdict_data_ready() and sk_psock_stop_verdict() are called
> concurrently, psock->saved_data_ready can be NULL, causing the above issue.
> 
> This patch fixes this issue by calling the appropriate data ready function
> using the sk_psock_data_ready() helper and protecting it from concurrency
> with sk->sk_callback_lock.
> 
> Fixes: 6df7f764cd3c ("bpf, sockmap: Wake up polling after data copy")
> Reported-and-tested-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93 [1]
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---

By ensuring order of ops on teardown we should never have a loop here. Also
this aligns with strp usage that also uses sk_callback_lock. Thanks. I
suspect we haven't seen it because when this is being used we never remove
socks from the map before the socket is released.

Acked-by: John Fastabend <john.fastabend@gmail.com>

>  net/core/skmsg.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 93ecfceac1bc..4d75ef9d24bf 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1226,8 +1226,11 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
>  
>  		rcu_read_lock();
>  		psock = sk_psock(sk);
> -		if (psock)
> -			psock->saved_data_ready(sk);
> +		if (psock) {
> +			read_lock_bh(&sk->sk_callback_lock);
> +			sk_psock_data_ready(sk, psock);
> +			read_unlock_bh(&sk->sk_callback_lock);
> +		}
>  		rcu_read_unlock();
>  	}
>  }
> -- 
> 2.43.0
> 



