Return-Path: <bpf+bounces-70488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF57BC01CB
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 05:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D046D4E1E15
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE32217722;
	Tue,  7 Oct 2025 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sHtHr9+4"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C520322;
	Tue,  7 Oct 2025 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759808999; cv=none; b=pS4VVmPE8xkTVWZrQ1nFY+yMJ1RNrw2PqVWoUrFNKjpv53aXpoC8MHV45Zq65OYTIKprOzE9EHb0paFpGP9s+jA3tSqnJ822Bu1+kGT+jKilRv8QJYTkbAbthKuO148SP/aQSNo/I7D6p3DEAuEyZHLejen0Bev/WOvFoYUUdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759808999; c=relaxed/simple;
	bh=cNlI9bHI/ylXQMlNzU+Ogaqapl/G/HUfveqiYuJSf9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo72pXW0AAGod40o9kL3Ent3G44I/oNog9TT9ZPdOEHpBLzDNgMZ8o3wk83kVQEC/PUXwRXZNcd89vRQ74wse8MMSmHhy5NLG6XfCp+frreT87+imLn4LGgbKguFoAZ+5Pvxpc3EVG5/GeW2geS0HJZfrPOnPSw9Yl1b8qFJn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sHtHr9+4; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759808994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hiokzts7PCRKt1OVuEkEGfOq4GhsmdPG6MMIx7taoM=;
	b=sHtHr9+4cBBh32A4cQH2VvK5uHIQpnTYzLql6prkqaJLjI/AtwzFWxpGRZTH188yEsCX9e
	fe7RzXPZ0LP/zmMJludJbuFqY8x/U2qXtxpqTaSgGuiFLKxT6OGYnGFHPY+Yx97OOjFqVU
	/tv2iMaa4OYCXP5muCy+TCQcYvYIUho=
From: Menglong Dong <menglong.dong@linux.dev>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, martin.lau@kernel.org,
 houtao1@huawei.com, jkangas@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>,
 bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] bpf: Use rcu_read_lock_dont_migrate() and and
 rcu_read_unlock_migrate()
Date: Tue, 07 Oct 2025 11:49:42 +0800
Message-ID: <3379803.44csPzL39Z@7950hx>
In-Reply-To: <20251005150816.38799-1-wangfushuai@baidu.com>
References: <20251005150816.38799-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/5 23:08, Fushuai Wang wrote:
> Replace the combination of migrate_disable()/migrate_enable() and rcu_read_lock()/rcu_read_unlock()
> with rcu_read_lock_dont_migrate()/rcu_read_unlock_migrate() in bpf_sk_storage.c.

Hi, Fushuai. There are some nits in you patch:

1. The title is too fuzzy. It can be
    "bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c"
2. You can wrap the commit log and don't exceed 75 character per line.
    This is not necessary, but it can stop the check_patch from
    complaining.

And I think you shoud CC bpf@vger.kernel.org too. Before you
send the patch, you can check it with ./scripts/checkpatch.pl to
find potential problems.

Thanks!
Menglong Dong

> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  net/core/bpf_sk_storage.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 2e538399757f..bdb70cf89ae1 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -50,16 +50,14 @@ void bpf_sk_storage_free(struct sock *sk)
>  {
>  	struct bpf_local_storage *sk_storage;
>  
> -	migrate_disable();
> -	rcu_read_lock();
> +	rcu_read_lock_dont_migrate();
>  	sk_storage = rcu_dereference(sk->sk_bpf_storage);
>  	if (!sk_storage)
>  		goto out;
>  
>  	bpf_local_storage_destroy(sk_storage);
>  out:
> -	rcu_read_unlock();
> -	migrate_enable();
> +	rcu_read_unlock_migrate();
>  }
>  
>  static void bpf_sk_storage_map_free(struct bpf_map *map)
> @@ -161,8 +159,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  
>  	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
>  
> -	migrate_disable();
> -	rcu_read_lock();
> +	rcu_read_lock_dont_migrate();
>  	sk_storage = rcu_dereference(sk->sk_bpf_storage);
>  
>  	if (!sk_storage || hlist_empty(&sk_storage->list))
> @@ -213,9 +210,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  	}
>  
>  out:
> -	rcu_read_unlock();
> -	migrate_enable();
>  
> +	rcu_read_unlock_migrate();
>  	/* In case of an error, don't free anything explicitly here, the
>  	 * caller is responsible to call bpf_sk_storage_free.
>  	 */
> 





