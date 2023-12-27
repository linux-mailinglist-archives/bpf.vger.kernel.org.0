Return-Path: <bpf+bounces-18695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2A81EF66
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD451C2104C
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D6A4502A;
	Wed, 27 Dec 2023 14:24:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5945019
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T0Ylz6Xtlz4f3l1H
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 22:23:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 570621A0862
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 22:23:49 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3hQtxM4xlt9chEw--.23991S2;
	Wed, 27 Dec 2023 22:23:49 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 2/3] bpf: add bpf_relay_output kfunc
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 joannelkoong@gmail.com, laoar.shao@gmail.com, kuifeng@meta.com,
 shung-hsi.yu@suse.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, hengqi@linux.alibaba.com
References: <20231227100130.84501-1-lulie@linux.alibaba.com>
 <20231227100130.84501-3-lulie@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <28c18a22-e5db-be29-d793-ff97399a4fe8@huaweicloud.com>
Date: Wed, 27 Dec 2023 22:23:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231227100130.84501-3-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3hQtxM4xlt9chEw--.23991S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1rKr17uw1xtF1Dur47XFb_yoW5Jw1DpF
	Z5Cr40kr48tF4xXw17JF4ku3s5Zw4rtr12k3WkKry8A3yqq34fXw4vgFnxur9IqF1UGr4Y
	yr1Y93yYk397u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/27/2023 6:01 PM, Philo Lu wrote:
> A kfunc is needed to write into the relay channel, named
> bpf_relay_output. The usage is same as bpf_ringbuf_output helper. It
> only works after relay files are set, i.e., after calling
> map_update_elem for the created relay map.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  kernel/bpf/helpers.c  |  3 +++
>  kernel/bpf/relaymap.c | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index be72824f32b2..22480b69ff27 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2617,6 +2617,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +#ifdef CONFIG_RELAY
> +BTF_ID_FLAGS(func, bpf_relay_output)
> +#endif
>  BTF_SET8_END(common_btf_ids)

Could you explain the reason why bpf_relay_out is placed in
common_btf_ids instead of generic_kfunc_set ?
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
> index 02b33a8e6b6c..37280d60133c 100644
> --- a/kernel/bpf/relaymap.c
> +++ b/kernel/bpf/relaymap.c
> @@ -6,6 +6,7 @@
>  #include <linux/slab.h>
>  #include <linux/bpf.h>
>  #include <linux/err.h>
> +#include <linux/btf.h>
>  
>  #define RELAY_CREATE_FLAG_MASK (BPF_F_OVERWRITE)
>  
> @@ -197,3 +198,24 @@ const struct bpf_map_ops relay_map_ops = {
>  	.map_mem_usage = relay_map_mem_usage,
>  	.map_btf_id = &relay_map_btf_ids[0],
>  };
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_relay_output(struct bpf_map *map,
> +				   void *data, u64 data__sz, u32 flags)
> +{
> +	struct bpf_relay_map *rmap;
> +
> +	/* not support any flag now */
> +	if (unlikely(!map || flags))
> +		return -EINVAL;
> +
> +	rmap = container_of(map, struct bpf_relay_map, map);

How does bpf_relay_out() guarantee the passed map is a relay map ? And
just like bpf_map_sum_elem_count(), I think KF_TRUSTED_ARGS is also
necessary for bpf_relay_output().
> +	if (!rmap->relay_chan->has_base_filename)
> +		return -ENOENT;
> +

I think a comment is needed here. It needs to explain why checking
->has_base_filename is enough to guarantee the concurrently running of
bpf_relay_output() and .map_update_elem() is safe.

> +	relay_write(rmap->relay_chan, data, data__sz);
> +	return 0;
> +}
> +
> +__bpf_kfunc_end_defs();


