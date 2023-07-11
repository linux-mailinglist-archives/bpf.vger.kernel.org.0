Return-Path: <bpf+bounces-4805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C6A74FA9F
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 00:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1B41C20DFC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 22:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513F1ED3F;
	Tue, 11 Jul 2023 22:06:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068A1DDEE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 22:06:24 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666071705;
	Tue, 11 Jul 2023 15:06:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so9814848e87.1;
        Tue, 11 Jul 2023 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689113179; x=1691705179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Syi4ocZDJ/NQjVPRcQ3DBduQ2/GqzDZqG6uuH+Ek4c=;
        b=BlgiXZUsP0BOpt+i7061H3LNgkMnstpFp/hMNNQRhewUSYA5iSe/YkC5jbO+ly97Kd
         ed/9dwhYzsX15tl1F1YBv8PPmuapqJ67Xr/QFAkyH+mKHmcsi6itvInxdIAN9KxGUBn7
         UFxY+tENyNAhbe4y71SnEuWN4+0CfAwWvx3PrY6pI8m4Uz0dIGZi7/nd2W7g8qdvYejm
         qxEsVYu1GgMYnM7tQnJ5vliqev+vu+mQZ5VjyGDx3JnM5Q+Jar9uQsPovcdccRvmIo/o
         1Uwq6bTZs7xdKtyoJqYMzJU0BluKw/kyq0sZ7kwnVr4M9DVztlp1Yny5+OWy+zQlh/gm
         Np0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689113179; x=1691705179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Syi4ocZDJ/NQjVPRcQ3DBduQ2/GqzDZqG6uuH+Ek4c=;
        b=SDAgV2fWvdZlWU5sYbEMOG4FcOllW4ZRMRNYZWxrnb2So1XWIX5HvDiGz67uYBh9ub
         XZZVnGfPVVPTUUq9+Ur69ZvAg8Ia47SX1O1mFN0J0tEp7TM+bvbViU9VqJtKZj4hHSY1
         u/ABT+fhqtA+W+dvjK74fctTrImiWi924km63JTiajsGuBLuYuTTh5MC9XmqR+5JtXJu
         w6qFmEXZ0IdDkQkguO2Zd2ur8U7riGISN+k4ZZx4ax0QekuxRFIhn78iraZNjuMKEK15
         ol3V9Hhb8lXJfl6YhadR/pBp7NE8hbzL7JQ5xzEGTK26OJOtCiAN9eaKjNTnndEaawVd
         JApw==
X-Gm-Message-State: ABy/qLbsMtWPlbDerbWKkoN8kPPI/plIDtpDEBQC0+28pPjzOuzXvBJ2
	/PPuh8Ho9rDWMxGmJiPJlg1EfdBXUz497tU9BIc=
X-Google-Smtp-Source: APBJJlHZVIxPXwAM+QRt/lhNVrhMbyW2r96bgtmeNJ0FEaz/VRMphynIozgDq5KOaobFWa3ry7xYSRXs7enCKl6i+zo=
X-Received: by 2002:a05:6512:3e0c:b0:4fb:bc46:7c09 with SMTP id
 i12-20020a0565123e0c00b004fbbc467c09mr17729770lfv.6.1689113179077; Tue, 11
 Jul 2023 15:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner> <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner> <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
 <20230711-zwerchfell-gegen-3d43b114ad13@brauner>
In-Reply-To: <20230711-zwerchfell-gegen-3d43b114ad13@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 15:06:06 -0700
Message-ID: <CAEf4BzatqxozceT=ZZp7UG3j4WLo2nEB9H92h7Udwk4AEYFKrw@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 6:33=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jul 05, 2023 at 02:38:43PM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 5, 2023 at 7:42=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Wed, Jul 05, 2023 at 10:16:13AM -0400, Paul Moore wrote:
> > > > On Tue, Jul 4, 2023 at 8:44=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > > > On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> > > > > > Add new kind of BPF kernel object, BPF token. BPF token is mean=
t to to
> > > > > > allow delegating privileged BPF functionality, like loading a B=
PF
> > > > > > program or creating a BPF map, from privileged process to a *tr=
usted*
> > > > > > unprivileged process, all while have a good amount of control o=
ver which
> > > > > > privileged operations could be performed using provided BPF tok=
en.
> > > > > >
> > > > > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, =
which
> > > > > > allows to create a new BPF token object along with a set of all=
owed
> > > > > > commands that such BPF token allows to unprivileged application=
s.
> > > > > > Currently only BPF_TOKEN_CREATE command itself can be
> > > > > > delegated, but other patches gradually add ability to delegate
> > > > > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > > > > >
> > > > > > The above means that new BPF tokens can be created using existi=
ng BPF
> > > > > > token, if original privileged creator allowed BPF_TOKEN_CREATE =
command.
> > > > > > New derived BPF token cannot be more powerful than the original=
 BPF
