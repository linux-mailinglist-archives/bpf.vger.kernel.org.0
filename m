Return-Path: <bpf+bounces-58465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5671ABB155
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC901739D7
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2421C17D;
	Sun, 18 May 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZbCLbce"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478CE1373;
	Sun, 18 May 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747594115; cv=none; b=DXqj882coGfTjxMasNuFcsN2QC5WefOgYbjzjq8L0lXK1CZC+PgB7+uds1CzSkt+3k6K97LHKE2A+kfkTKQYDbvaPoYvhp06Tc4i1D8yb3rdGti+Uj2XuCu5sh+TS85NI4wXRj6hXO8+KlZdZrwOq/MGd0eVlDCuBPtFhki2HJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747594115; c=relaxed/simple;
	bh=gS1VEGiPowwxWN2Jb0/+xH16i848Y8FN/BYCnT5X5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7TSlp0sZa02Ut0U3oeEFCevmbmtgjryR5gUlz9vUgR48p2Lp9vRuuArw9W70puHwangzTp35omG3SRd6IPpmGTOLgF3HKKnmqpqMqPut1QoqGQq9C4DUEpkfzhbbsZ9zx+RR/QDrTe6uBmlGTNRKA3G0t0KIQqBhZrgo+URARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZbCLbce; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26f5cd984cso1928605a12.3;
        Sun, 18 May 2025 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747594113; x=1748198913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdJv4YRH0LF+qEVhNWiI9qZKzNeQBOlfoe8LQVeqwOI=;
        b=HZbCLbcekkMQBJXHpf3SZEiiliFmi4dPCKYMs+1ks8Gzp5L9X0ggqbztrYFwoFyPct
         SXmTNKcH5+ukUOKOZE5PfU3Gbm3aWMvmEqvE4R7YT5nCRcM0xIs9/tCBS/Dzqo7ESgLP
         x/ZyLn2nSFhsv6DpxU+ZyQksJwhjXMxlhdRUcW8/JaQiIbjxlrLHY2nooCdUcY/QeoGm
         gpVCBnFiRFzsEJMw68n+Bn5UjgBwEyrvCa9gZZn9icSnamvIBJHGB5N0yGkUxZ10RjXw
         gy+KI41xzL8G4Jq0pC2A1uQGx0jOrL8pnsrl/OlFwi74H4N9VZKiUezY2dto+hwVZ//s
         ZUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747594113; x=1748198913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdJv4YRH0LF+qEVhNWiI9qZKzNeQBOlfoe8LQVeqwOI=;
        b=Q4Vi6A821EnO8JGZtSDB9qQsTDQthQg+g25UntNjwLFyGZ9omxtzViSrxQFrtnOMmj
         RN5HS3MaRVbI8xyr05HO2ceOI9/u5gXjoHT4lGzJBKerCkIEEQBpMgBkj/5cBSAS6Ut+
         qilYcmMaZD5Lt/oelPD0TtKKZmV7tPuQ7zN/anfxxW26X6DPJP7iBmBawZ5AFJb/6Zm2
         ciSVj5bYb8ERXLMOhK8nWbK9qjs7VOmuH+AK0s4Bleeuw6GJ4EisAuJJrLwbVPdBzdGU
         eaxYf4KzSwJpKcbG9jEdddzSreAOtkxvechg6EUThNvhTvHxv1QhnbVIgatfp0aiASMf
         ZPQA==
X-Forwarded-Encrypted: i=1; AJvYcCVsfj8RChZOsMpYXmmi7VFJEoR1Gv27I5r6bpaEudGDQVz97L3QZBtUp7Q+Lgu93evRkatCyJaRS8BoXr8=@vger.kernel.org, AJvYcCWfh16cZz7Hlwl354Z2Yt0Y46mjku8+/z7W++uwpywiW5NH6YRneXEB4XNtxEOU9FF1TgvfwqDf@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSA1Hl/rHLyHGrCyp7hkPEkBGPAHRHjshbMjAVp13VC6BMdBS
	k4JMsIq23WOMhpztRH24ETJ9fNGQK45wtEFZk7KZDFuKZKvwbyql2rIU
