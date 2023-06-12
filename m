Return-Path: <bpf+bounces-2457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927372D45C
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 00:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8755281131
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E023C70;
	Mon, 12 Jun 2023 22:27:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C82342B
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 22:27:44 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8F170C;
	Mon, 12 Jun 2023 15:27:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977cf86aae5so736561766b.0;
        Mon, 12 Jun 2023 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686608861; x=1689200861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA78BhFipKkzQ30vwjempYhrPvAMhNzRx0ETipbQy3E=;
        b=SYMNc3iB+qi46wHgoLFxmqyfkwN8mWzlTBzhPReZ68T7cFw/QMKO9p30Kk7sOeOKs5
         TOISCiXxf87tao7qm2amwFn/c9/hea6bGa7Kg15EaNIxeacf11F3uiWZBFTScofQfDcI
         /O9FieXh4C5r6j34a/4gqfdJFhSWj2o891bgyknzloNd1LzbjgpqZTS8XuVmCvEjKAgC
         h8T8Fda5C4oa9pEuzSTJH6cmPwJ9vW0PwmnREQ4tatM3MzAJ98dwe8RSOAfrpRei0177
         U558+bRHZanxFMMdZC5QP8V6gU73PuEnZgYErdzyaxjKzvhx0X06ujX205DPKU4vsDMf
         W1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608861; x=1689200861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA78BhFipKkzQ30vwjempYhrPvAMhNzRx0ETipbQy3E=;
        b=jLtaJOleIxud50RiZyfQ5leEqAmMAA1X9I7g71oBogMGvQsMV+V6QOJxYq+U1BmPuy
         A6VU9JR0FmIYgxPQb7HgvoQuTHUG1JivwazNRyenoNu4SXd7juM/cSJT34DAfOZhzdmA
         4ZqTnOl7Od+58aXaZbZwISSh8Il1uCiTzHOTiJQ4REmcFp7t9qYN+K4XmpwVQ8mjz6Et
         czIzb/m5tTz0322gea0unUOm9wgY4eFiYt+2N3adpOWwPgTSzJK+KCXhVkyl/n3jJgHK
         KdtPa6Wk3jlH8UF9tMlr5iJPepuDEI8WdTPn16eipypCCZ4Pq6UZVwXv4F8F9H62OXJU
         EiFw==
X-Gm-Message-State: AC+VfDxMfXqcWTnkQ6s0Fa32wGNcy+0uo52eVtbyPZeUP0zO/opKnN8J
	Jnu404/Sk1DeNkvF7LE97zwcQZuhNK/ogUjXxKE=
X-Google-Smtp-Source: ACHHUZ4/r3FeV0AZd+6PROUEuJxFJ3wn76aAoCTfdPXqDlqQmWchAx8Y76EPgh2R2sUJtNhgQ1X/puQdmvca37fq4zA=
X-Received: by 2002:a17:907:a4e:b0:96f:d345:d0f7 with SMTP id
 be14-20020a1709070a4e00b0096fd345d0f7mr9214184ejc.62.1686608860743; Mon, 12
 Jun 2023 15:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
 <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com> <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com>
In-Reply-To: <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jun 2023 15:27:28 -0700
Message-ID: <CAEf4BzaQSKBJ_+8HaHdBHa9_guL_QCVgHZHb6jpCqv6CboCniQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Djalal Harouni <tixxdz@gmail.com>
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

On Mon, Jun 12, 2023 at 5:02=E2=80=AFAM Djalal Harouni <tixxdz@gmail.com> w=
rote:
>
> On Sat, Jun 10, 2023 at 12:57=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Djalal Harouni <tixxdz@gmail.com=
> wrote:
> > >
> > > Hi Andrii,
> > >
> > > On Thu, Jun 8, 2023 at 1:54=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > >
> > > > ...
> > > > creating new BPF objects like BPF programs, BPF maps, etc.
> > >
> > > Is there a reason for coupling this only with the userns?
> >
> > There is no coupling. Without userns it is at least possible to grant
> > CAP_BPF and other capabilities from init ns. With user namespace that
> > becomes impossible.
>
> But these are not the same: delegate full cap vs delegate an fd mask?

What FD mask are we talking about here? I don't recall us talking
about any FD masks, so this one is a bit confusing without more
context.

>
> One can argue unprivileged in init userns is the same privileged in
> nested userns
> Getting to delegate fd in init userns, then in nested ones seems logical.=
..

Again, sorry, I'm not following. Can you please elaborate what you mean?

>
> > > The "trusted unprivileged" assumed by systemd can be in init userns?
> >
> > It doesn't have to be systemd, but yes, BPF token can be created only
> > when you have CAP_SYS_ADMIN in init ns. It's in line with restrictions
> > on a bunch of other bpf() syscall commands (like GET_FD_BY_ID family
> > of commands).
>
> I'm more into getting fd delegation work also in the first init userns...
>
> I can't understand why it's not possible or doable?
>

I don't know what you are proposing, as I mentioned above, so it's
hard to answer this question.

> > >
> > >
> > > > Previous attempt at addressing this very same problem ([0]) attempt=
ed to
> > > > utilize authoritative LSM approach, but was conclusively rejected b=
y upstream
> > > > LSM maintainers. BPF token concept is not changing anything about L=
SM
> > > > approach, but can be combined with LSM hooks for very fine-grained =
security
> > > > policy. Some ideas about making BPF token more convenient to use wi=
th LSM (in
> > > > particular custom BPF LSM programs) was briefly described in recent=
 LSF/MM/BPF
