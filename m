Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B05F080F
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiI3J5Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiI3J5X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 05:57:23 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF5B17F560;
        Fri, 30 Sep 2022 02:57:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Mf5B76wGSz9ttD8;
        Fri, 30 Sep 2022 17:52:31 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3c15gvTZjNyOKAA--.49482S2;
        Fri, 30 Sep 2022 10:56:59 +0100 (CET)
Message-ID: <4c5c64f32ced8c9402db8c93ba0c29c5379ff75a.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 30 Sep 2022 11:56:45 +0200
In-Reply-To: <CAHC9VhTWsP99PxJLebbm04HdSAfF4QyhU0kwZZQnduET3jfKjw@mail.gmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
         <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
         <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
         <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
         <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
         <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
         <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
         <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com>
         <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
         <87mtajss8j.fsf@toke.dk>
         <fe9fe2443b8401a076330a3019bd46f6c815a023.camel@huaweicloud.com>
         <CAHC9VhRKq=BMtAat2_+0VvYk91hnryUHg+wbZRhu2BDB9ehC2A@mail.gmail.com>
         <3a9efcd6c8f7fa3908230ef5be0e0ad224a730ff.camel@huaweicloud.com>
         <CAHC9VhTWsP99PxJLebbm04HdSAfF4QyhU0kwZZQnduET3jfKjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwD3c15gvTZjNyOKAA--.49482S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr13KFWfWr13uryUZw1rCrg_yoWfWryxpF
        Wrt3W3KF1kGFWxAws2q3yUJa1SvrZ3Xr45J3s0gryUZan8WF1fKrySgF15ZFyjyr1xZ3yF
        vr40yr9rCayDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj3+ekQACsO
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-09-29 at 18:30 -0400, Paul Moore wrote:
> On Thu, Sep 29, 2022 at 3:55 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Wed, 2022-09-28 at 20:24 -0400, Paul Moore wrote:
> > > I only became aware of this when the LSM list was CC'd so I'm a
> > > little
> > > behind on what is going on here ... looking quickly through the
> > > mailing list archive it looks like there is an issue with BPF map
> > > permissions not matching well with their associated fd
> > > permissions,
> > > yes?  From a LSM perspective, there are a couple of hooks that
> > > currently use the fd's permissions (read/write) to determine the
> > > appropriate access control check.
> > 
> > From what I understood, access control on maps is done in two
> > steps.
> > First, whenever someone attempts to get a fd to a map
> > security_bpf_map() is called. LSM implementations could check
> > access if
> > the current process has the right to access the map (whose label
> > can be
> > assigned at map creation time with security_bpf_map_alloc()).
> 
> [NOTE: SELinux is currently the only LSM which provides BPF access
> controls, so they are going to be my example here and in the rest of
> this email.]
> 
> In the case of SELinux, security_bpf_map() does check the access
> between the current task and the BPF map itself (which inherits its
> security label from its creator), with the actual permission
> requested
> being determined by the fmode_t parameter passed to the LSM hook.
> Looking at the current BPF code, the callers seem to take that from
> various different places
> (bpf_attr:{file_flags,map_flags,open_flags}).
> This could be due solely to the different operations being done by
> the
> callers, which would make me believe everything is correct, but given
> this thread it seems reasonable for someone with a better
> understanding of BPF than me to double check this.  Can you help
> verify that everything is okay here?

I also don't have concerns on this part. eBPF maintainers can help to
confirm.

> Second, whenever the holder of the obtained fd wants to do an
> > operation
> > on the map (lookup, update, delete, ...), eBPF checks if the fd
> > modes
> > are compatible with the operation to perform (e.g. lookup requires
> > FMODE_CAN_READ).
> 
> To be clear, from what I can see, it looks like the LSM is not
> checking the fd modes, but rather the modes stored in the bpf_attr,
> which I get the impression do not always match the fd modes.  Yes?
> No?

Correct, there is no revalidation. Fd modes represent what LSMs granted
to the fd holder. eBPF allows operations on the object behind the fd
depending on the stored fd modes (for maps, not sure about the other
object types).

> There is also LSM/SELinux code which checks the permissions when a
> BPF
> map is passed between tasks via a fd.  Currently the SELinux check
> only looks at the file:f_mode to get the permissions to check, but if
> the f_mode bits are not the authoritative record of what is allowed
> in
> the BPF map, perhaps we need to change that to use one of the
> bpf_attr
> mode bits (my gut feeling is bpf_attr:open_flags)?
> 
> > One problem is that the second part is missing for some operations
> > dealing with the map fd:
> > 
> > Map iterators:
> > https://lore.kernel.org/bpf/20220906170301.256206-1-roberto.sassu@huaweicloud.com/
> 
> You'll need to treat me like an idiot when it comes to BPF maps ;)

Argh, sorry!

