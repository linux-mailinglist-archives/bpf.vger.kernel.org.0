Return-Path: <bpf+bounces-3951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57327746DC0
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DC7280E5F
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22327525D;
	Tue,  4 Jul 2023 09:38:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60900539F
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 09:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BD0C433C8;
	Tue,  4 Jul 2023 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688463523;
	bh=MjijfA5rbAdH4++U85ZPif8qBdhLaly4RtVren1Uees=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryMmgVkA4jCx5pK/UQwRipK269ZgAuwp+k9/LZQ6rtFjpTX2jw/XEarKzXHYlLx9L
	 QZDkVj38z4yRPziIWWb3fzunMYOXpo3lEjsPJ8ec2PVImco115HTJtdHl5MjyDKQQN
	 6Tb4HLp21tQFC1zP/f5J5PICdrB5g+n+1BRES5gFXXGaGOV5Nv5/dfx3F6WhLMYal/
	 Oqd1G6CymfDIUQjLiVhjGUkWJJLak0VNvZy9BkLEVqIg9JFQMCr5H5FBpGTGPyuVfE
	 Xr/bOrjbStyQvmAno+E2f5tlKQSVzvFO/I5dDApkNb+mWSCnalz1b40zuDv6R648Au
	 5hrIClVaOcVLw==
Date: Tue, 4 Jul 2023 11:38:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
Message-ID: <20230704-pumpwerk-festakt-a8313d3ae90e@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <87sfa9eu70.fsf@toke.dk>
 <CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>

