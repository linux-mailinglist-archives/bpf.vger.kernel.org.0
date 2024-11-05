Return-Path: <bpf+bounces-44024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22109BC926
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8671C22241
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C71CEAA0;
	Tue,  5 Nov 2024 09:30:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C61367;
	Tue,  5 Nov 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799021; cv=none; b=tfPGIDjAcH55Wz6O4kfGQJETRta3N10zGsvv4DgOjhiXUVQ3+DnWj73wBneIgKWV0xjait8Y/5D4R1/CVbbPJlkzWRf7hDjV2+q3enUCPJ/1K7MPrgyL9gy80zv1WVo9jLnjYaFcT590KtQDAXatxRrElYgucoOR9uZlN6oJegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799021; c=relaxed/simple;
	bh=6VCrizESjrShaxDZ17cix50758++pSXgZgaGod230kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPhbj/J8XGPAQ1pR0g00VO87bJxodITpfy8UW6kVJ7EOqAcwt+JGWbQ70yCgQSiV/Hg5WOZKCXIL/IDgHZgcEXob7Np8zvcOAOYxo0LmnY5MwrRFrNhBoUlYpLWxReQon6PsRDLbd5mHL27148Sgi/lNWen3cgCWdn9hm6QnX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjNN92657z4f3kny;
	Tue,  5 Nov 2024 17:30:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1E53C1A0359;
	Tue,  5 Nov 2024 17:30:14 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDnj7GH5Slnk02NAw--.34665S4;
	Tue, 05 Nov 2024 17:30:14 +0800 (CST)
Message-ID: <33060881-3044-4bd1-aeee-2d863dcc85aa@huaweicloud.com>
Date: Tue, 5 Nov 2024 17:30:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops
 trampoline
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
 <cf62c79d-cba5-49dc-9099-fc86d54ee864@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <cf62c79d-cba5-49dc-9099-fc86d54ee864@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnj7GH5Slnk02NAw--.34665S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF48XryUKw1fuFy5Gr1kAFb_yoW7Gr43pF
	1ktryUCry5Wr4kWr48Xw4UCFy5Jr1UX3WUJFykJa45ArWYqr1vqF1UXFyj9ry3Ar4kAF4U
	Jr1jqr9rZrW7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdyUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/5/2024 8:10 AM, Martin KaFai Lau wrote:
> On 11/1/24 4:19 AM, Xu Kuohai wrote:
>>   static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>                          void *value, u64 flags)
>>   {
>> @@ -601,6 +633,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>       int prog_fd, err;
>>       u32 i, trampoline_start, image_off = 0;
>>       void *cur_image = NULL, *image = NULL;
>> +    struct bpf_ksym *ksym;
>>       if (flags)
>>           return -EINVAL;
>> @@ -640,6 +673,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>       kdata = &kvalue->data;
>>       module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
>> +    ksym = st_map->ksyms;
>>       for_each_member(i, t, member) {
>>           const struct btf_type *mtype, *ptype;
>>           struct bpf_prog *prog;
>> @@ -735,6 +769,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>           /* put prog_id to udata */
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>> +
>> +        /* init ksym for this trampoline */
>> +        bpf_struct_ops_ksym_init(prog, image + trampoline_start,
>> +                     image_off - trampoline_start,
>> +                     ksym++);
>>       }
>>       if (st_ops->validate) {
>> @@ -790,6 +829,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   unlock:
>>       kfree(tlinks);
>>       mutex_unlock(&st_map->lock);
>> +    if (!err)
>> +        bpf_struct_ops_map_ksyms_add(st_map);
>>       return err;
>>   }
> 
>>   static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>   {
>>       const struct bpf_struct_ops_desc *st_ops_desc;
>> @@ -905,6 +963,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       struct bpf_map *map;
>>       struct btf *btf;
>>       int ret;
>> +    size_t ksyms_offset;
>> +    u32 ksyms_cnt;
>>       if (attr->map_flags & BPF_F_VTYPE_BTF_OBJ_FD) {
>>           /* The map holds btf for its whole life time. */
>> @@ -951,6 +1011,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>            */
>>           (vt->size - sizeof(struct bpf_struct_ops_value));
>> +    st_map_size = round_up(st_map_size, sizeof(struct bpf_ksym));
>> +    ksyms_offset = st_map_size;
>> +    ksyms_cnt = count_func_ptrs(btf, t);
>> +    st_map_size += ksyms_cnt * sizeof(struct bpf_ksym);
>> +
>>       st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
>>       if (!st_map) {
>>           ret = -ENOMEM;
>> @@ -958,6 +1023,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       }
>>       st_map->st_ops_desc = st_ops_desc;
>> +    st_map->ksyms = (void *)st_map + ksyms_offset;
> 
> nit. The st_map->ksyms is very similar to the existing st_map->links. Can we do the allocation similar to the st_map->links and use another bpf_map_area_alloc() instead of doing the round_up() and then figuring out the ksyms_offset.
> 
>> +    st_map->ksyms_cnt = ksyms_cnt;
> 
> The same goes for ksyms_cnt. ksyms_cnt is almost the same as the st_map->links_cnt. st_map->links_cnt unnecessarily includes the non func ptr (i.e. a waste). The st_map->links[i] must be NULL if the i-th member of a struct is not a func ptr.
> 
> If this patch adds the count_func_ptrs(), I think at least just have one variable to mean funcs_cnt instead of adding another new ksyms_cnt. Both the existing st_map->links and the new st_map->ksyms can use the same funcs_cnt. An adjustment is needed for 
> link in update_elem (probably use link++ similar to your ksym++ idea). bpf_struct_ops_map_put_progs() should work as is.
>

Great, agree.

> Also, the actual bpf_link is currently allocated during update_elem() only when there is a bpf prog for an ops. The new st_map->ksyms pre-allocated everything during map_alloc() regardless if there will be a bpf prog (e.g. tcp_congestion_ops has 5 optional 
> ops). I don't have a strong opinion on pre-allocate everything in map_alloc() or allocate on-demand in update_elem(). However, considering bpf_ksym has a "char name[KSYM_NAME_LEN]", the on-demand allocation on bpf_link becomes not very useful. If the next 
> respin stays with the pre-allocate everything way, it is useful to followup later to stay with one way and do the same for bpf_link.

OK, let’s go with the bpf_link way to avoid another cleanup patch.


