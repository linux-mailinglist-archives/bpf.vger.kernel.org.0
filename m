Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAB252925B
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiEPUz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 16:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiEPUzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 16:55:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E84579BE
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 13:29:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r27so17270174iot.1
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kR1HNX4w4WKHrCjde2GbCV/sYIm0B+cux3Cg63NO03M=;
        b=ZfHahAsPDYKMoW7WT5hvqkBNdbGtjpRrmOow4j8W4PdQzUdlkrfbfHsUfOfyVbE5/m
         xtwbFL6O7oisuwadA18gDsXlKq/BatMAdIvIQIZA5YDGDIAo9ySCJEyDwVPaCfHCvi3y
         a5QwpbHlPYxZrPwwjZb/IrNRhoS2nMwC03Ab2NcWDmYvdcJw3RkNlcdHIEMuAfWwUp7E
         xoqa65nKODZXt6WLKJB/FQd4olbEDiS4YhZnHIQ4wqPB7wQ0QpXZGVGSBZMhuT1PwCVh
         A3q3lGsxq8hEmAh+nLXOOcwGL2z9VqcR5d6ptI5Vne4BFsf4b+nfrPHvCIxM1Ayh2WD4
         9dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kR1HNX4w4WKHrCjde2GbCV/sYIm0B+cux3Cg63NO03M=;
        b=jDmUkSOen7jeUyElnyTT/1WhbwMjcGDq9Tz1/E07JT0rqtUs2AxLbHMcQ/UK15NaiE
         Mn1XQkO+FQ5UnCqjFNwdJUaK9iJgYcXXsFXDz6AyOcxKCVo3LOYYGc51R8K7p/+njNsb
         P7GcXv4kuOZVGmxH6FdZvIa7ctF1OvuKEtJapAC7tyIrbmr7ZBmGv7QHcfUazybwJQ+8
         1bneZatYjCUk5Kl47H/qYhXgAYSUZvfufLXqWWPQfvNMUC6iudcOhtx/XXeJVH51LrIT
         uYsQt9QZIJIa5UDuzjjCRD23swiWXXkacZAxR6IAYAGsv0Rkx4Zu0OnOkn7yNgJ2Txm2
         yILw==
X-Gm-Message-State: AOAM532jRD7EAFy2rDQw53eXBlMzFWr6OqWD7QeCJsIU7m/CYvu1poyS
        akjTX6/2ZhhQ9lKjXHpqE7CuFcIovai2SbXuCYM=
X-Google-Smtp-Source: ABdhPJxir1HVAuf2hX8leN2Dz0RCM6HgACDxJTcosFiQ0vts3pYe29DlkRgCedWjA8EUSGxKgdZ6FSORHqpf5FdZUxI=
X-Received: by 2002:a6b:c90a:0:b0:65b:48b5:9907 with SMTP id
 z10-20020a6bc90a000000b0065b48b59907mr8987461iof.102.1652732973328; Mon, 16
 May 2022 13:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com> <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
 <CAJnrk1Zs6dVAqwbCQ1VShH+00D_EY7ePjyyhfj5UVO5zwSO7JA@mail.gmail.com>
 <b35e19c7-82ea-27fa-4fd6-50e36e64241c@iogearbox.net> <20220513163951.tg2nrsuwlglpxvu7@MBP-98dd607d3435.dhcp.thefacebook.com>
 <0313e3f4-2e5b-240f-0c45-339f7b23da8b@iogearbox.net> <20220513221621.i7l3fwtqvl3ehjic@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220513221621.i7l3fwtqvl3ehjic@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 16 May 2022 13:29:22 -0700
