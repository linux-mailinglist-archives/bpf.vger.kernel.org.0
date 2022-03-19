Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA34DEA29
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiCSSgG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243930AbiCSSgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:36:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F02986F5
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:34:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s42so12301061pfg.0
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TTIX3VQ3vxNyia4hxAMCDVeYq4kvPPMMxqUx7FxhPS0=;
        b=QQlal+uF+iTw2OCEQDbHmYhpQpZB3oY9G+PXQN9Wr2b6jQHFunJFPd74/9gtwxhalm
         DTK8JTMXgclTjdpTFDVuhrEnoF1VK1AIaZjNbmfL9Am6Zhi3Ab4R3YjXhuArLkp7zxRT
         oyv6LH8ClGF5hh7N5+clkLjs1VvB9ZlfUIJBkddkgNFFk9Ecbe9ECAMB7tCmfn38FSKY
         o+e0oV/KIj6zgtTO++WFdeRiOqXDMjBX2oKyaLyvER7PVhKDo7aDn0lzC9LGy+B5s/m+
         7E+mEN1otqCloJqvXC9ep4O7iv0jjnamoiE4B3jtV6IQW+SPgv4U9Xc/qB+ykg4Twpy9
         geAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TTIX3VQ3vxNyia4hxAMCDVeYq4kvPPMMxqUx7FxhPS0=;
        b=vte5VmRjppDl4FPMiEqc8TSxwHYEqP/8Bru/Rr9LK7mi9zrq9VnxVOtWHqze04x6w/
         ht7w02sS7oYC9sg3pvNgBOz95WyQh8XhoZsPAE3Yae3cbfsf7WXYOLALsPdVlDAaHF1c
         vTeRPGHX7WfMwyAWjutWc4MpIAC9g7THwpWvhsH7PIieqnqOGSomaZegszMltavGZMta
         uQ1Iw4taSj+DCzo48OWHFyjol+IpY7XyG7fJWsLfjraWBDyn+eXpyumbPibBUqU4vWRP
         P3GsUiQIWKwIwJE2QMiN6Wk3EN/SidSdGxqUbaq/tlkeHwHkta3rdmzl2zvEc7zuFniN
         5FAw==
X-Gm-Message-State: AOAM530tON1yLahOCJrXY5bV+2fAKFIIGkVuIbOKQuXWMfUxWfD9zrSR
        4SGYa6OW79Pkl4CWSRQgq3Y=
X-Google-Smtp-Source: ABdhPJz7FLqudedIcpE0WM5D51Fje2SviFf/dD4LvqS7uZvNg59PgtVFtjSi0iKgthR9hly+6F/vXw==
X-Received: by 2002:a65:5b43:0:b0:382:1f25:eaef with SMTP id y3-20020a655b43000000b003821f25eaefmr9319031pgr.590.1647714883172;
        Sat, 19 Mar 2022 11:34:43 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a7f9100b001b9e4d62ed0sm15211270pjl.13.2022.03.19.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:34:42 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:34:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 08/15] bpf: Adapt copy_map_value for multiple
 offset case
Message-ID: <20220319183440.jkp25f4lo5o2xdck@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-9-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115957.3193097-9-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 05:29:50PM +0530, Kumar Kartikeya Dwivedi wrote:
> Since now there might be at most 10 offsets that need handling in
> copy_map_value, the manual shuffling and special case is no longer going
> to work. Hence, let's generalise the copy_map_value function by using
> a sorted array of offsets to skip regions that must be avoided while
> copying into and out of a map value.
> 
> When the map is created, we populate the offset array in struct map,
> with one extra element for map->value_size, which is used as the final
> offset to subtract previous offset from. Since there can only be three
> sizes, we can avoid recording the size in the struct map, and only store
> sorted offsets. Later we can determine the size for each offset by
> comparing it to timer_off and spin_lock_off, otherwise it must be
> sizeof(u64) for kptr.
> 
> Then, copy_map_value uses this sorted offset array is used to memcpy
> while skipping timer, spin lock, and kptr.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h  | 59 +++++++++++++++++++++++++-------------------
>  kernel/bpf/syscall.c | 47 +++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8ac3070aa5e6..f0f1e0d3bb2e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -158,6 +158,10 @@ struct bpf_map_ops {
>  enum {
>  	/* Support at most 8 pointers in a BPF map value */
>  	BPF_MAP_VALUE_OFF_MAX = 8,
> +	BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> +				1 + /* for bpf_spin_lock */
> +				1 + /* for bpf_timer */
> +				1,  /* for map->value_size sentinel */
>  };
>  
>  enum {
> @@ -208,7 +212,12 @@ struct bpf_map {
>  	char name[BPF_OBJ_NAME_LEN];
>  	bool bypass_spec_v1;
>  	bool frozen; /* write-once; write-protected by freeze_mutex */
> -	/* 6 bytes hole */
> +	/* 2 bytes hole */
> +	struct {
> +		u32 off[BPF_MAP_OFF_ARR_MAX];
> +		u32 cnt;
> +	} off_arr;
> +	/* 20 bytes hole */
>  
>  	/* The 3rd and 4th cacheline with misc members to avoid false sharing
>  	 * particularly with refcounting.
> @@ -252,36 +261,34 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
>  		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
>  	if (unlikely(map_value_has_timer(map)))
>  		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
> +	if (unlikely(map_value_has_kptr(map))) {
> +		struct bpf_map_value_off *tab = map->kptr_off_tab;
> +		int i;
> +
> +		for (i = 0; i < tab->nr_off; i++)
> +			*(u64 *)(dst + tab->off[i].offset) = 0;
> +	}
>  }
>  
>  /* copy everything but bpf_spin_lock and bpf_timer. There could be one of each. */
>  static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
>  {
> -	u32 s_off = 0, s_sz = 0, t_off = 0, t_sz = 0;
> -
> -	if (unlikely(map_value_has_spin_lock(map))) {
> -		s_off = map->spin_lock_off;
> -		s_sz = sizeof(struct bpf_spin_lock);
> -	}
> -	if (unlikely(map_value_has_timer(map))) {
> -		t_off = map->timer_off;
> -		t_sz = sizeof(struct bpf_timer);
> -	}
> -
> -	if (unlikely(s_sz || t_sz)) {
> -		if (s_off < t_off || !s_sz) {
> -			swap(s_off, t_off);
> -			swap(s_sz, t_sz);
> -		}
> -		memcpy(dst, src, t_off);
> -		memcpy(dst + t_off + t_sz,
> -		       src + t_off + t_sz,
> -		       s_off - t_off - t_sz);
> -		memcpy(dst + s_off + s_sz,
> -		       src + s_off + s_sz,
> -		       map->value_size - s_off - s_sz);
> -	} else {
> -		memcpy(dst, src, map->value_size);
> +	int i;
> +
> +	memcpy(dst, src, map->off_arr.off[0]);
> +	for (i = 1; i < map->off_arr.cnt; i++) {
> +		u32 curr_off = map->off_arr.off[i - 1];
> +		u32 next_off = map->off_arr.off[i];
> +		u32 curr_sz;
> +
> +		if (map_value_has_spin_lock(map) && map->spin_lock_off == curr_off)
> +			curr_sz = sizeof(struct bpf_spin_lock);
> +		else if (map_value_has_timer(map) && map->timer_off == curr_off)
> +			curr_sz = sizeof(struct bpf_timer);
> +		else
> +			curr_sz = sizeof(u64);

Lets store size in off_arr as well.
Memory consumption of few u8-s are worth it.
Single load is faster than two if-s and a bunch of load.

> +		curr_off += curr_sz;
> +		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
>  	}
>  }
>  void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 87263b07f40b..69e8ea1be432 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -30,6 +30,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/poll.h>
> +#include <linux/sort.h>
>  #include <linux/bpf-netns.h>
>  #include <linux/rcupdate_trace.h>
>  #include <linux/memcontrol.h>
> @@ -850,6 +851,50 @@ int map_check_no_btf(const struct bpf_map *map,
>  	return -ENOTSUPP;
>  }
>  
> +static int map_off_arr_cmp(const void *_a, const void *_b)
> +{
> +	const u32 a = *(const u32 *)_a;
> +	const u32 b = *(const u32 *)_b;
> +
> +	if (a < b)
> +		return -1;
> +	else if (a > b)
> +		return 1;
> +	return 0;
> +}
> +
> +static void map_populate_off_arr(struct bpf_map *map)
> +{
> +	u32 i;
> +
> +	map->off_arr.cnt = 0;
> +	if (map_value_has_spin_lock(map)) {
> +		i = map->off_arr.cnt;
> +
> +		map->off_arr.off[i] = map->spin_lock_off;
> +		map->off_arr.cnt++;
> +	}
> +	if (map_value_has_timer(map)) {
> +		i = map->off_arr.cnt;
> +
> +		map->off_arr.off[i] = map->timer_off;
> +		map->off_arr.cnt++;
> +	}
> +	if (map_value_has_kptr(map)) {
> +		struct bpf_map_value_off *tab = map->kptr_off_tab;
> +		u32 j = map->off_arr.cnt;
> +
> +		for (i = 0; i < tab->nr_off; i++)
> +			map->off_arr.off[j + i] = tab->off[i].offset;
> +		map->off_arr.cnt += tab->nr_off;
> +	}
> +
> +	map->off_arr.off[map->off_arr.cnt++] = map->value_size;
> +	if (map->off_arr.cnt == 1)
> +		return;
> +	sort(map->off_arr.off, map->off_arr.cnt, sizeof(map->off_arr.off[0]), map_off_arr_cmp, NULL);
> +}
> +
>  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  			 u32 btf_key_id, u32 btf_value_id)
>  {
> @@ -1015,6 +1060,8 @@ static int map_create(union bpf_attr *attr)
>  			attr->btf_vmlinux_value_type_id;
>  	}
>  
> +	map_populate_off_arr(map);
> +
>  	err = security_bpf_map_alloc(map);
>  	if (err)
>  		goto free_map;
> -- 
> 2.35.1
> 

-- 
