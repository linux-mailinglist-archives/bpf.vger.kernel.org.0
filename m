Return-Path: <bpf+bounces-16936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8AC807B1B
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901781C21126
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9774654B;
	Wed,  6 Dec 2023 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Y2e1++NN"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A56B10C9;
	Wed,  6 Dec 2023 14:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=O/XXOBx/uB/+sYdDySqcFpWuG+Hs1qkjZy8yZ4GyHZ4=; b=Y2e1++NNNL0k5c1puQ5os9Vf9b
	SHbxPhH3TcZTG1uPKJWuHH/t7ze8afLhAPQnxR11bN2+cM1sWhxV91QG9E+35irrHxAkEQmPWOtxl
	TxKf5sXDr4rD2JeSByZmiMok1A5MikMj9l3bKex8hLyNjOct37POcvICGs15MF3vFgV019rhPmxfZ
	3yJ66MOXZDvJ4qw+ogU8bzx6nkFcmOqWxCbVIuzZpQyAL7XAtoLKB/Z+DUMVXutLbs+TagDBgQgIu
	X6Qq565tvcNqwxP9tQLoQVaimO/+e4qzZwG7e3Ym7Jp5aM+t+7gLl9dn1tDsqnAka9W8baYS45hBd
	8FJy3xrA==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rB01J-000Iaq-LH; Wed, 06 Dec 2023 23:05:29 +0100
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
Subject: pull-request: bpf 2023-12-06
Date: Wed,  6 Dec 2023 23:05:28 +0100
Message-Id: <20231206220528.12093-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27115/Wed Dec  6 09:44:21 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 4 non-merge commits during the last 6 day(s) which contain
a total of 7 files changed, 185 insertions(+), 55 deletions(-).

The main changes are:

1) Fix race found by syzkaller on prog_array_map_poke_run when a BPF program's kallsym
   symbols were still missing, from Jiri Olsa.

2) Fix BPF verifier's branch offset comparison for BPF_JMP32 | BPF_JA, from Yonghong Song.

3) Fix xsk's poll handling to only set mask on bound xsk sockets, from Yewon Choi.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Ilya Leoshkevich, Magnus Karlsson, Yonghong Song

----------------------------------------------------------------

The following changes since commit 830139e7b6911266a84a77e1f18abf758995cc89:

  octeontx2-af: Check return value of nix_get_nixlf before using nixlf (2023-12-01 12:19:02 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to ffed24eff9e0e52d8e74df1c18db8ed43b4666e6:

  selftests/bpf: Add test for early update in prog_array_map_poke_run (2023-12-06 22:40:43 +0100)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Jiri Olsa (2):
      bpf: Fix prog_array_map_poke_run map poke update
      selftests/bpf: Add test for early update in prog_array_map_poke_run

Yewon Choi (1):
      xsk: Skip polling event check for unbound socket

Yonghong Song (1):
      bpf: Fix a verifier bug due to incorrect branch offset comparison with cpu=v4

 arch/x86/net/bpf_jit_comp.c                        | 46 ++++++++++++
 include/linux/bpf.h                                |  3 +
 kernel/bpf/arraymap.c                              | 58 +++------------
 kernel/bpf/core.c                                  | 12 ++--
 net/xdp/xsk.c                                      |  5 +-
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 84 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tailcall_poke.c  | 32 +++++++++
 7 files changed, 185 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c

