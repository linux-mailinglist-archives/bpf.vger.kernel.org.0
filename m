Return-Path: <bpf+bounces-59476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBCACBE95
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7E73A5817
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B338DD1;
	Tue,  3 Jun 2025 02:46:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464262C3247
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748918766; cv=none; b=NsyCa9+Xe4p1O8WHDSWCdGkO6ozBN0a48KEnPWdrbISGAq4z0qid6XxE/WusH84oIOLGKVM1dY5ugibEgNJASkDH2SWMuuG6r4ZwweF25NH8o492QMlpheMZpumFK/5GHOzbMigD0ggs/S2aocb9EX0rcjvkkC8FpOZb3ZQMGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748918766; c=relaxed/simple;
	bh=7AIzeC584b801qPLFLXdu/lDLP2GggX4RA/COuyqmEU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PC6cOd+xz519QzG8G8VscTLKl/7P2eoipVEgKJSm/1KsvVOeRi8e7hRHdGVfQ062uNX6Op65tcEj8EOQJfntA4nXz2JWreNU9QjFZPZ78Fo1SxjtDOPARzsIjEoGIDEOJI6m7XZmAm/48WwSeMVSU/TAQkiJ5B9IirF+UqxbOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bBF2m5nMnzKHMjD
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 10:26:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3574F1A084E
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 10:26:39 +0800 (CST)
Received: from [10.174.177.163] (unknown [10.174.177.163])
	by APP3 (Coremail) with SMTP id _Ch0CgAnxsBbXT5ohE55OA--.9265S2;
	Tue, 03 Jun 2025 10:26:39 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf mem allocator dtor
 for hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
 <20250526062555.1106061-3-houtao@huaweicloud.com>
 <CAADnVQLH3Ut8dF9t=_zB4acbZYuN=9+fgsACossGqFVTPO6EaQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <137a5a3f-c571-5ade-7ea1-d224ec6b36f0@huaweicloud.com>
Date: Tue, 3 Jun 2025 10:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLH3Ut8dF9t=_zB4acbZYuN=9+fgsACossGqFVTPO6EaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAnxsBbXT5ohE55OA--.9265S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr15JF1rGFykWF1rZr4Utwb_yoW5tFW5pF
	WrGF13Kr4kXa9akwn3Xa12yry5Aws5GFyUCa45KryYkry5Wr97Kr4fu3y3XF1rCrykt3sY
	q39Iv3ZI9ayDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 6/3/2025 7:08 AM, Alexei Starovoitov wrote:
> On Sun, May 25, 2025 at 11:08 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> BPF hash map supports special fields in its value, and BPF program is
>> free to manipulate these special fields even after the element is
>> deleted from the hash map. For non-preallocated hash map, these special
>> fields will be leaked when the map is destroyed. Therefore, implement
>> necessary BPF memory allocator dtor to free these special fields.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/hashtab.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index dd6c157cb828..2531177d1464 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -128,6 +128,8 @@ struct htab_elem {
>>         char key[] __aligned(8);
>>  };
>>
>> +static void check_and_free_fields(struct bpf_htab *htab, struct htab_elem *elem);
>> +
>>  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
>>  {
>>         return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
>> @@ -464,6 +466,33 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>>         return 0;
>>  }
>>
>> +static void htab_ma_dtor(void *obj, void *ctx)
>> +{
>> +       struct bpf_htab *htab = ctx;
>> +
>> +       /* The per-cpu pointer saved in the htab_elem may have been freed
>> +        * by htab->pcpu_ma. Therefore, freeing the special fields in the
>> +        * per-cpu pointer through the dtor of htab->pcpu_ma instead.
>> +        */
>> +       if (htab_is_percpu(htab))
>> +               return;
>> +       check_and_free_fields(htab, obj);
>> +}
> It seems the selftest in patch 3 might be working "by accident",
> but older tests should be crashing?

Er, didn't follow the reason why the older test should be crashing.  For
the per-cpu hash map, the per-cpu pointer gets through
htab_elem_get_ptr() is valid until one tasks trace RCU gp passes,
therefore, the bpf prog will always manipulate a valid per-cpu pointer.
The comment above wants to say is that htab_elem_get_ptr() in
htab_ma_dtor() may return a freed per-cpu pointer, because the order of
freeing htab_elem->ptr_to_pptr and htab_elem is nondeterministic.

> It looks like you're calling check_and_free_fields() twice now.
> Once from htab_elem_free() and then again in htab_ma_dtor() ?
>
> If we're going for dtor then htab should delegate all clean up to it.

Yes. check_and_free_fields() is called twice. There are three possible
locations to free the special fields:

1) when the element is freed through bpf_mem_cache_free()
2) before the element is reused
3) before the element is freed to slab.

3) is necessary to ensure these special fields will not be leaked and 1)
is necessary to ensure these special fields will be freed before it is
reused. I didn't find a good way to only call it once. Maybe adding a
bit flag to the pointer of the element to indicate that it has been
destroyed is OK ? Will try it in the next revision.

>
> I wonder whether htab_put_fd_value() in free_htab_elem() has
> similar issue with hash-of-map. Looks correct on the first glance.
> .

Do you mean special fields in the inner map or the element in the inner
map ? For the former case, I think it is the same as the normal hash
table. For the latter case, I think it is fine because the freeing of
the inner map is deferred according to the program which may access it.


