Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0FE575AA7
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 06:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGOE6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGOE57 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 00:57:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6B237CC
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 21:57:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c6so2266535pla.6
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 21:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5CY8ZHdiWYVMq1QWx1BCAmJaT9pkYEA0RMcdHi3EfWs=;
        b=TBh6cRPcEGbKvQPtX9xrxX031xPwYEkJRsykwrHhVe4NwD0+PqhbWgMP3es7du+mWs
         3dMFx5V9YAFOUT18EdJkCUbRJin9ROEQS2S5JLjpCW6S42QQBo97YKspC+gOTSKfda8v
         PfmlyHitfCY57n/TFs2QBI43TQN5vGHhFP8zyTXAM/VzVKWPY7/Tzkpm+eGFlBmwPhuV
         7QeJZLpvYpbbx4t2c2ryVkyNAlQtzFFqUokbW0U+f6MpxluRlp7RREDgNZtBQ0BwuxUZ
         g6Dt4+mor5XYtCJq4pFwLavOVl3T9qyvqkN/oZ05V6xxF0gKGyClZScIPNftsbKAC0ok
         RAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5CY8ZHdiWYVMq1QWx1BCAmJaT9pkYEA0RMcdHi3EfWs=;
        b=AUB1demc+9bmTR7qMpVlA0B/AfWNXrlKHsIrByk4zYpAnLc6eTw8HTzOknyfE3cZao
         PdbQY5Va1uByMLjfzsbFuwbis6rsGkF5h9lhp6am6K920xE6HoORtyPGGH/Ic/PxDnEU
         L5CBXyok8Ejku5deF6/Dz6f6f3LVSY+FlRMGupZsjqbtGAUMm0cYwlWmQbB0sPbmIa9p
         J9qlfdSewh7rdftfEjS92B20nRcyJMPxm1kW8tQU4xkGFG9aAZHTPmKgR4nzhkIoDPc4
         5KATtsa8xny52NWPhm3OOw/YV+QBIIkfbelKAIXDUVUHs68aS9XbCtwhCg0Tx8McAN6+
         G/YA==
X-Gm-Message-State: AJIora/K9AtYYv4jJ69EFUGJex+YgIEzAaPi51cKJufcSvEQ7vzYVJ0J
        og1nPBe8zgwsIrM0udEWd+w=
X-Google-Smtp-Source: AGRyM1s9NXz8+eo45cMxw/WrOPm0m4Hd8y9Azox4NRfEq85bADIuMlfvYALJU8oW29PTH4c2FW4Z1w==
X-Received: by 2002:a17:90b:3911:b0:1ef:fa84:dc80 with SMTP id ob17-20020a17090b391100b001effa84dc80mr20180561pjb.7.1657861078574;
        Thu, 14 Jul 2022 21:57:58 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:f93f])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a7b8d00b001e29ddf9f4fsm2403535pjc.3.2022.07.14.21.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 21:57:57 -0700 (PDT)
Date:   Thu, 14 Jul 2022 21:57:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/4] bpf: fix potential 32-bit overflow when
 accessing ARRAY map element
Message-ID: <20220715045755.e5swvwkf6isxm7xj@macbook-pro-3.dhcp.thefacebook.com>
References: <20220714214305.3189551-1-andrii@kernel.org>
 <20220714214305.3189551-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714214305.3189551-2-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 02:43:02PM -0700, Andrii Nakryiko wrote:
> If BPF array map is bigger than 4GB, element pointer calculation can
> overflow because both index and elem_size are u32. Fix this everywhere
> by forcing 64-bit multiplication. Extract this formula into separate
> small helper and use it consistently in various places.
> 
> Speculative-preventing formula utilizing index_mask trick is left as is,
> but explicit u64 casts are added in both places.
> 
> Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/arraymap.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index fe40d3b9458f..d3dfc28dbb05 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -156,6 +156,11 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
>  	return &array->map;
>  }
>  
> +static void *array_map_elem_ptr(struct bpf_array* array, u32 index)
> +{
> +	return array->value + (u64)array->elem_size * (index & array->index_mask);
> +}
> +
>  /* Called from syscall or from eBPF program */
>  static void *array_map_lookup_elem(struct bpf_map *map, void *key)
>  {
> @@ -165,7 +170,7 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
>  	if (unlikely(index >= array->map.max_entries))
>  		return NULL;
>  
> -	return array->value + array->elem_size * (index & array->index_mask);
> +	return array->value + (u64)array->elem_size * (index & array->index_mask)
>  }
>  
>  static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
> @@ -339,7 +344,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
>  		       value, map->value_size);
>  	} else {
>  		val = array->value +
> -			array->elem_size * (index & array->index_mask);
> +			(u64)array->elem_size * (index & array->index_mask);
>  		if (map_flags & BPF_F_LOCK)
>  			copy_map_value_locked(map, val, value, false);
>  		else
> @@ -408,8 +413,7 @@ static void array_map_free_timers(struct bpf_map *map)
>  		return;
>  
>  	for (i = 0; i < array->map.max_entries; i++)
> -		bpf_timer_cancel_and_free(array->value + array->elem_size * i +
> -					  map->timer_off);
> +		bpf_timer_cancel_and_free(array_map_elem_ptr(array, i) + map->timer_off);
>  }
>  
>  /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
> @@ -420,7 +424,7 @@ static void array_map_free(struct bpf_map *map)
>  
>  	if (map_value_has_kptrs(map)) {
>  		for (i = 0; i < array->map.max_entries; i++)
> -			bpf_map_free_kptrs(map, array->value + array->elem_size * i);
> +			bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));

This is incorrect. There is no need to mask pointer here.
There is no security issue here.
