Return-Path: <bpf+bounces-4121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC9748FF9
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BA61C20BF4
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 21:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0D156EA;
	Wed,  5 Jul 2023 21:39:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0367134C5
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:39:00 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E7F1998;
	Wed,  5 Jul 2023 14:38:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so20745e9.1;
        Wed, 05 Jul 2023 14:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688593136; x=1691185136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2I0VJr35Z/Q2tTn0hViB65Znz9W/ziy02XlIsMkjvc=;
        b=dKieTbs8RvKcL8Sc7i8rk6auEIvOPxdNUZAR6TGW8ikDlAwS4EOoXXTQUJbobmPnh7
         BixtizUzgBqTnbm7lJClw3A4jo5vlZyMJBCz+9KKupr06eusou38qyo8DwiLPiM9VJuM
         A3yNeTDEkEOZC6aR9kmDyUIG92nZ7TcvJw0FQ1cAMriQUHfGkFPIIun3yNWbthItZsmc
         NM9kVatyV6DbybBVBPkCeYCL6k30TBVGSKinBaai7MaJZwFheOhH1OGbSCPJ+wqghwBj
         o/bZxBi+TM970TTFnAFTdEwfmcn4rFj4DJ1B8gX25UCH8ks1Jny7nDStN72Ic/L8UtKI
         y1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593136; x=1691185136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2I0VJr35Z/Q2tTn0hViB65Znz9W/ziy02XlIsMkjvc=;
        b=PX8aEJWARc6OcXna8YlpRjIdslzxWILKq9yyju9yvQ3H2mDKSC11dOXyEOgaq3ays4
         jd7wyZqzvUe3BdW1jhl+rtiDx6GtIFUAiUCBXIaVSgd14YxpaHDr//ehiLUTDHO22tgf
         FuS4GRrCgRYTJgN7fsyjpXydrecMTX+Y9GWHF8PKcBJpeB+yeNxbzBAwZI9FItD+RaMF
         ZWE5cR35w3YexVvZnskw8/PfO5yw20uSHRqownR6sqRGyQ8WveFjjYCJK0apQUGtQY/7
         ri4Yaez1KcY4hSnmtlrLmFlIS3hPZeyZPLh9uVRTrYA4fhHP6ZBtAwTc11CA16qdWxZt
         ssWg==
X-Gm-Message-State: AC+VfDxWLjkzlQbl1WswNiQaXyr5q6/LoAJ+Jk2Ug3I27JUU1Q3rDKaX
	5Ag9wT9B0r/2OvwmpKre3bOuOPSRLge7Mo8lDrHp6oKWUyyusQ==
X-Google-Smtp-Source: ACHHUZ6xYLwn/pNc9ujh4axXDY35Lw8onVjSi5U4YXZtK62qL69GnnzBcK9GOFvfPaq9WkgA4lJVVGMya/Z30STHhJY=
X-Received: by 2002:a05:600c:ac6:b0:3fb:b3aa:1c88 with SMTP id
 c6-20020a05600c0ac600b003fbb3aa1c88mr14494911wmr.26.1688593136118; Wed, 05
 Jul 2023 14:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner> <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
In-Reply-To: <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jul 2023 14:38:43 -0700
Message-ID: <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 7:42=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Jul 05, 2023 at 10:16:13AM -0400, Paul Moore wrote:
> > On Tue, Jul 4, 2023 at 8:44=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > > On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> > > > Add new kind of BPF kernel object, BPF token. BPF token is meant to=
 to
> > > > allow delegating privileged BPF functionality, like loading a BPF
> > > > program or creating a BPF map, from privileged process to a *truste=
d*
> > > > unprivileged process, all while have a good amount of control over =
which
> > > > privileged operations could be performed using provided BPF token.
> > > >
> > > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, whic=
h
> > > > allows to create a new BPF token object along with a set of allowed
> > > > commands that such BPF token allows to unprivileged applications.
> > > > Currently only BPF_TOKEN_CREATE command itself can be
> > > > delegated, but other patches gradually add ability to delegate
> > > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > > >
> > > > The above means that new BPF tokens can be created using existing B=
PF
> > > > token, if original privileged creator allowed BPF_TOKEN_CREATE comm=
and.
> > > > New derived BPF token cannot be more powerful than the original BPF
> > > > token.
> > > >
> > > > Importantly, BPF token is automatically pinned at the specified loc=
ation
> > > > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_P=
IN
> > > > command, unlike BPF prog/map/btf/link. This provides more control o=
ver
> > > > unintended sharing of BPF tokens through pinning it in another BPF =
FS
> > > > instances.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > >
> > > The main issue I have with the token approach is that it is a complet=
ely
> > > separate delegation vector on top of user namespaces. We mentioned th=
is
> > > duringthe conf and this was brought up on the thread here again as we=
ll.
> > > Imho, that's a problem both security-wise and complexity-wise.
> > >
> > > It's not great if each subsystem gets its own custom delegation
> > > mechanism. This imposes such a taxing complexity on both kernel- and
> > > userspace that it will quickly become a huge liability. So I would
> > > really strongly encourage you to explore another direction.

