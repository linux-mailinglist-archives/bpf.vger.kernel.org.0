Return-Path: <bpf+bounces-71452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290ABF3BBA
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B7818C2F2D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235E335076;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdMDObck"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42233375D;
	Mon, 20 Oct 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995600; cv=none; b=DxMrWqWr0Mri9q3Q5I2S8Kq3AAQzpd6jmD+3uO+PRTvKh/2le7V+SsIZcB+kC/xSnHqhoiScGWf1LkCi1Q1dPO0zoQca7lRW38bLK6QHM3ooIPj13ioG3YJD0ZPLWjEzQcRPsfv4/yoetHAU8HXS3MyLIrygb91I/Lvwn5Hfj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995600; c=relaxed/simple;
	bh=Vl0LkZmcqdOilJhaw5cYs+K+TtJi8z4nn49piM4Us7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bvDsEM8sSLDOZDt/3fviYF/7HbUBxCpYhlq8Fi08uDEDWOe+MQJvRFRhVoTw95fGT215OnCQ0QCdvOG3lpGHxmgXkUAwOahNbtfmIKptbHJgzaDVnyVlcOtG3NDBRjAUGncBjj9msdpNuqUXPe4O96gsPeOb//n3HOh7glM+7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdMDObck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9979C116C6;
	Mon, 20 Oct 2025 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995599;
	bh=Vl0LkZmcqdOilJhaw5cYs+K+TtJi8z4nn49piM4Us7I=;
	h=From:To:Cc:Subject:Date:From;
	b=gdMDObckHy+NxEkwxjfSkC7R1bwKgRt2UNZignA+OoLCAWbAYp+OhAzNHSMmbpMs7
	 HLSgLrHUJZWcAME4snDcfIh+oG4LxZykpg/gcaE1zAXJ5ttIFw4XS+jvJnKBnjNlIg
	 CJp6qcST0bPbFueQp6iOeEZdRRsRm9ojt5GJXNAmsNY5nM2W7XLFhFFnbxZZnX/6dX
	 tsqpJtEQ8bpnHFP2yr5S5A148Jp51UV4VLm2k5RSm2nwqt9T8j7hlVHN3qTU1CqE9j
	 WugVpCaqtnkDWexRiOnGPvxAJbAE3hEm7jaXMHsgt0nhyHEnsvhxvJ8nO5BWp0Qgfw
	 WZppfnH7scWow==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/9] net: Introduce struct sockaddr_unspec
Date: Mon, 20 Oct 2025 14:26:29 -0700
Message-Id: <20251020212125.make.115-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9326; i=kees@kernel.org; h=from:subject:message-id; bh=Vl0LkZmcqdOilJhaw5cYs+K+TtJi8z4nn49piM4Us7I=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVnJl/DwsUdZ9cxejif1zEa2nrxi/VHE/mfgs9eHWP Ee5C3mFHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOpd2Bk+LOLs/rFF36W7c4L 3/2W+V9/ZIH525XME0XXCfWFxT2QPMPwkzEoWC0oanvAnR1eU2bksRpXTFi+KK582Ub9fzsjv79 fyQMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

 v3:
   - fix missed kernel_connect/bind casts in bpf selftests
   - fix missed kernel_connect cast in samples/
   - drop "bpf: Add size validation to bpf_sock_addr_set_sun_path()",
     which is technically unrelated to the sockaddr conversion
 v2: https://lore.kernel.org/linux-hardening/20251014223349.it.173-kees@kernel.org/
 v1: https://lore.kernel.org/all/20250723230354.work.571-kees@kernel.org/

The historically fixed-size struct sockaddr is part of UAPI and embedded
in many existing structures. The kernel uses struct sockaddr extensively
within the kernel to represent arbitrarily sized sockaddr structures,
which caused problems with the compiler's ability to determine object
sizes correctly. The "temporary" solution was to make sockaddr explicitly
use a flexible array, but this causes problems for embedding struct
sockaddr in structures, where once again the compiler has to guess about
the size of such objects, and causes thousands of warnings under the
coming -Wflex-array-member-not-at-end warning.

