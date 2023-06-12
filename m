Return-Path: <bpf+bounces-2458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9377372D4BF
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 01:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB06D1C20B3A
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 23:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257EBDDD5;
	Mon, 12 Jun 2023 23:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF22BE63
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 23:04:25 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BDF1BF;
	Mon, 12 Jun 2023 16:04:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5186d5508afso678456a12.3;
        Mon, 12 Jun 2023 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686611061; x=1689203061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxksVMWqKFGDADLYpLhfx61N35U/HTnp4HIE3rWIo40=;
        b=YAf6XOXKHTWv6S0QY/sGRtkcLlvYFDk7ZSirqZPwn1tt0z5FpKCrT2r4GAKiObRLH/
         GUPmF3YcVZP4kNdwefzJTzXY7sip3OoTfHQpVhjs7Z76jXzQuDaONhsBJQSeAoIo9K98
         HnB0t3gRz/e/dGgOflSwrJIic8ifgBZseQEqOAtM1X4ZyNcw8RoZpYM9PrA32Tl/1vNY
         RCf6DgIceQKGcSeSmnM8lnBaE+V4q8Rxoe8EA1G26tfEcHEPKcH8CS3mQ2Dr0OilVW0/
         77CkTzUjCWSxlQ74EG3R4OJ2kcUE6i8zZvJ71F2A15SpeQMZpZq0r42qJp9nMKRnZrkE
         C0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686611061; x=1689203061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxksVMWqKFGDADLYpLhfx61N35U/HTnp4HIE3rWIo40=;
        b=JIIZhuhXRrEHmOSkRnpTrRI5wu4KwHZ2TH1S+Aro2Q414yWA3daM/OoXQeIIwIat2W
         R0olZfy/+fWxzp2XF+HDeyOP3tpTzrNPtsuPIoCw48lqNTgcoZPs6676MI4xOQGNadbs
         beNmBz/9iv00517+zVZWT1x/ooDW7GejKet9IDG8M2JA9nwebzilGfojjTT7Yw9tzHuQ
         IjBcEU7PtSYNqokcarrPk95B6EgH6jQ9Ppi/Oudpv7eXVsl0je1pxWlfmUQ9dtgQBmF2
         V8oud8dzv8INfZtfkx8DZFD5JDm88AeaDBc1y9D/mpAIc8veqS1QAclAI9G1AOBbxxqb
         pWaQ==
X-Gm-Message-State: AC+VfDwuY7cEKTJtoTJloE11gYspNMrYz2XRQCoT8z2HsXb8pEENd9pg
	FMFf2vOqSnHnerew5HJyezetD+U/t78enNapMvNbM1SA5WA=
X-Google-Smtp-Source: ACHHUZ5n26HqWwaMbUHTn2Zwut0/7u8SflHaV2YNnTgqeWBYI6PZo7Izk2WSP2oSfiOKu2lIhciv015LCAJS+emY25s=
X-Received: by 2002:a17:907:707:b0:94f:956:b3f7 with SMTP id
 xb7-20020a170907070700b0094f0956b3f7mr9977107ejb.2.1686611061079; Mon, 12 Jun
 2023 16:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <1BEB36A1-9FE4-4552-B2FF-DE6DF74F3756@redhat.com>
In-Reply-To: <1BEB36A1-9FE4-4552-B2FF-DE6DF74F3756@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jun 2023 16:04:09 -0700
Message-ID: <CAEf4BzZKFPDjaXXxSxUQH3-Z_d6oAXdXa1zgq65Tuf_sDttVdg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Dave Tucker <datucker@redhat.com>
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

On Mon, Jun 12, 2023 at 5:45=E2=80=AFAM Dave Tucker <datucker@redhat.com> w=
rote:
>
>
>
> > On 8 Jun 2023, at 00:53, Andrii Nakryiko <andrii@kernel.org> wrote:
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
>
>
> Hello! Author of a bpfd[1] here.
>
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
> You could do that=E2=80=A6 but the problem is created due to the pattern =
of having a
> single binary that is responsible for:
>
> - Loading and attaching the BPF program in question
> - Interacting with maps

It is a very desirable property to couple and deploy user process and
its BPF programs/maps together and manage their lifecycle directly.
All of Meta's production applications are using this model. This
allows for a simple and reliable versioning story. This allows using
BPF skeleton and BPF global variables naturally. It makes it simple
and easy to develop, debug, version, deploy, monitor BPF applications.