> > > > > > token.
> > > > > >
> > > > > > Importantly, BPF token is automatically pinned at the specified=
 location
> > > > > > inside an instance of BPF FS and cannot be repinned using BPF_O=
BJ_PIN
> > > > > > command, unlike BPF prog/map/btf/link. This provides more contr=
ol over
> > > > > > unintended sharing of BPF tokens through pinning it in another =
BPF FS
> > > > > > instances.
> > > > > >
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > ---
> > > > >
> > > > > The main issue I have with the token approach is that it is a com=
pletely
> > > > > separate delegation vector on top of user namespaces. We mentione=
d this
> > > > > duringthe conf and this was brought up on the thread here again a=
s well.
> > > > > Imho, that's a problem both security-wise and complexity-wise.
> > > > >
> > > > > It's not great if each subsystem gets its own custom delegation
> > > > > mechanism. This imposes such a taxing complexity on both kernel- =
and
> > > > > userspace that it will quickly become a huge liability. So I woul=
d
> > > > > really strongly encourage you to explore another direction.
> >
> > Alright, thanks a lot for elaborating. I did want to keep everything
> > contained to bpf() for various reasons, but it seems like I won't be
> > able to get away with this. :)
> >
> > > > >
> > > > > I do think the spirit of your proposal is workable and that it ca=
n
> > > > > mostly be kept in tact.
> >
> > It's good to know that at least conceptually you support the idea of
> > BPF delegation. I have a few more specific questions below and I'd
> > appreciate your answers, as I have less familiarity with how exactly
> > container managers do stuff at container bootstrapping stage.
> >
> > But first, let's try to get some tentative agreement on design before
> > I go and implement the BPF-token-as-FS idea. I have basically just two
> > gripes with exact details of what you are proposing, so let me explain
> > which and why, and see if we can find some common ground.
>
> Just fyi, there'll likely be some delays in my replies bc first I need
> to think about it and second floods of mails. I'll be on vacation for
> starting end of this week.

I'll be on vacation for the next month or so starting from tomorrow,
so that's no problem :)

>
> >
> > First, the idea of coupling and bundling this "delegation" option with
> > BPF FS doesn't feel right. BPF FS is just a container of BPF objects,
> > so adding to it a new property of allowing to use privileged BPF
> > functionality seems a bit off.
>
> Fwiw, I have a series that makes it possible to delegate a superblock of
> a filesystem to a user namespace using the new mount api introducing a
> vfs generic "delegate" mount option. So this won't be a special bpf
> thing. This is generally useful.
>
> >
> > Why not just create a new separate FS, let's code-name it "BPF Token
> > FS" for now (naming suggestions are welcome). Such BPF Token FS would
> > be dedicated to specifying everything about what's allowable through
> > BPF, just like my BPF token implementation. It can then be
> > mounted/bind-mounted inside BPF FS (or really, anywhere, it's just a
> > FS, right?). User application would open it (I'm guessing with
> > open_tree(), right?) and pass it as token_fd to bpf() syscall.
> >
> > Having it as a separate single-purpose FS seems cleaner, because we
> > have use cases where we'd have one BPF FS instance created for a
> > container by our container manager, and then exposing a few separate
> > tokens with different sets of allowed functionality. E.g., one for
> > main intended workload, another for some BPF-based observability
> > tools, maybe yet another for more heavy-weight tools like bpftrace for
> > extra debugging. In the debugging case our container infrastructure
> > will be "evacuating" any other workloads on the same host to avoid
> > unnecessary consequences. The point is to not disturb
> > workload-under-human-debugging as much as possible, so we'd like to
> > keep userns intact, which is why mounting extra (more permissive) BPF
> > token inside already running containers is an important consideration.
> >
> > With such goals, it seems nicer to have a single BPF FS, and few BPF
> > token FSs mounted inside it. Yes, we could bundle token functionality
> > with BPF FS, but separating those two seems cleaner to me. WDYT?
>
> It seems that writing a pseudo filesystem for the kernel is some right
> of passage that every kernel developer wants to go through for some
> reason. It's not mandatory though, it's actually discouraged.