X-Gm-Gg: ASbGncvuOgXnmUUliibc5fMQ3+zXxICafTrTfWpBUp//a9uVV61bpogYq5kOn54qVOe
	WRwd4w1bjRb6ZHoG/+PF7fT+sfZ89JJImfTJE6gYxmi0cw3/p8/7U+ZtCscj98jpBm6yYvU7A9n
	nS/WxBEjKXsdRownDeeebUedlYxh+SNMQXJbipvUlwFnTDxHPAr/zZpx/VNKb73LjJURvCHRsN+
	Vy54ccIfJMf9VaNxZw4A9nNIhCVCVNSMUaRvUiU28SuWz/vc/yt5HLas2h1HJBc94mnuIekymkP
	uBNk7fW3GIKlF1S3FHVZiRX8WhXS/oXsAKWLLadQ+t6Yud8V+zXi41+ERA==
X-Google-Smtp-Source: AGHT+IEbtsSTAhA5HI8Cj3BFN2PPge6wTU+eaOuo6Fk7YaYF2EQ9GThOrkOIpHbK3+os0chpFb2c3g==
X-Received: by 2002:a17:903:3d07:b0:224:a96:e39 with SMTP id d9443c01a7336-231d438b420mr150253565ad.9.1747594113434;
        Sun, 18 May 2025 11:48:33 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6a86:3458:a742:d44e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8bbsm46108135ad.90.2025.05.18.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 11:48:32 -0700 (PDT)
Date: Sun, 18 May 2025 11:48:31 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Fix concurrency issues between
 memory charge and uncharge
Message-ID: <aCorf4Cq3Fuwiw2h@pop-os.localdomain>
References: <20250508062423.51978-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508062423.51978-1-jiayuan.chen@linux.dev>

On Thu, May 08, 2025 at 02:24:22PM +0800, Jiayuan Chen wrote:
> Triggering WARN_ON_ONCE(sk->sk_forward_alloc) by running the following
> command, followed by pressing Ctrl-C after 2 seconds:
> ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
> '''
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 40 at net/ipv4/af_inet.c inet_sock_destruct
> 
> Call Trace:
> <TASK>
> __sk_destruct+0x46/0x222
> sk_psock_destroy+0x22f/0x242
> process_one_work+0x504/0x8a8
> ? process_one_work+0x39d/0x8a8
> ? __pfx_process_one_work+0x10/0x10
> ? worker_thread+0x44/0x2ae
> ? __list_add_valid_or_report+0x83/0xea
> ? srso_return_thunk+0x5/0x5f
> ? __list_add+0x45/0x52
> process_scheduled_works+0x73/0x82
> worker_thread+0x1ce/0x2ae
> '''
> 
> Reason:
> When we are in the backlog process, we allocate sk_msg and then perform
> the charge process. Meanwhile, in the user process context, the recvmsg()
> operation performs the uncharge process, leading to concurrency issues
> between them.
> 
> The charge process (2 functions):
> 1. sk_rmem_schedule(size) -> sk_forward_alloc increases by PAGE_SIZE
>                              multiples
> 2. sk_mem_charge(size)    -> sk_forward_alloc -= size
> 
> The uncharge process (sk_mem_uncharge()):
> 3. sk_forward_alloc += size
> 4. check if sk_forward_alloc > PAGE_SIZE
> 5. reclaim    -> sk_forward_alloc decreases, possibly becoming 0
> 
> Because the sk performing charge and uncharge is not locked
> (mainly because the backlog process does not lock the socket), therefore,
> steps 1 to 5 will execute concurrently as follows:
> 
> cpu0                                cpu1
> 1
>                                     3
>                                     4   --> sk_forward_alloc >= PAGE_SIZE
>                                     5   --> reclaim sk_forward_alloc
> 2 --> sk_forward_alloc may
>       become negative
> 
> Solution:
> 1. Add locking to the kfree_sk_msg() process, which is only called in the
>    user process context.
> 2. Integrate the charge process into sk_psock_create_ingress_msg() in the
>    backlog process and add locking.
> 3. Reuse the existing psock->ingress_lock.

Reusing the psock->ingress_lock looks weird to me, as it is intended for
locking ingress queue, at least at the time it was introduced.

And technically speaking, it is the sock lock which is supposed to serialize
socket charging.

So is there any better solution here?

Thanks.

