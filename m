Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18DF54595B
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 02:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbiFJAzu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 20:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiFJAzu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 20:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC444D634
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 17:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE714612EA
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 00:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60646C3411E
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 00:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654822548;
        bh=tPPcB6qg2ZDplGPe5r34eX0A1FBrYHTtZQ+pNqpv4cA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rN5vKZT7vMn0D59pBjQMR6mer6VECxTn1hYov3KEh5snnj1z7CwMg13lMNf9o7IUA
         lF9I8W0oA15/RX9rX7hvXCCv6D4Gl/uuANjLnuDTJt36EPbFmvkXNUfMUw3eIyRTqQ
         KPez9+0cjELSSt72zYM5K+D/Lp0VG4PW3Z/U4PGvGDcTkxetZJyTohPfopkrwDUQJ5
         874N91QIlhffz1T9+T+DvffzZLX8R8lnFhW/tw8vQlh8uWmCcaMqLiAXD2pvRPgWVq
         zEzffesV+lvotIb7YSb5M59646RksweW82+DEAsqhuW5kQVqkgpxB8TMt0GCCplgPT
         mm5MjSG1/tlAA==
Received: by mail-yb1-f172.google.com with SMTP id s39so16975329ybi.0
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 17:55:48 -0700 (PDT)
X-Gm-Message-State: AOAM531s+y3NlgBbLsB3x8PmdH2K3F0J4jKPThpTqmynl8QhHsJmK29Z
        EcQs9rg6t2kg/RG4sGjxvW8jGftcyduwla8RdVvneQ==
X-Google-Smtp-Source: ABdhPJyUNbhO6WzB5L/SFE1CmuOEdZh1ZSad2If7CbByV6A9zwXVh1jSuEqwGjwBpyNA794D0lNgL1YDOJF2KTfy2ZM=
X-Received: by 2002:a5b:10b:0:b0:654:74c1:61cf with SMTP id
 11-20020a5b010b000000b0065474c161cfmr43467397ybx.42.1654822547386; Thu, 09
 Jun 2022 17:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220609234601.2026362-1-kpsingh@kernel.org> <CAADnVQJSijXmDG0C+U101ahgOYTmHEuyBu_=CS87rJ9GchFQyA@mail.gmail.com>
In-Reply-To: <CAADnVQJSijXmDG0C+U101ahgOYTmHEuyBu_=CS87rJ9GchFQyA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 10 Jun 2022 02:55:36 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4L=SxggPxrqEC1yzv-DzM1-w0ZPo-E1HPE-8ob-r0UTw@mail.gmail.com>
Message-ID: <CACYkzJ4L=SxggPxrqEC1yzv-DzM1-w0ZPo-E1HPE-8ob-r0UTw@mail.gmail.com>
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

On Fri, Jun 10, 2022 at 2:44 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 9, 2022 at 4:46 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > BPF LSM currently has a default implementation for each LSM hooks which
> > return a default value defined in include/linux/lsm_hook_defs.h. These
> > hooks should have no functional effect when there is no BPF program
> > loaded to implement the hook logic.
> >
> > Some LSM hooks treat any return value of the hook as policy decision
> > which results in destructive side effects.
> >
> > This issue and the effects were reported to me by Jann Horn:
> >
> > For a system configured with CONFIG_BPF_LSM and the bpf lsm is enabled
> > (via lsm= or CONFIG_LSM) an unprivileged user can vandalize the system
> > by removing the security.capability xattrs from binaries, preventing
> > them from working normally:
> >
> > $ getfattr -d -m- /bin/ping
> > getfattr: Removing leading '/' from absolute path names
> > security.capability=0sAQAAAgAgAAAAAAAAAAAAAAAAAAA=
> >
> > $ setfattr -x security.capability /bin/ping
> > $ getfattr -d -m- /bin/ping
> > $ ping 1.2.3.4
> > $ ping google.com
> > $ echo $?
> > 2
> >
> > The above reproduces with:
> >
> > cat /sys/kernel/security/lsm
> > capability,apparmor,bpf
>
> Why is this bpf related?
> apparmor doesn't have that hook,
> while capability returns 0.
> So bpf's default==0 doesn't change the situation.
>
> Just
> cat /sys/kernel/security/lsm
> capability
>
> would reproduce the issue?
> what am I missing?

capability does not define the inode_removexattr LSM hook:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/commoncap.c#n1449

It's only when the return value of the hook is 1, it checks for
cap_inode_removexattr.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/security.c#n1408

Only 3 LSMs define the hook (bpf, smack and selinux):

fgrep -R LSM_HOOK_INIT *  | grep inode_removexattr
selinux/hooks.c: LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
smack/smack_lsm.c: LSM_HOOK_INIT(inode_removexattr, smack_inode_removexattr),

The BPF LSM default hooks intend to provide no side-effects when the
LSM is enabled and
for the hooks that the patch updates, there is a side-effect.
