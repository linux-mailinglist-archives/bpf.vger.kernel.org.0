Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE15F13E0
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 22:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiI3UoH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 16:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiI3UoG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 16:44:06 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BD1F0CF7
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 13:44:04 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-131dda37dddso5795788fac.0
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iucWMdDiXC2TzuXfdi9T/RexEPt6mASkDyRuKHp0nGk=;
        b=QNomiRi8MIk+nkky+IZB5LI/82IfHCRGbhjORCOGXYi2taJclvcaj9h0BC/5ty2uFz
         jEcOM2AW5dg+1Xf8ChSH6YIB+NYKDh22hcec3FOK+Lm49uy41DIT5487mMMlyMqfrhAg
         JcvORgpMpePdPwB4GY0zCHzjYKbE0w7o/oB9pbRYHHx7e2OvGRvpsshjGUVgIpn4s23S
         knvMZxwQDRPCDBzqrEwPcPJtvesLX7e/K9Zt7znqV/EbzmSqZ/U4lhah8E+z6wWOCHPh
         KFbyzD97WP7SaIvEtWetBlJoF80pEKCMAi9DcUJ5YBFRQNqRDupUEVzaSMTyRmbLJB6n
         mv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iucWMdDiXC2TzuXfdi9T/RexEPt6mASkDyRuKHp0nGk=;
        b=ZW5o698j8SWz2I1m3T+rZ/Xvad/QCaL1PLx/aCht6HN2bRy6aLrpsTpOu2g2rvpEQu
         FYbvLKD+bRfCxDow8PFSviVhPnoxO1PnOxAnFLqptulEMlpbTlaKPTQAt5GovNu9u028
         RMYW2fkEe6PIQd5+mwhUzGFjgK1gPUKSXNbo8MnITKZnCRCKhosp+qQsqY0zM/f/rjFW
         gnAMieDI3nkgY/BVhUHquGWrDckqK/pI2u9uyGnXR2Xhj0GytRkR5aoO9hNrI1eCC1V/
         Nns2HlIPA3HWjNSe9yNNdBlbkIVjRprmtQgykFAT+GqIddIsIgsnoJm/yX6Ye53L9880
         v/fw==
X-Gm-Message-State: ACrzQf1xkS6hbMtwCf0OkmYBal/iUU/jkcCNilv43c0CU2ojqhn9OK38
        rSe6Fetm0OGHCkEaZstlhyRi5Ygk85oTqs5O6J1U
X-Google-Smtp-Source: AMsMyM5dUMbQwflRokmshGAAmFzsWuNnxzT8N9Z5DYrFyfpo8o3jdz18dW6ioZVGf3qD8aShmYyW3TbKATI2GhI0uOE=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr39386oab.172.1664570643929; Fri, 30
 Sep 2022 13:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com> <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
 <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com> <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
 <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com> <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
 <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com> <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
 <87mtajss8j.fsf@toke.dk> <fe9fe2443b8401a076330a3019bd46f6c815a023.camel@huaweicloud.com>
 <CAHC9VhRKq=BMtAat2_+0VvYk91hnryUHg+wbZRhu2BDB9ehC2A@mail.gmail.com>
 <3a9efcd6c8f7fa3908230ef5be0e0ad224a730ff.camel@huaweicloud.com>
 <CAHC9VhTWsP99PxJLebbm04HdSAfF4QyhU0kwZZQnduET3jfKjw@mail.gmail.com> <4c5c64f32ced8c9402db8c93ba0c29c5379ff75a.camel@huaweicloud.com>
