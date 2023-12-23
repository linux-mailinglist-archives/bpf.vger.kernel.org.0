Return-Path: <bpf+bounces-18645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E225081D3BE
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 12:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2611C21AEE
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 11:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F50BCA4C;
	Sat, 23 Dec 2023 11:22:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C7D261;
	Sat, 23 Dec 2023 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sy1wK5vlLz4f3kFV;
	Sat, 23 Dec 2023 19:22:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ADABB1A091B;
	Sat, 23 Dec 2023 19:22:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXWxHgwoZl_2esEQ--.33542S2;
	Sat, 23 Dec 2023 19:22:12 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: implement relay map basis
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <35f5a5bf-7059-a177-cd94-b60ed8dbff03@huaweicloud.com>
Date: Sat, 23 Dec 2023 19:22:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231222122146.65519-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXWxHgwoZl_2esEQ--.33542S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jry5ZFWDZry8Xw1DXF1rXrb_yoWxZFyDpF
	WrGr1rCr40qr47X3yrAa15ur9Yvr40q3W29asIg34jyr9rWrn3JFW8WFyj9ry5ArWDJw4j
	vF4jk3yrC392y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/22/2023 8:21 PM, Philo Lu wrote:
> BPF_MAP_TYPE_RELAY is implemented based on relay interface, which
> creates per-cpu buffer to transfer data. Each buffer is essentially a
> list of fix-sized sub-buffers, and is exposed to user space as files in
> debugfs. attr->max_entries is used as subbuf size and attr->map_extra is
> used as subbuf num. Currently, the default value of subbuf num is 8.
>
> The data can be accessed by read or mmap via these files. For example,
> if there are 2 cpus, files could be `/sys/kernel/debug/mydir/my_rmap0`
> and `/sys/kernel/debug/mydir/my_rmap1`.
>
> Buffer-only mode is used to create the relay map, which just allocates
> the buffer without creating user-space files. Then user can setup the
> files with map_update_elem, thus allowing user to define the directory
> name in debugfs. map_update_elem is implemented in the following patch.
>
> A new map flag named BPF_F_OVERWRITE is introduced to set overwrite mode
> of relay map.

Beside adding a new map type, could we consider only use kfuncs to
support the creation of rchan and the write of rchan ? I think
bpf_cpumask will be a good reference.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  include/linux/bpf_types.h |   3 +
>  include/uapi/linux/bpf.h  |   7 ++
>  kernel/bpf/Makefile       |   3 +
>  kernel/bpf/relaymap.c     | 157 ++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c      |   1 +
>  5 files changed, 171 insertions(+)
>  create mode 100644 kernel/bpf/relaymap.c
>

SNIP
> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
> new file mode 100644
> index 000000000000..d0adc7f67758
> --- /dev/null
> +++ b/kernel/bpf/relaymap.c
> @@ -0,0 +1,157 @@
> +#include <linux/cpumask.h>
> +#include <linux/debugfs.h>
> +#include <linux/filter.h>
> +#include <linux/relay.h>
> +#include <linux/slab.h>
> +#include <linux/bpf.h>
> +#include <linux/err.h>
> +
> +#define RELAY_CREATE_FLAG_MASK (BPF_F_OVERWRITE)
> +
> +struct bpf_relay_map {
> +	struct bpf_map map;
> +	struct rchan *relay_chan;
> +	struct rchan_callbacks relay_cb;
> +};

It seems that there is no need to add relay_cb in bpf_relay_map. We
could define two kinds of rchan_callbacks: one for non-overwrite mode
and another one for overwrite mode.
> +
> +static struct dentry *create_buf_file_handler(const char *filename,
> +							   struct dentry *parent, umode_t mode,
> +							   struct rchan_buf *buf, int *is_global)
> +{
> +	/* Because we do relay_late_setup_files(), create_buf_file(NULL, NULL, ...)
> +	 * will be called by relay_open.
> +	 */
> +	if (!filename)
> +		return NULL;
> +
> +	return debugfs_create_file(filename, mode, parent, buf,
> +				   &relay_file_operations);
> +}
> +
> +static int remove_buf_file_handler(struct dentry *dentry)
> +{
> +	debugfs_remove(dentry);
> +	return 0;
> +}
> +
> +/* For non-overwrite, use default subbuf_start cb */
> +static int subbuf_start_overwrite(struct rchan_buf *buf, void *subbuf,
> +						   void *prev_subbuf, size_t prev_padding)
> +{
> +	return 1;
> +}
> +
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
> +
> +	/* set default subbuf num */
> +	attr->map_extra = attr->map_extra & UINT_MAX;

Should we reject invalid map_extra and return -EINVAL instead ?
> +	if (!attr->map_extra)
> +		attr->map_extra = 8;
> +
> +	if (!attr->map_name || strlen(attr->map_name) == 0)
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
> +	if (!rmap->relay_chan)
> +		return ERR_PTR(-EINVAL);

Need to free rmap.
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

rmap->relay_chan may be freed by relay_close(), so it is not safe to
dereference relay_chan->parent here. And is debugfs_remove_recursive()
necessary here ?
> +	kfree(rmap);
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
>


