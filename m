Return-Path: <bpf+bounces-9684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5DE79AB10
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 21:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B3628121B
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB315ACF;
	Mon, 11 Sep 2023 19:20:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD140156DB
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 19:20:49 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D92FB
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:20:46 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57361de8878so3019346eaf.0
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694460046; x=1695064846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGPsvpQjUEMIdQOzFdJ9vJo67U/s7GQIjWlcPJNV6YA=;
        b=fv8roNBXPi5mgYvP5vTbiP18A6RTDl7g58gwlasVDyy4GUpwipGyRjIZfuW+WdUiXa
         Xjyn+ZnTmGxJIztp5qRo18n1IWDnXy58kFRO8Z+j5HqRHVeB4Ezy/phcFGDZDERJW2dm
         FlFs9H0YsfhuX2DPlOvS+ALEdY5rWz+0xTZetqHa9rLTynx0/Oe69+GAXPpE2M2pgSdF
         eQmtjlslg506OnwPy3LLFzacIUJRpQ4nE5uIPogvq5k7Ev5X4/5gotgIlIcFYqU3Jwi/
         tvy0At/XRK7JU6RqqrEv2/T5NSUBsr0d3JXUyIq8XkPTWimiD3PReapds1YeUjsJnSwy
         kqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460046; x=1695064846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGPsvpQjUEMIdQOzFdJ9vJo67U/s7GQIjWlcPJNV6YA=;
        b=dbjpkDE9WYrVkKiJatvo7Wkby1kMQWRKkM/xOQ+ZtL1S/jnj8GaH5WAANP9Qb6ksYB
         XbH+zj4oqHdvSO6q8HaKpEMfE+BBbkM4RyqU8/eu2ZwTNsm9bUp/GbBAnFrv25/h1Xdk
         nwseUccl9noc9nZaAAUekWmZieg4cfzLQnb0SyrB6sO7HcpYnew/LLiIqbf+mGhAISnr
         2VYngQVtYy1ASkqcVpLQXC5O9+DyhpP73Ykjh3qxJkwu7JooBGAPVkjfTm90ur07Fud/
         YJjCtjh04sQ459SYTs2AiX2DikZERM+4IBjdQ1GtIiIcEz1uRLvjApnmv3bJlcmLmv7w
         +GhA==
X-Gm-Message-State: AOJu0YyGJWrmjgVDg6y5UnJKqglCHbNgpJH9oF7A1xvoCzDUWF2LUZ9p
	XDc85pp/Cv5I8qaZGg0gFbNxF3NNPKZNP6ciHHul
X-Google-Smtp-Source: AGHT+IH96yo1MzMdmWLefgxTsJbhc0nUrndVLDy3So17nfp7l4Zrw4DTX0vQ9IskY0ltFBWcnOEUGmtAq7DSUwfe5og=
X-Received: by 2002:a05:6870:2150:b0:1b7:3fd5:87cd with SMTP id
 g16-20020a056870215000b001b73fd587cdmr12282617oae.48.1694460046149; Mon, 11
 Sep 2023 12:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner> <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
 <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com> <20230904-harfe-haargenau-4c6cb31c304a@brauner>
In-Reply-To: <20230904-harfe-haargenau-4c6cb31c304a@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Sep 2023 15:20:35 -0400
Message-ID: <CAHC9VhRJ8iw7EXDqLdWEaj+EZSwHS0ytSWy+W-BoKVvw0EWA5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	=?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gyroidos@aisec.fraunhofer.de, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 4, 2023 at 7:44=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Tue, Aug 29, 2023 at 03:35:46PM +0200, Alexander Mikhalitsyn wrote:
> > On Fri, Aug 18, 2023 at 12:11=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 10:59:22AM +0200, Christian Brauner wrote:
> > > > On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Wei=C3=9F wrote:
> > > > > Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> > > > > which allows to set a cgroup device program to be a device guard.
> > > >
> > > > Currently we block access to devices unconditionally in may_open_de=
v().
> > > > Anything that's mounted by an unprivileged containers will get
> > > > SB_I_NODEV set in s_i_flags.
> > > >
> > > > Then we currently mediate device access in:
> > > >
> > > > * inode_permission()
> > > >   -> devcgroup_inode_permission()
> > > > * vfs_mknod()
> > > >   -> devcgroup_inode_mknod()
> > > > * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block=
 devices and friends
