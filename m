Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26366A734
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 00:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjAMXoT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 18:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjAMXoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 18:44:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9E7A397;
        Fri, 13 Jan 2023 15:44:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so33288936edc.3;
        Fri, 13 Jan 2023 15:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiD4XuljWboqUYIS4LRAcIps0II1sfWftKD+kMm06Go=;
        b=C/s/9LuL/WYBqFD4EB5pxlKXWidNEPzGOv0vv1psvI3HB4A/OoUL4OYdPB9OVNHnSf
         /zhA+pFWUCxOnaVoyzAL//ACBTXJR0oJhpYrBQ8/acEbAJ5dZ/s8gb0MDYGmFL+wRfv6
         JN3v1W5I/8Jc3a0RRGgIna8GqMgyOPG43htzzVc508tueV1HT2I1PaerVBkKf1YD/KZ5
         sMSS7IQzxl4yX+uKb9UpXWYZQHoSh2rVBjNhyHdKoZFuexeoDkouLOVOiySzNHtRuxkK
         mVsgx8369gaO0PuGcl+dpF/xfVv3dt+tJTjzypzFWD6u7DNjdaJx7nBvmeyCfLS/vwiO
         UnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiD4XuljWboqUYIS4LRAcIps0II1sfWftKD+kMm06Go=;
        b=gGDLtEtQF6F1PrOZkYYiLohQ7KjI6JaqboJ1LLK0xoaPbHaBHOQGgFw7ZuPihheoaE
         0eWvLjH5y4sLOY1eOeSGRQyrEZOpdg4omttJ/HmiltX2ZthQ8C7Ui0mTifw2pJ+VV9Gb
         7xJGgU+YPKsjbYRXEbHg0fhlHXMd5rYHQ2rTeTgi9LB2rKjV/Lmu0SymgMnuJrp7NcpD
         jp8b1KTcaYlzxWPVB6ndGTPLE9oaDZXybsajA4YSoyyfGB3sR0mGUDwp4n71MBKhsru+
         wzkFKNb/ZViD1KwCFnMRQbEyUGgNrgqQbgAckAhg/p2I7okRIUVjdKyKj8l3XlIBob7T
         ajUQ==
X-Gm-Message-State: AFqh2kpIC8f02vdHkbdz5e/9i76CI77VbXnFNrIQS9XnuoVmOEgjXkYI
        7VoNGBJFsbStgh1Skp7Id0nI0n/nO0uFgNxJnZ8=
X-Google-Smtp-Source: AMrXdXugIxxCOTLCsJL5l1WzdJMhO1+av+OVIqu/rQiE4QSd8ANPBGJ7IOEjFzWCdrxmDHXl3I9pzXYhip9mmMxDPoc=
X-Received: by 2002:a05:6402:6d9:b0:499:7efc:1d78 with SMTP id
 n25-20020a05640206d900b004997efc1d78mr1921636edy.81.1673653455917; Fri, 13
 Jan 2023 15:44:15 -0800 (PST)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com> <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
 <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com> <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
 <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
 <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
 <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
 <3fa1fdafc4335c43f84259261dcd1f7d588985a6.camel@huaweicloud.com>
 <c0f7120e433c80b7c4e0af788eda58de8d1ecdad.camel@huaweicloud.com>
 <CAHC9VhQKa36C4xh1OiCdC1baNSeNL7OMLY9zg4O0UWahX-mzow@mail.gmail.com>
 <4175e56b-8522-5086-bdf1-b534122c841b@huaweicloud.com> <CAHC9VhSRs0cUowuedQ1Sth4U7P5vcJMqe-qTLMBvCpYbeZ5OxA@mail.gmail.com>
 <981170d7e587ff2c7e4673b1acc2886200e22392.camel@huaweicloud.com>
In-Reply-To: <981170d7e587ff2c7e4673b1acc2886200e22392.camel@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 15:44:04 -0800
Message-ID: <CAEf4BzYRx5gdwsEGTFY=C9-C72pus2Z3QV6THMLR4wACGMDrrQ@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
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

