Return-Path: <bpf+bounces-4029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40B748008
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5665B280C74
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FC46AD;
	Wed,  5 Jul 2023 08:45:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E617FE
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 08:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6227C433C7;
	Wed,  5 Jul 2023 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688546756;
	bh=bCExwKjLQQCGYF1Uq8o6XXNVt2wSjeOVz9aBSM8jfaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtCIgVZJDhEH2e7xHRwR2fPmdcwH5dsgi1/OrimhBn2Hx75t28XiosAxfpGW7vyzz
	 afhPV9TdZzHvstRYA3tLWLgg24C9qEQ3fpDkIEWjRpJA0WU/w12JJv33rKa/jAsjRv
	 u92ElOqvkRN7K2yrSfRHrmIBvxO9KVGwbniIBpbDQg9P8AG6Mc87t2Bbz6Vj93FX03
	 s1325MEAU593KjLay9x1mdwzLNuKN8+qa00boM2bR8i+47l9XJrMCiiqASOA3jQ9AJ
	 lGkkIL4iRq/aRZb71NednQ0q1IU0k5ZOGa9eMb822jXFWuT/eOmVrjI/9C/8+Su7hQ
	 uec9f1sVqoE3Q==
Date: Wed, 5 Jul 2023 10:45:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
Message-ID: <20230705-praxen-nahmen-644ea9e5c35c@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <87sfa3b6j5.fsf@toke.dk>
 <3555c0bd-7aee-35b0-655d-710437b4876c@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3555c0bd-7aee-35b0-655d-710437b4876c@iogearbox.net>

On Wed, Jul 05, 2023 at 09:20:28AM +0200, Daniel Borkmann wrote:
> On 7/5/23 1:28 AM, Toke Høiland-Jørgensen wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> > > On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> > > > Add new kind of BPF kernel object, BPF token. BPF token is meant to to
> > > > allow delegating privileged BPF functionality, like loading a BPF
> > > > program or creating a BPF map, from privileged process to a *trusted*
> > > > unprivileged process, all while have a good amount of control over which
> > > > privileged operations could be performed using provided BPF token.
> > > > 
> > > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> > > > allows to create a new BPF token object along with a set of allowed
> > > > commands that such BPF token allows to unprivileged applications.
> > > > Currently only BPF_TOKEN_CREATE command itself can be
> > > > delegated, but other patches gradually add ability to delegate
> > > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > > > 
> > > > The above means that new BPF tokens can be created using existing BPF
> > > > token, if original privileged creator allowed BPF_TOKEN_CREATE command.
> > > > New derived BPF token cannot be more powerful than the original BPF
> > > > token.
> > > > 
> > > > Importantly, BPF token is automatically pinned at the specified location
> > > > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
> > > > command, unlike BPF prog/map/btf/link. This provides more control over
> > > > unintended sharing of BPF tokens through pinning it in another BPF FS
> > > > instances.
> > > > 
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > 
> > > The main issue I have with the token approach is that it is a completely
> > > separate delegation vector on top of user namespaces. We mentioned this
> > > duringthe conf and this was brought up on the thread here again as well.
> > > Imho, that's a problem both security-wise and complexity-wise.
> > > 
> > > It's not great if each subsystem gets its own custom delegation
> > > mechanism. This imposes such a taxing complexity on both kernel- and
> > > userspace that it will quickly become a huge liability. So I would
> > > really strongly encourage you to explore another direction.
> > 
> > I share this concern as well, but I'm not quite sure I follow your
> > proposal here. IIUC, you're saying that instead of creating the token
> > using a BPF_TOKEN_CREATE command, the policy daemon should create a
> > bpffs instance and attach the token value directly to that, right? But
> > then what? Are you proposing that the calling process inside the
> > container open a filesystem reference (how? using fspick()?) and pass
> > that to the bpf syscall? Or is there some way to find the right
> > filesystem instance to extract this from at the time that the bpf()
> > syscall is issued inside the container?
> 
> Given there can be multiple bpffs instances, it would have to be similar
> as to what Andrii did in that you need to pass the fd to the bpf(2) for
> prog/map creation in order to retrieve the opts->abilities from the super
> block.

I think it's pretty flexible what one can do here. Off the top of my
head there could be a dedicated file like /sys/fs/bpf/delegate which
only exists if delegation has been enabled. Thought that might be just a
wasted inode. There could be a new ioctl() on bpffsd which has the same
effect.

Probably an ioctl() on the bpffs instance is easier to grok. You could
even take away rights granted by a bpffs instance from such an fd via
additional ioctl() on it.

For increased limitations, it's also possible to have an optional
write-time security check from within the bpf call itself, e.g.,

    sys_bpf(fd_delegate)
    {
                struct fd fd = fdget_raw(fd_delegate);

                /* That token is only valid within a single user namespace ... */
                if (fd.file->f_cred->user_ns != current_user_ns())
                        return -EINVAL;

                /* woah, no CAP_BPF? */
                if (!ns_capable(fd.file->cred->user_ns, CAP_BPF))
                        return -EPERM;

                /* now check abilities */

                return 0;
    }

I'm not claiming that this is the silver bullet but it fits within the
framework of this approach and explicitly ties it into bpffs right from
the get go since this is the delegation mechanism's core.

The systemd-bpfd approach that was once pushed could probably also work
and I'm not up to date on why this was rejected. The issue against
systemd is still open.

