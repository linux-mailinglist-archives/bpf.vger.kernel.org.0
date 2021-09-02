Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613C13FE7EE
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 05:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhIBDRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 23:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhIBDRr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 23:17:47 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7565C061575
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 20:16:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f6so732603iox.0
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 20:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SUe7g/UHtF1EOgdP835Y+4qnpd3f5ih62fapMUqQVuk=;
        b=mT5OIp4fLDHiWaUuH8YmHIg76FXMZfSQ3U8P8zrSJ9TZvSLGb3rhN4Tc7MP8vN/91V
         NV/jurQN8IKxFM8FtCSmw+vifiyAI6p58ZKS4x8sLrpR8UNlQDwBXiAEo3PciMKMcrtS
         HLVzmj8dQjcIDtexcRlQ0EA4hXG3sCbeA5Eq4WpySaJXG+KG52KoFeTuLVmASqjz1Z13
         Xsxt9MssYEh0EZ08FG8/ufkp+qH7XKrSSWhVv95Au4naltGvbNA42mgLL6U2xFWVNJGb
         ZWEvwadmgYitMv5GLJqEMu1bIeNzUQnYn+Qqrp6z7u3wAzZptpYvvZj3uQ/mAvmDrxbZ
         AQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SUe7g/UHtF1EOgdP835Y+4qnpd3f5ih62fapMUqQVuk=;
        b=m2yBmn5oXoQJBGvZ2fucJ8jy0bqxZYbvzB80tVMiljur4mhxjP2hcS8fz+xC0pwuxJ
         G5iKK5tSa6X/O9qN2hwbKlJqSpIUoMbkkMTsetDcHJmTGpBVpllsL8fHJh4lHpATtlVT
         1BHgJmykvCXiXEZDm7itDzNivA7/ffls6abPYRWsg2vSPhqKvZ/4d3L3Dd2rtxYSG5+q
         RsM5gWC9OFt5DRfGavU3z5VMK7pthX4exLfStN9v/tSUJIZUBYBmk7CnztkV1+r7cq8W
         A5bvRuIvEd1wLdg0e6b9S6V5gjOJChMoRxqTMtSfy1EZMFRG2r+pjb2PV8uxkAV96DTv
         8MWQ==
X-Gm-Message-State: AOAM530+61nIC6rfrnIRs4t7rQ09oZTAjwpmVvmrxA22H0B65uvEjcCI
        UlSSXLDpBxT/D/ToCf2cf0Dc9YXhxFY=
X-Google-Smtp-Source: ABdhPJyfVr2J8EFiYn+vizm/ahp8E7uL0ZAFuavqy+6ZJrnt1qgz/nVv8RIgUS6MWvlyig9xw2e98w==
X-Received: by 2002:a05:6602:340a:: with SMTP id n10mr955928ioz.188.1630552608999;
        Wed, 01 Sep 2021 20:16:48 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id e14sm253265ilr.62.2021.09.01.20.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 20:16:48 -0700 (PDT)
Date:   Wed, 01 Sep 2021 20:16:40 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     Joanne Koong <joannekoong@fb.com>
Message-ID: <61304218227e8_1aed208dd@john-XPS-13-9370.notmuch>
In-Reply-To: <20210831225005.2762202-2-joannekoong@fb.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
Subject: RE: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong wrote:
> Bloom filters are a space-efficient probabilistic data structure
> used to quickly test whether an element exists in a set.
> In a bloom filter, false positives are possible whereas false
> negatives are not.
> 
> This patch adds a bloom filter map for bpf programs.
> The bloom filter map supports peek (determining whether an element
> is present in the map) and push (adding an element to the map)
> operations.These operations are exposed to userspace applications
> through the already existing syscalls in the following way:
> 
> BPF_MAP_LOOKUP_ELEM -> peek
> BPF_MAP_UPDATE_ELEM -> push
> 
> The bloom filter map does not have keys, only values. In light of
> this, the bloom filter map's API matches that of queue stack maps:
> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> APIs to query or add an element to the bloom filter map. When the
> bloom filter map is created, it must be created with a key_size of 0.
> 
> For updates, the user will pass in the element to add to the map
> as the value, wih a NULL key. For lookups, the user will pass in the
> element to query in the map as the value. In the verifier layer, this
> requires us to modify the argument type of a bloom filter's
> BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> the syscall layer, we need to copy over the user value so that in
> bpf_map_peek_elem, we know which specific value to query.
> 
> The maximum number of entries in the bloom filter is not enforced; if
> the user wishes to insert more entries into the bloom filter than they
> specified as the max entries size of the bloom filter, that is permitted
> but the performance of their bloom filter will have a higher false
> positive rate.

hmm I'm wondering if this means the memory footprint can grow without
bounds? Typically maps have an upper bound on memory established at
alloc time.

In queue_stack_map_alloc() we have,

 queue_size = sizeof(*qs) + size * attr->value_size);
 bpf_map_area_alloc(queue_size, numa_node) 

In hashmap (not preallocated)  we have, alloc_htab_elem() that will
give us an upper bound.

Is there a practical value in allowing these to grow endlessly? And
should we be charging the value memory against something? In
bpf_map_kmalloc_node we set_active_memcg() for example.
 
I'll review code as well, but think above is worth some thought.

> 
> The number of hashes to use for the bloom filter is configurable from
> userspace. The benchmarks later in this patchset can help compare the
> performances of different number of hashes on different entry
> sizes. In general, using more hashes decreases the speed of a lookup,
> but increases the false positive rate of an element being detected in the
> bloom filter.
> 
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
