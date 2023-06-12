Return-Path: <bpf+bounces-2388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98572C3A1
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 14:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D881C20B20
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E41952E;
	Mon, 12 Jun 2023 12:02:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36118C35
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:02:41 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BE8F;
	Mon, 12 Jun 2023 05:02:39 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-43b87490a27so1555904137.0;
        Mon, 12 Jun 2023 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686571359; x=1689163359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzmVyjn5vqcrDgp5U5+cSMvgkE+waDiK4LR1OGbCtls=;
        b=nAcSFnk3slfL242FmuSFKyE04/akLEbivoVWFXmQK8AMFaV2zbgK0eN6Zk5YwLKCAI
         vu8/ULXAK6TsnSsMKQSDgwd3DQAI+U3jp6SA84gAAsVV47JLei9JadjgPzqC0GbtkbLo
         5QX79jAuYN4nTQrzQPFvKWPpICOHyo/DhA4RKau66H0cNER/xTH1Gq1+RFBuI+reqNWP
         5ITuA07EhnYFkKAnZ5yqg2meQpDLjSmyLRI+gHB0GPtL4HDeVzPB6pImrbwfbnh+qobt
         Rm2Td9SFU/BVnz40zIHtSYRCoseFCcE1ZYytQzxruK3tpWWrv9luiM1J0tpsmnIWS9Bb
         ydZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686571359; x=1689163359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzmVyjn5vqcrDgp5U5+cSMvgkE+waDiK4LR1OGbCtls=;
        b=Nls8nSsIEjdZJf9b68fu1JEbE30dLw/HX4+itxBqM1YbGLCJDg6ujFhanyXxPSK70r
         35LsMnCuiQqd8zsyEbGF2Ue+LaBpJFoyghOD68EkviX8X872jMmuEvd8JzzXCM97DxhZ
         WrFdo9FIVijxu77R6jKB0qvjivej8qxp8Hc/M848zNn/i/uvI9TKnsq6Pe2QGoozWFiN
         kXBybwo5tqExvmgEUJ8jpXbVOz+I74SgniXSEeaZUoraAYKaiK4Nj+AR2FrVDjTBICcU
         2UdX7KyrbAGguTsnbyilcUPzd1TUd/zlYF+EhgbkZfoX5aNZtSkDJ3zo4A3TJBypQvSN
         2flA==
X-Gm-Message-State: AC+VfDwIHUZpTViCzSpvLYEhfNGyOrDA4yC0HrPjULGCWdDfx0DhZroF
	pie+uNd70ywnnk8pFK3UmA+4h74u7CPWN4yAtD3ut/m3qPU=
X-Google-Smtp-Source: ACHHUZ4a0nZ9N6l/W0Ol0b9j9BrwZrf4iQdnTfRY1JiOhz6o4r27FcdNCepcOJ+HkL6/JhvKdhAGKqRVp8MunZgQDiU=
X-Received: by 2002:a05:6102:94:b0:43b:1f8a:d581 with SMTP id
 t20-20020a056102009400b0043b1f8ad581mr3856074vsp.31.1686571358681; Mon, 12
 Jun 2023 05:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
 <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Mon, 12 Jun 2023 14:02:11 +0200
Message-ID: <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com>
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

On Sat, Jun 10, 2023 at 12:57=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Djalal Harouni <tixxdz@gmail.com> =
wrote:
> >
> > Hi Andrii,
> >
> > On Thu, Jun 8, 2023 at 1:54=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > ...
> > > creating new BPF objects like BPF programs, BPF maps, etc.
> >
> > Is there a reason for coupling this only with the userns?
>
> There is no coupling. Without userns it is at least possible to grant
> CAP_BPF and other capabilities from init ns. With user namespace that
> becomes impossible.

But these are not the same: delegate full cap vs delegate an fd mask?

One can argue unprivileged in init userns is the same privileged in
nested userns
Getting to delegate fd in init userns, then in nested ones seems logical...

> > The "trusted unprivileged" assumed by systemd can be in init userns?
>
> It doesn't have to be systemd, but yes, BPF token can be created only
> when you have CAP_SYS_ADMIN in init ns. It's in line with restrictions
> on a bunch of other bpf() syscall commands (like GET_FD_BY_ID family
> of commands).

