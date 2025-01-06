Return-Path: <bpf+bounces-47939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EBA02086
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5A91881849
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93E51A2631;
	Mon,  6 Jan 2025 08:18:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAC35952;
	Mon,  6 Jan 2025 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151526; cv=none; b=kZdFD/Qw/iefWm4WS+Xos+8+s6dLvuSI7j3fHtMLbdct5LE2PtiR0lCXjwJtbJnca7FAvKryio0PpGZ/lHU/5NyfcqwVHgXrH7PZHTcqYKEyFqACzIJcwseAW+OMnXylqtUNGOFpk5T9ehldttv4SsVPR1G2sE28KKA88qFsBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151526; c=relaxed/simple;
	bh=Qv1uZ9xv8DoSDXorsLKhgEI652bYODAL01ifmwQ9RF0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XzpvmANrz3P+Nk2TV3JL1hmQkhgrVZATh83gxDy3vqaYOloikr2aADum/G68VFiVF6xu9V+keCXDuu7p+sH4AtQrfiRySieb8ayWg1fzRJzIUXkNPtcoWaUT8rmHYScpM1Z2TfmlLiDjXY1YKaUCXnngqiUrL/mKc1RBbGvoF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRrq08lPz4f3lDF;
	Mon,  6 Jan 2025 16:18:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4C7B71A0D4F;
	Mon,  6 Jan 2025 16:18:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3F8LakXtndt26AA--.6626S2;
	Mon, 06 Jan 2025 16:18:38 +0800 (CST)
Subject: Re: faom 13cc1d4ee0a231f81951ee87f1e55229907966ee Mon Sep 17 00:00:00
 2001
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xukuohai@huawei.com,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f516ac54-058b-1b7d-ab21-8405e1fe77fa@huaweicloud.com>
Date: Mon, 6 Jan 2025 16:18:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250106081900.1665573-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3F8LakXtndt26AA--.6626S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWDWF48KryxAr1DuFyxAFb_yoWrZF1xpr
	4fK34fKr4UXa4S9anxAw4IkFyrAw4fG347AwnrKryrtws8Zr98Xw1xJF48ZFZxCryktryf
	Xr1qqw1qkw1kAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JV
	W7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

The header of patch #0 is broken for the patch set. However, it seems
BPF CI still can handle it and the content of patch #0 is still intact,
so I will not resend the patch set and instead I will respin it after
receiving some comments. Sorry for the inconvenience.

On 1/6/2025 4:18 PM, Hou Tao wrote:
> Hi,
>
> The use of migrate_{disable|enable} pair in BPF is mainly due to the
> introduction of bpf memory allocator and the use of per-CPU data struct
> in its internal implementation. The caller needs to disable migration
> before invoking the alloc or free APIs of bpf memory allocator, and
> enable migration after the invocation.
>
> The main users of bpf memory allocator are various kind of bpf maps in
> which the map values or the special fields in the map values are
> allocated by using bpf memory allocator.
>
> At present, the running context for bpf program has already disabled
> migration explictly or implictly, therefore, when these maps are
> manipulated in bpf program, it is OK to not invoke migrate_disable()
> and migrate_enable() pair. Howevers, it is not always the case when
> these maps are manipulated through bpf syscall, therefore many
> migrate_{disable|enable} pairs are added when the map can either be
> manipulated by BPF program or BPF syscall.
>
> The initial idea of reducing the use of migrate_{disable|enable} comes
> from Alexei [1]. I turned it into a patch set that archives the goals
> through the following three methods:
>
> 1. remove unnecessary migrate_{disable|enable} pair
> when the BPF syscall path also disables migration, it is OK to remove
> the pair. Patch #1~#3 fall into this category, while patch #4~#5 are
> partially included.
>
> 2. move the migrate_{disable|enable} pair from inner callee to outer
>    caller
> Instead of invoking migrate_disable() in the inner callee, invoking
> migrate_disable() in the outer caller to simplify reasoning about when
> migrate_disable() is needed. Patch #4~#5 and patch #6~#19 belongs to
> this category.
>
> 3. add cant_migrate() check in the inner callee
> Add cant_migrate() check in the inner callee to ensure the guarantee
> that migration is disabled is not broken. Patch #1~#5, #13, #16~#19 also
> belong to this category.
>
> Considering the bpf-next CI is broken, the patch set is verified by
> using bpf tree. Please check the individual patches for more details.
> Comments are always welcome.
>
> [1]: https://lore.kernel.org/bpf/CAADnVQKZ3=F0L7_R_pYqu7ePzpXRwQEN8tCzmFoxjdJHamMOUQ@mail.gmail.com
>
> Hou Tao (19):
>   bpf: Remove migrate_{disable|enable} from LPM trie
>   bpf: Remove migrate_{disable|enable} in ->map_for_each_callback
>   bpf: Remove migrate_{disable|enable} in htab_elem_free
>   bpf: Remove migrate_{disable|enable} from bpf_cgrp_storage_lock
>     helpers
>   bpf: Remove migrate_{disable|enable} from bpf_task_storage_lock
>     helpers
>   bpf: Disable migration when destroying inode storage
>   bpf: Disable migration when destroying sock storage
>   bpf: Disable migration when cloning sock storage
>   bpf: Disable migration in bpf_selem_free_rcu
>   bpf: Disable migration in array_map_free()
>   bpf: Disable migration in htab_map_free()
>   bpf: Disable migration for bpf_selem_unlink in
>     bpf_local_storage_map_free()
>   bpf: Remove migrate_{disable|enable} in bpf_obj_free_fields()
>   bpf: Remove migrate_{disable,enable} in bpf_cpumask_release()
>   bpf: Disable migration before calling ops->map_free()
>   bpf: Remove migrate_{disable|enable} from bpf_selem_alloc()
>   bpf: Remove migrate_{disable|enable} from bpf_local_storage_alloc()
>   bpf: Remove migrate_{disable|enable} from bpf_local_storage_free()
>   bpf: Remove migrate_{disable|enable} from bpf_selem_free()
>
>  kernel/bpf/arraymap.c          |  6 ++----
>  kernel/bpf/bpf_cgrp_storage.c  | 15 +++++++-------
>  kernel/bpf/bpf_inode_storage.c |  9 ++++----
>  kernel/bpf/bpf_local_storage.c | 38 +++++++++++++++-------------------
>  kernel/bpf/bpf_task_storage.c  | 15 +++++++-------
>  kernel/bpf/cpumask.c           |  2 --
>  kernel/bpf/hashtab.c           | 21 ++++++++-----------
>  kernel/bpf/helpers.c           |  4 ----
>  kernel/bpf/lpm_trie.c          | 24 +++++++--------------
>  kernel/bpf/range_tree.c        |  2 --
>  kernel/bpf/syscall.c           | 12 ++++++++---
>  net/core/bpf_sk_storage.c      | 11 ++++++----
>  12 files changed, 71 insertions(+), 88 deletions(-)
>


