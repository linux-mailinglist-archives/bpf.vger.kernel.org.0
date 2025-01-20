Return-Path: <bpf+bounces-49285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00DA16866
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 09:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD0818891A3
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774B194C92;
	Mon, 20 Jan 2025 08:50:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E37E1
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363013; cv=none; b=RWt4/zphjACWNtNEVwLY2DfBgKn5OTYPfOMsS/e2FyD0Z91eFLwA9izAIrxxZVgVEvoYNuYAb0G+zRsAeYydyu0izoepchsZ35zYijAK8RVC/WZH6ykUxPy37oIR02A02yatt0owP1Sa1VdQD8aGHUaENwk92wQQvCOz8O/LSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363013; c=relaxed/simple;
	bh=v0P4vue0CQjGjg+jonwOW2P5yRCbRgtBBcNw8OVyXJk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TXY5t/PAh3OQPNeuQazJHcOGMzdp0/+wenKmoJ0ELu+AmNdV7WQpmkck/qMVhnMBSqa7MiHry6gIv9RzDCEh9qcy/ONL4rQmuSfR9Pf0kyaq9vrJJssaMzSIgYiZZbTf7+oNAxj95Bd037HHAk9cxZGdAaYpd0NW/wy+kDoxX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yc3td4Fwrz4f3jXy
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 16:49:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2B95C1A0D37
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 16:50:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCnDH0pDo5nPxHVBQ--.25586S2;
	Mon, 20 Jan 2025 16:50:05 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Free element after unlock in
 __htab_map_lookup_and_delete_elem()
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-4-houtao@huaweicloud.com> <87o705oby2.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <96a1e15a-52d8-acee-aee8-f494f009d2d7@huaweicloud.com>
Date: Mon, 20 Jan 2025 16:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o705oby2.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCnDH0pDo5nPxHVBQ--.25586S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy3GrW7CF17WrW5AFWfAFb_yoWfWFgE9r
	s5tFZ7Can5Wws3t3Wjyr4xGr4IkFWUGF18ArW8trW7Ar4rZaykZFsxuryavryfZa97Ja15
	KFnYqayDA34xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU0s2-5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/17/2025 8:35 PM, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The freeing of special fields in map value may acquire a spin-lock
>> (e.g., the freeing of bpf_timer), however, the lookup_and_delete_elem
>> procedure has already held a raw-spin-lock, which violates the lockdep
>> rule.
> This implies that we're fixing a locking violation here? Does this need
> a Fixes tag?
>
> -Toke

Ah, the fix tag is a bit hard. The lockdep violation in the patch is
also related with PREEMPT_RT, however, the lookup_and_delete_elem is
introduced in v5.14. Also considering that patch #4 will also fix the
lockdep violation in the case, I prefer to not add a fix tag in the
patch. Instead I will update the commit message for the patch to state
that it will reduce the lock scope of bucket lock. What do you think ?
> .


