Return-Path: <bpf+bounces-36356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B1947370
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 04:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A559AB20C8A
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 02:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0082D7B8;
	Mon,  5 Aug 2024 02:47:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91651A21
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826072; cv=none; b=t/ndC7VaSa+gV1onMIyhL8OG/ENBUqKIHd39kwrKrRUBRDtdjp/W2Wtqt5wfEMkiICY7a162tM+aJ9ot7N2YuWx1f+htIknN7vJTrclndaeJ9rW5hT2BjDB+3kbbj0cGnd7uzZfp/ikhT+i32nY+wg/aepfpAMiZcUqR1XPwPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826072; c=relaxed/simple;
	bh=iprZ8Kpr3FgCrRqHZDGSd+UTF4+MdN23HWJc0zBCGkM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oVoHkXdF+y/nC/itNICPs/w3KnykXXzdrMvT+/4lG3XxftI90wDzyitl29jKf8StnURyXSRX280u/XwTY8cehH4kULamiYMEU99FXfj5bQFYevyZapeCr86o75CyU5mbIOQxKxxKN/ITRZbYsqvXpuDrXWTqBBpKcwm+3UeioGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WcgpB3XFQz4f3kvp
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 10:47:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B07311A0D3C
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 10:47:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAHarhOPbBmTxcXAw--.51211S2;
	Mon, 05 Aug 2024 10:47:44 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Test bpf_kptr_xchg
 stashing into local kptr
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-5-amery.hung@bytedance.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <103a9c34-9fde-7c4b-39a5-46a57e2ae9cf@huaweicloud.com>
Date: Mon, 5 Aug 2024 10:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803001145.635887-5-amery.hung@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAHarhOPbBmTxcXAw--.51211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWrJFWxAr4UWw4xAF4DCFg_yoW8ur13pF
	W5G34ayFyIqF47uw4xGFs8Z34Fgr4xt3y5Aa4Dtry3ArnrX34kXF17Kr45u3WSyrW09r4r
	ArsYqry3Wa1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 8/3/2024 8:11 AM, Amery Hung wrote:
> From: Dave Marchevsky <davemarchevsky@fb.com>
>
> Test stashing a referenced kptr in to a local kptr.
>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  .../selftests/bpf/progs/local_kptr_stash.c    | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> index 75043ffc5dad..a0d784e8a05b 100644
> --- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> @@ -11,6 +11,7 @@
>  struct node_data {
>  	long key;
>  	long data;
> +	struct prog_test_ref_kfunc __kptr *stashed_in_node;
>  	struct bpf_rb_node node;
>  };

Because prog_test_ref_kfunc is a module btf, so the btf_get() in
btf_parse_kptr() will not be invoked. I would like to suggest to add a
user-defined type kptr in node_data to exercise the btf_get() in
btf_parse_kptr().
>  
> @@ -85,18 +86,35 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>  
>  static int create_and_stash(int idx, int val)
>  {
> +	struct prog_test_ref_kfunc *inner;
>  	struct map_value *mapval;
>  	struct node_data *res;
> +	unsigned long dummy;
>  
>  	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
>  	if (!mapval)
>  		return 1;
>  
> +	dummy = 0;
> +	inner = bpf_kfunc_call_test_acquire(&dummy);
> +	if (!inner)
> +		return 2;
> +
>  	res = bpf_obj_new(typeof(*res));
> -	if (!res)
> -		return 1;
> +	if (!res) {
> +		bpf_kfunc_call_test_release(inner);
> +		return 3;
> +	}
>  	res->key = val;
>  
> +	inner = bpf_kptr_xchg(&res->stashed_in_node, inner);
> +	if (inner) {
> +		/* Should never happen, we just obj_new'd res */
> +		bpf_kfunc_call_test_release(inner);
> +		bpf_obj_drop(res);
> +		return 4;
> +	}
> +
>  	res = bpf_kptr_xchg(&mapval->node, res);
>  	if (res)
>  		bpf_obj_drop(res);


