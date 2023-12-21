Return-Path: <bpf+bounces-18517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F481B44E
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DC91C2096B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032F6E585;
	Thu, 21 Dec 2023 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MVCsGBgw"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536D6E2D0;
	Thu, 21 Dec 2023 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=03H+pBQS1ta2kxx072C7tlZMZAl9+818xz/DLtnYhoQ=; b=MVCsGBgwS6FdnTJbAFLR7tEtVq
	uUXf22UlAFfYMZqPEZk/PqYg8TTqS0wVbIexAZh8I/QSP3x+61zJVyS3C8nw2O9n3Si965k+05GXv
	tH67ShV0Hwes3/2V+wbLhgwgUvv6bkWUrWPvSJiOsfhC/pmNJgxqHb7rzZOImoAU+sa2yE/fHByYc
	mTmE6pjaVEx57x7K7nMaSLiwB1aUs5H3GpjcES8G1RTP1AqXGrgbGoVIUH85F25IeGMtUnwuLdm1y
	KYhy/bNwjSY4ADZQGWOwrOGXPiDsLRtrV5/4eeVOLpWSacp/JHWLj09GDgsUkGNkfvnGyaDeYcvFG
	ju+W5XfQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rGGbd-000ORA-7a; Thu, 21 Dec 2023 11:48:45 +0100
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
Subject: pull-request: bpf 2023-12-21
Date: Thu, 21 Dec 2023 11:48:44 +0100
Message-Id: <20231221104844.1374-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27130/Thu Dec 21 10:38:20 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 3 non-merge commits during the last 5 day(s) which contain
a total of 4 files changed, 45 insertions(+).

The main changes are:

1) Fix a syzkaller splat which triggered an oob issue in bpf_link_show_fdinfo(),
   from Jiri Olsa.

2) Fix another syzkaller-found issue which triggered a NULL pointer dereference
   in BPF sockmap for unconnected unix sockets, from John Fastabend.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Eric Dumazet, Hou Tao, Jakub Sitnicki, Pengfei Xu

----------------------------------------------------------------

The following changes since commit e307b5a845c5951dabafc48d00b6424ee64716c4:

  octeontx2-af: Fix pause frame configuration (2023-12-11 10:55:12 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 117211aa739a926e6555cfea883be84bee6f1695:

  bpf: Add missing BPF_LINK_TYPE invocations (2023-12-15 16:34:12 -0800)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Jiri Olsa (1):
      bpf: Add missing BPF_LINK_TYPE invocations

John Fastabend (2):
      bpf: syzkaller found null ptr deref in unix_bpf proto add
      bpf: sockmap, test for unconnected af_unix sock

Martin KaFai Lau (1):
      Merge branch ' bpf fix for unconnect af_unix socket'

 include/linux/bpf_types.h                          |  4 +++
 include/net/sock.h                                 |  5 ++++
 net/core/sock_map.c                                |  2 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 34 ++++++++++++++++++++++
 4 files changed, 45 insertions(+)

