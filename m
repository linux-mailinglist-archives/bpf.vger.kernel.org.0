Return-Path: <bpf+bounces-18613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D473A81CB7A
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFAB284CD3
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25022F06;
	Fri, 22 Dec 2023 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDQT3GtP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256A22F0D;
	Fri, 22 Dec 2023 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e593c756dso2314400e87.2;
        Fri, 22 Dec 2023 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703256345; x=1703861145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaPsk3CGkaafbpbNk0d+rIGlQWF/lZlsuE7mQYdmbLA=;
        b=TDQT3GtPwIUFlhfXGJ2cp050URKTR5MSyhQh7kvOCqQUMF7lEKUzx8I3skhg2vxXJX
         Z1Xyq7bq3I6gbv0AnU2gvK0RQs7wsYlZ3tVWY0715wBMWMBPwudlurh7ExUPu4dl8BqW
         JcQcgT38dVgVXS1YD1aWCXtS0vV9TrXZuJkrklPq0WnIV3k1ADnRFo5gMAgU8gTmGFRw
         INcN8R49IZyuQicyYbwwV6cURSo5tKQKR7IfHK3+cgP/3ihYOXcN4aFVUyd20f2kscyo
         40HGU7I2crQmUsGWuPhYoHNF60s2NLU3kn309JRWq9V+PoCfzWlPHJL/ITMb6MpuHdp/
         Luxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703256345; x=1703861145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaPsk3CGkaafbpbNk0d+rIGlQWF/lZlsuE7mQYdmbLA=;
        b=nC8sN+C2HWBpmBh4dsC6dgfU5DoQ8xwE2c4gkrk7dGjqEVwrZljVQ20zzz2uR28Jgp
         hXEn9hpQe39S9YMybclAyI8BV7ZA7Hgxn0H4GxO5c9sxl33gD/RU/rOo3E8C6NMKEZSg
         3cjHhRxJafaJImcmp/B7AdXr9Uw5ZNFMQuZl+FPpNX4a9jNGUR4iNAEEUq+ArPUQbm/6
         8Qjd00CwWkvkg3A40xAg5fmBShET3nlJAsuQfcmqyyYAkS3WAmD4vwPVMwbKYN43Zeba
         H5cNornGVIwiApBYPlr0j575479D4y9CGfUmcS2Rqdl2MtTfFsZOJaLrSO33n4gqO0pP
         +DtA==
X-Gm-Message-State: AOJu0Yxn/OsqJzE6cdmEeC5NbXmTqZV1AyHc9G/EZ4J8YuHy+ILk5ZBj
	eURlZzgK/An1gllvYq115tc=
X-Google-Smtp-Source: AGHT+IFtRqbxY2XKG15N6iNNMOaj4iOkvQP1HQHvDiIdURO+pKHZyLtCKVrM8yemCNEdy4BYpYlPHQ==
X-Received: by 2002:a19:e01e:0:b0:50e:2fee:21c8 with SMTP id x30-20020a19e01e000000b0050e2fee21c8mr623258lfg.77.1703256344959;
        Fri, 22 Dec 2023 06:45:44 -0800 (PST)
Received: from krava (host-87-27-10-76.business.telecomitalia.it. [87.27.10.76])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7da4d000000b005538f27a1a0sm2650687eds.41.2023.12.22.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:45:44 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Dec 2023 15:45:40 +0100
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com, hengqi@linux.alibaba.com,
	shung-hsi.yu@suse.com
Subject: Re: [PATCH bpf-next 1/3] bpf: implement relay map basis
Message-ID: <ZYWhFHLqwQDgI7OG@krava>
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
 <20231222122146.65519-2-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222122146.65519-2-lulie@linux.alibaba.com>

On Fri, Dec 22, 2023 at 08:21:44PM +0800, Philo Lu wrote:

SNIP

