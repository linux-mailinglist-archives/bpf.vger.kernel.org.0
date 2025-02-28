Return-Path: <bpf+bounces-52856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D51A491E4
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 08:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7743B5DB7
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709F1C5F06;
	Fri, 28 Feb 2025 07:09:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9D748F;
	Fri, 28 Feb 2025 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726566; cv=none; b=JKSK3hlVQlcRd4vJALLsc/IN3mwcBpNon+5Bs/TvD3nUw1HBvcDUMYDPNe46QlnEHSXsxvQlS8cr1qBfM9jcLt8R61UZd7e9gXEdxVZr/rNhnv++ZJnwsVJpHdu85/fCFiAtgJaxSxWFgCVAP1aGmZ+1eza2R4RiaqVYqLad1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726566; c=relaxed/simple;
	bh=xxNnvOq+BfHZ1I5AhbpH+De5ZdG2UHgdQE79LxWbI9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZwkv5s5bKKxy1TVnAu3RCQg9MUYP360eXfMSjui06k4TwOV3Pnl7Jcq2YvPnptEsWFcYsjIG5Y9Jj4iMHk5md1N86JEFf/mX37v9HzUNAggRnM/DjGfxt0D+UIuZ0UG8UfiSvjP3XZ53BahfCIHmcnolbTsYfJfsI3nJZmGG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z3zk27083z1ltbt;
	Fri, 28 Feb 2025 15:05:14 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id DBA75180042;
	Fri, 28 Feb 2025 15:09:20 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 15:09:20 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 15:09:18 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next v3 0/2] Introduced to support the ULP to get or set sockets
Date: Fri, 28 Feb 2025 15:06:26 +0800
Message-ID: <20250228070628.3219087-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
- v2 -> V3:
  - fixed some compilation issues and added TCP_ULP macro
  - Move __tcp_set_ulp outside rcu_read_unlock

- v1 -> v2:
  - modified the do_tcp_setsockopt(TCP_ULP) process by referring to
  section do_tcp_setsockopt(TCP_CONGESTION), avoid sleep
  - The selftest case is modified. An independent file is selected
  for the test to avoid affecting the original file in setget_sockopt.c
  - fixed some formatting errors, such as Signed and Subject

Revisions:
- v1
  https://lore.kernel.org/bpf/20250127090724.3168791-1-zhangmingyi5@huawei.com/

- v2
  https://lore.kernel.org/bpf/20250210134550.3189616-1-zhangmingyi5@huawei.com/

Mingyi Zhang (2):
  Introduced to support the ULP to get or set sockets
  selftest for TCP_ULP in bpf_setsockopt

 include/net/tcp.h                             |  2 +-
 net/core/filter.c                             |  1 +
 net/ipv4/tcp.c                                |  2 +-
 net/ipv4/tcp_ulp.c                            | 28 ++++++++--------
 net/mptcp/subflow.c                           |  2 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 32 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../selftests/bpf/progs/setget_sockopt.c      | 24 ++++++++++++++
 8 files changed, 76 insertions(+), 16 deletions(-)

-- 
2.43.0