It also couples BPF program attachment (link) with lifetime of the
user space process. So if it crashes or restarts without clean
detachment, we don't end up with orphaned BPF programs and maps. We've
had pretty bad issues due to such orphaned programs, and that's why
the whole BPF link concept was formalized.

So it's actually a desirable approach in a real-world production setup.

>
> Let=E2=80=99s set aside some of the other fun concerns of eBPF in contain=
ers:
>  - Requiring mounting of vmlinux, bpffs, traces etc=E2=80=A6
>  - How fs permissions on host translate into permissions in containers
>
> While your proposal lets you grant a subset of CAP_BPF to some other proc=
ess,
> which I imagine could also be done with SELinux, it doesn=E2=80=99t stop =
you from needing
> other required permissions for attaching tracing programs in such an
> environment.

In some cases yes, there are other parts of the kernel that would
require some more work to be able to be used. But a lot of things are
possible within bpf() syscall already, including tracing stuff.

>
> For example, say container A wants to attach a uprobe to a process in con=
tainer B.
> Container A needs to be able to nsenter into container B=E2=80=99s pidns =
in order for attachment
> to succeed=E2=80=A6 but then what I can do with CAP_BPF is the least of m=
y concerns since
> I=E2=80=99d wager I=E2=80=99d need to mount `/proc` from the host in cont=
ainer A + have elevated privileges
> much scarier than CAP_BPF in the first place.

You'd wager, or you know for sure? I haven't tried, so I won't make any cla=
ims.

I do know, though, that our systemd-wide profiling agent (not running
under user namespace), can attach to and profile namespaced
applications running inside containers without any nsenter.

But again, uprobe'ing some other container is just one of possible use
cases. Even if some scenarios would require more stuff beyond the BPF
token, it doesn't invalidate the need and usefulness of the BPF token.

>
> If you move =E2=80=9CLoading and attaching=E2=80=9D away to somewhere els=
e (i.e a daemon like bpfd)
> then with recent kernels your container workload should be fine to run en=
tirely unprivileged,
> or worst case with only CAP_BPF since all you need to do is read/write ma=
ps.

Except we explicitly want to avoid the need for some external entity
loading BPF programs on my behalf, like I explained in replies to
Toke.

>
> Policy control - which process can request to load programs that monitor =
which other
> processes - would happen within this system daemon and you wouldn=E2=80=
=99t need tokens.

And we can do the same through controlling which containers/services
are issued BPF tokens. And in addition to that could employ LSM for
more dynamic and fine-granular control.

Doing this through a centralized daemon is one way of doing this. But
it's not the universally better way to do this.

>
> Since it=E2=80=99s easy enough to do this in userspace, I=E2=80=99d be st=
rongly against adding more
> complexity into BPF to support this usecase.

I appreciate you trying to get more customers for bpfd, there is
nothing wrong with that. But this approach has major (good and bad)
implications and is not the most appropriate solution in a lot of
cases and setups.

As for complexity. If you looked at the code, you saw that it's a
completely optional feature as far as BPF UAPI goes, so your customers
won't need to care about BPF token existence, if they are happy using
bpfd solution.

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
> > syscall accepts token_fd parameters explicitly for each relevant BPF co=
mmand.
> > This addresses main concerns brought up during the /dev/bpf discussion,=
 and
> > fits better with overall BPF subsystem design.
> >
> > This patch set adds a basic minimum of functionality to make BPF token =
useful
> > and to discuss API and functionality. Currently only low-level libbpf A=
PIs
> > support passing BPF token around, allowing to test kernel functionality=
, but
> > for the most part is not sufficient for real-world applications, which
> > typically use high-level libbpf APIs based on `struct bpf_object` type.=
 This
> > was done with the intent to limit the size of patch set and concentrate=
 on
> > mostly kernel-side changes. All the necessary plumbing for libbpf will =
be sent
> > as a separate follow up patch set kernel support makes it upstream.
> >
> > Another part that should happen once kernel-side BPF token is establish=
ed, is
> > a set of conventions between applications (e.g., systemd), tools (e.g.,
> > bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through=
 BPF FS
> > at well-defined locations to allow applications take advantage of this =
in
> > automatic fashion without explicit code changes on BPF application's si=
de.
> > But I'd like to postpone this discussion to after BPF token concept lan=
ds.
> >
> >  [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.=
org/
> >  [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_B=
PF_LSFMM2023.pdf
> >  [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubravin=
g@fb.com/
> >
>
> - Dave
>
> [1]: https://github.com/bpfd-dev/bpfd
>