> +/* bpf_attr is used as follows:
> + * - key size: must be 0
> + * - value size: value will be used as directory name by map_update_elem
> + *   (to create relay files). If passed as 0, it will be set to NAME_MAX as
> + *   default
> + *
> + * - max_entries: subbuf size
> + * - map_extra: subbuf num, default as 8
> + *
> + * When alloc, we do not set up relay files considering dir_name conflicts.
> + * Instead we use relay_late_setup_files() in map_update_elem(), and thus the
> + * value is used as dir_name, and map->name is used as base_filename.
> + */
> +static struct bpf_map *relay_map_alloc(union bpf_attr *attr)
> +{
> +	struct bpf_relay_map *rmap;
> +
> +	if (unlikely(attr->map_flags & ~RELAY_CREATE_FLAG_MASK))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* key size must be 0 in relay map */
> +	if (unlikely(attr->key_size))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(attr->value_size > NAME_MAX)) {
> +		pr_warn("value_size should be no more than %d\n", NAME_MAX);
> +		return ERR_PTR(-EINVAL);
> +	} else if (attr->value_size == 0)
> +		attr->value_size = NAME_MAX;

the concept of no key with just value seems strange.. I never worked
with relay channels, so perhaps stupid question: but why not have one
relay channel for given key? having the debugfs like:

  /sys/kernel/debug/my_rmap/mychannel/<cpu>

> +
> +	/* set default subbuf num */
> +	attr->map_extra = attr->map_extra & UINT_MAX;
> +	if (!attr->map_extra)
> +		attr->map_extra = 8;
> +
> +	if (!attr->map_name || strlen(attr->map_name) == 0)

attr->map_name is allways != NULL

> +		return ERR_PTR(-EINVAL);
> +
> +	rmap = bpf_map_area_alloc(sizeof(*rmap), NUMA_NO_NODE);
> +	if (!rmap)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bpf_map_init_from_attr(&rmap->map, attr);
> +
> +	rmap->relay_cb.create_buf_file = create_buf_file_handler;
> +	rmap->relay_cb.remove_buf_file = remove_buf_file_handler;
> +	if (attr->map_flags & BPF_F_OVERWRITE)
> +		rmap->relay_cb.subbuf_start = subbuf_start_overwrite;
> +
> +	rmap->relay_chan = relay_open(NULL, NULL,
> +							attr->max_entries, attr->map_extra,
> +							&rmap->relay_cb, NULL);

wrong indentation

> +	if (!rmap->relay_chan)
> +		return ERR_PTR(-EINVAL);
> +
> +	return &rmap->map;
> +}
> +
> +static void relay_map_free(struct bpf_map *map)
> +{
> +	struct bpf_relay_map *rmap;
> +
> +	rmap = container_of(map, struct bpf_relay_map, map);
> +	relay_close(rmap->relay_chan);
> +	debugfs_remove_recursive(rmap->relay_chan->parent);
> +	kfree(rmap);

should you use bpf_map_area_free instead?

jirka

> +}
> +
> +static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static long relay_map_update_elem(struct bpf_map *map, void *key, void *value,
> +				   u64 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static long relay_map_delete_elem(struct bpf_map *map, void *key)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int relay_map_get_next_key(struct bpf_map *map, void *key,
> +				    void *next_key)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static u64 relay_map_mem_usage(const struct bpf_map *map)
> +{
> +	struct bpf_relay_map *rmap;
> +	u64 usage = sizeof(struct bpf_relay_map);
> +
> +	rmap = container_of(map, struct bpf_relay_map, map);
> +	usage += sizeof(struct rchan);
> +	usage += (sizeof(struct rchan_buf) + rmap->relay_chan->alloc_size)
> +			 * num_online_cpus();
> +	return usage;
> +}
> +
> +BTF_ID_LIST_SINGLE(relay_map_btf_ids, struct, bpf_relay_map)
> +const struct bpf_map_ops relay_map_ops = {
> +	.map_meta_equal = bpf_map_meta_equal,
> +	.map_alloc = relay_map_alloc,
> +	.map_free = relay_map_free,
> +	.map_lookup_elem = relay_map_lookup_elem,
> +	.map_update_elem = relay_map_update_elem,
> +	.map_delete_elem = relay_map_delete_elem,
> +	.map_get_next_key = relay_map_get_next_key,
> +	.map_mem_usage = relay_map_mem_usage,
> +	.map_btf_id = &relay_map_btf_ids[0],
> +};
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1bf9805ee185..35ae54ac6736 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1147,6 +1147,7 @@ static int map_create(union bpf_attr *attr)
>  	}
>  
>  	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
> +	    attr->map_type != BPF_MAP_TYPE_RELAY &&
>  	    attr->map_extra != 0)
>  		return -EINVAL;
>  
> -- 
> 2.32.0.3.g01195cf9f
> 