Switching to sockaddr_storage internally everywhere wastes a lot of memory,
so we are left with needing two changes:
- introduction of an explicitly arbitrarily sized sockaddr struct
- switch struct sockaddr back to being fixed size

Doing the latter step requires all "arbitrarily sized" uses of struct
sockaddr to be replaced with the new struct from the first step.

So, introduce the new struct and do enough conversions that we can
switch sockaddr back to a fixed-size sa_data.

Thanks!

-Kees

Kees Cook (9):
  net: Add struct sockaddr_unspec for sockaddr of unknown length
  net/l2tp: Add missing sa_family validation in
    pppol2tp_sockaddr_get_info
  net: Convert proto_ops bind() callbacks to use sockaddr_unspec
  net: Convert proto_ops connect() callbacks to use sockaddr_unspec
  net: Remove struct sockaddr from net.h
  net: Convert proto callbacks from sockaddr to sockaddr_unspec
  bpf: Convert cgroup sockaddr filters to use sockaddr_unspec
    consistently
  bpf: Convert bpf_sock_addr_kern "uaddr" to sockaddr_unspec
  net: Convert struct sockaddr to fixed-size "sa_data[14]"

 include/linux/bpf-cgroup.h                    | 17 ++++++++------
 include/linux/filter.h                        |  2 +-
 include/linux/net.h                           |  9 ++++----
 include/linux/socket.h                        | 23 +++++++++++++++----
 include/net/inet_common.h                     | 13 +++++------
 include/net/ip.h                              |  4 ++--
 include/net/ipv6.h                            | 10 ++++----
 include/net/ipv6_stubs.h                      |  2 +-
 include/net/ping.h                            |  2 +-
 include/net/sctp/sctp.h                       |  2 +-
 include/net/sock.h                            | 14 +++++------
 include/net/tcp.h                             |  2 +-
 include/net/udp.h                             |  2 +-
 include/net/vsock_addr.h                      |  2 +-
 net/rds/rds.h                                 |  2 +-
 net/smc/smc.h                                 |  4 ++--
 .../perf/trace/beauty/include/linux/socket.h  |  5 +---
 crypto/af_alg.c                               |  2 +-
 drivers/block/drbd/drbd_receiver.c            |  6 ++---
 drivers/infiniband/hw/erdma/erdma_cm.c        |  6 ++---
 drivers/infiniband/sw/siw/siw_cm.c            |  8 +++----
 drivers/isdn/mISDN/l1oip_core.c               |  2 +-
 drivers/isdn/mISDN/socket.c                   |  4 ++--
 drivers/net/ppp/pppoe.c                       |  4 ++--
 drivers/net/ppp/pptp.c                        |  8 +++----
 drivers/net/wireless/ath/ath10k/qmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/qmi.c         |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c         |  2 +-
 drivers/nvme/host/tcp.c                       |  4 ++--
 drivers/nvme/target/tcp.c                     |  2 +-
 drivers/slimbus/qcom-ngd-ctrl.c               |  2 +-
 drivers/target/iscsi/iscsi_target_login.c     |  2 +-
 drivers/xen/pvcalls-back.c                    |  4 ++--
 fs/afs/rxrpc.c                                |  6 ++---
 fs/coredump.c                                 |  2 +-
 fs/dlm/lowcomms.c                             |  8 +++----
 fs/ocfs2/cluster/tcp.c                        |  6 ++---
 fs/smb/client/connect.c                       |  4 ++--
 fs/smb/server/transport_tcp.c                 |  4 ++--
 kernel/bpf/cgroup.c                           |  8 +++----
 net/9p/trans_fd.c                             |  8 +++----
 net/appletalk/ddp.c                           |  4 ++--
 net/atm/pvc.c                                 |  4 ++--
 net/atm/svc.c                                 |  4 ++--
 net/ax25/af_ax25.c                            |  4 ++--
 net/bluetooth/hci_sock.c                      |  2 +-
 net/bluetooth/iso.c                           |  6 ++---
 net/bluetooth/l2cap_sock.c                    |  4 ++--
 net/bluetooth/rfcomm/core.c                   |  6 ++---
 net/bluetooth/rfcomm/sock.c                   |  5 ++--
 net/bluetooth/sco.c                           |  4 ++--
 net/caif/caif_socket.c                        |  2 +-
 net/can/bcm.c                                 |  2 +-
 net/can/isotp.c                               |  2 +-
 net/can/j1939/socket.c                        |  4 ++--
 net/can/raw.c                                 |  2 +-
 net/ceph/messenger.c                          |  2 +-
 net/core/dev.c                                |  2 +-
 net/core/dev_ioctl.c                          |  2 +-
 net/core/filter.c                             |  5 ++--
 net/core/sock.c                               |  6 ++---
 net/ieee802154/socket.c                       | 12 +++++-----
 net/ipv4/af_inet.c                            | 16 ++++++-------
 net/ipv4/arp.c                                |  2 +-
 net/ipv4/datagram.c                           |  4 ++--
 net/ipv4/ping.c                               |  8 +++----
 net/ipv4/raw.c                                |  3 ++-
 net/ipv4/tcp.c                                |  2 +-
 net/ipv4/tcp_ipv4.c                           |  4 ++--
 net/ipv4/udp.c                                |  6 +++--
 net/ipv4/udp_tunnel_core.c                    |  4 ++--
 net/ipv6/af_inet6.c                           |  6 ++---
 net/ipv6/datagram.c                           |  8 +++----
 net/ipv6/ip6_udp_tunnel.c                     |  4 ++--
 net/ipv6/ping.c                               |  2 +-
 net/ipv6/raw.c                                |  3 ++-
 net/ipv6/tcp_ipv6.c                           |  6 ++---
 net/ipv6/udp.c                                |  5 ++--
 net/iucv/af_iucv.c                            |  6 ++---
 net/l2tp/l2tp_core.c                          |  8 +++----
 net/l2tp/l2tp_ip.c                            |  6 +++--
 net/l2tp/l2tp_ip6.c                           |  5 ++--
 net/l2tp/l2tp_ppp.c                           |  9 +++++++-
 net/llc/af_llc.c                              |  4 ++--
 net/mctp/af_mctp.c                            |  4 ++--
 net/mctp/test/route-test.c                    |  2 +-
 net/mctp/test/utils.c                         |  5 ++--
 net/mptcp/pm_kernel.c                         |  4 ++--
 net/mptcp/protocol.c                          |  5 ++--
 net/mptcp/subflow.c                           |  4 ++--
 net/netfilter/ipvs/ip_vs_sync.c               |  6 ++---
 net/netlink/af_netlink.c                      |  4 ++--
 net/netrom/af_netrom.c                        |  6 ++---
 net/nfc/llcp_sock.c                           |  6 ++---
 net/nfc/rawsock.c                             |  2 +-
 net/packet/af_packet.c                        | 15 ++++++------
 net/phonet/pep.c                              |  3 ++-
 net/phonet/socket.c                           | 10 ++++----
 net/qrtr/af_qrtr.c                            |  4 ++--
 net/qrtr/ns.c                                 |  2 +-
 net/rds/af_rds.c                              |  2 +-
 net/rds/bind.c                                |  2 +-
 net/rds/tcp_connect.c                         |  4 ++--
 net/rds/tcp_listen.c                          |  2 +-
 net/rose/af_rose.c                            |  4 ++--
 net/rxrpc/af_rxrpc.c                          |  4 ++--
 net/rxrpc/rxperf.c                            |  2 +-
 net/sctp/socket.c                             | 13 ++++++-----
 net/smc/af_smc.c                              |  6 ++---
 net/socket.c                                  | 14 +++++------
 net/sunrpc/clnt.c                             |  6 ++---
 net/sunrpc/svcsock.c                          |  2 +-
 net/sunrpc/xprtsock.c                         |  9 ++++----
 net/tipc/socket.c                             |  6 ++---
 net/unix/af_unix.c                            | 12 +++++-----
 net/vmw_vsock/af_vsock.c                      |  6 ++---
 net/vmw_vsock/vsock_addr.c                    |  2 +-
 net/x25/af_x25.c                              |  4 ++--
 net/xdp/xsk.c                                 |  2 +-
 samples/qmi/qmi_sample_client.c               |  2 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++--
 121 files changed, 326 insertions(+), 290 deletions(-)

-- 
2.34.1


