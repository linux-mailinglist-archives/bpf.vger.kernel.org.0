Return-Path: <bpf+bounces-51530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39940A35766
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D0E16A17B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A869B1DE8B6;
	Fri, 14 Feb 2025 06:49:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121E18A6D5
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515797; cv=none; b=atlVo5RmPhy/JEXtOefwkRnibyiVwTBeazSjY+aDI8J15Szz3I1U1jI/GT7aNlXVUWGlCEsrZMfRZyaZIoF5YKu6ulWWG2qCUPiQDVpIhq1e41cTgM1Trps07SkS7FKaxYs0PsD7+b5QSrIXSb15lXpPFIKgtfdXKybyQhm8Wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515797; c=relaxed/simple;
	bh=m71kuhIJPT88/xfdJ4bllZLTthipLIrnjFxrzamvudM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hNmS8PPACj9cyJ/OxUHwEOdMzLP9Jmu5xvys5DG/5/NfAgdjpNoU1ro8QPt0fYhj668AGjx6Q02skjOJRS91Jkyi0rnEH6YsO3sMbfRovMoeGaDrVD5mrcuZR63rUlFGSujmINKVYXeB+W49LhFYHEkuDVV8iakITUfUqJ1FQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YvN2P6s9Bz4f3jt3
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 14:49:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 170681A0CCC
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 14:49:50 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3F1yJ565nND43Dw--.59108S2;
	Fri, 14 Feb 2025 14:49:49 +0800 (CST)
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
 <6223b1f5-b491-fcec-b50c-222f1075f952@huaweicloud.com>
 <CAADnVQ+G9YQyj8-Q7UFT9y26tD1Rud_AgRu-D-s1LruYE03NZQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <01e5b3ca-86d3-46a9-742a-3b69f378d141@huaweicloud.com>
Date: Fri, 14 Feb 2025 14:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+G9YQyj8-Q7UFT9y26tD1Rud_AgRu-D-s1LruYE03NZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3F1yJ565nND43Dw--.59108S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1furWrJF47Kw1DWFW5Awb_yoWrZr1fpF
	4xGF1a9r4kJFnrAw42qa15Wr1Fvw4fGryUCF12gryru3Z8Xryfury0ga15uF9I9F15A3Wa
	vr45Ka4fC3W7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/14/2025 12:17 PM, Alexei Starovoitov wrote:
> On Thu, Feb 13, 2025 at 8:12 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 2/14/2025 7:56 AM, Alexei Starovoitov wrote:
>>> On Sat, Jan 25, 2025 at 2:59 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> When there is bpf_dynptr field in the map key btf type or the map key
>>>> btf type is bpf_dyntr, set BPF_INT_F_DYNPTR_IN_KEY in map_flags.
>>>>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>>>  kernel/bpf/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index 07c67ad1a6a07..46b96d062d2db 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -1360,6 +1360,34 @@ static struct btf *get_map_btf(int btf_fd)
>>>>         return btf;
>>>>  }
>>>>

SNIP
>>>>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
>>>>  /* called via syscall */
>>>>  static int map_create(union bpf_attr *attr)
>>>> @@ -1398,6 +1426,14 @@ static int map_create(union bpf_attr *attr)
>>>>                 btf = get_map_btf(attr->btf_fd);
>>>>                 if (IS_ERR(btf))
>>>>                         return PTR_ERR(btf);
>>>> +
>>>> +               err = map_has_dynptr_in_key_type(btf, attr->btf_key_type_id, attr->key_size);
>>>> +               if (err < 0)
>>>> +                       goto put_btf;
>>>> +               if (err > 0) {
>>>> +                       attr->map_flags |= BPF_INT_F_DYNPTR_IN_KEY;
>>> I don't like this inband signaling in the uapi field.
>>> The whole refactoring in patch 4 to do patch 6 and
>>> subsequent bpf_map_has_dynptr_key() in various places
>>> feels like reinventing the wheel.
>>>
>>> We already have map_check_btf() mechanism that works for
>>> existing special fields inside BTF.
>>> Please use it.
>> Yes. However map->key_record is only available after the map is created,
>> but the creation of hash map needs to check it before the map is
>> created. Instead of using an internal flag, how about adding extra
>> argument for both ->map_alloc_check() and ->map_alloc() as proposed in
>> the commit message of the previous patch ?
>>> map_has_dynptr_in_key_type() can be done in map_check_btf()
>>> after map is created, no ?
>> No. both ->map_alloc_check() and ->map_alloc() need to know whether
>> dynptr is enabled (as explained in the previous commit message). Both of
>> these functions are called before the map is created.
> Is that the explanation?
> "
> The reason for an internal map flag is twofolds:
> 1) user doesn't need to set the map flag explicitly
> map_create() will use the presence of bpf_dynptr in map key as an
> indicator of enabling dynptr key.
> 2) avoid adding new arguments for ->map_alloc_check() and ->map_alloc()
> map_create() needs to pass the supported status of dynptr key to
> ->map_alloc_check (e.g., check the maximum length of dynptr data size)
> and ->map_alloc (e.g., check whether dynptr key fits current map type).
> Adding new arguments for these callbacks to achieve that will introduce
> too much churns.
>
> Therefore, the patch uses the topmost bit of map_flags as the internal
> map flag. map_create() checks whether the internal flag is set in the
> beginning and bpf_map_get_info_by_fd() clears the internal flag before
> returns the map flags to userspace.
> "
>
> As commented in the other patch map_extra can be dropped (I hope).
> When it's gone, the map can be destroyed after creation in map_check_btf().
> What am I missing?

If I understanding correctly, you are suggesting to replace
(map->map_flags & BPF_INT_F_DYNPTR_IN_KEY) with !!map->key_record, right
? And you also don't want to move map_check_btf() before the invocation
of ->map_alloc_check() and ->map_alloc(), right ? However, beside the
checking of map_extra, ->map_alloc_check() also needs to know whether
the dynptr-typed key is suitable for current hash map type or map flags.
->map_alloc() also needs to allocate a bpf mem allocator for the dynptr
key. So are you proposing the following steps for creating a dynkey hash
map:

1) ->map_alloc_check()
no change

2) ->map_alloc()
allocate bpf mem allocator for dynptr unconditionally

3) map_check_btf()
invokes an new map callback (e.g., ->map_alloc_post_check()) to check
whether the created map is mismatched with the dynptr key and destroy it
if it is.

?



