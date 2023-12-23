Return-Path: <bpf+bounces-18636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE91881D14E
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 03:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E00284F16
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 02:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A1EC7;
	Sat, 23 Dec 2023 02:56:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C6A21;
	Sat, 23 Dec 2023 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vz09Zi-_1703300143;
Received: from 30.236.12.129(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz09Zi-_1703300143)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 10:56:41 +0800
Message-ID: <d26c3522-6042-4ebd-980e-8c21166a19e6@linux.alibaba.com>
Date: Sat, 23 Dec 2023 10:56:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] bpf: introduce bpf_relay_output helper
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
 <20231222122146.65519-4-lulie@linux.alibaba.com> <ZYWhOP9og5P0W6Bl@krava>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <ZYWhOP9og5P0W6Bl@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/22 22:46, Jiri Olsa wrote:
> On Fri, Dec 22, 2023 at 08:21:46PM +0800, Philo Lu wrote:
>> Like perfbuf/ringbuf, a helper is needed to write into the buffer, named
>> bpf_relay_output, whose usage is same as ringbuf. Note that it works only
>> after relay files are set, i.e., after calling map_update_elem for the
>> created relay map.
> 
> we can't add helpers anymore, this will need to be kfunc
> check functions marked with __bpf_kfunc as examples
> 

Got it, I will change it to kfunc in the next version.

Thanks.

> jirka
> 
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> ---
>>   include/linux/bpf.h      |  1 +
>>   include/uapi/linux/bpf.h | 10 ++++++++++
>>   kernel/bpf/helpers.c     |  4 ++++
>>   kernel/bpf/relaymap.c    | 26 ++++++++++++++++++++++++++
>>   kernel/bpf/verifier.c    |  8 ++++++++
>>   kernel/trace/bpf_trace.c |  4 ++++
>>   6 files changed, 53 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 7671530d6e4e..b177122369e6 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3095,6 +3095,7 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>>   extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>>   extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>> +extern const struct bpf_func_proto bpf_relay_output_proto;
>>   
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 143b75676bd3..03c0c1953ba1 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5686,6 +5686,15 @@ union bpf_attr {
>>    *		0 on success.
>>    *
>>    *		**-ENOENT** if the bpf_local_storage cannot be found.
>> + *
>> + * long bpf_relay_output(void *map, void *data, u64 size, u64 flags)
>> + * 	Description
>> + * 		Copy *size* bytes from *data* into *map* of type BPF_MAP_TYPE_RELAY.
>> + * 		Currently, the *flags* must be 0.
>> + * 	Return
>> + * 		0 on success.
>> + *
>> + *		**-ENOENT** if the relay base_file in debugfs cannot be found.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>   	FN(unspec, 0, ##ctx)				\
>> @@ -5900,6 +5909,7 @@ union bpf_attr {
>>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>>   	FN(cgrp_storage_get, 210, ##ctx)		\
>>   	FN(cgrp_storage_delete, 211, ##ctx)		\
>> +	FN(relay_output, 212, ##ctx)		\
>>   	/* */
>>   
>>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index be72824f32b2..0c26e87ce729 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1720,6 +1720,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>>   		return &bpf_ringbuf_discard_proto;
>>   	case BPF_FUNC_ringbuf_query:
>>   		return &bpf_ringbuf_query_proto;
>> +#ifdef CONFIG_RELAY
>> +	case BPF_FUNC_relay_output:
>> +		return &bpf_relay_output_proto;
>> +#endif
>>   	case BPF_FUNC_strncmp:
>>   		return &bpf_strncmp_proto;
>>   	case BPF_FUNC_strtol:
>> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
>> index 588c8de0a4bd..f9e2e4a780df 100644
>> --- a/kernel/bpf/relaymap.c
>> +++ b/kernel/bpf/relaymap.c
>> @@ -173,6 +173,32 @@ static u64 relay_map_mem_usage(const struct bpf_map *map)
>>   	return usage;
>>   }
>>   
>> +BPF_CALL_4(bpf_relay_output, struct bpf_map *, map, void *, data, u64, size,
>> +	   u64, flags)
>> +{
>> +	struct bpf_relay_map *rmap;
>> +
>> +	/* not support any flag now */
>> +	if (unlikely(flags))
>> +		return -EINVAL;
>> +
>> +	rmap = container_of(map, struct bpf_relay_map, map);
>> +	if (!rmap->relay_chan->has_base_filename)
>> +		return -ENOENT;
>> +
>> +	relay_write(rmap->relay_chan, data, size);
>> +	return 0;
>> +}
>> +
>> +const struct bpf_func_proto bpf_relay_output_proto = {
>> +	.func		= bpf_relay_output,
>> +	.ret_type	= RET_INTEGER,
>> +	.arg1_type	= ARG_CONST_MAP_PTR,
>> +	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
>> +	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
>> +	.arg4_type	= ARG_ANYTHING,
>> +};
>> +
>>   BTF_ID_LIST_SINGLE(relay_map_btf_ids, struct, bpf_relay_map)
>>   const struct bpf_map_ops relay_map_ops = {
>>   	.map_meta_equal = bpf_map_meta_equal,
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f13008d27f35..8c8287d6ae18 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8800,6 +8800,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>>   		if (func_id != BPF_FUNC_user_ringbuf_drain)
>>   			goto error;
>>   		break;
>> +	case BPF_MAP_TYPE_RELAY:
>> +		if (func_id != BPF_FUNC_relay_output)
>> +			goto error;
>> +		break;
>>   	case BPF_MAP_TYPE_STACK_TRACE:
>>   		if (func_id != BPF_FUNC_get_stackid)
>>   			goto error;
>> @@ -8932,6 +8936,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>>   		if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF)
>>   			goto error;
>>   		break;
>> +	case BPF_FUNC_relay_output:
>> +		if (map->map_type != BPF_MAP_TYPE_RELAY)
>> +			goto error;
>> +		break;
>>   	case BPF_FUNC_get_stackid:
>>   		if (map->map_type != BPF_MAP_TYPE_STACK_TRACE)
>>   			goto error;
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 7ac6c52b25eb..5b13553c6232 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1594,6 +1594,10 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>   		return &bpf_ringbuf_discard_proto;
>>   	case BPF_FUNC_ringbuf_query:
>>   		return &bpf_ringbuf_query_proto;
>> +#ifdef CONFIG_RELAY
>> +	case BPF_FUNC_relay_output:
>> +		return &bpf_relay_output_proto;
>> +#endif
>>   	case BPF_FUNC_jiffies64:
>>   		return &bpf_jiffies64_proto;
>>   	case BPF_FUNC_get_task_stack:
>> -- 
>> 2.32.0.3.g01195cf9f
>>

