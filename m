Return-Path: <bpf+bounces-55189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDAEA7987C
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 01:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99AAB7A444E
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F71F78E6;
	Wed,  2 Apr 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICbdYUMO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A431F7075;
	Wed,  2 Apr 2025 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743634878; cv=none; b=VCnhqNTcpMlX+sLv3agXcKIa+RJENjS6QssUe4jjyxmNCJrLNsnoABcnkcRgDuOfSEUolWv0iSsa53QALXB9qMrmDfMpao55diC4VJkO/j6ehzB9uswcmjvXoC8A6mArrcJOp50JqAkVivNyyE2L9OQfkY+ULq48bdBimStepNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743634878; c=relaxed/simple;
	bh=2GzWdaDmN/7Vn4Jjp/ACQtNwRhu01zTK3kcsoJgCWbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWQu2QkaZVIYL0pqwKyv8hiEIDK91lfeX+YGbf1MofGF4a5f8kkQkhmM/QyGiOuZ5IZB+riUGxrfjmevQNU84/GxgPctCkftItG0BfmYMsToiQj2zdUtB4kDzxxiWWPnekRVRCMxoMCiTB7TJQwD2MPvxfKFHcVpV++ylGon4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICbdYUMO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30185d00446so225953a91.0;
        Wed, 02 Apr 2025 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743634875; x=1744239675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q5g6vjilwHVlFu2iNXstsKlqPmWzVrhaLj3zxkMXn4=;
        b=ICbdYUMO0SjLlEgMz+UX411Jcgx0uVLYv3Nr6Ym0LMnGc2b+UgMjeEYHdtnuzkpen7
         Ujm9HX5mwUcnOO+85/2gMng3ruzNmrNy+YASX/3oJ/4HR8x2GVo2sWZwGpf+54IWVGSy
         LDf6wWgQKz8loEyXr7jJmcoEvnMpkzEyQKn8Y7xE3fvx92Jx0KERbmmMftAoRpRGED2K
         XoZsBEObkM9bg115rvL2eKuZoxX8toQeilYEp1XivfMYFOvYcgC6e4myHSbjEC/oAE+H
         bSF2ejKTzGOv4s7i8u1i08j0eqneKfitp6SCYI1ZzmQv2dqOrf1IOOiK1/KQ8qg1JOP0
         23gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743634875; x=1744239675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q5g6vjilwHVlFu2iNXstsKlqPmWzVrhaLj3zxkMXn4=;
        b=xVgpiNZ5byRgwnUzVJKdi7ugGKrT7hRhJyO3e8AaxITXPW6ZrZGU/GNyaK6BFNGP02
         qtL/GJZsbpr1+Ubr02y7z8FIEo6RDN+eSTXvtW21ru9y5m7M4DMnlAiIYOmmsf8AUmKP
         T00IJtlxdrHoZYKYfMuVbwnGskRaiJC+c+hfQ/+yHEa2o/JYK9+8RFjqe4Orm3k04Ux+
         8c6OKeNNeFzyo92Xxpfdj5fgsC9Lz4RIBhITe/1DpzodXNXHYvjiL/0PGuuqK3KJX+ta
         g3f2IkL543/+Uz0uaZhNBRYC3BkrwRQamJvfKgY0UK6ep77WlNkBaEkbtVLAwK5WiZ1g
         H7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWVLbwK9xDZfC1wqWYX4j2J1o6P90T7Dmd8IKrS1MfdRPjsgSiKL1zzwtWCdRcbG10x5fc=@vger.kernel.org, AJvYcCWsRQM2Z5Mo4ihYZWEwi0ccEOVpRXyV22e81L0nHWQfpUoJ0KElNS2CAGdxVy6uhq2UmGRoYoWA@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxWkjAnyhp+hdcn3ZB00ErkjIxCbUjmgsQXWha3esDW2x6a4I
	JuTK0iyOkkNI6U5Qcn9JlyfI6Mf/3GgYb6iZiltjJslqsZIp9sK8
X-Gm-Gg: ASbGncuZFDR/WDt0ygEYymdwfONlxR4w9l1D1updXoDDEyYQZKQFD8cmO+rOieYzvbw
	iSCLsjXc4ihwZfKmOOjUa028GgiUCqNjbU9wXYHRHwqUV6qj2uVTdzW4Rhp1COib6YDM3NMFUhT
	5NIPiKutRJCg27Y/KEI5ucnxYj40H7fr8K3fEbJ+smV6nAdEufKVhiBwFCLp5RD01qORaYd1ckm
	JdWloWR/P+fKQs5AogypT+NPVG/rMwzt4Ur00/awf4ZrF1x2Z1T81m31GR+9wlvBiei0/eLzHlC
	rEgXTDMxmxcEs6gXyL0YeXAAPKgnUgw3DbgKe9t6g6cJ