Believe me, I tried to avoid this as much as possible.

>
> Joking aside.
> I think the danger lies in adding more and more moving parts and
> fragmenting this into so many moving pieces that it's hard to see the
> bigger picture and have a clear sense of the API.

It's probably a difference of perspective as a BPF developer and user.
To me bundling this delegate option onto BPF FS is completely
counter-intuitive. BPF FS has (in my mind) nothing to do with how I
can use the BPF subsystem. So BPF token as a separate object/FS is way
more natural.

Having said that, I can bundle this new functionality onto BPF FS if
you insist, just to make some progress here and move to solving
further problems with BPF usage within userns. If someone else who
prefers separate FS for BPF token (and I know there are at least few
people who think it's cleaner that way as well) would like to voice
their opinion in support, please do so.

>
> >
> > Second, mount options usage. I'm hearing stories from our production
> > folks how some new mount options (on some other FS, not BPF FS) were
> > breaking tools unintentionally during kernel/tooling
> > upgrades/downgrades, so it makes me a bit hesitant to have these
> > complicated sets of mount options to specify parameters of
> > BPF-token-as-FS. I've been thinking a bit, and I'm starting to lean
>
> I don't see this as a good argument for a new pseudo filesystem. It
> implies that any new filesystem would end up with the same problem. The
> answer here would be to report and fix such bugs.

Sure, this wasn't the reason for separate BPF token FS, of course.

>
> > towards the idea of allowing to set up (and modify as well) all these
> > allowed maps/progs/attach types through special auto-created files
> > within BPF token FS. Something like below:
> >
> > # pwd
> > /sys/fs/bpf/workload-token
> > # ls
> > allowed_cmds allowed_map_types allowed_prog_types allowed_attach_types
> > # echo "BPF_PROG_LOAD" > allowed_cmds
> > # echo "BPF_PROG_TYPE_KPROBE" >> allowed_prog_types
> > ...
> > # cat allowed_prog_types
> > BPF_PROG_TYPE_KPROBE,BPF_PROG_TYPE_TRACEPOINT
> >
> >
> > The above is fake (I haven't implemented anything yet), but hopefully
> > works as a demonstration. We'll also need to make sure that inside
> > non-init userns these files are read-only or allow to just further
> > restrict the subset of allowed functionality, never extend it.
>
> This implementation would get you into the business of write-time
> permission checks. And this almost always means you should use an
> ioctl(), not a write() operation on these files.
>

Ok. I think ioctl() kind of kills all the benefits, so there is little poin=
t.

> >
> > Such an approach will actually make it simpler to test and experiment
> > with this delegation locally, will make it trivial to observe what's
> > allowed from simple shell scripts, etc, etc. With fsmount() and O_PATH
> > it will be possible to set everything up from privileged processes
> > before ever exposing a BPF Token FS instance through a file system, if
> > there are any concerns about racing with user space.
> >
> > That's the high-level approach I'm thinking of right now. Would that
> > work? How critical is it to reuse BPF FS itself and how important to
> > you is to rely on mount options vs special files as described above?
>
> In the end, it's your api and you need to live with it and support it.
> What is important is that we don't end up with security issues. The
> special files thing will work but be aware that write-time permission
> checking is nasty:
> * https://git.zx2c4.com/CVE-2012-0056/about/ (Thanks to Aleksa for the li=
nk.)

entertaining read :)

