Return-Path: <bpf+bounces-57462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A97AAB82D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6394016C380
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32F2FD624;
	Tue,  6 May 2025 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZlDL+0wf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE1221FD8;
	Tue,  6 May 2025 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746491736; cv=none; b=EFfBykP1uj2NGr5UmKXX+FHr6dUWsJunf0JBNe+7c0i3EnBjBIJxH+Ow+3+WrG1sZlRTkL9Bhw7oAt1C+FM1GQ6L/zybaRjsvAJdencn3mNfqy86UVjZUsBNVSWw5iTIka6ijjqo6jr9Po5HpSUVuhMvEhrlatXgv8nzc6oqmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746491736; c=relaxed/simple;
	bh=0pAdBspU8vivANdaZW/o97sPHrOFbC6O9J5s0BYxnS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHTAJt1jxvgDwoaWbzmpJC8ZBeDJnvIFIDVtNFQ8DBV5JJ8WONYGskiPGKcCd/6/eVMbZnhp2bQTPPBbU6souI1cHjXJBh3zgFMEANPS34tBQFubsLwL4jBwlQAecNgnmT2ZYPGx1A/rIyudkHFMsl24Avn9dXn71Wjb/RpUaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZlDL+0wf; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746491735; x=1778027735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nOvQXWRc/5qil+cvIoucc+DXMTSwboardUIFaB7uqnE=;
  b=ZlDL+0wf8NUr7jwn72/Z+mKNYm4Cc2op9vcKDkzuoGj4LO6SXDqJcEZ/
   I3hSao6CCISiilBliJ56wqZkMDEzU8up2lPpfVq9ze6a7DSQvBz3tNxS/
   YtbCfrCaHns0sKYSSTErF5gZHQ8BUndjHfIqgsHWqXDV3WIFt7rizl8NK
   E=;
X-IronPort-AV: E=Sophos;i="6.15,265,1739836800"; 
   d="scan'208";a="720011798"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 00:35:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:20550]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.114:2525] with esmtp (Farcaster)
 id 811641e1-8323-4f02-86cd-9fb113c36d55; Tue, 6 May 2025 00:35:28 +0000 (UTC)
X-Farcaster-Flow-ID: 811641e1-8323-4f02-86cd-9fb113c36d55
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 00:35:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 00:35:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <paul@paul-moore.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<brauner@kernel.org>, <casey@schaufler-ca.com>, <daniel@iogearbox.net>,
	<eddyz87@gmail.com>, <gnoack@google.com>, <haoluo@google.com>,
	<jmorris@namei.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-security-module@vger.kernel.org>, <martin.lau@linux.dev>,
	<mic@digikod.net>, <netdev@vger.kernel.org>, <omosnace@redhat.com>,
	<sdf@fomichev.me>, <selinux@vger.kernel.org>, <serge@hallyn.com>,
	<song@kernel.org>, <stephen.smalley.work@gmail.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub SCM_RIGHTS at sendmsg().
Date: Mon, 5 May 2025 17:35:10 -0700
Message-ID: <20250506003514.66821-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAHC9VhSWS2L3qwu_r_1Fr3eLp-9KRz3_20EPwy=FFu7_eSiN7g@mail.gmail.com>
References: <CAHC9VhSWS2L3qwu_r_1Fr3eLp-9KRz3_20EPwy=FFu7_eSiN7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 19:21:25 -0400
> On Mon, May 5, 2025 at 5:58 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
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
> 
> I'll take a closer look later this week, but generally speaking LSM
> hooks are intended for observability and access control, not data
> modification, which means what you are trying to accomplish may not be
> a good fit for a LSM hook.  Have you considered simply inspecting the
> skb at sendmsg() and rejecting the send in the LSM hook if a
> SCM_RIGHTS cmsg is present that doesn't fit within the security policy
> implemented in your BPF program?

I think the simple inspection (accept all or deny) does not cover
a real use case and is not that helpful.

I don't like to add another hook point in AF_UNIX code just because
of it and rather want to reuse the exisiting hook as we have a nice
place.

Also, passing skb makes it possible to build much more flexible
policy as it allows bpf prog to inspect the skb payload with
existing bpf helpers.

