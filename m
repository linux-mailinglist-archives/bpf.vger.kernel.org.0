Return-Path: <bpf+bounces-70977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC877BDDC7A
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8206119C2F57
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC731A81A;
	Wed, 15 Oct 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxNZF0vX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415431A7FE
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520484; cv=none; b=s3caIggtlMgGhtDbj2GhaFaVUnErNOvv/v+oREDwMmPSRG3ee74ODh67OsXTO1PrY92b+PamrdHbf4x8rs22xwlXMuDbpyu0nibgExpVRY655saCCci8L/s5IZy66fIUxfXSQ1vYxcgSTVTKdXj8fuEUOiyiLcWorP52EI5II7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520484; c=relaxed/simple;
	bh=pFoJJjJbejC2oI615aLxejF0WFZKh65MTdtQRTfljHs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/7CGfkHFaLqmwfm7bYbB+W8nYQlvxOOO8aSVsCb8CdGll0BnYmJ9iWUWbv6PNAuTiZQBaL1UhaArnPebY32FVc9WXpnESe9icIThESwkLfA2A5To4VW2SX/JMyOTPob29aKB9B2jrOBUB0TQ2eGddv3jS3JFDoBjRus8x7H9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxNZF0vX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so12826910a12.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760520481; x=1761125281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Yokmi+guvGAqBeCW7WGfZb2neFCPlmwzWK2yOyCJU=;
        b=BxNZF0vXosKAqokW6l507n7FL/7NfT1oDxc3I7KV1Mft3yqMHt/BzBqhPvZ3Cer5Ga
         6RXfFbLJgRwYlZ231Ici6KIFjTTiZhspjtxS5txH1/GGSnad+uEjcfczd/WT30xsh/6R
         h7DcGNWadQklTT0PLG+Rjz79e09MFKWmSxebFxdfHpsPRYdaR6CxKfWp1lba0L7vnuPj
         Ke9nS4OghWFU3A3Y2a5flYaNYJwNDjok0zuXJpViX1fDXvhIV3Yl9UkL0wi38aQ2yyW2
         lO/7JW1mnCBPXQyLI61qxpR0+ixJ5tlNBKO2zUWOO6k3DsgXKZJ5NisUHElVErLtn5Fx
         P4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520481; x=1761125281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2Yokmi+guvGAqBeCW7WGfZb2neFCPlmwzWK2yOyCJU=;
        b=b1BNlSmaOEDFXd3xMwJ5bXfXaxvCtMkeHG4zILPggI+mnYXp1G6yrfLrB7wnWVqNrm
         ZUBAH5s+jrvC66REW8cBCClmKnE7ZKQvOJcY66QY6570iRofnnyvD3cM0OvkigIGqGzS
         X/vGknoC9kmGJf1L9BfbroZwIQJVWW51lyA92pBg8B7sYje8EEdblFEJ6JscRl2A7AuT
         YLxgAMU70VOwchEAN/7muRGQQVich2DqIGr5IBk416bZflM6+Brji48BID416gRklwK7
         U61DdcYGr/ohlhMZzDSna2fcSoev/icbZhvkNXaD6YQMvvl3VZH1ZRyFdISwh9saTpL3
         WpXA==
X-Gm-Message-State: AOJu0YxEjI9tTLKqQjMEqbP8ptQhHWq725TPMYcN9eBxhIqxMOmci0Dc
	U8SW0lyHnCo/gqf8uTGhHbSzuiDuyrVTIWyrDEg+KpURAwdpUPAorJAv
X-Gm-Gg: ASbGncuqiNQBR0h1e5jUqDdRl2Ftbrj4aGnEXzvwUNuAed34KwqdGy9tnNj6GwcAhO8
	Ef7AGln9NfKlqI1SKSLpNqTcRGXKRtXbzJgV715EWW33UUbghNGECiwMCiCgMbZKVoYZhFfv7Hx
	SphaCsx1fJdir5UjcjjeMiR2uYq1Nyqj4HlUCS/vL7HOuyxNnqSpqwKKRgZUEvFM1lAJjF9WHmM
	S11RIaFGqVPV1XgKycVmlo0AfjqBHB+8FQA5quiWRT5/sglPdWnvjaR76JsHuFNf+qb2CCaT74Z
	TwVBKTzwfoNzqETf0NqrMD99gMF5dVEGdmp5sT9HCcUf4TeJrbo6hrSY2DlVbWpyfnXqeswLi/V
	YHrGHDVLUoEIu1Mznr0ZhU5kWeZnb3g==
