Return-Path: <bpf+bounces-44619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A259C574D
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 13:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09B01F226DF
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544981CD1FF;
	Tue, 12 Nov 2024 12:06:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED62309A8;
	Tue, 12 Nov 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413201; cv=none; b=bkjTcXvRvvD4elB0O3SPJ0SH/wBk7VW58szStTN2+QkdIfv2eH5bYZjLQ68c8r/m+SZfaZUu3pIdeybGF65ja1hyF6jQRgq1r7Lh2lgPtUfqa509qgUFdkHa7aUAUNh/wmlDCrUvLUcBuvWfgJ/M/GhZm830iV6ZXTT82cMuPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413201; c=relaxed/simple;
	bh=E1fHwwrIH+2QTw/A9WYRJNMs2DJttSS9Y9SBdL7b4ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5dDLSQLdzHaWYZ0izzlLr4ExOENVUc2f0aLv6ap3vLJ75bWnqd6afq9QKw63R6TfNmLIJ2q9BAlCErwn0Wzk01stxmOF+GCvX6QK8Jkdq9ZjScRNR8r6xkdBEMtBhKOPPw5Anw4t1pyi4M6QQZ8h3HUYz/9IXLtMPpzl7kN35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XnlWC1FWqz4f3pJG;
	Tue, 12 Nov 2024 20:06:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 421211A058E;
	Tue, 12 Nov 2024 20:06:34 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCHroLIRDNnJH1NBg--.6554S2;
	Tue, 12 Nov 2024 20:06:34 +0800 (CST)
Message-ID: <b0f07f8d-841c-4d61-b5ae-108d26315297@huaweicloud.com>
Date: Tue, 12 Nov 2024 20:06:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add kernel symbol for struct_ops
 trampoline
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241111121641.2679885-1-xukuohai@huaweicloud.com>
 <20241111121641.2679885-3-xukuohai@huaweicloud.com>
 <f35f4d0e-77df-4e52-b62e-9e1254fb4b5c@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <f35f4d0e-77df-4e52-b62e-9e1254fb4b5c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHroLIRDNnJH1NBg--.6554S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtry5Cr47KFy8tw47Xr4rGrg_yoWfAF1kpF
	1ktrWUCrWUJr4kWr18Jw1UAFy5tr1jq3ZrJrykJa4Yyr4jqr1qqF1UWF1q9w15Jr48Ar1U
	Jr1jqr9rZrW7JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/12/2024 7:04 AM, Martin KaFai Lau wrote:
