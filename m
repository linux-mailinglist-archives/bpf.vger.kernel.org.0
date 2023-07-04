Return-Path: <bpf+bounces-3971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB387472C7
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F50280E2A
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22698612C;
	Tue,  4 Jul 2023 13:35:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D566124
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 13:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4987FC433C8;
	Tue,  4 Jul 2023 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688477699;
	bh=4fIdqmkmI54Oh77XXTPqwjpIa6KwTwouD5cjsGMfpSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ebm3P5vgn5B1Vi6D9oR8jYsq2XX/gv0J0Y3+Zu2XYLY497zrV1k/nJZNw4+kMzged
	 jmGxsbteqrcho4XvQE+0tF7dNX1SFD5mmJp3u5YhHNqrZC2oHAcHg+Tb8TOvaHzgD0
	 +j5VlrhjqxA8AXcAc3SrQ0cqFBfbG4bJIp8vS56ojWGXSq05PkDmxApZ6JghR1mkPL
	 Y84RDozwpwsJNRTk4to0uz2U9qLmQUKcC/eCbIxqpTGI64kB75ZEvRlXVY3qbG6ZMw
	 hoTKgsCM73liJxSIV/YZElGpy9D6lPIeWWDsCPmBPP+IDo5mMKMJTunGIwTeqoshyp
	 +sTHrWM6CXGSw==
Date: Tue, 4 Jul 2023 15:34:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
	luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
Message-ID: <20230704-gourmet-radius-55a8d9c4c9e5@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230704-hochverdient-lehne-eeb9eeef785e@brauner>

On Tue, Jul 04, 2023 at 02:43:59PM +0200, Christian Brauner wrote:
> On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while have a good amount of control over which
> > privileged operations could be performed using provided BPF token.
> > 
> > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> > allows to create a new BPF token object along with a set of allowed
> > commands that such BPF token allows to unprivileged applications.
> > Currently only BPF_TOKEN_CREATE command itself can be
> > delegated, but other patches gradually add ability to delegate
> > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > 
> > The above means that new BPF tokens can be created using existing BPF
> > token, if original privileged creator allowed BPF_TOKEN_CREATE command.
> > New derived BPF token cannot be more powerful than the original BPF
> > token.
> > 
> > Importantly, BPF token is automatically pinned at the specified location
> > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
> > command, unlike BPF prog/map/btf/link. This provides more control over
> > unintended sharing of BPF tokens through pinning it in another BPF FS
> > instances.
> > 
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> 
> The main issue I have with the token approach is that it is a completely
> separate delegation vector on top of user namespaces. We mentioned this
> duringthe conf and this was brought up on the thread here again as well.
> Imho, that's a problem both security-wise and complexity-wise.
> 
> It's not great if each subsystem gets its own custom delegation
> mechanism. This imposes such a taxing complexity on both kernel- and
> userspace that it will quickly become a huge liability. So I would
> really strongly encourage you to explore another direction.
> 
> I do think the spirit of your proposal is workable and that it can
> mostly be kept in tact.
> 
> As mentioned before, bpffs has all the means to be taught delegation:
> 
>         // In container's user namespace
>         fd_fs = fsopen("bpffs");
> 
>         // Delegating task in host userns (systemd-bpfd whatever you want)
>         ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "delegate", ...);
> 
>         // In container's user namespace
>         fd_mnt = fsmount(fd_fs, 0);
> 
>         ret = move_mount(fd_fs, "", -EBADF, "/my/fav/location", MOVE_MOUNT_F_EMPTY_PATH)
> 
> Roughly, this would mean:
> 
> (i) raise FS_USERNS_MOUNT on bpffs but guard it behind the "delegate"
>     mount option. IOW, it's only possibly to mount bpffs as an
>     unprivileged user if a delegating process like systemd-bpfd with
>     system-level privileges has marked it as delegatable.
> (ii) add fine-grained delegation options that you want this
>      bpffs instance to allow via new mount options. Idk,
> 
>      // allow usage of foo
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "foo");
> 
>      // also allow usage of bar
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "bar");
> 
>      // reset allowed options
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "");
> 
>      // allow usage of schmoo
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "schmoo");

This is really just one crummy way of doing this. It's ofc possible to
make this a binary struct if you wanted to; of any form:

struct bpf_delegation_opts {
	u64 a;
	u64 b;
	u64 c;
	u32 d;
	u32 e;
};

and then

struct bpf_delegation_opts opts = {
	.a = SOMETHING_SOMETHING,
	.d = SOMETHING_SOMETHING_ELSE,
};

fsconfig(fd_fs, FSCONFIG_SET_BINARY, "abilities", &opts, sizeof(opts));

you'll get:

param->size == sizeof(opts);
param->blob = memdup_user_nul();

and then you can version this by size like we do for extensible structs
and change whatever you'd like to change in the future.

