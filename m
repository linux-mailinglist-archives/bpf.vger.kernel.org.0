Return-Path: <bpf+bounces-45442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888FD9D5811
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 03:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D5282EC2
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 02:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388542A9E;
	Fri, 22 Nov 2024 02:07:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39D3B1A1
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241227; cv=none; b=SRtEF/oRweY7YVKnL/xig/uoTaH+nQ3je/KU+Bg1x7bpeLU4Z+MYY1BQlyI1FCoD9q+J6WRjnVLnK4yYfZHelvJUtF8AsU2l0WPh445kmVcDYLV3I2atg1LxeBVj4Dw6LGUuplKste9/NvJjwMbio0Bxeufd5eYULdf/tdnFcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241227; c=relaxed/simple;
	bh=z2fZejrV+p2IDG+CHOnWlaiOKoFy4dqmxC9XVS1WR98=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o+3vhXa9KfnBanZphKBWkpFFnUCg07Hce4z9QRo1ND3Ob/bGaIFX6lUTSTS209iIwiX6OujJSMMNuAGIPia26uaxi9lJBuucMtrYO0KD3V0RNAlGAoX/Sz33kDvbo7db13zqS4AlNQvNzbe5cswdw4CY/YCFyxQVGfOnz9H+WL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xvdkp5lJ5z4f3jXm
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 10:06:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5E3C81A018C
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 10:07:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBH9OBB5z9nRWLVCQ--.4165S2;
	Fri, 22 Nov 2024 10:07:01 +0800 (CST)
Subject: Re: [PATCH bpf-next 04/10] bpf: Handle in-place update for full LPM
 trie correctly
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-5-houtao@huaweicloud.com> <878qtcj1rt.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <864758a2-c927-f639-9fff-bf5ce896328e@huaweicloud.com>
Date: Fri, 22 Nov 2024 10:06:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878qtcj1rt.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBH9OBB5z9nRWLVCQ--.4165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4rJFy5uw4DWF4UZFy3XFb_yoW8Zr4xpF
	WSkasxur18tr129w4Syr4kXrW5Xw4xGw43G3Z7Wr1Fya4qkryxG3yDKw48ZFW5Ary8Kr1Y
	qF1Yqryjg398uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/21/2024 6:53 PM, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When a LPM trie is full, in-place updates of existing elements
>> incorrectly return -ENOSPC.
>>
>> Fix this by deferring the check of trie->n_entries. For new insertions,
>> n_entries must not exceed max_entries. However, in-place updates are
>> allowed even when the trie is full.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/lpm_trie.c | 46 +++++++++++++++++++++----------------------
>>  1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>> index 4300bd51ec6e..ff57e35357ae 100644
>> --- a/kernel/bpf/lpm_trie.c
>> +++ b/kernel/bpf/lpm_trie.c
>> @@ -310,6 +310,15 @@ static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
>>  	return node;
>>  }
>>  
>> +static int trie_check_noreplace_update(const struct lpm_trie *trie, u64 flags)
> I think this function name is hard to parse (took me a few tries). How
> about trie_check_add_entry() instead?

Better. However, "entry" is not commonly used. The commonly used noun is
either "node" or "element". Will use trie_check_add_elem().
>
>> +{
>> +	if (flags == BPF_EXIST)
>> +		return -ENOENT;
>> +	if (trie->n_entries == trie->map.max_entries)
>> +		return -ENOSPC;
> The calls to this function are always paired with a trie->n_entries++; -
> so how about moving that into the function after the checks? You'll have
> to then add a decrement if the im_node allocation fails, but I think
> that is still clearer than having the n_entries++ statements scattered
> around the function.

Got it. Will update it in v2.  One motivation for adding n_entries only
necessary is to prevent trie_mem_usage from reading an inaccurate
n_entries, but consider it again I don't think it matters much.
>
> -Toke


