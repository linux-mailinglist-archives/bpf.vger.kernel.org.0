Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C30601FD0
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 02:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJRAsi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 20:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJRAsh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 20:48:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9731A835
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 17:48:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y80so10568582iof.3
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1QXG27kNJUDd25GH+DBolqpD3o2h5cuqtIowd8+jj4=;
        b=RxAobzhmTOXuMz3c2E7W1ENQFM5i/qkZ/j+r724YA2nWmdIG/w3O4581I3hIiH/UNZ
         s+Bl6xjGN79rAN8XNpV6/xHPuMHFoVz4jn/hnoVt87ExTkbOFtAUICrqoz1agHHcM1ca
         3Jc5eqD6vgaR5PVUBKNNNuqRU/H09RUsEOxqlrbnqdiCjX/YKSA23qRg2+mAAKyQxtG7
         +Kgu4tLh6mUXVx/mQF51NOxdQV4VyLaI/nmX1wnKwGqxxKKsXunvjhxetOuNRUTFzsqE
         39urtXyF6qrrhSK9KlPtkPdJcxRqEeiS/QIVpzeDhNLlfc3e8KkfUKPp2sIHHRsquF+Q
         2uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1QXG27kNJUDd25GH+DBolqpD3o2h5cuqtIowd8+jj4=;
        b=L+CGw+XDvvgv/vvunHFuZukRSLL6FpRFsptOtgzdbJYQKuvaHTH5W9sCNwKmusRIEY
         i2QCcV5jhKhIMFBC9AAIF0V4nW4tefe7Wmay5K34eV4zNv66T3RiVaagJPbhlDVKrPKQ
         seQPH+2fLAiw+mW72sscAlvKTxER6X6SZAjA5GkRlPMmTUHzTCByyPf5KIhEB8FnwXKQ
         faiByagORfJ1DoRJ0PaDvrR9ZypDeeoSCMa+qgjMwIOnJfrobU2ppaWMv5VhzAnJh/CA
         l+++QK/Tl1uqocUlNq9O+GCD4CjI3QOP1E6HHCpg3dj03zZ5rA0RHDCgNzazvPeqPYm4
         wfwg==
X-Gm-Message-State: ACrzQf3eV5FICD7nEKfnJeROaum5QXFCt9mK+M2JqY6iwz0uYKP4Nj/r
        W0K4QPJBLyrpardR1SBkIGQ8suHEKu0jBpMZG4ntkU5XTC0=
X-Google-Smtp-Source: AMsMyM5J3UdPNEaPDvs6JodkggEleV8Vj4XBZbOVzo/f71ukFWoNIv4sF1iBadK7QEgn1KkJx0GCrqGf9HHfrrKrtU0=
X-Received: by 2002:a02:900a:0:b0:35a:84e4:39aa with SMTP id
 w10-20020a02900a000000b0035a84e439aamr564215jaf.191.1666054113885; Mon, 17
 Oct 2022 17:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221014045619.3309899-1-yhs@fb.com> <20221014045630.3311951-1-yhs@fb.com>
 <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
 <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev> <CAJD7tkZb65=T-Rffa91sVRvkTeEy1N7jdDfQy=f5oF+2u-ijHg@mail.gmail.com>
 <e210d926-4925-c83f-317f-1bf70d630b9e@linux.dev>
In-Reply-To: <e210d926-4925-c83f-317f-1bf70d630b9e@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Oct 2022 17:47:56 -0700
Message-ID: <CAJD7tka+3uRfqbsyHfSgRPcGa5vnBpwQT683v+FQw7Y1Mwn2TA@mail.gmail.com>
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

