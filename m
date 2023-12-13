Return-Path: <bpf+bounces-17659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16E5810F5C
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF20B20CF3
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A598B23745;
	Wed, 13 Dec 2023 11:06:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB7DBD
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 03:05:59 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sqt281gngz4f3lW5
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:05:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 362041A0771
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:05:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDHa0oSkHllMrmODg--.12280S2;
	Wed, 13 Dec 2023 19:05:57 +0800 (CST)
Subject: Re: [PATCH bpf-next 3/5] bpf: Refill only one percpu element in
 memalloc
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
 <20231212223055.2138132-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e5a58774-971f-ddcd-8f43-8dd76dda30b6@huaweicloud.com>
Date: Wed, 13 Dec 2023 19:05:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231212223055.2138132-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDHa0oSkHllMrmODg--.12280S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13uFy7uryUZFyDCFW5GFg_yoW8GrW7pF
	WfGa4xGrn8ZF13Wa1xJ3yxCrW5Z3sYq3ZrGayUX3s8Zrn5Xw1DXr4vq34SqFyIvrZY9a1S
	yFWkKr4aya4UuFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrcTmDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/13/2023 6:30 AM, Yonghong Song wrote:
> Typically for percpu map element or data structure, once allocated,
> most operations are lookup or in-place update. Deletion are really
> rare. Currently, for percpu data strcture, 4 elements will be
> refilled if the size is <= 256. Let us just do with one element
> for percpu data. For example, for size 256 and 128 cpus, the
> potential saving will be 3 * 256 * 128 * 128 = 12MB.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/memalloc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 84987e97fd0a..a1d718ee264d 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -483,11 +483,15 @@ static void init_refill_work(struct bpf_mem_cache *c)
>  
>  static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>  {
> +	int cnt = 1;
> +
>  	/* To avoid consuming memory assume that 1st run of bpf
>  	 * prog won't be doing more than 4 map_update_elem from
>  	 * irq disabled region
>  	 */

Please update the comments accordingly.
> -	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
> +	if (!c->percpu_size && c->unit_size <= 256)
> +		cnt = 4;
> +	alloc_bulk(c, cnt, cpu_to_node(cpu), false);
>  }
>  
>  static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)


