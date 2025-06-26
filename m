Return-Path: <bpf+bounces-61704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B945CAEAA6C
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 01:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD5B1C27654
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48862163B2;
	Thu, 26 Jun 2025 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HFfKRDT7"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0801FBCA1;
	Thu, 26 Jun 2025 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979824; cv=none; b=Ri7GYLUYOcOKx2gdkECbowgu5PwIKDWBDEYOWt7uXRvV5PCVYRRj5UKkyhGpN9qRT6SdBMed8gq++ALS7rOGMtkaFu1mSZtQwuvCklzLv854dn73cXsA9NILN2JTUMS2lil5t/Oh6hWsssBzvtZNI6v0VwoJUXkA4FvG/EYVOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979824; c=relaxed/simple;
	bh=1wA9A47szU+VrjeV4OiB2bj/WtG8oYnLQCRFfmIFE84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZ/37OWQxrrHSkcX4iKVeCD0hsd9j9TUU2X9cwyX+NeJh3hrLgUYprYHh889C2UTHppviyiunYaSASgwr9H4/kj0FsHvfMKgQ+ysIZnYds0Q0g/VbK6lIafWk/S7e/G36xOhf9csn7SbcopeRmVUHyCf4l8WdbGEVarHAKV+byc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HFfKRDT7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=HRJjLTvM5n86H842Si//qWpIS9NZshIAK219b6uDKos=; b=HFfKRDT7R1rA/Pr+DNhjN5uZsN
	AyelXKX6kSvfhib5cCYvPih3Iv0HL7a2DGwnrS8Fpm9df8Uls565gFoIYwHT7Ht4uyfXq3lUq7t/N
	TvIP1bB7irCJXh9mPJFzYsW6SRGMDGe7lNL1P7tMWd4bRp83eN0kR92qL2vhb+FCjxA5puWHpHhU1
	JlBdr8cFiQ49fL0O32PcseB9gUCjXMtBF664ukpXwKW60ZGgXsalpcVS7kSxY8rU801qm113tR+Ff
	DzzP9nZCIiYRpPQM++eMzGQUOXAzECiV7N2u3Dq6ZF+WdMneZymo3OjOQCbA9qzu9Kl4R+kNiDMtK
	yGIcbPJw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uUvam-000M7V-20;
	Fri, 27 Jun 2025 01:01:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2025-06-27
Date: Fri, 27 Jun 2025 01:01:10 +0200
Message-ID: <20250626230111.24772-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27681/Thu Jun 26 10:38:00 2025)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 6 non-merge commits during the last 8 day(s) which contain
a total of 6 files changed, 120 insertions(+), 20 deletions(-).

The main changes are:

1) Fix RCU usage in task_cls_state() for BPF programs using helpers like
   bpf_get_cgroup_classid_curr() outside of networking, from Charalampos
   Mitrodimas.

2) Fix a sockmap race between map_update and a pending workqueue from
   an earlier map_delete freeing the old psock where both pointed to the
   same psock->sk, from Jiayuan Chen.

3) Fix a data corruption issue when using bpf_msg_pop_data() in kTLS which
   failed to recalculate the ciphertext length, also from Jiayuan Chen.

4) Remove xdp_redirect_map{,_err} trace events since they are unused and
   also hide XDP trace events under CONFIG_BPF_SYSCALL, from Steven Rostedt.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Cong Wang, Daniel Borkmann, Jakub Kicinski, Jesper Dangaard Brouer, John 
Fastabend, Toke Høiland-Jørgensen

----------------------------------------------------------------

The following changes since commit 2c7e4a2663a1ab5a740c59c31991579b6b865a26:

  Merge tag 'net-6.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-05 12:34:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 16f3c7ad887c1f8fd698ab568b5851cadb65b5a8:

  xdp: tracing: Hide some xdp events under CONFIG_BPF_SYSCALL (2025-06-12 19:36:53 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Charalampos Mitrodimas (1):
      net, bpf: Fix RCU usage in task_cls_state() for BPF programs

Jiayuan Chen (3):
      bpf, sockmap: Fix psock incorrectly pointing to sk
      bpf, ktls: Fix data corruption when using bpf_msg_pop_data() in ktls
      selftests/bpf: Add test to cover ktls with bpf_msg_pop_data

Steven Rostedt (2):
      xdp: Remove unused events xdp_redirect_map and xdp_redirect_map_err
      xdp: tracing: Hide some xdp events under CONFIG_BPF_SYSCALL

 include/trace/events/xdp.h                         | 21 +----
 net/core/netclassid_cgroup.c                       |  4 +-
 net/core/skmsg.c                                   |  7 ++
 net/tls/tls_sw.c                                   | 13 ++++
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 91 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c        |  4 +
 6 files changed, 120 insertions(+), 20 deletions(-)

