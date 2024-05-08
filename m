Return-Path: <bpf+bounces-29111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22C8C0400
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD661C239F0
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736212BEAE;
	Wed,  8 May 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0/hFbOR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D055DDCB;
	Wed,  8 May 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191266; cv=none; b=W2A1o+HFjVJjcATWfhYnwNg8una00e+AM0ffZ721kr9PKfNmYrGIh8qhveF00NmKtmb06KknZGlh1OpBOsM+lX07u5dBeZ0R+g/pQf8AiBk6MZRu159eHWbMHhokygTMOWKAU8NzF3oa+O/IdTFrg8PcBhvMsUQy70tI8FrBljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191266; c=relaxed/simple;
	bh=w+6pd7vkk3meLmrEPohukRNGS4a3CtFdc4a02Ryf+wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEODYEyZPxNbf+uF7ZhrcZVHlQtLOHKhetFyteyI0fdPjjTx++1hD04+vXxSaNPUdnVux2TqtSMx0v8/16+pAoQCAa45145F4FLXpnkIOtAZDqi+6ZvycqAW14tO/lFuJ5MU4RUuQ3meD/CxgbTucWXOTjTrFLFgN5ydmcoVXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0/hFbOR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715191264; x=1746727264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w+6pd7vkk3meLmrEPohukRNGS4a3CtFdc4a02Ryf+wc=;
  b=k0/hFbORKeA7KBwafO9YP7Bw8Z93UEiYxr2BkBwhuPGNg8k4Ldo4hVnO
   f+PZHJeTSANLUAJsW2ShuXv/y2l6se5SFTCbfpYuKdahfuPMTi/nKHKkj
   eoKAcoRL7MlN9MN5TJfWPp+NJPKv7Cn/28LgMxX9/Q3t1lU7ydOXuAgvA
   FxvK4OBalhgc2jhsQX2zn1drOPu88MH37W7NVeJ+08MFAUUL6JsqsKqrg
   XQELfbDa6fhNPGhtOHQgaWMUSA48MqSfge6KnxgqrfL+L+XvvyXXj1+wh
   Q6mXLFYxziIBS1+nZLk+/k1hQYopY18AfbplgraMWa192Q5nOAt5nPT7T
   g==;
X-CSE-ConnectionGUID: puzgzq2JQ6ifIvrHFT3wHQ==
X-CSE-MsgGUID: 9uJeWrC6QwaaLT+fh40ttw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14888227"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14888227"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:01:03 -0700
X-CSE-ConnectionGUID: zwJdwyjYS+Krzyxu9isdag==
X-CSE-MsgGUID: pTaD+luwR5edavVGrYFFEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29050724"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 08 May 2024 11:01:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9AF1E109; Wed, 08 May 2024 21:00:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 1/1] net: intel: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 21:00:19 +0300
Message-ID: <20240508180057.1947637-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tags (Olek, Aleksandr), fixed misplaced line in one case (LKP)
 drivers/net/ethernet/intel/e1000/Makefile   | 2 +-
 drivers/net/ethernet/intel/e1000e/Makefile  | 7 +++----
 drivers/net/ethernet/intel/i40e/Makefile    | 2 +-
 drivers/net/ethernet/intel/iavf/Makefile    | 5 ++---
 drivers/net/ethernet/intel/igb/Makefile     | 6 +++---
 drivers/net/ethernet/intel/igbvf/Makefile   | 6 +-----
 drivers/net/ethernet/intel/igc/Makefile     | 6 +++---
 drivers/net/ethernet/intel/ixgbe/Makefile   | 8 ++++----
 drivers/net/ethernet/intel/ixgbevf/Makefile | 6 +-----
 drivers/net/ethernet/intel/libeth/Makefile  | 2 +-
 drivers/net/ethernet/intel/libie/Makefile   | 2 +-
 11 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/Makefile b/drivers/net/ethernet/intel/e1000/Makefile
index 314c52d44b7c..79491dec47e1 100644
--- a/drivers/net/ethernet/intel/e1000/Makefile
+++ b/drivers/net/ethernet/intel/e1000/Makefile
@@ -7,4 +7,4 @@
 
 obj-$(CONFIG_E1000) += e1000.o
 
-e1000-objs := e1000_main.o e1000_hw.o e1000_ethtool.o e1000_param.o
+e1000-y := e1000_main.o e1000_hw.o e1000_ethtool.o e1000_param.o
diff --git a/drivers/net/ethernet/intel/e1000e/Makefile b/drivers/net/ethernet/intel/e1000e/Makefile
index 0baa15503c38..18f22b6374d5 100644
--- a/drivers/net/ethernet/intel/e1000e/Makefile
+++ b/drivers/net/ethernet/intel/e1000e/Makefile
@@ -10,7 +10,6 @@ subdir-ccflags-y += -I$(src)
 
 obj-$(CONFIG_E1000E) += e1000e.o
 
