Return-Path: <bpf+bounces-36832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B634794DC4C
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA60F1C21173
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B515358F;
	Sat, 10 Aug 2024 10:32:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E30179A7
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285952; cv=none; b=lWvZROW2E89lTlaFuOA7iMiK/xMsqs6eyDEHuU/E/YPfVS3vyJtPWLfo+NKojWuiTdec6+iUHox9p2nWqqCvWGLcW0bITjlG5t0Fh2zh8L6shqdu8hCN3ZtZfZXAiFIZNwV4uFpBCijZDT4Lgs3QjasTNzGGhnHPT1gy+pe1ueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285952; c=relaxed/simple;
	bh=MOhcZ/0W/4mudZAzRUqlp6n1CU1AMX8Dq0VKMmhS4Hg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jvBK7Emycinh0cOaZRIn6bC/4Elhz+91Zq6M2mVyfHqz8Q/jOGaD2lqgwySmCPk2IELBL90/GeVxyBcVVR8WgMucL6REtIdSMF1rKeavTTTa2BTEJ9HGEXeIoD68svaBDEGBIfS5pDqJC83C7knSdgYI+6rW/mxq89K8tOmyzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wgxt90RsQz4f3jM1
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 18:32:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 364AA1A1637
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 18:32:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDHzU+2Qbdmj1gCBQ--.9685S2;
	Sat, 10 Aug 2024 18:32:26 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Test bpf_kptr_xchg
 stashing into local kptr
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
 <20240809005131.3916464-6-amery.hung@bytedance.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a7b50f46-2efe-2a81-99a8-bc8eed48f36b@huaweicloud.com>
Date: Sat, 10 Aug 2024 18:32:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240809005131.3916464-6-amery.hung@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHzU+2Qbdmj1gCBQ--.9685S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1ktr1Utr1UXr1xAw13Jwb_yoW5KF17pF
	45GrWYkFyjqFW7Cw43KanrXw1Fqw4xK343ZFnYyry7ZrsrX3s7XwnrKr4Y93WfC3ykGF4r
	ArWa9rWfWFs0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 8/9/2024 8:51 AM, Amery Hung wrote:
> From: Dave Marchevsky <davemarchevsky@fb.com>
>
> Test stashing both referenced kptr and local kptr into local kptrs. Then,
> test unstashing them.
>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>

Acked-by: Hou Tao <houtao1@huawei.com>
> ---
>  .../selftests/bpf/progs/local_kptr_stash.c    | 58 ++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> index 75043ffc5dad..ce7bf7790917 100644
> --- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> @@ -8,9 +8,13 @@
>  #include "../bpf_experimental.h"
>  #include "../bpf_testmod/bpf_testmod_kfunc.h"
>  
> +struct plain_local;
> +
>  struct node_data {
>  	long key;
>  	long data;
> +	struct prog_test_ref_kfunc __kptr *stashed_in_kptr;
> +	struct plain_local __kptr *stashed_in_local_kptr;
>  	struct bpf_rb_node node;
>  };
>  
> @@ -85,18 +89,52 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>  
>  static int create_and_stash(int idx, int val)
>  {
> +	struct prog_test_ref_kfunc *inner_kptr;
> +	struct plain_local *inner_local_kptr;
>  	struct map_value *mapval;
>  	struct node_data *res;
> +	unsigned long dummy;
>  
>  	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
>  	if (!mapval)
>  		return 1;
>  
> +	dummy = 0;
> +	inner_kptr = bpf_kfunc_call_test_acquire(&dummy);
> +	if (!inner_kptr)
> +		return 2;
> +
> +	inner_local_kptr = bpf_obj_new(typeof(*inner_local_kptr));
> +	if (!inner_local_kptr) {
> +		bpf_kfunc_call_test_release(inner_kptr);
> +		return 3;
> +	}
> +
>  	res = bpf_obj_new(typeof(*res));
> -	if (!res)
> -		return 1;
> +	if (!res) {
> +		bpf_kfunc_call_test_release(inner_kptr);
> +		bpf_obj_drop(inner_local_kptr);
> +		return 4;
> +	}
>  	res->key = val;
>  
> +	inner_kptr = bpf_kptr_xchg(&res->stashed_in_kptr, inner_kptr);
> +	if (inner_kptr) {
> +		/* Should never happen, we just obj_new'd res */
> +		bpf_kfunc_call_test_release(inner_kptr);
> +		bpf_obj_drop(inner_local_kptr);
> +		bpf_obj_drop(res);
> +		return 5;
> +	}
> +
> +	inner_local_kptr = bpf_kptr_xchg(&res->stashed_in_local_kptr, inner_local_kptr);
> +	if (inner_local_kptr) {
> +		/* Should never happen, we just obj_new'd res */
> +		bpf_obj_drop(inner_local_kptr);
> +		bpf_obj_drop(res);
> +		return 6;
> +	}
> +
>  	res = bpf_kptr_xchg(&mapval->node, res);
>  	if (res)
>  		bpf_obj_drop(res);
> @@ -169,6 +207,8 @@ long stash_local_with_root(void *ctx)
>  SEC("tc")
>  long unstash_rb_node(void *ctx)
>  {
> +	struct prog_test_ref_kfunc *inner_kptr = NULL;
> +	struct plain_local *inner_local_kptr = NULL;
>  	struct map_value *mapval;
>  	struct node_data *res;
>  	long retval;
> @@ -180,6 +220,20 @@ long unstash_rb_node(void *ctx)
>  
>  	res = bpf_kptr_xchg(&mapval->node, NULL);
>  	if (res) {
> +		inner_kptr = bpf_kptr_xchg(&res->stashed_in_kptr, inner_kptr);
> +		if (!inner_kptr) {
> +			bpf_obj_drop(res);
> +			return 1;
> +		}
> +		bpf_kfunc_call_test_release(inner_kptr);
> +
> +		inner_local_kptr = bpf_kptr_xchg(&res->stashed_in_local_kptr, inner_local_kptr);
> +		if (!inner_local_kptr) {
> +			bpf_obj_drop(res);
> +			return 1;
> +		}
> +		bpf_obj_drop(inner_local_kptr);
> +
>  		retval = res->key;
>  		bpf_obj_drop(res);
>  		return retval;


