Return-Path: <bpf+bounces-2565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A573372F0EE
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 02:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A877281277
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39162363;
	Wed, 14 Jun 2023 00:23:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E1160
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 00:23:32 +0000 (UTC)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7775127;
	Tue, 13 Jun 2023 17:23:30 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-463577c35eeso71034e0c.0;
        Tue, 13 Jun 2023 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686702210; x=1689294210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPOuVjdWN3O7AMrEWfLXIsNHrCdwm/+hZAV5hYzcZd8=;
        b=cAjpPrG/zcGtzKBZOJIRAnGeouxyL4D0LOovKXv9MylGTnofF2X+u9/ue6OCkHDINL
         U4Z5BB0m0rMQNy5/jh/RkGEUgQJV+QUTxVdIZVBqhov7/2VKdbS8SNHV7MCUuHiWubp6
         2AVlxD+04AXLxZzCWyQSzGjVb8spxGeqL3Txt3IiyyBUKxJH6cs8Hhb8mzMLkS3wX1N4
         UHAms6yrJpziLHnBAtdjsiQj2kQSYUVXNYRKprep4dydF9n31KO5/Tyccnvsa6L1B5xG
         tTYywWjRl4O7qlGMwwxukF7UZp1q/Su+srJaHGamO1Bh0sxJLZMNdN5uo3Lv3pWdC1mH
         GDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702210; x=1689294210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPOuVjdWN3O7AMrEWfLXIsNHrCdwm/+hZAV5hYzcZd8=;
        b=CLHyE16TN+MrTuj+jm+ramSRF/Hhguh3InILqiafGQbqHm5p+k8TGkJOh27pZ55ctj
         H5wdzTRSxcb/7g6RHMXxc72iWBfnC1kYofDzrFH0eJtComJFOQlVwapzAH0TIxXDYE7C
         H9OmC9/qtLpjhMf4+7IjDP9gszHZsKDdE29oXqJ8Cj13PaX/cNpttWjBgwTT4ihkSqUl
         lGOQpjeoPZ1fOIWsXCTqSfFdVJWzJ2HONUKC5zpcJAsMi69KlqgCV1tdwd8e9Tu4FdB1
         f5XXHMcbtPzraL7Q7U12/jfDJFF5b5wM98KOdwc46gjxHpWb6//C6yhk1rRh52+J5o9Y
         ha+A==
X-Gm-Message-State: AC+VfDw9fMjNf3FiWcCmuDdKC/2AAY6r4bl3Qg34H2eiIWWlCaek6aRz
	rhwlYucrM4AVrjsF758XB69HpCEwhPjO03j85Td1FIlPhxs=
X-Google-Smtp-Source: ACHHUZ6HEWz10sD6UvIQkMNcajXflBcoqHukXVxZpt0iJOtIVUFGmuf1beeaE7nadse7YaUUyBFYnxh4JBEL8JR4vc8=
X-Received: by 2002:a1f:45d0:0:b0:46e:86be:90d1 with SMTP id
 s199-20020a1f45d0000000b0046e86be90d1mr262040vka.9.1686702209278; Tue, 13 Jun
 2023 17:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
 <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com>
 <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com> <CAEf4BzaQSKBJ_+8HaHdBHa9_guL_QCVgHZHb6jpCqv6CboCniQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaQSKBJ_+8HaHdBHa9_guL_QCVgHZHb6jpCqv6CboCniQ@mail.gmail.com>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Wed, 14 Jun 2023 02:23:02 +0200
Message-ID: <CAEiveUdU7On9c27iek2rRmqSLFTKduNUtjEAD0iaCPQ4wZoH6Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 12:27=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 12, 2023 at 5:02=E2=80=AFAM Djalal Harouni <tixxdz@gmail.com>=
 wrote:
> >
> > On Sat, Jun 10, 2023 at 12:57=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Djalal Harouni <tixxdz@gmail.c=
om> wrote:
> > > >
> > > > Hi Andrii,
> > > >
> > > > On Thu, Jun 8, 2023 at 1:54=E2=80=AFAM Andrii Nakryiko <andrii@kern=
el.org> wrote:
> > > > >
> > > > > ...
> > > > > creating new BPF objects like BPF programs, BPF maps, etc.
> > > >
> > > > Is there a reason for coupling this only with the userns?
> > >
> > > There is no coupling. Without userns it is at least possible to grant
> > > CAP_BPF and other capabilities from init ns. With user namespace that
> > > becomes impossible.
> >
> > But these are not the same: delegate full cap vs delegate an fd mask?
>
> What FD mask are we talking about here? I don't recall us talking
> about any FD masks, so this one is a bit confusing without more
> context.

Ah err, sorry yes referring to fd token (which I assumed is a mask of
allowed operations or something like that).

