Return-Path: <bpf+bounces-51710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DAA379BA
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F59A16BD12
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1E146580;
	Mon, 17 Feb 2025 02:28:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E51D52B
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759279; cv=none; b=hCRpZn6WQzo7eNv8b1bjwmzm3b9mQmcoVqyBohSjJvC1idJCoXr9wd2bHqHvKoBA5KPyGaJDJeDs/UHY302Y8i2g2VCKd7JNm228FcxeaHlwCFvV9jbjG31h1Nnx+vb2V6t1mSVuwqXFzQkqXz48aSBc2SzJKli88geW/w0BdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759279; c=relaxed/simple;
	bh=OX7eXNSxisH8wCp8O7UDayrTcnft3hSNJVHvGNROv34=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PxnTZIeP4oI+dNqCl1dijyvNev18EGCGuPKbX6lhj2QM8vIzrqY6hBfO65te3pt+1zSYTG8d1nGOI1OkLZVl90uWDmvmYa1Yv64lArjHzJ83Tyj7N+axshagLpXU42hZY90WsxmNPbSzD/WLsCbre8w+pllAh7p9arfiTm0byWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yx64f32pgz4f3jMN
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:27:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5542A1A10DC
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:27:53 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAn2XmmnrJnftkNEA--.36255S2;
	Mon, 17 Feb 2025 10:27:53 +0800 (CST)
Subject: Re: [PATCH -next 2/5] bpf: Remove map_push_elem callbacks with
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
 <20250217014122.65645-3-zhangxiaomeng13@huawei.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a501ad89-9832-21d4-ce9c-ebd5bfa37a79@huaweicloud.com>
Date: Mon, 17 Feb 2025 10:27:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014122.65645-3-zhangxiaomeng13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAn2XmmnrJnftkNEA--.36255S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xtryUurWrCw4xWF48JFb_yoW8Gr47pF
	4rJFWq9F4Fqay3K34Ut3W5ur48J34Ut3yUCF4kKryYyFyxWrnaqF1rGas3ZFn3CF1DCr40
	yF10vayFvw4xKrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUrsqXDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 2/17/2025 9:41 AM, Xiaomeng Zhang wrote:
> Remove redundant map_push_elem callbacks with return -EOPNOTSUPP. We can
> directly return -EOPNOTSUPP when calling the unimplemented callbacks.
>
>
>  BPF_CALL_3(bpf_map_push_elem, struct bpf_map *, map, void *, value, u64, flags)
>  {
> -	return map->ops->map_push_elem(map, value, flags);
> +	if (map->ops->map_push_elem)
> +		return map->ops->map_push_elem(map, value, flags);
> +	else
> +		return -EOPNOTSUPP;
>  }

Similar with the previous patch, the modifications in both
bpf_map_push_elem() and bpf_map_update_valu() are unnecessary.
>  
>  const struct bpf_func_proto bpf_map_push_elem_proto = {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e6e859f71c5d..79a118ea9270 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -281,7 +281,10 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>  	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>  		   map->map_type == BPF_MAP_TYPE_STACK ||
>  		   map->map_type == BPF_MAP_TYPE_BLOOM_FILTER) {
> -		err = map->ops->map_push_elem(map, value, flags);
> +		if (map->ops->map_push_elem)
> +			err = map->ops->map_push_elem(map, value, flags);
> +		else
> +			err = -EOPNOTSUPP;
>  	} else {
>  		err = bpf_obj_pin_uptrs(map->record, value);
>  		if (!err) {


