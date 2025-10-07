Return-Path: <bpf+bounces-70552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A5BC2EF4
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 01:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B8C19A2777
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABF25D209;
	Tue,  7 Oct 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNFg8aRF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236372475CE;
	Tue,  7 Oct 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879627; cv=none; b=eJ5s+6OXEmfGXt3EwMla82s8OQC7Va4Zaqvi3htNj9z0s6D2JlwcEvBeJlEB0malX3ch74Mk4zcB4NosodhG4pCkQKOS8x3pOjCnOj/1J4S0D5ekWJynUHzLsKC/puuaG+EMUvkBDXXnjqEJCYscivkSlX8NVAUv+d2j5Pn+i/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879627; c=relaxed/simple;
	bh=eOYagBJBu947tdZvPRnny66snevmIr01/5hSWXE9pd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+rG5EsNdj0hWk1rcCYuCt8RdHsJOekaCRUuuIYnU1WqGnfHjGrPmhk5Ch6Dhhnrek/Gi7hpxf3rA11M92USQqK4yWYM3O9ujtt0a/LvJsv7ssqv3HAoEqFPPd6L1HkzAe+ifAeM2MO/CthvRMCe9SZwkTjQCCcpHHRvImK3HGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNFg8aRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0BCC116B1;
	Tue,  7 Oct 2025 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879626;
	bh=eOYagBJBu947tdZvPRnny66snevmIr01/5hSWXE9pd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNFg8aRF07qN5RVTdkguQG/9MFPY4dz1U8fHUBaleaHpFHgoUSLmM4BpfsxEANEL7
	 VMQwji7a3BhSAPFLPGPtIqVfRTz698AaL7onBEndMIkMy8r+F6zHajzZyj1XfzCFY0
	 uQum+TM/Bey6tYJgR8FYRQ3TWcYgNRCsyhYkhTO/o2wSKMWnew1R09D2EdYDRGsnNi
	 yG/w4vqN+93G3X5cjWaJm6rKUjzTKu9zvQBEgJ2xe0QJiq7+fCuu3/8Pjh/jWfq2mk
	 vpFB6la4nUfg4JXZIOOLedJe6m3jUQrEcnik6M8xiBIxqNzlYlsbDxiXOJp8b9ONen
	 GYASjFo6G5kDw==
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
Subject: [PATCH net v2 1/9] eth: fbnic: fix missing programming of the default descriptor
Date: Tue,  7 Oct 2025 16:26:45 -0700
Message-ID: <20251007232653.2099376-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
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

Reviewed-by: Simon Horman <horms@kernel.org>
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


