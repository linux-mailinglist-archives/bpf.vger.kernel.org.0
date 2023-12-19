Return-Path: <bpf+bounces-18277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF6818666
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 12:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4931F23C70
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385515AE6;
	Tue, 19 Dec 2023 11:31:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276018C05
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SvZJh2yZWz4f3k5Y
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:31:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C22301A09C3
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:31:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCX80MBf4FlzlK2EA--.37178S2;
	Tue, 19 Dec 2023 19:31:17 +0800 (CST)
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Refill only one percpu element in
 memalloc
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231218063031.3037929-1-yonghong.song@linux.dev>
 <20231218063052.3040932-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2b92dfac-1ce1-4981-c2ec-a432e4dd24a5@huaweicloud.com>
Date: Tue, 19 Dec 2023 19:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231218063052.3040932-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCX80MBf4FlzlK2EA--.37178S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13uFy7ur4DKr1fZr4ktFb_yoW8trWUpF
	Z5Ga45Crn0vFy3ua13G3yxGr15Cw4rGF9xJ3y0v34DAr13Xr1qvrs2q34SqFyjyrsaka1Y
	vFWDtr1ay3WDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/18/2023 2:30 PM, Yonghong Song wrote:
> Typically for percpu map element or data structure, once allocated,
> most operations are lookup or in-place update. Deletion are really
> rare. Currently, for percpu data strcture, 4 elements will be
> refilled if the size is <= 256. Let us just do with one element
> for percpu data. For example, for size 256 and 128 cpus, the
> potential saving will be 3 * 256 * 128 * 128 = 12MB.
>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/memalloc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 50ab2fecc005..f37998662146 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -485,11 +485,16 @@ static void init_refill_work(struct bpf_mem_cache *c)
>  
>  static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>  {
> -	/* To avoid consuming memory assume that 1st run of bpf
> -	 * prog won't be doing more than 4 map_update_elem from
> -	 * irq disabled region
> +	int cnt = 1;
> +
> +	/* To avoid consuming memory, for non-percpu allocation, assume that
> +	 * 1st run of bpf prog won't be doing more than 4 map_update_elem from
> +	 * irq disabled region if unit size is less than or equal to 256.
> +	 * For all other cases, let us just do one allocation.
>  	 */
> -	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
> +	if (!c->percpu_size && c->unit_size <= 256)
> +		cnt = 4;
> +	alloc_bulk(c, cnt, cpu_to_node(cpu), false);
>  }

Another thought about this patch. When the prefilled element is
allocated by the invocation of bpf_percpu_obj_new(), the prefill will
trigger again and this time it will allocate c->batch elements. For
256-bytes unit_size, c->batch will be 64, so the maximal memory
consumption under 128-cpus host will be: 64 * 256 * 128 * 128 = 256MB
when there is one allocation of bpf_percpu_obj_new() on each CPU. And my
question is that should we adjust the low_watermark and high_watermark
accordingly for per-cpu allocation to reduce the memory consumption ?
>  
>  static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)


