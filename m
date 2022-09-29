Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4A5EEFBE
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiI2HzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2HzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 03:55:18 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4713F1877;
        Thu, 29 Sep 2022 00:55:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MdQVN3bx0z9v7HH;
        Thu, 29 Sep 2022 15:49:16 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAXD5NFTzVj3l+EAA--.16688S2;
        Thu, 29 Sep 2022 08:54:54 +0100 (CET)
Message-ID: <3a9efcd6c8f7fa3908230ef5be0e0ad224a730ff.camel@huaweicloud.com>
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
Date:   Thu, 29 Sep 2022 09:54:43 +0200
In-Reply-To: <CAHC9VhRKq=BMtAat2_+0VvYk91hnryUHg+wbZRhu2BDB9ehC2A@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAXD5NFTzVj3l+EAA--.16688S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW3GrW7Zw1kXF15Cry7GFg_yoW7Ww1fpF
        W8t3W5KF4DJryrAw4vqw1rJF1Fy395GrZrXr90yryrZ3Wq9w1rKr4IkF45uFyvvr1xGw10
        vrWSyr9xZas8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4OQkAAAs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-09-28 at 20:24 -0400, Paul Moore wrote:
> On Wed, Sep 28, 2022 at 7:24 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote
> > On Wed, 2022-09-28 at 12:33 +0200, Toke Høiland-Jørgensen wrote:
> > > Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
> > > 
> > > > On Wed, 2022-09-28 at 09:52 +0100, Lorenz Bauer wrote:
> > > > > On Mon, 26 Sep 2022, at 17:18, Roberto Sassu wrote:
> > > > > > Uhm, if I get what you mean, you would like to add DAC
> > > > > > controls
> > > > > > to
> > > > > > the
> > > > > > pinned map to decide if you can get a fd and with which
> > > > > > modes.
> > > > > > 
> > > > > > The problem I see is that a map exists regardless of the
> > > > > > pinned
> > > > > > path
> > > > > > (just by ID).
> > > > > 
> > > > > Can you spell this out for me? I imagine you're talking about
> > > > > MAP_GET_FD_BY_ID, but that is CAP_SYS_ADMIN only, right? Not
> > > > > great
> > > > > maybe, but no gaping hole IMO.
> > > > 
> > > > +linux-security-module ML (they could be interested in this
> > > > topic
> > > > as
> > > > well)
> > > > 
> > > > Good to know! I didn't realize it before.
> > > > 
> > > > I figured out better what you mean by escalating privileges.
> > > > 
> > > > Pin a read-only fd, get a read-write fd from the pinned path.
> > > > 
> > > > What you want to do is, if I pin a read-only fd, I should get
> > > > read-
> > > > only
> > > > fds too, right?
> > > > 
> > > > I think here there could be different views. From my
> > > > perspective,
> > > > pinning is just creating a new link to an existing object.
> > > > Accessing
> > > > the link does not imply being able to access the object itself
> > > > (the
> > > > same happens for files).
> > > > 
> > > > I understand what you want to achieve. If I have to choose a
> > > > solution,
> > > > that would be doing something similar to files, i.e. add owner
> > > > and
> > > > mode
> > > > information to the bpf_map structure (m_uid, m_gid, m_mode). We
> > > > could
> > > > add the MAP_CHMOD and MAP_CHOWN operations to the bpf() system
> > > > call
> > > > to
> > > > modify the new fields.
> > > > 
> > > > When you pin the map, the inode will get the owner and mode
> > > > from
> > > > bpf_map. bpf_obj_get() will then do DAC-style verification
> > > > similar
> > > > to
> > > > MAC-style verification (with security_bpf_map()).
> > > 
> > > As someone pointed out during the discussing at LPC, this will
> > > effectively allow a user to create files owned by someone else,
> > > which
> > > is
> > > probably not a good idea either from a security PoV. (I.e., user
> > > A
> > > pins
> > > map owned by user B, so A creates a file owned by B).
> > 
> > Uhm, I see what you mean. Right, it is not a good idea, the owner
> > of
> > the file should the one that pinned the map.
> > 
> > Other than that, DAC verification on the map would be still
> > correct, as
> > it would be independent from the DAC verification of the file.
> 
> I only became aware of this when the LSM list was CC'd so I'm a
> little
> behind on what is going on here ... looking quickly through the
> mailing list archive it looks like there is an issue with BPF map
> permissions not matching well with their associated fd permissions,
> yes?  From a LSM perspective, there are a couple of hooks that
> currently use the fd's permissions (read/write) to determine the
> appropriate access control check.

From what I understood, access control on maps is done in two steps.
First, whenever someone attempts to get a fd to a map
security_bpf_map() is called. LSM implementations could check access if
the current process has the right to access the map (whose label can be
assigned at map creation time with security_bpf_map_alloc()).

Second, whenever the holder of the obtained fd wants to do an operation
on the map (lookup, update, delete, ...), eBPF checks if the fd modes
are compatible with the operation to perform (e.g. lookup requires
FMODE_CAN_READ).

One problem is that the second part is missing for some operations
dealing with the map fd:

Map iterators:
https://lore.kernel.org/bpf/20220906170301.256206-1-roberto.sassu@huaweicloud.com/

Map fd directly used by eBPF programs without system call:
https://lore.kernel.org/bpf/20220926154430.1552800-1-roberto.sassu@huaweicloud.com/

Another problem is that there is no DAC, only MAC (work in progress). I
don't know exactly the status of enabling unprivileged eBPF.

Apart from this, now the discussion is focusing on the following
problem. A map (kernel object) can be referenced in two ways: by ID or
by path. By ID requires CAP_ADMIN, so we can consider by path for now.

Given a map fd, the holder of that fd can create a new reference
(pinning) to the map in the bpf filesystem (a new file whose private
data contains the address of the kernel object).

Pinning a map does not have a corresponding permission. Any fd mode is
sufficient to do the operation. Furthermore, subsequent requests to
obtain a map fd by path could result in receiving a read-write fd,
while at the time of pinning the fd was read-only.

While this does not seem to me a concern from MAC perspective, as
attempts to get a map fd still have to pass through security_bpf_map(),
in general this should be fixed without relying on LSMs.

> Is the plan to ensure that the map and fd permissions are correct at
> the core BPF level, or do we need to do some additional checks in the
> LSMs (currently only SELinux)?

Should we add a new map_pin permission in SELinux?

Should we have DAC to restrict pinnning without LSMs?

Thanks

Roberto

