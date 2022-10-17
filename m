Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73E3601B37
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJQVXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJQVXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 17:23:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5778B2871B
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 14:23:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b79so10071327iof.5
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5fwuPQMgQUhGGx0rmdgHT+W1hXD/l5jonkySw7zoQNk=;
        b=ogg+jU7dWQB5JOFRw+qLmZYU0F+Q5BbX6L/C4gTlcvyWj2qG5I2KOX5jaiQu6Gxo18
         DvretwwCw4qHv/MIEzldNMsFAjM1QZZE1qfY/fmGUsI32dKn8ZqUW7aUig2xo9YLACCN
         Mwb5Mr6PkI+gsOwcPKLK9KZILFyO+HO3sDCc9zl7JvFtDubX1r04iXByY7bEOsz6GqVq
         RnpaZ4D/1cKNdcbgTQCVHLHU+ThIaVSgKYt3cKt1lS88ve+9sY9xb8fjS45ti9tTajor
         6YNrr/zngBi0lsQ/wOHCwzmsVAx/SClqIMgjw3eFi4pIHMxI5Cj8j1vmfZSvD1EdOidd
         nOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fwuPQMgQUhGGx0rmdgHT+W1hXD/l5jonkySw7zoQNk=;
        b=HCrtCQ7DzrKmgsgUXGNXuHF44ztP2beUspjXtT4COBBlADX3d1QUhIHFu2zYIJrhys
         s5YnR3QvM+oudc5n9lRVSqw6jULjjWc/BnXsfwRnHyRcVxm0F4SpBeaAsFvW0VQQkW+z
         dEhwUU7CmLD5FOUJhsbIaMHCtpSMapQiTEtr8kj2BLOPFUtVBIRRgMxcDOJtvutfmM+n
         +mCgzvsI6nx01VzNlpWR5bya8P+429p6S1Rh+IHNOJrayWryThc4hkuwpZaHOlocNtqn
         6TPgrO9mIfU6VF4AnskEb0L3vnTJSgPhFZ52i/6C483Kyrnbi2mEYl5Wq+numPol7sDk
         NbNA==
X-Gm-Message-State: ACrzQf3beJydRt8DI9YucXz6KQo4bYDl7wUxGvv2mWZoGPtubWxr8M6L
        PEml1+W3yCCAJzTAhAo6CBDqVf/ArQbh7X0uuqVWHg==
X-Google-Smtp-Source: AMsMyM5hifi7yGuPEdo7EFXbukiQTtiaUbMLht8uEBj0EnqbRJtCID3EW57EHJnkx89yGdpS1qCTp/5m53lQ3mVKKIk=
X-Received: by 2002:a05:6602:1551:b0:6bc:dfba:33f9 with SMTP id
 h17-20020a056602155100b006bcdfba33f9mr5539433iow.76.1666041828523; Mon, 17
 Oct 2022 14:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221014045619.3309899-1-yhs@fb.com> <20221014045630.3311951-1-yhs@fb.com>
 <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com> <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev>
In-Reply-To: <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Oct 2022 14:23:12 -0700
Message-ID: <CAJD7tkZb65=T-Rffa91sVRvkTeEy1N7jdDfQy=f5oF+2u-ijHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
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

