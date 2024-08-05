Return-Path: <bpf+bounces-36355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212494736A
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 04:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECEF281020
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B012D7B8;
	Mon,  5 Aug 2024 02:41:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0417C
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722825711; cv=none; b=iFZftkXgKwafQSSZGfsTSL8SS5o1c5vp+bbexvgBs0dVt1gCSe1tSzSkTTMjv7SYj5bVaxfJRiJ0LE8IvKI4vYxObW2Fob4TN3xn77anRKcaeddqDHOFddHqgtyiVnhTBjPyZD4A/X4D3JaKcmUyyH47SvAlRlRPxwOcOpX5zSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722825711; c=relaxed/simple;
	bh=hg93DJ+IhCGZ+gW0kbnOX2/R88vRJsBp9xG/CgOdIxw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Qj/7moDZa7LD2b9mtYr2y2Y9t1MbYDNgjQJ1QGI5rwh7Y/u/hTPsa6kAL/FK8LI54Rf5gjpYO03VzCjJz2BEpao/ffWid10G2pL8Vz3dlE1zKiKuUseu+mb36+1Vf8dUFP9W7475I7M3wT7L3ngVS6a+5P4nbVnosTUSw7AEd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WcggG67K8z4f3kty
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 10:41:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 150871A12C4
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 10:41:45 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXqUvlO7Bmuz8aAw--.58931S2;
	Mon, 05 Aug 2024 10:41:44 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
Date: Mon, 5 Aug 2024 10:41:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803001145.635887-2-amery.hung@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXqUvlO7Bmuz8aAw--.58931S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy8Gw43tw4DAr47AryDGFg_yoW5CFW8pF
	92yFnYyrW8Jr1fur1DKayrua4fKrs5Jay7GFy5Gw1Y9rsFqryvg3WUGrWUuw1YkrsYkr18
	Ar4q9F9xA3yDZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 8/3/2024 8:11 AM, Amery Hung wrote:
> From: Dave Marchevsky <davemarchevsky@fb.com>
>
> Currently btf_parse_fields is used in two places to create struct
> btf_record's for structs: when looking at mapval type, and when looking
> at any struct in program BTF. The former looks for kptr fields while the
> latter does not. This patch modifies the btf_parse_fields call made when
> looking at prog BTF struct types to search for kptrs as well.
>

SNIP
> On a side note, when building program BTF, the refcount of program BTF
> is now initialized before btf_parse_struct_metas() to prevent a
> refcount_inc() on zero warning. This happens when BPF_KPTR is present
> in program BTF: btf_parse_struct_metas() -> btf_parse_fields()
> -> btf_parse_kptr() -> btf_get(). This should be okay as the program BTF
> is not available yet outside btf_parse().

If btf_parse_kptr() pins the passed btf, there will be memory leak for
the btf after closing the btf fd, because the invocation of btf_put()
for kptr record in btf->struct_meta_tab depends on the invocation of 
btf_free_struct_meta_tab() in btf_free(), but the invocation of
btf_free() depends the final refcnt of the btf is released, so the btf
will not be freed forever. The reason why map value doesn't have such
problem is that the invocation of btf_put() for kptr record doesn't
depends on the release of map value btf and it is accomplished by
bpf_map_free_record().

Maybe we should move the common btf used by kptr and graph_root into
btf_record and let the callers of btf_parse_fields() and
btf_record_free() to decide the life cycle of btf in btf_record.
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  kernel/bpf/btf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 95426d5b634e..7b8275e3e500 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5585,7 +5585,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
>  		type = &tab->types[tab->cnt];
>  		type->btf_id = i;
>  		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
> -						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size);
> +						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
> +						  BPF_KPTR, t->size);
>  		/* The record cannot be unset, treat it as an error if so */
>  		if (IS_ERR_OR_NULL(record)) {
>  			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
> @@ -5737,6 +5738,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
>  	if (err)
>  		goto errout;
>  
> +	refcount_set(&btf->refcnt, 1);
> +
>  	struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
>  	if (IS_ERR(struct_meta_tab)) {
>  		err = PTR_ERR(struct_meta_tab);
> @@ -5759,7 +5762,6 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
>  		goto errout_free;
>  
>  	btf_verifier_env_free(env);
> -	refcount_set(&btf->refcnt, 1);
>  	return btf;
>  
>  errout_meta:


