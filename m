Return-Path: <bpf+bounces-50468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30491A2815B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7941E1885D96
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E321213220;
	Wed,  5 Feb 2025 01:39:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885D25A63B;
	Wed,  5 Feb 2025 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719540; cv=none; b=k1dwgLBnBfSoCjNFjeHYoTqiR+GHkBVtPSYk4mgzZ14Bqdj+zhWiYK0GXBUds9Qq09Hc/CpFAL3Fo45u9Hwk/X8xXxpWlRP31UG15Lsmn6aWJX7WrhAImxTGKuOOeA+3qAYqjjcbPOCWto4t9tOI9ZYDTBNqG/8fhlWHjSdTGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719540; c=relaxed/simple;
	bh=oUEvIE7Ygq+NVKre2zyiV8axQSyC5SemEbXMGzGjgvg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IkHxEmCEbaGBe4GPslqideNd2lQXDO5F+6RZnLtfZr5jWPM8e3XfQJ8kTZtGIzwY+uJvQyY0YfO6zClxwdy2Kq3Ysv1KZLU8/GxDdYXwxAW/7T3kLTey7LHeSt9g3cnDPb//nhmL4O0/wi99LygwAJ9ppX48LXf+4368czH4vI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YnjYp6J2cz4f3jsv;
	Wed,  5 Feb 2025 09:38:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B165A1A138C;
	Wed,  5 Feb 2025 09:38:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBHql4rwaJnJqPCCw--.38584S2;
	Wed, 05 Feb 2025 09:38:54 +0800 (CST)
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Hou Tao <hotforest@gmail.com>, bpf@vger.kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
References: <20250204082848.13471-1-hotforest@gmail.com>
 <20250204082848.13471-3-hotforest@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com>
Date: Wed, 5 Feb 2025 09:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250204082848.13471-3-hotforest@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHql4rwaJnJqPCCw--.38584S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryrWr4DtF4xAFW3Aw4fKrg_yoW8uF18pF
	ZYkr1Ut3Wvya4qqw4xArsxCFW3Awn3Ja45KF4DtryrAw1YqryvyrnYk3Z2qFy3AFWrJFnY
	q3W2qrnIkayUKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU07PEDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

+cc Cody Haas

Sorry for the resend. I sent the reply in the HTML format.

On 2/4/2025 4:28 PM, Hou Tao wrote:
> Currently, the update of existing element in hash map involves two
> steps:
> 1) insert the new element at the head of the hash list
> 2) remove the old element
> 
> It is possible that the concurrent lookup operation may fail to find
> either the old element or the new element if the lookup operation starts
> before the addition and continues after the removal.
> 
> Therefore, replacing the two-step update with an atomic update. After
> the change, the update will be atomic in the perspective of the lookup
> operation: it will either find the old element or the new element.
> 
> Signed-off-by: Hou Tao <hotforest@gmail.com>
> ---
>  kernel/bpf/hashtab.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4a9eeb7aef85..a28b11ce74c6 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1179,12 +1179,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  		goto err;
>  	}
>  
> -	/* add new element to the head of the list, so that
> -	 * concurrent search will find it before old elem
> -	 */
> -	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> -	if (l_old) {
> -		hlist_nulls_del_rcu(&l_old->hash_node);
> +	if (!l_old) {
> +		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> +	} else {
> +		/* Replace the old element atomically, so that
> +		 * concurrent search will find either the new element or
> +		 * the old element.
> +		 */
> +		hlist_nulls_replace_rcu(&l_new->hash_node, &l_old->hash_node);
>  
>  		/* l_old has already been stashed in htab->extra_elems, free
>  		 * its special fields before it is available for reuse. Also
> 

After thinking about it the second time, the atomic list replacement on
the update side is enough to make lookup operation always find the
existing element. However, due to the immediate reuse, the lookup may
find an unexpected value. Maybe we should disable the immediate reuse
for specific map (e.g., htab of maps).


