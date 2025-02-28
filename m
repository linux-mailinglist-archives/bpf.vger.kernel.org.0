Return-Path: <bpf+bounces-52833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C57A48E07
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A87A30B8
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8505C2628C;
	Fri, 28 Feb 2025 01:36:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43571276D11
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706614; cv=none; b=dZq4ixe/yXc8h0KO5oCnOBzP0dbWZPT/pWextq+PkHrf6SKXA2TgGoJ03vRqSeT3Bp05YI2bNIP91iroBdfGFFLUcRlc/X4mZXPlj7f1P2EnOCkX3bhF76BhyGXsGtfBmVxMC1vqutmKhWlbidqDVOtKzP0Tnf6Q3itLbyzKiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706614; c=relaxed/simple;
	bh=RbzbMWGVly78V4pUuZUnqdXRPb9Ap5sUfz/pP5jq93Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aCGjH8ANzPxYuy7oz2+DcF8mJmZOCEbJqxMybFlldFrxzgmOYiX4RQQIPsuVwcQ4jhNPmTlIh49FSbIEAu9ieEJoyBMXY2ZYd9PERjDDpQTEauiRwLZxgKfFy4Yg7gPUxIM46Dva+9nICoic0QYDjUr42bSsplieEKaFsubwgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3qZh15RZz4f3nTw
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 08:58:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7FAE41A14AB
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 08:58:43 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXu3s_CsFnohshFA--.16502S2;
	Fri, 28 Feb 2025 08:58:43 +0800 (CST)
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
 <01e5b3ca-86d3-46a9-742a-3b69f378d141@huaweicloud.com>
 <012917a0-e707-0527-f1f2-bb3f38464c7e@huaweicloud.com>
 <CAADnVQ+ng5wPns+tbFAumWLoZzNnho8pRVaorKGBA=6h9NsYhw@mail.gmail.com>
 <CAADnVQ+o=2XQ2Wo-Roe35ahq=zgHjC19ptsbRJa1DVir5umqxw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <dac0c127-1876-b936-5d59-bfd29e11c687@huaweicloud.com>
Date: Fri, 28 Feb 2025 08:58:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+o=2XQ2Wo-Roe35ahq=zgHjC19ptsbRJa1DVir5umqxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXu3s_CsFnohshFA--.16502S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13Kw48CF4kKw1kAw4ruFg_yoW8ur4fpF
	WrGFyagws2k34xtw1xt3WDJayjyr4FgrW7Arn3XryUA345XrsxWryrA3W5urn3Cr98t343
	XF4jya4fuayruaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2/28/2025 5:10 AM, Alexei Starovoitov wrote:
> On Fri, Feb 14, 2025 at 9:30 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Thu, Feb 13, 2025 at 11:25 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>

SNIP
>>>
>>> 3) ->map_check_btf()
>>>
>>> In ->map_check_btf() callback, check whether the created map is
>>> mismatched with the dynptr key. If it is, let map_create() destroys the map.
>> map_check_btf() itself can have the code to filter out unsupported maps
>> like it does already:
>>                         case BPF_WORKQUEUE:
>>                                 if (map->map_type != BPF_MAP_TYPE_HASH &&
>>                                     map->map_type != BPF_MAP_TYPE_LRU_HASH &&
>>                                     map->map_type != BPF_MAP_TYPE_ARRAY) {
>>                                         ret = -EOPNOTSUPP;
>>
>> I don't mind moving map_check_btf() before ->map_alloc_check()
>> since it doesn't really need 'map' pointer.
>> I objected to partial move where btf_get_by_fd() is done early
>> while the rest after map allocation.
>> Either all map types do map_check_btf() before alloc or
>> all map types do it after.
>>
>> If we move map_check_btf() before alloc
>> then the final map->ops->map_check_btf() should probably
>> stay after alloc.
>> Otherwise this is too much churn.
>>
>> So I think it's better to try to keep the whole map_check_btf() after
>> as it is right now.
>> I don't see yet why dynptr-in-key has to have it before.
>> So far map_extra limitation was the only special condition,
>> but even if we have to keep (which I doubt) it can be done in
>> map->ops->map_check_btf().
> Any update on this ?
> Two weeks have passed.
> iirc above was the only thing left to resolve.
Er, I started adding bpffs seq-file and batched operation support
recently.  I need to ask whether it is OK to complete these todo items
shown below in the following patch-set. As noted in the cover letter,
the following things have not been supported yet:

1) batched map operation through bpf syscall
2) the memory accounting for dynptr (aka .htab_map_mem_usage)
3) btf print for the dynptr in map key
4) bpftool support
5) the iteration of elements through bpf program