> > > >   -> devcgroup_check_permission()
> > > > * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu i=
nfo afaict
> > > >   -> devcgroup_check_permission()
> > > >
> > > > All your new flag does is to bypass that SB_I_NODEV check afaict an=
d let
> > > > it proceed to the devcgroup_*() checks for the vfs layer.
> > > >
> > > > But I don't get the semantics yet.
> > > > Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs=
 or
> > > > is that a flag on random bpf programs? It looks like it would be th=
e
> > > > latter but design-wise I would expect this to be a property of the
> > > > device program itself.
> > >
> > > Looks like patch 4 attemps to bypass usual permission checks with:
> > > @@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct =
inode *dir,
> > >         if (error)
> > >                 return error;
> > >
> > > -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> > > -           !capable(CAP_MKNOD))
> > > -               return -EPERM;
> > > +       /*
> > > +        * In case of a device cgroup restirction allow mknod in user
> > > +        * namespace. Otherwise just check global capability; thus,
> > > +        * mknod is also disabled for user namespace other than the
> > > +        * initial one.
> > > +        */
> > > +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
> > > +               if (devcgroup_task_is_guarded(current)) {
> > > +                       if (!ns_capable(current_user_ns(), CAP_MKNOD)=
)
> > > +                               return -EPERM;
> > > +               } else if (!capable(CAP_MKNOD))
> > > +                       return -EPERM;
> > > +       }
> > >
> >
> > Dear colleagues,
> >
> > > which pretty much sounds like authoritative LSM that was brought up i=
n the past
> > > and LSM folks didn't like it.
> >
> > Thanks for pointing this out, Alexei!
> > I've searched through the LKML archives and found a thread about this:
> > https://lore.kernel.org/all/CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PN=
WtD7eSUA@mail.gmail.com/
> >
> > As far as I understand, disagreement here is about a practice of
> > skipping kernel-built capability checks based
> > on LSM hooks, right?
> >
> > +CC Paul Moore <paul@paul-moore.com>
> >
> > >
> > > If vfs folks are ok with this special bypass of permissions in vfs_mk=
nod()
> > > we can talk about kernel->bpf api details.
> > > The way it's done with BPF_F_CGROUP_DEVICE_GUARD flag is definitely n=
o go,
> > > but no point going into bpf details now until agreement on bypass is =
made.
>
> Afaiu the original concern was specifically about an LSM allowing to
> bypass other LSMs or DAC permissions. But this wouldn't be the case
> here. The general inode access LSM permission mediation is separate from
> specific device access management: the security_inode_permission() LSM
> hook would still be called and thus LSMs restrictions would continue to
> apply exactly as they do now.
>
> For cgroup v1 device access management was a cgroup controller with
> management interface through files. It then was ported to an eBPF
> program attachable to cgroups for cgroup v2. Arguably, it should
> probably have been ported to an LSM hook or a separate LSM and untied
> from cgroups completely. The confusion here seems to indicate that that
> would have been the right way to go.
>
> Because right now device access management seems its own form of
> mandatory access control.

My apologies, I lost this thread in my inbox and I'm just reading it now.

Historically we haven't any real LSM controls around
cgroups/resource-management, but that is mostly because everything
that I recall being proposed has been very piecemeal and didn't
provide a comprehensive access control solution for resource
management.  If someone wanted to propose a proper set of access
control hooks for cgroups I think that is something we would be happy
to review, merge, etc.

Somewhat relatedly, we've been working on some docs around guidelines
for new LSM hooks; eventually the guidelines will work their way into
the kernel docs, but here they are now:

* https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm=
-hook-guidelines

--=20
paul-moore.com

