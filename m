Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66E50C8C6
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiDWJra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Apr 2022 05:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiDWJr3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Apr 2022 05:47:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B3C112DB1
        for <bpf@vger.kernel.org>; Sat, 23 Apr 2022 02:44:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s14so16060131plk.8
        for <bpf@vger.kernel.org>; Sat, 23 Apr 2022 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BV9blMV4R8cJX3abt+ekbQL+Vsgy61siY1mixK1/R9Y=;
        b=HuFznirt8BBSclV7AHYki8dh56+XgAu/RyR4ROY0JX+S1xuyl9NI02S2FK63G9Jh1a
         bmW6PI30jsQt2cWOFOXTj6vfISJ6U8Xbrs8vLzQt0ZVbZW4WAKePArnhLFUKcKsawSZl
         d/tyKxGCzrGqI3pQ/xUtkMuOs46lyOJ0imH+pX/qZ6GTtr59uHrkHkNkJYGOiRY5oZYM
         DJEmhqGH7MEI+HUlXMakp7+yPv4kqoBdKNaoXjsSkqMDd6ZtwUos6Zq/kFPRRWW6M+WD
         wdQxzHdMbB/1NEtdbi2PqmHOQYKv2f32LNTWaq962NM7zeQUhGIaE7Cab/jGxGrrMKSQ
         suFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BV9blMV4R8cJX3abt+ekbQL+Vsgy61siY1mixK1/R9Y=;
        b=OhHDM9qXklpW+Rs2Ee7Wr87o7p+zHd7ywkvFnES6lhwaeH5W8pV3cKI+a8rWVJ34nx
         O4fxxOwbUqnKpDykoDCBNcgOP37QekMhv8yX/bZGEdJN4AqHTBePhAOZy2JU4Kx4+kV/
         3Gt1IH1hZPLT2OfbzK9eBKNyREzqvY5t9AAFqB3RK7u19Rdbl9xq7WRaO0Au07cqAprm
         1tpHv6i5hxAltMoqzINooUTMm6Ltgabc45I9ABAg7S2oAlSf9farjx5Ts3utDeQIwyxa
         B4xw32aJyJ+OXC2dFLXyEA6SHvZloMhqKWUgCOQ97W3joYMsjnKlnN57R2dn0siK9hde
         PzPg==
X-Gm-Message-State: AOAM532QA6YrSewRP8ZAXNJAm3ZKTeZ8yT23qsjmjXXBEOXW01MD3itH
        O8uZpbdQqbrs7CDaCgsjB4uJu3Gs1va0UwtUneh/fX1IU10=
X-Google-Smtp-Source: ABdhPJyd7jsgQHNivBsrpkNQe9pJILpyXqhf5yvGC7g0w8AL77to32kgiPtrGfaIbFtYhV5NYRp+NTNUwxAnOfy0Sa8=
X-Received: by 2002:a17:903:1051:b0:15c:f02f:cd0e with SMTP id
 f17-20020a170903105100b0015cf02fcd0emr773402plc.81.1650707072203; Sat, 23 Apr
 2022 02:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220420002143.1096548-1-davemarchevsky@fb.com> <20220422014030.opvbgrfvdnxzwfxl@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220422014030.opvbgrfvdnxzwfxl@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 23 Apr 2022 02:43:56 -0700
Message-ID: <CAJD7tkZRwOd4v2A8Q__czxJEWyG-==9F_ZMhScXoY+6PQ6S5-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce local_storage exclusive caching
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 6:47 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 19, 2022 at 05:21:40PM -0700, Dave Marchevsky wrote:
> > Currently, each local_storage type (sk, inode, task) has a 16-entry
> > cache for local_storage data associated with a particular map. A
> > local_storage map is assigned a fixed cache_idx when it is allocated.
> > When looking in a local_storage for data associated with a map the cache
> > entry at cache_idx is the only place the map can appear in cache. If the
> > map's data is not in cache it is placed there after a search through the
> > cache hlist. When there are >16 local_storage maps allocated for a
> > local_storage type multiple maps have same cache_idx and thus may knock
> > each other out of cache.
> >
> > BPF programs that use local_storage may require fast and consistent
> > local storage access. For example, a BPF program using task local
> > storage to make scheduling decisions would not be able to tolerate a
> > long hlist search for its local_storage as this would negatively affect
> > cycles available to applications. Providing a mechanism for such a
> > program to ensure that its local_storage_data will always be in cache
> > would ensure fast access.
> >
> > This series introduces a BPF_LOCAL_STORAGE_FORCE_CACHE flag that can be
> > set on sk, inode, and task local_storage maps via map_extras. When a map
> > with the FORCE_CACHE flag set is allocated it is assigned an 'exclusive'
> > cache slot that it can't be evicted from until the map is free'd.
> >
> > If there are no slots available to exclusively claim, the allocation
> > fails. BPF programs are expected to use BPF_LOCAL_STORAGE_FORCE_CACHE
> > only if their data _must_ be in cache.
>
> I'm afraid new uapi flag doesn't solve this problem.
> Sooner or later every bpf program would deem itself "important" and
> performance critical. All of them will be using FORCE_CACHE flag
> and we will back to the same situation.
>
> Also please share the performance data that shows more than 16 programs
> that use local storage at the same time and existing simple cache
> replacing logic is not enough.
> For any kind link list walking to become an issue there gotta be at
> least 17 progs. Two progs should pick up the same cache_idx and
> run interleaved to evict each other.
> It feels like unlikely scenario, so real data would be good to see.
> If it really an issue we might need a different caching logic.
> Like instead of single link list per local storage we might
> have 16 link lists. cache_idx can point to a slot.
> If it's not 1st it will be a 2nd in much shorter link list.
> With 16 slots the link lists will have 2 elements until 32 bpf progs
> are using local storage.
> We can get rid of cache too and replace with mini hash table of N
> elements where map_id would be an index into a hash table.

This is a tangent to this discussion, but I was actually wondering why
the elements in bpf_local_storage are stored in a list rather than a
hashtable. Is there a specific reason for this?

> All sorts of other algorithms are possible.
> In any case the bpf user shouldn't be telling the kernel about
> "importance" of its program. If program is indeed executing a lot
> the kernel should be caching/accelerating it where it can.
