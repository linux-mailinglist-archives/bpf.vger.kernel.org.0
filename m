Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BED3AFD3A
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 08:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFVGuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 02:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVGuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 02:50:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3BAC061574
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 23:47:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bj15so35107553qkb.11
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 23:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTKM4qoQg9/vgZS1rNuUq2Ud8owEiPe9dkrNJzP3toI=;
        b=bP+ZVIDJNV5S5lw1ybFcjumJJRIU5uyMVGbHvdgoSJ2m8HfNiYiGcCZ3ffHYLru1zD
         Gm+Xwz5GFkENQEq0Rs52kXJ9E4GQVHbB26xZwUI3YLrzHbv/0/tO9+296+6R/tQXfaxV
         v2pIF05aGmfIdBTrx77TM69/Ny3Xw/DykigTs9umyRgJ6sZ/p+7aGTlIza91OTZ4pzQh
         aNuust97mI2WEanS84yYHKxDzOLVPSC7laK1cVOjd0xuX8aKsks6HlTv8MSYZ1rOV7wf
         hGGwIOAO5Q35lQy7YpReHeTNRvRWmsVZg5uAlNwILpDzovXS30W7NUPrOr+YhMD9o+OQ
         1QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTKM4qoQg9/vgZS1rNuUq2Ud8owEiPe9dkrNJzP3toI=;
        b=ZMDMlMqmPQbu+7kEskT0Y7XfHMqgC2M7yjgoqEPtaTiNn4V0t4f4mMJwdTg8E+x0L8
         JM75wnsmjofblb7l5rQMWVdvYXMlUekWs/vYg6nA0gQjC+JIh7eK2NCj4irdFiNOHFhl
         LH1rSqSuaXrqo7BJCVZVFWxbNnhz+/m6eZ/xpLxAA5FfEp5gulRTu1Va64XfHg9RPF73
         mwC+BE2O9zkkzoCDPI3FsmwiIMET1zlxOOiGp1/wEE5mwXtKkmxeRjscZ9T1RmBepMEg
         CuLvKDcSp/2OKuJIVnkueNwKEYaUK/XlpS60RUJFmDWCxfoZjqNWxBPRamYSMaAm5bct
         YhlQ==
X-Gm-Message-State: AOAM530KiWdguMLRlROUV7kjO48mOq4ZHzYwZKU2UJ4iIu66g9TD4ATa
        G6RMZbCnnR+wVOdCzmHFBSNudi8B89+0qmjZZOg=
X-Google-Smtp-Source: ABdhPJyxqt0sZGBduXUHnO8AuMCeBbj9lULmeSntbcnKSdoiBTGg24dhkNhJ0KbARCax7/KszaqD6xIEsNMYjIr5tDs=
X-Received: by 2002:a25:660a:: with SMTP id a10mr2792013ybc.178.1624344468397;
 Mon, 21 Jun 2021 23:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHb-xau6SrWN0eU1XB=jjvae3YxnAK0VsU08R0bH4bbRqo4aBA@mail.gmail.com>
 <8e3a8a21-f973-a809-d005-bcde3546e32c@fb.com>
In-Reply-To: <8e3a8a21-f973-a809-d005-bcde3546e32c@fb.com>
From:   rainkin <rainkin1993@gmail.com>
Date:   Tue, 22 Jun 2021 14:47:12 +0800
Message-ID: <CAHb-xav98Hy7=aGZsaU67Vw19OnGV8fsnzD+Xp6FJkGUtmmuZA@mail.gmail.com>
Subject: Re: Create inner maps dynamically from ebpf kernel prog program
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
>
>
> On 6/21/21 6:12 AM, rainkin wrote:
> > Hi,
> >
> > My ebpf program is attched to kprobe/vfs_read, my use case is to store
> > information of each file (i.e., inode) of each process by using
> > map-in-map (e.g., outer map is a hash map where key is pid, value is a
> > inner map where key is inode, value is some stateful information I
> > want to store.
> > Thus I need to create a new inner map for a new coming inode.
> >
> > I know there exists local storage for task/inode, however, limited to
> > my kernel version (4.1x), those local storage cannot be used.
> >
> > I tried two methods:
> > 1. dynamically create a new inner in user-land ebpf program by
> > following this tutorial:
> > https://github.com/torvalds/linux/blob/master/samples/bpf/test_map_in_map_user.c
> > Then insert the new inner map into the outer map.
> > The limitation of this method:
> > It requires ebpf kernel program send a message to user-land program to
> > create a newly inner map.
> > And ebpf kernel programs might access the map before user-land program
> > finishes the job.
> >
> > 2. Thus, i prefer the second method: dynamically create inner maps in
> > the kernel ebpf program.
> > According to the discussion in the following thread, it seems that it
> > can be done by calling bpf_map_update_elem():
> > https://lore.kernel.org/bpf/878sdlpv92.fsf@toke.dk/T/#e9bac624324ffd3efb0c9f600426306e3a40ec
> > 7b5
> >> Creating a new map for map_in_map from bpf prog can be implemented.
> >> bpf_map_update_elem() is doing memory allocation for map elements. In such a case calling
> >> this helper on map_in_map can, in theory, create a new inner map and insert it into the outer map.
> >
> > However, when I call method to create a new inner, it return the error:
> > 64: (bf) r2 = r10
> > 65: (07) r2 += -144
> > 66: (bf) r3 = r10
> > 67: (07) r3 += -176
> > ; bpf_map_update_elem(&outer, &ino, &new_inner, BPF_ANY);
> > 68: (18) r1 = 0xffff8dfb7399e400
> > 70: (b7) r4 = 0
> > 71: (85) call bpf_map_update_elem#2
> > cannot pass map_type 13 into func bpf_map_update_elem#2
>
> This is expected based on current verifier implementation.
> In verifier check_map_func_compatibility() function, we have
>
>          case BPF_MAP_TYPE_ARRAY_OF_MAPS:
>          case BPF_MAP_TYPE_HASH_OF_MAPS:
>                  if (func_id != BPF_FUNC_map_lookup_elem)
>                          goto error;
>                  break;
>
> For array/hash map-in-map, the only supported helper
> is bpf_map_lookup_elem(). bpf_map_update_elem()
> is not supported yet.

Thanks for your answer!
If I understand correctly, the conclusion is that (at least for now)
*ebpf kernel program*
CAN only do lookup for array/hash map-in-map, and CANNOT do
add/update/delete for array/hash
map-in-map, and CANNOT create reguar hash/array maps dynamically.


>
> For your method #1, the bpf helper bpf_send_signal() or
> bpf_send_signal_thread() might help to send some info
> to user space, but I think they are not available in
> 4.x kernels.
>
> Maybe a single map with key (pid, inode) may work?
>
> >
> > new_inner is a structure of inner hashmap.
> >
> > Any suggestions?
> > Thanks,
> > Rainkin
> >

a single map with key (pid, inode) is ok for the above scenario, however,
when I want to cleanup all entries realted to a certain pid when a
process exits,
a single map is NOT ok. I need to go through all the keys of the
single map and delete keys related
to the certain pid.
