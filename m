Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4565D6134F7
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 12:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiJaLyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 07:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiJaLye (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 07:54:34 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66F10C6;
        Mon, 31 Oct 2022 04:54:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4N1BH31nGGz9xqx3;
        Mon, 31 Oct 2022 19:47:59 +0800 (CST)
Received: from [10.48.133.117] (unknown [10.48.133.117])
        by APP1 (Coremail) with SMTP id LxC2BwCXg3BVt19jhEsoAA--.31921S2;
        Mon, 31 Oct 2022 12:54:09 +0100 (CET)
Message-ID: <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
Date:   Mon, 31 Oct 2022 12:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Closing the BPF map permission loophole
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <oss@lmb.io>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
 <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
Content-Language: en-US
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCXg3BVt19jhEsoAA--.31921S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJr4kXr1rAF47AryUZryUtrb_yoWDur4UpF
        WrtrnFkF4xJrW7CrsYq3y7AF1FvrWfXr4UWas8J34UZrZIgr9xKF1xtF4YgrW3Ars7G3ya
        qw4IvryDJFyjvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBF1jj4TgQgABsR
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/27/2022 6:54 PM, Andrii Nakryiko wrote:
> On Wed, Sep 28, 2022 at 1:54 AM Lorenz Bauer <oss@lmb.io> wrote:
>>
>> On Thu, 15 Sep 2022, at 11:30, Lorenz Bauer wrote:
>>> Hi list,
>>>
>>> Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF
>>> map permission loophole", with slides at [0].
>>
>> I've put this topic on the agenda of the 2022-10-06 BPF office hours to get some maintainer attention. Details are here: https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit
>>
>> Best
> 
> So after the office hours I had an offline whiteboard discussion with
> Alexei explaining more precisely what I was proposing, and it became
> apparent that some of the things I was proposing weren't exactly
> clear, and thus people were left confused about the solution I was
> talking about. So I'll try to summarize it a bit and add some more
> specifics. Hopefully that will help, because I still believe we can
> solve this problem moving forward.
> 
> But first, two notes.
> 
> 1) Backporting this is going to be hard, and I don't think that should
> be the goal, it's going to be too intrusive, probably.
> 
> 2) It turned out that we currently don't store user-space-side
> read/write permissions on struct bpf_map itself, and we'd need to do
> that as a preliminary step here. Below I just assume that struct
> bpf_map records all the bpf-side and user-side read/write permissions.

+linux-security-module, Paul, Casey

Thanks Andrii for writing such detailed proposal. It is very clear.

I was thinking about your bpf_map_view abstraction, to record per-fd
permission. My question would be, isn't the f_mode enough for this
purpose? I mean, if you want to record the access flags per fd, you
already have them in f_mode. Apart from map iterators, the eBPF code
handling the user space side of map access is already capable of
handling and enforcing based on the f_mode.

So, what remains for us to do is to ensure that a requestor gets
a fd with modes compatible with what the requestor is allowed to do.

For a moment, I exclude MAC-style controls, as I understood that
this should not be the only type of enforcement.

Then, maybe we could treat maps like inodes, meaning that we could
add to bpf_map the following fields:

m_uid
m_gid
m_mode

These fields will be populated at map creation time, depending on
who is requesting it. With similar mechanism as for inodes (umask),
we can decide the default m_mode (read-write for the owner,
read-only for the group and others). These fields are relevant only
for the user space side of map access.

We can add two new commands for bpf():

BPF_MAP_CHOWN
BPF_MAP_CHMOD

to change the fields above.

I comment below, to see if this alternative proposal works for the
use cases you described.

> So, the overall idea is that instead of fetching struct bpf_map point
> for all kinds of FD-based operations (bpf_obj_get, map_fd_by_id, even
> bpf_map_create) we are always working with a view of a map, and that
> "view" is a separate struct/object, something like:
> 
> struct bpf_map_view {
>      struct bpf_map *map;
>      /* BPF_F_RDONLY | BPF_F_WRONLY, but we can later also add
>         BPF-side flags: BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG
>      */
>      int access_flags;
> }
> 
> So whenever we work with map by FD, we get struct bpf_map_view (i.e.,
> we store struct bpf_map_view inside file->private and
> inode->i_private). The semantics of view->access_flags is that it is
> superimposed on top of bpf_map->map_flags (specifically its
> BPF_F_RDONLY | BPF_F_WRONLY parts, later also BPF_F_RDONLY_PROG |
> BPF_F_WRONLY_PROG). This means that if struct bpf_map is R/W, but our
> current bpf_map_view says BPF_F_RDONLY, then only read-only access is
> allowed through that FD. On the other hand, if bpf_map itself is only
> BPF_F_RDONLY, but we somehow go bpf_map_view with BPF_F_RDONLY |
> BPF_F_WRONLY (e.g., due to chmod loophole), then it doesn't matter,
> it's still BPF_F_RDONLY, no write access. We can try preventing such
> situations in some circumstances, but as we showed with chmod() it's
> impossible to prevent in general.
> 
> So, just to hopefully make it a bit clearer, let's discuss a use case
> that a bunch of people had in mind. Root/CAP_BPF user created R/W
> bpf_map, but wants to pin it in one BPFFS path as R/W, so that it can
> be later opened as R/W and modified. This BPFFS path will be
> restricted through FS permissions to only allow it to be opened by a
> privileged user/group. But, that same original root/CAP_BPF user would
> like to also create a read-only BPFFS pinning of that same map, and
> let unprivileged user(s) to open and work with that map, but only
> perform read-only operations (e.g., BPF_MAP_LOOKUP_ELEM command).
> 
> Let's see how that works in this new bpf_map_view model.
> 
> 1. root/CAP_BPF user does BPF_MAP_CREATE operation, struct bpf_map is
> created with map_flags BPF_F_RDONLY | BPF_F_WRONLY. Also, immediately
> struct bpf_map_view is created with same BPF_F_RDONLY | BPF_F_WRONLY
> access_flags. struct bpf_map_view keeps reference on struct bpf_map,
> struct bpf_map_view is assigned to struct file->private, new FD is
> returned to user-space.

