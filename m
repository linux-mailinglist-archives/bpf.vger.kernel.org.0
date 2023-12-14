Return-Path: <bpf+bounces-17822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA481310A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86821F22227
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19A54BC2;
	Thu, 14 Dec 2023 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arGNP5d3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246798;
	Thu, 14 Dec 2023 05:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702559562; x=1734095562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Hu9fY5kkvAJf6hXJQmsIaGB2tOLeUF7E5kv3+ktTUQ=;
  b=arGNP5d3wUg9XEDlrvJOw4aVNXPDQS02VmdwkycqTw8gJG9bWi88IDnM
   DmI6XuvVwkD4KcMiPll75+inIAJalhqhbpuVliMd0rFV+qh+5hOaw0k0/
   WOoJGuTPoLQBtoiot+LYH4/yNdU2N1EljXaQSA/zIAWNGsDhDVV0actvT
   2hTGarjbXz9RjBbGU+lzP7Z4yaYyMXSznre5KZeg4p/OKHhrOUEfjk1/4
   cajqU+Om03grIr3cO99BbpVlB5zCO4aFajm7nG0bpNJTSSXc4lM0U5yCA
   zYvFTsdPGRwgL4bRrQj9AYc91qzXZlEC5V5LSNudR5xmfPmWqw9BOPemh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392290950"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="392290950"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105711639"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1105711639"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:12:38 -0800
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v2] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED test
Date: Thu, 14 Dec 2023 13:00:07 +0000
Message-Id: <20231214130007.33281-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix test broken by shared umem test and framework enhancement commit.

Correct the current implementation of pkt_stream_replace_half() by
ensuring that nb_valid_entries are not set to half, as this is not true
for all the tests. Ensure that the expected value for valid_entries for
the SEND_RECEIVE_UNALIGNED test equals the total number of packets sent,
which is 4096.

Create a new function called pkt_stream_pkt_set() that allows for packet
modification to meet specific requirements while ensuring the accurate
maintenance of the valid packet count to prevent inconsistencies in packet
tracking.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem feature")
Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

---
v1->v2
- Updated git commit message for better clarity as suggested in the
  review. [Maciej]
- Renamed pkt_valid() to set_pkt_valid() for better clarity. [Maciej]
- Fixed double space issue. [Maciej]
- Included Magnus's acknowledgement.
- Remove the redundant part from the set_pkt_valid() if condition.
  [Maciej]
- remove pkt_modify().
- added pkt_stream_pkt_set(). [Magnus]
- renamed mod_valid to prev_pkt_valid. [Tirtha]
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 +++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index b604c570309a..b1102ee13faa 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -634,16 +634,24 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	return nb_frags;
 }
 
+static bool set_pkt_valid(int offset, u32 len)
+{
+	return len <= MAX_ETH_JUMBO_SIZE;
+}
+
 static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int offset, u32 len)
 {
 	pkt->offset = offset;
 	pkt->len = len;
-	if (len > MAX_ETH_JUMBO_SIZE) {
-		pkt->valid = false;
-	} else {
-		pkt->valid = true;
-		pkt_stream->nb_valid_entries++;
-	}
+	pkt->valid = set_pkt_valid(offset, len);
+}
+
+static void pkt_stream_pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int offset, u32 len)
+{
+	bool prev_pkt_valid = pkt->valid;
+
+	pkt_set(pkt_stream, pkt, offset, len);
+	pkt_stream->nb_valid_entries += pkt->valid - prev_pkt_valid;
 }
 
 static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
@@ -665,7 +673,7 @@ static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
 	for (i = 0; i < nb_pkts; i++) {
 		struct pkt *pkt = &pkt_stream->pkts[i];
 
-		pkt_set(pkt_stream, pkt, 0, pkt_len);
+		pkt_stream_pkt_set(pkt_stream, pkt, 0, pkt_len);
 		pkt->pkt_nb = nb_start + i * nb_off;
 	}
 
@@ -700,10 +708,9 @@ static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
 
 	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream);
 	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
-		pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
+		pkt_stream_pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
 
 	ifobj->xsk->pkt_stream = pkt_stream;
-	pkt_stream->nb_valid_entries /= 2;
 }
 
 static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
-- 
2.34.1