X-Google-Smtp-Source: AGHT+IFVKPS95bGsL04BAYXU6uWII/sYk8x/DkLwVzzJC6vREAr+0Yi+957RfOh2nmzpO8IW9bWUxA==
X-Received: by 2002:a05:6402:57:b0:636:6801:eed7 with SMTP id 4fb4d7f45d1cf-639d5c5a767mr20056041a12.32.1760520480636;
        Wed, 15 Oct 2025 02:28:00 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235dcdasm13036147a12.6.2025.10.15.02.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:28:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Oct 2025 11:27:58 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next] bpf: consistently use bpf_rcu_lock_held()
 everywhere
Message-ID: <aO9pHt32T8BI3Rlt@krava>
References: <20251014201403.4104511-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014201403.4104511-1-andrii@kernel.org>

On Tue, Oct 14, 2025 at 01:14:03PM -0700, Andrii Nakryiko wrote:
> We have many places which open-code what's now is bpf_rcu_lock_held()
> macro, so replace all those places with a clean and short macro invocation.
> For that, move bpf_rcu_lock_held() macro into include/linux/bpf.h.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> v1->v2:
>   - move bpf_rcu_lock_held() outside of #ifdef CONFIG_BPF_SYSCALL area (kernel
>     test robot).
> 
>  include/linux/bpf.h               |  3 +++
>  include/linux/bpf_local_storage.h |  3 ---
>  kernel/bpf/hashtab.c              | 21 +++++++--------------
>  kernel/bpf/helpers.c              | 12 ++++--------
>  4 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f87fb203aaae..86afd9ac6848 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2381,6 +2381,9 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>  bool bpf_jit_bypass_spec_v1(void);
>  bool bpf_jit_bypass_spec_v4(void);
>  
> +#define bpf_rcu_lock_held() \
> +	(rcu_read_lock_held() || rcu_read_lock_trace_held() || rcu_read_lock_bh_held())
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  DECLARE_PER_CPU(int, bpf_prog_active);
>  extern struct mutex bpf_stats_enabled_mutex;
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index ab7244d8108f..782f58feea35 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -18,9 +18,6 @@
>  
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
>  
> -#define bpf_rcu_lock_held()                                                    \
> -	(rcu_read_lock_held() || rcu_read_lock_trace_held() ||                 \
> -	 rcu_read_lock_bh_held())
>  struct bpf_local_storage_map_bucket {
>  	struct hlist_head list;
>  	raw_spinlock_t lock;
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index e7a6ba04dc82..f876f09355f0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -657,8 +657,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>  	struct htab_elem *l;
>  	u32 hash, key_size;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
>  	key_size = map->key_size;
>  
> @@ -1086,8 +1085,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  		/* unknown flags */
>  		return -EINVAL;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
>  	key_size = map->key_size;
>  
> @@ -1194,8 +1192,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>  		/* unknown flags */
>  		return -EINVAL;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
>  	key_size = map->key_size;
>  
> @@ -1263,8 +1260,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>  		/* unknown flags */
>  		return -EINVAL;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
>  	key_size = map->key_size;
>  
> @@ -1326,8 +1322,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  		/* unknown flags */
>  		return -EINVAL;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
>  	key_size = map->key_size;
>  
> @@ -1404,8 +1399,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
>  	u32 hash, key_size;
>  	int ret;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
>  	key_size = map->key_size;
>  
> @@ -1440,8 +1434,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
>  	u32 hash, key_size;
>  	int ret;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
>  	key_size = map->key_size;
>  
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dea8443f782c..825280c953be 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -42,8 +42,7 @@
>   */
>  BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
>  {
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  	return (unsigned long) map->ops->map_lookup_elem(map, key);
>  }
>  
> @@ -59,8 +58,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
>  BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
>  	   void *, value, u64, flags)
>  {
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  	return map->ops->map_update_elem(map, key, value, flags);
>  }
>  
> @@ -77,8 +75,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
>  
>  BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
>  {
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  	return map->ops->map_delete_elem(map, key);
>  }
>  
> @@ -134,8 +131,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
>  
>  BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
>  {
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> -		     !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
>  }
>  
> -- 
> 2.47.3
> 
> 

