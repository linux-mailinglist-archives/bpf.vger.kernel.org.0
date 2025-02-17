Return-Path: <bpf+bounces-51711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F1A379BC
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5784F7A126E
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE20101EE;
	Mon, 17 Feb 2025 02:32:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CAF9DA
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759529; cv=none; b=nW2t3Pmuz9J0zWicrRFJjbYSSs2bvon9DVYGI8xs2tcAwv26rBzIGT929lio1iIE5iHLHT/NDlNbrZ/RP9TvPEsydvYiMhkC/ogObQMz8GBvWscorbgSSsjfddVMppbLtBndhjE7Ik3+WMfhTJkAjjHR/UrexHpyRUMgAlkY8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759529; c=relaxed/simple;
	bh=5tFOppLHJudtKPCZifI/Qrvt3wULc9C9pXilcps/cxQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aWZ58hCSvf5B0TPf85uwOtBa6wYbj+39R3FXmkIvrd3rN3xN3c+a3djuFVaajGq93a/wSBacx2xYP5/VuZi9kfZfuhT7qd8WgCi+jGGGpHOH1Ej65cF6CWmA8M+KW0HH2d3CRCl39LYVjuzjGSpShM3PBjBLvfRm+ODVaCiHYjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yx69R1Cznz4f3jR3
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:31:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A95F61A0B2D
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:32:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAnxsCcn7JnWLsMEA--.12290S2;
	Mon, 17 Feb 2025 10:32:00 +0800 (CST)
Subject: Re: [PATCH -next 3/5] bpf: Remove map_pop_elem callbacks with
 -EOPNOTSUPP
To: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250217014122.65645-1-zhangxiaomeng13@huawei.com>
 <20250217014122.65645-4-zhangxiaomeng13@huawei.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5e6dccfd-dad0-3665-2141-cb928074fb8d@huaweicloud.com>
Date: Mon, 17 Feb 2025 10:31:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014122.65645-4-zhangxiaomeng13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAnxsCcn7JnWLsMEA--.12290S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4fJr18uF1kJryxJw1xAFb_yoW8XFykpr
	4rJFZrur40q34ak34jqanY9ryUtw4Dt3yakF1vk34Yyr9rWr1aqr18Ja4xX34aka47CrW0
	yr4Fva4Fvw48CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU10PfPUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 2/17/2025 9:41 AM, Xiaomeng Zhang wrote:
> Remove redundant map_pop_elem callbacks with return -EOPNOTSUPP. We can
> directly return -EOPNOTSUPP when calling the unimplemented callbacks.
>
> Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
> ---
>  kernel/bpf/arena.c        | 6 ------
>  kernel/bpf/bloom_filter.c | 6 ------
>  kernel/bpf/helpers.c      | 5 ++++-
>  kernel/bpf/syscall.c      | 5 ++++-
>  4 files changed, 8 insertions(+), 14 deletions(-)
>

>  BPF_CALL_2(bpf_map_pop_elem, struct bpf_map *, map, void *, value)
>  {
> -	return map->ops->map_pop_elem(map, value);
> +	if (map->ops->map_pop_elem)
> +		return map->ops->map_pop_elem(map, value);
> +	else
> +		return -EOPNOTSUPP;
>  }
>  

Similar with the previous patch, it is unnecessary.
>  const struct bpf_func_proto bpf_map_pop_elem_proto = {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 79a118ea9270..c6f55283f4ff 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2142,7 +2142,10 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>  	err = -ENOTSUPP;
>  	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>  	    map->map_type == BPF_MAP_TYPE_STACK) {
> -		err = map->ops->map_pop_elem(map, value);
> +		if (map->ops->map_pop_elem)
> +			err = map->ops->map_pop_elem(map, value);
> +		else
> +			err = -EOPNOTSUPP;

It is also unnecessary.
>  	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
>  		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>  		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||


