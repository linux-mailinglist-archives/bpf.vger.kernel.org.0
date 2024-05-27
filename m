Return-Path: <bpf+bounces-30698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080688D0EA6
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 22:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409A82826B6
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF2161302;
	Mon, 27 May 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="adnR//DZ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9375338D;
	Mon, 27 May 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842158; cv=none; b=sm/2VdWZTzM2ePv5KhS/MjGAHrTRjxxDNRZONniuTkv/E+Wf1xd0w90MlkCEWOR8Mi8FTYcANwxOd7vVqUPXgBlpwQr73899VK+fZiFTYMmU8VkGAHGGbtilRNZfdPJIyaqLiucvDpYXsjEgscnWtnyZhwJppSTokzHvVgvAgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842158; c=relaxed/simple;
	bh=hAOz+EzzqUvjMkMNKEG6qGZenmSoJkzQa7zoXY5SR6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvXgmSr9W+v81ZfCGFwAaKwm/EsbMtUQBZuL2gqlGEwf+fCQp6PU8WXAz8WNTWdNOAo9J9XRVGkm9JsrZBgv4XPoQviHNFtcZRpmWlLvrqG5cNSbEYZOkpxVWGUt8VRSlhp/QhmQL9b/f+sZ7R73c/1pCCs8rPJdImkbYT4sPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=adnR//DZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=VSD+0BKNQsrtH6j3YR1cQCSm45GZTcfbAbU1ZjT2e9M=; b=adnR//DZl2mx6nhVxrnvxOAIx9
	8Rr6kmDeS13Yr8I0j4rxAJ/2qspqiqAIHPCY+ANmgDiCOyk36qklRxB6zLNVKW45CApSxKzNHUpKT
	0GAVjD6LnUGjVoYYrXJjxm30C6y7acg/32LsCtvsnNIrIiruhRl5qTS260i4zPP5aDUyPbAj49ua8
	N6E6CPXs6sWp7/pkwRQ0pmVBlHkFDON270f2kqyGVi1jquBo/9y3X/z93kZoD8DCXP//qlzPVzjsS
	2U7QDKBdPaQFohH8lwy/iR0MxYxUrHE9cLrcQ/GgIDCxglnwm/4WImNNl6YBLNY4LebzErqeySylE
	oB/EtzEQ==;
Received: from 14.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.14] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sBh4S-000CZt-1U; Mon, 27 May 2024 22:35:52 +0200
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
Subject: pull-request: bpf 2024-05-27
Date: Mon, 27 May 2024 22:35:51 +0200
Message-Id: <20240527203551.29712-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27288/Mon May 27 10:29:01 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 15 non-merge commits during the last 7 day(s) which contain
a total of 18 files changed, 583 insertions(+), 55 deletions(-).

The main changes are:

1) Fix broken BPF multi-uprobe PID filtering logic which filtered by thread while
   the promise was to filter by process, from Andrii Nakryiko.

2) Fix the recent influx of syzkaller reports to sockmap which triggered a
   locking rule violation by performing a map_delete, from Jakub Sitnicki.

3) Fixes to netkit driver in particular on skb->pkt_type override upon pass
   verdict, from Daniel Borkmann.

4) Fix an integer overflow in resolve_btfids which can wrongly trigger build
   failures, from Friedrich Vock.

5) Follow-up fixes for ARC JIT reported by static analyzers, from Shahab Vahedi.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Daniel Borkmann, Hengqi Chen, Jiri Olsa, John Fastabend, kernel test 
robot, Nikolay Aleksandrov, Stanislav Fomichev, Tetsuo Handa

----------------------------------------------------------------

The following changes since commit 30a92c9e3d6b073932762bef2ac66f4ee784c657:

  openvswitch: Set the skbuff pkt_type for proper pmtud support. (2024-05-21 15:34:04 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to a63bf556160fb19591183383da6757f52119981d:

  selftests/bpf: Cover verifier checks for mutating sockmap/sockhash (2024-05-27 19:34:26 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'fix-bpf-multi-uprobe-pid-filtering-logic'

Andrii Nakryiko (5):
      bpf: fix multi-uprobe PID filtering logic
      bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic
      libbpf: detect broken PID filtering logic for multi-uprobe
      selftests/bpf: extend multi-uprobe tests with child thread case
      selftests/bpf: extend multi-uprobe tests with USDTs

Daniel Borkmann (4):
      netkit: Fix setting mac address in l2 mode
      netkit: Fix pkt_type override upon netkit pass verdict
      selftests/bpf: Add netkit tests for mac address
      selftests/bpf: Add netkit test for pkt_type

Friedrich Vock (1):
      bpf: Fix potential integer overflow in resolve_btfids

Jakub Sitnicki (3):
      bpf: Allow delete from sockmap/sockhash only if update is allowed
      Revert "bpf, sockmap: Prevent lock inversion deadlock in map delete elem"
      selftests/bpf: Cover verifier checks for mutating sockmap/sockhash

Shahab Vahedi (1):
      ARC, bpf: Fix issues reported by the static analyzers

Xu Kuohai (1):
      MAINTAINERS: Add myself as reviewer of ARM64 BPF JIT

 MAINTAINERS                                        |   1 +
 arch/arc/net/bpf_jit.h                             |   2 +-
 arch/arc/net/bpf_jit_arcv2.c                       |  10 +-
 arch/arc/net/bpf_jit_core.c                        |  22 +--
 drivers/net/netkit.c                               |  30 +++-
 include/linux/etherdevice.h                        |   8 +
 kernel/bpf/verifier.c                              |  10 +-
 kernel/trace/bpf_trace.c                           |  10 +-
 net/core/sock_map.c                                |   6 -
 net/ethernet/eth.c                                 |   4 +-
 tools/bpf/resolve_btfids/main.c                    |   2 +-
 tools/lib/bpf/features.c                           |  31 +++-
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |  94 +++++++++++
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   | 134 ++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/test_tc_link.c   |  35 +++-
 tools/testing/selftests/bpf/progs/uprobe_multi.c   |  50 +++++-
 .../selftests/bpf/progs/verifier_sockmap_mutate.c  | 187 +++++++++++++++++++++
 18 files changed, 583 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c

