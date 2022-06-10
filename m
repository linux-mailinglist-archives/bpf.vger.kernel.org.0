Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE79C545A2F
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 04:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiFJCjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 22:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFJCja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 22:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24BC166896
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 19:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 820E461C17
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 02:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7279C341C0
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 02:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654828767;
        bh=rsmpjQKyhTk7pqGkO4fYTQg8y7bY511N7uz04exIUZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a9n/XmZYq7xcguH7yVhiZiLJyfmqkVyvsJ+7fC9AwJlZ4F7U66kEmZ7kgSXyybTYV
         n7xbHu8mxN3sqjzvVZOe57wTbsJKVBY175ACD6Dzsc9EVcatyTwFnWjSJq8tSzX06L
         Efjy/yQ6HPWtgsGaSGL8h/dfqtUblx+4mT9p3itJODqH+pxkbb1ml5DxaYkTQRJ3iK
         e11n1xa65CbZckq+6oDBJfADxRrndU1wOwJfPqxQgMvCqAe73BimLt21tpqI/jKxZt
         S/7sAfDsgcK8G7aB53vWqv/8HJpnpv99n4WZ+EyXem9hAMLm1gM+fXSzKKaEwAjB8G
         NY/p3MNVzPiLA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3137eb64b67so58049457b3.12
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 19:39:27 -0700 (PDT)
X-Gm-Message-State: AOAM532e9eroVRTvaAZtuLRI/1OrAErgjHBe2BQwbHc9CDWL7JXhmL7G
        fxEt0xJyuX4YxHMStydVXLEGnxaQG10EbZitPTFoEw==
X-Google-Smtp-Source: ABdhPJyjn/3sT5tAZubi103CMBTjOKQAmXzbIkVasMHwP55lWHnixOhFNhO1ozS/oK6gxaVpaoEMSUoq7o/F1DOycc4=
X-Received: by 2002:a81:b0b:0:b0:2e5:dcc1:3d49 with SMTP id
 11-20020a810b0b000000b002e5dcc13d49mr45112515ywl.210.1654828766880; Thu, 09
 Jun 2022 19:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220609234601.2026362-1-kpsingh@kernel.org> <CAADnVQJSijXmDG0C+U101ahgOYTmHEuyBu_=CS87rJ9GchFQyA@mail.gmail.com>
 <CACYkzJ4L=SxggPxrqEC1yzv-DzM1-w0ZPo-E1HPE-8ob-r0UTw@mail.gmail.com>
In-Reply-To: <CACYkzJ4L=SxggPxrqEC1yzv-DzM1-w0ZPo-E1HPE-8ob-r0UTw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 10 Jun 2022 04:39:15 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4TDp1=-h0+1z+dvjs5eEGjQhMhrvi=4Yck3wp8dVD0hA@mail.gmail.com>
Message-ID: <CACYkzJ4TDp1=-h0+1z+dvjs5eEGjQhMhrvi=4Yck3wp8dVD0hA@mail.gmail.com>
Subject: Re: [PATCH linux-next] security: Fix side effects of default BPF LSM hooks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 10, 2022 at 2:55 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Fri, Jun 10, 2022 at 2:44 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jun 9, 2022 at 4:46 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > BPF LSM currently has a default implementation for each LSM hooks which
> > > return a default value defined in include/linux/lsm_hook_defs.h. These
> > > hooks should have no functional effect when there is no BPF program
> > > loaded to implement the hook logic.
> > >
> > > Some LSM hooks treat any return value of the hook as policy decision
> > > which results in destructive side effects.
> > >
> > > This issue and the effects were reported to me by Jann Horn:
> > >
> > > For a system configured with CONFIG_BPF_LSM and the bpf lsm is enabled
> > > (via lsm= or CONFIG_LSM) an unprivileged user can vandalize the system
> > > by removing the security.capability xattrs from binaries, preventing
> > > them from working normally:
> > >
> > > $ getfattr -d -m- /bin/ping
> > > getfattr: Removing leading '/' from absolute path names
> > > security.capability=0sAQAAAgAgAAAAAAAAAAAAAAAAAAA=
> > >
> > > $ setfattr -x security.capability /bin/ping
> > > $ getfattr -d -m- /bin/ping
> > > $ ping 1.2.3.4
> > > $ ping google.com
> > > $ echo $?
> > > 2
> > >
> > > The above reproduces with:
> > >
> > > cat /sys/kernel/security/lsm
> > > capability,apparmor,bpf
> >
> > Why is this bpf related?
> > apparmor doesn't have that hook,
> > while capability returns 0.
> > So bpf's default==0 doesn't change the situation.
> >
> > Just
> > cat /sys/kernel/security/lsm
> > capability
> >
> > would reproduce the issue?

Just to clarify, when one just has:

cat /sys/kernel/security/lsm
capability

call_int_hook would return the IRC (i.e 1) which would lead the code
to the capability check. (i.e. cap_inode_removexattr)

ret = call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name);
if (ret == 1)
    ret = cap_inode_removexattr(mnt_userns, dentry, name);

cap_inode_removexattr restricts setting security.* xattrs to only CAP_SYS_ADMIN.

Now, since BPF's hook returns 0 here, the capability check is skipped.

But then again, this is just one of the hooks which has the issue.




> > what am I missing?
>
> capability does not define the inode_removexattr LSM hook:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/commoncap.c#n1449
>
> It's only when the return value of the hook is 1, it checks for
> cap_inode_removexattr.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/security.c#n1408
>
> Only 3 LSMs define the hook (bpf, smack and selinux):
>
> fgrep -R LSM_HOOK_INIT *  | grep inode_removexattr
> selinux/hooks.c: LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
> smack/smack_lsm.c: LSM_HOOK_INIT(inode_removexattr, smack_inode_removexattr),
>
> The BPF LSM default hooks intend to provide no side-effects when the
> LSM is enabled and
> for the hooks that the patch updates, there is a side-effect.
