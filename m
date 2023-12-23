Return-Path: <bpf+bounces-18648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD1F81D42B
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 14:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1202A283D43
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C790D2EC;
	Sat, 23 Dec 2023 13:19:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61886D2E9;
	Sat, 23 Dec 2023 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Vz1GF6Z_1703337568;
Received: from 30.39.236.78(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz1GF6Z_1703337568)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 21:19:30 +0800
Message-ID: <2660804b-c2a0-45cd-aac3-47824d7f0afd@linux.alibaba.com>
Date: Sat, 23 Dec 2023 21:19:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpf: implement map_update_elem to init relay
 file
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, hengqi@linux.alibaba.com, shung-hsi.yu@suse.com
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
 <20231222122146.65519-3-lulie@linux.alibaba.com>
 <cb325603-4bf4-57cf-ca63-aa12580646fc@huaweicloud.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <cb325603-4bf4-57cf-ca63-aa12580646fc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/23 19:28, Hou Tao wrote:
> Hi,
> 
> On 12/22/2023 8:21 PM, Philo Lu wrote:
>> map_update_elem is used to create relay files and bind them with the
>> relay channel, which is created with BPF_MAP_CREATE. This allows users
>> to set a custom directory name. It must be used with key=NULL and
>> flag=0.
>>
>> Here is an example:
>> ```
>> struct {
>> __uint(type, BPF_MAP_TYPE_RELAY);
>> __uint(max_entries, 4096);
>> } my_relay SEC(".maps");
>> ...
>> char dir_name[] = "relay_test";
>> bpf_map_update_elem(map_fd, NULL, dir_name, 0);
>> ```
>>
>> Then, directory `/sys/kerenl/debug/relay_test` will be created, which
>> includes files of my_relay0...my_relay[#cpu]. Each represents a per-cpu
>> buffer with size 8 * 4096 B (there are 8 subbufs by default, each with
>> size 4096B).
> 
> It is a little weird. Because the name of the relay file is
> $debug_fs_root/$value_name/${map_name}xxx. Could we update it to
> $debug_fs_root/$map_name/$value_name/xxx instead ?

I think a unique directory is enough for a relay map, so currently users 
can use map_update_elem to set the directory name. Thus 
$map_name/${value_name}xxx may be better than $map_name/$value_name/xxx.

As for whether map_name or value_name is better to be used as the 
directory name, I think it more likely that different bpf programs share 
a same map_name. So value_name is currently used.

>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> ---
>>   kernel/bpf/relaymap.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
>> index d0adc7f67758..588c8de0a4bd 100644
>> --- a/kernel/bpf/relaymap.c
>> +++ b/kernel/bpf/relaymap.c
>> @@ -117,7 +117,37 @@ static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
>>   static long relay_map_update_elem(struct bpf_map *map, void *key, void *value,
>>   				   u64 flags)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_relay_map *rmap;
>> +	struct dentry *parent;
>> +	int err;
>> +
>> +	if (unlikely(flags))
>> +		return -EINVAL;
>> +
>> +	if (unlikely(key))
>> +		return -EINVAL;
>> +
>> +	rmap = container_of(map, struct bpf_relay_map, map);
>> +
> 
> Lock is needed here, because .map_update_elem can be invoked concurrently.

Got it. I will fix it in the next version.

Thanks.

>> +	/* The directory already exists */
>> +	if (rmap->relay_chan->has_base_filename)
>> +		return -EEXIST;
>> +
>> +	/* Setup relay files. Note that the directory name passed as value should
>> +	 * not be longer than map->value_size, including the '\0' at the end.
>> +	 */
>> +	((char *)value)[map->value_size - 1] = '\0';
>> +	parent = debugfs_create_dir(value, NULL);
>> +	if (IS_ERR_OR_NULL(parent))
>> +		return PTR_ERR(parent);
>> +
>> +	err = relay_late_setup_files(rmap->relay_chan, map->name, parent);
>> +	if (err) {
>> +		debugfs_remove_recursive(parent);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   static long relay_map_delete_elem(struct bpf_map *map, void *key)

