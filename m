Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615D064E96B
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 11:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLPKZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 05:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiLPKYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 05:24:47 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0E50D70;
        Fri, 16 Dec 2022 02:24:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYQ533lWZz9xqpX;
        Fri, 16 Dec 2022 18:17:11 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3DGNAR5xjWcYZAA--.14542S2;
        Fri, 16 Dec 2022 11:24:10 +0100 (CET)
Message-ID: <c0f7120e433c80b7c4e0af788eda58de8d1ecdad.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Fri, 16 Dec 2022 11:23:56 +0100
In-Reply-To: <3fa1fdafc4335c43f84259261dcd1f7d588985a6.camel@huaweicloud.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
         <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
         <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
         <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
         <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
         <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
         <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
         <3fa1fdafc4335c43f84259261dcd1f7d588985a6.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA3DGNAR5xjWcYZAA--.14542S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFykKryDtrWkCryDGryUWrg_yoW7XF4xpF
        W3K3W7Kr1DJ3y7Can3KFyDJ3WFya1rJr45Z3s8t3y8Z3s09r1FkF4xKF4Y9F9rCrn7Jw1Y
        qrZFvF9xGF1DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4a4HwABsc
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-12-12 at 19:19 +0100, Roberto Sassu wrote:
> On Mon, 2022-12-12 at 09:07 -0800, Alexei Starovoitov wrote:
> > On Mon, Dec 12, 2022 at 8:11 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Mon, 2022-11-07 at 13:11 +0100, Roberto Sassu wrote:
> > > 
> > > [...]
> > > 
> > > > > > > P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
> > > > > > > BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
> > > > > > > user will control that. E.g., FS read-only permission, does it
> > > > > > > restrict both user-space and BPF-view, or just user-space view? We can
> > > > > > > certainly extend file_flags to allow users to get BPF-side read-only
> > > > > > > and user-space-side read-write BPF map FD, for example. Obviously, BPF
> > > > > > > verifier would need to know about struct bpf_map_view when accepting
> > > > > > > BPF map FD in ldimm64 and such.
> > > > > > 
> > > > > > I guess, this patch could be used:
> > > > > > 
> > > > > > https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/
> > > > > > 
> > > > > > When passing a fd to an eBPF program, the permissions of the user space
> > > > > > side cannot exceed those defined from eBPF program side.
> > > > > 
> > > > > Don't know, maybe. But I can see how BPF-side can be declared r/w for
> > > > > BPF programs, while user-space should be restricted to read-only. I'm
> > > > > a bit hesitant to artificially couple both together.
> > > > 
> > > > Ok. At least what I would do is to forbid write, if you provide a read-
> > > > only fd.
> > > 
> > > Ok, we didn't do too much progress for a while. I would like to resume
> > > the discussion.
> > > 
> > > Can we start from the first point Lorenz mentioned? Given a read-only
> > > map fd, it is not possible to write to the map. Can we make sure that
> > > this properly work?
> > > 
> > > In my opinion, to achieve this particular goal, the map view
> > > abstraction Andrii suggested, should not be necessary.
> > 
> > What do you 'not necessary' ?
> > afair the map view abstraction is only one that actually addresses
> > all the issues.
> 
> For the first issue, map iterators, you need to ensure that the fd is
> read-write if the key/value can be modified.
> 
> For the second issue, fd modes ignored by the verifier, you need to
> restrict operations on the map, to meet the expectactions of whoever
> granted the fd to the requestor (as Lorenz said, if you have a read-
> only fd, you should not be able to write to the map).
> 
> Maybe I missed something, I didn't get how the map view abstraction
> could help better in these cases.

Ok, let me try to complete the solution for the issues Lorenz pointed
out. Here I discuss only the system call side of access.

I was thinking on the meaning of the permissions on the inode of a
pinned eBPF object. Given that the object exists without pinning, this
double check of permissions first on the inode and then on the object
to me looks very confusing.

So, here is a proposal: what if read and write in the context of
pinning don't refer to accessing the eBPF object itself but to the
ability to read the association between inode and eBPF object or to
write/replace the association with a different eBPF object (I guess not
supported now).

We continue to do access control only at the time a requestor asks for
a fd. Currently there is only MAC, but we can add DAC and POSIX ACL too
(Andrii wanted to give read permission to a specific group). The owner
is who created the eBPF object and who can decide (for DAC and ACL) who
can access that object.

The requestor obtains a fd with modes depending on what was granted. Fd
modes (current behavior) give the requestor the ability to do certain
operations. It is responsibility of the function performing the
operation on an eBPF object to check the fd modes first.

It does not matter if the eBPF object is accessed through ID or inode,
access control is solely based on who is accessing the object, who
created it and the object permissions. *_GET_FD_BY_ID and OBJ_GET
operations will have the same access control.

With my new proposal, once an eBPF object is pinned the owner or
whoever can access the inode could do chown/chmod. But this does not
have effect on the permissions of the object. It changes only who can
retrieve the association with the eBPF object itself.

Permissions on the eBPF object could be changed with the bpf() syscall
and with new operations (such as OBJ_CHOWN, OBJ_CHMOD). These
operations are of course subject to access control too.

The last part is who can do pinning. Again, an eBPF object can be
pinned several times by different users. It won't affect who can access
the object, but only who can access the association between inode and
eBPF object.

We can make things very simple: whoever is able to read the association
is granted with the privilege to pin the eBPF object again.

One could ask what happens if a user has only read permission on an
inode created by someone else, but has also write permission on a new
inode the user creates by pinning the eBPF object again (I assume that
changing the association makes sense). Well, that user is the owner of
the inode. If the user wants other users accessing it to see a
different eBPF object, it is the user's decision.

Roberto

