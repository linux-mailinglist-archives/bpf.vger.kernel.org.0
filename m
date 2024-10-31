Return-Path: <bpf+bounces-43675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055919B8606
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 23:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808851F225E5
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA481CEE91;
	Thu, 31 Oct 2024 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TrjGckgW"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4722097;
	Thu, 31 Oct 2024 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412961; cv=none; b=pdnCA4FIAJA+9tiIN7vGNNgiG2ZdsP+YQCDcWVnNip/dIZn+Ob3z2obR+jDXNk4o542rjdmLla9AEH+KLlgeE1JwG84YOKR2mNrAY0pXEg7ar3ncOh/TaBCtixwOd4wgTeO7GHjuMoj1smXuvEzq+ATQPjLA64lvz0PvlgFtyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412961; c=relaxed/simple;
	bh=Qsugghxcfd8X2KBuPsAhSzxIY/wk3Ga7LrSxOt/JNBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FCJWbMnvEi8jc6+dkRQf20tdcP9yNLWQHhMO1aVXbV6LK0nnkM/Wjziheqd/XsaSlOumyU0ytyOw8KRk80tewqFZmb8o1NH6EleaeJjAU/Ev4lnauSIYqwCzf5I8l6I8Exa3u0OYPmGc4nw7722xGjGN38m7c2ipJkN1l/6C+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TrjGckgW; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=9qZb3+0O13WmQ34m1zz0npxtZPmtp6Tr6e9o5B8LN80=; b=TrjGckgWzBIc8YIyMf7caxXQmp
	BWNkxWneMsAp6HloUrF54I1m5uEaUgLXsGzbc9A4UuvxSxiBu1c00EhYZJorzdFn+t5kN7ROlOuSh
	pmmfQtFDN78Su/bSuWbuPwazO8oDnlzNBO0RrIQueRfRp1m25TdEljwrYPnB5aBsHPe/qNEp3xRps
	Kc/zLUIZOGfm/463Xl9dAwpBneETQuep2wRBZBQv4qMZ0YaywWmK7j2BeD3DzE7ZAKb/M+biqVrQf
	Xspa6g+ttYT52rb1W0PYTv5+MXTVrHhtzRCnS13Cp906JhbNLcvhMO8p6cpnwR+jymwAjfPRCUj+G
	3C3MGoiQ==;
Received: from 47.248.197.178.dynamic.cust.swisscom.net ([178.197.248.47] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t6dSC-000965-Oq; Thu, 31 Oct 2024 23:15:44 +0100
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
Subject: pull-request: bpf-next 2024-10-31
Date: Thu, 31 Oct 2024 23:15:43 +0100
Message-Id: <20241031221543.108853-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27444/Thu Oct 31 09:34:36 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 13 non-merge commits during the last 16 day(s) which contain
a total of 16 files changed, 710 insertions(+), 668 deletions(-).

There's a small merge conflict between f91b256644ea ("selftests/bpf: Add
test for kfunc module order") in net-next tree and c3566ee6c66c
("selftests/bpf: remove test_tcp_check_syncookie") from bpf-next/net.

Resolve as follows in tools/testing/selftests/bpf/Makefile so that end
result looks like:

 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
	bench \
	bpf_testmod.ko \
	bpf_test_modorder_x.ko \
	bpf_test_modorder_y.ko \
	bpf_test_no_cfi.ko \
	flow_dissector_load \
	runqslower \
	test_cpp \
	test_flow_dissector \
	test_lirc_mode2_user \
	veristat \
	xdp_features \
	xdp_hw_metadata \
	xdp_redirect_multi \
	xdp_synproxy \
	xdping \
	xskxceiver

The main changes are:

1) Optimize and homogenize bpf_csum_diff helper for all archs and also
   add a batch of new BPF selftests for it, from Puranjay Mohan.

2) Rewrite and migrate the test_tcp_check_syncookie.sh BPF selftest
   into test_progs so that it can be run in BPF CI, from Alexis Lothoré.

3) Two BPF sockmap selftest fixes, from Zijian Zhang.

4) Small XDP synproxy BPF selftest cleanup to remove IP_DF check,
   from Vincent Li.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Daniel Borkmann, John Fastabend, Toke Høiland-Jørgensen

----------------------------------------------------------------

The following changes since commit 4a6f05d9fe8adb25dff35ca6cbd707efeda4d527:

  Merge tag 'batadv-next-pullrequest-20241015' of git://git.open-mesh.org/linux-merge (2024-10-15 15:28:17 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 00c1f3dc66a38cf65c3cfd0cb4fe7acfc7f60e37:

  selftests/bpf: Add a selftest for bpf_csum_diff() (2024-10-30 15:29:59 +0100)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexis Lothoré (eBPF Foundation) (6):
      selftests/bpf: factorize conn and syncookies tests in a single runner
      selftests/bpf: add missing ns cleanups in btf_skc_cls_ingress
      selftests/bpf: get rid of global vars in btf_skc_cls_ingress
      selftests/bpf: add ipv4 and dual ipv4/ipv6 support in btf_skc_cls_ingress
      selftests/bpf: test MSS value returned with bpf_tcp_gen_syncookie
      selftests/bpf: remove test_tcp_check_syncookie

Martin KaFai Lau (2):
      Merge branch 'Two fixes for test_sockmap'
      Merge branch 'selftests/bpf: integrate test_tcp_check_syncookie.sh into test_progs'

Puranjay Mohan (4):
      net: checksum: Move from32to16() to generic header
      bpf: bpf_csum_diff: Optimize and homogenize for all archs
      selftests/bpf: Don't mask result of bpf_csum_diff() in test_verifier
      selftests/bpf: Add a selftest for bpf_csum_diff()

Vincent Li (1):
      selftests/bpf: remove xdp_synproxy IP_DF check

Zijian Zhang (2):
      selftests/bpf: Fix msg_verify_data in test_sockmap
      selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap

 arch/parisc/lib/checksum.c                         |  13 +-
 include/net/checksum.h                             |   6 +
 lib/checksum.c                                     |  11 +-
 net/core/filter.c                                  |  39 +-
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   9 +-
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 264 +++++++------
 .../selftests/bpf/prog_tests/test_csum_diff.c      | 408 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/csum_diff_test.c |  42 +++
 .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |  82 +++--
 .../bpf/progs/test_tcp_check_syncookie_kern.c      | 167 ---------
 .../selftests/bpf/progs/verifier_array_access.c    |   3 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |   3 +-
 tools/testing/selftests/bpf/test_sockmap.c         |  32 +-
 .../selftests/bpf/test_tcp_check_syncookie.sh      |  85 -----
 .../selftests/bpf/test_tcp_check_syncookie_user.c  | 213 -----------
 16 files changed, 710 insertions(+), 668 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_csum_diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_test.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
 delete mode 100755 tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
 delete mode 100644 tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c

