Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21572561A3E
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiF3MWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 08:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiF3MWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 08:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC504286C1
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 05:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45BB761CD0
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 12:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8C5C341CD
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 12:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656591728;
        bh=iTBWAumngEPJywWFUjSrouRUufjy8JuBUKn6ObMV4QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I1xPd4dii0UbD/IG93adwrJkVuDz2gAHU++qlripsds7GvBCphJ+m9l9v74CtbB1d
         Eebot8XDzqmMqIY7Kf6S1ulyRT/LxkeimTXEENRlZD1PVfX+t2SIxPDgakstTMYbvb
         elW0wirNKDJFEsRSfkkS70GSfKMxJxZpnY7Z5jVu+hN/411OgOSaCg627pfnGjQg3f
         jNgb3tcqZ1AdkXXWb1kHCWyUjx/6JOGTbvVkB/GNwAerW5D7wTJcMsd2yTFasdk0op
         rMdaO8gdFlEgFcSPWVzeTBYjFuIs6ELgJ7q0j25fN7LXc1OIOuui9QlmMyv/oQlm51
         XkNgvREic68nA==
Received: by mail-yb1-f174.google.com with SMTP id i7so33377386ybe.11
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 05:22:08 -0700 (PDT)
X-Gm-Message-State: AJIora8XT7lBysmE0/DLIqKAaqIqhRYW2HuBMk1qnyVhMZak+mAIhyri
        BvpGRJNdf7XjsgKAqAGsuhcXQBUdaB3oauP0JH05ow==
X-Google-Smtp-Source: AGRyM1tprl3miqEFYbLSzyVmJ3icV8xah3FFr/R1wGp49TxCMFk/zA/kWWFQfL5jlpRrU+F1iesZirBL2juSB3Y+Yz0=
X-Received: by 2002:a25:9a48:0:b0:669:b51a:5b8d with SMTP id
 r8-20020a259a48000000b00669b51a5b8dmr9158672ybo.404.1656591727605; Thu, 30
 Jun 2022 05:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628161948.475097-6-kpsingh@kernel.org>
 <20220628173344.h7ihvyl6vuky5xus@wittgenstein> <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
 <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
 <20220629081119.ddqvfn3al36fl27q@wittgenstein> <20220629095557.oet6u2hi7msit6ff@wittgenstein>
 <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com> <20220630114549.uakuocpn7w5jfrz2@wittgenstein>
In-Reply-To: <20220630114549.uakuocpn7w5jfrz2@wittgenstein>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 30 Jun 2022 14:21:56 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
Message-ID: <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 30, 2022 at 1:45 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Jun 29, 2022 at 08:02:50PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jun 29, 2022 at 2:56 AM Christian Brauner <brauner@kernel.org> wrote:

[...]

> > > > > > > >
> > > > > > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > > > > > ---
> > > > > > > >  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > +SEC("lsm.s/bprm_committed_creds")
> > > > > > > > +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > > > > > > > +{
> > > > > > > > +     struct task_struct *current = bpf_get_current_task_btf();
> > > > > > > > +     char dir_xattr_value[64] = {0};
> > > > > > > > +     int xattr_sz = 0;
> > > > > > > > +
> > > > > > > > +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > > > > > > > +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> > > > > > > > +                             dir_xattr_value, 64);
> > > > > > >
> > > > > > > Yeah, this isn't right. You're not accounting for the caller's userns
> > > > > > > nor for the idmapped mount. If this is supposed to work you will need a
> > > > > > > variant of vfs_getxattr() that takes the mount's idmapping into account
> > > > > > > afaict. See what needs to happen after do_getxattr().
> > > > > >
> > > > > > Thanks for taking a look.
> > > > > >

[...]

> > > > >
> > > > > That will not be correct.
> > > > > posix_acl_fix_xattr_to_user checking current_user_ns()
> > > > > is checking random tasks that happen to be running
> > > > > when lsm hook got invoked.
> > > > >
> > > > > KP,
> > > > > we probably have to document clearly that neither 'current*'
> > > > > should not be used here.
> > > > > xattr_permission also makes little sense in this context.
> > > > > If anything it can be a different kfunc if there is a use case,
> > > > > but I don't see it yet.
> > > > > bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
> > > > > call it directly. It's the kernel that is doing its security thing.
> > > >
> > > > Right, but LSMs usually only retrieve their own xattr namespace (ima,
> > > > selinux, smack) or they calculate hashes for xattrs based on the raw
> > > > filesystem xattr values (evm).
> > > >
> > > > But this new bpf_getxattr() is different. It allows to retrieve _any_
> > > > xattr in any security hook it can be attached to. So someone can write a
> > > > bpf program that retrieves filesystem capabilites or posix acls. And
> > > > these are xattrs that require higher-level vfs involvement to be
> > > > sensible in most contexts.
> > > >

[...]

