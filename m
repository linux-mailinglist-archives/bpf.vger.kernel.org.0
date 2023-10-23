Return-Path: <bpf+bounces-13035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3927D3D44
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAFEB20E26
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5577F20317;
	Mon, 23 Oct 2023 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="E0uIgfeu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD311EA73;
	Mon, 23 Oct 2023 17:19:13 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C92EE;
	Mon, 23 Oct 2023 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Xvdm2nlWUsjr8Nk0q5x2uduxl+Asd3Qw4JFB76l2a2s=; b=E0uIgfeuP989sKTiMQ2OERyWYW
	FOLKozUw/ulgcoOtR88leGUYPBynEeYCZxaOIqx+v3ekn6CC4H3jE0Ii8OKNbxL6QkwGlVRDhsoX/
	I/UpcPKuT4p2e3MFEaMbYnFAtBeWIsGa8XwBCmqp3TctcMSYtUX0T8unUiVtwBJWuw+LXnPZ0OKvh
	arfvbugoH69rejYDnLeADGeEgSriQQdZFXgXVuTHUklOhRudIiB2wXfElPVFxiHRBbKgMB1liaiVy
	FrNh7blEu4I10aN16bueRqmo9Ja3k2H+et85Ib2sm1rT6Nyd7vgPH3xHN92vYkiZhiyuX2d1BEG1w
	pJYMZKsw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1quyZx-000PQZ-0F; Mon, 23 Oct 2023 19:19:01 +0200
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
Subject: [PATCH bpf-next v3 0/7] Add bpf programmable net device
Date: Mon, 23 Oct 2023 19:18:49 +0200
Message-Id: <20231023171856.18324-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27070/Mon Oct 23 09:53:01 2023)

This work adds a BPF programmable device which can operate in L3 or L2
mode where the BPF program is part of the xmit routine. It's program
management is done via bpf_mprog and it comes with BPF link support.
For details see patch 1 and following. Thanks!

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
 drivers/net/netkit.c                          | 934 ++++++++++++++++++
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
 25 files changed, 2427 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/netkit.c
 create mode 100644 include/net/netkit.h
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_netkit.c

-- 
2.34.1


