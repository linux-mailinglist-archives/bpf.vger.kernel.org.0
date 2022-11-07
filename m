Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2F61F297
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 13:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiKGMMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 07:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGMML (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 07:12:11 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594BB3E;
        Mon,  7 Nov 2022 04:12:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4N5VLv3YLwz9xFmk;
        Mon,  7 Nov 2022 20:06:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHe_f49WhjOq5FAA--.42S2;
        Mon, 07 Nov 2022 13:11:47 +0100 (CET)
Message-ID: <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Mon, 07 Nov 2022 13:11:29 +0100
In-Reply-To: <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
         <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
         <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
         <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBHe_f49WhjOq5FAA--.42S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJr4kXr18Jw45ZFykWr45Jrb_yoW8GF4rAo
        WfWwn7ta1xKr1rAF4DK3s8AFy3W34rury8JrZIqr15JFyFq3yjvw47Cw1xXayavF10kr4k
        ZaykAa4Yvry3Ja4fn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4EjugABsn
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-11-04 at 14:10 -0700, Andrii Nakryiko wrote:
> On Mon, Oct 31, 2022 at 4:54 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On 10/27/2022 6:54 PM, Andrii Nakryiko wrote:
> > > On Wed, Sep 28, 2022 at 1:54 AM Lorenz Bauer <oss@lmb.io> wrote:
> > > > On Thu, 15 Sep 2022, at 11:30, Lorenz Bauer wrote:
> > > > > Hi list,
> > > > > 
> > > > > Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF
> > > > > map permission loophole", with slides at [0].
> > > > 
> > > > I've put this topic on the agenda of the 2022-10-06 BPF office hours to get some maintainer attention. Details are here: https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit
> > > > 
> > > > Best
> > > 
> > > So after the office hours I had an offline whiteboard discussion with
> > > Alexei explaining more precisely what I was proposing, and it became
> > > apparent that some of the things I was proposing weren't exactly
> > > clear, and thus people were left confused about the solution I was
> > > talking about. So I'll try to summarize it a bit and add some more
> > > specifics. Hopefully that will help, because I still believe we can
> > > solve this problem moving forward.
> > > 
> > > But first, two notes.
> > > 
> > > 1) Backporting this is going to be hard, and I don't think that should
> > > be the goal, it's going to be too intrusive, probably.
> > > 
> > > 2) It turned out that we currently don't store user-space-side
> > > read/write permissions on struct bpf_map itself, and we'd need to do
> > > that as a preliminary step here. Below I just assume that struct
> > > bpf_map records all the bpf-side and user-side read/write permissions.
> > 
> > +linux-security-module, Paul, Casey
> > 
> > Thanks Andrii for writing such detailed proposal. It is very clear.
> > 
> > I was thinking about your bpf_map_view abstraction, to record per-fd
> > permission. My question would be, isn't the f_mode enough for this
> > purpose? I mean, if you want to record the access flags per fd, you
> > already have them in f_mode. Apart from map iterators, the eBPF code
> > handling the user space side of map access is already capable of
> > handling and enforcing based on the f_mode.
> > 
> > So, what remains for us to do is to ensure that a requestor gets
> > a fd with modes compatible with what the requestor is allowed to do.
> > 
> > For a moment, I exclude MAC-style controls, as I understood that
> > this should not be the only type of enforcement.
> > 
> > Then, maybe we could treat maps like inodes, meaning that we could
> > add to bpf_map the following fields:
> > 
> > m_uid
> > m_gid
> > m_mode
> > 
> > These fields will be populated at map creation time, depending on
> > who is requesting it. With similar mechanism as for inodes (umask),
> > we can decide the default m_mode (read-write for the owner,
> > read-only for the group and others). These fields are relevant only
> > for the user space side of map access.
> > 
> > We can add two new commands for bpf():
> > 
> > BPF_MAP_CHOWN
> > BPF_MAP_CHMOD
> > 
> > to change the fields above.
> > 
> > I comment below, to see if this alternative proposal works for the
> > use cases you described.
> 
> didn't we establish that we can't trust fd permissions because we
> don't control normal chmod/chown?..

Maybe this part is not clear to me.

We are getting a fd with:


	return anon_inode_getfd("bpf-map", &bpf_map_fops, map,
				flags | O_CLOEXEC);


from bpf_map_new_fd(). This applies for both MAP_GET_FD_BY_ID and
OBJ_GET operations.

Before this, we have the MAC-style access control. We could add DAC-
style there too.

So, once the fd is obtained, there would be a problem if we could
change the flags FMODE_CAN_READ/FMODE_CAN_WRITE without mediation,
right? Would it be possible?