> > > > 2023 presentation ([1]). E.g., an ability to specify user-provided =
data
> > > > (context), which in combination with BPF LSM would allow implementi=
ng a very
> > > > dynamic and fine-granular custom security policies on top of BPF to=
ken. In the
> > > > interest of minimizing API surface area discussions this is going t=
o be
> > > > added in follow up patches, as it's not essential to the fundamenta=
l concept
> > > > of delegatable BPF token.
> > > >
> > > > It should be noted that BPF token is conceptually quite similar to =
the idea of
> > > > /dev/bpf device file, proposed by Song a while ago ([2]). The bigge=
st
> > > > difference is the idea of using virtual anon_inode file to hold BPF=
 token and
> > > > allowing multiple independent instances of them, each with its own =
set of
> > > > restrictions. BPF pinning solves the problem of exposing such BPF t=
oken
> > > > through file system (BPF FS, in this case) for cases where transfer=
ring FDs
> > > > over Unix domain sockets is not convenient. And also, crucially, BP=
F token
> > > > approach is not using any special stateful task-scoped flags. Inste=
ad, bpf()
> > >
> > > What's the use case for transfering over unix domain sockets?
> >
> > I'm not sure I understand the question. Unix domain socket
> > (specifically its SCM_RIGHTS ancillary message) allows to transfer
> > files between processes, which is one way to pass BPF object (like
> > prog/map/link, and now token). BPF FS is the other one. In practice
> > it's usually BPF FS, but there is no presumption about how file
> > reference is transferred.
>
> Got it.
>
> IIRC SCM_RIGHTS and SCM_CREDENTIALS are translated into the receiving
> userns, no ?
>
> I assume such which allows to set up things in a hierarchical way...
>
> If I set up the environment to lock things down the line, I find it
> strange if a received fd would allow me to do more things than what
> was planned when I created the environment: namespaces, mounts, etc
>
> I think you have to add the owning userns context to the fd or
> "token", and on the receiving part if the current userns is the same
> or a nested one of the current userns hierarchy then allow bpf
> operation, otherwise fail with -EACCESS or something similar...
>

I think I mentioned problems with namespacing BPF itself. It's just
fundamentally impossible due to a system-wide nature of BPF. So we can
pretend to somehow attach/restrict BPF token to some namespace, but it
still allows BPF programs to peek at any kernel state or user-space
process.

So I'd rather us not pretend we can do something that we actually
cannot enforce.

>
> > >
> > > Will BPF token translation happen if you cross the different namespac=
es?
> >
> > What does BPF token translation mean specifically? Currently it's a
> > very simple kernel object with refcnt and a few flags, so there is
> > nothing to translate?
>
> Please see above comment about the owning userns context
>
> > >
> > > If the token is pinned into different bpffs, will the token share the
> > > same context?
> >
> > So I was planning to allow a user process creating a BPF token to
> > specify custom user-provided data (context). This is not in this patch
> > set, but is it what you are asking about?
>
> Exactly, define what you can access inside the container... this would
> align with Andy's suggestion "making BPF behave sensibly in that
> container seems like it should also be necessary." I do agree on this.
>

I don't know what Andy's suggestion actually is (as I honestly can't
make out what your proposal is, sorry; you guys are not making it easy
on me by being pretty vague and nonspecific). But see above about
pretending to contain BPF within a container. There is no such thing.
BPF is system-wide.

> Again I think LSM and bpf+lsm should have the final word on this too...
>

Yes, I also think that having LSM on top is beneficial. But not a
strict requirement and more or less orthogonal.

>
> > Regardless, pinning BPF object in BPF FS is just basically bumping a
> > refcnt and exposes that object in a way that can be looked up through
> > file system path (using bpf() syscall's BPF_OBJ_GET command).
> > Underlying object isn't cloned or copied, it's exactly the same object
> > with the same shared internal state.
>
> This is the part I also find strange, I can understand pinning a bpf
> program, map, etc, but an fd that gives some access rights should be
> part of the filesystem from the start, I don't get the extra pinning.

BPF pinning of BPF token is optional. Everything still works without
any BPF FS mount at all. It's an FD, BPF FS is just one of the means
to pass FD to another process. I actually don't see why coupling BPF
FS and BPF token is simpler.

Now, BPF token is a kernel object, with its own state. It has an FD
associated with it. It can be passed around and provided as an
argument to bpf() syscall. In that sense it's just like BPF
prog/map/link, just another BPF object.

> Also it seems bpffs is per superblock mount so why not allow
> privileged to mount bpffs with the corresponding information, then
> privileged can open the fd, set it up and pass it down the line when
> executing the main program?  or even allow unprivileged to open it on
> bpffs with some restrictive conditions?
>
> Then it would be the business of the privileged to bind mount bpffs in
> some other places, share it, etc

How is this fundamentally different from BPF token pinning by
*privileged* process? Except we are not conflating BPF FS as a way to
pin/get many different BPF objects with BPF token itself. In both
cases it's up to privileged process to set up sharing of BPF token
appropriately.

>
> Having the fd or "token" that gives access rights pinned in two
> separate bpffs mounts seems too much, it crosses namespaces (mount,
> userns etc), environments setup by privileged...

See above, there is nothing namespaceable about BPF itself, and BPF
token as well. If some production setup benefits from pinning one BPF
token in multiple places, I don't see the problem with that.

>
> I would just make it per bpffs mount and that's it, nothing more. If a
> program wants to bind mount it somewhere else then it's not a bpf
> problem.

And if some application wants to pin BPF token, why would that be BPF
subsystem's problem as well?

