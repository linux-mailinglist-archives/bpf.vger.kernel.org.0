Return-Path: <bpf+bounces-9182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0579165B
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 13:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262191C20329
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 11:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57F4433;
	Mon,  4 Sep 2023 11:44:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008C3FF9
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 11:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F5BC433C7;
	Mon,  4 Sep 2023 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693827867;
	bh=fYR3tc02KRKsQWWGmBLxr9JQRojGSNYY9TDLjFmJUSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bltXaApYnLmdRt6ZqB6BIbyO2XcnmQKbtZMC+OGux2/kbAyHo1+a6SkQ54MopeAtm
	 ospAwLs0JrnreoYGzUN4pc4OjZUNLtu79pEdr4WvHhoWzUn9zcVABhNkmws4cKa47g
	 kMxiR+ftLWeVisIYTpn5HCEc8JOn7gTeFVqbmZXgVuRqijO7oExyjOki4NxC3Mcaww
	 pPs22gl6fdJ5Ip9bMFpoMDGLWr5Lm6rFbiKRw+kDGtk3leZT+PekUYlKBKjM3igFIf
	 UovfihIZqpC8zQTtfCvBheaW3vENIofypxiEPEIJ+QeRpm2fgqiN09IO+YmD5w9XRk
	 BwijyodYuu4yw==
Date: Mon, 4 Sep 2023 13:44:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de, paul@paul-moore.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Message-ID: <20230904-harfe-haargenau-4c6cb31c304a@brauner>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner>
 <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
 <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com>

On Tue, Aug 29, 2023 at 03:35:46PM +0200, Alexander Mikhalitsyn wrote:
> On Fri, Aug 18, 2023 at 12:11 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Aug 15, 2023 at 10:59:22AM +0200, Christian Brauner wrote:
> > > On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Weiß wrote:
> > > > Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> > > > which allows to set a cgroup device program to be a device guard.
> > >
> > > Currently we block access to devices unconditionally in may_open_dev().
> > > Anything that's mounted by an unprivileged containers will get
> > > SB_I_NODEV set in s_i_flags.
> > >
> > > Then we currently mediate device access in:
> > >
> > > * inode_permission()
> > >   -> devcgroup_inode_permission()
> > > * vfs_mknod()
> > >   -> devcgroup_inode_mknod()
> > > * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
> > >   -> devcgroup_check_permission()
> > > * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
> > >   -> devcgroup_check_permission()
> > >
> > > All your new flag does is to bypass that SB_I_NODEV check afaict and let
> > > it proceed to the devcgroup_*() checks for the vfs layer.
> > >
> > > But I don't get the semantics yet.
> > > Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
> > > is that a flag on random bpf programs? It looks like it would be the
> > > latter but design-wise I would expect this to be a property of the
> > > device program itself.
> >
> > Looks like patch 4 attemps to bypass usual permission checks with:
> > @@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> >         if (error)
> >                 return error;
> >
> > -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> > -           !capable(CAP_MKNOD))
> > -               return -EPERM;
> > +       /*
> > +        * In case of a device cgroup restirction allow mknod in user
> > +        * namespace. Otherwise just check global capability; thus,
> > +        * mknod is also disabled for user namespace other than the
> > +        * initial one.
> > +        */
> > +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
> > +               if (devcgroup_task_is_guarded(current)) {
> > +                       if (!ns_capable(current_user_ns(), CAP_MKNOD))
> > +                               return -EPERM;
> > +               } else if (!capable(CAP_MKNOD))
> > +                       return -EPERM;
> > +       }
> >
> 
> Dear colleagues,
> 
> > which pretty much sounds like authoritative LSM that was brought up in the past
> > and LSM folks didn't like it.
> 
> Thanks for pointing this out, Alexei!
> I've searched through the LKML archives and found a thread about this:
> https://lore.kernel.org/all/CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PNWtD7eSUA@mail.gmail.com/
> 
> As far as I understand, disagreement here is about a practice of
> skipping kernel-built capability checks based
> on LSM hooks, right?
> 
> +CC Paul Moore <paul@paul-moore.com>
> 
> >
> > If vfs folks are ok with this special bypass of permissions in vfs_mknod()
> > we can talk about kernel->bpf api details.
> > The way it's done with BPF_F_CGROUP_DEVICE_GUARD flag is definitely no go,
> > but no point going into bpf details now until agreement on bypass is made.

Afaiu the original concern was specifically about an LSM allowing to
bypass other LSMs or DAC permissions. But this wouldn't be the case
here. The general inode access LSM permission mediation is separate from
specific device access management: the security_inode_permission() LSM
hook would still be called and thus LSMs restrictions would continue to
apply exactly as they do now.

For cgroup v1 device access management was a cgroup controller with
management interface through files. It then was ported to an eBPF
program attachable to cgroups for cgroup v2. Arguably, it should
probably have been ported to an LSM hook or a separate LSM and untied
from cgroups completely. The confusion here seems to indicate that that
would have been the right way to go.

Because right now device access management seems its own form of
mandatory access control.

