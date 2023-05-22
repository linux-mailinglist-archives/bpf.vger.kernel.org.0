Return-Path: <bpf+bounces-1028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853FD70C310
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598AF1C20B3E
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190FC16402;
	Mon, 22 May 2023 16:12:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5A154A9
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 16:12:51 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13EED
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 09:12:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f607e60902so5295745e9.2
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684771969; x=1687363969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ze7SiVr+/WpvbvKSsv/T7r7gNdpq9Dap2Pb1JAqNCO0=;
        b=P3eJSj6Uo0XgF8ApFBKGAh0N/7YZN5xIPn1msZF0batDDiY1ytksOrPZkyYKMGhOkw
         ygED7Jx7/EC40absRo921WCzlyAvweoMqQVBZLuD1i4IZajxOaffhrMUeenIqlwx4VBF
         g+s5R0FyUlBHOuu1GjSfGMhlIPJ7U7pvZpvPUp1xmvnGPHqhQNeZ+KasV1vmPV+So1I8
         O86damHbB6JQBozlWOUdIe4HZ/DerNrx8Jw54dv1esrd34nTo0LsOFkMJHrAVZlULtZx
         guhMT/slSsqRAGLKO8ZKbmlxD+ASFcQAuns+hnMcuOCR6qLPnos4OLwdkfVQi6EccfsZ
         O64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684771969; x=1687363969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze7SiVr+/WpvbvKSsv/T7r7gNdpq9Dap2Pb1JAqNCO0=;
        b=UU6/VdqNStSxcVWQkW+9RE1SAgK4f5OfIDLVmiV7RN4Gfo0nWvQbeP0XHcP6N0HnXK
         ziAHruZSOYuBzDPcaOsVo8UbiJoFeCbH7/sMfGAfieGrpbzth3n2KqK3x4x5PXrRSLPg
         xExRqa0Q0dNYUauPL7+XJMI6XdBLm2JBGhmn77OJ5bSIOovylbS4dtXzRpXvuXZDIO/L
         DIWU3mzB6lLCZiAqg6SGN49mWsM+4d1ipQ5SRXfhzFhqWn/bk4qdoV7cYAvrwcmdUuWc
         0856CQO7tWizhXaZ43rAF4FikYU1hJjpgJY671WZU8doT03HCKETeQxjV/NO5FV4igQ7
         GW5g==
X-Gm-Message-State: AC+VfDwEb4IVkrbB1TuQ1KonE/Lim6TnFLDYYt44Xle5f8LGjBcXrRkb
	emDLy+AEvG/9g01qw5Eg7adM4e8S9gXzhWZRZ/SuSw==
X-Google-Smtp-Source: ACHHUZ7dW3A3RZIwlFK40XhBqEH7dzvx+lsn812JCL4yb/FYwRw0ThlXb+an/zQVbMX4d4LQvntyrQ==
X-Received: by 2002:a05:600c:294b:b0:3f4:2d22:536a with SMTP id n11-20020a05600c294b00b003f42d22536amr7871977wmd.19.1684771968760;
        Mon, 22 May 2023 09:12:48 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id c5-20020a7bc845000000b003f604793989sm3554531wml.18.2023.05.22.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:12:48 -0700 (PDT)
Date: Mon, 22 May 2023 16:12:58 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf] bpf: fix a memory leak in the LRU and LRU_PERCPU
 hash maps
Message-ID: <ZGuUii1nfyvXzX4g@zh-lab-node-5>
References: <20230522154558.2166815-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522154558.2166815-1-aspsk@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 22, 2023 at 03:45:58PM +0000, Anton Protopopov wrote:
> The LRU and LRU_PERCPU maps allocate a new element on update before locking the
> target hash table bucket. Right after that the maps try to lock the bucket.
> If this fails, then maps return -EBUSY to the caller without releasing the
> allocated element. This makes the element untracked: it doesn't belong to
> either of free lists, and it doesn't belong to the hash table, so can't be
> re-used; this eventually leads to the permanent -ENOMEM on LRU map updates,
> which is unexpected. Fix this by returning the element to the local free list
> if bucket locking fails.

Fixes: 20b6cc34ea74 ("bpf: Avoid hashtab deadlock with map_locked")

> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/hashtab.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 00c253b84bf5..9901efee4339 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1215,7 +1215,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
> 
>  	ret = htab_lock_bucket(htab, b, hash, &flags);
>  	if (ret)
> -		return ret;
> +		goto err_lock_bucket;
>  
>  	l_old = lookup_elem_raw(head, hash, key, key_size);
>  
> @@ -1236,6 +1236,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>  err:
>  	htab_unlock_bucket(htab, b, hash, flags);
>  
> +err_lock_bucket:
>  	if (ret)
>  		htab_lru_push_free(htab, l_new);
>  	else if (l_old)
> @@ -1338,7 +1339,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  
>  	ret = htab_lock_bucket(htab, b, hash, &flags);
>  	if (ret)
> -		return ret;
> +		goto err_lock_bucket;
>  
>  	l_old = lookup_elem_raw(head, hash, key, key_size);
>  
> @@ -1361,6 +1362,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  	ret = 0;
>  err:
>  	htab_unlock_bucket(htab, b, hash, flags);
> +err_lock_bucket:
>  	if (l_new)
>  		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
>  	return ret;
> -- 
> 2.34.1
> 

