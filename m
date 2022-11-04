Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC661A2ED
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKDVKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDVKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 17:10:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D21342F71;
        Fri,  4 Nov 2022 14:10:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 13so16466561ejn.3;
        Fri, 04 Nov 2022 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/kQYdJhQRckKt4rUibxSFTIQweO2rniyf8K8sfzQjk=;
        b=DM5z3k+iPnZPK+YBRtJPPtKb20BElSUppKh+sMir9PZle00aGZf1GxjtodUL3Ej3sY
         qihJUDUWhmzlju3gP0zViodmMfGWIEYhsxN1NZF2QniK96poSKpj4oB8cX4M/NUFfQje
         r4yzAr3zAcShmbhsHgqawctAAvG+cDvZvhz+REeMQ7CxRGE4qO6kuisz1Gxf7BcfYayC
         WO2TAxFh82r8rbDGgUM/BayB2+WxsRCvFfHy+5820OWCBX3qFBL/phTq44vH6Lap++lu
         24huB/Sdc622j99iHyMk4iQfil4dfhmjRXZt9l/+IuaJiOfiOAzY9ja3/qyMq+1NvUNB
         bcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/kQYdJhQRckKt4rUibxSFTIQweO2rniyf8K8sfzQjk=;
        b=brQeBk6iOh9KdUqN+nilHWWZVfCzB1pmwdRqbGJfKQOFuPoBt2l1oh08otXyyZBa4c
         7zlCkstmLcI5m7M5gx2BryJgoiAmPr0B3YptFM+L6eya34ee5zC6qydj2/wVccJO8Fh1
         eTsTXsV+uiXmHGDcpqzgrKxQeRNHFiaGgNfyOJqPQMq0kRNK+Nw+b49hswBO/vlLywYh
         UvG3FMT8dIFxqwAi/0+iNIm2XrZyXu9cPsyzvVK9ACYY3tpZJbtfXk5DieAcG/BZPUyo
         OH72dqW/7bMYkNPXUXAX3Z8NOXY4GpImO+2y8AjfL86IHdQSzobK4mDSKltqIGNP9tHV
         3HYQ==
X-Gm-Message-State: ACrzQf3xoZnRgIQXnElR7ltCgxPbmQArvdGNS1bTyREZ9pZI2UzMs2zm
        O5ydDoJCGOI2My1x/zEohpqos9RTMgLV8Fa23RU=
X-Google-Smtp-Source: AMsMyM7Go04Xu5XZjzpb2SQMBT4b5LLzG3uR5DHKQLX3P299PePjbF4Tk4K0r46prqF2izEO1cZc54Cw3tzPR6qktxg=
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id
 sc36-20020a1709078a2400b00795bb7d643bmr37125222ejc.115.1667596213954; Fri, 04
 Nov 2022 14:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com> <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
 <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
In-Reply-To: <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 14:10:01 -0700
Message-ID: <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 4:54 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On 10/27/2022 6:54 PM, Andrii Nakryiko wrote:
> > On Wed, Sep 28, 2022 at 1:54 AM Lorenz Bauer <oss@lmb.io> wrote:
> >>
> >> On Thu, 15 Sep 2022, at 11:30, Lorenz Bauer wrote:
> >>> Hi list,
> >>>
> >>> Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF
> >>> map permission loophole", with slides at [0].
> >>
> >> I've put this topic on the agenda of the 2022-10-06 BPF office hours to get some maintainer attention. Details are here: https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit
> >>
> >> Best
> >
> > So after the office hours I had an offline whiteboard discussion with
> > Alexei explaining more precisely what I was proposing, and it became
> > apparent that some of the things I was proposing weren't exactly
> > clear, and thus people were left confused about the solution I was
> > talking about. So I'll try to summarize it a bit and add some more
> > specifics. Hopefully that will help, because I still believe we can
> > solve this problem moving forward.
> >
> > But first, two notes.
> >
> > 1) Backporting this is going to be hard, and I don't think that should
> > be the goal, it's going to be too intrusive, probably.
> >
> > 2) It turned out that we currently don't store user-space-side
> > read/write permissions on struct bpf_map itself, and we'd need to do
> > that as a preliminary step here. Below I just assume that struct
> > bpf_map records all the bpf-side and user-side read/write permissions.
>
> +linux-security-module, Paul, Casey
>
> Thanks Andrii for writing such detailed proposal. It is very clear.
>
> I was thinking about your bpf_map_view abstraction, to record per-fd
> permission. My question would be, isn't the f_mode enough for this
> purpose? I mean, if you want to record the access flags per fd, you
> already have them in f_mode. Apart from map iterators, the eBPF code
> handling the user space side of map access is already capable of
> handling and enforcing based on the f_mode.
>
> So, what remains for us to do is to ensure that a requestor gets
> a fd with modes compatible with what the requestor is allowed to do.
>
> For a moment, I exclude MAC-style controls, as I understood that
> this should not be the only type of enforcement.
>
> Then, maybe we could treat maps like inodes, meaning that we could
> add to bpf_map the following fields:
>
> m_uid
> m_gid
> m_mode
>
> These fields will be populated at map creation time, depending on
> who is requesting it. With similar mechanism as for inodes (umask),
> we can decide the default m_mode (read-write for the owner,
> read-only for the group and others). These fields are relevant only
> for the user space side of map access.
>
> We can add two new commands for bpf():
>
> BPF_MAP_CHOWN
> BPF_MAP_CHMOD
>
> to change the fields above.
>
> I comment below, to see if this alternative proposal works for the
> use cases you described.

