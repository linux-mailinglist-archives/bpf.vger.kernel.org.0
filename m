Return-Path: <bpf+bounces-70357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7975BB8673
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 01:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA65C3C5188
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88D277CB3;
	Fri,  3 Oct 2025 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syWKlWL0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB521271451;
	Fri,  3 Oct 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534256; cv=none; b=CKYQzYWT9esoJieuzeJJ7vTpeI5Td96BXXxHieCjr2lxHtjTDruh9HAStb7iriqcyDl5WS14+rto+6hdgdJMjjs8UT0S+712INFbDcdQ7MG1NO59fcbYZ4gS3myNnmaJFCHQO5QyPgA+BE57k7cMhJTWYIIHszaIltyfzSs9f0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534256; c=relaxed/simple;
	bh=vTZfystQm9nlofRbvHOgOSRGxhsCr0qhYinp9l6gF8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxlSj4NkYMUgcxsz2hfavsX6D4SQEYtGBaNhubfbg2Menx/uS2SZ6Ojro4tULQVRKtHTUPvjqzxgLCWd47VHo2Ig8KPfYOVb8XVaYN92RPavryhqVubYEan523WpBGowZ8kf+jThnWUwge0vQ7Pag2QN/5qPVj7/FmhCEIZ2gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syWKlWL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E797FC4CEF7;
	Fri,  3 Oct 2025 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534256;
	bh=vTZfystQm9nlofRbvHOgOSRGxhsCr0qhYinp9l6gF8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syWKlWL07DUx03O9mlkQevS9MNTb+ORvMkHxzmisXr6qd3bY+oBUc8PPyabevDN3i
	 nmO0xtmZQxEQ03OA6+4LZ83l6X4NgQgVvar3j8HM1IduWdSVWvOrQdgUpoVLtCJnpm
	 YI8TxKjjKxbGQ786cEQEhfK1i+kxLCTFQjqYnh4Athek8Oree4teiDVetmb17vsXBx
	 DUU792oawVmG0GYg6aJGFJsZwQ2RyY2TzaGgSk2I4FwE0wqgogo9pGlNGMXcsI65wc
	 lRmRAjofxLEEah68w99xsRQd5eUEHzF6ARt5KxogEcPTnJfTZL2uWf1z75hV1a8cN6
	 qDxt2pHMJo9eA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net 1/9] eth: fbnic: fix missing programming of the default descriptor
Date: Fri,  3 Oct 2025 16:30:17 -0700
Message-ID: <20251003233025.1157158-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003233025.1157158-1-kuba@kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP_TX typically uses no offloads. To optimize XDP we added a "default
descriptor" feature to the chip, which allows us to send XDP frames with
just the buffer descriptors (DMA address + length). All the metadata
descriptors are derived from the queue config.

Commit under Fixes missed adding setting the defaults up when transplanting
the code from the prototype driver. Importantly after reset the "request
completion" bit is not set. Packets still get sent but there's no
completion, so ring is not cleaned up. We can send one ring's worth
of packets and then will start dropping all frames that got the XDP_TX
action from the XDP prog.

Fixes: 168deb7b31b2 ("eth: fbnic: Add support for XDP_TX action")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: jacob.e.keller@intel.com
CC: mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 8f998d26b9a3..2a84bd1d7e26 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -83,8 +83,16 @@ static void fbnic_mac_init_axi(struct fbnic_dev *fbd)
 
 static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
 {
+	u64 default_meta = FIELD_PREP(FBNIC_TWD_L2_HLEN_MASK, ETH_HLEN) |
+			   FBNIC_TWD_FLAG_REQ_COMPLETION;
 	u32 clock_freq;
 
+	/* Configure default TWQ Metadata descriptor */
+	wr32(fbd, FBNIC_QM_TWQ_DEFAULT_META_L,
+	     lower_32_bits(default_meta));
+	wr32(fbd, FBNIC_QM_TWQ_DEFAULT_META_H,
+	     upper_32_bits(default_meta));
+
 	/* Configure TSO behavior */
 	wr32(fbd, FBNIC_QM_TQS_CTL0,
 	     FIELD_PREP(FBNIC_QM_TQS_CTL0_LSO_TS_MASK,
-- 
2.51.0