-e1000e-objs := 82571.o ich8lan.o 80003es2lan.o \
-	       mac.o manage.o nvm.o phy.o \
-	       param.o ethtool.o netdev.o ptp.o
-
+e1000e-y := 82571.o ich8lan.o 80003es2lan.o \
+	    mac.o manage.o nvm.o phy.o \
+	    param.o ethtool.o netdev.o ptp.o
diff --git a/drivers/net/ethernet/intel/i40e/Makefile b/drivers/net/ethernet/intel/i40e/Makefile
index cad93f323bd5..9faa4339a76c 100644
--- a/drivers/net/ethernet/intel/i40e/Makefile
+++ b/drivers/net/ethernet/intel/i40e/Makefile
@@ -10,7 +10,7 @@ subdir-ccflags-y += -I$(src)
 
 obj-$(CONFIG_I40E) += i40e.o
 
-i40e-objs := i40e_main.o \
+i40e-y := i40e_main.o \
 	i40e_ethtool.o	\
 	i40e_adminq.o	\
 	i40e_common.o	\
diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index 2d154a4e2fd7..356ac9faa5bf 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -11,6 +11,5 @@ subdir-ccflags-y += -I$(src)
 
 obj-$(CONFIG_IAVF) += iavf.o
 
-iavf-objs := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
-	     iavf_adv_rss.o \
-	     iavf_txrx.o iavf_common.o iavf_adminq.o
+iavf-y := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
+	  iavf_adv_rss.o iavf_txrx.o iavf_common.o iavf_adminq.o
diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
index 394c1e0656b9..463c0d26b9d4 100644
--- a/drivers/net/ethernet/intel/igb/Makefile
+++ b/drivers/net/ethernet/intel/igb/Makefile
@@ -6,6 +6,6 @@
 
 obj-$(CONFIG_IGB) += igb.o
 
-igb-objs := igb_main.o igb_ethtool.o e1000_82575.o \
-	    e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
-	    e1000_i210.o igb_ptp.o igb_hwmon.o
+igb-y := igb_main.o igb_ethtool.o e1000_82575.o \
+	 e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
+	 e1000_i210.o igb_ptp.o igb_hwmon.o
diff --git a/drivers/net/ethernet/intel/igbvf/Makefile b/drivers/net/ethernet/intel/igbvf/Makefile
index afd3e36eae75..902711d5e691 100644
--- a/drivers/net/ethernet/intel/igbvf/Makefile
+++ b/drivers/net/ethernet/intel/igbvf/Makefile
@@ -6,8 +6,4 @@
 
 obj-$(CONFIG_IGBVF) += igbvf.o
 
-igbvf-objs := vf.o \
-              mbx.o \
-              ethtool.o \
-              netdev.o
-
+igbvf-y := vf.o mbx.o ethtool.o netdev.o
diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
index ebffd3054285..efc5e7983dad 100644
--- a/drivers/net/ethernet/intel/igc/Makefile
+++ b/drivers/net/ethernet/intel/igc/Makefile
@@ -6,7 +6,7 @@
 #
 
 obj-$(CONFIG_IGC) += igc.o
-igc-$(CONFIG_IGC_LEDS) += igc_leds.o
 
-igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
-igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
+igc-y := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
+	 igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
+igc-$(CONFIG_IGC_LEDS) += igc_leds.o
diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index 4fb0d9e3f2da..965e5ce1b326 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -6,10 +6,10 @@
 
 obj-$(CONFIG_IXGBE) += ixgbe.o
 
-ixgbe-objs := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
-              ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
-              ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
-              ixgbe_xsk.o
+ixgbe-y := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
+           ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
+           ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
+           ixgbe_xsk.o
 
 ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
                               ixgbe_dcb_82599.o ixgbe_dcb_nl.o
diff --git a/drivers/net/ethernet/intel/ixgbevf/Makefile b/drivers/net/ethernet/intel/ixgbevf/Makefile
index 186a4bb24fde..01d3e892f3fa 100644
--- a/drivers/net/ethernet/intel/ixgbevf/Makefile
+++ b/drivers/net/ethernet/intel/ixgbevf/Makefile
@@ -6,9 +6,5 @@
 
 obj-$(CONFIG_IXGBEVF) += ixgbevf.o
 
-ixgbevf-objs := vf.o \
-                mbx.o \
-                ethtool.o \
-                ixgbevf_main.o
+ixgbevf-y := vf.o mbx.o ethtool.o ixgbevf_main.o
 ixgbevf-$(CONFIG_IXGBEVF_IPSEC) += ipsec.o
-
diff --git a/drivers/net/ethernet/intel/libeth/Makefile b/drivers/net/ethernet/intel/libeth/Makefile
index cb99203d1dd2..52492b081132 100644
--- a/drivers/net/ethernet/intel/libeth/Makefile
+++ b/drivers/net/ethernet/intel/libeth/Makefile
@@ -3,4 +3,4 @@
 
 obj-$(CONFIG_LIBETH)		+= libeth.o
 
-libeth-objs			+= rx.o
+libeth-y			:= rx.o
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index bf42c5aeeedd..ffd27fab916a 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -3,4 +3,4 @@
 
 obj-$(CONFIG_LIBIE)	+= libie.o
 
-libie-objs		+= rx.o
+libie-y			:= rx.o
-- 
2.43.0.rc1.1336.g36b5255a03ac