didn't we establish that we can't trust fd permissions because we
don't control normal chmod/chown?..

>
> > So, the overall idea is that instead of fetching struct bpf_map point
> > for all kinds of FD-based operations (bpf_obj_get, map_fd_by_id, even
> > bpf_map_create) we are always working with a view of a map, and that
> > "view" is a separate struct/object, something like:
> >
> > struct bpf_map_view {
> >      struct bpf_map *map;
> >      /* BPF_F_RDONLY | BPF_F_WRONLY, but we can later also add
> >         BPF-side flags: BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG
> >      */
> >      int access_flags;
> > }
> >
> > So whenever we work with map by FD, we get struct bpf_map_view (i.e.,
> > we store struct bpf_map_view inside file->private and
> > inode->i_private). The semantics of view->access_flags is that it is
> > superimposed on top of bpf_map->map_flags (specifically its
> > BPF_F_RDONLY | BPF_F_WRONLY parts, later also BPF_F_RDONLY_PROG |
> > BPF_F_WRONLY_PROG). This means that if struct bpf_map is R/W, but our
> > current bpf_map_view says BPF_F_RDONLY, then only read-only access is
> > allowed through that FD. On the other hand, if bpf_map itself is only
> > BPF_F_RDONLY, but we somehow go bpf_map_view with BPF_F_RDONLY |
> > BPF_F_WRONLY (e.g., due to chmod loophole), then it doesn't matter,
> > it's still BPF_F_RDONLY, no write access. We can try preventing such
> > situations in some circumstances, but as we showed with chmod() it's
> > impossible to prevent in general.
> >
> > So, just to hopefully make it a bit clearer, let's discuss a use case
> > that a bunch of people had in mind. Root/CAP_BPF user created R/W
> > bpf_map, but wants to pin it in one BPFFS path as R/W, so that it can
> > be later opened as R/W and modified. This BPFFS path will be
> > restricted through FS permissions to only allow it to be opened by a
> > privileged user/group. But, that same original root/CAP_BPF user would
> > like to also create a read-only BPFFS pinning of that same map, and
> > let unprivileged user(s) to open and work with that map, but only
> > perform read-only operations (e.g., BPF_MAP_LOOKUP_ELEM command).
> >
> > Let's see how that works in this new bpf_map_view model.
> >
> > 1. root/CAP_BPF user does BPF_MAP_CREATE operation, struct bpf_map is
> > created with map_flags BPF_F_RDONLY | BPF_F_WRONLY. Also, immediately
> > struct bpf_map_view is created with same BPF_F_RDONLY | BPF_F_WRONLY
> > access_flags. struct bpf_map_view keeps reference on struct bpf_map,
> > struct bpf_map_view is assigned to struct file->private, new FD is
> > returned to user-space.
>
> Ok, m_uid, m_gid are taken from the current process. m_mode (for the
> owner) could be set from the map creation flags (0, BPF_F_RDONLY,
> BPF_F_WRONLY). The fd the owner receives has f_mode compatible with the
> map creation flags.
>
> > 2. That same root/CAP_BPF user does BPF_OBJ_PIN and specifies that
> > they want R/W pinning (through file_flags). Kernel clones/copies
> > struct bpf_map_view (I think bpf_map_view shouldn't be shared between
> > files/inodes, each file/inode has its own personal copy; but we can
> > work out the details later), sets (keeps in this case) its
> > access_flags as  BPF_F_RDONLY | BPF_F_WRONLY. After that they are free
> > to chown/chmod as necessary to prevent unprivileged user from doing
> > anything with that BPFFS file, if necessary.
>
> I understand that per-pinned map permissions gives a lot of flexibility.
> But maybe, the owner/group/others permissions are sufficient to cover
> most of the use cases. Instead of creating two pinned maps, one
> read-write and one read-only, we just create one and we define the map
> m_mode
> as rw-r--r--.
>
> At the time a requestor wants to get a fd from the pinned map through
> OBJ_GET, the kernel checks from the process UID/GID if it has
> permissions in m_mode.
>
> We can keep the permission check on the inode of the pinned map as an
> additional security control.

