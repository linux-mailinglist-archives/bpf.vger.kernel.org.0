Return-Path: <bpf+bounces-51516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA7FA3559A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C4E3AA080
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4315746E;
	Fri, 14 Feb 2025 04:12:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2DF14B088
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506350; cv=none; b=H372BmY1/7BzafST+GOKaKR19VFs5KEV25Zdn88YJu6zdAkytaQKaeXQTHE4tghBw1Mlz364XvLTTBfeksNozIDiRP41RMqUEKdyFpB+ixNxypsV0ZefZUJEc9EnqgHTyVzHDPZR+k2S/ReILYZN0m8DCktlW0KmwKXJlRUMtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506350; c=relaxed/simple;
	bh=lL5MPzdWVVnWvKXXmDRPNDgLOyBjLuxzirMW1NSeqYo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Py7q4ntrxbhTL46eZ+cRfeXh4KSUfH10w6uIBptRuRLvk3utzA9htmeRbufbHxkHFI5BmHrQCYk/tttfMo3cIL4CdV6yNbLBLHMREkPPm8JSPxqoaIOgqjMUwyr8JXDs5U0rDzrjiF3wqetYtQiR8K5lvZE5DR8fuHkrfPKAiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YvJXm2sw1z4f3jt0
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 12:12:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 82B3B1A15CC
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 12:12:24 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXunqlwq5nYRH5Dg--.53263S2;
	Fri, 14 Feb 2025 12:12:24 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 06/20] bpf: Set BPF_INT_F_DYNPTR_IN_KEY
 conditionally
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-7-houtao@huaweicloud.com>
 <CAADnVQL+866m69rv+PC_V1y1-PjL4=w3obTwqLPgW3=kA_BjEg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6223b1f5-b491-fcec-b50c-222f1075f952@huaweicloud.com>
Date: Fri, 14 Feb 2025 12:12:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQL+866m69rv+PC_V1y1-PjL4=w3obTwqLPgW3=kA_BjEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXunqlwq5nYRH5Dg--.53263S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xWFWUZrW7Kr4ruw47CFg_yoW5uFWUpF
	48GFWa9r4ktFnFyrnIqa15W34Fvw4xJryUCry7KFyYkF1DAryfWr18Ka15WryYvr1rCws7
	Zr4jga4Fk347ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/14/2025 7:56 AM, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2025 at 2:59 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When there is bpf_dynptr field in the map key btf type or the map key
>> btf type is bpf_dyntr, set BPF_INT_F_DYNPTR_IN_KEY in map_flags.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 07c67ad1a6a07..46b96d062d2db 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1360,6 +1360,34 @@ static struct btf *get_map_btf(int btf_fd)
>>         return btf;
>>  }
>>
>> +static int map_has_dynptr_in_key_type(struct btf *btf, u32 btf_key_id, u32 key_size)
>> +{
>> +       const struct btf_type *type;
>> +       struct btf_record *record;
>> +       u32 btf_key_size;
>> +
>> +       if (!btf_key_id)
>> +               return 0;
>> +
>> +       type = btf_type_id_size(btf, &btf_key_id, &btf_key_size);
>> +       if (!type || btf_key_size != key_size)
>> +               return -EINVAL;
>> +
>> +       /* For dynptr key, key BTF type must be struct */
>> +       if (!__btf_type_is_struct(type))
>> +               return 0;
>> +
>> +       if (btf_type_is_dynptr(btf, type))
>> +               return 1;
>> +
>> +       record = btf_parse_fields(btf, type, BPF_DYNPTR, key_size);
>> +       if (IS_ERR(record))
>> +               return PTR_ERR(record);
>> +
>> +       btf_record_free(record);
>> +       return !!record;
>> +}
>> +
>>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
>>  /* called via syscall */
>>  static int map_create(union bpf_attr *attr)
>> @@ -1398,6 +1426,14 @@ static int map_create(union bpf_attr *attr)
>>                 btf = get_map_btf(attr->btf_fd);
>>                 if (IS_ERR(btf))
>>                         return PTR_ERR(btf);
>> +
>> +               err = map_has_dynptr_in_key_type(btf, attr->btf_key_type_id, attr->key_size);
>> +               if (err < 0)
>> +                       goto put_btf;
>> +               if (err > 0) {
>> +                       attr->map_flags |= BPF_INT_F_DYNPTR_IN_KEY;
> I don't like this inband signaling in the uapi field.
> The whole refactoring in patch 4 to do patch 6 and
> subsequent bpf_map_has_dynptr_key() in various places
> feels like reinventing the wheel.
>
> We already have map_check_btf() mechanism that works for
> existing special fields inside BTF.
> Please use it.

Yes. However map->key_record is only available after the map is created,
but the creation of hash map needs to check it before the map is
created. Instead of using an internal flag, how about adding extra
argument for both ->map_alloc_check() and ->map_alloc() as proposed in
the commit message of the previous patch ?
>
> map_has_dynptr_in_key_type() can be done in map_check_btf()
> after map is created, no ?

No. both ->map_alloc_check() and ->map_alloc() need to know whether
dynptr is enabled (as explained in the previous commit message). Both of
these functions are called before the map is created.
> Then when it passes map->map_type check set a bool inside
> struct bpf_map, so that bpf_map_has_dynptr_key() can be fast
> in the critical path of hashtab.
> Or better yet use:
> static inline bool bpf_map_has_dynptr_key(const struct bpf_map *map)
> {
>   /* key_record is not NULL when the map key contains bpf_dynptr_user */
>   return !!map->key_record;
> }
> since htab_map_hash() has to read key_record anyway,
> hence better D$ access.
> .