On Mon, Oct 17, 2022 at 4:55 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/17/22 2:23 PM, Yosry Ahmed wrote:
> > On Mon, Oct 17, 2022 at 2:07 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 10/17/22 12:11 PM, Yosry Ahmed wrote:
> >>> On Mon, Oct 17, 2022 at 12:07 PM Stanislav Fomichev <sdf@google.com> wrote:
> >>>>
> >>>> On Mon, Oct 17, 2022 at 11:47 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>>>>
> >>>>> On Mon, Oct 17, 2022 at 11:43 AM Stanislav Fomichev <sdf@google.com> wrote:
> >>>>>>
> >>>>>> On Mon, Oct 17, 2022 at 11:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>>>>>>
> >>>>>>> On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
> >>>>>>>>
> >>>>>>>> On 10/13, Yonghong Song wrote:
> >>>>>>>>> Similar to sk/inode/task storage, implement similar cgroup local storage.
> >>>>>>>>
> >>>>>>>>> There already exists a local storage implementation for cgroup-attached
> >>>>>>>>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> >>>>>>>>> bpf_get_local_storage(). But there are use cases such that non-cgroup
> >>>>>>>>> attached bpf progs wants to access cgroup local storage data. For example,
> >>>>>>>>> tc egress prog has access to sk and cgroup. It is possible to use
> >>>>>>>>> sk local storage to emulate cgroup local storage by storing data in
> >>>>>>>>> socket.
> >>>>>>>>> But this is a waste as it could be lots of sockets belonging to a
> >>>>>>>>> particular
> >>>>>>>>> cgroup. Alternatively, a separate map can be created with cgroup id as
> >>>>>>>>> the key.
> >>>>>>>>> But this will introduce additional overhead to manipulate the new map.
> >>>>>>>>> A cgroup local storage, similar to existing sk/inode/task storage,
> >>>>>>>>> should help for this use case.
> >>>>>>>>
> >>>>>>>>> The life-cycle of storage is managed with the life-cycle of the
> >>>>>>>>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> >>>>>>>>> with a callback to the bpf_cgroup_storage_free when cgroup itself
> >>>>>>>>> is deleted.
> >>>>>>>>
> >>>>>>>>> The userspace map operations can be done by using a cgroup fd as a key
> >>>>>>>>> passed to the lookup, update and delete operations.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> [..]
> >>>>>>>>
> >>>>>>>>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
> >>>>>>>>> local
> >>>>>>>>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
> >>>>>>>>> used
> >>>>>>>>> for cgroup storage available to non-cgroup-attached bpf programs. The two
> >>>>>>>>> helpers are named as bpf_cgroup_local_storage_get() and
> >>>>>>>>> bpf_cgroup_local_storage_delete().
> >>>>>>>>
> >>>>>>>> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
> >>>>>>>> cgroup storages shared between programs on the same cgroup") where
> >>>>>>>> the map changes its behavior depending on the key size (see key_size checks
> >>>>>>>> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
> >>>>>>>> can be used so we can, in theory, reuse the name..
> >>>>>>>>
> >>>>>>>> Pros:
> >>>>>>>> - no need for a new map name
> >>>>>>>>
> >>>>>>>> Cons:
> >>>>>>>> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
> >>>>>>>>      good idea to add more stuff to it?
> >>>>>>>>
> >>>>>>>> But, for the very least, should we also extend
> >>>>>>>> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
> >>>>>>>> tried to keep some of the important details in there..
> >>>>>>>
> >>>>>>> This might be a long shot, but is it possible to switch completely to
> >>>>>>> this new generic cgroup storage, and for programs that attach to
> >>>>>>> cgroups we can still do lookups/allocations during attachment like we
> >>>>>>> do today? IOW, maintain the current API for cgroup progs but switch it
> >>>>>>> to use this new map type instead.
> >>>>>>>
> >>>>>>> It feels like this map type is more generic and can be a superset of
> >>>>>>> the existing cgroup storage, but I feel like I am missing something.
> >>>>>>
> >>>>>> I feel like the biggest issue is that the existing
> >>>>>> bpf_get_local_storage helper is guaranteed to always return non-null
> >>>>>> and the verifier doesn't require the programs to do null checks on it;
> >>>>>> the new helper might return NULL making all existing programs fail the
> >>>>>> verifier.
> >>>>>
> >>>>> What I meant is, keep the old bpf_get_local_storage helper only for
> >>>>> cgroup-attached programs like we have today, and add a new generic
> >>>>> bpf_cgroup_local_storage_get() helper.
> >>>>>
> >>>>> For cgroup-attached programs, make sure a cgroup storage entry is
> >>>>> allocated and hooked to the helper on program attach time, to keep
> >>>>> today's behavior constant.
> >>>>>
> >>>>> For other programs, the bpf_cgroup_local_storage_get() will do the
> >>>>> normal lookup and allocate if necessary.
> >>>>>
> >>>>> Does this make any sense to you?
> >>>>
> >>>> But then you also need to somehow mark these to make sure it's not
> >>>> possible to delete them as long as the program is loaded/attached? Not
> >>>> saying it's impossible, but it's a bit of a departure from the
> >>>> existing common local storage framework used by inode/task; not sure
> >>>> whether we want to pull all this complexity in there? But we can
> >>>> definitely try if there is a wider agreement..
> >>>
> >>> I agree that it's not ideal, but it feels like we are comparing two
> >>> non-ideal options anyway, I am just throwing ideas around :)
> >>
> >> I don't think it is a good idea to marry the new
> >> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE and the existing BPF_MAP_TYPE_CGROUP_STORAGE
> >> in any way.  The API is very different.  A few have already been mentioned here.
> >>    Delete is one.  Storage creation time is another one.  The map key is also
> >> different.  Yes, maybe we can reuse the different key size concept in
> >> bpf_cgroup_storage_key in some way but still feel too much unnecessary quirks
> >> for the existing sk/inode/task storage users to remember.
> >>
> >> imo, it is better to keep them separate and have a different map-type.  Adding a
> >> map flag or using map extra will make it sounds like an extension which it is not.
> >
> > I was actually proposing considering the existing cgroup storage as an
> > extension to the new cgroup local storage. Basically the new cgroup
> > local storage is a generic cgroup-indexed map, and for cgroup-attached
> > programs they get some nice extensions, such as preallocation (create
> > local storage on attachment) and fast lookups (stash a pointer to the
> > attached cgroup storage for direct access). There are, of course, some
> > quirks, but it felt to me like something that is easier to reason
> > about, and less code to maintain
> Like extending the new BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE implementation and add
> codes to make it work like the existing BPF_MAP_TYPE_CGROUP_STORAGE such that
> those existing code can go away?
>
> hmm.....  A quick thought is it probably does not worth it for the code removal
> purpose alone.  If all use cases can be satisfied by the
> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE, retiring the existing one eventually may be a
> cleaner answer instead of re-factoring it.
>
> Pre-allocation could be useful.  The user space can do it by using
> bpf_map_update_elem syscall with the new BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE
> before attaching the program.
>
> For fast-lookup/stash pointer, yes, the current limitation on a bpf prog can use
> only one BPF_MAP_TYPE_CGROUP_STORAGE makes this easier.  However, afaik, the
> existing bpf_get_local_storage() is also doing
> current->bpf_ctx->prog_item->cgroup_storage. It is not clear to me which one may
> be faster though.  Need a micro benchmark to tell.
>
> Also, there are quite many code in local_storage.c.  Not sure all of them makes
> sense for the new BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE to support. eg.
> ".map_get_next_key = cgroup_storage_get_next_key".  The new
> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE does not support iteration from the user space
> because it has bpf_iter that supports iteration by a bpf prog which can directly
> get to the kernel ptr (task/sk/...) instead of a fd.
>
> In the future, we will add feature to bpf_local_storage.c that will work for all
> kernel objects whenever possible. eg. Adding map-in-map in the
> sk/inode/task/cgroup local storage, and store a ring-buf map to the sk (eg)
> storage.  The inner map may not always make sense to be created during the
> cgroup-attach time and it will be another exception to make for the
> alloc-during-cgroup-attach behavior.
>
> >
> > For the helpers, we can maintain the existing one and generalize it
> > (get the local storage for my cgroup), and add a new one that we pass
> > the cgroup into (as in this patch).
> >
> > My idea is not to have a different flag or key size, but just
> > basically rework the existing cgroup storage as an extension to the
> > new one for cgroup-attached programs.
>

I see what you mean, thanks for clarifying your thoughts. I think
retiring the old cgroup storage at some point if all its use cases
become covered by the new cgroup local storage. Meanwhile, we will
need clear docs in the code and for users to draw a clear distinction
between both map types.

>
>
