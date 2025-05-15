Return-Path: <bpf+bounces-58275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC89AB7D59
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 07:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCD38C1EAD
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 05:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A316E295DB8;
	Thu, 15 May 2025 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGD/h8Nb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA675295506;
	Thu, 15 May 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288456; cv=none; b=fCr+FPyXCIW9FQFR+SgB1q7InAVF7OkgDg1Cy1Wqps0l4sIfz++KApOi42p1ne1EITzsSSHCJWkSc8EvXkactivd5x8xEnenGvmBZnd1cWxyLRly16rsIVylGdkfh5vBd8wlxEDiFKMN9wOyMsrtAetiDAyvPcy47OZTqKfByEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288456; c=relaxed/simple;
	bh=rx1/9A8dVOwOhrTh11u2UqTyFdFfZws9vN4IjLqI+yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3MOnRXmZWdPfEONLOW/heEToGwChCU8bpr9zkJI06nWJNG/Fv9ZEju1VzHYVMPpPU6f5fFR+W2zRg//koU1Smzeaw+keLTfFQ+IV+Rg7uEXNrtAyBei/wO9Y0tdmlv2YaZBbrQCC86iTxtVJd/uYAsmSZJjoecOtzpHS07doNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGD/h8Nb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74068f95d9fso509366b3a.0;
        Wed, 14 May 2025 22:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747288454; x=1747893254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgKT5U3SZeCc2sPkQ0JOFIZTSMBOA7CuCOjmkLX15rU=;
        b=lGD/h8NbpIKnsATp5j640tqEA8PAjMS1qGHQ2ryd4vwIqK6TF+zHaGsIsiTcn3qiWV
         cxSYGUcOSOJmzXUXhjYf1RerosYecJf6VDzRlT+mAE/oM3ahC9bsnuNsuHbsrblWfDaW
         LkU/FVYuvr646PCwKEuRIxcJY5uqMGD1vnK0qDVbZOf/o7Fac/SuI5CKzPegEWZ/2g2I
         VwilBu6IkrI/Uu8p/gs/wa7rB9/9LT/MJotSTZ7hIqMt+Y7R3SnNsvMD9ePFOAkNuXQ4
         LSuBForYcPfo5RNualtN6rAjMTyFwkKfOKzNd/DMMaKNLYl9+7FNltnXkzcmAichww9z
         7AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747288454; x=1747893254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgKT5U3SZeCc2sPkQ0JOFIZTSMBOA7CuCOjmkLX15rU=;
        b=A0OPZLx7ga+ZRrv27Kcr/5zHzWVGX8Q+ILLSML9se8agcJX8MXoEnT6L4gfT2wgBK+
         FYVBuRoACP1wkAW/UtqhPoKoXg/SERmQ+RlrI/QMo4YPeA0seeAxyVtY1WgeVvkkkBAO
         jhInuznd1DYjxhakUf56qxSftXMKNSG5+QhgwMYt15xAaE6amuTtuduDjl8aX+YYK90Y
         l41HOAG+Wwtytd/jwElfQ1+Pmn3qbOU3zRHKcoLl6e8P/C5I9wfCMuw/WbFXVTUi+rKR
         sSyN7RG0+AacruX4lfvbZsUEu9n1So62kj6uV6lDGAu6KWyl9+5scSAtz339kwgEFO8C
         vHzA==
X-Forwarded-Encrypted: i=1; AJvYcCU4hUyu4iTtfmRr0UcGSmiFbBP6vFprnlwOjKTKYnH6FzAOx0gYm1wvj8ZCyzNVRdg/k3Sj7Xfw4LnLnoQ=@vger.kernel.org, AJvYcCUOQUmgN2DRKe+RwpFIJ2cPCRU+dvDRvoNRT4QCmtkAQydaSEI3OZsPadCSI2m/H+yUf7Wnngqo@vger.kernel.org
X-Gm-Message-State: AOJu0YxoEjPQ87O9W6nFEUJoVDLNwx1hnFEwGpJ2PVwRdbK3fo7dVzxE
	Ojyoc15qmzizocIU9/HpjI0nuSS04WcX71mjx8zmjiz1S3MVU8kx