In-Reply-To: <4c5c64f32ced8c9402db8c93ba0c29c5379ff75a.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Sep 2022 16:43:53 -0400
Message-ID: <CAHC9VhTXcD11Xyg=C1sOdY1+d8GwJVjK1V-gB-2CuRNe=zk9gA@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 30, 2022 at 5:57 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2022-09-29 at 18:30 -0400, Paul Moore wrote:
> > On Thu, Sep 29, 2022 at 3:55 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Wed, 2022-09-28 at 20:24 -0400, Paul Moore wrote:
> > > > I only became aware of this when the LSM list was CC'd so I'm a
> > > > little
> > > > behind on what is going on here ... looking quickly through the
> > > > mailing list archive it looks like there is an issue with BPF map
> > > > permissions not matching well with their associated fd
> > > > permissions,
> > > > yes?  From a LSM perspective, there are a couple of hooks that
> > > > currently use the fd's permissions (read/write) to determine the
> > > > appropriate access control check.
> > >
> > > From what I understood, access control on maps is done in two
> > > steps.
> > > First, whenever someone attempts to get a fd to a map
> > > security_bpf_map() is called. LSM implementations could check
> > > access if
> > > the current process has the right to access the map (whose label
> > > can be
> > > assigned at map creation time with security_bpf_map_alloc()).
> >
> > [NOTE: SELinux is currently the only LSM which provides BPF access
> > controls, so they are going to be my example here and in the rest of
> > this email.]
> >
> > In the case of SELinux, security_bpf_map() does check the access
> > between the current task and the BPF map itself (which inherits its
> > security label from its creator), with the actual permission
> > requested
> > being determined by the fmode_t parameter passed to the LSM hook.
> > Looking at the current BPF code, the callers seem to take that from
> > various different places
> > (bpf_attr:{file_flags,map_flags,open_flags}).
> > This could be due solely to the different operations being done by
> > the
> > callers, which would make me believe everything is correct, but given
> > this thread it seems reasonable for someone with a better
> > understanding of BPF than me to double check this.  Can you help
> > verify that everything is okay here?
>
> I also don't have concerns on this part. eBPF maintainers can help to
> confirm.
>
> > Second, whenever the holder of the obtained fd wants to do an
> > > operation
> > > on the map (lookup, update, delete, ...), eBPF checks if the fd
> > > modes
> > > are compatible with the operation to perform (e.g. lookup requires
> > > FMODE_CAN_READ).
> >
> > To be clear, from what I can see, it looks like the LSM is not
> > checking the fd modes, but rather the modes stored in the bpf_attr,
> > which I get the impression do not always match the fd modes.  Yes?
> > No?
>
> Correct, there is no revalidation. Fd modes represent what LSMs granted
> to the fd holder.

The "fd modes represent what LSMs grant the fd holder" comment doesn't
make much sense to me, can you clarify this?  LSMs by design are not
authoritative so I'm not sure how they would "grant" fd mode bits;
LSMs can deny a process the ability to open a file, but that's about
it.

> eBPF allows operations on the object behind the fd
> depending on the stored fd modes (for maps, not sure about the other
> object types).

Yes, it definitely seems as though BPF does not care at all about
permissions at the fd level.  That seems odd to me, and I wonder how
many BPF users truly understand that, but I suppose as long as
unprivileged BPF is not allowed, there is at least some ability to
dismiss the security concerns from a DAC perspective.  As mentioned
previously, I do worry about that becoming a problem in the future.

I am also growing increasingly concerned that the BPF fd passing check
in bpf_fd_pass() is not correct, but it isn't clear to me what the
correct thing is in this case.  How does one determine what access can
potentially be requested when a BPF fd is passed between processes if
the fd mode bits are not meaningful?  I'm not sure we have any other
information to go on at this point in the code ... do we just have to
assume that all passed maps are read/write (and programs can be run)
regardless of the fd mode bits?

> > There is also LSM/SELinux code which checks the permissions when a
> > BPF
> > map is passed between tasks via a fd.  Currently the SELinux check
> > only looks at the file:f_mode to get the permissions to check, but if
> > the f_mode bits are not the authoritative record of what is allowed
> > in
> > the BPF map, perhaps we need to change that to use one of the
> > bpf_attr
> > mode bits (my gut feeling is bpf_attr:open_flags)?
> >
> > > One problem is that the second part is missing for some operations
> > > dealing with the map fd:
> > >
> > > Map iterators:
> > > https://lore.kernel.org/bpf/20220906170301.256206-1-roberto.sassu@huaweicloud.com/
> >
> > You'll need to treat me like an idiot when it comes to BPF maps ;)
>
> Argh, sorry!

No worries :)

> > I did a very quick read on them right now and it looks like a BPF map
> > iterator would just be a combination of BPF read and execute ("bpf {
> > map_read prog_run }" in SELinux policy terms).  Would it make more
> > sense to just use the existing security_bpf_map() and
> > security_bpf_prog() hooks here?
>
> If I can make an example, if you have a linked list, a map iterator is
> like calling a function for each element of the list, allowing the
> function to read and write the element.

