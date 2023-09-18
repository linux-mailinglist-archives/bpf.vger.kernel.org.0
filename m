Return-Path: <bpf+bounces-10324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D1D7A5257
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A01C209D4
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411126E24;
	Mon, 18 Sep 2023 18:49:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17557262A2;
	Mon, 18 Sep 2023 18:49:07 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851D109;
	Mon, 18 Sep 2023 11:49:04 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59be8a2099bso48105717b3.0;
        Mon, 18 Sep 2023 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062944; x=1695667744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBScvKSzp0uWOXXPxrbaBCIKGxV7w6c3lLSoPif2v3M=;
        b=RzqRdO5cu9lYrlarbKCuuqjyeZw8e56eGij5M1OxTJx4ebcCzaDwJV+RwQtAZZdrkd
         RBJuUIjNuGN7A2mFk1cbgPKpjyiNakeqkx+JGa7a2YuLrJ+8HfX0shHIs4U6GFtk2u8w
         67XX8ReMaoxal354JE5HZLWOSXXQ5+49dGB0x+E5Rns8WMOxVmyPJc//UQ8E14Z2cLxO
         /JG0J3TkL/Fop+Eha5BLLH8sEItJnDJD1i2BtVQRO8+E2ZSGiPtd5bx6E9El8yFirgbm
         rvJzTNPjLMIAm9lVWNQo6tzPIc8cndZ6cHDnOkY+EXd+GdnTdnK2LqIrp4ZkHAV+OPet
         zqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062944; x=1695667744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBScvKSzp0uWOXXPxrbaBCIKGxV7w6c3lLSoPif2v3M=;
        b=RLg0Jb8Hr4Q/a0+4m+HSImMDEDuengZaRy2GWqaw9ZEGqQuX/x5DNQdg63oyOATV8D
         F/7EPxznLfP68IgW5005DJTb6bP6PTsuXb1BRl+fea6DRV6R3KHAo3QH4uezQZ0BG47n
         ai4OBLzbkXV1GbDgkAibJ54/oygKtUP+cbJVgUnfXefmwsNHDad9orxIhZArp6+SbKKf
         EAJ/ivoxk4NUOCXyULATdQJxO9YhR7a+MhlnA5s913Ddmvqf/qLeZZOsB7JktC3xS2mf
         OkOL5mJ/P5iEaDUDWjqndAe2hpQUH/BW2EA2cR/fmvjn3TAiiOZC3Sh9R0JKLcqHDNOb
         +XYA==
X-Gm-Message-State: AOJu0Yw/0ktmbrxGw0caMMGDgNMeFg9QJ23Z1V5zUf+lIVehUKRszr49
	W5BHXeTXBc51svP/aXUU4m4=
X-Google-Smtp-Source: AGHT+IFlabmyCKzs3TJCwRu9pzXgXQ5gnGGWAj5UTnvOq4RVLQmMmcwqpHWTteWj40envjYp+EaoFA==
X-Received: by 2002:a81:a0c2:0:b0:586:a68b:4c9a with SMTP id x185-20020a81a0c2000000b00586a68b4c9amr11609317ywg.2.1695062943808;
        Mon, 18 Sep 2023 11:49:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cd9b:b05b:a4d3:eeda? ([2600:1700:6cf8:1240:cd9b:b05b:a4d3:eeda])
        by smtp.gmail.com with ESMTPSA id v129-20020a814887000000b0059b516ed11fsm2768725ywa.110.2023.09.18.11.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:49:03 -0700 (PDT)
Message-ID: <dc84f39f-5b13-4a7d-a26c-598227fd9a42@gmail.com>
Date: Mon, 18 Sep 2023 11:49:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bpf, sockmap: fix deadlocks in the sockhash and sockmap
Content-Language: en-US
To: Ma Ke <make_ruc2021@163.com>, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230918093620.3479627-1-make_ruc2021@163.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230918093620.3479627-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/18/23 02:36, Ma Ke wrote:
> It seems that elements in sockhash are rarely actively
> deleted by users or ebpf program. Therefore, we do not
> pay much attention to their deletion. Compared with hash
> maps, sockhash only provides spin_lock_bh protection.
> This causes it to appear to have self-locking behavior
> in the interrupt context, as CVE-2023-0160 points out.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   net/core/sock_map.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index cb11750b1df5..1302d484e769 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -928,11 +928,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
>   	struct bpf_shtab_bucket *bucket;
>   	struct bpf_shtab_elem *elem;
>   	int ret = -ENOENT;
> +	unsigned long flags;

Keep reverse xmas tree ordering?

>   
>   	hash = sock_hash_bucket_hash(key, key_size);
>   	bucket = sock_hash_select_bucket(htab, hash);
>   
> -	spin_lock_bh(&bucket->lock);
> +	spin_lock_irqsave(&bucket->lock, flags);
>   	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
>   	if (elem) {
>   		hlist_del_rcu(&elem->node);
> @@ -940,7 +941,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
>   		sock_hash_free_elem(htab, elem);
>   		ret = 0;
>   	}
> -	spin_unlock_bh(&bucket->lock);
> +	spin_unlock_irqrestore(&bucket->lock, flags);
>   	return ret;
>   }
>   

