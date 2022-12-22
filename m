Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C861C653A34
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 01:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiLVAzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 19:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVAzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 19:55:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF086315
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:55:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so309979pjj.4
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gFNetXaRlVDvCqhQ0rysSFbh6onFGxVaOPCNsmu49Ws=;
        b=dTpDCEko7F1uV9ySI49/PGF87sfjLnGMpGIARCulw49iil7t7GrLERZCBMWKI9hTwM
         f2AwqwKyHqQ33x27uY8pdxNWA62fZkRSiV4iDVdcXfNXoXX/Yohu4W0Ybv4P9mu65C28
         E6GWIs7zMU8Os5mD9w8P3CTsqaQMy42AJ4eWZUHGJ68hZ2wAEMFxuyGX1rfI7kNk9puk
         ySiQt0tQgLE+c6DjCQAupf88AjjGfq2bbbQti//SFL8Sr8q0ntx5kyEbNkqU0T7KpcwT
         jJ9eslg3EG6vjJ1a2d4smrCq4dGEDyV6aWuT7xrrrbtHt1j7Rr94yW+AauKuezOe/zS/
         LUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFNetXaRlVDvCqhQ0rysSFbh6onFGxVaOPCNsmu49Ws=;
        b=WL8vIGWS7tlihyRw/kiTNCVV5l3HpmlvmCj4XqpS7xmOr5w6Pzi8gOusmPAyBbJWuO
         Bbq4WgMktrdyk2agxdQw0E6eHxZD/TQkkmi/W+1zleXkGuDvI98dORyq6oxUvprxm+Vj
         SHVAIDnkPLiCFF/hy8CWq6FfleufcxWTxS0kqYo2shHZHI6U8TuNRMqyiA648P/RT3tH
         C1hiwT33OB47cMPFCA5YKmd/Jyt+AMvnBJlUTyww2B6BHvdjQgFfwv+e0t7BizDjR8dk
         hJxYjbm+R7GjyQARybPsWQZj7fFw1WC6wmISFtC+8V7s8E4tDav4ETtIUJRZAaIlWB3c
         wTdQ==
X-Gm-Message-State: AFqh2koqx6BNeo8GIGtfAh5FAw7YIRRNw8MIG+sLEdCFEQBVvneI8XK/
        WQSoRL/lqzbjZYfeFGGMskdzry2BpdxcukpVsxr6
X-Google-Smtp-Source: AMrXdXuBq7WoL3pjZlW0Sm6fCr/jRGPU8wG+z1QgKR0VEXzdR8F89j5Kjjz4WAZQmgctE0QWeLtMjg/nigBnCIFC7/Q=
X-Received: by 2002:a17:90a:3944:b0:218:8398:5846 with SMTP id
 n4-20020a17090a394400b0021883985846mr380780pjf.241.1671670544636; Wed, 21 Dec
 2022 16:55:44 -0800 (PST)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com> <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
 <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com> <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
 <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
 <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
 <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
 <3fa1fdafc4335c43f84259261dcd1f7d588985a6.camel@huaweicloud.com>
 <c0f7120e433c80b7c4e0af788eda58de8d1ecdad.camel@huaweicloud.com>
 <CAHC9VhQKa36C4xh1OiCdC1baNSeNL7OMLY9zg4O0UWahX-mzow@mail.gmail.com> <4175e56b-8522-5086-bdf1-b534122c841b@huaweicloud.com>
In-Reply-To: <4175e56b-8522-5086-bdf1-b534122c841b@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Dec 2022 19:55:33 -0500
Message-ID: <CAHC9VhSRs0cUowuedQ1Sth4U7P5vcJMqe-qTLMBvCpYbeZ5OxA@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 21, 2022 at 4:54 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 12/20/2022 9:44 PM, Paul Moore wrote:
> > On Fri, Dec 16, 2022 at 5:24 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> >> Ok, let me try to complete the solution for the issues Lorenz pointed
> >> out. Here I discuss only the system call side of access.
> >>
> >> I was thinking on the meaning of the permissions on the inode of a
> >> pinned eBPF object. Given that the object exists without pinning, this
> >> double check of permissions first on the inode and then on the object
> >> to me looks very confusing.
> >>
> >> So, here is a proposal: what if read and write in the context of
> >> pinning don't refer to accessing the eBPF object itself but to the
> >> ability to read the association between inode and eBPF object or to
> >> write/replace the association with a different eBPF object (I guess not
> >> supported now).
> >>
> >> We continue to do access control only at the time a requestor asks for
> >> a fd. Currently there is only MAC, but we can add DAC and POSIX ACL too
> >> (Andrii wanted to give read permission to a specific group). The owner
> >> is who created the eBPF object and who can decide (for DAC and ACL) who
> >> can access that object.
> >>
> >> The requestor obtains a fd with modes depending on what was granted. Fd
> >> modes (current behavior) give the requestor the ability to do certain
> >> operations. It is responsibility of the function performing the
> >> operation on an eBPF object to check the fd modes first.
> >>
> >> It does not matter if the eBPF object is accessed through ID or inode,
> >> access control is solely based on who is accessing the object, who
> >> created it and the object permissions. *_GET_FD_BY_ID and OBJ_GET
> >> operations will have the same access control.
> >>
> >> With my new proposal, once an eBPF object is pinned the owner or
> >> whoever can access the inode could do chown/chmod. But this does not
> >> have effect on the permissions of the object. It changes only who can
> >> retrieve the association with the eBPF object itself.
> >
> > Just to make sure I understand you correctly, you're suggesting that
> > the access modes assigned to a pinned map's fd are simply what is
> > requested by the caller, and don't necessarily represent the access
> > control modes of the underlying map, is that correct?  That seems a
>
> The fd modes don't necessarily represent the access control modes of the
> inode the map is pinned to. But they surely represent the access control
> modes of the map object itself.
>
> The access control modes of the inode tell if the requestor is able to
> retrieve the map from it, before accessing the map is attempted. But,
> even if the request is granted (i.e. the inode has read permission), the
> requestor has still to pass access control on the map object, which is
> separate.

Okay, good.  That should work.

> Fd modes are bound to the map access modes, but not necessarily bound to
> the inode access modes (fd with write mode, on an inode with only read
> permission). Fd modes are later enforced by map operations by checking
> the compatibility of the operation (e.g. read-like operation requires fd
> read mode).
>
> The last point is what it means getting a fd on the inode itself. It is
> possible, because inodes could have seq_file operations. Thus, one could
> dump the map content by just reading from the inode.

Gotcha, yes, that would be bad.

> Here, I suggest that we still do two separate checks. One is for the
> open(), done by the VFS, and the other to access the map object. Not
> having read permission on the inode means that the map content cannot be
> dumped. But, having read permission on the inode does not imply the
> ability to do it (still the map object check has to be passed).

That makes sense to me.

-- 
paul-moore.com
