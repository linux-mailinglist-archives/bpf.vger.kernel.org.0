Return-Path: <bpf+bounces-62722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A3AFDBE6
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6E45678F3
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D197A238166;
	Tue,  8 Jul 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUWylyJt"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD121D3E1
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752017994; cv=none; b=COSSnVlWDh34LQyCj1oi988LPgkG+WxGEbWBCEcAKB1m6L5F96PqUN0N1lr+ICXAl8vryNpEvCSuPUq4tKcrLCHZNoIpHclp47SBJwwtEtMFDZdCIzNVcANhdLXquMR4AAHpCZPzBZHs5vtkbTZlFupeVM20Y2w7iLOE78h2tVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752017994; c=relaxed/simple;
	bh=kPlcl0UL1/YHn8lVBNf78f8iM01u/eqDoYJib+acUWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwYdJWuyEFoRFMmmNCNL5mlObfEuGr2OF+WJUH84tYUCNl+OAa0r6OpWvI1/DsTxbCNduhjo2U8lS4KZkXLsB7GDAdph0jkCkVahGkMNxGhr/lPAK1p2pbtKm6yo4G+9CIdj7vyU/fipI0pczVp9gfNL4hVJSTrr+MQtbQBdjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUWylyJt; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca23af7b-28cf-4453-bd53-c0507b3b4e8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752017989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gzvTyswj6fAUCWbrWxlcdNwIKwGy7exrEHiNNMIq0c=;
	b=QUWylyJtlQrI6jhfv2y66UeWYfk3XGZ88eHBLLAfYamdRkXOW/8cVEFXoHIlXbeBJ6n1kM
	a+zpdPHvh70dHlYyAzcKF53cPaZ/YJ65tJAdUtkB4o1UnJKJqh2ft5hpXoGw+ujmYKNLJs
	GkqIdNMaPTV0bVzWkYg7olB2WVvCm8I=
Date: Tue, 8 Jul 2025 16:39:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy
 test program
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250707155102.672692-1-jordan@jrife.io>
 <20250707155102.672692-12-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250707155102.672692-12-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/7/25 8:50 AM, Jordan Rife wrote:
> Prepare for bucket resume tests for established TCP sockets by creating
> a program to immediately destroy and remove sockets from the TCP ehash
> table, since close() is not deterministic.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>   .../selftests/bpf/progs/sock_iter_batch.c     | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> index a36361e4a5de..14513aa77800 100644
> --- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> +++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> @@ -70,6 +70,28 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
>   	return 0;
>   }
>   
> +int bpf_sock_destroy(struct sock_common *sk) __ksym;

A nit.

The kfunc declaration should be already in the vmlinux.h, so this line is no 
longer needed. The bpf CI has the new pahole for this.

> +volatile const __u64 destroy_cookie;
> +
> +SEC("iter/tcp")
> +int iter_tcp_destroy(struct bpf_iter__tcp *ctx)
> +{
> +	struct sock_common *sk_common = (struct sock_common *)ctx->sk_common;
> +	__u64 sock_cookie;
> +
> +	if (!sk_common)
> +		return 0;
> +
> +	sock_cookie = bpf_get_socket_cookie(sk_common);
> +	if (sock_cookie != destroy_cookie)
> +		return 0;
> +
> +	bpf_sock_destroy(sk_common);
> +	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
> +
> +	return 0;
> +}
> +
>   #define udp_sk(ptr) container_of(ptr, struct udp_sock, inet.sk)
>   
>   SEC("iter/udp")


