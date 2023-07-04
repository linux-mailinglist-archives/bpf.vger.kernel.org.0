Return-Path: <bpf+bounces-3952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0ED746E00
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6331C28098B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3853A6;
	Tue,  4 Jul 2023 09:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD49539F
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 09:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A2C433C8;
	Tue,  4 Jul 2023 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688464319;
	bh=vTzJCWSm3RPaGk9LEfK7QE5m4UMrj/ejn3sCq85uG7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4wMatb9Fotj+e9UWmkQLrHcYieW70DS14+XEHXtfeIj74QkZH5qnXWMgcegeiqX7
	 9DWz9bXotEjsfnJcxCwVlAtWti6b5rGqqdG5iPMhoITao+9VFEv8xzPObh8PiMofUH
	 NnitqOhkLCAbl6L7yd/BTuRgiUl++uZbjzApYrG7Lyak7i9X8ULz+ysPx13XHRlx/u
	 QeRjSxn87KymZMUD0L5DuibAYpgARHnARoqBRRdBwe//fbN3NEj1MPfDTLgghTfVlf
	 x2ZrGRyVlbwRgu8irQXp/GslG7L97dtiyMn6XyEeec1qTQ+3oyHddik1Q8Oy9vVH7c
	 S6ydWYx7D3E2Q==
Date: Tue, 4 Jul 2023 11:51:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
Message-ID: <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <87sfa9eu70.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfa9eu70.fsf@toke.dk>

On Fri, Jun 30, 2023 at 01:15:47AM +0200, Toke Høiland-Jørgensen wrote:
> Andrii Nakryiko <andrii@kernel.org> writes:
> 
> > This patch set introduces new BPF object, BPF token, which allows to delegate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about allowing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application that
> > would create a BPF token, as different production setups can and do achieve it
> > through a combination of different means (signing, LSM, code reviews, etc),
> > and it's undesirable and infeasible for kernel to enforce any particular way
> > of validating trustworthiness of particular process.
> >
> > The main motivation for BPF token is a desire to enable containerized
> > BPF applications to be used together with user namespaces. This is currently
> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
> > arbitrary memory, and it's impossible to ensure that they only read memory of
> > processes belonging to any given namespace. This means that it's impossible to
> > have namespace-aware CAP_BPF capability, and as such another mechanism to
> > allow safe usage of BPF functionality is necessary. BPF token and delegation
> > of it to a trusted unprivileged applications is such mechanism. Kernel makes
> > no assumption about what "trusted" constitutes in any particular case, and
> > it's up to specific privileged applications and their surrounding
> > infrastructure to decide that. What kernel provides is a set of APIs to create
> > and tune BPF token, and pass it around to privileged BPF commands that are
> > creating new BPF objects like BPF programs, BPF maps, etc.
> 
> So a colleague pointed out today that the Seccomp Notify functionality
> would be a way to achieve your stated goal of allowing unprivileged
> containers to (selectively) perform bpf() syscall operations. Christian
> Brauner has a pretty nice writeup of the functionality here:
> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-unprivileged-container-development

I'm amazed you read this. :)
The seccomp notifier comes with a lot of caveats. I think it would be
impractical if not infeasible to handle bpf() delegation.

> 
> In fact he even mentions allowing unprivileged access to bpf() as a
> possible use case (in the second-to-last paragraph).

Yeah, I tried to work around a userspace regression with the
introduction of the cgroup v2 devices controller.

