Return-Path: <bpf+bounces-37953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF58195CE63
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B43DB265E6
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807E1885BE;
	Fri, 23 Aug 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UHQYuAzz"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E29188599;
	Fri, 23 Aug 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421006; cv=none; b=u5244Lq2e25LOS80yuOCHapY4Y6tTI8OImbJ/Hv1fLHAukmvEBMWEhFiUae51yYNzPAXKnrdEKKYfAW6go89i81vqblLakMfHW9asY/N5wpSSbpOO/lXQAyvBU2Oe/MZNgjMH+3naKAHFKF02CRemExVWc3JrreFMX6h4jllzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421006; c=relaxed/simple;
	bh=5GiXg5grCKH9UPEePNehPEjM6L22MBcJ1OYY6wZfU0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fT9fR0soz4G4ZniTkVClAnk8Bfn4epPC40cHZICSAYnxrnPjB9o/e/p8OrlWWFljC8v7WBQSYhQT22MvjlzBXMnIPH20qaZNZMdngQK8fmlgzC8u7AYD3Mi+zIahz8s2kRh6kkTqw0mYvTrfnts7r7xgFxhh669BvCDa8u6ZL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UHQYuAzz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=a11LqUG0kCMn8QJAx5ciVGhtCbw78YNzvmbklFMT4gY=; b=UHQYuAzz35IHjhxifroeb5jgMZ
	vs3twGsitlTHT9LfAP4B46FZ3Ho345LcTcBHGylJZpea51LRuFc1rcfQBjatJpcKDEmyPXKsWUzc0
	XJgk7OyIy2RgQPRyzAZ9InaO4Ew8mrzmIkKD6zRiLNtvQ1Ox6kRpHrQb1Knk1jVN7q6J0EzL1dHAP
	dCpstnz+nIc3S3IK8P01GXEpwaaXAqvedpjl7HdCaBmUnoa99tkuqHPGwIg9MJnRwfZDAT5wDGP7b
	DJedIPgeHiJVlHtQ93Ixewj3CfdZnf7ljseoLYz7br4wLZCIHb8kvBusU6EdoXdnxUWTZExwQSWHB
	kVSg106w==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1shUfw-000AAK-7p; Fri, 23 Aug 2024 15:50:00 +0200
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
Subject: pull-request: bpf-next 2024-08-23
Date: Fri, 23 Aug 2024 15:49:59 +0200
Message-Id: <20240823134959.1091-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27376/Fri Aug 23 10:47:45 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 10 non-merge commits during the last 15 day(s) which contain
a total of 10 files changed, 222 insertions(+), 190 deletions(-).

The main changes are:

1) Add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_*sockopt() to address the case when
   long-lived sockets miss a chance to set additional callbacks if a sockops
   program was not attached early in their lifetime, from Alan Maguire.

2) Add a batch of BPF selftest improvements which fix a few bugs and add missing
   features to improve the test coverage of sockmap/sockhash, from Michal Luczaj.

3) Fix a false-positive Smatch-reported off-by-one in tcp_validate_cookie() which
   is part of the test_tcp_custom_syncookie BPF selftest, from Kuniyuki Iwashima.

4) Fix the flow_dissector BPF selftest which had a bug in IP header's tot_len
   calculation doing subtraction after htons() instead of inside htons(), from
   Asbjørn Sloth Tønnesen.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Dan Carpenter, Jakub Sitnicki, Toke Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit 91d516d4de48532d967a77967834e00c8c53dfe6:

  net: mvpp2: Increase size of queue_name buffer (2024-08-07 20:21:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to af8a066f1c473261881a6d8e2b55cca8eda9ce80:

  selftest: bpf: Remove mssind boundary check in test_tcp_custom_syncookie.c. (2024-08-21 23:19:33 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alan Maguire (2):
      bpf/bpf_get,set_sockopt: add option to set TCP-BPF sock ops flags
      selftests/bpf: add sockopt tests for TCP_BPF_SOCK_OPS_CB_FLAGS

Asbjørn Sloth Tønnesen (1):
      selftests/bpf: Avoid subtraction after htons() in ipip tests

Kuniyuki Iwashima (1):
      selftest: bpf: Remove mssind boundary check in test_tcp_custom_syncookie.c.

Martin KaFai Lau (2):
      Merge branch 'add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_*sockopt()'
      Merge branch 'selftests/bpf: Various sockmap-related fixes'

Michal Luczaj (6):
      selftests/bpf: Support more socket types in create_pair()
      selftests/bpf: Socket pair creation, cleanups
      selftests/bpf: Simplify inet_socketpair() and vsock_socketpair_connectible()
      selftests/bpf: Honour the sotype of af_unix redir tests
      selftests/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
      selftests/bpf: Introduce __attribute__((cleanup)) in create_pair()

 include/uapi/linux/bpf.h                           |   3 +-
 net/core/filter.c                                  |  16 +++
 tools/include/uapi/linux/bpf.h                     |   3 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |  12 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c      |  47 +++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 ++--
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 149 ++++++++++++++-------
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 117 ++--------------
 tools/testing/selftests/bpf/progs/setget_sockopt.c |  26 +++-
 .../bpf/progs/test_tcp_custom_syncookie.c          |  11 +-
 10 files changed, 222 insertions(+), 190 deletions(-)

