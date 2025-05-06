Return-Path: <bpf+bounces-57552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3542AACD16
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146144A6E99
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13409283142;
	Tue,  6 May 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bq1rhQeB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C862286417;
	Tue,  6 May 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555617; cv=none; b=S08lH3NT9BXKO+klB2k0REEHiNZUQ//ugRfPJHWVJfF0fAF9VNEgz524N6s2uBh0NCQdipant03gfqt5qnUS9m92r2AXls1APSo8jZ14GGhwYY20YK7MdUED1KD1bCKEZZX/kBbaO/jX4SW8OTM+aHIqUQWho3NIuK8keLbcE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555617; c=relaxed/simple;
	bh=o93wR73IFjfQLzDgGRDcc5N4OR2sbxJy3v1sHs7WGEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXEcqBbLeiDjfUFk6a6s4U7nlrL3tnzmi3OKZF4RPct1Wg31O3JGm31XhFlSWMH1IZt8ZUyvnE3IiP5FfWA2ZHC3SgqKUsJVdacvxZccvgp2bgjTNEir541vKvgxd49k4QyQxGVQMXXLE2NRbB0tTNlpdyleJYOORX0/r3thGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bq1rhQeB; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746555616; x=1778091616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oM7tdbIMPHK+aa95BxCuLAMfY2QV4C0T4oxTNUdeZEc=;
  b=Bq1rhQeBaP/FpAd1molnqezOVpC1gDLPET1ze8SRL9q1Edc31QD48FyP
   03shR1HsPlVeyfhVk2b1O5XBJsRvBUXUYAA3M9VmGCIY0WdxATk9KazXs
   ucejL9FQCkmRDDp9eLuMBs0xNTiojjyOzXhLQz48+MdcOrdJ1X1k4Qe3k
   U=;
X-IronPort-AV: E=Sophos;i="6.15,267,1739836800"; 
   d="scan'208";a="720279258"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 18:20:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:44588]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id db32f1e7-8960-44cc-9820-b6d9a11fd1dc; Tue, 6 May 2025 18:20:04 +0000 (UTC)
X-Farcaster-Flow-ID: db32f1e7-8960-44cc-9820-b6d9a11fd1dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 18:20:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 18:19:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lennart@poettering.net>
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
Date: Tue, 6 May 2025 11:19:49 -0700
Message-ID: <20250506181951.8804-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aBn90vJ49ymBT3LW@zeta>
References: <aBn90vJ49ymBT3LW@zeta>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Lennart Poettering <lennart@poettering.net>
Date: Tue, 6 May 2025 14:17:22 +0200
> On Mo, 05.05.25 14:56, Kuniyuki Iwashima (kuniyu@amazon.com) wrote:
> 
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
> 
> Frankly, this sounds like a bad idea to me. The number and order of
> the fds passed matters, and if you magically make some fds disappear
> everything becomes a complete mess for most protocols. Hence, making
> fds disappear from a messasge mid-flight is really not a realistic
> option, already for compat. Not for systemd, and not for other tools
> either I am sure.
> 
> I also think it's pointless to enforce this on the receiving side,
> because the deed is done by then. i.e. it doesn't matter if we have to
> close the fd via bpf or in userspace, we still have to wait for it to
> be closed on the receiving side, hence we have to pay. i.e. focus must
> be to refuse the fds on the sender side, instead of allowing this to
> go to the receiver side.
> 
> From my perspective this must be enforced on sender side.

Note that this series is doing that, at sendmsg().


> And more
> importantly, for systemd's usecase it would be a lot more relevant to
> have a simple, dumb boolean per socket instead of the full bpf
> machinery. I mean, as much as I like the lsm-bpf concept it's not
> clear to me that this is the right place to make use of it. I
> personally would really like to see a SO_PASSRIGHTS sockopt, that is
> modelled after SO_PASSCREDS and SO_PASSSEC.

Will add the socket option, and it will be enabled by default
to keep backward compatibility.

Thanks!