Thanks, that matches with what I found and why I thought an iterator
matches well with a map read and program run permission.  Do you
agree?

> For now I didn't think about programs. Lorenz, which reported this
> issue in the first place, is planning on rethinking access control on
> all eBPF objects.

That's probably not a bad idea, or at the very least I think it would
be a very good idea to draft a document about how eBPF access control
is supposed to work.  Start with the DAC side of things and we can
extend it to include those LSMs which provide eBPF controls.  Does
something like that already exist?

> When you create a map iterator, you pass the program you want to run
> and a map reference to bpftool (user space). bpftool first retrieves
> the fds for the program and the map (thus, security_bpf_prog() and
> security_bpf_map() are called).

Okay, that's good, we should have the right LSM controls in place at
this point in the process.

> The fds are then passed to the kernel
> with another system call to create the map iterator. The map iterator
> is a named kernel object, with a corresponding file in the bpf
> filesystem.

The iterator has no additional user data, or system state, beyond the
associated BPF program and map data, yes?  If that is the case I think
we may be able to avoid treating it as a proper object from a SELinux
perspective as long as we ensure that access is checked against the
associated map and program.

> Reading that file causes the iteration to start, by running
> the program for each map element.

... and we should definitely have an LSM access control check here,
although as mentioned above we may be able to just leverage the
existing security_bpf_map() and security_bpf_prog() hooks.  Do we do
that currently?

> The only missing part is checking the fd modes granted by LSMs at the
> time the map iterator is created. If the map iterator allows read and
> write, both FMODE_CAN_READ and FMODE_CAN_WRITE should be set.

Does the kernel enforce this from a DAC perspective?

> > > Map fd directly used by eBPF programs without system call:
> > > https://lore.kernel.org/bpf/20220926154430.1552800-1-roberto.sassu@huaweicloud.com/
> >
> > Another instance of "can you please explain this use case?" ;)
>
> Lorenz discovered that. Despite LSMs check which permissions user space
> requested for a map fd, there is no corresponding check of the fd
> modes. Normally, a map fd is passed in a system call to perform a map
> operation. In this case, it is not. It is set in the program code, and
> eBPF transforms the map fd into a map address suitable to be passed to
> kernel helpers which directly access the kernel object.

Yes, the LSMs use the fmode_t bits that are passed to
security_bpf_map() to determine the requested access permissions for
the map operation.  When I looked at the callers yesterday, it looked
like all of the security_bpf_map() callers were passing fmode_t bits
from a bpf_attr and not directly from the fd.  I need some help in
verifying that this is correct, but from what I've read thus far it
appears that the BPF code in general is not concerned about fd mode
bits.

> > I'm wondering if we do want to move the SELinux BPF fd passing code
> > to
> > check the bpf_attr:open_flags perms.  Thoughts?
>
> Seems correct as it is, but I'm not completely familiar with this work.
> As long as you ensure that the fd holder has the right to access the
> map, then it will be still responsibility of eBPF to just check the fd
> modes.

Looking at this further, I don't believe we would have the open_flags
perms at the time the BPF fd was passed anyway.

> > While this does not seem to me a concern from MAC perspective, as
> > > attempts to get a map fd still have to pass through
> > > security_bpf_map(),
> > > in general this should be fixed without relying on LSMs.
> >
> > Agreed.  The access controls need to work both for DAC and DAC+LSM.
>
> @all, what do you think?

It is worth reminding everyone this is pretty much how the rest of the
kernel works, you can't ignore the DAC controls (file mode bits,
capabilities, etc.) in favor of a pure LSM-based system, and you can't
avoid the necessary LSM hooks because "LSMs are stupid".  People build
Linux systems both as DAC only and DAC+LSM, we need to make sure we
can Do The Right Thing in both cases.

> > Is the plan to ensure that the map and fd permissions are correct
> > > > at
> > > > the core BPF level, or do we need to do some additional checks in
> > > > the
> > > > LSMs (currently only SELinux)?
> > >
> > > Should we add a new map_pin permission in SELinux?
> >
> > Maybe?  Maybe not?  I don't know, can you help me understand map
> > pinning a bit more first?
>
> I'm not completely sure that this is correct. Pinning a map seems to me
> like creating a new dentry for the inode.

Once again, can someone explain BPF map pinning?

-- 
paul-moore.com