Alright, thanks a lot for elaborating. I did want to keep everything
contained to bpf() for various reasons, but it seems like I won't be
able to get away with this. :)

> > >
> > > I do think the spirit of your proposal is workable and that it can
> > > mostly be kept in tact.

It's good to know that at least conceptually you support the idea of
BPF delegation. I have a few more specific questions below and I'd
appreciate your answers, as I have less familiarity with how exactly
container managers do stuff at container bootstrapping stage.

But first, let's try to get some tentative agreement on design before
I go and implement the BPF-token-as-FS idea. I have basically just two
gripes with exact details of what you are proposing, so let me explain
which and why, and see if we can find some common ground.

First, the idea of coupling and bundling this "delegation" option with
BPF FS doesn't feel right. BPF FS is just a container of BPF objects,
so adding to it a new property of allowing to use privileged BPF
functionality seems a bit off.

Why not just create a new separate FS, let's code-name it "BPF Token
FS" for now (naming suggestions are welcome). Such BPF Token FS would
be dedicated to specifying everything about what's allowable through
BPF, just like my BPF token implementation. It can then be
mounted/bind-mounted inside BPF FS (or really, anywhere, it's just a
FS, right?). User application would open it (I'm guessing with
open_tree(), right?) and pass it as token_fd to bpf() syscall.

Having it as a separate single-purpose FS seems cleaner, because we
have use cases where we'd have one BPF FS instance created for a
container by our container manager, and then exposing a few separate
tokens with different sets of allowed functionality. E.g., one for
main intended workload, another for some BPF-based observability
tools, maybe yet another for more heavy-weight tools like bpftrace for
extra debugging. In the debugging case our container infrastructure
will be "evacuating" any other workloads on the same host to avoid
unnecessary consequences. The point is to not disturb
workload-under-human-debugging as much as possible, so we'd like to
keep userns intact, which is why mounting extra (more permissive) BPF
token inside already running containers is an important consideration.

With such goals, it seems nicer to have a single BPF FS, and few BPF
token FSs mounted inside it. Yes, we could bundle token functionality
with BPF FS, but separating those two seems cleaner to me. WDYT?

Second, mount options usage. I'm hearing stories from our production
folks how some new mount options (on some other FS, not BPF FS) were
breaking tools unintentionally during kernel/tooling
upgrades/downgrades, so it makes me a bit hesitant to have these
complicated sets of mount options to specify parameters of
BPF-token-as-FS. I've been thinking a bit, and I'm starting to lean
towards the idea of allowing to set up (and modify as well) all these
allowed maps/progs/attach types through special auto-created files
within BPF token FS. Something like below:

# pwd
/sys/fs/bpf/workload-token
# ls
allowed_cmds allowed_map_types allowed_prog_types allowed_attach_types
# echo "BPF_PROG_LOAD" > allowed_cmds
# echo "BPF_PROG_TYPE_KPROBE" >> allowed_prog_types
...
# cat allowed_prog_types
BPF_PROG_TYPE_KPROBE,BPF_PROG_TYPE_TRACEPOINT