X-Google-Smtp-Source: AGHT+IFTn/3YRHFEhIEuXBYfveNpG911n8tz7h0qc3UcYP9adi1ViVPh9fIv1rRDRodHcVoJYgSsXw==
X-Received: by 2002:a17:90b:3509:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-3057a5a14a4mr1641907a91.1.1743634874882;
        Wed, 02 Apr 2025 16:01:14 -0700 (PDT)
Received: from gmail.com ([98.97.40.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e45fsm1140155ad.135.2025.04.02.16.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:01:14 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:00:56 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
	willemb@google.com, jakub@cloudflare.com, davem@davemloft.net,
	kuba@kernel.org, horms@kernel.org, daniel@iogearbox.net,
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stfomichev@gmail.com, mrpre@163.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2 1/2] bpf, sockmap: Avoid sk_prot reset on sockmap
 unlink with ULP set
Message-ID: <20250402230056.6xobt4gwpfnqorzp@gmail.com>
References: <20250331012126.1649720-1-dongchenchen2@huawei.com>
 <20250331012126.1649720-2-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331012126.1649720-2-dongchenchen2@huawei.com>

On 2025-03-31 09:21:25, Dong Chenchen wrote:
> WARNING: CPU: 0 PID: 6558 at net/core/sock_map.c:1703 sock_map_close+0x3c4/0x480
> Modules linked in:
> CPU: 0 UID: 0 PID: 6558 Comm: syz-executor.14 Not tainted 6.14.0-rc5+ #238
> RIP: 0010:sock_map_close+0x3c4/0x480
> Call Trace:
>  <TASK>
>  inet_release+0x144/0x280
>  __sock_release+0xb8/0x270
>  sock_close+0x1e/0x30
>  __fput+0x3c6/0xb30
>  __fput_sync+0x7b/0x90
>  __x64_sys_close+0x90/0x120
>  do_syscall_64+0x5d/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The root cause is:
> bpf_prog_attach(BPF_SK_SKB_STREAM_VERDICT)
> tcp_set_ulp //set ulp after sockmap add
> 	icsk->icsk_ulp_ops = ulp_ops;
> sock_hash_update_common
>   sock_map_unref
>     sock_map_del_link
>       psock->psock_update_sk_prot(sk, psock, false);
> 	sk->sk_prot->close = sock_map_close
> sk_psock_drop
>   sk_psock_restore_proto
>     tcp_bpf_update_proto
>        tls_update //not redo sk_prot to tcp prot
> inet_release
>   sk->sk_prot->close
>     sock_map_close
>       WARN(sk->sk_prot->close == sock_map_close)
> 
> commit e34a07c0ae39 ("sock: redo the psock vs ULP protection check")
> has moved ulp check from tcp_bpf_update_proto() to psock init.
> If sk sets ulp after being added to sockmap, it will reset sk_prot to
> BPF_BASE when removed from sockmap. After the psock is dropped, it will
> not reset sk_prot back to the tcp prot, only tls context update is
> performed. This can trigger a warning in sock_map_close() due to
> recursion of sk->sk_prot->close.
> 
> To fix this issue, skip the sk_prot operations redo when deleting link
> from sockmap if ULP is set.
> 
> Fixes: e34a07c0ae39 ("sock: redo the psock vs ULP protection check")
> Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
> Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
> Changes for v2:
> - Move ULP check from sock_map_del_link() to tcp_bpf_update_proto()
> ---
>  net/ipv4/tcp_bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index ba581785adb4..01b3930947cc 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -708,6 +708,9 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  		return 0;
>  	}
>  

I think in this case we also want to update the ULP so that when it
tears down it will restore the correct proto ops?

Either tcp_bpf_update_proto should be called with restore=true or
this logic should be similar to above?

	if (inet_csk_has_ulp(sk)) {
		/* TLS does not have an unhash proto in SW cases,
		 * but we need to ensure we stop using the sock_map
		 * unhash routine because the associated psock is being
		 * removed. So use the original unhash handler.
		 */
		WRITE_ONCE(sk->sk_prot->unhash, psock->saved_unhash);
		tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);

> +	if (inet_csk_has_ulp(sk))
> +		return 0;

I'm thinking of this stack of psock/ULPs,

   TCP ops -> sockmap psock -> TLS (ULP) ops

When ULP ops was initialized it stored sockmap ops in its ctx->sk_proto
so that it if it was removed it could restore the correct ops. Similar
sockmap psock stored TCP ops to restore if its removed. So if we remove
psock in the middle we shoudl tell the ULP to update its stored value.

The concerning flow might be,

   socket insert into sockmap (gets psock)
   socket adds ULP
   socket removed from socketmap (removes psock)
   socket removes ULP (restores original tcp ops hopefully)

Perhaps we could also add a test for this case to the 2nd patch?

Thanks,
John
 

