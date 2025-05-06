Return-Path: <bpf+bounces-57492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE48FAABD10
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623EC3A8082
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B859247289;
	Tue,  6 May 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="phs/DWbu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC821ADAE
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519919; cv=none; b=D6qs76pD/oi3ZKtnpVtwpTxR5pwUMsFH65ppfVOQkfc11tHzl5ghsCSNJ+o7Zh8nqxhFnENgtw92MaQ0um+YaGCC9ynTdicp7XvLrt6dz6EszKQGTmvuA/Ofp59cPzs4BB3jF9Tc6meUjHLhZDLZjCWl81aqSxpKQ2wXwAjbhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519919; c=relaxed/simple;
	bh=YSWl+QfwkOnRfAH90XS1/0eMYPBj00WkhiTyiofpPcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjtvUDk2LeOho76ZxciF0CKK7ioyheWNOMb1DrewPNj2babTaTBbQWDb5A5D9iVuUfRP4PjkmPY3++I/H1kGf4bac2jWKxIDWCWfkN7COErjphQxdRQ/gM6orHO3UnP06BKZTqn0Bxlfsy7+k8hHduC7GTxr9znMFvyTYCOXmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=phs/DWbu; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZsBKP0tKlzxvW;
	Tue,  6 May 2025 10:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746519913;
	bh=i4kB+dqu3Gkr/hdwa8JkKng9U1uVnoBQB3MDCaMXOP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phs/DWbuE3BjYaFDGc4kP6Y06gZrB3iNk0R3hNh9ysHb0gtRc8uz9Dkm5ND/BnUK6
	 xJAMq5cUXkfBNSxP0SEL/Ym0gUDuX5jsHjqfHAv7JyXCKKE2weLd0jQP4lQasVdp4m
	 ty90N4LjlRdoOdU7l1TMBH9ZgDdF/PmQkyttd7/o=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZsBKL3wtjz4m9;
	Tue,  6 May 2025 10:25:10 +0200 (CEST)
Date: Tue, 6 May 2025 10:25:09 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	selinux@vger.kernel.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at
 security_unix_may_send().
Message-ID: <20250506.ahjae2Beemuo@digikod.net>
References: <20250505215802.48449-1-kuniyu@amazon.com>
 <20250505215802.48449-5-kuniyu@amazon.com>
 <CAADnVQK1t3ZqERODdHJM_HaZDMm+JH4OFvwTsLNqZG0=4SQQcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK1t3ZqERODdHJM_HaZDMm+JH4OFvwTsLNqZG0=4SQQcA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, May 05, 2025 at 05:13:32PM -0700, Alexei Starovoitov wrote:
> On Mon, May 5, 2025 at 3:00 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > As Christian Brauner said [0], systemd calls cmsg_close_all() [1] after
> > each recvmsg() to close() unwanted file descriptors sent via SCM_RIGHTS.
> >
> > However, this cannot work around the issue that close() for unwanted file
> > descriptors could block longer because the last fput() could occur on
> > the receiver side once sendmsg() with SCM_RIGHTS succeeds.
> >
> > Also, even filtering by LSM at recvmsg() does not work for the same reason.
> >
> > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> >
> > Let's add a new kfunc to scrub all file descriptors from skb in
> > sendmsg().
> >
> > This allows the receiver to keep recv()ing the bare data and disallows
> > the sender to impose the potential slowness of the last fput().
> >
> > If necessary, we can add more granular filtering per file descriptor
> > after refactoring GC code and adding some fd-to-file helpers for BPF.
> >
> > Sample:
> >
> > SEC("lsm/unix_may_send")
> > int BPF_PROG(unix_scrub_scm_rights,
> >              struct socket *sock, struct socket *other, struct sk_buff *skb)
> > {
> >         struct unix_skb_parms *cb;
> >
> >         if (skb && bpf_unix_scrub_fds(skb))
> >                 return -EPERM;
> >
> >         return 0;
> > }
> 
> Any other programmability do you need there?
> 
> If not and above is all that is needed then what Jann proposed
> sounds like better path to me:
> "
> I think the thorough fix would probably be to introduce a socket
> option (controlled via setsockopt()) that already blocks the peer's
> sendmsg().
> "
> 
> Easier to operate and upriv process can use such setsockopt() too.

Adding a flag with setsockopt() will enable any program to protect
themselves instead of requiring the capability to load an eBPF program.
For the systemd use case, I think a flag would be enough, and it would
benefit more than only/mainly systemd.

Another thing is that we should have a consistent user space error code
if passing file descriptors is denied, to avoid confusing senders, to
not silently ignore dropped file descriptors, and to let the sender know
that it can send again but without passed file descriptors or maybe with
a maximum number of file descriptors.  The ENFILE errno (file table
overflow) looks like a good candidate.

I guess both approaches are valuable, but this series should add this
new flag as well, and specify the expected error handling.

If we want to be able to handle legacy software not using this new flag,
we can leverage seccomp unotify.

