Return-Path: <bpf+bounces-18646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1108681D3C1
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12F71F22B1F
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B38CA61;
	Sat, 23 Dec 2023 11:28:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9856CA48;
	Sat, 23 Dec 2023 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sy23H3z3Sz4f3k5s;
	Sat, 23 Dec 2023 19:28:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 015A51A090E;
	Sat, 23 Dec 2023 19:28:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCnS0pJxIZlpFwoEg--.65176S2;
	Sat, 23 Dec 2023 19:28:12 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/3] bpf: implement map_update_elem to init relay
 file
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
 <20231222122146.65519-3-lulie@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cb325603-4bf4-57cf-ca63-aa12580646fc@huaweicloud.com>
Date: Sat, 23 Dec 2023 19:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231222122146.65519-3-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCnS0pJxIZlpFwoEg--.65176S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47Ary5uw1DXr15Zry8AFb_yoW5JF13pF
	WrGFn3Cr4Iqr43Z3say3Z5WryrZw1rXr17X3s7Aa40yrySgrn5tr4kKayDCr4ayr45uw4j
	va1jgw4jk3y0krDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUo0eHDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/22/2023 8:21 PM, Philo Lu wrote:
> map_update_elem is used to create relay files and bind them with the
> relay channel, which is created with BPF_MAP_CREATE. This allows users
> to set a custom directory name. It must be used with key=NULL and
> flag=0.
>
> Here is an example:
> ```
> struct {
> __uint(type, BPF_MAP_TYPE_RELAY);
> __uint(max_entries, 4096);
> } my_relay SEC(".maps");
> ...
> char dir_name[] = "relay_test";
> bpf_map_update_elem(map_fd, NULL, dir_name, 0);
> ```
>
> Then, directory `/sys/kerenl/debug/relay_test` will be created, which
> includes files of my_relay0...my_relay[#cpu]. Each represents a per-cpu
> buffer with size 8 * 4096 B (there are 8 subbufs by default, each with
> size 4096B).

It is a little weird. Because the name of the relay file is
$debug_fs_root/$value_name/${map_name}xxx. Could we update it to
$debug_fs_root/$map_name/$value_name/xxx instead ?
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  kernel/bpf/relaymap.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
> index d0adc7f67758..588c8de0a4bd 100644
> --- a/kernel/bpf/relaymap.c
> +++ b/kernel/bpf/relaymap.c
> @@ -117,7 +117,37 @@ static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
>  static long relay_map_update_elem(struct bpf_map *map, void *key, void *value,
>  				   u64 flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_relay_map *rmap;
> +	struct dentry *parent;
> +	int err;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (unlikely(key))
> +		return -EINVAL;
> +
> +	rmap = container_of(map, struct bpf_relay_map, map);
> +

Lock is needed here, because .map_update_elem can be invoked concurrently.
> +	/* The directory already exists */
> +	if (rmap->relay_chan->has_base_filename)
> +		return -EEXIST;
> +
> +	/* Setup relay files. Note that the directory name passed as value should
> +	 * not be longer than map->value_size, including the '\0' at the end.
> +	 */
> +	((char *)value)[map->value_size - 1] = '\0';
> +	parent = debugfs_create_dir(value, NULL);
> +	if (IS_ERR_OR_NULL(parent))
> +		return PTR_ERR(parent);
> +
> +	err = relay_late_setup_files(rmap->relay_chan, map->name, parent);
> +	if (err) {
> +		debugfs_remove_recursive(parent);
> +		return err;
> +	}
> +
> +	return 0;
>  }
>  
>  static long relay_map_delete_elem(struct bpf_map *map, void *key)