On Mon, Oct 17, 2022 at 2:07 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/17/22 12:11 PM, Yosry Ahmed wrote:
> > On Mon, Oct 17, 2022 at 12:07 PM Stanislav Fomichev <sdf@google.com> wrote:
> >>
> >> On Mon, Oct 17, 2022 at 11:47 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>>
> >>> On Mon, Oct 17, 2022 at 11:43 AM Stanislav Fomichev <sdf@google.com> wrote:
> >>>>
> >>>> On Mon, Oct 17, 2022 at 11:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>>>>
> >>>>> On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
> >>>>>>
> >>>>>> On 10/13, Yonghong Song wrote:
> >>>>>>> Similar to sk/inode/task storage, implement similar cgroup local storage.
> >>>>>>
> >>>>>>> There already exists a local storage implementation for cgroup-attached
> >>>>>>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> >>>>>>> bpf_get_local_storage(). But there are use cases such that non-cgroup
> >>>>>>> attached bpf progs wants to access cgroup local storage data. For example,
> >>>>>>> tc egress prog has access to sk and cgroup. It is possible to use
> >>>>>>> sk local storage to emulate cgroup local storage by storing data in
> >>>>>>> socket.
> >>>>>>> But this is a waste as it could be lots of sockets belonging to a
> >>>>>>> particular
> >>>>>>> cgroup. Alternatively, a separate map can be created with cgroup id as
> >>>>>>> the key.
> >>>>>>> But this will introduce additional overhead to manipulate the new map.
> >>>>>>> A cgroup local storage, similar to existing sk/inode/task storage,
> >>>>>>> should help for this use case.
> >>>>>>
> >>>>>>> The life-cycle of storage is managed with the life-cycle of the
> >>>>>>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> >>>>>>> with a callback to the bpf_cgroup_storage_free when cgroup itself
> >>>>>>> is deleted.
> >>>>>>
> >>>>>>> The userspace map operations can be done by using a cgroup fd as a key
> >>>>>>> passed to the lookup, update and delete operations.
> >>>>>>
> >>>>>>
> >>>>>> [..]
> >>>>>>
> >>>>>>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
> >>>>>>> local
> >>>>>>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
> >>>>>>> used
> >>>>>>> for cgroup storage available to non-cgroup-attached bpf programs. The two
> >>>>>>> helpers are named as bpf_cgroup_local_storage_get() and
> >>>>>>> bpf_cgroup_local_storage_delete().
> >>>>>>
> >>>>>> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
> >>>>>> cgroup storages shared between programs on the same cgroup") where
> >>>>>> the map changes its behavior depending on the key size (see key_size checks
> >>>>>> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
> >>>>>> can be used so we can, in theory, reuse the name..
> >>>>>>
> >>>>>> Pros:
> >>>>>> - no need for a new map name
> >>>>>>
> >>>>>> Cons:
> >>>>>> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
> >>>>>>     good idea to add more stuff to it?
> >>>>>>
> >>>>>> But, for the very least, should we also extend
> >>>>>> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
> >>>>>> tried to keep some of the important details in there..
> >>>>>
> >>>>> This might be a long shot, but is it possible to switch completely to
> >>>>> this new generic cgroup storage, and for programs that attach to
> >>>>> cgroups we can still do lookups/allocations during attachment like we
> >>>>> do today? IOW, maintain the current API for cgroup progs but switch it
> >>>>> to use this new map type instead.
> >>>>>
> >>>>> It feels like this map type is more generic and can be a superset of
> >>>>> the existing cgroup storage, but I feel like I am missing something.
> >>>>
> >>>> I feel like the biggest issue is that the existing
> >>>> bpf_get_local_storage helper is guaranteed to always return non-null
> >>>> and the verifier doesn't require the programs to do null checks on it;
> >>>> the new helper might return NULL making all existing programs fail the
> >>>> verifier.
> >>>
> >>> What I meant is, keep the old bpf_get_local_storage helper only for
> >>> cgroup-attached programs like we have today, and add a new generic
> >>> bpf_cgroup_local_storage_get() helper.
> >>>
> >>> For cgroup-attached programs, make sure a cgroup storage entry is
> >>> allocated and hooked to the helper on program attach time, to keep
> >>> today's behavior constant.
> >>>
> >>> For other programs, the bpf_cgroup_local_storage_get() will do the
> >>> normal lookup and allocate if necessary.
> >>>
> >>> Does this make any sense to you?
> >>
> >> But then you also need to somehow mark these to make sure it's not
> >> possible to delete them as long as the program is loaded/attached? Not
> >> saying it's impossible, but it's a bit of a departure from the
> >> existing common local storage framework used by inode/task; not sure
> >> whether we want to pull all this complexity in there? But we can
> >> definitely try if there is a wider agreement..
> >
> > I agree that it's not ideal, but it feels like we are comparing two
> > non-ideal options anyway, I am just throwing ideas around :)
>
> I don't think it is a good idea to marry the new
> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE and the existing BPF_MAP_TYPE_CGROUP_STORAGE
> in any way.  The API is very different.  A few have already been mentioned here.
>   Delete is one.  Storage creation time is another one.  The map key is also
> different.  Yes, maybe we can reuse the different key size concept in
> bpf_cgroup_storage_key in some way but still feel too much unnecessary quirks
> for the existing sk/inode/task storage users to remember.
>
> imo, it is better to keep them separate and have a different map-type.  Adding a
> map flag or using map extra will make it sounds like an extension which it is not.

I was actually proposing considering the existing cgroup storage as an
extension to the new cgroup local storage. Basically the new cgroup
local storage is a generic cgroup-indexed map, and for cgroup-attached
programs they get some nice extensions, such as preallocation (create
local storage on attachment) and fast lookups (stash a pointer to the
attached cgroup storage for direct access). There are, of course, some
quirks, but it felt to me like something that is easier to reason
about, and less code to maintain.

For the helpers, we can maintain the existing one and generalize it
(get the local storage for my cgroup), and add a new one that we pass
the cgroup into (as in this patch).

My idea is not to have a different flag or key size, but just
basically rework the existing cgroup storage as an extension to the
new one for cgroup-attached programs.

Anyway, like I said I was just throwing ideas around, you have a lot
more background here than me :)

>
> >>
> >>>> There might be something else I don't remember at this point (besides
> >>>> that weird per-prog_type that we'd have to emulate as well)..
> >>>
> >>> Yeah there are things that will need to be emulated, but I feel like
> >>> we may end up with less confusing code (and less code in general).
>
>
