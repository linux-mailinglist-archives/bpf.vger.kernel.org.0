Return-Path: <bpf+bounces-53309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA9A4FF70
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610C67A3A7E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ACC24EAB9;
	Wed,  5 Mar 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMlSoufq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F7248883;
	Wed,  5 Mar 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179684; cv=none; b=Dsy4yp/Vh8v6TGYuG+RDayXw37b4yPAoUnddzjIzpw0f21CKHSHgWyOlVjvmZ7Cds+jM9KZY7ltjpPNIUSq8rZODFUp4Hf9X12fVyzcGDpXmzfLR8z69B7KppOqOkQxNZIcX7iJ2LFX5SJCAYhbVFOI3mOj+sGmSVBZYiM0nyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179684; c=relaxed/simple;
	bh=Y//C+KyY9JDiVXwSEk627cRg7D/ALr5oNlQGwg/5vVQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rt1z3Z6fjzUISDruRh5fur/RTx2eR4/4EfWC3HTIHvABSUeGM3N0kkUewmASs83l7Egg5c7/RQKE8qULzfaLtM8J0wtR0Y2bV2gqriAKvng/Vb8o70Hg872us+exz1ODIlnsWbcgJLNWN0d1i0hFlDkRciM0ZuOAOrd4/WLg61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMlSoufq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741179684; x=1772715684;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Y//C+KyY9JDiVXwSEk627cRg7D/ALr5oNlQGwg/5vVQ=;
  b=mMlSoufqJwien0MgFABi0tFra/oc7ajKnIZh0NXzhrZj1fdiDQmtiKeI
   D5Jp0oZLHwIIIigeNyPRXS61k/tP6MszGd+TksQjDrzAKbuqaJ0iSOs7j
   PQwtiKgn7MLkxyjn3t0mbYf7JkaeXTBK131OBc4RYdYzn+fzqxN3Z75NF
   NEKQuffz9RsNXQD4vYKKjbzTZ/IB9iBe+ObunfebgOYI2wDVYr7irSkRA
   3JSNKiqbYW6cB90TxDl4DI+qYXwF1uOivw2u1SM4H6CQAsHGfob1xco1I
   tOfTHwJ3+xuPiA32IeqYjIuSn/xhnGuctCpfGU3y4iV8S1j4JvriB52Nh
   Q==;
X-CSE-ConnectionGUID: 79dLLd93TzWcFRejszyMOQ==
X-CSE-MsgGUID: MH52ft6ISn+aqySE2E0Wtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45794963"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="45794963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:01:23 -0800
X-CSE-ConnectionGUID: 9mXuV+xOTeqFLxVCFnBCTA==
X-CSE-MsgGUID: yj4NzQiUSh+rtly7s9bQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123277001"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa005.fm.intel.com with ESMTP; 05 Mar 2025 05:01:16 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v8 03/11] net: ethtool: mm: reset verification status when link is down
Date: Wed,  5 Mar 2025 08:00:18 -0500
Message-Id: <20250305130026.642219-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the link partner goes down, "ethtool --show-mm" still displays
"Verification status: SUCCEEDED," reflecting a previous state that is
no longer valid.

Reset the verification status to ensure it reflects the current state.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/ethtool/mm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index aa43df2ecac0..ad9b40034003 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -415,8 +415,9 @@ void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
 		/* New link => maybe new partner => new verification process */
 		ethtool_mmsv_apply(mmsv);
 	} else {
-		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
-		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
+		/* Reset the reported verification state while the link is down */
+		if (mmsv->verify_enabled)
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
 
 		/* No link or pMAC not enabled */
 		ethtool_mmsv_configure_pmac(mmsv, false);
-- 
2.34.1


