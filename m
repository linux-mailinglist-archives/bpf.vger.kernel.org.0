Return-Path: <bpf+bounces-41885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90699D8C6
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 23:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F161C21E6F
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 21:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215831D0940;
	Mon, 14 Oct 2024 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eVgp0nd4"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902E4683;
	Mon, 14 Oct 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940280; cv=none; b=udeghPW1c+HRfF8Yl/vrTgNC2xeqx3taCWSz5S0QGJC+NClc7YsdSjtOG83SOdIIkmhxP4rv2kNoHGzL/NAIVjU+MyiKcmFw6EXvXJTPn8r/Or950UtnMfn7glpa0oiUl8p9C4sqggf9cKLDodxAGKHwRJJlM0Lzn91cyf+l0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940280; c=relaxed/simple;
	bh=R/DLS+Xw7OyYhNxfeQXWUUUD6LkllQytJ1hPyqj1kMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=e0BsfbEDaQ8Lw1VBcId1ITNERrLWY5vhIh6oIEnMOiy10XizVguUhEsNSY8tZItb3TPbmPhhsAm+0ZHMIAWl/q75WB0QuCR+FQmKUbtg8TZgyUemqNI+To43hTxNYWsyfdO4l6/JR6K39k9dbxTdC1XPpekqJzO6VrKzUB6QRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eVgp0nd4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=SdUR8mON2IFLbntfrRFLdckUiOEXcRl2h7inwZBQyuI=; b=eVgp0nd4gTpE+m/EayIw1OhzTW
	V0udynR9BSafUsEi10BcelXeIgdOu7VaBxgOEO8/9Ou4F0hKQ99w1kd5WZgGPM8mZmHD4Z0VsgchB
	6AWRuvQuUinfb4/8Taf1P/MY5TaINkjkwSRZax4KFNWB61/BAP6czMt0DE5Zx2ntoN5nKI2/VR6eK
	Sf251yo1PWezKldaS4H1AlKPLrfKlROBxIvAkQ3dOdeQws7GQcpjYo2DzTlM+cf9V4klmTPxmGyzt
	lRFi4i+A7kzSvkz2aeEz4Pi+gNqw13v7yRXxoSsMEyKlselFfAZiX/KtlJtb+HBNnCpKb5V1RjiQ6
	0AgGt4Og==;
Received: from 47.249.197.178.dynamic.cust.swisscom.net ([178.197.249.47] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t0SLP-00031X-Bs; Mon, 14 Oct 2024 23:11:11 +0200
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
Subject: pull-request: bpf-next 2024-10-14
Date: Mon, 14 Oct 2024 23:11:10 +0200
Message-Id: <20241014211110.16562-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27427/Mon Oct 14 10:48:30 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 21 non-merge commits during the last 18 day(s) which contain
a total of 21 files changed, 1185 insertions(+), 127 deletions(-).

The main changes are:

1) Put xsk sockets on a struct diet and add various cleanups. Overall, this helps
   to bump performance by 12% for some workloads, from Maciej Fijalkowski.

2) Extend BPF selftests to increase coverage of XDP features in combination
   with BPF cpumap, from Alexis Lothoré (eBPF Foundation).

3) Extend netkit with an option to delegate skb->{mark,priority} scrubbing to
   its BPF program, from Daniel Borkmann.

4) Make the bpf_get_netns_cookie() helper available also to tc(x) BPF programs,
   from Mahe Tardy.

5) Extend BPF selftests covering a BPF program setting socket options per MPTCP
   subflow, from Geliang Tang and Nicolas Rybowski.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jakub Kicinski, Jordan Rife, Magnus Karlsson, Mat Martineau, Matthieu 
Baerts (NGI0), Nikolay Aleksandrov

----------------------------------------------------------------

The following changes since commit c824deb1a89755f70156b5cdaf569fca80698719:

  cxgb4: clip_tbl: Fix spelling mistake "wont" -> "won't" (2024-09-27 12:44:08 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to e6c4047f5122803f2fe4ab9b1ab7038626e51ec1:

  xsk: Use xsk_buff_pool directly for cq functions (2024-10-14 17:23:49 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: add missing header include for htons
      selftests/bpf: fix bpf_map_redirect call for cpu map test
      selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
      selftests/bpf: check program redirect in xdp_cpumap_attach

Daniel Borkmann (5):
      netkit: Add option for scrubbing skb meta data
      netkit: Simplify netkit mode over to use NLA_POLICY_MAX
      netkit: Add add netkit scrub support to rt_link.yaml
      tools: Sync if_link.h uapi tooling header
      selftests/bpf: Extend netkit tests to validate skb meta data

Geliang Tang (2):
      selftests/bpf: Add getsockopt to inspect mptcp subflow
      selftests/bpf: Add mptcp subflow subtest

Maciej Fijalkowski (7):
      bpf: Remove unused macro
      xsk: Get rid of xdp_buff_xsk::xskb_list_node
      xsk: s/free_list_node/list_node/
      xsk: Get rid of xdp_buff_xsk::orig_addr
      xsk: Carry a copy of xdp_zc_max_segs within xsk_buff_pool
      xsk: Wrap duplicated code to function
      xsk: Use xsk_buff_pool directly for cq functions

Mahe Tardy (2):
      bpf: add get_netns_cookie helper to tc programs
      selftests/bpf: add tcx netns cookie tests

Martin KaFai Lau (3):
      Merge branch 'selftests/bpf: new MPTCP subflow subtest'
      Merge branch 'netkit: Add option for scrubbing skb meta data'
      Merge branch 'selftests/bpf: add coverage for xdp_features in test_progs'

Nicolas Rybowski (1):
      selftests/bpf: Add mptcp subflow example

 Documentation/netlink/specs/rt_link.yaml           |  15 +
 MAINTAINERS                                        |   2 +-
 drivers/net/netkit.c                               |  91 ++--
 include/net/xdp_sock_drv.h                         |  14 +-
 include/net/xsk_buff_pool.h                        |  23 +-
 include/uapi/linux/if_link.h                       |  15 +
 net/core/filter.c                                  |  17 +-
 net/xdp/xsk.c                                      |  38 +-
 net/xdp/xsk_buff_pool.c                            |  54 +-
 net/xdp/xsk_queue.h                                |   2 +-
 tools/include/uapi/linux/if_link.h                 | 553 ++++++++++++++++++++-
 tools/testing/selftests/bpf/network_helpers.h      |   1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 121 +++++
 .../selftests/bpf/prog_tests/netns_cookie.c        |  29 +-
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |  94 +++-
 .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   |  44 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      |  42 ++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c  | 128 +++++
 .../selftests/bpf/progs/netns_cookie_prog.c        |  10 +
 tools/testing/selftests/bpf/progs/test_tc_link.c   |  12 +
 .../bpf/progs/test_xdp_with_cpumap_helpers.c       |   7 +-
 21 files changed, 1185 insertions(+), 127 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

