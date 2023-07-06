Return-Path: <bpf+bounces-4221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521457499C1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C628129A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC88BE3;
	Thu,  6 Jul 2023 10:49:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CE1848
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:49:24 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989951FEC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 03:49:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QxYDd4pDjz4f4687
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:49:05 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXsRsenKZkjPh3Mg--.36601S2;
	Thu, 06 Jul 2023 18:49:06 +0800 (CST)
Subject: Re: [PATCH v4 bpf-next 5/6] selftests/bpf: test map percpu stats
To: Anton Protopopov <aspsk@isovalent.com>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-6-aspsk@isovalent.com>
From: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Message-ID: <5efebb7d-138a-5353-2bc2-a2a1ffa66a2d@huaweicloud.com>
Date: Thu, 6 Jul 2023 18:49:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230705160139.19967-6-aspsk@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXsRsenKZkjPh3Mg--.36601S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7WrWDGw43Gw13CF47twb_yoW5ur18pr
	W8AFZ7GrW8W3y2v34Fga48WFW2vr1jyr1UZrZ8J345ArsIvr17Zr18G3W2yF1a9Fy2ywnI
	vw429393Ja97GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/6/2023 12:01 AM, Anton Protopopov wrote:
> Add a new map test, map_percpu_stats.c, which is checking the correctness of
> map's percpu elements counters.  For supported maps the test upserts a number
> of elements, checks the correctness of the counters, then deletes all the
> elements and checks again that the counters sum drops down to zero.
>
> The following map types are tested:
>
>     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
>     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
>     * BPF_MAP_TYPE_HASH,
>     * BPF_MAP_TYPE_PERCPU_HASH,
>     * BPF_MAP_TYPE_LRU_HASH
>     * BPF_MAP_TYPE_LRU_PERCPU_HASH
>     * BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU
>     * BPF_MAP_TYPE_LRU_PERCPU_HASH, BPF_F_NO_COMMON_LRU
>     * BPF_MAP_TYPE_HASH_OF_MAPS
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Acked-by: Hou Tao <houtao1@huawei.com>

With two nits below.
> +
> +static const char *map_type_to_s(__u32 type)
> +{
> +	switch (type) {
> +	case BPF_MAP_TYPE_HASH:
> +		return "HASH";
> +	case BPF_MAP_TYPE_PERCPU_HASH:
> +		return "PERCPU_HASH";
> +	case BPF_MAP_TYPE_LRU_HASH:
> +		return "LRU_HASH";
> +	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +		return "LRU_PERCPU_HASH";
> +	default:
> +		return "<define-me>";
> +	}
Missing BPF_MAP_TYPE_HASH_OF_MAPS ?
> +}
> +
> +static __u32 map_count_elements(__u32 type, int map_fd)
> +{
> +	__u32 key = -1;
> +	int n = 0;
> +
> +	while (!bpf_map_get_next_key(map_fd, &key, &key))
> +		n++;
> +	return n;
> +}
> +
> +#define BATCH	true
> +
> +static void delete_and_lookup_batch(int map_fd, void *keys, __u32 count)
> +{
> +	static __u8 values[(8 << 10) * MAX_ENTRIES];
> +	void *in_batch = NULL, *out_batch;
> +	__u32 save_count = count;
> +	int ret;
> +
> +	ret = bpf_map_lookup_and_delete_batch(map_fd,
> +					      &in_batch, &out_batch,
> +					      keys, values, &count,
> +					      NULL);
> +
> +	/*
> +	 * Despite what uapi header says, lookup_and_delete_batch will return
> +	 * -ENOENT in case we successfully have deleted all elements, so check
> +	 * this separately
> +	 */

It seems it is a bug in __htab_map_lookup_and_delete_batch(). I could
post a patch to fix it if you don't plan to do that by yourself.
> +	CHECK(ret < 0 && (errno != ENOENT || !count), "bpf_map_lookup_and_delete_batch",
> +		       "error: %s\n", strerror(errno));
> +
> +	CHECK(count != save_count,
> +			"bpf_map_lookup_and_delete_batch",
> +			"deleted not all elements: removed=%u expected=%u\n",
> +			count, save_count);
> +}
> +
SNIP
> +static __u32 get_cur_elements(int map_id)
> +{
> +	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +	struct map_percpu_stats *skel;
> +	struct bpf_link *link;
> +	__u32 n_elements;
> +	int iter_fd;
> +	int ret;
> +
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	skel = map_percpu_stats__open();
> +	CHECK(skel == NULL, "map_percpu_stats__open", "error: %s", strerror(errno));
> +
> +	skel->bss->target_id = map_id;
> +
> +	ret = map_percpu_stats__load(skel);
> +	CHECK(ret != 0, "map_percpu_stats__load", "error: %s", strerror(errno));
> +
> +	link = bpf_program__attach_iter(skel->progs.dump_bpf_map, &opts);

Instead of passing a uninitialized opts, I think using NULL will be fine
here because there is no option for bpf map iterator now.


