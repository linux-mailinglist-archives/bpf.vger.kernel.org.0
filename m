Return-Path: <bpf+bounces-2279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18172A668
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 00:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16363281AAB
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F958824;
	Fri,  9 Jun 2023 22:57:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B267408D0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 22:57:15 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20532D41;
	Fri,  9 Jun 2023 15:57:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so3276664a12.2;
        Fri, 09 Jun 2023 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686351432; x=1688943432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCcFQvwlT5seqLJ1ulWZ3vRZZR2lvjPV8fCYXApwbH4=;
        b=kH3tnEULzr4ab5xK56zG5MiR7jMvjp35Vm6yAwnXqS8KUszZB/S6ahaPjY60UDfYCx
         VMQxdZC7td3Ctk78Ozyp9jBWDZYEFPob5IiYwPPBzqOx8hPAT4tAl8dYiSRpq8FQy8bD
         LvyKi7O/OFoq+sOA2Zgwr4HW+rsRs+H6v1FWD/Hk4jYkY5fnnaQTiYhyumpFHfnpTZaw
         9mw7WavU45gGYCIEOS+gxLfqlZBPtezqMoibJjxaMU5xdIzAyRMrcUExQFJVH7rFcu0R
         gTqodlyO13xtZ52Lkn2JxZ5YVM/TTaJQDm+WgsC9mnn/M/5o0ds+5G7Q4Jy9Ceb+tqwe
         YG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686351432; x=1688943432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCcFQvwlT5seqLJ1ulWZ3vRZZR2lvjPV8fCYXApwbH4=;
        b=fZQcXX2ESalHZfpWi/0wD/bCPAsFkW1pKDNCySv11IGigCULVaQVnlzPci22vV9W6Y
         qJ6YRdxL7GZT63Cpdfqz9GUpTbBvEIVdpfXL24t3lbDdugOaVba4WP1GsuqYLiLkRkFJ
         RNWDSn0Vgvjvq2S5or1yncnE80B7Tx4bw8B4uB5/emUH3OZBMvfZsV+i8hv9lxrT9ukW
         x+/GAqDPglYbk9XJDvkD04getNtHfHp3LtZPri8eUF3y+Urls39sCGLEVYu/dMN90j1O
         nczsnS+1j7IXwX+2lP9SwOQKqRynPf8JCsC+NeJjp+yBPUsMfLDMKk5RZ/PQuKMvQMzW
         aAng==
X-Gm-Message-State: AC+VfDwl7Z15DNRmICz+8Vj3ZuNGM8TC+UqZmVaTq+xDkA2IoFHsUKRF
	I2F9eljdjYLWVu0WuxOGal8ZuYU/l/fl97iF/hk=
X-Google-Smtp-Source: ACHHUZ5ce2sWlE9/G3bD6e/WfDXlMstl1ra1AbTaeM5u878zGGteHgPuD1xcQJjt3oqnIc6BFeoKYz+ZIjtUvpYl1i0=
X-Received: by 2002:a17:907:25c4:b0:969:9fd0:7ce7 with SMTP id
 ae4-20020a17090725c400b009699fd07ce7mr2564053ejc.11.1686351432030; Fri, 09
 Jun 2023 15:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
In-Reply-To: <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 15:57:00 -0700
Message-ID: <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com>
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

On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Djalal Harouni <tixxdz@gmail.com> wr=
ote:
>
> Hi Andrii,
>
> On Thu, Jun 8, 2023 at 1:54=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > This patch set introduces new BPF object, BPF token, which allows to de=
legate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about all=
owing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application th=
at
> > would create a BPF token.
> >
> > The main motivation for BPF token is a desire to enable containerized
> > BPF applications to be used together with user namespaces. This is curr=
ently
> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be nam=
espaced
> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to =
BPF
> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safe=
ly read
> > arbitrary memory, and it's impossible to ensure that they only read mem=
ory of
> > processes belonging to any given namespace. This means that it's imposs=
ible to
> > have namespace-aware CAP_BPF capability, and as such another mechanism =
to
> > allow safe usage of BPF functionality is necessary. BPF token and deleg=
ation
> > of it to a trusted unprivileged applications is such mechanism. Kernel =
makes
> > no assumption about what "trusted" constitutes in any particular case, =
and
> > it's up to specific privileged applications and their surrounding
> > infrastructure to decide that. What kernel provides is a set of APIs to=
 create
> > and tune BPF token, and pass it around to privileged BPF commands that =
are
> > creating new BPF objects like BPF programs, BPF maps, etc.
>
> Is there a reason for coupling this only with the userns?

There is no coupling. Without userns it is at least possible to grant
CAP_BPF and other capabilities from init ns. With user namespace that
becomes impossible.

> The "trusted unprivileged" assumed by systemd can be in init userns?

It doesn't have to be systemd, but yes, BPF token can be created only
when you have CAP_SYS_ADMIN in init ns. It's in line with restrictions
on a bunch of other bpf() syscall commands (like GET_FD_BY_ID family
of commands).

>
>
> > Previous attempt at addressing this very same problem ([0]) attempted t=
o
> > utilize authoritative LSM approach, but was conclusively rejected by up=
stream
> > LSM maintainers. BPF token concept is not changing anything about LSM
> > approach, but can be combined with LSM hooks for very fine-grained secu=
rity
> > policy. Some ideas about making BPF token more convenient to use with L=
SM (in
> > particular custom BPF LSM programs) was briefly described in recent LSF=
/MM/BPF
> > 2023 presentation ([1]). E.g., an ability to specify user-provided data
> > (context), which in combination with BPF LSM would allow implementing a=
 very
> > dynamic and fine-granular custom security policies on top of BPF token.=
 In the
> > interest of minimizing API surface area discussions this is going to be
> > added in follow up patches, as it's not essential to the fundamental co=
ncept
> > of delegatable BPF token.
> >
> > It should be noted that BPF token is conceptually quite similar to the =
idea of
> > /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> > difference is the idea of using virtual anon_inode file to hold BPF tok=
en and
> > allowing multiple independent instances of them, each with its own set =
of
> > restrictions. BPF pinning solves the problem of exposing such BPF token
> > through file system (BPF FS, in this case) for cases where transferring=
 FDs
> > over Unix domain sockets is not convenient. And also, crucially, BPF to=
ken
> > approach is not using any special stateful task-scoped flags. Instead, =
bpf()
>
> What's the use case for transfering over unix domain sockets?

I'm not sure I understand the question. Unix domain socket
(specifically its SCM_RIGHTS ancillary message) allows to transfer
files between processes, which is one way to pass BPF object (like
prog/map/link, and now token). BPF FS is the other one. In practice
it's usually BPF FS, but there is no presumption about how file
reference is transferred.

>
> Will BPF token translation happen if you cross the different namespaces?

What does BPF token translation mean specifically? Currently it's a
very simple kernel object with refcnt and a few flags, so there is
nothing to translate?

>
> If the token is pinned into different bpffs, will the token share the
> same context?

So I was planning to allow a user process creating a BPF token to
specify custom user-provided data (context). This is not in this patch
set, but is it what you are asking about?

Regardless, pinning BPF object in BPF FS is just basically bumping a
refcnt and exposes that object in a way that can be looked up through
file system path (using bpf() syscall's BPF_OBJ_GET command).
Underlying object isn't cloned or copied, it's exactly the same object
with the same shared internal state.

