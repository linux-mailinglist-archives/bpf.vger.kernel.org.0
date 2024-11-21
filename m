Return-Path: <bpf+bounces-45320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B19D453F
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE481F21E4E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC71BF58;
	Thu, 21 Nov 2024 01:20:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BF70815
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732152044; cv=none; b=MomGVuBBSJf/9BPAz1GAXg5+b7kGB/xwQAut0T2MX2GC6izKuzT0/CG0kGcK/iENEcPto9t+say+dOOnE/xHMLxkUf5qknnCtXzNpEQj4sC1CdgMUrLMEuEC23gG9wC7fq6dtCLvEkQw47D0Wyo/vaiC1+2IkU1A8e5fX3Y79w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732152044; c=relaxed/simple;
	bh=ZDxeB+R5oJh3ifV/WuQgNlJRVkMYzYn6NfUIUr3jcio=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GB670AHwT1Aa4e6qnEqqc8vHKC/PzcIEW5OB5LVBBOt4/hm+Yr7rhx45SDo78plCnWu6MGdMeJTO1IesUIsq/mqGs69T1mCjB2fvao3/5RRlFbMDur+uOGiVZRA3XC6NVkizTRknPpLpu6pO1AmYK+qqR1vOb6tdZ0F8gg0ig/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xv0ld0l4sz4f3jsh
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 09:20:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A00DF1A0568
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 09:20:31 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBH8bLbij5nn01KCQ--.9058S2;
	Thu, 21 Nov 2024 09:20:31 +0800 (CST)
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM
 trie
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com>
 <CAADnVQJPhkNbq0nHANJ5W03-dQ3t7ZPeh3gk+WJbtXFOL=GwUA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <31bf6193-2154-443e-4811-9f71a4fab7cf@huaweicloud.com>
Date: Thu, 21 Nov 2024 09:20:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJPhkNbq0nHANJ5W03-dQ3t7ZPeh3gk+WJbtXFOL=GwUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBH8bLbij5nn01KCQ--.9058S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW3KF1kCr13Wr1DCFWktFb_yoW8ArWkpF
	4ftFyrArn8tFsrJr4xWw4xWa4SvanYgF1YkF4jyrW5ur43Xrn8Cr48Zay3ZFy5AF4kCw1I
	qr1vkry3ZFs5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Alexei,

On 11/20/2024 9:16 AM, Alexei Starovoitov wrote:
> On Sun, Nov 17, 2024 at 4:56 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>> +enum {
>> +       LPM_TRIE_MA_IM = 0,
>> +       LPM_TRIE_MA_LEAF,
>> +       LPM_TRIE_MA_CNT,
>> +};
>> +
>>  struct lpm_trie {
>>         struct bpf_map                  map;
>>         struct lpm_trie_node __rcu      *root;
>> +       struct bpf_mem_alloc            ma[LPM_TRIE_MA_CNT];
>> +       struct bpf_mem_alloc            *im_ma;
>> +       struct bpf_mem_alloc            *leaf_ma;
> We cannot use bpf_ma-s liberally like that.
> Freelists are not huge, but we shouldn't be adding new bpf_ma
> in every map and every use case.
>
> bpf_mem_cache_is_mergeable() in the previous patch also
> leaks implementation details.
>
> Can you use bpf_global_ma for all nodes?

Will try. However, there are mainly two differences between
bpf_global_ma and map specific bpf_mem_alloc. The first one is the
memory accounting problem. All memories allocated from bpf_global_ma
will be accounted to the root memory cgroup instead of the current
memory cgroup (due to the return value of get_memcg()). I think we could
fix this partially by returning NULL instead of root_mem_cgroup when
c->objcg is NULL. However, even with the fix, the memory account is
still inaccurate, because these pre-allocated objects may be used by
other maps instead of the map which triggers the pre-allocation. The
second one is the freeing of freed objects  when destroying the map. For
a map specific bpf_mem_alloc, most of these freed objects could be freed
immediately back to slub, However, it is not true for the bpf_global_ma,
because we could not tell whether the object belongs to a to-be-freed
map or not. And also we can not drain the bpf_global_ma just like we do
for bpf_mem_alloc.
>
> pw-bot: cr
> .


