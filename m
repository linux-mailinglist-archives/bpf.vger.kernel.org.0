Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DFD601C2B
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 00:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJQWQo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 18:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQWQn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 18:16:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E736086
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 15:16:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k11-20020aa792cb000000b00558674e8e7fso6711692pfa.6
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=apMnGZaDOE2WYT+mqSw+7teanXZjzru67qu3ydmDbNo=;
        b=UJmPTCSJuh+Fw6rWfBSMmobH/5sctcCCEwCCjN2WvESPL2d8mC8+8rxMoz+GGaaW40
         6Lx8nyoTSzrk6oprpZtZ49lUWebFt1RA+1LknB1Eok+L5vfuu1O3aFLS74bwPDCH4hbw
         dfdI01QrnVWmB/4ek1lPnPoXmRuCIcFyqRzb1qMjiCFCI58Zfu5+EAC3VxSCq1XYoLGY
         uxbXOJvswJMWO8ANC6qhWgGdVETDtaKqmGSBUYmFJGxuYOu5ZKix9Gd80Iy4H8IwR58i
         /5LaKplRnqJVnyyi4BlL3vDs/LisCJR8l1SFXSl/J8iRbmsJYxylAB0n6rKRC5FjPbGc
         +Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apMnGZaDOE2WYT+mqSw+7teanXZjzru67qu3ydmDbNo=;
        b=mGE5CGGNvNDXDnzWP+4yDiuy68LnYshFOGBhD76lVHPKuddDzXB1Xtp0xPaj0lnwJg
         HwpaKwqHmqqCb6pxYafyWAdzQnO8Q0GTvsJ3Dd18yF+DsXwfgQSGM4e1pMXTWcNVvxoB
         k3HSFvErDtPV4fToPtURkIviRO1FVtEFJcS/rPGPvegymVU15FtJEYZWHLMcyf4RmodY
         5tuhwsWnSTa1ZRkAAgUPeK6FDhccvN6bc5G5Ljd+c0OBlNqyy0yr6CZoIvUiUmCoAjXO
         CthhrsMXuWrq1+0T03BHgL3Z6rtDvwHJz/XFkZX4PAc8z7tUqaWovpQJQT/CE9om4EAz
         /9rQ==
X-Gm-Message-State: ACrzQf3D5r2MFUyFY782dqgNgsC6iEPJfJ4am77nnJ5Fycxuw2ckcvSr
        UHvGvgHRrVoD9n5d6byaJwMeS2w=
X-Google-Smtp-Source: AMsMyM5gt3sCdW0V47kJUtS+yUOTkGmujreZLaV1UqHSXnpRpUiCDCGDoN/1+CTPsszmRRZpMT/wgzo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:b794:b0:20a:eab5:cf39 with SMTP id
 m20-20020a17090ab79400b0020aeab5cf39mr1508440pjr.1.1666045001836; Mon, 17 Oct
 2022 15:16:41 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:16:40 -0700
In-Reply-To: <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev>
Mime-Version: 1.0
References: <20221014045619.3309899-1-yhs@fb.com> <20221014045630.3311951-1-yhs@fb.com>
 <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com> <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev>
