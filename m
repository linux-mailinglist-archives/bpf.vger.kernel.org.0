Return-Path: <bpf+bounces-57501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3895AABEE5
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 11:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8607B6613
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A17267391;
	Tue,  6 May 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V91zxqsE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179812BF24;
	Tue,  6 May 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522954; cv=none; b=sVmglijb2vbk9zQrbtLOCIVm3CfFEN3vSyEyjQMvBvM7H4hTIjI4HFN1518+EF9JW7kkdzTXQ+CUgx5EycxkrstrKdSlbDu99KCxx1muqowrRCxp0WftY1ug2N+DhrIXU8yJLHUX/o5IDMgnuhlCpZEx1lSAyopnzzD2wdlimhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522954; c=relaxed/simple;
	bh=1Y97fGZ2pcgpkQySDAiBpuDx1JxFWgJKA6h5L7yFJN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2hRSj6BPAEqdvW7F14r9yLFaOg75s4I9+9VU+ZVXgnnlyCLqoyf19cKBvc/Py/oSQyaTIe43Ofcy0tMN6RRAPtATbUHN+gwTE51Spq+bm9yptKXQEGlq1zO3AReVTQmgRuOPoih+i7g1C1gFrAr2eVk76oGThYnxbueGJdgEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V91zxqsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84159C4CEE4;
	Tue,  6 May 2025 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746522953;
	bh=1Y97fGZ2pcgpkQySDAiBpuDx1JxFWgJKA6h5L7yFJN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V91zxqsEGgxeKAXgbJuN86woyLZknZxRnTFXGUwXFeZw61HnjHLekUic9XBe9Mo6J
	 mmKx+Rf2GInYAGaTvmSUbOkPNc5UX4qM9h0NIJOp+zg797K+OAMXY9ifb/00VhHzBa
	 oszvGl7rWiHfNWpKdwA1UWgbCAb/j9+KWxjGtDpcXwQpGVdbo2lFQlmkam54qERIap
	 5TqtI4YSbhwJoo1kOnYvDTvMFj9PsTLXQ5fgH8T+okj02eM+DzrdpVBbwFjjlq/cCb
	 xG44f/jJ5nn1mD9I4lq04yvGzb6+EV8MwVv9GTuWHFD/wLKFYqdXhWfcaXwbJTcWYy
	 wbqyNstTd5/SA==
Date: Tue, 6 May 2025 11:15:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
Message-ID: <20250506-eitel-gerede-7c8b5e556a2c@brauner>
References: <20250505215802.48449-1-kuniyu@amazon.com>
 <CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com>

On Tue, May 06, 2025 at 12:49:11AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 5 May 2025 at 23:58, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> > possible to avoid receiving file descriptors via SCM_RIGHTS.
> >
> > This behaviour has occasionally been flagged as problematic.
> >
> > For instance, as noted on the uAPI Group page [0], an untrusted peer
> > could send a file descriptor pointing to a hung NFS mount and then
> > close it.  Once the receiver calls recvmsg() with msg_control, the
> > descriptor is automatically installed, and then the responsibility
> > for the final close() now falls on the receiver, which may result
> > in blocking the process for a long time.
> >
> > systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> > unwanted file descriptors sent via SCM_RIGHTS.
> >
> > However, this cannot work around the issue because the last fput()
> > could occur on the receiver side once sendmsg() with SCM_RIGHTS
> > succeeds.  Also, even filtering by LSM at recvmsg() does not work
> > for the same reason.
> >
> > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> >
> > This series allows BPF LSM to inspect skb at sendmsg() and scrub
> > SCM_RIGHTS fds by kfunc.
> >
> > Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
> > Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
> >
> 
> This sounds pretty useful!
> 
> I think you should mention the cases of possible DoS on close() or
> flooding, e.g. with FUSE controlled fd/NFS hangs in the commit log
> itself.
> I think it's been an open problem for a while now with no good solution.
> Currently systemd's FDSTORE=1 for PID 1 is susceptible to the same
> problem, even if the underlying service isn't root.
> 
> I think it is also useful for restricting what individual file
> descriptors can be passed around by a process.
> Say restricting usage of an fd to a process and its children, but not
> allowing it to be shared with others.
> Send side hook is the right point to enforce it.
> 
> Therefore exercising scm_fp_list would be a good idea.

No, that's a terrible idea. If the receiver expects 10 file descriptors
and suddenly some magically disappear or the order gets messed up that's
terrible for security. It's either close all or nothing.

> We should provide some more examples of the filtering policy in the selftests.
> Maybe a simple example, e.g. only memfd or a pipe fd can be passed,
> and nothing else.
> It would require checking file->f_ops.

There's not going to be poking around in file->f_ops for this.

Really, what I asked for was a simple way to set a socket option without
any bpf or lsm involvement so even really dumb userspace can simply
block receiving any file descriptors. How that spiraled into "let's
apply arbitrary filters on SCM_RIGHTS and make files disappear on the
way" is beyond me.

