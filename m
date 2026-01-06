Return-Path: <bpf+bounces-77915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A1CF6800
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 03:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0DE730210D8
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 02:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849C23EABF;
	Tue,  6 Jan 2026 02:44:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CE20468E;
	Tue,  6 Jan 2026 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667479; cv=none; b=aGJj8yQxMSJI1UjIy1wNip69DSuA5HTKnDmJD3umP8lRBvwaPRwb4FXScbDh0475OVFLjI+JTOm7medB0B/6KLH3DIW2QEq7f2HWLeRIH7fcPKkMpCJLIF3MPjmgbeoh1UM9t9lRsy1z7OD4CG0s7xyfVRvIgn3Xf11hVaGiguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667479; c=relaxed/simple;
	bh=xl8NxzKHk60ABfeTu1tc38ZYZqWuMncWIqmfh9j+rVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgNCpWOxVUzuWNfa12dzHi8vYcqEWUrO0lksE+XqZIpwHs6tCV+OSg5zp5WeNQSUKkQWIp8sOzbhPMkrK30pdg0/OJ6hNTTPegVlmrJIhmatZjoiy2qGqsk9tu6RheOvQxux7LPe2mTwW8Et8MKJ3wWvBLjrLWfQkBN7DD6b1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dlb862KVLzYQtgV;
	Tue,  6 Jan 2026 10:43:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2181340577;
	Tue,  6 Jan 2026 10:44:34 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA35vYQd1xp4sMoCw--.16779S2;
	Tue, 06 Jan 2026 10:44:33 +0800 (CST)
Message-ID: <014d87db-f389-4bba-be79-f5650ad08003@huaweicloud.com>
Date: Tue, 6 Jan 2026 10:44:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 mm-unstable tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Chen Ridong <chenridong@huawei.com>,
 JP Kobryn <inwardvessel@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20260105130413.273ee0ee@canb.auug.org.au>
 <CAADnVQKkphWpwKE17bGQao36dH8xqCyV-iXDcagrO7s-VOPE-w@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CAADnVQKkphWpwKE17bGQao36dH8xqCyV-iXDcagrO7s-VOPE-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vYQd1xp4sMoCw--.16779S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1ruF48tF1UCFWkCw43trb_yoW5XrWrpF
	ZrA3W3KayUArWrJF4Ska4j9a4fZw1xXw12yr9Ig348ZFy3tw1fXasxCws8CF15CF9YgF13
	trZxtw1kGw43AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/6 10:15, Alexei Starovoitov wrote:
> On Sun, Jan 4, 2026 at 6:04 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the bpf-next tree got a semantic conflict in:
>>
>>   include/linux/memcontrol.h
>>   mm/memcontrol-v1.c
>>   mm/memcontrol.c
>>
>> between commit:
>>
>>   eb557e10dcac ("memcg: move mem_cgroup_usage memcontrol-v1.c")
>>
>> from the mm-unstable tree and commit:
>>
>>   99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics and events")
>>
>> from the bpf-next tree producing this build failure:
>>
>> mm/memcontrol-v1.c:430:22: error: static declaration of 'mem_cgroup_usage' follows non-static declaration
>>   430 | static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>>       |                      ^~~~~~~~~~~~~~~~
>> In file included from mm/memcontrol-v1.c:3:
>> include/linux/memcontrol.h:953:15: note: previous declaration of 'mem_cgroup_usage' with type 'long unsigned int(struct mem_cgroup *, bool)' {aka 'long unsigned int(struct mem_cgroup *, _Bool)'}
>>   953 | unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>>       |               ^~~~~~~~~~~~~~~~
>>
>> I fixed it up (I reverted the mm-unstable tree commit) and can carry the
>> fix as necessary. This is now fixed as far as linux-next is concerned,
>> but any non trivial conflicts should be mentioned to your upstream
>> maintainer when your tree is submitted for merging.  You may also want
>> to consider cooperating with the maintainer of the conflicting tree to
>> minimise any particularly complex conflicts.
> 
> Hey All,
> 
> what's the proper fix here?
> 
> Roman,
> 
> looks like adding mem_cgroup_usage() to include/linux/memcontrol.h
> wasn't really necessary, since kfuncs don't use it anyway?
> Should we just remove that line in bpf-next?
> 

I agree, mem_cgroup_usage() is not declared in next.

I'm wondering why there is a difference between next and bpf-next.

> Just:
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6a5d65487b70..229ac9835adb 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -950,7 +950,6 @@ static inline void mod_memcg_page_state(struct page *page,
>  }
> 
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
> -unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
>  unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  bool memcg_stat_item_valid(int idx);
> 
> compiles fine.
> 
> If you agree pls send an official patch.
> 

-- 
Best regards,
Ridong


