Return-Path: <bpf+bounces-18634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033181D14C
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 03:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD09B1F23C1C
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 02:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9FAECB;
	Sat, 23 Dec 2023 02:55:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B5A59;
	Sat, 23 Dec 2023 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vz09ZQG_1703300087;
Received: from 30.236.12.129(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz09ZQG_1703300087)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 10:54:49 +0800
Message-ID: <a4794c5d-3e3f-4210-a26f-000ad68d6799@linux.alibaba.com>
Date: Sat, 23 Dec 2023 10:54:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: implement relay map basis
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 hengqi@linux.alibaba.com, shung-hsi.yu@suse.com
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
 <20231222122146.65519-2-lulie@linux.alibaba.com> <ZYWhFHLqwQDgI7OG@krava>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <ZYWhFHLqwQDgI7OG@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/22 22:45, Jiri Olsa wrote:
> On Fri, Dec 22, 2023 at 08:21:44PM +0800, Philo Lu wrote:
> 
> SNIP
> 
>> +/* bpf_attr is used as follows:
>> + * - key size: must be 0
>> + * - value size: value will be used as directory name by map_update_elem
>> + *   (to create relay files). If passed as 0, it will be set to NAME_MAX as
>> + *   default
>> + *
>> + * - max_entries: subbuf size
>> + * - map_extra: subbuf num, default as 8
>> + *
>> + * When alloc, we do not set up relay files considering dir_name conflicts.
>> + * Instead we use relay_late_setup_files() in map_update_elem(), and thus the
>> + * value is used as dir_name, and map->name is used as base_filename.
>> + */
>> +static struct bpf_map *relay_map_alloc(union bpf_attr *attr)
>> +{
>> +	struct bpf_relay_map *rmap;
>> +
>> +	if (unlikely(attr->map_flags & ~RELAY_CREATE_FLAG_MASK))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* key size must be 0 in relay map */
>> +	if (unlikely(attr->key_size))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (unlikely(attr->value_size > NAME_MAX)) {
>> +		pr_warn("value_size should be no more than %d\n", NAME_MAX);
>> +		return ERR_PTR(-EINVAL);
>> +	} else if (attr->value_size == 0)
>> +		attr->value_size = NAME_MAX;
> 
> the concept of no key with just value seems strange.. I never worked
> with relay channels, so perhaps stupid question: but why not have one
> relay channel for given key? having the debugfs like:
> 
>    /sys/kernel/debug/my_rmap/mychannel/<cpu>
> 
Here, a relay map is actually a relay channel, which includes buffers 
for all cpus. And I think 2 levels is enough when we use relay map in 
`/sys/kernel/debug/`: <dir_name>/<map_name>[#cpu]. The `dir_name` is 
necessary because user could use the same `map_name` in different bpf 
programs, and we can use it as an additional tag to distinguish them. 
The `dir_name` is set by user with relay_map_update_elem.

Here is an example. Assume we have 2 relay maps (rmap_a and rmap_b) and 
2 cpus, the debugfs will be like:
```
/sys/kernel/debug/<dir_name1>/rmap_a0
/sys/kernel/debug/<dir_name1>/rmap_a1
/sys/kernel/debug/<dir_name2>/rmap_b0
/sys/kernel/debug/<dir_name2>/rmap_b1
```

So I think the key point here is that we just need one field to set the 
`dir_name`, either key or value. I chose key as NULL because I think it 
suggests "Normally map_update_elem should be invoked just once for a 
relay map". But I think it okay to use key instead, and value as NULL.

>> +
>> +	/* set default subbuf num */
>> +	attr->map_extra = attr->map_extra & UINT_MAX;
>> +	if (!attr->map_extra)
>> +		attr->map_extra = 8;
>> +
>> +	if (!attr->map_name || strlen(attr->map_name) == 0)
> 
> attr->map_name is allways != NULL
> 
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	rmap = bpf_map_area_alloc(sizeof(*rmap), NUMA_NO_NODE);
>> +	if (!rmap)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	bpf_map_init_from_attr(&rmap->map, attr);
>> +
>> +	rmap->relay_cb.create_buf_file = create_buf_file_handler;
>> +	rmap->relay_cb.remove_buf_file = remove_buf_file_handler;
>> +	if (attr->map_flags & BPF_F_OVERWRITE)
>> +		rmap->relay_cb.subbuf_start = subbuf_start_overwrite;
>> +
>> +	rmap->relay_chan = relay_open(NULL, NULL,
>> +							attr->max_entries, attr->map_extra,
>> +							&rmap->relay_cb, NULL);
> 
> wrong indentation
> 
Got it. I will adjust it.

>> +	if (!rmap->relay_chan)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return &rmap->map;
>> +}
>> +
>> +static void relay_map_free(struct bpf_map *map)
>> +{
>> +	struct bpf_relay_map *rmap;
>> +
>> +	rmap = container_of(map, struct bpf_relay_map, map);
>> +	relay_close(rmap->relay_chan);
>> +	debugfs_remove_recursive(rmap->relay_chan->parent);
>> +	kfree(rmap);
> 
> should you use bpf_map_area_free instead?
> 
Thanks for catching. Will fix it.

> jirka
> 
>> +}
>> +
>> +static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>> +static long relay_map_update_elem(struct bpf_map *map, void *key, void *value,
>> +				   u64 flags)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static long relay_map_delete_elem(struct bpf_map *map, void *key)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int relay_map_get_next_key(struct bpf_map *map, void *key,
>> +				    void *next_key)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static u64 relay_map_mem_usage(const struct bpf_map *map)
>> +{
>> +	struct bpf_relay_map *rmap;
>> +	u64 usage = sizeof(struct bpf_relay_map);
>> +
>> +	rmap = container_of(map, struct bpf_relay_map, map);
>> +	usage += sizeof(struct rchan);
>> +	usage += (sizeof(struct rchan_buf) + rmap->relay_chan->alloc_size)
>> +			 * num_online_cpus();
>> +	return usage;
>> +}
>> +
>> +BTF_ID_LIST_SINGLE(relay_map_btf_ids, struct, bpf_relay_map)
>> +const struct bpf_map_ops relay_map_ops = {
>> +	.map_meta_equal = bpf_map_meta_equal,
>> +	.map_alloc = relay_map_alloc,
>> +	.map_free = relay_map_free,
>> +	.map_lookup_elem = relay_map_lookup_elem,
>> +	.map_update_elem = relay_map_update_elem,
>> +	.map_delete_elem = relay_map_delete_elem,
>> +	.map_get_next_key = relay_map_get_next_key,
>> +	.map_mem_usage = relay_map_mem_usage,
>> +	.map_btf_id = &relay_map_btf_ids[0],
>> +};
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 1bf9805ee185..35ae54ac6736 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1147,6 +1147,7 @@ static int map_create(union bpf_attr *attr)
>>   	}
>>   
>>   	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
>> +	    attr->map_type != BPF_MAP_TYPE_RELAY &&
>>   	    attr->map_extra != 0)
>>   		return -EINVAL;
>>   
>> -- 
>> 2.32.0.3.g01195cf9f
>>

