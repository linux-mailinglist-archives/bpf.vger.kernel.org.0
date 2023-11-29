Return-Path: <bpf+bounces-16202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA537FE452
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5371C209EE
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26247A6D;
	Wed, 29 Nov 2023 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aDhigzmU"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC884;
	Wed, 29 Nov 2023 15:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+1mG0n8jEXMUcbRRUHaIgbHxu7jhjROAA37nRQGORFk=; b=aDhigzmUxV4IfAJ4blEFYKvVr5
	ZzgxRzd79xhkuRexHNy5IkpHrNiZs49snGzhq64X9FpTlCADJKQREPaNotNs1c85V3E5W5aSEUcY1
	+Zyd/b7nn4xaNEdg5khHzpYVI1xHbO27Se3j28WcY+tS8GBKO6hmEYcxGXWwpYI0X8eUsO8f/q4q4
	SlFwyrEo3eveVfnNlYt4VjyXTro69oRR66KwOt02ppuClHpe/GAvHRHD5pwwRie6VejQ1RGdIPIrh
	upv5/M+qvBOlzUzJrPq/RKMSLFcPLjma1WQVElh5Qr9mataO7aalvkMllyIj565WM8Fu5wfXynqN9
	yCPGVNrw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8UIv-000Atx-CP; Thu, 30 Nov 2023 00:49:17 +0100
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
Subject: pull-request: bpf 2023-11-30
Date: Thu, 30 Nov 2023 00:49:16 +0100
Message-Id: <20231129234916.16128-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27108/Wed Nov 29 09:40:15 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 5 non-merge commits during the last 7 day(s) which contain
a total of 10 files changed, 66 insertions(+), 15 deletions(-).

The main changes are:

1) Fix AF_UNIX splat from use after free in BPF sockmap, from John Fastabend.

2) Fix a syzkaller splat in netdevsim by properly handling offloaded programs (and
   not device-bound ones), from Stanislav Fomichev.

3) Fix bpf_mem_cache_alloc_flags() to initialize the allocation hint, from Hou Tao.

4) Fix netkit by rejecting IFLA_NETKIT_PEER_INFO in changelink, from Daniel Borkmann.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jakub Kicinski, Jakub Sitnicki, Nikolay Aleksandrov, Yonghong Song

----------------------------------------------------------------

The following changes since commit d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7:

  Merge tag 'net-6.7-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-23 10:40:13 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 51354f700d400e55b329361e1386b04695e6e5c1:

  bpf, sockmap: Add af_unix test with both sockets in map (2023-11-30 00:25:25 +0100)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Daniel Borkmann (1):
      netkit: Reject IFLA_NETKIT_PEER_INFO in netkit_change_link

Hou Tao (1):
      bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()

John Fastabend (2):
      bpf, sockmap: af_unix stream sockets need to hold ref for pair sock
      bpf, sockmap: Add af_unix test with both sockets in map

Stanislav Fomichev (1):
      netdevsim: Don't accept device bound programs

 drivers/net/netdevsim/bpf.c                        |  4 +-
 drivers/net/netkit.c                               |  6 +++
 include/linux/skmsg.h                              |  1 +
 include/net/af_unix.h                              |  1 +
 kernel/bpf/memalloc.c                              |  2 +
 net/core/skmsg.c                                   |  2 +
 net/unix/af_unix.c                                 |  2 -
 net/unix/unix_bpf.c                                |  5 +++
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 51 +++++++++++++++++-----
 .../selftests/bpf/progs/test_sockmap_listen.c      |  7 +++
 10 files changed, 66 insertions(+), 15 deletions(-)

