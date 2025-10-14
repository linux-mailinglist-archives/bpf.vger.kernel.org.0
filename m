Return-Path: <bpf+bounces-70930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA5BDBAD2
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A251F4FC796
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9F30DECE;
	Tue, 14 Oct 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKWFy3Hn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAC2E7F22;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481814; cv=none; b=H0JnihCrOEwsAHK3MRCCnu3PwS97OgwcuTVApaIZATwemepY0Ac7CCot1KVyNWU3kNKE+fH4RoFhL5IlisHGqPCGN9Uom6l47r3tklbGulZMO59DFNTjeneaKV6AyfTGax5pKCEpojDc4GcrBcA1YLuslTifZoOoy80TsXWKbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481814; c=relaxed/simple;
	bh=6J7jMaWSktm0Exujgt4294K+p6lq0OLmTk8omdfZlYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAnRjCg3uHKkAi7d6C8tgFsrXJNodW5p6RZ4rpZtno+WnQmsJcpxX2pgKKthowWvTXsVLwL5E4mVh015Wky29YucVCWIy9HxI4oPfGXzs7n+hUDow07CYEi8YeezEG6JJX2t0hzjVkuRWRKCwQFLgh/nXAYgYH9tzh68Mr9wdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKWFy3Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767C6C4CEF9;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=6J7jMaWSktm0Exujgt4294K+p6lq0OLmTk8omdfZlYw=;
	h=From:To:Cc:Subject:Date:From;
	b=JKWFy3HnF5NmTPkhEWnaatPh7ukJHliv4zIzT6qaBK3DZ61pY6f8Agfi3HN2fzv8R
	 29+mdRmT8zC3OkTqnvIwzkj3R//eNdsrvISsrwcVcYK2w8IOf5Lq3zi16029Y+QQlG
	 optofRgkONFUKUFSo5r0ss2TI5n/PZI050XP2hWol/HaWBk5uGgq40F4ZhUIV/UAjq
	 MFzXd1AvaS5kvTRVLaQGPOEtE8Q4bHDYhprPxij+KLbl7CwWx75Qtk3Y+p5zDC1VnO
	 mBfFcQrSeqTrbvPtw674iv5/WZ/HHgu8ZPDtjjXypky5kQV2mhh+yPVzApCgfCBi8N
	 CgnHdBJ4XeyCA==
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
Subject: [PATCH v2 00/10] net: Introduce struct sockaddr_unspec
Date: Tue, 14 Oct 2025 15:43:22 -0700
Message-Id: <20251014223349.it.173-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9004; i=kees@kernel.org; h=from:subject:message-id; bh=6J7jMaWSktm0Exujgt4294K+p6lq0OLmTk8omdfZlYw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLvFfvK6bdOfvIqNw9gMfjTwP/jP+0pRlIu703WWPj iArg3RSRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQ+3WD4n+Tn+OLEqkdJK9U2 +cSHrg5p/c2wNXHRj327VW8FcK3jLmT4K1TkqHC/YcGhhcVZ7MYl05KrM+KUfPmFr7y9W82611i eAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

The historically fixed-size struct sockaddr is part of UAPI and embedded
in many existing structures. The kernel uses struct sockaddr extensively
within the kernel to represent arbitrarily sized sockaddr structures,
which caused problems with the compiler's ability to determine object
sizes correctly. The "temporary" solution was to make sockaddr explicitly
use a flexible array, but this causes problems for embedding struct
sockaddr in structures, where once again the compiler has to guess about
the size of such objects, and causes thousands of warnings under the
coming -Wflex-array-member-not-at-end.

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

 v2:
  - Include BPF casts
  - Move sockaddr_unspec out of UAPI
 v1: https://lore.kernel.org/all/20250723230354.work.571-kees@kernel.org/

Kees Cook (10):
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
  bpf: Add size validation to bpf_sock_addr_set_sun_path()
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
 net/core/filter.c                             | 13 ++++++++---
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
 119 files changed, 330 insertions(+), 288 deletions(-)

-- 
2.34.1


