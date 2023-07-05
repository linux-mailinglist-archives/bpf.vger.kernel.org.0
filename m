Return-Path: <bpf+bounces-4063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95006748691
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D52F1C20B21
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E7411188;
	Wed,  5 Jul 2023 14:42:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFB6FA1
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 14:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777E2C433C7;
	Wed,  5 Jul 2023 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688568128;
	bh=8VcDi3ZI5V+OQAMc+CzdnI+vI1LgcTk36dHd1nbvhQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WI73b9TcWqscq/755RwZV6jIcQiySEOvMw/3q41hROL+z4meTlIX2w3kJvLfIQic6
	 TCEmdQxoQMqIUlld6ilGvsrTP4Mqr69a7PztHx/qVtLoGyoJfJu3D4ydJcUOkRlohs
	 BePWJTeZZHirkeHwjassWJf1twrR5hBvsKSmrAPdHKLZp3Irktbcs92KSYnaEMB6TZ
	 b1YhrN04X7WIKMt/pw/WBWOfB6tvAUL/C+7w/T3OJTrrkSDzxCq7twChs8EasgIQV1
	 hQ+r+CR4z47yvgh2r+siGnYq8CowFIwhjgW7JjmiQgfYN7PBgQAZvBukO8ilpC9J2i
	 BzO96Hf1IqBtw==
Date: Wed, 5 Jul 2023 16:42:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
Message-ID: <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>

On Wed, Jul 05, 2023 at 10:16:13AM -0400, Paul Moore wrote:
> On Tue, Jul 4, 2023 at 8:44 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> > > Add new kind of BPF kernel object, BPF token. BPF token is meant to to
> > > allow delegating privileged BPF functionality, like loading a BPF
> > > program or creating a BPF map, from privileged process to a *trusted*
> > > unprivileged process, all while have a good amount of control over which
> > > privileged operations could be performed using provided BPF token.
> > >
> > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> > > allows to create a new BPF token object along with a set of allowed
> > > commands that such BPF token allows to unprivileged applications.
> > > Currently only BPF_TOKEN_CREATE command itself can be
> > > delegated, but other patches gradually add ability to delegate
> > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > >
> > > The above means that new BPF tokens can be created using existing BPF
> > > token, if original privileged creator allowed BPF_TOKEN_CREATE command.
> > > New derived BPF token cannot be more powerful than the original BPF
> > > token.
> > >
> > > Importantly, BPF token is automatically pinned at the specified location
> > > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
> > > command, unlike BPF prog/map/btf/link. This provides more control over
> > > unintended sharing of BPF tokens through pinning it in another BPF FS
> > > instances.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > The main issue I have with the token approach is that it is a completely
> > separate delegation vector on top of user namespaces. We mentioned this
> > duringthe conf and this was brought up on the thread here again as well.
> > Imho, that's a problem both security-wise and complexity-wise.
> >
> > It's not great if each subsystem gets its own custom delegation
> > mechanism. This imposes such a taxing complexity on both kernel- and
> > userspace that it will quickly become a huge liability. So I would
> > really strongly encourage you to explore another direction.
> >
> > I do think the spirit of your proposal is workable and that it can
> > mostly be kept in tact.
> >
> > As mentioned before, bpffs has all the means to be taught delegation:
> >
> >         // In container's user namespace
> >         fd_fs = fsopen("bpffs");
> >
> >         // Delegating task in host userns (systemd-bpfd whatever you want)
> >         ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "delegate", ...);
> >
> >         // In container's user namespace
> >         fd_mnt = fsmount(fd_fs, 0);
> >
> >         ret = move_mount(fd_fs, "", -EBADF, "/my/fav/location", MOVE_MOUNT_F_EMPTY_PATH)
> >
> > Roughly, this would mean:
> >
> > (i) raise FS_USERNS_MOUNT on bpffs but guard it behind the "delegate"
> >     mount option. IOW, it's only possibly to mount bpffs as an
> >     unprivileged user if a delegating process like systemd-bpfd with
> >     system-level privileges has marked it as delegatable.
> > (ii) add fine-grained delegation options that you want this
> >      bpffs instance to allow via new mount options. Idk,
> >
> >      // allow usage of foo
> >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "foo");
> >
> >      // also allow usage of bar
> >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "bar");
> >
> >      // reset allowed options
> >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "");
> >
> >      // allow usage of schmoo
> >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "schmoo");
> >
> > This all seems more intuitive and integrates with user and mount
> > namespaces of the container. This can also work for restricting
> > non-userns bpf instances fwiw. You can also share instances via
> > bind-mount and so on. The userns of the bpffs instance can also be used
> > for permission checking provided a given functionality has been
> > delegated by e.g., systemd-bpfd or whatever.
> 
> I have no arguments against any of the above, and would prefer to see
> something like this over a token-based mechanism.  However we do want
> to make sure we have the proper LSM control points for either approach
> so that admins who rely on LSM-based security policies can manage
> delegation via their policies.
> 
> Using the fsconfig() approach described by Christian above, I believe
> we should have the necessary hooks already in
> security_fs_context_parse_param() and security_sb_mnt_opts() but I'm
> basing that on a quick look this morning, some additional checking
> would need to be done.

I think what I outlined is even unnecessarily complicated. You don't
need that pointless "delegate" mount option at all actually. Permission
to delegate shouldn't be checked when the mount option is set. The
permissions should be checked when the superblock is created. That's the
right point in time. So sm like:

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..a2eb382f5457 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -746,6 +746,13 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
        struct inode *inode;
        int ret;

+       /*
+        * If you want to delegate this instance then you need to be
+        * privileged and know what you're doing. This isn't trust.
+        */
+       if ((fc->user_ns != &init_user_ns) && !capable(CAP_SYS_ADMIN))
+               return -EPERM;
+
        ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
        if (ret)
                return ret;
@@ -800,6 +807,7 @@ static struct file_system_type bpf_fs_type = {
        .init_fs_context = bpf_init_fs_context,
        .parameters     = bpf_fs_parameters,
        .kill_sb        = kill_litter_super,
+       .fs_flags       = FS_USERNS_MOUNT,
 };

 static int __init bpf_init(void)

In fact this is conceptually generalizable but I'd need to think about
that.

