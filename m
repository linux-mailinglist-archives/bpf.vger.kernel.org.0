Return-Path: <bpf+bounces-45806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5E9DB210
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37111B21A8E
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A813665A;
	Thu, 28 Nov 2024 04:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC0134BD
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767155; cv=none; b=WCAz0b5usrA9ndwAolPWb23AyXPJUf/i4CQFp5vglkkxXO1Xr/hK7RA6wJ5OTLaYa+X9Fkaoge7NvbCNgnTVgZ0wdCmdi095+i22eYzcEUUi1gFo3+znphemBCwJ9jhdJM5IRJIc2+u39mfYjQlp4CYuUuUM7laLC0SOQZEi++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767155; c=relaxed/simple;
	bh=eJzpk5d1JMvHW2fvLToYDw7hINzg53RZCNHFOBscJLw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TQ+XaH+s+Y1VaZujHzNolL7hQAuTdTvO6GU8zJI8eMn2eK7sMteJK7xHZ3TmiUmYLgi0Px3/bIAhjAdD85ohxPPTAQR9jnnuJ5U3rtzqooq9ELw8EOXnB43mda6OfQ7NepthS544IOlQh74wr00lE0Rw3wLuAZpx8Uw3gjROmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XzNDm55SBz4f3jsx
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 12:12:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 74CD51A058E
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 12:12:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDHbrCi7UdngxHjCw--.1022S2;
	Thu, 28 Nov 2024 12:12:22 +0800 (CST)
Subject: Re: [PATCH bpf v2 6/9] bpf: Switch to bpf mem allocator for LPM trie
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-7-houtao@huaweicloud.com>
 <CAADnVQKZ3=F0L7_R_pYqu7ePzpXRwQEN8tCzmFoxjdJHamMOUQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <98ff0c5e-e2ed-3d5e-08a2-7d320372bc7e@huaweicloud.com>
Date: Thu, 28 Nov 2024 12:12:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKZ3=F0L7_R_pYqu7ePzpXRwQEN8tCzmFoxjdJHamMOUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHbrCi7UdngxHjCw--.1022S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xGw1rWrWxKr4ktr1UWrg_yoW8CF1kpF
	Z7GFyrtr4kZr1qqr1xXws7Wa48ZrsxKFs8Wa4kWF4jk3sxuF9aqrW8ZFWYgFW5Wrs3K3yS
	vr1UK3s5Wr4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 11/27/2024 1:51 PM, Alexei Starovoitov wrote:
> On Tue, Nov 26, 2024 at 4:34 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> 2. nodes are freed before invoking spin_unlock_irqrestore(). Therefore,
>> there is no need to add paired migrate_{disable|enable}() calls for
>> these free operations.
> ...
>
>>         if (ret)
>> -               kfree(new_node);
>> +               bpf_mem_cache_free(&trie->ma, new_node);
>> +       bpf_mem_cache_free_rcu(&trie->ma, free_node);
>>         spin_unlock_irqrestore(&trie->lock, irq_flags);
>> -       kfree_rcu(free_node, rcu);
> ...
>
>> +       bpf_mem_cache_free_rcu(&trie->ma, free_parent);
>> +       bpf_mem_cache_free_rcu(&trie->ma, free_node);
>>         spin_unlock_irqrestore(&trie->lock, irq_flags);
>> -       kfree_rcu(free_parent, rcu);
>> -       kfree_rcu(free_node, rcu);
> going back to under lock wasn't obvious.
> I only understood after reading the commit log for the 2nd time.
>
> Probably a code comment would be good.

Missed that. Will be alert next time.
>
> Though I wonder whether we should add migrate_disable/enable
> in the syscall path of these callbacks.
> We already wrapped them with rcu_read_lock().
> Extra migrate_disable() won't hurt.

It seems that bpf program has already been running with migration
disabled. I think we could also do the similar thing for the syscall path.
>
> And it will help this patch. bpf_mem_cache_free_rcu() can be
> done outside of bucket lock.
> bpf_ma can easily exhaust the free list in irq disabled region,
> so the more operations outside of the known irq region the better.
>
> Also it will help remove migrate_disable/enable from a bunch
> of places in kernel/bpf where we added them due to syscall path
> or map free path.
>
> It's certainly a follow up, if you agree.
> This patch set will go through bpf tree
> (after hopefully few more acks from reviewers)
Thanks for the suggestion. Will try it.


