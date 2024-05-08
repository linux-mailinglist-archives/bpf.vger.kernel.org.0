Return-Path: <bpf+bounces-29071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8358BFEA6
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075661F26B98
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F7979B9D;
	Wed,  8 May 2024 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DY0RyZJn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2F54FA3;
	Wed,  8 May 2024 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174609; cv=none; b=Aa1UZuwSPAryDKbdt/6MbaIsJ7bjZENv6we4LzxkDtd02sxgN1pe81+TVTKNDNAok4lbpC/RErZX+zPFT9WYsuLDuqGZInwRA+qbw6mViapRHI1LNYBvve7cgjyDAV40y8CYXupToZVZwEPHxtATHPdiXT5ltsZvhQ8xmXes2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174609; c=relaxed/simple;
	bh=UZTuM19sfO6IyeO00FqUVca6+KRZ5NfpcA4zNw9xJg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hj+ZT/5RxmWI11mS6cYv4k7DQTQ3xQNDc4k4uHSySA5EhYTV1Qfzok/i5WRfGkiPyjdHXXHIvK1q4V0ZZyIJvPKjogpwbVeIJXf4KmbCaltmY7T+8sF4a9jFJ+gVqobbiD0snkwI3XbldZgPJmCHVdpTKVbQuvLpUFOmBaPp/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DY0RyZJn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715174607; x=1746710607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UZTuM19sfO6IyeO00FqUVca6+KRZ5NfpcA4zNw9xJg4=;
  b=DY0RyZJnXz/lLirAH6aw7Afo2Z7z6B4H1D5WoeXfwCsLNl9Jxx+d2nhx
   q9eLpQes5M+kxT+jA+7cTTK2N+WpcUbIoGgnHkj6wqUAFZSaQiSajG2Mi
   cPuh/Q2AqUBA10P9irov9s02kPujaDNF8F1ihFsey+w93HI6rXAXCPoSh
   K8j3EtrUfCMcoDaC543XmSowYkcFB17Avb/1KOXvtKr+YrMV2Mnnr7KyW
   0QEbVScfXzz0tnekPVx/ZEa4xAAUZcAvR+ry6P6O6uq6cyfttvZe/SIP7
   9KiF+nvyeVhAEP5+WsFwDi81hBWAOCzqZVAnDk9hGAFUbZSEVvUUYnHdu
   A==;
X-CSE-ConnectionGUID: c/wFF05ER26kZLNTpi5g1A==
X-CSE-MsgGUID: eBH0pV/wSvq7lEhY/AdFUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36414233"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36414233"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:23:27 -0700
X-CSE-ConnectionGUID: nl17En8nSgWa4E/1HF/puA==
X-CSE-MsgGUID: OrWG+csSRCip2uAzwaFf3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33358923"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2024 06:23:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5917011F; Wed, 08 May 2024 16:23:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
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
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net-next v1 1/1] net: intel: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 16:23:15 +0300
Message-ID: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000/Makefile   | 2 +-
 drivers/net/ethernet/intel/e1000e/Makefile  | 7 +++----
 drivers/net/ethernet/intel/i40e/Makefile    | 2 +-
 drivers/net/ethernet/intel/iavf/Makefile    | 5 ++---
 drivers/net/ethernet/intel/igb/Makefile     | 6 +++---
 drivers/net/ethernet/intel/igbvf/Makefile   | 6 +-----
 drivers/net/ethernet/intel/igc/Makefile     | 4 ++--
 drivers/net/ethernet/intel/ixgbe/Makefile   | 8 ++++----
 drivers/net/ethernet/intel/ixgbevf/Makefile | 6 +-----
 drivers/net/ethernet/intel/libeth/Makefile  | 2 +-
 drivers/net/ethernet/intel/libie/Makefile   | 2 +-
 11 files changed, 20 insertions(+), 30 deletions(-)

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
index ebffd3054285..a64c734740f6 100644
--- a/drivers/net/ethernet/intel/igc/Makefile
+++ b/drivers/net/ethernet/intel/igc/Makefile
@@ -8,5 +8,5 @@
 obj-$(CONFIG_IGC) += igc.o
 igc-$(CONFIG_IGC_LEDS) += igc_leds.o
 
-igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
-igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
+igc-y := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
+	 igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
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