> * commit e57457641613 ("cgroup: Use open-time cgroup namespace for proces=
s migration perm checks")
> There's a lot more. It can be done but it needs stringent permission
> checking and an ioctl() is probably the way to go in this case.
>
> Another thing, if you split configuration over multiple files you can
> end up introducing race windows. This is a common complaint with cgroups
> and sysfs whenever configuration of something is split over multiple
> files. It gets especially hairy if the options interact with each other
> somehow.

I'm not too worried about races, but all the above makes sense. My
original approach with bpf() syscall creating BPF token object went
for immutable BPF token construction for the very same reasons of
simplicity. Alright, this is all fair enough, I'll give mount options
a try and see how it all works out.

>
> > Hopefully not critical, and I can start working on it, and we'll get
> > what you want with using FS as a vehicle for delegation, while
> > allowing some of the intended use cases that we have in mind in a bit
> > cleaner fashion?
> >
> > > > >
> > > > > As mentioned before, bpffs has all the means to be taught delegat=
ion:
> > > > >
> > > > >         // In container's user namespace
> > > > >         fd_fs =3D fsopen("bpffs");
> > > > >
> > > > >         // Delegating task in host userns (systemd-bpfd whatever =
you want)
> > > > >         ret =3D fsconfig(fd_fs, FSCONFIG_SET_FLAG, "delegate", ..=
.);
> > > > >
> > > > >         // In container's user namespace
> > > > >         fd_mnt =3D fsmount(fd_fs, 0);
> > > > >
> > > > >         ret =3D move_mount(fd_fs, "", -EBADF, "/my/fav/location",=
 MOVE_MOUNT_F_EMPTY_PATH)
> > > > >
> > > > > Roughly, this would mean:
> > > > >
> > > > > (i) raise FS_USERNS_MOUNT on bpffs but guard it behind the "deleg=
ate"
> > > > >     mount option. IOW, it's only possibly to mount bpffs as an
> > > > >     unprivileged user if a delegating process like systemd-bpfd w=
ith
> > > > >     system-level privileges has marked it as delegatable.
> >
> > Regarding the FS_USERNS_MOUNT flag and fsopen() happening from inside
> > the user namespace. Am I missing something subtle and important here,
> > why does it have to happen inside the container's user namespace?
> > Can't the container manager both fsopen() and fsconfig() everything in
> > host userns, and only then fsmount+move_mount inside the container's
> > userns? Just trying to understand if there is some important early
> > association of userns happening at early steps here?
>
> The mount api _currently_ works very roughly like this: if a filesytem
> is FS_USERNS_MOUNT enabled fsopen() records the user namespace of the
> caller. The recorded userns will later become the owning userns of the
> filesystem's superblock (Without going into detail: owning userns of a
> superblock !=3D owning userns of a mount. move_mount() on a detached moun=
t
> is about the latter.).
>
> I have a patchset that adds a generic "delegate" mount option which will
> allow a sufficiently privileged process to do the following:
>
>         fd_fs =3D fsopen("ext4");
>
>         /*
>          * Set owning namespace of the filesystem's superblock.
>          * Caller must be privileged over @fd_userns.
>          *
>          * Note, must be first mount option to ensure that possible
>          * follow-up ermission checks for other mount options are done
>          * on the final owning namespace.
>          */
>         fsconfig(fd_fs, FSCONFIG_SET_FD, "delegate", NULL, fd_userns);
>
>         /*
>          * * If fs is FS_USERNS_MOUNT then permission is checked in @fd_u=
serns.
>          * * If fs is not FS_USERNS_MOUNT then permission is check in @in=
it_user_ns.
>          *   (Privilege in @init_user_ns implies privilege over @fd_usern=
s.)
>          */
>         fsconfig(fd_fs, FSCONFIG_CMD_CREATE, NULL, 0);
>
> After this, the sb is owned by @fd_userns. Currently my draft restricts
> this to such filesystems that raise FS_ALLOW_IDMAP because they almost
> can support delegation and don't need to be checked for any potential
> issues. But bpffs could easily support this (without caring about
> FS_ALLOW_IDMAP).

I see. Well, I should definitely not use "delegate" option name then
for anythying ;)