> > > >
> > > > This hooks a bpf-lsm program to the security_bprm_committed_creds()
> > > > hook. It then retrieves the extended attributes of the file to be
> > > > executed. The hook currently always retrieves the raw filesystem values.
> > > >
> > > > But for example any XATTR_NAME_CAPS filesystem capabilities that
> > > > might've been stored will be taken into account during exec. And both
> > > > the idmapping of the mount and the caller matter when determing whether
> > > > they are used or not.
> > > >
> > > > But the current implementation of bpf_getxattr() just ignores both. It
> > > > will always retrieve the raw filesystem values. So if one invokes this
> > > > hook they're not actually retrieving the values as they are seen by
> > > > fs/exec.c. And I'm wondering why that is ok? And even if this is ok for
> > > > some use-cases it might very well become a security issue in others if
> > > > access decisions are always based on the raw values.
> > > >
> > > > I'm not well-versed in this so bear with me, please.
> > >
> > > If this is really just about retrieving the "security.bpf" xattr and no
> > > other xattr then the bpf_getxattr() variant should somehow hard-code
> > > that to ensure that no other xattrs can be retrieved, imho.
> >
> > All of these restrictions look very artificial to me.
> > Especially the part "might very well become a security issue"
> > just doesn't click.
> > We're talking about bpf-lsm progs here that implement security.
> > Can somebody implement a poor bpf-lsm that doesn't enforce
> > any actual security? Sure. It's a code.
>
> The point is that with the current implementation of bpf_getxattr() you
> are able to retrieve any xattrs and we have way less control over a
> bpf-lsm program than we do over selinux which a simple git grep
> __vfs_getxattr() is all we need.
>
> The thing is that with bpf_getxattr() as it stands it is currently
> impossible to retrieve xattr values - specifically filesystem
> capabilities and posix acls - and see them exactly like the code you're
> trying to supervise is. And that seems very strange from a security
> perspective. So if someone were to write
>
> SEC("lsm.s/bprm_creds_from_file")
> void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> {
>         struct task_struct *current = bpf_get_current_task_btf();
>
>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>                                 bprm->file->f_path.dentry->d_inode,
>                                 XATTR_NAME_POSIX_ACL_ACCESS, ..);
>         // or
>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>                                 bprm->file->f_path.dentry->d_inode,
>                                 XATTR_NAME_CAPS, ..);
>
> }
>
> they'd get the raw nscaps and the raw xattrs back. But now, as just a
> tiny example, the nscaps->rootuid and the ->e_id fields in the posix
> ACLs make zero sense in this context.
>
> And what's more there's no way for the bpf-lsm program to turn them into
> something that makes sense in the context of the hook they are retrieved
> in. It lacks all the necessary helpers to do so afaict.
>
> > No one complains about the usage of EXPORT_SYMBOL(__vfs_getxattr)
> > in the existing LSMs like selinux.
>
> Selinux only cares about its own xattr namespace. It doesn't retrieve
> fscaps or posix acls and it's not possible to write selinux programs
> that do so. With the bpf-lsm that's very much possible.
>
> And if we'd notice selinux would start retrieving random xattrs we'd ask
> the same questions we do here.
>
> > No one complains about its usage in out of tree LSMs.
> > Is that a security issue? Of course not.
> > __vfs_getxattr is a kernel mechanism that LSMs use to implement
> > the security features they need.
> > __vfs_getxattr as kfunc here is pretty much the same as EXPORT_SYMBOL
> > with a big difference that it's EXPORT_SYMBOL_GPL.
> > BPF land doesn't have an equivalent of non-gpl export and is not going
> > to get one.

I want to reiterate what Alexei is saying here:

*Please* consider this as a simple wrapper around __vfs_getxattr
with a limited attach surface and extra verification checks and
and nothing else.

What you are saying is __vfs_getxattr does not make sense in some
contexts. But kernel modules can still use it right?

The user is implementing an LSM, if they chose to do things that don't make
sense, then they can surely cause a lot more harm:

SEC("lsm/bprm_check_security")
int BPF_PROG(bprm_check, struct linux_binprm *bprm)
{
     return -EPERM;
}

>
> This discussion would probably be a lot shorter if this series were sent
> with a proper explanation of how this supposed to work and what it's
> used for.

It's currently scoped to BPF LSM (albeit limited to LSM for now)
but it won't just be used in LSM programs but some (allow-listed)
tracing programs too.

We want to leave the flexibility to the implementer of the LSM hooks. If the
implementer choses to retrieve posix_acl_* we can also expose
posix_acl_fix_xattr_to_user or a different kfunc that adds this logic too
but that would be a separate kfunc (and a separate use-case).

>
> A series without a cover letter and no detailed explanation in the
> commit messages makes it quite hard to understand whether what is asked
> can be acked or not.

As I mentioned in

https://lore.kernel.org/bpf/CACYkzJ70uqVJr5EnM0i03Lu+zkuSsXOXcOLQoUS6HZPqH=skpQ@mail.gmail.com/T/#m74f32bae800a97d5c2caf08cee4199d3ba48d76c

I will resend with a cover letter that has more details.

>
> I'm just adding Serge and Casey to double-check here as the LSM stuff is
> more up their alley. I can just look at this from the perspective of a
> vfs person.
>
> If you have your eBPF meeting thing I'm also happy to jump on there next

Sure, we can discuss this during BPF office hours next week.


> week to get more context.
