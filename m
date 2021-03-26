Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54AA34B2E5
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhCZXVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:21:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:11392 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhCZXVj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:21:39 -0400
IronPort-SDR: WzAOPcTzNXdGyHvudFdO08VGrUnAh1uJ4bJ4BjDBPK+Pv743BwddJYWwoSEW04Y8o7qYgQ5sQn
 aifh2ogi9Vjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="190681423"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="190681423"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 16:21:09 -0700
IronPort-SDR: FSShKgROb4BR8MT6h0DENGOLUQDGDPHz0dPHUhb5X+BX2UeNI83Ql4bmkmP6EzQECv3o8y9KVG
 Mwfqouz70LaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="410113248"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2021 16:21:07 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, andrii@kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        ciara.loftus@intel.com, john.fastabend@gmail.com, toke@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 bpf-next 04/17] selftests: xsk: remove inline keyword from source file
Date:   Sat, 27 Mar 2021 00:09:25 +0100
Message-Id: <20210326230938.49998-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326230938.49998-1-maciej.fijalkowski@intel.com>
References: <20210326230938.49998-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Follow the kernel coding style guidelines and let compiler do the
decision about inlining.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 6769e9e2de17..08058a3d9aec 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -158,7 +158,7 @@ static void *memset32_htonl(void *dest, u32 val, u32 size)
  * This function code has been taken from
  * Linux kernel include/asm-generic/checksum.h
  */
-static inline __u16 csum_fold(__u32 csum)
+static __u16 csum_fold(__u32 csum)
 {
 	u32 sum = (__force u32)csum;
 
@@ -171,7 +171,7 @@ static inline __u16 csum_fold(__u32 csum)
  * This function code has been taken from
  * Linux kernel lib/checksum.c
  */
-static inline u32 from64to32(u64 x)
+static u32 from64to32(u64 x)
 {
 	/* add up 32-bit and 32-bit for 32+c bit */
 	x = (x & 0xffffffff) + (x >> 32);
@@ -180,13 +180,11 @@ static inline u32 from64to32(u64 x)
 	return (u32)x;
 }
 
-__u32 csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len, __u8 proto, __u32 sum);
-
 /*
  * This function code has been taken from
  * Linux kernel lib/checksum.c
  */
-__u32 csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len, __u8 proto, __u32 sum)
+static __u32 csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len, __u8 proto, __u32 sum)
 {
 	unsigned long long s = (__force u32)sum;
 
@@ -204,13 +202,12 @@ __u32 csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len, __u8 proto, __u3
  * This function has been taken from
  * Linux kernel include/asm-generic/checksum.h
  */
-static inline __u16
-csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len, __u8 proto, __u32 sum)
+static __u16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len, __u8 proto, __u32 sum)
 {
 	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
 }
 
-static inline u16 udp_csum(u32 saddr, u32 daddr, u32 len, u8 proto, u16 *udp_pkt)
+static u16 udp_csum(u32 saddr, u32 daddr, u32 len, u8 proto, u16 *udp_pkt)
 {
 	u32 csum = 0;
 	u32 cnt = 0;
@@ -500,7 +497,7 @@ static void kick_tx(struct xsk_socket_info *xsk)
 	exit_with_error(errno);
 }
 
-static inline void complete_tx_only(struct xsk_socket_info *xsk, int batch_size)
+static void complete_tx_only(struct xsk_socket_info *xsk, int batch_size)
 {
 	unsigned int rcvd;
 	u32 idx;
@@ -605,7 +602,7 @@ static void tx_only(struct xsk_socket_info *xsk, u32 *frameptr, int batch_size)
 	complete_tx_only(xsk, batch_size);
 }
 
-static inline int get_batch_size(int pkt_cnt)
+static int get_batch_size(int pkt_cnt)
 {
 	if (!opt_pkt_count)
 		return BATCH_SIZE;
-- 
2.20.1

