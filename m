Return-Path: <bpf+bounces-42638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C117A9A6B7A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F05280A97
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044AF1F8900;
	Mon, 21 Oct 2024 14:02:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B1881E
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519372; cv=none; b=Gm4HhfYcx0TOZG04D8PpFp/w/oC/x7C4ayf5jfH0gtuHn50UD2l5CCWbW7+V9okPcDUuop/W1r7sHujkDz5cro2QDNc6HiYnKSmTQmZr/nmEwX8o9b3i7Od4WmyXM6l1OzWDe9QUIgF7WnKN8hRbpiK4mUMqtMrI5RnxFnokA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519372; c=relaxed/simple;
	bh=7cBmHOtJi2MSGJ5RL7EwudhgZD0KQj7mLk5z6FhoGVo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hi6sfKUBeGX26qwXPRbe3QgYWTCl5wejDHyXXARTxQ23kFpwh2IX0rZZZtpu+82jCdaLbjn3jl9bbAJhxGOSxIS+z3V55pB8hx4whtoRN58iCReJYSRwWpCgph8iXa/fWRcwN5rKt6fwfbtoO+DRQXW1inpiw/ex7726yDr5o0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXH7Y713jz4f3l8x
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:02:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3D2961A06D7
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:02:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBHe2ABXxZnXnPTEg--.60867S2;
	Mon, 21 Oct 2024 22:02:44 +0800 (CST)
Subject: Re: [PATCH bpf-next 03/16] bpf: Parse bpf_dynptr in map key
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-4-houtao@huaweicloud.com>
 <CAADnVQKmkaYJixBrJpWPDpHM9R9jq91meY9bERCVaC11CN4G_w@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b2ceb4b4-e9bf-dc07-86ac-c7c3edbd4d04@huaweicloud.com>
Date: Mon, 21 Oct 2024 22:02:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKmkaYJixBrJpWPDpHM9R9jq91meY9bERCVaC11CN4G_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBHe2ABXxZnXnPTEg--.60867S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW8Jw43Jr15WrW7Gr1xZrb_yoW8ur1xpF
	4xGryfCr4ktrW2krnrJw4F9Fy8trWFg347u3yrJ347KF1kXryDZF18KFs8urn0kFs5tw48
	Ars0g3s5u34vyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07UXyCJUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/12/2024 12:29 AM, Alexei Starovoitov wrote:
> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> +#define MAX_DYNPTR_CNT_IN_MAP_KEY 4
>> +
>>  static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>                          const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
>>  {
>> @@ -1103,6 +1113,40 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>         if (!value_type || value_size != map->value_size)
>>                 return -EINVAL;
>>
>> +       if (btf_type_is_dynptr(btf, key_type))
>> +               map->key_record = btf_new_bpf_dynptr_record();
>> +       else
>> +               map->key_record = btf_parse_fields(btf, key_type, BPF_DYNPTR, map->key_size);
>> +       if (!IS_ERR_OR_NULL(map->key_record)) {
>> +               if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY) {
>> +                       ret = -E2BIG;
>> +                       goto free_map_tab;
> Took me a while to grasp that map->key_record is only for dynptr fields
> and map->record is for the rest except dynptr fields.
>
> Maybe rename key_record to dynptr_fields ?
> Or at least add a comment to struct bpf_map to explain
> what each btf_record is for.

I was trying to rename map->record to map->value_record, however, I was
afraid that it may introduce too much churn, so I didn't do that. But I
think it is a good idea to add comments for both btf_record. And
considering that only bpf_dynptr is enabled for map key, renaming it to
dynptr_fields seems reasonable as well.
>
> It's kinda arbitrary decision to support multiple dynptr-s per key
> while other fields are not.
> Maybe worth looking at generalizing it a bit so single btf_record
> can have multiple of certain field kinds?
> In addition to btf_record->cnt you'd need btf_record->dynptr_cnt
> but that would be easier to extend in the future ?

Map value has already supported multiple kptrs or bpf_list_node. And in
the discussion [1], I thought multiple dynptr support in map key is
necessary, so I enabled it.

[1]:
https://lore.kernel.org/bpf/CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com/