> > > So, the overall idea is that instead of fetching struct bpf_map point
> > > for all kinds of FD-based operations (bpf_obj_get, map_fd_by_id, even
> > > bpf_map_create) we are always working with a view of a map, and that
> > > "view" is a separate struct/object, something like:
> > > 
> > > struct bpf_map_view {
> > >      struct bpf_map *map;
> > >      /* BPF_F_RDONLY | BPF_F_WRONLY, but we can later also add
> > >         BPF-side flags: BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG
> > >      */
> > >      int access_flags;
> > > }
> > > 
> > > So whenever we work with map by FD, we get struct bpf_map_view (i.e.,
> > > we store struct bpf_map_view inside file->private and
> > > inode->i_private). The semantics of view->access_flags is that it is
> > > superimposed on top of bpf_map->map_flags (specifically its
> > > BPF_F_RDONLY | BPF_F_WRONLY parts, later also BPF_F_RDONLY_PROG |
> > > BPF_F_WRONLY_PROG). This means that if struct bpf_map is R/W, but our
> > > current bpf_map_view says BPF_F_RDONLY, then only read-only access is
> > > allowed through that FD. On the other hand, if bpf_map itself is only
> > > BPF_F_RDONLY, but we somehow go bpf_map_view with BPF_F_RDONLY |
> > > BPF_F_WRONLY (e.g., due to chmod loophole), then it doesn't matter,
> > > it's still BPF_F_RDONLY, no write access. We can try preventing such
> > > situations in some circumstances, but as we showed with chmod() it's
> > > impossible to prevent in general.
> > > 
> > > So, just to hopefully make it a bit clearer, let's discuss a use case
> > > that a bunch of people had in mind. Root/CAP_BPF user created R/W
> > > bpf_map, but wants to pin it in one BPFFS path as R/W, so that it can
> > > be later opened as R/W and modified. This BPFFS path will be
> > > restricted through FS permissions to only allow it to be opened by a
> > > privileged user/group. But, that same original root/CAP_BPF user would
> > > like to also create a read-only BPFFS pinning of that same map, and
> > > let unprivileged user(s) to open and work with that map, but only
> > > perform read-only operations (e.g., BPF_MAP_LOOKUP_ELEM command).
> > > 
> > > Let's see how that works in this new bpf_map_view model.
> > > 
> > > 1. root/CAP_BPF user does BPF_MAP_CREATE operation, struct bpf_map is
> > > created with map_flags BPF_F_RDONLY | BPF_F_WRONLY. Also, immediately
> > > struct bpf_map_view is created with same BPF_F_RDONLY | BPF_F_WRONLY
> > > access_flags. struct bpf_map_view keeps reference on struct bpf_map,
> > > struct bpf_map_view is assigned to struct file->private, new FD is
> > > returned to user-space.
> > 
> > Ok, m_uid, m_gid are taken from the current process. m_mode (for the
> > owner) could be set from the map creation flags (0, BPF_F_RDONLY,
> > BPF_F_WRONLY). The fd the owner receives has f_mode compatible with the
> > map creation flags.
> > 
> > > 2. That same root/CAP_BPF user does BPF_OBJ_PIN and specifies that
> > > they want R/W pinning (through file_flags). Kernel clones/copies
> > > struct bpf_map_view (I think bpf_map_view shouldn't be shared between
> > > files/inodes, each file/inode has its own personal copy; but we can
> > > work out the details later), sets (keeps in this case) its
> > > access_flags as  BPF_F_RDONLY | BPF_F_WRONLY. After that they are free
> > > to chown/chmod as necessary to prevent unprivileged user from doing
> > > anything with that BPFFS file, if necessary.
> > 
> > I understand that per-pinned map permissions gives a lot of flexibility.
> > But maybe, the owner/group/others permissions are sufficient to cover
> > most of the use cases. Instead of creating two pinned maps, one
> > read-write and one read-only, we just create one and we define the map
> > m_mode
> > as rw-r--r--.
> > 
> > At the time a requestor wants to get a fd from the pinned map through
> > OBJ_GET, the kernel checks from the process UID/GID if it has
> > permissions in m_mode.
> > 
> > We can keep the permission check on the inode of the pinned map as an
> > additional security control.
> 
> wouldn't inode permissions be too inflexible? E.g., if I created a map
> and I'm in group1, but I want to give read-only access to group2, but
> not to any other group. I can't use other part of permission and
> setting group permissions to r is too restrictive (I want users in my
> group to be able to open r/w view of the map).

Ok, I guess we would need ACLs then. Maybe in addition to simple POSIX
permissions.