> On 11/11/24 4:16 AM, Xu Kuohai wrote:
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index e99fce81e916..d6dd56fc80d8 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -23,7 +23,6 @@ struct bpf_struct_ops_value {
>>   struct bpf_struct_ops_map {
>>       struct bpf_map map;
>> -    struct rcu_head rcu;
> 
> Since it needs a respin (more on it later), it will be useful to separate this cleanup as a separate patch in the same patch series.
>

OK

>>       const struct bpf_struct_ops_desc *st_ops_desc;
>>       /* protect map_update */
>>       struct mutex lock;
>> @@ -32,6 +31,8 @@ struct bpf_struct_ops_map {
>>        * (in kvalue.data).
>>        */
>>       struct bpf_link **links;
>> +    /* ksyms for bpf trampolines */
>> +    struct bpf_ksym **ksyms;
>>       u32 funcs_cnt;
>>       u32 image_pages_cnt;
>>       /* image_pages is an array of pages that has all the trampolines
>> @@ -586,6 +587,49 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>>       return 0;
>>   }
>> +static void bpf_struct_ops_ksym_init(const char *tname, const char *mname,
>> +                     void *image, unsigned int size,
>> +                     struct bpf_ksym *ksym)
>> +{
>> +    snprintf(ksym->name, KSYM_NAME_LEN, "bpf__%s_%s", tname, mname);
>> +    INIT_LIST_HEAD_RCU(&ksym->lnode);
>> +    bpf_image_ksym_init(image, size, ksym);
>> +}
>> +
>> +static void bpf_struct_ops_map_ksyms_add(struct bpf_struct_ops_map *st_map)
>> +{
>> +    u32 i;
>> +
>> +    for (i = 0; i < st_map->funcs_cnt; i++) {
>> +        if (!st_map->ksyms[i])
>> +            break;
>> +        bpf_image_ksym_add(st_map->ksyms[i]);
>> +    }
>> +}
>> +
>> +static void bpf_struct_ops_map_del_ksyms(struct bpf_struct_ops_map *st_map)
>> +{
>> +    u32 i;
>> +
>> +    for (i = 0; i < st_map->funcs_cnt; i++) {
>> +        if (!st_map->ksyms[i])
>> +            break;
>> +        bpf_image_ksym_del(st_map->ksyms[i]);
>> +    }
>> +}
>> +
>> +static void bpf_struct_ops_map_free_ksyms(struct bpf_struct_ops_map *st_map)
>> +{
>> +    u32 i;
>> +
>> +    for (i = 0; i < st_map->funcs_cnt; i++) {
>> +        if (!st_map->ksyms[i])
>> +            break;
>> +        kfree(st_map->ksyms[i]);
>> +        st_map->links[i] = NULL;
> 
> s/links/ksyms/
> 
> pw-bot: cr
>

Oops, good catch

>> +    }
>> +}
>> +
>>   static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>                          void *value, u64 flags)
>>   {
>> @@ -602,6 +646,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>       u32 i, trampoline_start, image_off = 0;
>>       void *cur_image = NULL, *image = NULL;
>>       struct bpf_link **plink;
>> +    struct bpf_ksym **pksym;
>> +    const char *tname, *mname;
>>       if (flags)
>>           return -EINVAL;
>> @@ -641,14 +687,18 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>       kdata = &kvalue->data;
>>       plink = st_map->links;
>> +    pksym = st_map->ksyms;
>> +    tname = btf_name_by_offset(st_map->btf, t->name_off);
>>       module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
>>       for_each_member(i, t, member) {
>>           const struct btf_type *mtype, *ptype;
>>           struct bpf_prog *prog;
>>           struct bpf_tramp_link *link;
>> +        struct bpf_ksym *ksym;
>>           u32 moff;
>>           moff = __btf_member_bit_offset(t, member) / 8;
>> +        mname = btf_name_by_offset(st_map->btf, member->name_off);
>>           ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
>>           if (ptype == module_type) {
>>               if (*(void **)(udata + moff))
>> @@ -718,6 +768,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>                     &bpf_struct_ops_link_lops, prog);
>>           *plink++ = &link->link;
>> +        ksym = kzalloc(sizeof(*ksym), GFP_USER);
> 
> link is also using kzalloc but probably both link and ksym allocation should use bpf_map_kzalloc instead. This switch can be done for both together later as a follow up patch.
>

OK, will do.

>> +        if (!ksym) {
>> +            bpf_prog_put(prog);
> 
> afaik, this bpf_prog_put is not needed. The bpf_link_init above took the prog ownership and the bpf_struct_ops_map_put_progs() at the error path will take care of it.
>

Right, good catch

>> +            err = -ENOMEM;
>> +            goto reset_unlock;
>> +        }
>> +        *pksym = ksym;
> 
> nit. Follow the *plink++ style above and does the same *pksym++ here.
>

OK

>> +
>>           trampoline_start = image_off;
>>           err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>                           &st_ops->func_models[i],
>> @@ -737,6 +795,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>           /* put prog_id to udata */
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>> +
>> +        /* init ksym for this trampoline */
>> +        bpf_struct_ops_ksym_init(tname, mname,
>> +                     image + trampoline_start,
>> +                     image_off - trampoline_start,
>> +                     *pksym++);
> 
> then uses "ksym" here.
> 
>>       }
>>       if (st_ops->validate) {
>> @@ -785,6 +849,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>        */
>>   reset_unlock:
>> +    bpf_struct_ops_map_free_ksyms(st_map);
>>       bpf_struct_ops_map_free_image(st_map);
>>       bpf_struct_ops_map_put_progs(st_map);
>>       memset(uvalue, 0, map->value_size);
>> @@ -792,6 +857,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   unlock:
>>       kfree(tlinks);
>>       mutex_unlock(&st_map->lock);
>> +    if (!err)
>> +        bpf_struct_ops_map_ksyms_add(st_map);
>>       return err;
>>   }
>> @@ -851,7 +918,10 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>>       if (st_map->links)
>>           bpf_struct_ops_map_put_progs(st_map);
>> +    if (st_map->ksyms)
>> +        bpf_struct_ops_map_free_ksyms(st_map);
>>       bpf_map_area_free(st_map->links);
>> +    bpf_map_area_free(st_map->ksyms);
>>       bpf_struct_ops_map_free_image(st_map);
>>       bpf_map_area_free(st_map->uvalue);
>>       bpf_map_area_free(st_map);
>> @@ -868,6 +938,9 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>>       if (btf_is_module(st_map->btf))
>>           module_put(st_map->st_ops_desc->st_ops->owner);
>> +    if (st_map->ksyms)
> 
> This null test should not be needed.
>

Agree, will remove it.

>> +        bpf_struct_ops_map_del_ksyms(st_map);
>> +
>>       /* The struct_ops's function may switch to another struct_ops.
>>        *
>>        * For example, bpf_tcp_cc_x->init() may switch to
>> @@ -980,7 +1053,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       st_map->links =
>>           bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_links *),
>>                      NUMA_NO_NODE);
>> -    if (!st_map->uvalue || !st_map->links) {
>> +
>> +    st_map->ksyms =
>> +        bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_ksyms *),
>> +                   NUMA_NO_NODE);
> 
> .map_mem_usage at least needs to include the st_map->ksyms[] pointer array. func_cnts should be used instead of btf_type_vlen(vt) for link also in .map_mem_usage.
>

Right, agree

>> +    if (!st_map->uvalue || !st_map->links || !st_map->ksyms) {
>>           ret = -ENOMEM;
>>           goto errout_free;
>>       }


