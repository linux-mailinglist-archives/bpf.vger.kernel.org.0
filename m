Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB4342702
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 21:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCSUgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 16:36:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:45492 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCSUgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 16:36:06 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lNLqi-0005Kx-GZ; Fri, 19 Mar 2021 21:36:00 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lNLqi-00088c-9y; Fri, 19 Mar 2021 21:36:00 +0100
Subject: Re: [PATCH v3 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>, bpf@vger.kernel.org
Cc:     juraj.vijtiuk@sartura.hr, luka.oreskovic@sartura.hr,
        luka.perkov@sartura.hr, yhs@fb.com
References: <YFDudWFj9zydyo/P@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2f5f29ed-354b-b88d-f5cb-535d61aaaf0e@iogearbox.net>
Date:   Fri, 19 Mar 2021 21:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YFDudWFj9zydyo/P@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26113/Fri Mar 19 12:14:45 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/16/21 6:44 PM, Denis Salopek wrote:
[...]
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c859bc46d06c..36f65b589b82 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1463,7 +1463,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>   	return err;
>   }
>   
> -#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
> +#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD flags
>   
>   static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   {
> @@ -1479,6 +1479,9 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   	if (CHECK_ATTR(BPF_MAP_LOOKUP_AND_DELETE_ELEM))
>   		return -EINVAL;
>   
> +	if (attr->flags & ~BPF_F_LOCK)
> +		return -EINVAL;
> +
>   	f = fdget(ufd);
>   	map = __bpf_map_get(f);
>   	if (IS_ERR(map))
> @@ -1489,13 +1492,19 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   		goto err_put;
>   	}
>   
> +	if ((attr->flags & BPF_F_LOCK) &&
> +	    !map_value_has_spin_lock(map)) {
> +		err = -EINVAL;
> +		goto err_put;
> +	}
> +
>   	key = __bpf_copy_key(ukey, map->key_size);
>   	if (IS_ERR(key)) {
>   		err = PTR_ERR(key);
>   		goto err_put;
>   	}
>   
> -	value_size = map->value_size;
> +	value_size = bpf_map_value_size(map);
>   
>   	err = -ENOMEM;
>   	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
> @@ -1505,6 +1514,17 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>   	    map->map_type == BPF_MAP_TYPE_STACK) {
>   		err = map->ops->map_pop_elem(map, value);
> +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
> +		if (!bpf_map_is_dev_bound(map)) {

I think you probably rather meant to fold the above !bpf_map_is_dev_bound(map)
condition into the higher level 'else if', right? Otherwise for dev bound maps
you'll always end up with -ENOMEM error rather than -ENOTSUPP.

> +			bpf_disable_instrumentation();
> +			rcu_read_lock();
> +			err = map->ops->map_lookup_and_delete_elem(map, key, value, attr->flags);
> +			rcu_read_unlock();
> +			bpf_enable_instrumentation();
> +		}
>   	} else {
>   		err = -ENOTSUPP;
>   	}
