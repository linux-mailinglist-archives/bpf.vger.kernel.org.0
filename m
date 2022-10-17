Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062160193E
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJQUTG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJQUTA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 16:19:00 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F2618B22
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:18:58 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i9so6432672ilv.9
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ST2+vDal2gnq4x27KTMsboXyRRTH2DRhj3ktZQASLxQ=;
        b=Fi+x8aTjD9xnB/RTiopvbUB/Olf9pmk73dnUVC44i2v9YJc4w4SqQwHY2Wj0kNjfvA
         gu4V1KsHuzUJiKzFSmZM7hx4YKdDr0eHZ0nYwAaiShmKpEG+bXI80ZT8LzsZYHWXmvX4
         s/sIMLUkf6QOKyxWHEWfHrsJlTosY/wQmguCEWiojqa2Ra4xIk6PxRDu2eoxLKsPJk74
         ueUUZMSJWyOrCyBNhj7wHGOWmoBtdI2B2IME7bdV6Aln0s4owoliaBreTNN1kioTMDIh
         ioCJAWX/FOUTyesR1WlrJ1e+USt0Vrzv2ksnhA6GPjLamr34jrOQpG76LOC0ZaIA/2Vt
         uBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ST2+vDal2gnq4x27KTMsboXyRRTH2DRhj3ktZQASLxQ=;
        b=jKnk+QKzypkZKf3YCkssCspX9xou3TSfNMIwwa89R9O2FF+wMKSWeXNCQZKZ2sdMhJ
         XatGNDbCk1cU6+pcJLU4al2EihOEGrqQo1c9ocfaz0UObta9wmux9pk+KuoFdYXAgLQE
         cM2QrJMeLXqr8cx6R60Ml+zy4ZG4dBsncpeWG3cRRDeuocHQ5oQMys1ifrJ/QI705Sms
         tYR3MiBo7Zw84IHRMY1R9olhu4uU1fxD5Y90gYJ4zQ4kLRJEsVesCq95ISc32Ewa0lGv
         2RmCl20PgcWRtrYvJutxJ819ylpzmVQ7hQUK6xoLGqAwO3n+1VOsjyhV+axlRD1CuB1F
         SxlA==
X-Gm-Message-State: ACrzQf0l5C1fKDmFe3vvNUhDrdzhHoL2ncm1Jm2nIFdMEIvny8gcnl2Y
        PSaaZXY6V7MwQC857JyRM1SSycrnMyD8t+XvrDXGGA==
X-Google-Smtp-Source: AMsMyM7HAS8Tr/zNZIDVkFKaR906ceqb67owFCuE1DdFqRtIa0ClijEmEBhK9yeeZ1iyKZfK4WuQOgDCEy7HNJ9QXUw=
X-Received: by 2002:a05:6e02:bef:b0:2f9:889b:6db6 with SMTP id
 d15-20020a056e020bef00b002f9889b6db6mr5806296ilu.281.1666037936668; Mon, 17
 Oct 2022 13:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221014045619.3309899-1-yhs@fb.com> <20221014045630.3311951-1-yhs@fb.com>
 <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com> <8f345eb7-f385-1ccd-1ea4-34bfbd2498f5@meta.com>
In-Reply-To: <8f345eb7-f385-1ccd-1ea4-34bfbd2498f5@meta.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Oct 2022 13:18:20 -0700
Message-ID: <CAJD7tkaeRE9w8CxoXAuu6m2nUQXk_BPy2OmjfwyVWe6MiZEwXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
To:     Yonghong Song <yhs@meta.com>
Cc:     Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>,
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

