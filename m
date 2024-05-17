Return-Path: <bpf+bounces-29897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481798C7FAA
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99C928424A
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD56184D;
	Fri, 17 May 2024 01:53:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442EA32
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715910793; cv=none; b=qb2OCUDxU47ayeZ0xka+NibeEfJcI+5YtSRz2MV2swQppMi8De0HzjSEa5yfVyui3pPxEaoZ2JJegdPBCqj08cT74I5eNMTmCxwHdMQDJ6dQfhVqkuX+/3wPp/qxwaItnXs+lYrIJGaYxcWGolV0IQJWzIOa4XtXpbcr6I6HDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715910793; c=relaxed/simple;
	bh=ft6DYKSa0ewYvlkJm7PpefJC/q3KWOILV2iCHa9Trfc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fPQe3kK/ndDE981uIoAy2unHfqaIrqvCIj2rzmbmI6EoFZIdIQWkpssCWRaBIM3jeQv9iNRbBgPMiC4RgvCfwfZxKyQG23GrBRGBhUVDbgwp5kGvH6pzn0BKxrOpkttnaBO7sil/tKJ0NUmhlBxm0n85MCyoBfalndzYBHTTcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VgVN91ZkJz4f3jHc
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 09:52:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EDE6C1A0FB9
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 09:53:05 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB3y218uEZmkvN9NA--.12553S2;
	Fri, 17 May 2024 09:53:03 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and
 stack maps
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, daniel@iogearbox.net, olsajiri@gmail.com,
 andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, sairoop@vt.edu,
 miloc@vt.edu, memxor@gmail.com,
 syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
 <20240514124052.1240266-2-sidchintamaneni@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <43fee6a1-c078-fc1f-2039-4ef9934d2016@huaweicloud.com>
Date: Fri, 17 May 2024 09:53:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240514124052.1240266-2-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB3y218uEZmkvN9NA--.12553S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyrJF1rCF1DZrWUZw18Zrb_yoW5uF17pF
	WDWF93CFW0qFW2q3y3Xw4UJFnxGws5W347CFWfG34fAFsrXrn7Wr1I9a47Zr4F9r1kAan2
	vr45trWvk3yIyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 5/14/2024 8:40 PM, Siddharth Chintamaneni wrote:
> This patch is a revised version which addresses a possible deadlock issue in
> queue and stack map types.
>
> Deadlock could happen when a nested BPF program acquires the same lock
> as the parent BPF program to perform a write operation on the same map
> as the first one. This bug is also reported by syzbot.
>
> Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
> Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
> Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  kernel/bpf/queue_stack_maps.c | 76 +++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index d869f51ea93a..b5ed76c9ddd7 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -13,11 +13,13 @@
>  #define QUEUE_STACK_CREATE_FLAG_MASK \
>  	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
>  
> +
>  struct bpf_queue_stack {
>  	struct bpf_map map;
>  	raw_spinlock_t lock;
>  	u32 head, tail;
>  	u32 size; /* max_entries + 1 */
> +	int __percpu *map_locked;
>  
>  	char elements[] __aligned(8);
>  };
> @@ -78,6 +80,15 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
>  
>  	qs->size = size;
>  
> +	qs->map_locked = bpf_map_alloc_percpu(&qs->map,
> +						sizeof(int),
> +						sizeof(int),
> +						GFP_USER | __GFP_NOWARN);
> +	if (!qs->map_locked) {
> +		bpf_map_area_free(qs);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	raw_spin_lock_init(&qs->lock);
>  
>  	return &qs->map;
> @@ -88,19 +99,57 @@ static void queue_stack_map_free(struct bpf_map *map)
>  {
>  	struct bpf_queue_stack *qs = bpf_queue_stack(map);
>  
> +	free_percpu(qs->map_locked);
>  	bpf_map_area_free(qs);
>  }
>  
> +static inline int map_lock_inc(struct bpf_queue_stack *qs)
> +{
> +	unsigned long flags;
> +
> +	preempt_disable();
> +	local_irq_save(flags);
> +	if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
> +		__this_cpu_dec(*(qs->map_locked));
> +		local_irq_restore(flags);
> +		preempt_enable();
> +		return -EBUSY;
> +	}
> +
> +	local_irq_restore(flags);
> +	preempt_enable();
> +
> +	return 0;
> +}
> +
> +static inline void map_unlock_dec(struct bpf_queue_stack *qs)
> +{
> +	unsigned long flags;
> +
> +	preempt_disable();
> +	local_irq_save(flags);
> +	__this_cpu_dec(*(qs->map_locked));
> +	local_irq_restore(flags);
> +	preempt_enable();
> +}
> +
>  static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
>  {
>  	struct bpf_queue_stack *qs = bpf_queue_stack(map);
>  	unsigned long flags;
>  	int err = 0;
>  	void *ptr;
> +	int ret;
> +
> +	ret = map_lock_inc(qs);
> +	if (ret)
> +		return ret;
>  
>  	if (in_nmi()) {
> -		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
> +		if (!raw_spin_trylock_irqsave(&qs->lock, flags)) {
> +			map_unlock_dec(qs);
>  			return -EBUSY;
> +		}

With percpu map-locked in place, I think the in_nmi() checking could
also be remove. When the BPF program X which has already acquired the
lock is interrupted by a NMI, if the BPF program Y for the NMI also
tries to acquire the same lock, it will find map_locked is 1 and return
early.


