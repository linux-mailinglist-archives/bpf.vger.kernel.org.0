Return-Path: <bpf+bounces-51709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C47A379B9
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A8816C8D7
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D7146580;
	Mon, 17 Feb 2025 02:26:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50837DA66
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759163; cv=none; b=o7qZPuCoVrnkDXLhN9OUaQgP8hXeR94Hj+jS+zUeRUWWORzKlxPLUzP4ZqJxXy03qCCTwBYWID9zXSB6chGuDr4rSbnA97dxgfcoM/waFEkg4uR+ataHzm3GU1il968PGy8Tfv5CdquHP0Y4zf19oPMpfZFsXJi4OmFSy+FfoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759163; c=relaxed/simple;
	bh=pIO/9SEeyhAGRmZnOpDx9mMRFvZCRYASCD1T4X6sYZo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D74ozcAQNVP1rpRFKyphxnFE2p714Aw/sxMr9N0VeipNF/mnsFFvMVd60A3Sj6SEZpGbTn/NhjzX/sb7j7b96pPk4ki94sxiLmSP8SXvgxWwOVlgyl4MsJt8F876STAyhFntXGryRE7cJhbFuxKYHfdirKe2aSJl3Mhv6Kh2rJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yx62Q6Z64z4f3jqN
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:25:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24D201A1062
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:25:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBHqFwsnrJno+ZEEA--.12341S2;
	Mon, 17 Feb 2025 10:25:50 +0800 (CST)
Subject: Re: [PATCH -next 1/5] bpf: Remove map_peek_elem callbacks with
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
 <20250217014122.65645-2-zhangxiaomeng13@huawei.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7a6031fb-5fb4-578c-2ccd-89c3f624ebff@huaweicloud.com>
Date: Mon, 17 Feb 2025 10:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014122.65645-2-zhangxiaomeng13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBHqFwsnrJno+ZEEA--.12341S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1UAFyrJr15ZF15AF17trb_yoW5Ww4rpF
	4rJFykCF4Fqa1a934DJw4ku34UGw45Cw4UKa4kG34FyrZ8WrnIqr18G3W3Xr1F9Fy7ur40
	kr409a4Fvw48WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/17/2025 9:41 AM, Xiaomeng Zhang wrote:
> Remove redundant map_peek_elem callbacks with return -EOPNOTSUPP. We can
> directly return -EOPNOTSUPP when calling the unimplemented callbacks.
>
> Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
> ---
>  kernel/bpf/arena.c   | 6 ------
>  kernel/bpf/helpers.c | 5 ++++-
>  kernel/bpf/syscall.c | 5 ++++-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 095a9554e1de..0aaefa5d6b09 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -62,11 +62,6 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
>  	return arena ? arena->user_vm_start : 0;
>  }
>  
> -static long arena_map_peek_elem(struct bpf_map *map, void *value)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
>  static long arena_map_push_elem(struct bpf_map *map, void *value, u64 flags)
>  {
>  	return -EOPNOTSUPP;
> @@ -404,7 +399,6 @@ const struct bpf_map_ops arena_map_ops = {
>  	.map_get_unmapped_area = arena_get_unmapped_area,
>  	.map_get_next_key = arena_map_get_next_key,
>  	.map_push_elem = arena_map_push_elem,
> -	.map_peek_elem = arena_map_peek_elem,
>  	.map_pop_elem = arena_map_pop_elem,
>  	.map_lookup_elem = arena_map_lookup_elem,
>  	.map_update_elem = arena_map_update_elem,
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f27ce162427a..0f429171de6d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -116,7 +116,10 @@ const struct bpf_func_proto bpf_map_pop_elem_proto = {
>  
>  BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, void *, value)
>  {
> -	return map->ops->map_peek_elem(map, value);
> +	if (map->ops->map_peek_elem)
> +		return map->ops->map_peek_elem(map, value);
> +	else
> +		return -EOPNOTSUPP;
>  }

It is unnecessary. Because the verifier has ensured the
bpf_map_peek_elem helper is only available for specific maps in
check_map_func_compatibility().
>  
>  const struct bpf_func_proto bpf_map_peek_elem_proto = {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ff1f980bd59a..e6e859f71c5d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -325,7 +325,10 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
>  	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>  		   map->map_type == BPF_MAP_TYPE_STACK ||
>  		   map->map_type == BPF_MAP_TYPE_BLOOM_FILTER) {
> -		err = map->ops->map_peek_elem(map, value);
> +		if (map->ops->map_peek_elem)
> +			err = map->ops->map_peek_elem(map, value);
> +		else
> +			err = -EOPNOTSUPP;

It is also unnecessary due to the similar reason.
>  	} else if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
>  		/* struct_ops map requires directly updating "value" */
>  		err = bpf_struct_ops_map_sys_lookup_elem(map, key, value);