So I want the possibility to delegate the fd token in the init userns.

> >
> > One can argue unprivileged in init userns is the same privileged in
> > nested userns
> > Getting to delegate fd in init userns, then in nested ones seems logica=
l...
>
> Again, sorry, I'm not following. Can you please elaborate what you mean?

I mean can we use the fd token in the init user namespace too? not
only in the nested user namespaces but in the first one? Sorry I
didn't check the code.


> >
> > > > The "trusted unprivileged" assumed by systemd can be in init userns=
?
> > >
> > > It doesn't have to be systemd, but yes, BPF token can be created only
> > > when you have CAP_SYS_ADMIN in init ns. It's in line with restriction=
s
> > > on a bunch of other bpf() syscall commands (like GET_FD_BY_ID family
> > > of commands).
> >
> > I'm more into getting fd delegation work also in the first init userns.=
..
> >
> > I can't understand why it's not possible or doable?
> >
>
> I don't know what you are proposing, as I mentioned above, so it's
> hard to answer this question.
>


> > > >
> > > >
> > > > > Previous attempt at addressing this very same problem ([0]) attem=
pted to
> > > > > utilize authoritative LSM approach, but was conclusively rejected=
 by upstream
> > > > > LSM maintainers. BPF token concept is not changing anything about=
 LSM
> > > > > approach, but can be combined with LSM hooks for very fine-graine=
d security
> > > > > policy. Some ideas about making BPF token more convenient to use =
with LSM (in
> > > > > particular custom BPF LSM programs) was briefly described in rece=
nt LSF/MM/BPF
> > > > > 2023 presentation ([1]). E.g., an ability to specify user-provide=
d data
> > > > > (context), which in combination with BPF LSM would allow implemen=
ting a very
> > > > > dynamic and fine-granular custom security policies on top of BPF =
token. In the
> > > > > interest of minimizing API surface area discussions this is going=
 to be
> > > > > added in follow up patches, as it's not essential to the fundamen=
tal concept
> > > > > of delegatable BPF token.
> > > > >
> > > > > It should be noted that BPF token is conceptually quite similar t=
o the idea of
> > > > > /dev/bpf device file, proposed by Song a while ago ([2]). The big=
gest
> > > > > difference is the idea of using virtual anon_inode file to hold B=
PF token and
> > > > > allowing multiple independent instances of them, each with its ow=
n set of
> > > > > restrictions. BPF pinning solves the problem of exposing such BPF=
 token
> > > > > through file system (BPF FS, in this case) for cases where transf=
erring FDs
> > > > > over Unix domain sockets is not convenient. And also, crucially, =
BPF token
> > > > > approach is not using any special stateful task-scoped flags. Ins=
tead, bpf()
> > > >
> > > > What's the use case for transfering over unix domain sockets?
> > >
> > > I'm not sure I understand the question. Unix domain socket
> > > (specifically its SCM_RIGHTS ancillary message) allows to transfer
> > > files between processes, which is one way to pass BPF object (like
> > > prog/map/link, and now token). BPF FS is the other one. In practice
> > > it's usually BPF FS, but there is no presumption about how file
> > > reference is transferred.
> >
> > Got it.
> >
> > IIRC SCM_RIGHTS and SCM_CREDENTIALS are translated into the receiving
> > userns, no ?
> >
> > I assume such which allows to set up things in a hierarchical way...
> >
> > If I set up the environment to lock things down the line, I find it
> > strange if a received fd would allow me to do more things than what
> > was planned when I created the environment: namespaces, mounts, etc
> >
> > I think you have to add the owning userns context to the fd or
> > "token", and on the receiving part if the current userns is the same
> > or a nested one of the current userns hierarchy then allow bpf
> > operation, otherwise fail with -EACCESS or something similar...
> >
>
> I think I mentioned problems with namespacing BPF itself. It's just
> fundamentally impossible due to a system-wide nature of BPF. So we can
> pretend to somehow attach/restrict BPF token to some namespace, but it
> still allows BPF programs to peek at any kernel state or user-space
> process.

I'm not referring to namespacing BPF, but about the same token that
can fly between containers...
More or less problems mentioned by Casey
https://lore.kernel.org/bpf/20230602150011.1657856-19-andrii@kernel.org/T/#=
m005dfd937e4fff7a8cc35036f0ce38281f01e823

I think that a token or the fd should be part of the bpffs and should
not be shared between containers or crosse namespaces by default
without control... hence the suggested protection:
https://lore.kernel.org/bpf/CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ=
1tUw@mail.gmail.com/T/#m217d041d9ef9e02b598d5f0e1ff61043aeae57fd


> So I'd rather us not pretend we can do something that we actually
> cannot enforce.

Actually it is to protect against accidental token sharing or abuse...
so completely different things.