On Mon, Oct 17, 2022 at 1:15 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 10/17/22 11:47 AM, Yosry Ahmed wrote:
> > On Mon, Oct 17, 2022 at 11:43 AM Stanislav Fomichev <sdf@google.com> wrote:
> >>
> >> On Mon, Oct 17, 2022 at 11:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>>
> >>> On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
> >>>>
> >>>> On 10/13, Yonghong Song wrote:
> >>>>> Similar to sk/inode/task storage, implement similar cgroup local storage.
> >>>>
> >>>>> There already exists a local storage implementation for cgroup-attached
> >>>>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> >>>>> bpf_get_local_storage(). But there are use cases such that non-cgroup
> >>>>> attached bpf progs wants to access cgroup local storage data. For example,
> >>>>> tc egress prog has access to sk and cgroup. It is possible to use
> >>>>> sk local storage to emulate cgroup local storage by storing data in
> >>>>> socket.
> >>>>> But this is a waste as it could be lots of sockets belonging to a
> >>>>> particular
> >>>>> cgroup. Alternatively, a separate map can be created with cgroup id as
> >>>>> the key.
> >>>>> But this will introduce additional overhead to manipulate the new map.
> >>>>> A cgroup local storage, similar to existing sk/inode/task storage,
> >>>>> should help for this use case.
> >>>>
> >>>>> The life-cycle of storage is managed with the life-cycle of the
> >>>>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> >>>>> with a callback to the bpf_cgroup_storage_free when cgroup itself
> >>>>> is deleted.
> >>>>
> >>>>> The userspace map operations can be done by using a cgroup fd as a key
> >>>>> passed to the lookup, update and delete operations.
> >>>>
> >>>>
> >>>> [..]
> >>>>
> >>>>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
> >>>>> local
> >>>>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
> >>>>> used
> >>>>> for cgroup storage available to non-cgroup-attached bpf programs. The two
> >>>>> helpers are named as bpf_cgroup_local_storage_get() and
> >>>>> bpf_cgroup_local_storage_delete().
> >>>>
> >>>> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
> >>>> cgroup storages shared between programs on the same cgroup") where
> >>>> the map changes its behavior depending on the key size (see key_size checks
> >>>> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
> >>>> can be used so we can, in theory, reuse the name..
> >>>>
> >>>> Pros:
> >>>> - no need for a new map name
> >>>>
> >>>> Cons:
> >>>> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
> >>>>     good idea to add more stuff to it?
> >>>>
> >>>> But, for the very least, should we also extend
> >>>> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
> >>>> tried to keep some of the important details in there..
> >>>
> >>> This might be a long shot, but is it possible to switch completely to
> >>> this new generic cgroup storage, and for programs that attach to
> >>> cgroups we can still do lookups/allocations during attachment like we
> >>> do today? IOW, maintain the current API for cgroup progs but switch it
> >>> to use this new map type instead.
> >>>
> >>> It feels like this map type is more generic and can be a superset of
> >>> the existing cgroup storage, but I feel like I am missing something.
> >>
> >> I feel like the biggest issue is that the existing
> >> bpf_get_local_storage helper is guaranteed to always return non-null
> >> and the verifier doesn't require the programs to do null checks on it;
> >> the new helper might return NULL making all existing programs fail the
> >> verifier.
> >
> > What I meant is, keep the old bpf_get_local_storage helper only for
> > cgroup-attached programs like we have today, and add a new generic
> > bpf_cgroup_local_storage_get() helper.
> >
> > For cgroup-attached programs, make sure a cgroup storage entry is
> > allocated and hooked to the helper on program attach time, to keep
> > today's behavior constant.
> >
> > For other programs, the bpf_cgroup_local_storage_get() will do the
> > normal lookup and allocate if necessary.
> >
> > Does this make any sense to you?
>
> Right. This is what I plan to do. The map will add a flag to
> distinguish the old and new behavior.
>

This might not make any sense, but is this doable without a flag?
Basically extend the new map type so that it has some special
behaviors for cgroup attached programs (allocate memory on program
attach, bpf_get_local_storage() automatically gets entry for the
attached cgroup, etc).

> >
> >>
> >> There might be something else I don't remember at this point (besides
> >> that weird per-prog_type that we'd have to emulate as well)..
> >
> > Yeah there are things that will need to be emulated, but I feel like
> > we may end up with less confusing code (and less code in general).
> >
> >>
> >>>>
> >>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>>>> ---
> >>>>>    include/linux/bpf.h             |   3 +
> >>>>>    include/linux/bpf_types.h       |   1 +
> >>>>>    include/linux/cgroup-defs.h     |   4 +
> >>>>>    include/uapi/linux/bpf.h        |  39 +++++
> >>>>>    kernel/bpf/Makefile             |   2 +-
> >>>>>    kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
> >>>>>    kernel/bpf/helpers.c            |   6 +
> >>>>>    kernel/bpf/syscall.c            |   3 +-
> >>>>>    kernel/bpf/verifier.c           |  14 +-
> >>>>>    kernel/cgroup/cgroup.c          |   4 +
> >>>>>    kernel/trace/bpf_trace.c        |   4 +
> >>>>>    scripts/bpf_doc.py              |   2 +
> >>>>>    tools/include/uapi/linux/bpf.h  |  39 +++++
> >>>>>    13 files changed, 398 insertions(+), 3 deletions(-)
> >>>>>    create mode 100644 kernel/bpf/bpf_cgroup_storage.c
> [...]
