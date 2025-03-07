Return-Path: <bpf+bounces-53549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA011A56432
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 10:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E396D18928DD
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67F20C00B;
	Fri,  7 Mar 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Fpv3ofoW"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926E19C575;
	Fri,  7 Mar 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340755; cv=none; b=WI+kxDqSwgzzlq4neSMyryc5ID8ikVezs6axpzZcdDySTMPGFKOmwqG6k/iMBZv8YL36+s47ATY3PtLZO/npDdT5lhFSWGm3upwS6AeuVVlRRkexqf8OoJaJHJhH/MTSxaFIho/o3GdrdD8fxwcr9PlRa5ONpQUgph34Kw6C/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340755; c=relaxed/simple;
	bh=8BxwcUC03a1oPRZ2pAlv3i2yCxXMrV7cP/jYoHXH/zs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BgjmWmVJQwBPqGQtHDMUQB9n/kXDyASiQj3QIjc9lU6rvuzNLutrc6bsELooNpJlc5kqSGe84g44ohGk3NzstBpyWRhdts8SGDH0OZ/rFgLdPhGE0jlYJRGN96nJr0nxIqRapN0yVh7mvs14LzuHCnPoCMmknKrgPOT4O3niaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Fpv3ofoW; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqUGs-0033xo-8z; Fri, 07 Mar 2025 10:45:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=8tA/kRSVyx+JyEIR4+usiCzAfmuIpsak7pwQ/jnN35Y=; b=Fpv3ofoWZmCgQnpYPTTrolVu6P
	de8JefFtWeInaxjfUg6dvQf0fUMLHGZAWWioaw1DKq2pRg6rudQT4aJqR9D4nsI3a6I8wPG33XdWB
	8ktI4nOIW40I3Dycgnpt/LHRPDIQceBf4zW8rLy37gvK2Zf3mGEmxZ8axKldzz5/shnBQY3FhrqCa
	xySf0CsXSEEiR3LVnC6gDAo9QTdYg1onBEwRlHQ9wN00pIku4eado38x+zfsxt0Mdw8LPd/eu6hq6
	/IOIurS90GnhKLVxkwwHaesvOfewix+ImcI5Sz82I+c7v3hHOeoWN9TkumkXoCAHDmVoTZm62hlFX
	BQVMGIlg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqUGq-0003Tb-67; Fri, 07 Mar 2025 10:45:32 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqUGl-006bBn-4U; Fri, 07 Mar 2025 10:45:27 +0100
Message-ID: <baeca627-e6f1-4d0a-aea5-fa31689edc4d@rbox.co>
Date: Fri, 7 Mar 2025 10:45:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next v2 1/3] bpf, sockmap: avoid using sk_socket after
 free
To: Jiayuan Chen <jiayuan.chen@linux.dev>, xiyou.wangcong@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, martin.lau@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, sgarzare@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mrpre@163.com, cong.wang@bytedance.com,
 syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
 <20250228055106.58071-2-jiayuan.chen@linux.dev>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250228055106.58071-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 06:51, Jiayuan Chen wrote:
> ...
>  static void sk_psock_verdict_data_ready(struct sock *sk)
>  {
> -	struct socket *sock = sk->sk_socket;
> +	struct socket *sock;
>  	const struct proto_ops *ops;
>  	int copied;
>  
>  	trace_sk_data_ready(sk);
>  
> +	/* We need RCU to prevent the sk_socket from being released.
> +	 * Especially for Unix sockets, we are currently in the process
> +	 * context and do not have RCU protection.
> +	 */
> +	rcu_read_lock();
> +	sock = sk->sk_socket;
>  	if (unlikely(!sock))
> -		return;
> +		goto unlock;
> +
>  	ops = READ_ONCE(sock->ops);
>  	if (!ops || !ops->read_skb)
> -		return;
> +		goto unlock;
> +
>  	copied = ops->read_skb(sk, sk_psock_verdict_recv);
>  	if (copied >= 0) {
>  		struct sk_psock *psock;
>  
> -		rcu_read_lock();
>  		psock = sk_psock(sk);
>  		if (psock)
>  			sk_psock_data_ready(sk, psock);
> -		rcu_read_unlock();
>  	}
> +unlock:
> +	rcu_read_unlock();
>  }

Hi,

Doesn't sk_psock_handle_skb() (!ingress path) have the same `struct socket`
release race issue? Any plans on fixing that one, too?

BTW, lockdep (CONFIG_LOCKDEP=y) complains about calling AF_UNIX's
read_skb() under RCU read lock.

Thanks,
Michal

