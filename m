Return-Path: <bpf+bounces-34189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F192AE21
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 04:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC3F1F219B7
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A053D966;
	Tue,  9 Jul 2024 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fA9KzHY8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3327487A5;
	Tue,  9 Jul 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491540; cv=none; b=RzXn2g3yTziZ+1CNOfqHjb/sxsdD1NhxT1hxvIC5Tb6gZRNcDfEwKuFj1zVaaI5fSYeRcF/fjgc2GNc8b6mwkGZJGOYDcNmegIdtSuLZQ+Z3r2ztM/z9R+ftwc+mhOvUgWhaA+6ngzs/KmjV3laIvL6Nfg3c1aDfOSzXjWZYohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491540; c=relaxed/simple;
	bh=f1OHIPL0chjLC41H/uptD0EgeuBRwMzWjSo4ma9AV70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHQ2J60QwhM1uotvVkMn/DtpgZDssbJbMYDJ+E7x7ded1NnNLm+O0rGGsp4Eut6ZixBH0fW4cbo73Kxq7NPBy5HDMjrEtCqP1WslqmS3d/LASPUwkZj24K0zlm5bLfrWdRGOl+YMaTVwJD6mcc9vUbptDoVesTFhdyoQQJM8Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fA9KzHY8; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720491539; x=1752027539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytM6FHdd6zeKxu0OQuStG3uQdGLIhWU7tHYeLLh7Tmc=;
  b=fA9KzHY8N0JMjnRuxrqnFhnav1DMhQLeco08UDyi6ZUerYh/uEHh9pYQ
   mBMEY3Ww9gMkQW5iDHKj6zLvgmUrLWaNDOv54NJTW14QJkQd6R0LOKJA4
   TrPTReSH5NQiZKzC4OSLF6OTIQ8prt5/bALKh2C+8FYDZJca1UugKyiuL
   4=;
X-IronPort-AV: E=Sophos;i="6.09,193,1716249600"; 
   d="scan'208";a="739196239"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 02:18:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:49316]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.122:2525] with esmtp (Farcaster)
 id 99de9644-0e58-4c51-b9a5-e140a409bf4d; Tue, 9 Jul 2024 02:18:52 +0000 (UTC)
X-Farcaster-Flow-ID: 99de9644-0e58-4c51-b9a5-e140a409bf4d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 9 Jul 2024 02:18:51 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 9 Jul 2024 02:18:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <john.fastabend@gmail.com>
CC: <Rao.Shoaib@oracle.com>, <bpf@vger.kernel.org>, <cong.wang@bytedance.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <jakub@cloudflare.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mhal@rbox.co>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <takamitz@amazon.co.jp>
Subject: Re: [PATCH bpf v3 1/4] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Mon, 8 Jul 2024 19:18:39 -0700
Message-ID: <20240709021839.53278-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <668c9132195f6_d7720840@john.notmuch>
References: <668c9132195f6_d7720840@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 08 Jul 2024 18:24:02 -0700
> Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Sun,  7 Jul 2024 23:28:22 +0200
> > > AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
> > > with an `oob_skb` pointer. BPF redirecting does not account for that: when
> > > an OOB packet is moved between sockets, `oob_skb` is left outdated. This
> > > results in a single skb that may be accessed from two different sockets.
> > > 
> > > Take the easy way out: silently drop MSG_OOB data targeting any socket that
> > > is in a sockmap or a sockhash. Note that such silent drop is akin to the
> > > fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
> > > 
> > > For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
> > > 
> > > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > 
> 
> Why does af_unix put the oob data on the sk_receive_queue()? Wouldn't it
> be enough to just have the ousk->oob_skb hold the reference to the skb?

We need to remember when oob_skb was sent for some reasons:

  1. OOB data must stop recv() at the point
  2. ioctl(SIOCATMARK) must return true if OOB data is at the head of
     the recvq regardless that the data is already consumed or not

  See tools/testing/selftests/net/af_unix/msg_oob.c

And actually TCP has OOB data in the normal skb ququed in recvq.

TCP also holds the copied data in tp->urg_data and SEQ# in tp->urg_seq.
Later when recv() passes through the OOB SEQ#, the recv() is stopped at
OOB data.

Note that the implementation has some bugs, e.g. it doesn't have a flag
to indicate if each OOB data is consumed, and we can recv() the stale
OOB data twice.

(CCed Takamitsu who is working on the URG bugs on the TCP side)


> I think for TCP/UDP at least I'll want to handle MSG_OOB data correctly.

UDP doesn't support MSG_OOB.


> For redirect its probably fine to just drop or skip it, but when we are
> just reading recv msgs and parsing/observing it would be nice to not change
> how the application works. In practice I don't recall anyone reporting
> issues on TCP side though from incorrectly handling URG data.

IIUC, the normal read case is processed by tcp_recvmsg(), right ?
Then, OOB data is handled at the found_ok_skb/skip_copy: labels.


> 
> From TCP side I believe we can fix the OOB case by checking the oob queue
> before doing the recvmsg handling. If the urg data wasn't on the general
> sk_receive_queue we could do similar here for af_unix? My argument for
> URG not working for redirect would be to let userspace handle it if they
> cared.

For the redirect cse, in tcp_read_skb(), we need to check tp->urg_data and
tp->{copied,urg}_seq and clear them if needed as done in tcp_recvmsg().