I'm more into getting fd delegation work also in the first init userns...

I can't understand why it's not possible or doable?

> >
> >
> > > Previous attempt at addressing this very same problem ([0]) attempted=
 to
> > > utilize authoritative LSM approach, but was conclusively rejected by =
upstream
> > > LSM maintainers. BPF token concept is not changing anything about LSM
> > > approach, but can be combined with LSM hooks for very fine-grained se=
curity
> > > policy. Some ideas about making BPF token more convenient to use with=
 LSM (in
> > > particular custom BPF LSM programs) was briefly described in recent L=
SF/MM/BPF
> > > 2023 presentation ([1]). E.g., an ability to specify user-provided da=
ta
> > > (context), which in combination with BPF LSM would allow implementing=
 a very
> > > dynamic and fine-granular custom security policies on top of BPF toke=
n. In the
> > > interest of minimizing API surface area discussions this is going to =
be
> > > added in follow up patches, as it's not essential to the fundamental =
concept
> > > of delegatable BPF token.
> > >
> > > It should be noted that BPF token is conceptually quite similar to th=
e idea of
> > > /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> > > difference is the idea of using virtual anon_inode file to hold BPF t=
oken and
> > > allowing multiple independent instances of them, each with its own se=
t of
> > > restrictions. BPF pinning solves the problem of exposing such BPF tok=
en
> > > through file system (BPF FS, in this case) for cases where transferri=
ng FDs
> > > over Unix domain sockets is not convenient. And also, crucially, BPF =
token
> > > approach is not using any special stateful task-scoped flags. Instead=
, bpf()
> >
> > What's the use case for transfering over unix domain sockets?
>
> I'm not sure I understand the question. Unix domain socket
> (specifically its SCM_RIGHTS ancillary message) allows to transfer
> files between processes, which is one way to pass BPF object (like
> prog/map/link, and now token). BPF FS is the other one. In practice
> it's usually BPF FS, but there is no presumption about how file
> reference is transferred.

Got it.

IIRC SCM_RIGHTS and SCM_CREDENTIALS are translated into the receiving
userns, no ?

I assume such which allows to set up things in a hierarchical way...

If I set up the environment to lock things down the line, I find it
strange if a received fd would allow me to do more things than what
was planned when I created the environment: namespaces, mounts, etc

I think you have to add the owning userns context to the fd or
"token", and on the receiving part if the current userns is the same
or a nested one of the current userns hierarchy then allow bpf
operation, otherwise fail with -EACCESS or something similar...


> >
> > Will BPF token translation happen if you cross the different namespaces=
?
>
> What does BPF token translation mean specifically? Currently it's a
> very simple kernel object with refcnt and a few flags, so there is
> nothing to translate?

Please see above comment about the owning userns context

> >
> > If the token is pinned into different bpffs, will the token share the
> > same context?
>
> So I was planning to allow a user process creating a BPF token to
> specify custom user-provided data (context). This is not in this patch
> set, but is it what you are asking about?

Exactly, define what you can access inside the container... this would
align with Andy's suggestion "making BPF behave sensibly in that
container seems like it should also be necessary." I do agree on this.

Again I think LSM and bpf+lsm should have the final word on this too...


> Regardless, pinning BPF object in BPF FS is just basically bumping a
> refcnt and exposes that object in a way that can be looked up through
> file system path (using bpf() syscall's BPF_OBJ_GET command).
> Underlying object isn't cloned or copied, it's exactly the same object
> with the same shared internal state.

This is the part I also find strange, I can understand pinning a bpf
program, map, etc, but an fd that gives some access rights should be
part of the filesystem from the start, I don't get the extra pinning.
Also it seems bpffs is per superblock mount so why not allow
privileged to mount bpffs with the corresponding information, then
privileged can open the fd, set it up and pass it down the line when
executing the main program?  or even allow unprivileged to open it on
bpffs with some restrictive conditions?

Then it would be the business of the privileged to bind mount bpffs in
some other places, share it, etc

Having the fd or "token" that gives access rights pinned in two
separate bpffs mounts seems too much, it crosses namespaces (mount,
userns etc), environments setup by privileged...

I would just make it per bpffs mount and that's it, nothing more. If a
program wants to bind mount it somewhere else then it's not a bpf
problem.