Ok, m_uid, m_gid are taken from the current process. m_mode (for the
owner) could be set from the map creation flags (0, BPF_F_RDONLY,
BPF_F_WRONLY). The fd the owner receives has f_mode compatible with the
map creation flags.

> 2. That same root/CAP_BPF user does BPF_OBJ_PIN and specifies that
> they want R/W pinning (through file_flags). Kernel clones/copies
> struct bpf_map_view (I think bpf_map_view shouldn't be shared between
> files/inodes, each file/inode has its own personal copy; but we can
> work out the details later), sets (keeps in this case) its
> access_flags as  BPF_F_RDONLY | BPF_F_WRONLY. After that they are free
> to chown/chmod as necessary to prevent unprivileged user from doing
> anything with that BPFFS file, if necessary.

I understand that per-pinned map permissions gives a lot of flexibility.
But maybe, the owner/group/others permissions are sufficient to cover
most of the use cases. Instead of creating two pinned maps, one 
read-write and one read-only, we just create one and we define the map 
m_mode
as rw-r--r--.

At the time a requestor wants to get a fd from the pinned map through
OBJ_GET, the kernel checks from the process UID/GID if it has 
permissions in m_mode.

We can keep the permission check on the inode of the pinned map as an
additional security control.

> 3. Now, for the read-only pinning. User does another BPF_OBJ_PIN using
> original R/W map FD, but now they specify file_flags to only allow
> BPF_F_RDONLY (I'm too lazy to check what exact flag we pass there to
> communicate this intent, it's not that important for this discussion).
> At this point, kernel creates a new struct bpf_map_view, pointing to
> struct bpf_map, but this time access_flags have only BPF_F_RDONLY set.
> Then we proceed to creating an inode, its i_private is assigned this
> new R/O bpf_map_view. The user should chmod/chown pinned BPFFS file
> appropriately to allow unprivileged users to BPF_OBJ_GET it.

Now that the main access control check is based on m_mode, we might
think who can pin a map. Only the owner? Maybe we can reuse the
execute permission in m_mode to determine that.

> Now, let's assume we are unprivileged user who wants to work with that
> pinned BPF map. When we do BPF_OBJ_GET on that read-only pinned file,
> kernel fetches struct bpf_map_view from inode->i_private which has
> access_flags as BPF_F_RDONLY. That's it, there is no way we can do
> update on that map, kernel will reject that even though struct bpf_map
> itself allows BPF_F_WRONLY.

This should be clear now.

> Note, though, that once we checked everything, as we create a new
> struct file and return new FD to user-space, that new struct file will
> have *yet another copy* of struct bpf_map_view, cloned from inode's
> bpf_map_view (recall that I was proposing to have 1-to-1 mapping
> between file/inode and bpf_map_view).
> 
> 
> Let's now assume we are sneaky bastards and chmod that second pinned
> BPFFS file to allow r/w file permissions. When we do BPF_OBJ_GET,
> again, we'll fetch struct bpf_map_view which enforce BPF_F_RDONLY
> (only), despite file itself having writable permissions. We can argue
> if we should reject such BPF_OBJ_GET command or silently "downgrade"
> to read-only view, that's beside the point.

Ok, yes. Permissions on the pinned map are just an additional barrier.

> Hopefully this is a bit clearer.
> 
> One last note. When we are talking about BPF_OBJ_GET, we are actually
> going to be dealing with 4 layers of read and write permissions:
>    1) struct bpf_map's "inherent" permissions
>    2) struct bpf_map_view's access_flags
>    3) struct file's FS read/write permissions
>    4) union bpf_attr's file_flags specified for BPF_OBJ_GET

In my proposal, that would change to:

1) struct bpf_map m_uid, m_gid, m_mode
2) struct file's FS read/write permission (depends on the inode on
    BPFFS)
3) process uid, gid of the requestor
4) union bpf_attr's file_flags specified for BPF_OBJ_GET

> While that's a lot, we always intersect them and keep only the most
> restrictive combination. So if at any of the layers we have read-only
> permissions, resulting *new struct bpf_map_view* will only specify
> BPF_F_RDONLY. E.g., if at layers 1, 2, and 4 we allow BPF_F_WRONLY,
> but BPFFS file permission (layer #3 above) at that moment is
> read-only, we should be only getting read-only view of BPF map.

Ok, sure. I think more or less the proposals are aligned. If traditional
access control is sufficient, we could avoid the increased complexity of 
the new bpf_map_view layer.

> P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
> BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
> user will control that. E.g., FS read-only permission, does it
> restrict both user-space and BPF-view, or just user-space view? We can
> certainly extend file_flags to allow users to get BPF-side read-only
> and user-space-side read-write BPF map FD, for example. Obviously, BPF
> verifier would need to know about struct bpf_map_view when accepting
> BPF map FD in ldimm64 and such.

I guess, this patch could be used:

https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/

When passing a fd to an eBPF program, the permissions of the user space
side cannot exceed those defined from eBPF program side.

Thanks

Roberto

