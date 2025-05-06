Return-Path: <bpf+bounces-57463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6CAAB860
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DCE1884FE9
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340ED35AFF0;
	Tue,  6 May 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m0N4EUYC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B87347357;
	Tue,  6 May 2025 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746492374; cv=none; b=lylfz8bjvnCNLsbCUiyRjcMfumOsqxSpsw+EhkoM/8YSqui77IDLLBu5bvF7gWZikOlMHOVQCcP2nkr3ARxr9334G5HuC2N/MWiJyR+YryuQ3uTsMW0cU1331st0WEkeRjnsGw70BKrNRaXpJl46FXo0yjHwRemmmOJfgyQdPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746492374; c=relaxed/simple;
	bh=K7YCRWUV0AHkeSy9BuUH5yxL7FnYdu26K+6m2SqhOJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJ4udoCciWdDmZoczZ2vG02+A+3bVKwUdH0HoX69olDmr0u1R1gaSE0ibC5JhZGGUGh220gvVAZcLHp1aTCG7CJM2uwIDZdpfT8cJHY7oBM0KIIWHeiU/R0pRsXkX9BS5yXJKUWaeNPZqUcQdwJqywrUzqYfNUBsntgKUwJLjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m0N4EUYC; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746492370; x=1778028370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RSYOunfmEVpq0TlU48zdEU3dFvnuc8YiW73w9xJwoHY=;
  b=m0N4EUYC9P3oVS01PjtkeTnwsSF7J3GaKkZROqA/ovgP/R2APfL1yUNB
   h5DqRJ5LvprUA3lwVJcZE14GaYoT7Z21h7Zjw3b34uT0sG5pz3xJ0HQtI
   hfnil6QMcyJ8fTWsEMGWeDIOmx3fBL5z4hNhwJNj2soXzSLsznGnyIZGM
   w=;
X-IronPort-AV: E=Sophos;i="6.15,265,1739836800"; 
   d="scan'208";a="495784027"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 00:46:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:29537]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id 33fef85d-7f2b-40d4-8855-07d747e2fb6e; Tue, 6 May 2025 00:46:03 +0000 (UTC)
X-Farcaster-Flow-ID: 33fef85d-7f2b-40d4-8855-07d747e2fb6e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 00:46:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 00:45:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ast@kernel.org>
CC: <andrii@kernel.org>, <bpf@vger.kernel.org>, <brauner@kernel.org>,
	<casey@schaufler-ca.com>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
	<gnoack@google.com>, <haoluo@google.com>, <jmorris@namei.org>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-security-module@vger.kernel.org>, <martin.lau@linux.dev>,
	<mic@digikod.net>, <netdev@vger.kernel.org>, <omosnace@redhat.com>,
	<paul@paul-moore.com>, <sdf@fomichev.me>, <selinux@vger.kernel.org>,
	<serge@hallyn.com>, <song@kernel.org>, <stephen.smalley.work@gmail.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
Date: Mon, 5 May 2025 17:44:13 -0700
Message-ID: <20250506004550.67917-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAADnVQK1t3ZqERODdHJM_HaZDMm+JH4OFvwTsLNqZG0=4SQQcA@mail.gmail.com.txt>
References: <CAADnVQK1t3ZqERODdHJM_HaZDMm+JH4OFvwTsLNqZG0=4SQQcA@mail.gmail.com.txt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 17:13:32 -0700
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

This is kind of PoC, and as Kumar mentioned, per-fd scrubbing
is ideal to cover the real use cases.

https://lore.kernel.org/netdev/CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com/

for example:
https://uapi-group.org/kernel-features/#filtering-on-received-file-descriptors

"""
An alternative to the previous item could be if some form of filtering
could be enforced on the file descriptors suitable for enqueuing on the
AF_UNIX socket. i.e. allow filtering by superblock type or similar, so
that policies such as “only memfds are OK to be received” may be
expressed. (BPF?).
"""

I think Christian can add more scenarios if needed.



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