The above is fake (I haven't implemented anything yet), but hopefully
works as a demonstration. We'll also need to make sure that inside
non-init userns these files are read-only or allow to just further
restrict the subset of allowed functionality, never extend it.

Such an approach will actually make it simpler to test and experiment
with this delegation locally, will make it trivial to observe what's
allowed from simple shell scripts, etc, etc. With fsmount() and O_PATH
it will be possible to set everything up from privileged processes
before ever exposing a BPF Token FS instance through a file system, if
there are any concerns about racing with user space.

That's the high-level approach I'm thinking of right now. Would that
work? How critical is it to reuse BPF FS itself and how important to
you is to rely on mount options vs special files as described above?
Hopefully not critical, and I can start working on it, and we'll get
what you want with using FS as a vehicle for delegation, while
allowing some of the intended use cases that we have in mind in a bit
cleaner fashion?

> > >
> > > As mentioned before, bpffs has all the means to be taught delegation:
> > >
> > >         // In container's user namespace
> > >         fd_fs =3D fsopen("bpffs");
> > >
> > >         // Delegating task in host userns (systemd-bpfd whatever you =
want)
> > >         ret =3D fsconfig(fd_fs, FSCONFIG_SET_FLAG, "delegate", ...);
> > >
> > >         // In container's user namespace
> > >         fd_mnt =3D fsmount(fd_fs, 0);
> > >
> > >         ret =3D move_mount(fd_fs, "", -EBADF, "/my/fav/location", MOV=
E_MOUNT_F_EMPTY_PATH)
> > >
> > > Roughly, this would mean:
> > >
> > > (i) raise FS_USERNS_MOUNT on bpffs but guard it behind the "delegate"
> > >     mount option. IOW, it's only possibly to mount bpffs as an
> > >     unprivileged user if a delegating process like systemd-bpfd with
> > >     system-level privileges has marked it as delegatable.

Regarding the FS_USERNS_MOUNT flag and fsopen() happening from inside
the user namespace. Am I missing something subtle and important here,
why does it have to happen inside the container's user namespace?
Can't the container manager both fsopen() and fsconfig() everything in
host userns, and only then fsmount+move_mount inside the container's
userns? Just trying to understand if there is some important early
association of userns happening at early steps here?

Also, in your example above, move_mount() should take fd_mnt, not fd_fs, ri=
ght?

> > > (ii) add fine-grained delegation options that you want this
> > >      bpffs instance to allow via new mount options. Idk,
> > >
> > >      // allow usage of foo
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "foo");
> > >
> > >      // also allow usage of bar
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "bar");
> > >
> > >      // reset allowed options
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "");
> > >
> > >      // allow usage of schmoo
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "schmoo");
> > >
> > > This all seems more intuitive and integrates with user and mount
> > > namespaces of the container. This can also work for restricting
> > > non-userns bpf instances fwiw. You can also share instances via
> > > bind-mount and so on. The userns of the bpffs instance can also be us=
ed
> > > for permission checking provided a given functionality has been
> > > delegated by e.g., systemd-bpfd or whatever.
> >
> > I have no arguments against any of the above, and would prefer to see
> > something like this over a token-based mechanism.  However we do want
> > to make sure we have the proper LSM control points for either approach
> > so that admins who rely on LSM-based security policies can manage
> > delegation via their policies.
> >
> > Using the fsconfig() approach described by Christian above, I believe
> > we should have the necessary hooks already in
> > security_fs_context_parse_param() and security_sb_mnt_opts() but I'm
> > basing that on a quick look this morning, some additional checking
> > would need to be done.
>
> I think what I outlined is even unnecessarily complicated. You don't
> need that pointless "delegate" mount option at all actually. Permission
> to delegate shouldn't be checked when the mount option is set. The
> permissions should be checked when the superblock is created. That's the
> right point in time. So sm like:
>

I think this gets even more straightforward with BPF Token FS being a
separate one, right? Given BPF Token FS is all about delegation, it
has to be a privileged operation to even create it.

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 4174f76133df..a2eb382f5457 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -746,6 +746,13 @@ static int bpf_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
>         struct inode *inode;
>         int ret;
>
> +       /*
> +        * If you want to delegate this instance then you need to be
> +        * privileged and know what you're doing. This isn't trust.
> +        */
> +       if ((fc->user_ns !=3D &init_user_ns) && !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
>         ret =3D simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
>         if (ret)
>                 return ret;
> @@ -800,6 +807,7 @@ static struct file_system_type bpf_fs_type =3D {
>         .init_fs_context =3D bpf_init_fs_context,
>         .parameters     =3D bpf_fs_parameters,
>         .kill_sb        =3D kill_litter_super,
> +       .fs_flags       =3D FS_USERNS_MOUNT,

Just an aside thought. It doesn't seem like there is any reason why
BPF FS right now is not created with FS_USERNS_MOUNT, so (separately
from all this discussion) I suspect we can just make it
FS_USERNS_MOUNT right now (unless we combine it with BPF-token-FS,
then yeah, we can't do that unconditionally anymore). Given BPF FS is
just a container of pinned BPF objects, just mounting BPF FS doesn't
seem to be dangerous in any way. But that's just an aside thought
here.

>  };
>
>  static int __init bpf_init(void)
>
> In fact this is conceptually generalizable but I'd need to think about
> that.