> I did a very quick read on them right now and it looks like a BPF map
> iterator would just be a combination of BPF read and execute ("bpf {
> map_read prog_run }" in SELinux policy terms).  Would it make more
> sense to just use the existing security_bpf_map() and
> security_bpf_prog() hooks here?

If I can make an example, if you have a linked list, a map iterator is
like calling a function for each element of the list, allowing the
function to read and write the element.

For now I didn't think about programs. Lorenz, which reported this
issue in the first place, is planning on rethinking access control on
all eBPF objects.

When you create a map iterator, you pass the program you want to run
and a map reference to bpftool (user space). bpftool first retrieves
the fds for the program and the map (thus, security_bpf_prog() and
security_bpf_map() are called). The fds are then passed to the kernel
with another system call to create the map iterator. The map iterator
is a named kernel object, with a corresponding file in the bpf
filesystem. Reading that file causes the iteration to start, by running
the program for each map element.

The only missing part is checking the fd modes granted by LSMs at the
time the map iterator is created. If the map iterator allows read and
write, both FMODE_CAN_READ and FMODE_CAN_WRITE should be set.

> > Map fd directly used by eBPF programs without system call:
> > https://lore.kernel.org/bpf/20220926154430.1552800-1-roberto.sassu@huaweicloud.com/
> 
> Another instance of "can you please explain this use case?" ;)

Lorenz discovered that. Despite LSMs check which permissions user space
requested for a map fd, there is no corresponding check of the fd
modes. Normally, a map fd is passed in a system call to perform a map
operation. In this case, it is not. It is set in the program code, and
eBPF transforms the map fd into a map address suitable to be passed to
kernel helpers which directly access the kernel object.

> I'm not going to hazard too much of a guess here, but if the map is
> being passed between tasks and a fd is generated from that map, we
> may
> be able to cover this with logic similar
> security/selinux/hooks.c:bpf_fd_pass() ... but I'm really stretching
> my weak understanding of BPF here.
> 
> > Another problem is that there is no DAC, only MAC (work in
> > progress). I
> > don't know exactly the status of enabling unprivileged eBPF.
> 
> It is my opinion that we need to ensure both DAC and MAC are present
> in the code.  This thread makes me worry that some eBPF DAC controls
> are being ignored because one can currently say "we're okay because
> you need privilege!".  That may be true today, but I can imagine a
> time in the not too distant future where unpriv eBPF is allowed and
> we
> suddenly have to bolt on a lot of capable() checks ... which is a
> great recipe for privilege escalation bugs.
> 
> > Apart from this, now the discussion is focusing on the following
> > problem. A map (kernel object) can be referenced in two ways: by ID
> > or
> > by path. By ID requires CAP_ADMIN, so we can consider by path for
> > now.
> > 
> > Given a map fd, the holder of that fd can create a new reference
> > (pinning) to the map in the bpf filesystem (a new file whose
> > private
> > data contains the address of the kernel object).
> > 
> > Pinning a map does not have a corresponding permission. Any fd mode
> > is
> > sufficient to do the operation. Furthermore, subsequent requests to
> > obtain a map fd by path could result in receiving a read-write fd,
> > while at the time of pinning the fd was read-only.
> 
> Since the maps carry their own label I think we are mostly okay, even
> if the map is passed between tasks by some non-fd related mechanism.
> However, I am now slightly worried that if a fd is obtained with
> perms
> that don't match the underlying map and that fd is then passed to
> another task the access control check on the fd passing would not be
> correct.  Operations on the map from a SELinux perspective should
> still be okay (the map has its own label), but still.
> 
> I'm wondering if we do want to move the SELinux BPF fd passing code
> to
> check the bpf_attr:open_flags perms.  Thoughts?

Seems correct as it is, but I'm not completely familiar with this work.
As long as you ensure that the fd holder has the right to access the
map, then it will be still responsibility of eBPF to just check the fd
modes.

> While this does not seem to me a concern from MAC perspective, as
> > attempts to get a map fd still have to pass through
> > security_bpf_map(),
> > in general this should be fixed without relying on LSMs.
> 
> Agreed.  The access controls need to work both for DAC and DAC+LSM.

@all, what do you think?

> Is the plan to ensure that the map and fd permissions are correct
> > > at
> > > the core BPF level, or do we need to do some additional checks in
> > > the
> > > LSMs (currently only SELinux)?
> > 
> > Should we add a new map_pin permission in SELinux?
> 
> Maybe?  Maybe not?  I don't know, can you help me understand map
> pinning a bit more first?

I'm not completely sure that this is correct. Pinning a map seems to me
like creating a new dentry for the inode.

> Should we have DAC to restrict pinnning without LSMs?
> 
> Similar to above.

If we had DAC, even without restricting pinning, fds have to be
obtained if the DAC check passed (if we don't want to rely exclusively

on MAC). Even if pinning was done with a read-only fd, a new read-write fd can be obtained if the owner allowed you to do so.

Restricting pinning might be risky to break compatibility with existing
applications.

Roberto

