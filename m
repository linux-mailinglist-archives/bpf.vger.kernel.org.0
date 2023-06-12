Return-Path: <bpf+bounces-2421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299272CABE
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E706628113C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83721E52E;
	Mon, 12 Jun 2023 15:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE21DDFB
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:53:15 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0DCA;
	Mon, 12 Jun 2023 08:53:14 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43c380dd87eso5582137.2;
        Mon, 12 Jun 2023 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686585193; x=1689177193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kHYwyjY2Mx4tPXnbNJmtEwG3++/AUQq9JXIgugccBI=;
        b=LtKtLJVpq95dt/C283kO1r7ZtRR0DSsmoSp4hjDJ5ZFN9MdxREpZ5263PvFqFlLZ/k
         puV859gRyww95qMYj3Mf5GJqNVagkE8eMQWaEcmwJTC294EoFRKQ3XgM3EDAJTsddxr6
         WLyx2s/mkdpz4hBELiKJxS/e3uhZO87fIZ4KQAgG8lz2+Q2+KCKZWoYtx0xaC2KClCKS
         tUsstxHtpuTyTa0DL8i2nzKsi8pGs1qiRsbnclBmgoUnMtdMmK2w8+WzcYY/3touX9ob
         +DaPNgihrAJV8DckvVGnH9MDG273vdLgl4d6QueDrdt0RGXxj5sOe9H+yaNJfiMkifRn
         8+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585193; x=1689177193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kHYwyjY2Mx4tPXnbNJmtEwG3++/AUQq9JXIgugccBI=;
        b=EPQBiMmf2qnH9RA+Wxf1YqSwR1uWBnW3Kmz50OPmD8/v+tZFETzikM7kj2j4ACMENG
         ttQJMU9FlSzHyAOpAdKASgOWRBo7XSb5PZFv+MSPA8DlmJaHXTj+5N3ISxhWg5nZlfo0
         Lfh5K09TlWEwkHPKhK3oeUu3Bfl+BmpZC6pKyeSrFvTf52FuiEO7oj4ay+JEH2zeunZq
         BZoEjbol9Yuh3XqzUEX804ASnFXOl5nuBTi4CrNmw+A6r7YLckNw8zPwJmUvtk4+DVG3
         L5AzHxUjhRFMeH5P14hF0rpa/yMYBwqI7FcfY18KVf/kolE1H5OFh+J17UbJ9f0YsDAZ
         SiZQ==
X-Gm-Message-State: AC+VfDznjdlJUX/R9Wmbj6qXUjtrIqLo+FnH4jw0lvFqGVhMtAJ5z459
	2G1CNM2Z7f6ujHQdQN2pnj2K6S3z3WP31+Qsk+V5SnW9nrs2jg==
X-Google-Smtp-Source: ACHHUZ51V/dxMG1thd7OWRwa/l+D5ZEk7egdIMlAeWx6wrzceN8grCvuCGpVo3ousg4h2I54OEPfxOlK0GLSTF9prP8=
X-Received: by 2002:a67:f490:0:b0:43b:1dfa:2534 with SMTP id
 o16-20020a67f490000000b0043b1dfa2534mr4382835vsn.10.1686585193230; Mon, 12
 Jun 2023 08:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <1BEB36A1-9FE4-4552-B2FF-DE6DF74F3756@redhat.com>
In-Reply-To: <1BEB36A1-9FE4-4552-B2FF-DE6DF74F3756@redhat.com>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Mon, 12 Jun 2023 17:52:46 +0200
Message-ID: <CAEiveUeUKi1dFmrfGuTh36=kgXRjQT=xNwTsi8fk_qrk6e-QJA@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 2:45=E2=80=AFPM Dave Tucker <datucker@redhat.com> w=
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
>
> other required permissions for attaching tracing programs in such an
> environment.
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
>
> If you move =E2=80=9CLoading and attaching=E2=80=9D away to somewhere els=
e (i.e a daemon like bpfd)
> then with recent kernels your container workload should be fine to run en=
tirely unprivileged,
> or worst case with only CAP_BPF since all you need to do is read/write ma=
ps.
>
> Policy control - which process can request to load programs that monitor =
which other
> processes - would happen within this system daemon and you wouldn=E2=80=
=99t need tokens.
>
> Since it=E2=80=99s easy enough to do this in userspace, I=E2=80=99d be st=
rongly against adding more
> complexity into BPF to support this usecase.

For some cases complexity could be the other way, bpf by design are
small programs that can be loaded/unloaded dynamically and work on
their own... easily adaptable to dynamic workload... not all bpf are
the same...

Stuffing *everything* together and performing round trips between main
container and container transfering, loading and attaching bpf
programs would question what's the advantage?