> >
> > > >
> > > > Will BPF token translation happen if you cross the different namesp=
aces?
> > >
> > > What does BPF token translation mean specifically? Currently it's a
> > > very simple kernel object with refcnt and a few flags, so there is
> > > nothing to translate?
> >
> > Please see above comment about the owning userns context
> >
> > > >
> > > > If the token is pinned into different bpffs, will the token share t=
he
> > > > same context?
> > >
> > > So I was planning to allow a user process creating a BPF token to
> > > specify custom user-provided data (context). This is not in this patc=
h
> > > set, but is it what you are asking about?
> >
> > Exactly, define what you can access inside the container... this would
> > align with Andy's suggestion "making BPF behave sensibly in that
> > container seems like it should also be necessary." I do agree on this.
> >
>
> I don't know what Andy's suggestion actually is (as I honestly can't
> make out what your proposal is, sorry; you guys are not making it easy
> on me by being pretty vague and nonspecific). But see above about
> pretending to contain BPF within a container. There is no such thing.
> BPF is system-wide.

Sorry about that, I can quickly put: you may restrict types of bpf
programs, you may disable or nop probes if they are running without a
process context, if the triggered probe is owned by root by specific
uid? if the process is under a specific cgroup hierarchy etc... Are
the above possible?


> > Again I think LSM and bpf+lsm should have the final word on this too...
> >
>
> Yes, I also think that having LSM on top is beneficial. But not a
> strict requirement and more or less orthogonal.

I do think there should be LSM hooks to tighten this, as LSMs have
more context outside of BPF...


> >
> > > Regardless, pinning BPF object in BPF FS is just basically bumping a
> > > refcnt and exposes that object in a way that can be looked up through
> > > file system path (using bpf() syscall's BPF_OBJ_GET command).
> > > Underlying object isn't cloned or copied, it's exactly the same objec=
t
> > > with the same shared internal state.
> >
> > This is the part I also find strange, I can understand pinning a bpf
> > program, map, etc, but an fd that gives some access rights should be
> > part of the filesystem from the start, I don't get the extra pinning.
>
> BPF pinning of BPF token is optional. Everything still works without
> any BPF FS mount at all. It's an FD, BPF FS is just one of the means
> to pass FD to another process. I actually don't see why coupling BPF
> FS and BPF token is simpler.

I think it's better the other way around since bpffs is per super
block and separate mount then it is already solved, you just get that
special fd from the fs and pass it...


> Now, BPF token is a kernel object, with its own state. It has an FD
> associated with it. It can be passed around and provided as an
> argument to bpf() syscall. In that sense it's just like BPF
> prog/map/link, just another BPF object.
>
> > Also it seems bpffs is per superblock mount so why not allow
> > privileged to mount bpffs with the corresponding information, then
> > privileged can open the fd, set it up and pass it down the line when
> > executing the main program?  or even allow unprivileged to open it on
> > bpffs with some restrictive conditions?
> >
> > Then it would be the business of the privileged to bind mount bpffs in
> > some other places, share it, etc
>
> How is this fundamentally different from BPF token pinning by
> *privileged* process? Except we are not conflating BPF FS as a way to
> pin/get many different BPF objects with BPF token itself. In both
> cases it's up to privileged process to set up sharing of BPF token
> appropriately.

I'm not convinced about the use case of sharing BPF tokens between
containers or services...

Every container or service has its own separate bpffs, what's the
point of pinning a shared token created by a different container
compared to mounting separate bpffs with an fd token prepared to be
used for that specific container?

Then the container/service can delegate it to child processes, etc...
but sharing between containers and crossing user namespaces, mount
namespaces of such containers where bpffs is already separate in that
context? I don't see the point, and it just opens the room to token
misuse...


> >
> > Having the fd or "token" that gives access rights pinned in two
> > separate bpffs mounts seems too much, it crosses namespaces (mount,
> > userns etc), environments setup by privileged...
>
> See above, there is nothing namespaceable about BPF itself, and BPF
> token as well. If some production setup benefits from pinning one BPF
> token in multiple places, I don't see the problem with that.
>
> >
> > I would just make it per bpffs mount and that's it, nothing more. If a
> > program wants to bind mount it somewhere else then it's not a bpf
> > problem.
>
> And if some application wants to pin BPF token, why would that be BPF
> subsystem's problem as well?

The credentials, capabilities, keyring, different namespaces, etc are
all attached to the owning user namespace, if the BPF subsystem goes
its own way and creates a token to split up CAP_BPF without following
that model, then it's definitely a BPF subsystem problem...  I don't
recommend that.

Feels it's going more of a system-wide approach opening BPF
functionality where ultimately it clashes with the argument: delegate
a subset of BPF functionality to a *trusted* unprivileged application.
My reading of delegation is within a container/service hierarchy
nothing more.