> > > 3. Now, for the read-only pinning. User does another BPF_OBJ_PIN using
> > > original R/W map FD, but now they specify file_flags to only allow
> > > BPF_F_RDONLY (I'm too lazy to check what exact flag we pass there to
> > > communicate this intent, it's not that important for this discussion).
> > > At this point, kernel creates a new struct bpf_map_view, pointing to
> > > struct bpf_map, but this time access_flags have only BPF_F_RDONLY set.
> > > Then we proceed to creating an inode, its i_private is assigned this
> > > new R/O bpf_map_view. The user should chmod/chown pinned BPFFS file
> > > appropriately to allow unprivileged users to BPF_OBJ_GET it.
> > 
> > Now that the main access control check is based on m_mode, we might
> > think who can pin a map. Only the owner? Maybe we can reuse the
> > execute permission in m_mode to determine that.
> 
> Why such limitations that only owner should be able to pin? What if
> I'm that read-only user and I want to pin it somewhere else as another
> read-only pinning (for whatever reason, to share with my own
> processes/users).

It was easier to determine the initial permissions/owner of the pinned
map. You get it directly from m_mode/m_uid/m_gid.

If another subject does the pinning, the initial permissions could be
different (only the permissions granted to that subject).

Regarding the use case you mentioned, sharing a read-only pinning with
your processes/users, it could be achieved with simple POSIX
permissions/ACLs. It would not matter if a read-only/read-write fd was
used, because the permissions are checked anyway.

The only impact I see in pinning, from the security point of view, is
increasing the visibility of the map, which may have impact for
confidentiality policies.

> > > Now, let's assume we are unprivileged user who wants to work with that
> > > pinned BPF map. When we do BPF_OBJ_GET on that read-only pinned file,
> > > kernel fetches struct bpf_map_view from inode->i_private which has
> > > access_flags as BPF_F_RDONLY. That's it, there is no way we can do
> > > update on that map, kernel will reject that even though struct bpf_map
> > > itself allows BPF_F_WRONLY.
> > 
> > This should be clear now.
> > 
> > > Note, though, that once we checked everything, as we create a new
> > > struct file and return new FD to user-space, that new struct file will
> > > have *yet another copy* of struct bpf_map_view, cloned from inode's
> > > bpf_map_view (recall that I was proposing to have 1-to-1 mapping
> > > between file/inode and bpf_map_view).
> > > 
> > > 
> > > Let's now assume we are sneaky bastards and chmod that second pinned
> > > BPFFS file to allow r/w file permissions. When we do BPF_OBJ_GET,
> > > again, we'll fetch struct bpf_map_view which enforce BPF_F_RDONLY
> > > (only), despite file itself having writable permissions. We can argue
> > > if we should reject such BPF_OBJ_GET command or silently "downgrade"
> > > to read-only view, that's beside the point.
> > 
> > Ok, yes. Permissions on the pinned map are just an additional barrier.
> > 
> > > Hopefully this is a bit clearer.
> > > 
> > > One last note. When we are talking about BPF_OBJ_GET, we are actually
> > > going to be dealing with 4 layers of read and write permissions:
> > >    1) struct bpf_map's "inherent" permissions
> > >    2) struct bpf_map_view's access_flags
> > >    3) struct file's FS read/write permissions
> > >    4) union bpf_attr's file_flags specified for BPF_OBJ_GET
> > 
> > In my proposal, that would change to:
> > 
> > 1) struct bpf_map m_uid, m_gid, m_mode
> > 2) struct file's FS read/write permission (depends on the inode on
> >     BPFFS)
> > 3) process uid, gid of the requestor
> > 4) union bpf_attr's file_flags specified for BPF_OBJ_GET
> > 
> > > While that's a lot, we always intersect them and keep only the most
> > > restrictive combination. So if at any of the layers we have read-only
> > > permissions, resulting *new struct bpf_map_view* will only specify
> > > BPF_F_RDONLY. E.g., if at layers 1, 2, and 4 we allow BPF_F_WRONLY,
> > > but BPFFS file permission (layer #3 above) at that moment is
> > > read-only, we should be only getting read-only view of BPF map.
> > 
> > Ok, sure. I think more or less the proposals are aligned. If traditional
> > access control is sufficient, we could avoid the increased complexity of
> > the new bpf_map_view layer.
> 
> I think this additional complexity is fundamental to this problem. And
> as I mentioned above, relying just on inode permissions doesn't seem
> sufficient. But maybe I missed something in your proposal.

Assuming that we can mediate or it is not possible to clear/set
FMODE_CAN_READ/FMODE_CAN_WRITE, fd has already the concept of view
(capability?).

Fd modes hold what DAC/MAC granted to you, and give you the ability to
perform compatible operations.

The only missing part, is to do better mediation, e.g. by introducing
DAC in addition to MAC.

> > > P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
> > > BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
> > > user will control that. E.g., FS read-only permission, does it
> > > restrict both user-space and BPF-view, or just user-space view? We can
> > > certainly extend file_flags to allow users to get BPF-side read-only
> > > and user-space-side read-write BPF map FD, for example. Obviously, BPF
> > > verifier would need to know about struct bpf_map_view when accepting
> > > BPF map FD in ldimm64 and such.
> > 
> > I guess, this patch could be used:
> > 
> > https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/
> > 
> > When passing a fd to an eBPF program, the permissions of the user space
> > side cannot exceed those defined from eBPF program side.
> 
> Don't know, maybe. But I can see how BPF-side can be declared r/w for
> BPF programs, while user-space should be restricted to read-only. I'm
> a bit hesitant to artificially couple both together.

Ok. At least what I would do is to forbid write, if you provide a read-
only fd.

Thanks

Roberto

