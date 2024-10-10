Return-Path: <bpf+bounces-41515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99109979FE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B55A2848F4
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C1B22EE5;
	Thu, 10 Oct 2024 01:10:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817817BA1
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522600; cv=none; b=O7AbINMFUCfQVT1XiqWU4XWfNRsb54kVoowjSCfbYRGncSxY8VRInSIorYbGs/RNXfj1ox0pMq0CywHnt7hCJLq8s2ugBhYEOrsxfmrZrayPoCHy70Bhtg3pDBcpG1a1W/LN5d9r1JPT1Bu3C57SDQgUGk0mZ1Ko4P1Qz1kyZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522600; c=relaxed/simple;
	bh=fc1V3nEGV/4hHvbQV6WiuS77wArIfMlP4gLJAj4sUwc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iM5KZ02OnpB/mPH+QgON7i2p5cFcqEO/cNWlA33k8jpeWbX5NighUppD3mXlw/trH5vOjCmGz+FNQUTBJiTiw8cRq2zE972K/fJm9vgk1smSVIe5dVIl7V6QHb13rWbJsVW+lApLYAsmavirxCCJE/6wc3gzb/Xa4zP6+eOuU+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPBVt1Gkfz4f3jkL
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 09:09:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EDB2D1A08DC
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 09:09:53 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCHvGFdKQdnP52fDg--.48174S2;
	Thu, 10 Oct 2024 09:09:53 +0800 (CST)
Subject: Re: [PATCH bpf 3/7] bpf: Free dynamically allocated bits in
 bpf_iter_bits_destroy()
To: Yafang Shao <laoar.shao@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-4-houtao@huaweicloud.com>
 <CAEf4BzaxYNZ=xc15O7ai5Fqd8XOON5t-Z25mFGGaSu=63j1T1A@mail.gmail.com>
 <CALOAHbASB9OXkmVnhirB217Ndf9RR4vOZqnJF142UyKaAvdkPw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a14be468-6792-1d24-f127-29fd96a2013d@huaweicloud.com>
Date: Thu, 10 Oct 2024 09:09:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbASB9OXkmVnhirB217Ndf9RR4vOZqnJF142UyKaAvdkPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCHvGFdKQdnP52fDg--.48174S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWkAw4kAF1rCF15GF1kGrg_yoW5WF4Upr
	4fXF1qkr4ktFs2yw1Utr1DKFy5Jr1Yka4UWrs3tFn8CF4UWFyq9r1UWrWag3Z8trsYyF13
	Zr1kC34SvrW5JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi,

On 10/9/2024 7:37 PM, Yafang Shao wrote:
> On Wed, Oct 9, 2024 at 2:26 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Tue, Oct 8, 2024 at 2:05 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> bpf_iter_bits_destroy() uses "kit->nr_bits <= 64" to check whether the
>>> bits are dynamically allocated. However, the check is incorrect and may
>>> cause a kmemleak as shown below:
>>>
>>> unreferenced object 0xffff88812628c8c0 (size 32):
>>>   comm "swapper/0", pid 1, jiffies 4294727320
>>>   hex dump (first 32 bytes):
>>>     b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
>>>     f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
>>>   backtrace (crc 781e32cc):
>>>     [<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
>>>     [<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
>>>     [<00000000597124d6>] __alloc.isra.0+0x89/0xb0
>>>     [<000000004ebfffcd>] alloc_bulk+0x2af/0x720
>>>     [<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
>>>     [<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
>>>     [<000000008b616eac>] bpf_global_ma_init+0x19/0x30
>>>     [<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
>>>     [<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
>>>     [<00000000b119f72f>] kernel_init+0x20/0x160
>>>     [<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
>>>     [<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
>>>
>>> That is because nr_bits will be set as zero in bpf_iter_bits_next()
>>> after all bits have been iterated.
>>>
>> so maybe don't touch nr_bits and just use `kit->bit >= kit->nr_bits`
>> condition to know when iterator is done?
> No, we can't do that. The iterator may only process a few bits, which
> would result in `kit->bit < kit->nr_bits`. Wouldn't it be better to
> simply remove the line `kit->nr_bits = 0;`?

I think that is Andrii wanted to say. And is it more reasonable to also
change the check in the begin of bpf_iter_bits_next() to "bit >= nr_bits" ?

@@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct
bpf_iter_bits *it)
        const unsigned long *bits;
        int bit;

-       if (nr_bits == 0)
+       if (kit->bit >= nr_bits)
                return NULL;


>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1a43d06eab28..7fcd3163cf68 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2939,10 +2939,8 @@ __bpf_kfunc int *bpf_iter_bits_next(struct
> bpf_iter_bits *it)
>
>         bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
>         bit = find_next_bit(bits, nr_bits, kit->bit + 1);
> -       if (bit >= nr_bits) {
> -               kit->nr_bits = 0;
> +       if (bit >= nr_bits)
>                 return NULL;
> -       }
>
>         kit->bit = bit;
>         return &kit->bit;
>
> --
> Regards
>
> Yafang
> .


