Return-Path: <bpf+bounces-18319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D3818DA0
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E0D1C24D04
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1631A71;
	Tue, 19 Dec 2023 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TdOY54SB"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF53714B;
	Tue, 19 Dec 2023 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=e62DNxTUMvxp5Y/+sEj2mz9Kgu2LG5qJYrY152LyCPA=; b=TdOY54SBkrOgSbmZG9pTRfyBD7
	/QRFOs/YtHzf+80CqHqpi5cuyQQ54xGDEuriRyQthATfvGHlciXNmX61Zt6JeSBySsEyD6tuAfWyT
	V+zcg8d63W+m2U6CfnhSpIIdpJQqTdLMqVu6gTjtFSZIIKXlQZxS8FP/Auh3Z7cD69SYOLnlqVHJu
	5Oibs1XiFAU5XO3CzKQpVVYYnscVolwC8+9FgPj8+3RIFNi8u97pu7vUV3NBPcsL8Yk7SvjlDHf3M
	LYf4Dn6b1fuOPRq0LI9z2OihCmUv2rhNB5k4cSkD0iDHn81HMjXYnUUCz1cd+qGMgOgppd1jEq6MD
	5ftBIFkA==;
Received: from 12.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFdVg-000B47-KN; Tue, 19 Dec 2023 18:04:00 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	torvalds@linuxfoundation.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2023-12-19
Date: Tue, 19 Dec 2023 18:03:59 +0100
Message-Id: <20231219170359.11035-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27128/Tue Dec 19 10:36:48 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 2 non-merge commits during the last 1 day(s) which contain
a total of 40 files changed, 642 insertions(+), 2926 deletions(-).

The main changes are:

1) Revert all of BPF token-related patches for now as per list discussion [0],
   from Andrii Nakryiko.

   [0] https://lore.kernel.org/bpf/CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com

2) Fix a syzbot-reported use-after-free read in nla_find() triggered from
   bpf_skb_get_nlattr_nest() helper, from Jakub Kicinski.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Simon Horman

----------------------------------------------------------------

The following changes since commit f7dd48ea76be30666f0614d6a06061185ed38c60:

  Merge branch 'add-pf-vf-mailbox-support' (2023-12-19 12:00:55 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to d17aff807f845cf93926c28705216639c7279110:

  Revert BPF token-related functionality (2023-12-19 08:23:03 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Andrii Nakryiko (1):
      Revert BPF token-related functionality

Jakub Kicinski (1):
      bpf: Use nla_ok() instead of checking nla_len directly

 drivers/media/rc/bpf-lirc.c                        |    2 +-
 include/linux/bpf.h                                |   85 +-
 include/linux/filter.h                             |    2 +-
 include/linux/lsm_hook_defs.h                      |   15 +-
 include/linux/security.h                           |   43 +-
 include/uapi/linux/bpf.h                           |   42 -
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arraymap.c                              |    2 +-
 kernel/bpf/bpf_lsm.c                               |   15 +-
 kernel/bpf/cgroup.c                                |    6 +-
 kernel/bpf/core.c                                  |    3 +-
 kernel/bpf/helpers.c                               |    6 +-
 kernel/bpf/inode.c                                 |  326 +------
 kernel/bpf/syscall.c                               |  215 ++--
 kernel/bpf/token.c                                 |  271 -----
 kernel/bpf/verifier.c                              |   13 +-
 kernel/trace/bpf_trace.c                           |    2 +-
 net/core/filter.c                                  |   38 +-
 net/ipv4/bpf_tcp_ca.c                              |    2 +-
 net/netfilter/nf_bpf_link.c                        |    2 +-
 security/security.c                                |  101 +-
 security/selinux/hooks.c                           |   47 +-
 tools/include/uapi/linux/bpf.h                     |   42 -
 tools/lib/bpf/Build                                |    2 +-
 tools/lib/bpf/bpf.c                                |   37 +-
 tools/lib/bpf/bpf.h                                |   35 +-
 tools/lib/bpf/btf.c                                |    7 +-
 tools/lib/bpf/elf.c                                |    2 +
 tools/lib/bpf/features.c                           |  478 ---------
 tools/lib/bpf/libbpf.c                             |  573 ++++++++---
 tools/lib/bpf/libbpf.h                             |   37 +-
 tools/lib/bpf/libbpf.map                           |    1 -
 tools/lib/bpf/libbpf_internal.h                    |   36 +-
 tools/lib/bpf/libbpf_probes.c                      |    8 +-
 tools/lib/bpf/str_error.h                          |    3 -
 .../selftests/bpf/prog_tests/libbpf_probes.c       |    4 -
 .../testing/selftests/bpf/prog_tests/libbpf_str.c  |    6 -
 tools/testing/selftests/bpf/prog_tests/token.c     | 1031 --------------------
 tools/testing/selftests/bpf/progs/priv_map.c       |   13 -
 tools/testing/selftests/bpf/progs/priv_prog.c      |   13 -
 40 files changed, 642 insertions(+), 2926 deletions(-)
 delete mode 100644 kernel/bpf/token.c
 delete mode 100644 tools/lib/bpf/features.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
 delete mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c