Message-ID: <Y03USAeiBL5Ol22E@google.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
From:   sdf@google.com
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/17, Martin KaFai Lau wrote:
> On 10/17/22 12:11 PM, Yosry Ahmed wrote:
> > On Mon, Oct 17, 2022 at 12:07 PM Stanislav Fomichev <sdf@google.com>  
> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 11:47 AM Yosry Ahmed <yosryahmed@google.com>  
> wrote:
> > > >
> > > > On Mon, Oct 17, 2022 at 11:43 AM Stanislav Fomichev  
> <sdf@google.com> wrote:
> > > > >
> > > > > On Mon, Oct 17, 2022 at 11:26 AM Yosry Ahmed  
> <yosryahmed@google.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
> > > > > > >
> > > > > > > On 10/13, Yonghong Song wrote:
> > > > > > > > Similar to sk/inode/task storage, implement similar cgroup  
> local storage.
> > > > > > >
> > > > > > > > There already exists a local storage implementation for  
> cgroup-attached
> > > > > > > > bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and  
> helper
> > > > > > > > bpf_get_local_storage(). But there are use cases such that  
> non-cgroup
> > > > > > > > attached bpf progs wants to access cgroup local storage  
> data. For example,
> > > > > > > > tc egress prog has access to sk and cgroup. It is possible  
> to use
> > > > > > > > sk local storage to emulate cgroup local storage by storing  
> data in
> > > > > > > > socket.
> > > > > > > > But this is a waste as it could be lots of sockets  
> belonging to a
> > > > > > > > particular
> > > > > > > > cgroup. Alternatively, a separate map can be created with  
> cgroup id as
> > > > > > > > the key.
> > > > > > > > But this will introduce additional overhead to manipulate  
> the new map.
> > > > > > > > A cgroup local storage, similar to existing sk/inode/task  
> storage,
> > > > > > > > should help for this use case.
> > > > > > >
> > > > > > > > The life-cycle of storage is managed with the life-cycle of  
> the
> > > > > > > > cgroup struct.  i.e. the storage is destroyed along with  
> the owning cgroup
> > > > > > > > with a callback to the bpf_cgroup_storage_free when cgroup  
> itself
> > > > > > > > is deleted.
> > > > > > >
> > > > > > > > The userspace map operations can be done by using a cgroup  
> fd as a key
> > > > > > > > passed to the lookup, update and delete operations.
> > > > > > >
> > > > > > >
> > > > > > > [..]
> > > > > > >
> > > > > > > > Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used  
> for old cgroup
> > > > > > > > local
> > > > > > > > storage support, the new map name  
> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
> > > > > > > > used
> > > > > > > > for cgroup storage available to non-cgroup-attached bpf  
> programs. The two
> > > > > > > > helpers are named as bpf_cgroup_local_storage_get() and
> > > > > > > > bpf_cgroup_local_storage_delete().
> > > > > > >
> > > > > > > Have you considered doing something similar to 7d9c3427894f  
> ("bpf: Make
> > > > > > > cgroup storages shared between programs on the same cgroup")  
> where
> > > > > > > the map changes its behavior depending on the key size (see  
> key_size checks
> > > > > > > in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd  
> still
> > > > > > > can be used so we can, in theory, reuse the name..
> > > > > > >
> > > > > > > Pros:
> > > > > > > - no need for a new map name
> > > > > > >
> > > > > > > Cons:
> > > > > > > - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy;  
> might be not a
> > > > > > >     good idea to add more stuff to it?
> > > > > > >
> > > > > > > But, for the very least, should we also extend
> > > > > > > Documentation/bpf/map_cgroup_storage.rst to cover the new  
> map? We've
> > > > > > > tried to keep some of the important details in there..
> > > > > >
> > > > > > This might be a long shot, but is it possible to switch  
> completely to
> > > > > > this new generic cgroup storage, and for programs that attach to
> > > > > > cgroups we can still do lookups/allocations during attachment  
> like we
> > > > > > do today? IOW, maintain the current API for cgroup progs but  
> switch it
> > > > > > to use this new map type instead.
> > > > > >
> > > > > > It feels like this map type is more generic and can be a  
> superset of
> > > > > > the existing cgroup storage, but I feel like I am missing  
> something.
> > > > >
> > > > > I feel like the biggest issue is that the existing
> > > > > bpf_get_local_storage helper is guaranteed to always return  
> non-null
> > > > > and the verifier doesn't require the programs to do null checks  
> on it;
> > > > > the new helper might return NULL making all existing programs  
> fail the
> > > > > verifier.
> > > >
> > > > What I meant is, keep the old bpf_get_local_storage helper only for
> > > > cgroup-attached programs like we have today, and add a new generic
> > > > bpf_cgroup_local_storage_get() helper.
> > > >
> > > > For cgroup-attached programs, make sure a cgroup storage entry is
> > > > allocated and hooked to the helper on program attach time, to keep
> > > > today's behavior constant.
> > > >
> > > > For other programs, the bpf_cgroup_local_storage_get() will do the
> > > > normal lookup and allocate if necessary.
> > > >
> > > > Does this make any sense to you?
> > >
> > > But then you also need to somehow mark these to make sure it's not
> > > possible to delete them as long as the program is loaded/attached? Not
> > > saying it's impossible, but it's a bit of a departure from the
> > > existing common local storage framework used by inode/task; not sure
> > > whether we want to pull all this complexity in there? But we can
> > > definitely try if there is a wider agreement..
> >
> > I agree that it's not ideal, but it feels like we are comparing two
> > non-ideal options anyway, I am just throwing ideas around :)

> I don't think it is a good idea to marry the new
> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE and the existing
> BPF_MAP_TYPE_CGROUP_STORAGE in any way.  The API is very different.  A few
> have already been mentioned here.  Delete is one.  Storage creation time  
> is
> another one.  The map key is also different.  Yes, maybe we can reuse the
> different key size concept in bpf_cgroup_storage_key in some way but still
> feel too much unnecessary quirks for the existing sk/inode/task storage
> users to remember.

> imo, it is better to keep them separate and have a different map-type.
> Adding a map flag or using map extra will make it sounds like an extension
> which it is not.

This part is the most confusing to me:

BPF_MAP_TYPE_CGROUP_STORAGE       bpf_get_local_storage
BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE bpf_cgroup_local_storage_get

The new helpers should probably drop 'local' name to match the task/inode  
([0])?
And we're left with:

BPF_MAP_TYPE_CGROUP_STORAGE       bpf_get_local_storage
BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE bpf_cgroup_storage_get

You read CGROUP_STORAGE via get_local_storage and
you read CGROUP_LOCAL_STORAGE via cgroup_storage_get :-/

That's why I'm slightly tilting towards reusing the name. At least we can
add a big DEPRECATED message for bpf_get_local_storage and that seems to be
it? All those extra key sizes can also be deprecated, but I'm honestly
not sure if anybody is using them.

But having a separate map also seems fine, as long as we have a patch to
update the existing header documentation. (and mention in
Documentation/bpf/map_cgroup_storage.rst that there is a replacement?)
Current bpf_get_local_storage description is too vague; let's at least
mention that it works only with BPF_MAP_TYPE_CGROUP_STORAGE.

0:  
https://lore.kernel.org/bpf/6ce7d490-f015-531f-3dbb-b6f7717f0590@meta.com/T/#mb2107250caa19a8d9ec3549a52f4a9698be99e33

> > >
> > > > > There might be something else I don't remember at this point  
> (besides
> > > > > that weird per-prog_type that we'd have to emulate as well)..
> > > >
> > > > Yeah there are things that will need to be emulated, but I feel like
> > > > we may end up with less confusing code (and less code in general).


