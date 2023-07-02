Return-Path: <bpf+bounces-3849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67EF744C7A
	for <lists+bpf@lfdr.de>; Sun,  2 Jul 2023 08:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D044280DFA
	for <lists+bpf@lfdr.de>; Sun,  2 Jul 2023 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F41385;
	Sun,  2 Jul 2023 06:59:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F621115
	for <bpf@vger.kernel.org>; Sun,  2 Jul 2023 06:59:47 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568B10E7;
	Sat,  1 Jul 2023 23:59:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so3637005276.3;
        Sat, 01 Jul 2023 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688281184; x=1690873184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCCztWMMwlGf3AeF1NttvJPdBKuAtguV+m9UFrNGuTw=;
        b=JuE/RSMyyleh3SuwXo7aJWNrw6rTO8lvd5jGIuzmCIgLwry+EeldndijDEOmfpr/Nq
         m6710DEudKxYPfItF1g1V4C3rk7qaxW8PdAa0Sr+Hfv5o8tY+mXwD++zjIFmOMXcIZYA
         f1GVEnUgVxewlsb4h1i3QpyrUFn+OSKiYlDvK+J5czOoJzbIC0Xn6iLemQNvkLiqQweZ
         YmvHBhWP6HXSwrrHKH5SX1+uAlINjVBCkop+jA1C4VV5pA43YUgE0Nrpy/pgbeUEy7oy
         bOPk9Z5CVekD6XsRZfg5WEbLWfM80tIb+Bgn51OQcFfhNTjsMcSdMKWpmuAGl4pF9CHz
         32NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688281184; x=1690873184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCCztWMMwlGf3AeF1NttvJPdBKuAtguV+m9UFrNGuTw=;
        b=W2l6xNWZ7095h1q3cIT3grqCx5CK9ARP+T1GtBMzKFqdYmWFu82YweTUAXO9QEqTgi
         KhCxZfjZfZppMKAfss9qOTdzDQGSoibGWCJVnN1xYAnBD91sTyyFGPa6QBVF/CRbesZt
         tfgGED4Z+TJxPgGxTQSDVMDkw5hohd2Q37NOmdf6OPMcyV3ZLruw77U72FrY5NZvWvU2
         3VW5vaUxWhMB4jCvlRDeaSVwM+otNeHgmqHJ2zrof29HY+UQ3LjFC9xfzLYh601kMJGb
         LPbWPdZ+dNNd3KfQIwChyVpbumQ/M0fRV2MzgCDi2gN+EuN6UktkZalpybIixvA8w3c9
         br+Q==
X-Gm-Message-State: ABy/qLZCLBTQWgQmRnoc52f3x0hT6aziyeuLVQ2j26O8Xv/yyfRMxlaa
	WlUToegBL2Nokgwt+uXREYqaN+JZgdaK2RlkjoE=
X-Google-Smtp-Source: APBJJlFHQ7vC1ccvQuxkuTU+uFX9Y3EBPqdkezCtdTcXTe/p3ubimAGzHEcUtmTyIXk1/C1jb3IKShxWS2WlBRnlGoY=
X-Received: by 2002:a25:7105:0:b0:c1b:c138:46f4 with SMTP id
 m5-20020a257105000000b00c1bc13846f4mr6671540ybc.27.1688281183735; Sat, 01 Jul
 2023 23:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <87sfa9eu70.fsf@toke.dk>
In-Reply-To: <87sfa9eu70.fsf@toke.dk>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Sun, 2 Jul 2023 08:59:17 +0200
Message-ID: <CAEiveUf49kP9Ch8XvsZcwUQKPH_HqCPSP_8WXNW+sztkJDmNMw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:16=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > This patch set introduces new BPF object, BPF token, which allows to de=
legate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about all=
owing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application th=
at
> > would create a BPF token, as different production setups can and do ach=
ieve it
> > through a combination of different means (signing, LSM, code reviews, e=
tc),
> > and it's undesirable and infeasible for kernel to enforce any particula=
r way
> > of validating trustworthiness of particular process.
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
> So a colleague pointed out today that the Seccomp Notify functionality
> would be a way to achieve your stated goal of allowing unprivileged
> containers to (selectively) perform bpf() syscall operations. Christian
> Brauner has a pretty nice writeup of the functionality here:
> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-u=
nprivileged-container-development
>
> In fact he even mentions allowing unprivileged access to bpf() as a
> possible use case (in the second-to-last paragraph).
>
> AFAICT this would enable your use case without adding any new kernel
> functionality or changing the BPF-using applications, while allowing the
> privileged userspace daemon to make case-by-case decisions on each
> operation instead of granting blanket capabilities (which is my main
> objection to the token proposal, as we discussed on the last iteration
> of the series).
>
> So I'm curious whether you considered this as an alternative to
> BPF_TOKEN? And if so, what your reason was for rejecting it?

The Seccomp notifier is an answer 1. to special device nodes (or
arguably to simple cases...) , 2. a quick solution without changing
infrastructure and how the kernel deals with device nodes (doesn't
solve the root problem where this BPF series at least tries...), 3.
relies on Seccomp and would inherit its same limitation.

It clashes with BPF! BPF is not mknod, and most of its use cases are
*transparent to the workload*, they can't use Seccomp and are not
interested in it... Fd delegation is good design and applies to *all*
BPF use cases, all tools can take advantage of it, it is not
restricted to a special tool or daemon X.

Going further, hiding behind Seccomp notifier and such prevents BPF
from solving current and future problems.