X-Gm-Gg: ASbGnctk+o6Kk5756uJHeuEvDdXjM5/NJYsS6HorF84lrD/dIJWHpyi4CEcpb5jybu+
	uQOqJTHj+KCulkqu8/OBivCNfhuH35HwK4k0STlrMD+tbhLX23cfPIdzNWAto4+hqd2X1g5y7/i
	OYNPfqnYeCh8zwkHyWuqvXXLV7bXFP26ERf+ZEHQTMTmoojtV59xH9pED7JoDTLSygMCz0+yJqI
	GMi2pggmlxstL4A8bHBdo9/FOhlSKEyOI57kOpHCFEU4evbRWmf96XSflFwu1F1SiDfvE5jx6gQ
	UIQlX4jdaAX18VBdqVQbbG9rxH2NZLI5MrlOks1DqUnSj6xBEaJN
X-Google-Smtp-Source: AGHT+IGnvvwj2o8mGeCjnMVoMZ7GPGO0Yp7szaIvLMxyQiQuihgCVjzFljKZa2ipYOWvWf3o/H60/A==
X-Received: by 2002:a05:6a21:7a8b:b0:215:d9fc:382e with SMTP id adf61e73a8af0-216115270femr1696464637.13.1747288453904;
        Wed, 14 May 2025 22:54:13 -0700 (PDT)
Received: from gmail.com ([98.97.45.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234a0b5815sm9726893a12.21.2025.05.14.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 22:54:13 -0700 (PDT)
Date: Wed, 14 May 2025 22:53:56 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5] bpf, sockmap: avoid using sk_socket after
 free when sending
Message-ID: <20250515055356.bgevcqwkyv3q7acr@gmail.com>
References: <20250508061825.51896-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508061825.51896-1-jiayuan.chen@linux.dev>

On 2025-05-08 14:18:25, Jiayuan Chen wrote:
> The sk->sk_socket is not locked or referenced in backlog thread, and
> during the call to skb_send_sock(), there is a race condition with
> the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
> will be affected.
> 
> Race conditions:
> '''
> CPU0                               CPU1
> 
> backlog::skb_send_sock
>   sendmsg_unlocked
>     sock_sendmsg
>       sock_sendmsg_nosec
>                                    close(fd):
>                                      ...
>                                      ops->release() -> sock_map_close()
>                                      sk_socket->ops = NULL
>                                      free(socket)
>       sock->ops->sendmsg
>             ^
>             panic here
> '''
> 
> The ref of psock become 0 after sock_map_close() executed.
> '''
> void sock_map_close()
> {
>     ...
>     if (likely(psock)) {
>     ...
>     // !! here we remove psock and the ref of psock become 0
>     sock_map_remove_links(sk, psock)
>     psock = sk_psock_get(sk);
>     if (unlikely(!psock))
>         goto no_psock; <=== Control jumps here via goto
>         ...
>         cancel_delayed_work_sync(&psock->work); <=== not executed
>         sk_psock_put(sk, psock);
>         ...
> }
> '''
> 
> Based on the fact that we already wait for the workqueue to finish in
> sock_map_close() if psock is held, we simply increase the psock
> reference count to avoid race conditions.
> 
> With this patch, if the backlog thread is running, sock_map_close() will
> wait for the backlog thread to complete and cancel all pending work.
> 
> If no backlog running, any pending work that hasn't started by then will
> fail when invoked by sk_psock_get(), as the psock reference count have
> been zeroed, and sk_psock_drop() will cancel all jobs via
> cancel_delayed_work_sync().
> 
> In summary, we require synchronization to coordinate the backlog thread
> and close() thread.
> 
> The panic I catched:
> '''
> Workqueue: events sk_psock_backlog
> RIP: 0010:sock_sendmsg+0x21d/0x440
> RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
> ...
> Call Trace:
>  <TASK>
>  ? die_addr+0x40/0xa0
>  ? exc_general_protection+0x14c/0x230
>  ? asm_exc_general_protection+0x26/0x30
>  ? sock_sendmsg+0x21d/0x440
>  ? sock_sendmsg+0x3e0/0x440
>  ? __pfx_sock_sendmsg+0x10/0x10
>  __skb_send_sock+0x543/0xb70
>  sk_psock_backlog+0x247/0xb80
> ...
> '''
> 
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Is the fixes tag actually,

 4b4647add7d3c sock_map: avoid race between sock_map_close and sk_psock_put

Before that we should call the cancel correctly?

Thanks,
John