wouldn't inode permissions be too inflexible? E.g., if I created a map
and I'm in group1, but I want to give read-only access to group2, but
not to any other group. I can't use other part of permission and
setting group permissions to r is too restrictive (I want users in my
group to be able to open r/w view of the map).

>
> > 3. Now, for the read-only pinning. User does another BPF_OBJ_PIN using
> > original R/W map FD, but now they specify file_flags to only allow
> > BPF_F_RDONLY (I'm too lazy to check what exact flag we pass there to
> > communicate this intent, it's not that important for this discussion).
> > At this point, kernel creates a new struct bpf_map_view, pointing to
> > struct bpf_map, but this time access_flags have only BPF_F_RDONLY set.
> > Then we proceed to creating an inode, its i_private is assigned this
> > new R/O bpf_map_view. The user should chmod/chown pinned BPFFS file
> > appropriately to allow unprivileged users to BPF_OBJ_GET it.
>
> Now that the main access control check is based on m_mode, we might
> think who can pin a map. Only the owner? Maybe we can reuse the
> execute permission in m_mode to determine that.

Why such limitations that only owner should be able to pin? What if
I'm that read-only user and I want to pin it somewhere else as another
read-only pinning (for whatever reason, to share with my own
processes/users).


>
> > Now, let's assume we are unprivileged user who wants to work with that
> > pinned BPF map. When we do BPF_OBJ_GET on that read-only pinned file,
> > kernel fetches struct bpf_map_view from inode->i_private which has
> > access_flags as BPF_F_RDONLY. That's it, there is no way we can do
> > update on that map, kernel will reject that even though struct bpf_map
> > itself allows BPF_F_WRONLY.
>
> This should be clear now.
>
> > Note, though, that once we checked everything, as we create a new
> > struct file and return new FD to user-space, that new struct file will
> > have *yet another copy* of struct bpf_map_view, cloned from inode's
> > bpf_map_view (recall that I was proposing to have 1-to-1 mapping
> > between file/inode and bpf_map_view).
> >
> >
> > Let's now assume we are sneaky bastards and chmod that second pinned
> > BPFFS file to allow r/w file permissions. When we do BPF_OBJ_GET,
> > again, we'll fetch struct bpf_map_view which enforce BPF_F_RDONLY
> > (only), despite file itself having writable permissions. We can argue
> > if we should reject such BPF_OBJ_GET command or silently "downgrade"
> > to read-only view, that's beside the point.
>
> Ok, yes. Permissions on the pinned map are just an additional barrier.
>
> > Hopefully this is a bit clearer.
> >
> > One last note. When we are talking about BPF_OBJ_GET, we are actually
> > going to be dealing with 4 layers of read and write permissions:
> >    1) struct bpf_map's "inherent" permissions
> >    2) struct bpf_map_view's access_flags
> >    3) struct file's FS read/write permissions
> >    4) union bpf_attr's file_flags specified for BPF_OBJ_GET
>
> In my proposal, that would change to:
>
> 1) struct bpf_map m_uid, m_gid, m_mode
> 2) struct file's FS read/write permission (depends on the inode on
>     BPFFS)
> 3) process uid, gid of the requestor
> 4) union bpf_attr's file_flags specified for BPF_OBJ_GET
>
> > While that's a lot, we always intersect them and keep only the most
> > restrictive combination. So if at any of the layers we have read-only
> > permissions, resulting *new struct bpf_map_view* will only specify
> > BPF_F_RDONLY. E.g., if at layers 1, 2, and 4 we allow BPF_F_WRONLY,
> > but BPFFS file permission (layer #3 above) at that moment is
> > read-only, we should be only getting read-only view of BPF map.
>
> Ok, sure. I think more or less the proposals are aligned. If traditional
> access control is sufficient, we could avoid the increased complexity of
> the new bpf_map_view layer.

I think this additional complexity is fundamental to this problem. And
as I mentioned above, relying just on inode permissions doesn't seem
sufficient. But maybe I missed something in your proposal.

>
> > P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
> > BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
> > user will control that. E.g., FS read-only permission, does it
> > restrict both user-space and BPF-view, or just user-space view? We can
> > certainly extend file_flags to allow users to get BPF-side read-only
> > and user-space-side read-write BPF map FD, for example. Obviously, BPF
> > verifier would need to know about struct bpf_map_view when accepting
> > BPF map FD in ldimm64 and such.
>
> I guess, this patch could be used:
>
> https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/
>
> When passing a fd to an eBPF program, the permissions of the user space
> side cannot exceed those defined from eBPF program side.

Don't know, maybe. But I can see how BPF-side can be declared r/w for
BPF programs, while user-space should be restricted to read-only. I'm
a bit hesitant to artificially couple both together.

>
> Thanks
>
> Roberto
>