>
> >
> > Also, in your example above, move_mount() should take fd_mnt, not fd_fs=
, right?
> >
> > > > > (ii) add fine-grained delegation options that you want this
> > > > >      bpffs instance to allow via new mount options. Idk,
> > > > >
> > > > >      // allow usage of foo
> > > > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "foo");
> > > > >
> > > > >      // also allow usage of bar
> > > > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "bar");
> > > > >
> > > > >      // reset allowed options
> > > > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "");
> > > > >
> > > > >      // allow usage of schmoo
> > > > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "schmoo");
> > > > >
> > > > > This all seems more intuitive and integrates with user and mount
> > > > > namespaces of the container. This can also work for restricting
> > > > > non-userns bpf instances fwiw. You can also share instances via
> > > > > bind-mount and so on. The userns of the bpffs instance can also b=
e used
> > > > > for permission checking provided a given functionality has been
> > > > > delegated by e.g., systemd-bpfd or whatever.
> > > >
> > > > I have no arguments against any of the above, and would prefer to s=
ee
> > > > something like this over a token-based mechanism.  However we do wa=
nt
> > > > to make sure we have the proper LSM control points for either appro=
ach
> > > > so that admins who rely on LSM-based security policies can manage
> > > > delegation via their policies.
> > > >
> > > > Using the fsconfig() approach described by Christian above, I belie=
ve
> > > > we should have the necessary hooks already in
> > > > security_fs_context_parse_param() and security_sb_mnt_opts() but I'=
m
> > > > basing that on a quick look this morning, some additional checking
> > > > would need to be done.
> > >
> > > I think what I outlined is even unnecessarily complicated. You don't
> > > need that pointless "delegate" mount option at all actually. Permissi=
on
> > > to delegate shouldn't be checked when the mount option is set. The
> > > permissions should be checked when the superblock is created. That's =
the
> > > right point in time. So sm like:
> > >
> >
> > I think this gets even more straightforward with BPF Token FS being a
> > separate one, right? Given BPF Token FS is all about delegation, it
> > has to be a privileged operation to even create it.
> >
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 4174f76133df..a2eb382f5457 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -746,6 +746,13 @@ static int bpf_fill_super(struct super_block *sb=
, struct fs_context *fc)
> > >         struct inode *inode;
> > >         int ret;
> > >
> > > +       /*
> > > +        * If you want to delegate this instance then you need to be
> > > +        * privileged and know what you're doing. This isn't trust.
> > > +        */
> > > +       if ((fc->user_ns !=3D &init_user_ns) && !capable(CAP_SYS_ADMI=
N))
> > > +               return -EPERM;
> > > +
> > >         ret =3D simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> > >         if (ret)
> > >                 return ret;
> > > @@ -800,6 +807,7 @@ static struct file_system_type bpf_fs_type =3D {
> > >         .init_fs_context =3D bpf_init_fs_context,
> > >         .parameters     =3D bpf_fs_parameters,
> > >         .kill_sb        =3D kill_litter_super,
> > > +       .fs_flags       =3D FS_USERNS_MOUNT,
> >
> > Just an aside thought. It doesn't seem like there is any reason why
> > BPF FS right now is not created with FS_USERNS_MOUNT, so (separately
> > from all this discussion) I suspect we can just make it
> > FS_USERNS_MOUNT right now (unless we combine it with BPF-token-FS,
> > then yeah, we can't do that unconditionally anymore). Given BPF FS is
> > just a container of pinned BPF objects, just mounting BPF FS doesn't
> > seem to be dangerous in any way. But that's just an aside thought
> > here.
>
> My two cents: Don't ever expose anything under user namespaces unless it
> is guaranteed to be safe and has actual non-cosmetical use-cases.

Doesn't seem cosmetic to be able to have my own private BPF FS
instance created by an application inside the container to persist
and/or share BPF prog/maps between parts of the application. But I'm
not going to do this either, it was just a realization that we seem to
be unnecessarily restrictive with BPF FS (at least until it becomes
also a BPF token itself).

>
> The eagerness with which features pop up in user namespaces is probably
> bankrolling half the infosec community.