On Tue, Jan 10, 2023 at 1:12 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Wed, 2022-12-21 at 19:55 -0500, Paul Moore wrote:
> > On Wed, Dec 21, 2022 at 4:54 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On 12/20/2022 9:44 PM, Paul Moore wrote:
> > > > On Fri, Dec 16, 2022 at 5:24 AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > Ok, let me try to complete the solution for the issues Lorenz pointed
> > > > > out. Here I discuss only the system call side of access.
> > > > >
> > > > > I was thinking on the meaning of the permissions on the inode of a
> > > > > pinned eBPF object. Given that the object exists without pinning, this
> > > > > double check of permissions first on the inode and then on the object
> > > > > to me looks very confusing.
> > > > >
> > > > > So, here is a proposal: what if read and write in the context of
> > > > > pinning don't refer to accessing the eBPF object itself but to the
> > > > > ability to read the association between inode and eBPF object or to
> > > > > write/replace the association with a different eBPF object (I guess not
> > > > > supported now).
> > > > >
> > > > > We continue to do access control only at the time a requestor asks for
> > > > > a fd. Currently there is only MAC, but we can add DAC and POSIX ACL too
> > > > > (Andrii wanted to give read permission to a specific group). The owner
> > > > > is who created the eBPF object and who can decide (for DAC and ACL) who
> > > > > can access that object.
> > > > >
> > > > > The requestor obtains a fd with modes depending on what was granted. Fd
> > > > > modes (current behavior) give the requestor the ability to do certain
> > > > > operations. It is responsibility of the function performing the
> > > > > operation on an eBPF object to check the fd modes first.
> > > > >
> > > > > It does not matter if the eBPF object is accessed through ID or inode,
> > > > > access control is solely based on who is accessing the object, who
> > > > > created it and the object permissions. *_GET_FD_BY_ID and OBJ_GET
> > > > > operations will have the same access control.
> > > > >
> > > > > With my new proposal, once an eBPF object is pinned the owner or
> > > > > whoever can access the inode could do chown/chmod. But this does not
> > > > > have effect on the permissions of the object. It changes only who can
> > > > > retrieve the association with the eBPF object itself.
> > > >
> > > > Just to make sure I understand you correctly, you're suggesting that
> > > > the access modes assigned to a pinned map's fd are simply what is
> > > > requested by the caller, and don't necessarily represent the access
> > > > control modes of the underlying map, is that correct?  That seems a
> > >
> > > The fd modes don't necessarily represent the access control modes of the
> > > inode the map is pinned to. But they surely represent the access control
> > > modes of the map object itself.
> > >
> > > The access control modes of the inode tell if the requestor is able to
> > > retrieve the map from it, before accessing the map is attempted. But,
> > > even if the request is granted (i.e. the inode has read permission), the
> > > requestor has still to pass access control on the map object, which is
> > > separate.
> >
> > Okay, good.  That should work.
> >
> > > Fd modes are bound to the map access modes, but not necessarily bound to
> > > the inode access modes (fd with write mode, on an inode with only read
> > > permission). Fd modes are later enforced by map operations by checking
> > > the compatibility of the operation (e.g. read-like operation requires fd
> > > read mode).
> > >
> > > The last point is what it means getting a fd on the inode itself. It is
> > > possible, because inodes could have seq_file operations. Thus, one could
> > > dump the map content by just reading from the inode.
> >
> > Gotcha, yes, that would be bad.
> >
> > > Here, I suggest that we still do two separate checks. One is for the
> > > open(), done by the VFS, and the other to access the map object. Not
> > > having read permission on the inode means that the map content cannot be
> > > dumped. But, having read permission on the inode does not imply the
> > > ability to do it (still the map object check has to be passed).
> >
> > That makes sense to me.
>
> Andrii, Lorenz, what do you think about the new interpretation of the
> permissions of the inode of a pinned map?

Hi Roberto,

Sorry, I've lost track of all these intricacies a while ago. I'd like
to hear from Lorenz as well. My role here was to expand on what I
meant by "BPF map view" back then at BPF office hours and why I think
it solves all the problems mentioned earlier.

You seem to be proposing some alternative, but I'm not clear why we
need an alternative, given BPF map view seems to be the right
abstraction here? Either way, I think Lorenz was passionate about
solving this problem, so would certainly help to get his input as
well.

Thanks.

>
> Thanks
>
> Roberto
>
