Return-Path: <bpf+bounces-50980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81FCA2EEB5
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349193A3316
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15C22FDFA;
	Mon, 10 Feb 2025 13:48:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FD17BB6;
	Mon, 10 Feb 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195314; cv=none; b=CMtE/RvUTbe1urXSbsIkq6zkxtP2oygyxhkoVtBcMmLWpKdh2VBx0bbYY0P1TiselGug4++BkbzgYz/vZIz5/E27dFrzTCqeZb0sVaSB2o6o9JGoZ0ekEAouFkSY8xE7F/EIa4QNynRaeCGeSef1/vOlsToMPqRGC8w0QyUBozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195314; c=relaxed/simple;
	bh=pxuktho1cH+/a8gafDR/2L4T0jul+ZuYmlp0zh3lz9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IFaGmGKE4vq6plvEewj//j43gYTDRKzGu5Cg3sS4JMxiTW78jjYsHbeg07oupFtKGQL24Fif180+WJ2/a5CgK7AVTllUwMv5i+hrtW0lmd3tIVVYHYJw2abTkKAi9zM6+w2B7sdwqcNFoUpZ7/J/G49La31mwdLs8r/K/dXZSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ys5RB2V7hz1V6Xt;
	Mon, 10 Feb 2025 21:44:38 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 69FDD140156;
	Mon, 10 Feb 2025 21:48:22 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 21:48:22 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 21:48:20 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH v2 0/2] bpf-next: Introduced to support the ULP to get or set sockets
Date: Mon, 10 Feb 2025 21:45:48 +0800
Message-ID: <20250210134550.3189616-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn200003.china.huawei.com (7.202.194.126)

From: Mingyi Zhang <zhangmingyi5@huawei.com>

We want call bpf_setsockopt to replace the kernel module in the TCP_ULP
case. The purpose is to customize the behavior in connect and sendmsg
after the user-defined ko file is loaded. We have an open source
community project kmesh (kmesh.net). Based on this, we refer to some
processes of tcp fastopen to implement delayed connet and perform HTTP
DNAT when sendmsg.In this case, we need to parse HTTP packets in the
bpf program and set TCP_ULP for the specified socket.

Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
I'm not sure why there is such a difference, but I noticed that
tcp_setsockopt is called in bpf_setsockopt.I think we can add the
handling of this case.

Change list:
- v1 -> v2:
  - modified the do_tcp_setsockopt(TCP_ULP) process by referring to
  section do_tcp_setsockopt(TCP_CONGESTION), avoid sleep
  - The selftest case is modified. An independent file is selected
  for the test to avoid affecting the original file in setget_sockopt.c
  - fixed some formatting errors, such as Signed and Subject

Revisions:
- v1
  https://lore.kernel.org/bpf/20250127090724.3168791-1-zhangmingyi5@huawei.com/

Mingyi Zhang (2):
  bpf-next: Introduced to support the ULP to get or set sockets
  bpf-next: selftest for TCP_ULP in bpf_setsockopt

 include/net/tcp.h                             |  2 +-
 net/core/filter.c                             |  1 +
 net/ipv4/tcp.c                                |  2 +-
 net/ipv4/tcp_ulp.c                            | 28 +++----
 net/mptcp/subflow.c                           |  2 +-
 .../bpf/prog_tests/setget_sockopt_tcp_ulp.c   | 78 +++++++++++++++++++
 .../bpf/progs/setget_sockopt_tcp_ulp.c        | 33 ++++++++
 7 files changed, 130 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
 create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c

-- 
2.43.0