On Fri, Jun 30, 2023 at 11:25:57AM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 29, 2023 at 4:15 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >
> > Andrii Nakryiko <andrii@kernel.org> writes:
> >
> > > This patch set introduces new BPF object, BPF token, which allows to delegate
> > > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > > systemd or any other container manager) to a *trusted* unprivileged
> > > application. Trust is the key here. This functionality is not about allowing
> > > unconditional unprivileged BPF usage. Establishing trust, though, is
> > > completely up to the discretion of respective privileged application that
> > > would create a BPF token, as different production setups can and do achieve it
> > > through a combination of different means (signing, LSM, code reviews, etc),
> > > and it's undesirable and infeasible for kernel to enforce any particular way
> > > of validating trustworthiness of particular process.
> > >
> > > The main motivation for BPF token is a desire to enable containerized
> > > BPF applications to be used together with user namespaces. This is currently
> > > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
> > > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
> > > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
> > > arbitrary memory, and it's impossible to ensure that they only read memory of
> > > processes belonging to any given namespace. This means that it's impossible to
> > > have namespace-aware CAP_BPF capability, and as such another mechanism to
> > > allow safe usage of BPF functionality is necessary. BPF token and delegation
> > > of it to a trusted unprivileged applications is such mechanism. Kernel makes
> > > no assumption about what "trusted" constitutes in any particular case, and
> > > it's up to specific privileged applications and their surrounding
> > > infrastructure to decide that. What kernel provides is a set of APIs to create
> > > and tune BPF token, and pass it around to privileged BPF commands that are
> > > creating new BPF objects like BPF programs, BPF maps, etc.
> >
> > So a colleague pointed out today that the Seccomp Notify functionality
> > would be a way to achieve your stated goal of allowing unprivileged
> > containers to (selectively) perform bpf() syscall operations. Christian
> > Brauner has a pretty nice writeup of the functionality here:
> > https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-unprivileged-container-development
> >
> > In fact he even mentions allowing unprivileged access to bpf() as a
> > possible use case (in the second-to-last paragraph).
> >
> > AFAICT this would enable your use case without adding any new kernel
> > functionality or changing the BPF-using applications, while allowing the
> > privileged userspace daemon to make case-by-case decisions on each
> > operation instead of granting blanket capabilities (which is my main
> > objection to the token proposal, as we discussed on the last iteration
> > of the series).
> 
> It's not "blanket" capabilities. You control types or maps and
> programs that could be created. And again, CAP_SYS_ADMIN guarded.
> Please, don't give CAP_SYS_ADMIN/root permissions to applications you
> can't be sure won't do something stupid and blame kernel API for it.
> 
> After all, the root process can setuid() any file and make it run with
> elevated permissions, right? Doesn't get more "blanket" than that.
> 
> >
> > So I'm curious whether you considered this as an alternative to
> > BPF_TOKEN? And if so, what your reason was for rejecting it?
> >
> 
> Yes, I'm aware, Christian has a follow up short blog post specifically
> for using this for proxying BPF from privileged process ([0]).
> 
> So, in short, I think it's not a good generic solution. It's very
> fragile and high-maintenance. It's still proxying BPF UAPI (except
> application does preserve illusion of using BPF syscall, yes, that
> part is good) with all the implications: needing to replicate all of
> UAPI (fetching all those FDs from another process, following all the
> pointers from another process' memory, etc), and also writing back all
> the correct things (into another process' memory): log content,
> log_true_size (out param), any other output parameters. What do we do
> when an application uses a newer version of bpf_attr that is supported
> by proxy? And honestly, I'm like 99% sure there are lots of less
> obvious issues one runs into when starting implementing something like
> this.
> 
> This sounds like a hack and nightmare to implement and support.
> Perhaps that indirectly is supported by the fact that even Christian
> half-jokingly calls this a crazy approach. That code basically is
> unchanged for the last three years, with only one fix from Christian
> one year after initial introduction ([1]) to fix a quirky issue
> related to the limitation of pidfd working only for thread group
> leaders. It also still supports only BPF_PROG_TYPE_CGROUP_DEVICE
> program loading, it doesn't support a bunch of newer BPF_PROG_LOAD
> fields and functionality, etc, etc.
> 
> So as a technical curiosity it's pretty cool and perhaps is the right
> tool for the job for very narrow specific use cases. But as a
> realistic generic approach that could be used by industry at large for
> safe BPF usage from namespaced containers -- not so much.

Some background... When BPF & cgroup moved the devices cgroup from a
file-based cgroup controller into a BPF program it was technically an
immediate widespread regression.

The cgroup v1 controller was file based and supported seemlessly
switching between allow- and denylists. Whether that was ever sensible
is a separate question.

But what this meant was that any container runtime that used a simple
file-based mechanism now had to generate a BPF device program that
mirrored the cgroup v1 semantic such that the old syntax of the cgroup
v1 device controller would be correctly translated into a BPF devices
program.

In addition, this broke some nesting scenarios. So intercepting bpf()
via seccomp was specifically done to avoid devices cgroup regressions.
It was never meant to be a generic solution.

It also doesn't work for all cases as the seccomp notifier's supervision
mechanism isn't really a clean solution.

It's a pipe dream that you can transparently proxy system calls for
another process via seccomp for sufficiently complex system calls. We
did it for specific use-cases where we could sufficiently guarantee that
they could be safe. But to make this work it would involve way more
invasive changes:

* nesting/stacking of seccomp notifiers
* clean handling of pointer arguments in-kernel such that you can safely
  continue system calls being sure that they haven't been modified. This
  is currently only possible in scenarios where safety is guaranteed by
  the kernel refusing nonsensical or unsafe arguments
* correct privilege handling
  The seccomp notifier emulates system calls in userspace and thus has
  to mimick the privilege context of the task it is emulating the system
  call for in such a way that (i) it allows it to succeed by avoiding the
  privilege limitations of why the given system call was supposed to be
  proxied in the first place, (ii) it doesn't allow to circumvent other,
  generic restrictions that would otherwise cause the system call to
  fail. It's like saying e.g., "execute with most of the proxied task's
  creds but let it have a few more privileges". That's frail as Linux
  creds aren't really composable. That's why we have override_creds()
  not "add_creds()" and "subtract_creds()" which would probably be
  nicer.

Or it would have to be a generic first class kernel proxy which begs the
question why not change the subsystems itself to do this cleanly.

