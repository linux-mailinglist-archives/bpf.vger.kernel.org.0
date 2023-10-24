Return-Path: <bpf+bounces-13165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DBF7D5D75
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F9B2108E
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2A42909;
	Tue, 24 Oct 2023 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ncxJjAn3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2711CBD;
	Tue, 24 Oct 2023 21:49:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC0A6;
	Tue, 24 Oct 2023 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=c0DJTuLxstmAp25y+y+QPDwEnfa1MrG29USQVLl7Wp0=; b=ncxJjAn32+Z94uPnp57AjfIbWN
	AwTtB/SXNGoJQK+3j7ITK54ab5uPl+mvwhLBosMO7K5MwaxCRJLtBaLynj0Fn/vkEczgRVbttz5a4
	bws2N24+6tWkUti24g+jay0+Is39izuQ5PvJYUccyPFPSdPqRA7sUBcLkqZtou1RdWOvM+Qtmpvhx
	Hh6/d/bDVaSGHkcITW9keSWvyleKSSQ2aCy4Jth3uYh8pPYI8QQv/pCmMlRrlRPmhewzwJTCKiMZh
	5e0dHR3ctipBpmxNlq+RS/yg6NYixEpK6RETxIt+0Qb40NR69O+9WnIYXnLuwjddDcRALrFL7crHz
	hvYc31Cg==;
Received: from 40.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.40] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvPGw-0001ke-W4; Tue, 24 Oct 2023 23:49:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	sdf@google.com,
	toke@kernel.org,
	kuba@kernel.org,
	andrew@lunn.ch,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 0/7] Add bpf programmable net device
Date: Tue, 24 Oct 2023 23:48:57 +0200
Message-Id: <20231024214904.29825-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)
X-Spam-Level: *

This work adds a BPF programmable device which can operate in L3 or L2
mode where the BPF program is part of the xmit routine. It's program
management is done via bpf_mprog and it comes with BPF link support.
For details see patch 1 and following. Thanks!

v3 -> v4:
  - Moved netkit_release_all() into ndo_uninit (Stan)
  - Two small commit msg corrections (Toke)
  - Added Acked/Reviewed-by
v2 -> v3:
  - Remove setting dev->min_mtu to ETH_MIN_MTU (Andrew)
  - Do not populate ethtool info->version (Andrew)
  - Populate netdev private data before register_netdevice (Andrew)
  - Use strscpy for ifname template (Jakub)
  - Use GFP_KERNEL_ACCOUNT for link kzalloc (Jakub)
  - Carry and dump link attach type for bpftool (Toke)
v1 -> v2:
  - Rename from meta (Toke, Andrii, Alexei)
  - Reuse skb_scrub_packet (Stan)
  - Remove IFF_META and use netdev_ops (Toke)
  - Add comment to multicast handler (Toke)
  - Remove silly version info (Toke)
  - Fix attach_type_name (Quentin)
  - Rework libbpf link attach api to be similar
    as tcx (Andrii)
  - Move flags last for bpf_netkit_opts (Andrii)
  - Rebased to bpf_mprog query api changes
  - Folded link support patch into main one

Daniel Borkmann (7):
  netkit, bpf: Add bpf programmable net device
  tools: Sync if_link uapi header
  libbpf: Add link-based API for netkit
  bpftool: Implement link show support for netkit
  bpftool: Extend net dump with netkit progs
  selftests/bpf: Add netlink helper library
  selftests/bpf: Add selftests for netkit

 MAINTAINERS                                   |   9 +
 drivers/net/Kconfig                           |   9 +
 drivers/net/Makefile                          |   1 +
 drivers/net/netkit.c                          | 940 ++++++++++++++++++
 include/net/netkit.h                          |  38 +
 include/uapi/linux/bpf.h                      |  14 +
 include/uapi/linux/if_link.h                  |  24 +
 kernel/bpf/syscall.c                          |  30 +-
 .../bpf/bpftool/Documentation/bpftool-net.rst |   8 +-
 tools/bpf/bpftool/link.c                      |   9 +
 tools/bpf/bpftool/net.c                       |   7 +-
 tools/include/uapi/linux/bpf.h                |  14 +
 tools/include/uapi/linux/if_link.h            | 141 +++
 tools/lib/bpf/bpf.c                           |  16 +
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        |  39 +
 tools/lib/bpf/libbpf.h                        |  15 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |  19 +-
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/netlink_helpers.c | 358 +++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  46 +
 .../selftests/bpf/prog_tests/tc_helpers.h     |   4 +
 .../selftests/bpf/prog_tests/tc_netkit.c      | 687 +++++++++++++
 .../selftests/bpf/progs/test_tc_link.c        |  13 +
 25 files changed, 2433 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/netkit.c
 create mode 100644 include/net/netkit.h
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_netkit.c

-- 
2.34.1


