Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8421950C37A
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 01:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiDVWtO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 18:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiDVWs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 18:48:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874A39A056
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 15:08:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c12so13710732plr.6
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yz6zxeAM2W6JwA3xHwtSo4rCqra9jDuQkZoypKeIeaA=;
        b=nv5R7pRe5HHdf0+LvvcL+seUaDLn3bMFDNAgmdDvYFzBuuCIYeYNLV3P4bmD5j3EB2
         xCkdaCr4+gMzguTkVeneSDjigI4M4DzYEWQ3Vk4U3M9zSzINft0uyCK4qEZ3pcKkFviw
         fzKHOhelvjXFBrQzzSVYQjO4XEaLt1SISuz+xQJF0vMQkcizy4BgWKtnvZdaL1FNuuMl
         7Afaj2kQxS/9cMR2yjvkkoqRPQrBx73PM2sl70LIOBthkX79kQeSfd77FYBnhN/yIfwp
         OGj0dIDcSTMryvJeu/70s3lJuR8yPRG2IZ/Pma6gpQCRpo70diMfQlKZwydCrlvIfdCg
         5BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yz6zxeAM2W6JwA3xHwtSo4rCqra9jDuQkZoypKeIeaA=;
        b=CEzXOrsoqWGRi9H2RgQi1goX9WxRhzSGsHHTWkI1tsgl91TplwzneKotzIovN3jpbx
         heC8rjYl2HAYeNmVjeQ7NfWfevtCZYiYkODZNz7knyAgEUmOLaXgPgy89Shww4QYt1Lv
         TZItu1J84fr2uasrnyouB+jCqo03TCjcOVlivRSnWq91kDQzPczUahP9PSNBP3mnV3p8
         T0bYjNy9p31Bv96KWzvgpHNsykRuVbs/KUacrxEkiTWsegQtogZYyEz/UZ2TOf6xEcxC
         oqIF7DjuZrKBv5Kv/R2KbU0sTEUaLFvtYvTrcYfcl0AQGMDzAUEKkhLE/NJb5w6OJk3b
         z/aQ==
X-Gm-Message-State: AOAM533kkDSvMe06XXCgPt2cPS3as0D8W4mK+5XXJ/y3TrsKesn3Zh+z
        +QLkm85La4Vb2hC6QDx90DY=
X-Google-Smtp-Source: ABdhPJwzjHKsv3VRG7x5/pSYttJQA9a8o7zjSR3lFzQWTts9m7htd/i/6KMRvdiXJVGsbtQZFgC+eQ==
X-Received: by 2002:a17:902:ecd0:b0:159:572:af3a with SMTP id a16-20020a170902ecd000b001590572af3amr6725180plh.77.1650665273779;
        Fri, 22 Apr 2022 15:07:53 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:500::46a8])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090ab78400b001cd4989fed0sm6986838pjr.28.2022.04.22.15.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:07:53 -0700 (PDT)
Date:   Fri, 22 Apr 2022 15:07:50 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 0/3] Introduce local_storage exclusive caching
Message-ID: <20220422220750.kdyqkhkxyv4yv66f@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220420002143.1096548-1-davemarchevsky@fb.com>
 <20220422014030.opvbgrfvdnxzwfxl@MBP-98dd607d3435.dhcp.thefacebook.com>
 <5d14e267-298b-d4b5-07bf-704a36aa8aa5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d14e267-298b-d4b5-07bf-704a36aa8aa5@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 12:05:23AM -0400, Dave Marchevsky wrote:
> On 4/21/22 9:40 PM, Alexei Starovoitov wrote:   
> > On Tue, Apr 19, 2022 at 05:21:40PM -0700, Dave Marchevsky wrote:
> >> Currently, each local_storage type (sk, inode, task) has a 16-entry
> >> cache for local_storage data associated with a particular map. A
> >> local_storage map is assigned a fixed cache_idx when it is allocated.
> >> When looking in a local_storage for data associated with a map the cache
> >> entry at cache_idx is the only place the map can appear in cache. If the
> >> map's data is not in cache it is placed there after a search through the
> >> cache hlist. When there are >16 local_storage maps allocated for a
> >> local_storage type multiple maps have same cache_idx and thus may knock
> >> each other out of cache.
> >>
> >> BPF programs that use local_storage may require fast and consistent
> >> local storage access. For example, a BPF program using task local
> >> storage to make scheduling decisions would not be able to tolerate a
> >> long hlist search for its local_storage as this would negatively affect
> >> cycles available to applications. Providing a mechanism for such a
> >> program to ensure that its local_storage_data will always be in cache
> >> would ensure fast access.
> >>
> >> This series introduces a BPF_LOCAL_STORAGE_FORCE_CACHE flag that can be
> >> set on sk, inode, and task local_storage maps via map_extras. When a map
> >> with the FORCE_CACHE flag set is allocated it is assigned an 'exclusive'
> >> cache slot that it can't be evicted from until the map is free'd. 
> >>
> >> If there are no slots available to exclusively claim, the allocation
> >> fails. BPF programs are expected to use BPF_LOCAL_STORAGE_FORCE_CACHE
> >> only if their data _must_ be in cache.
> > 
> > I'm afraid new uapi flag doesn't solve this problem.
> > Sooner or later every bpf program would deem itself "important" and
> > performance critical. All of them will be using FORCE_CACHE flag
> > and we will back to the same situation.
> 
> In this scenario, if 16 maps had been loaded w/ FORCE_CACHE flag and 17th tried
> to load, it would fail, so programs depending on the map would fail to load.

Ahh. I missed that the cache_idx is assigned at map creation time.

> Patch 2 adds a selftest 'local_storage_excl_cache_fail' demonstrating this.
> 
> > Also please share the performance data that shows more than 16 programs
> > that use local storage at the same time and existing simple cache
> > replacing logic is not enough.
> > For any kind link list walking to become an issue there gotta be at
> > least 17 progs. Two progs should pick up the same cache_idx and
> > run interleaved to evict each other. 
> > It feels like unlikely scenario, so real data would be good to see.
> > If it really an issue we might need a different caching logic.
> > Like instead of single link list per local storage we might
> > have 16 link lists. cache_idx can point to a slot.
> > If it's not 1st it will be a 2nd in much shorter link list.
> > With 16 slots the link lists will have 2 elements until 32 bpf progs
> > are using local storage.
> > We can get rid of cache too and replace with mini hash table of N
> > elements where map_id would be an index into a hash table.
> > All sorts of other algorithms are possible.
> > In any case the bpf user shouldn't be telling the kernel about
> > "importance" of its program. If program is indeed executing a lot
> > the kernel should be caching/accelerating it where it can.
> 
> It's worth noting that this is a map-level setting, not prog-level. Telling the
> kernel about importance of data feels more palatable to me. Sort of like mmap's
> MAP_LOCKED, but for local_storage cache.

For mmap it's an operational difference. Not just performance.

> Going back to the motivating example - using data in task local_storage to make
> scheduling decisions - the desire is to have the task local_storage access be
> like "accessing a task_struct member" vs "doing a search for right data to 
> access (w/ some caching to try to avoid search)".

Exactly. The motivation is performance. Let's try to make good performance
without uapi flags.
Think from user's pov. They have to pick between FORCE_CACHE == good performance
and no flag == bad? performance.
Why would anyone pick something that has worse performance?
