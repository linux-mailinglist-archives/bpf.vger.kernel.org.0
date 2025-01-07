Return-Path: <bpf+bounces-48089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5520AA03EC5
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FCF3A26AB
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215611F1900;
	Tue,  7 Jan 2025 12:10:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52E1F0E37
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251798; cv=none; b=XZFpWnmHt/teyXd99ua4++lp+uPNvNvQSGhxm91RjrLvkl+AZ+EDF+0qQVByfW3P9Bk6Ynjw0jd7BGreuGWwDfBp+UbCBT8FLxmQ26wf3S4IBODsWgxOcQafN8azoXvAOyhd8vizOGBwEFV6QaoZqDaHaOOdw+KGDvMr00VyXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251798; c=relaxed/simple;
	bh=RjsYnoi5Ln1C78mKcu4tUxE+9up4SBFDTzF3HuIXpFo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iGJxYUQSHmJODbx2v5pMX2wXNuW5D6l1Y+nxO9N43ZiERHCBYgcB5Rd9X329thwQY0blv/e7MKTXhAM3T3HntvszMWSCMAtw1IzTxl7s2jqavKQBNekM+T5R93SSyXIELv21MqB3cr+1ahEYMIBks1uDoA+7ONNyhK74QPViTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YS8wb562kz4f3jdF
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 20:09:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D43C11A0CDF
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 20:09:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDHGcRtGX1nlZUmAQ--.30769S2;
	Tue, 07 Jan 2025 20:09:21 +0800 (CST)
Subject: Re: [PATCH bpf-next 0/7] Free htab element out of bucket lock
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, xukuohai@huawei.com,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9b4ebbaf-dd3c-85a4-2d17-18b8805ea5fb@huaweicloud.com>
Date: Tue, 7 Jan 2025 20:09:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250107085559.3081563-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDHGcRtGX1nlZUmAQ--.30769S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWkGr4kKr4DXF45KFW3ZFb_yoW5ZFWxpF
	WrKw13Kr1kJF9Fqws3t3Z5CrWrAws5Gr4UGr4kJry5Kas8WF1xtr1I9F4YvFWfAr93AF9a
	qw42yw1fG348urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/7/2025 4:55 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set continues the previous work [1] to move all the freeings
> of htab elements out of bucket lock. One motivation for the patch set is
> the locking problem reported by Sebastian [2]: the freeing of bpf_timer
> under PREEMPT_RT may acquire a spin-lock (namely softirq_expiry_lock).
> However the freeing procedure for htab element has already held a
> raw-spin-lock (namely bucket lock), and it will trigger the warning:
> "BUG: scheduling while atomic" as demonstrated by the selftests patch.
> Another motivation is to reduce the locked scope of bucket lock.
>
> The patch set is structured as follows:
>
> * Patch #1 moves the element freeing out of lock for
>   htab_lru_map_delete_node()
> * Patch #2~#3 move the element freeing out of lock for
>   __htab_map_lookup_and_delete_elem()
> * Patch #4~#6 move the element freeing out of lock for
>   htab_map_update_elem()
> * Patch #7 adds a selftest for the locking problem
>
> The changes for htab_map_update_elem() require some explanation. The
> reason that the previous work [1] can't move the element freeing out of
> the bucket lock for preallocated hash table is due to ->extra_elems
> optimization. When alloc_htab_elem() returns, the existed-old element
> has already been stashed in per-cpu ->extra_elems. To handle that, patch
> #5~#7 break the reuse of ->extra_elems and the refill of ->extra_elems
> into two independent steps, do resue with bucket lock being held and do
> refill after unlocking the bucket lock. The downside is that concurrent
> updates on the same CPU may need to pop free element from per-cpu list
> instead of reusing ->extra_elems directly, but I think such case will be
> rare.

Er, the break of reuse and refill of ->extra_elems is buggy. It failed
the htab_update/concurrent_update in BPF CI occasionally. It may also
return the unexpected E2BIG error when the map is full and there are
concurrent overwrites procedure on the same CPU. Need to figure out
another way to handle the lock problem.
> Please see individual patches for more details. Comments are always
> welcome.
>
> [1]: https://lore.kernel.org/bpf/20241106063542.357743-1-houtao@huaweicloud.com
> [2]: https://lore.kernel.org/bpf/20241106084527.4gPrMnHt@linutronix.de
>
> Hou Tao (7):
>   bpf: Free special fields after unlock in htab_lru_map_delete_node()
>   bpf: Bail out early in __htab_map_lookup_and_delete_elem()
>   bpf: Free element after unlock in __htab_map_lookup_and_delete_elem()
>   bpf: Support refilling extra_elems in free_htab_elem()
>   bpf: Factor out the element allocation for pre-allocated htab
>   bpf: Free element after unlock for pre-allocated htab
>   selftests/bpf: Add test case for the freeing of bpf_timer
>
>  kernel/bpf/hashtab.c                          | 170 ++++++++++--------
>  .../selftests/bpf/prog_tests/free_timer.c     | 165 +++++++++++++++++
>  .../testing/selftests/bpf/progs/free_timer.c  |  71 ++++++++
>  3 files changed, 332 insertions(+), 74 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/free_timer.c
>  create mode 100644 tools/testing/selftests/bpf/progs/free_timer.c
>


