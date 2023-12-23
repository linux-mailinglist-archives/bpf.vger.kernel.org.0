Return-Path: <bpf+bounces-18647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE881D41E
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 14:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7FD1F227AE
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7097D2F2;
	Sat, 23 Dec 2023 13:02:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1BD2E9;
	Sat, 23 Dec 2023 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Vz1GATd_1703336548;
Received: from 30.39.236.78(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz1GATd_1703336548)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 21:02:30 +0800
Message-ID: <87b4f7fc-cc98-496c-bbff-6e3890278e35@linux.alibaba.com>
Date: Sat, 23 Dec 2023 21:02:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: implement relay map basis
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
 <20231222122146.65519-2-lulie@linux.alibaba.com>
 <35f5a5bf-7059-a177-cd94-b60ed8dbff03@huaweicloud.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <35f5a5bf-7059-a177-cd94-b60ed8dbff03@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/23 19:22, Hou Tao wrote:
> Hi,
> 
> On 12/22/2023 8:21 PM, Philo Lu wrote:
>> BPF_MAP_TYPE_RELAY is implemented based on relay interface, which
>> creates per-cpu buffer to transfer data. Each buffer is essentially a
>> list of fix-sized sub-buffers, and is exposed to user space as files in
>> debugfs. attr->max_entries is used as subbuf size and attr->map_extra is
>> used as subbuf num. Currently, the default value of subbuf num is 8.
>>
>> The data can be accessed by read or mmap via these files. For example,
>> if there are 2 cpus, files could be `/sys/kernel/debug/mydir/my_rmap0`
>> and `/sys/kernel/debug/mydir/my_rmap1`.
>>
>> Buffer-only mode is used to create the relay map, which just allocates
>> the buffer without creating user-space files. Then user can setup the
>> files with map_update_elem, thus allowing user to define the directory
>> name in debugfs. map_update_elem is implemented in the following patch.
>>
>> A new map flag named BPF_F_OVERWRITE is introduced to set overwrite mode
>> of relay map.
> 
> Beside adding a new map type, could we consider only use kfuncs to
> support the creation of rchan and the write of rchan ? I think
> bpf_cpumask will be a good reference.

This is a good question. TBH, I have thought of implement it with 
helpers (I'm not very familiar with kfuncs, but I think they could be 
similar?), but I was stumped by how to close the channel. We can create 
a relay channel, hold it with a map, but it could be difficult for the 
bpf program to close the channel with relay_close(). And I think it 
could be the difference compared with bpf_cpumask.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> ---
>>   include/linux/bpf_types.h |   3 +
>>   include/uapi/linux/bpf.h  |   7 ++
>>   kernel/bpf/Makefile       |   3 +
>>   kernel/bpf/relaymap.c     | 157 ++++++++++++++++++++++++++++++++++++++
>>   kernel/bpf/syscall.c      |   1 +
>>   5 files changed, 171 insertions(+)
>>   create mode 100644 kernel/bpf/relaymap.c
>>
> 
> SNIP
>> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
>> new file mode 100644
>> index 000000000000..d0adc7f67758
>> --- /dev/null
>> +++ b/kernel/bpf/relaymap.c
>> @@ -0,0 +1,157 @@
>> +#include <linux/cpumask.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/filter.h>
>> +#include <linux/relay.h>
>> +#include <linux/slab.h>
>> +#include <linux/bpf.h>
>> +#include <linux/err.h>
>> +
>> +#define RELAY_CREATE_FLAG_MASK (BPF_F_OVERWRITE)
>> +
>> +struct bpf_relay_map {
>> +	struct bpf_map map;
>> +	struct rchan *relay_chan;
>> +	struct rchan_callbacks relay_cb;
>> +};
> 
> It seems that there is no need to add relay_cb in bpf_relay_map. We
> could define two kinds of rchan_callbacks: one for non-overwrite mode
> and another one for overwrite mode.

We need to store relay_cb, because the relay channel only uses a pointer 
of struct rchan_callbacks. So I maintain it with the map, or is there a 
better place to store it?
>> +
>> +static struct dentry *create_buf_file_handler(const char *filename,
>> +							   struct dentry *parent, umode_t mode,
>> +							   struct rchan_buf *buf, int *is_global)
>> +{
>> +	/* Because we do relay_late_setup_files(), create_buf_file(NULL, NULL, ...)
>> +	 * will be called by relay_open.
>> +	 */
>> +	if (!filename)
>> +		return NULL;
>> +
>> +	return debugfs_create_file(filename, mode, parent, buf,
>> +				   &relay_file_operations);
>> +}
>> +
>> +static int remove_buf_file_handler(struct dentry *dentry)
>> +{
>> +	debugfs_remove(dentry);
>> +	return 0;
>> +}
>> +
>> +/* For non-overwrite, use default subbuf_start cb */
>> +static int subbuf_start_overwrite(struct rchan_buf *buf, void *subbuf,
>> +						   void *prev_subbuf, size_t prev_padding)
>> +{
>> +	return 1;
>> +}
>> +
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
>> +
>> +	/* set default subbuf num */
>> +	attr->map_extra = attr->map_extra & UINT_MAX;
> 
> Should we reject invalid map_extra and return -EINVAL instead ?

Ack, will add a check here.
>> +	if (!attr->map_extra)
>> +		attr->map_extra = 8;
>> +
>> +	if (!attr->map_name || strlen(attr->map_name) == 0)
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
>> +	if (!rmap->relay_chan)
>> +		return ERR_PTR(-EINVAL);
> 
> Need to free rmap.

Good catch. Will fix it.
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
> 
> rmap->relay_chan may be freed by relay_close(), so it is not safe to
> dereference relay_chan->parent here. And is debugfs_remove_recursive()
> necessary here ?

debugfs_remove_recursive is needed here, otherwise the directory will be 
left, but the order is indeed incorrect here. I will move it before 
relay_close, and check if rmap->relay_chan->parent is valid.

Thanks.

