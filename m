Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5F6AFB60
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCHAja (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCHAjW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:39:22 -0500
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD3A80E6
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:38:47 -0800 (PST)
Message-ID: <ad7666cc-3ec4-0401-c571-7d07a8f7fbbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678235914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7oqWULignyooafnktoVZ02SkCi++8xwyo3TfGEvncw=;
        b=cMigPjGCFQjzhoNgTGJrp+MAe6iOWFgr3idYc7JJCO3dwmgD+438cqXJ02tEJ1fh49nFpo
        QwkalMg7AhtMuGKSnbe0tf+khdGpqe0fIB+pgaodqv/qqTXVSebbM6Vm+3APzz551EvJ4z
        H9hOYn9GMVMRhqTnU6b8Zom5RRwyEcU=
Date:   Tue, 7 Mar 2023 16:38:30 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 12/16] bpf: Use bpf_mem_cache_alloc/free in
 bpf_selem_alloc/free
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@meta.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20230306084216.3186830-1-martin.lau@linux.dev>
 <20230306084216.3186830-13-martin.lau@linux.dev>
 <CAADnVQJck3WUKNht++fAjKRTBtLUVL2K2FrWeyUr=+MMeiiZvQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJck3WUKNht++fAjKRTBtLUVL2K2FrWeyUr=+MMeiiZvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/6/23 7:47 PM, Alexei Starovoitov wrote:
>> @@ -80,12 +80,32 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>>          if (charge_mem && mem_charge(smap, owner, smap->elem_size))
>>                  return NULL;
>>
>> -       selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
>> -                               gfp_flags | __GFP_NOWARN);
>> +       migrate_disable();
>> +       selem = bpf_mem_cache_alloc(&smap->selem_ma);
>> +       migrate_enable();
>> +       if (!selem && (gfp_flags & GFP_KERNEL)) {
>> +               void *ma_node;
>> +
>> +               ma_node = bpf_map_kzalloc(&smap->map,
>> +                                         BPF_MA_SIZE(smap->elem_size),
>> +                                         gfp_flags | __GFP_NOWARN);
>> +               if (ma_node)
>> +                       selem = BPF_MA_PTR(ma_node);
>> +       }
> 
> If I understand it correctly the code is not trying
> to free selem the same way it allocated it.
> So we can have kzalloc-ed selems freed into bpf_mem_cache_alloc free-list.
> That feels dangerous.
> I don't think we can do such things in local storage,
> but if we add this api to bpf_mem_alloc it might be acceptable.
> I mean mem alloc will try to take from the free list and if empty
> and GFP_KERNEL it will kzalloc it.
> The knowledge of hidden llist_node shouldn't leave the bpf/memalloc.c file.
> reuse_now should probably be a memalloc api flag too.
> The implementation detail that it's scary but ok-ish to kfree or
> bpf_mem_cache_free depending on circumstances should stay in memalloc.c

All make sense. I will create a bpf_mem_cache_alloc_flags(..., gfp_t flags) to 
hide the llist_node and kzalloc details. For free, local storage still needs to 
use the selem->rcu head in its call_rcu_tasks_trace(), so I will create a 
bpf_mem_cache_raw_free(void *ptr) to hide the llist_node details, like:

/* 'struct bpf_mem_alloc *ma' is not available at this
  * point but the caller knows it is percpu or not and
  * call different raw_free function.
  */
void bpf_mem_cache_raw_free(void *ptr)
{
         kfree(ptr - LLIST_NODE_SZ);
}
