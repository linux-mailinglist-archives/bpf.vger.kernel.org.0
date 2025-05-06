Return-Path: <bpf+bounces-57500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D89EAABDFC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B9E1BC0FD8
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA76D263F5D;
	Tue,  6 May 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgSh9qd7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149F216399;
	Tue,  6 May 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521792; cv=none; b=UFh7H8BMPjcjdWbret/ZpW1C6nnA/dzDW2S24Hf/6NRLZzfEOpawKzutT9SlCPCDnXHMzoS/NSPZZ71WpAWKdoitTaF5U4qm54eKhqpwJPggrVyD8E9yO75eT7f33sw5paDcU+0w4eH6ExfLR7Q99SE4zskUumqH2cD5jEQYPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521792; c=relaxed/simple;
	bh=qVZHyp88JCrxll1HUvVH3F1uXrcyk8ebeewT3tzyUyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzsUOMEf0+NQmpBBy1FdwExzaYMaBrIUtQrma1ph9g6EBqvXDDrFGQMOr6kuITWbY6vht5B+/LRTufSXL8rFHLHKQ2immyR73JCX9U+4WPfVUEYchCUg0PQLVLBvN/aBt/pi+UR7RlMfl9S2Q6ak6AvG2UShJsmnPH9KbomU5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgSh9qd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942C1C4CEE4;
	Tue,  6 May 2025 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521792;
	bh=qVZHyp88JCrxll1HUvVH3F1uXrcyk8ebeewT3tzyUyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgSh9qd7o2kNDeo3OZ+KzR2Pj1P3AWvczzbjaZsNdGHLLQEY7U0W7rlgoxK1ZB3cl
	 maLmSuhUMRUwgN4Qxu4xYtL4lj3YOPUREkn9rWTYOA0zPoChgB+pWtVT2Rxnqgf1rD
	 5+P31LzmokYMJaeO5REpDL5haNaV2ElYHtFBsU2JJn4A7S37KDnyrijUBnWJx/s8Rf
	 xMYF1INca9XnqdgE5lRtrWXCGogfSnS3D3DDVMQXZXYiqoxVymjVAHIaQdI/oDibKt
	 hojwZ6N+t0bqNv2Am+ZI0xYhw3VmScrEO0jI6L51qlcNZH/kO94OzqY6lQc8SxXc5y
	 O2/MxKpKkKw3A==
Date: Tue, 6 May 2025 10:56:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard <eddyz87@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Hao Luo <haoluo@google.com>, James Morris <jmorris@namei.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, LSM List <linux-security-module@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Network Development <netdev@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, Stanislav Fomichev <sdf@fomichev.me>, selinux@vger.kernel.org, 
	"Serge E . Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at
 security_unix_may_send().
Message-ID: <20250506-gehirn-festplatten-6ee995a756b7@brauner>
References: <CAADnVQK1t3ZqERODdHJM_HaZDMm+JH4OFvwTsLNqZG0=4SQQcA@mail.gmail.com.txt>
 <20250506004550.67917-1-kuniyu@amazon.com>
 <CAADnVQ+bk8Qt=Zo4S2MZxB+O4G4q_EXB4P0BtJ3LjgbJuY_9_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+bk8Qt=Zo4S2MZxB+O4G4q_EXB4P0BtJ3LjgbJuY_9_w@mail.gmail.com>

On Mon, May 05, 2025 at 05:56:49PM -0700, Alexei Starovoitov wrote:
> On Mon, May 5, 2025 at 5:46 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Date: Mon, 5 May 2025 17:13:32 -0700
> > > On Mon, May 5, 2025 at 3:00 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > As Christian Brauner said [0], systemd calls cmsg_close_all() [1] after
> > > > each recvmsg() to close() unwanted file descriptors sent via SCM_RIGHTS.
> > > >
> > > > However, this cannot work around the issue that close() for unwanted file
> > > > descriptors could block longer because the last fput() could occur on
> > > > the receiver side once sendmsg() with SCM_RIGHTS succeeds.
> > > >
> > > > Also, even filtering by LSM at recvmsg() does not work for the same reason.
> > > >
> > > > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> > > >
> > > > Let's add a new kfunc to scrub all file descriptors from skb in
> > > > sendmsg().
> > > >
> > > > This allows the receiver to keep recv()ing the bare data and disallows
> > > > the sender to impose the potential slowness of the last fput().
> > > >
> > > > If necessary, we can add more granular filtering per file descriptor
> > > > after refactoring GC code and adding some fd-to-file helpers for BPF.
> > > >
> > > > Sample:
> > > >
> > > > SEC("lsm/unix_may_send")
> > > > int BPF_PROG(unix_scrub_scm_rights,
> > > >              struct socket *sock, struct socket *other, struct sk_buff *skb)
> > > > {
> > > >         struct unix_skb_parms *cb;
> > > >
> > > >         if (skb && bpf_unix_scrub_fds(skb))
> > > >                 return -EPERM;
> > > >
> > > >         return 0;
> > > > }
> > >
> > > Any other programmability do you need there?
> >
> > This is kind of PoC, and as Kumar mentioned, per-fd scrubbing
> > is ideal to cover the real use cases.
> >
> > https://lore.kernel.org/netdev/CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com/
> >
> > for example:
> > https://uapi-group.org/kernel-features/#filtering-on-received-file-descriptors
> 
> Fair enough.
> Would be great to have them as selftests to make sure that advanced
> use cases are actually working.

I think we should do both a socket option and the bpf fd filtering. They
can compliment each other. We should not force the use of bpf for this.
This is a very basic security guarantee we want that shouldn't require
the involvement of any LSM whatsoever.

