Return-Path: <bpf+bounces-57550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA316AACCE5
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3906A3BFE5F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84336286417;
	Tue,  6 May 2025 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sfu2ZS2F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596EC322E;
	Tue,  6 May 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555270; cv=none; b=QOPpzW9aOu6KQ1m29PEs2If0L6PzSu0vkufczqhQIPBsLM2I4ZqK1eNFZpzxm+OsN5rcwhqA+vaMdkcy31VT4R4bOeeNK/yXyWeY2vk5Kn3s3HgwlV2W/VJFET8wPB/A+FuOGERRB7Mi8TfR3fNLB6o2DIwAHi1o5WeSQL0jB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555270; c=relaxed/simple;
	bh=DkIKQfqsTu+gVD2DEws8gU9m4Q5ajcIXXeqGGGVYlg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cH7d406HiCyFH2UfFFcs0yhICtDD1qd9dyqGN0YyrYdHa7C7LwFqU1tejzdzGBjc82dXpFObsVLV9fY992VJ/GCQ2EdoQdNdFk9xRL6+6ltfpQlkd5VsWRhokSJ0yLQ5TbIb9jHW/JidqYx2ZUquE/6yxduw8N3scdkvzail1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sfu2ZS2F; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746555268; x=1778091268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KgSwdo/NxotK2V+pYTnW3FkSKp8QmApoafI0ZPFLKGM=;
  b=sfu2ZS2FCteKTl2pEm6iF1rzO+Kmt0MGGd5/Nswkev36b+JjsrU/+tHx
   +HYri8T1GbFuzDWDPT8UqgadUV47puwnwM4E7RzlsSQilc1zVh8GVnHOH
   i3WOXxVRTtg1pNtrZWi4IIXV4NM1gKLCrw571GgOtunkyc/i6iFn6SCfj
   wfLobnV3dsPej369GXOaBEbgrHg5vXPgn6FS5V3OJj/cwIHDOXf89wkpm
   1RNs+xs/aAAQozQQXsbT5mo9pSUYO7ZLx59dc0MfXKckcvGWsotwwCGRo
   GhC0w57B86e8tNvg5z6tgUQeCtaQTYqEWYnd3cixAB7UyKoubQqeB3FZC
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,267,1739836800"; 
   d="scan'208";a="194210162"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 18:14:26 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:22403]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id 14401153-5e8d-459a-9dec-01747983d2cc; Tue, 6 May 2025 18:14:26 +0000 (UTC)
X-Farcaster-Flow-ID: 14401153-5e8d-459a-9dec-01747983d2cc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 18:14:25 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 18:14:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <memxor@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<brauner@kernel.org>, <casey@schaufler-ca.com>, <daniel@iogearbox.net>,
	<eddyz87@gmail.com>, <gnoack@google.com>, <haoluo@google.com>,
	<jmorris@namei.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-security-module@vger.kernel.org>, <martin.lau@linux.dev>,
	<mic@digikod.net>, <netdev@vger.kernel.org>, <omosnace@redhat.com>,
	<paul@paul-moore.com>, <sdf@fomichev.me>, <selinux@vger.kernel.org>,
	<serge@hallyn.com>, <song@kernel.org>, <stephen.smalley.work@gmail.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub SCM_RIGHTS at sendmsg().
Date: Tue, 6 May 2025 11:14:07 -0700
Message-ID: <20250506181413.8387-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAP01T750x5a9ATX56hV0p+Je2zFfm1unS3ZhCObXY-yt_ar=+w@mail.gmail.com>
References: <CAP01T750x5a9ATX56hV0p+Je2zFfm1unS3ZhCObXY-yt_ar=+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 May 2025 18:08:23 +0200
> On Tue, 6 May 2025 at 11:15, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, May 06, 2025 at 12:49:11AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Mon, 5 May 2025 at 23:58, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> > > > possible to avoid receiving file descriptors via SCM_RIGHTS.
> > > >
> > > > This behaviour has occasionally been flagged as problematic.
> > > >
> > > > For instance, as noted on the uAPI Group page [0], an untrusted peer
> > > > could send a file descriptor pointing to a hung NFS mount and then
> > > > close it.  Once the receiver calls recvmsg() with msg_control, the
> > > > descriptor is automatically installed, and then the responsibility
> > > > for the final close() now falls on the receiver, which may result
> > > > in blocking the process for a long time.
> > > >
> > > > systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> > > > unwanted file descriptors sent via SCM_RIGHTS.
> > > >
> > > > However, this cannot work around the issue because the last fput()
> > > > could occur on the receiver side once sendmsg() with SCM_RIGHTS
> > > > succeeds.  Also, even filtering by LSM at recvmsg() does not work
> > > > for the same reason.
> > > >
> > > > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> > > >
> > > > This series allows BPF LSM to inspect skb at sendmsg() and scrub
> > > > SCM_RIGHTS fds by kfunc.
> > > >
> > > > Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
> > > > Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
> > > >
> > >
> > > This sounds pretty useful!
> > >
> > > I think you should mention the cases of possible DoS on close() or
> > > flooding, e.g. with FUSE controlled fd/NFS hangs in the commit log
> > > itself.
> > > I think it's been an open problem for a while now with no good solution.
> > > Currently systemd's FDSTORE=1 for PID 1 is susceptible to the same
> > > problem, even if the underlying service isn't root.
> > >
> > > I think it is also useful for restricting what individual file
> > > descriptors can be passed around by a process.
> > > Say restricting usage of an fd to a process and its children, but not
> > > allowing it to be shared with others.
> > > Send side hook is the right point to enforce it.
> > >
> > > Therefore exercising scm_fp_list would be a good idea.
> >
> > No, that's a terrible idea. If the receiver expects 10 file descriptors
> > and suddenly some magically disappear or the order gets messed up that's
> > terrible for security. It's either close all or nothing.
> 
> I was talking about exercising/reading it in the selftest, not
> exposing anything new.
> 
> Yes, the policy should be close all or nothing, but it can still be
> used to deny sendmsg when one of the descriptors being passed isn't in
> the allowed set.
> You just return 0 or an error. No need to scrub, no need to disappear
> some fds and let the message pass, which can be problematic.
> 
> >
> > > We should provide some more examples of the filtering policy in the selftests.
> > > Maybe a simple example, e.g. only memfd or a pipe fd can be passed,
> > > and nothing else.
> > > It would require checking file->f_ops.
> >
> > There's not going to be poking around in file->f_ops for this.
> 
> I don't think any poking is required. There's no need to expose anything extra.
> 
> Really, all that is needed is for an LSM hook to exist and the program
> to say success or failure.
> Even the scrub fds stuff can be dropped.
> 
> The program can simply inspect the scm_fp_list and if it doesn't look
> ok, deny the sendmsg.
> It's already there inside unix_skb_parms.
> 
> It just means the program can look at the file (there's no helper
> needed to be exposed) and make a decision, just like in the rest of
> the BPF LSM hooks.
> I think a socket option makes sense too, but ideally we can have both
> the hook and the socket option.
> 
> The socket option has the advantage that user space can set it itself
> conveniently, without having to load a BPF program.
> Meanwhile the hook can be more fine grained in decision making and be
> imposed by some central entity.
> 
> Does this sound reasonable? I don't think it requires anything beyond
> simply defining the hook and letting a program run there.
> No poking into VFS internals etc. or silently dropping file
> descriptors and letting it succeed.
> 
> So mostly patch 1-2 and then another to add a setsockopt flag.

Right, patch 1-2 is enough to let BPF LSM to filter each skb.

I'll also add the socket option too.

Thanks!

