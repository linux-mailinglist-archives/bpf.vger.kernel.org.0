Return-Path: <bpf+bounces-31869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9D9043D8
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8E01C24D3F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B496745CB;
	Tue, 11 Jun 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lsp5Gm4n"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA04F211;
	Tue, 11 Jun 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131369; cv=none; b=WpaZOah5RyWotUSUeULWYlLBr0N57IuzK5swcsng7SBntZkFEQIPJvSjqvoppBMYTna67GvwxaT13pEXeE2z8wHL/1QsSKXyhwilhpj4h8k1obxxyIcKCwXBryxcai5JpQ79K6YGX+uBtpvF4/G+s7vIJ5Z1k/b0VRZQIMvREoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131369; c=relaxed/simple;
	bh=pgqcbifk+QMBXJDtWm7l+jmLQx98LRG/nmZSVdeoBW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRyof1rqtRMhMf9s6tIHIcjsjxPYixI55i3WdfSYCEaI8hBckxw7exsJ3VGfaguQm8FXc9rwHONML5lXJRJzOh9RaKcuiE7P2FdXBpDinpMKTDntQpNOqoL1G2Mi4vEBnXsb7MFKPg69VBE83BByGLAu6KG5oJA+lgs6wyzrhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lsp5Gm4n; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718131368; x=1749667368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgqcbifk+QMBXJDtWm7l+jmLQx98LRG/nmZSVdeoBW8=;
  b=Lsp5Gm4nyhdKK1bQWRK9jFQ6sliq81cGhtme0WGJk0wjhgmRQ3LEIiut
   8kFJdjaJ7PzNKFF3b5r6ds8xUAG+LW2KtGmWF0wZtqdBZlOMFXc+7EBb7
   LsHudotx+8V4KKm9xTip64/K7KdjDQr/xT+sBdygPRDVbV/fYfvS6hGKk
   uoCdskUxVsMTLRRKoejnCR/CRtuh2/E3vdvvCkKgtHyuPPHbjWG+mfuPT
   AgOBzd5XhwNlpf9dDNdcebfxsGAdJjRhokvcRF9v8/OYq3XuK+tymt/2z
   NDHBZu62xmRWdEv/100FV9BKv7rZ4QOZ4cJHpZF8sx/37Ar/OBPPoYWTP
   w==;
X-CSE-ConnectionGUID: NMiW9dsvQTqE9e0AvnUd9w==
X-CSE-MsgGUID: 4IUxMXSZSRGqTWA1uu/vBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12025537"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="12025537"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:42:47 -0700
X-CSE-ConnectionGUID: pBSlb3dVRQeGRTA74QAGFg==
X-CSE-MsgGUID: cUbu5gyETn6obSrH02vMkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39592489"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2024 11:42:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/4] i40e: Fix XDP program unloading while removing the driver
Date: Tue, 11 Jun 2024 11:42:35 -0700
Message-ID: <20240611184239.1518418-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
References: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

The commit 6533e558c650 ("i40e: Fix reset path while removing
the driver") introduced a new PF state "__I40E_IN_REMOVE" to block
modifying the XDP program while the driver is being removed.
Unfortunately, such a change is useful only if the ".ndo_bpf()"
callback was called out of the rmmod context because unloading the
existing XDP program is also a part of driver removing procedure.
In other words, from the rmmod context the driver is expected to
unload the XDP program without reporting any errors. Otherwise,
the kernel warning with callstack is printed out to dmesg.

Example failing scenario:
 1. Load the i40e driver.
 2. Load the XDP program.
 3. Unload the i40e driver (using "rmmod" command).

Fix this by improving checks in ".ndo_bpf()" to determine if that
callback was called from the removing context and if the kernel
wants to unload the XDP program. Allow for unloading the XDP program
in such a case.

Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 284c3fad5a6e..2f478edb9f9f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13293,6 +13293,20 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 	bool need_reset;
 	int i;
 
+	/* Called from netdev unregister context. Unload the XDP program. */
+	if (vsi->netdev->reg_state == NETREG_UNREGISTERING) {
+		xdp_features_clear_redirect_target(vsi->netdev);
+		old_prog = xchg(&vsi->xdp_prog, NULL);
+		if (old_prog)
+			bpf_prog_put(old_prog);
+
+		return 0;
+	}
+
+	/* VSI shall be deleted in a moment, just return EINVAL */
+	if (test_bit(__I40E_IN_REMOVE, pf->state))
+		return -EINVAL;
+
 	/* Don't allow frames that span over multiple buffers */
 	if (vsi->netdev->mtu > frame_size - I40E_PACKET_HDR_PAD) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for linear frames and XDP prog does not support frags");
@@ -13301,14 +13315,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 
 	/* When turning XDP on->off/off->on we reset and rebuild the rings. */
 	need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog);
-
 	if (need_reset)
 		i40e_prep_for_reset(pf);
 
-	/* VSI shall be deleted in a moment, just return EINVAL */
-	if (test_bit(__I40E_IN_REMOVE, pf->state))
-		return -EINVAL;
-
 	old_prog = xchg(&vsi->xdp_prog, prog);
 
 	if (need_reset) {
-- 
2.41.0