Message-ID: <CAJnrk1ZRKH8Q1GBAr9+d3B18mAY=s1OvcXsf7J74mYuehTYE0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 3:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 13, 2022 at 09:28:03PM +0200, Daniel Borkmann wrote:
> > On 5/13/22 6:39 PM, Alexei Starovoitov wrote:
> > > On Fri, May 13, 2022 at 03:12:06PM +0200, Daniel Borkmann wrote:
> > > >
> > > > Thinking more about it, is there even any value for BPF_FUNC_dynptr_* for
> > > > fully unpriv BPF if these are rejected anyway by the spectre mitigations
> > > > from verifier?
> > > ...
> > > > So either for alloc, we always built-in __GFP_ZERO or bpf_dynptr_alloc()
> > > > helper usage should go under perfmon_capable() where it's allowed to read
> > > > kernel mem.
> > >
> > > dynptr should probably by cap_bpf and cap_perfmon for now.
> > > Otherwise we will start adding cap_perfmon checks in run-time to helpers
> > > which is not easy to do. Some sort of prog or user context would need
> > > to be passed as hidden arg into helper. That's too much hassle just
> > > to enable dynptr for cap_bpf only.
> > >
> > > Similar problem with gfp_account... remembering memcg and passing all
> > > the way to bpf_dynptr_alloc helper is not easy. And it's not clear
> > > which memcg to use. The one where task was that loaded that bpf prog?
> > > That task could have been gone and cgroup is in dying stage.
> > > bpf prog is executing some context and allocating memory for itself.
> > > Like kernel allocates memory for its needs. It doesn't feel right to
> > > charge prog's memcg in that case. It probably should be an explicit choice
> > > by bpf program author. Maybe in the future we can introduce a fake map
> > > for such accounting needs and bpf prog could pass a map pointer to
> > > bpf_dynptr_alloc. When such fake and empty map is created the memcg
> > > would be recorded the same way we do for existing normal maps.
> > > Then the helper will look like:
> > > bpf_dynptr_alloc(struct bpf_map *map, u32 size, u64 flags, struct bpf_dynptr *ptr)
> > > {
> > >    set_active_memcg(map->memcg);
> > >    kmalloc into dynptr;
> > > }
> > >
> > > Should we do this change now and allow NULL to be passed as a map ?
> >
> > Hm, this looks a bit too much like a hack, I wouldn't do that, fwiw.
> >
> > > This way the bpf prog will have a choice whether to account into memcg or not.
> > > Maybe it's all overkill and none of this needed?
> > >
> > > On the other side maybe map should be a mandatory argument and dynptr_alloc
> > > can do its own memory accounting for stats ? atomic inc and dec is probably
> > > an acceptable overhead? bpftool will print the dynptr allocation stats.
> > > All sounds nice and extra visibility is great, but the kernel code that
> > > allocates for the kernel doesn't use memcg. bpf progs semantically are part of
> > > the kernel whereas memcg is a mechanism to restrict memory that kernel
> > > allocated on behalf of user tasks. We abused memcg for bpf progs/maps
> > > to have a limit. Not clear whether we should continue doing so for dynpr_alloc
> > > and in the future for kptr_alloc. gfp_account adds overhead too. It's not free.
> > > Thoughts?
> >
> > Great question, I think the memcg is useful, just that the ownership for bpf
> > progs/maps has been relying on current whereas current is not a real 'owner',
> > just the entity which did the loading.
> >
> > Maybe we need some sort of memcg object for bpf where we can "bind" the prog
> > and map to it at load time, which is then different from current and can be
> > flexibly set, e.g. fd = open(/sys/fs/cgroup/memory/<foo>) and pass that fd to
> > BPF_PROG_LOAD and BPF_MAP_CREATE via bpf_attr (otherwise, if not set, then
> > no accounting)?
>
> Agree. Explicitly specifying memcg by FD would be nice.
> It will be useful for normal maps and progs.
> This is a bit orthogonal to having a map argument to bpf_dynptr/kptr_alloc.
>
> Here is the main reason why we probably should have it mandatory:
> kmalloc cannot be called from nmi and in general cannot be called from tracing.
> kprobe/fentry could be inside slab or page alloc path and it might blow up.
> That's the reason why hashmap defaults to pre-alloc.
> In order to do pre-alloc in bpf_dynptr/kptr_alloc() it has to have a map-like
> argument that will keep the info about preallocated memory.
>
> How about the following api:
> mem = bpf_map_create(BPF_MAP_TYPE_MEMORY); // form user space
> bpf_mem_prealloc(mem, size); // preallocate memory. from sleepable or irqwork
> bpf_dynptr_alloc(mem, size, flags, &dynptr); // non-sleepable
> // returns 'size' bytes if they were available in preallocated memory
>
> Right now bpf maps are either full prealloc or full kmalloc.
> This approach will be a hybrid.
> The bpf progs will be using it roughly like this:
>
> // init from user space
> mem = bpf_map_create(BPF_MAP_TYPE_MEMORY);
> sys_bpf(mem_prealloc, 1Mbyte); // prealloc largest possible single dynptr_alloc
>
> // from bpf prog
> bpf_dynptr_alloc(mem, size, flags, &dynptr); // if (size < 1M) all good
> bpf_irq_work_queue(replenish_prealloc, size); // refill mem's prealloc
>
> void replenish_prealloc(sz) { bpf_mem_prealloc(mem, sz); }
>
> bpf_dynptr_alloc would need to implement a memory allocator out of
> reserved memory. We can probably reuse some of sl[oua]b code.
> slob_alloc may fit the best (without dynamic slob_new_pages).
> Song's pack_alloc probably good enough to start.
>
> The gfp_account flag moves into bpf_mem_prealloc() helper.
> It doesn't make sense in bpf_dynptr_alloc.
> While gfp_zero makes sense only in bpf_dynptr_alloc.
>
> Thoughts?

Do you envision this also being used for accounting for kfunc memory
allocations?
