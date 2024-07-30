Return-Path: <bpf+bounces-35966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99BA94037B
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1AC1C2132D
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB6C2C6;
	Tue, 30 Jul 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSXhHoh2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6A10A0D;
	Tue, 30 Jul 2024 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302606; cv=none; b=a+BtnyLcEoEwG9kcYuZGkNJz5mmQ2ehnbdhX+3QvB5OeacnXdONRtqOBJsXHFPI1f1gsxU9jqepK4VUYejHsy4i0yE4SEgFMXFB3s9Oi9TAOkDhfw79aT2z4FWcHKioCToaRMnL77pGiHw9KaUvTf4iQ4NzB+rf0Kw52dHW823k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302606; c=relaxed/simple;
	bh=ddB0kFBn3W+5wYXdYlUfRy4LUhqB6abeQG+R6RSOGtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzDuBzzCiMZ1rRRvh2dtRydzgr5TiXom4ivmxd6sADh1PxlilaJsFpwDUjXDSsoToA5OoM95QNMLM3yz3uIO7VwFtWbPlt7iV4pZBZ9/ChaiBWxjD8C1XaoQ/zLHhMHGJ+42D/TPeaLDgeuGGb7s1uPG2mT18eWKMxVccGGZmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSXhHoh2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722302604; x=1753838604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ddB0kFBn3W+5wYXdYlUfRy4LUhqB6abeQG+R6RSOGtg=;
  b=lSXhHoh2AEiMqrpokdLLxKynEqo6Q6nadBSMQo8mRm+NUM755PbHcK1P
   9n13EnE8XSypqdTZXfTi4HoZvkDPnrkwZcORS2RKql1z59vWZs8Tb1bHB
   xVecORaTDE9kzCG1XJ/FMS/YRhahMKLdx54lNLQsG3sRBEG2awHJV3wiK
   LYHkmEKnmmtTUkB15uB1yUYI44X01I+qMxh/NyG9gT3YOCvSHd2q+hOt6
   KUKHKWFKyTui5VAh7MxgqP6oJz6lVrf7+yjNqojAr8le369cJ2DVzbdxe
   7GOy8bFs9Re4sULlSicYYFNhVmZ+4367i1dGXjePeO7e7dGch0SOwKrAn
   w==;
X-CSE-ConnectionGUID: +3M9gp3ESeCu0X7YMsV6gA==
X-CSE-MsgGUID: uqHpWtJfQxWVszqKyq6mIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20242217"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20242217"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:23:24 -0700
X-CSE-ConnectionGUID: 0uIlYRFsSrK/857cNPi7PQ==
X-CSE-MsgGUID: PJ4+QiIAR5yiZnKSn997OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54079262"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa010.jf.intel.com with ESMTP; 29 Jul 2024 18:23:18 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH iwl-next,v1 1/3] igc: Add documentation
Date: Tue, 30 Jul 2024 09:22:47 +0800
Message-Id: <20240730012247.775856-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>

This commit adds the documentation file for the Intel Ethernet Network
Controller I225 and I226 driver. The documentation includes:
 - Identifying Your Adapter
 - Command Line Parameters
 - Additional Configurations
 - Support
 - Trademarks

The file provides detailed information on how to identify the adapter, use
command line parameters, configure additional features, and obtain support.

Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 .../device_drivers/ethernet/index.rst         |  1 +
 .../device_drivers/ethernet/intel/igc.rst     | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/igc.rst

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 6932d8c043c2..2b1dbb984f98 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -35,6 +35,7 @@ Contents:
    intel/idpf
    intel/igb
    intel/igbvf
+   intel/igc
    intel/ixgbe
    intel/ixgbevf
    intel/i40e
diff --git a/Documentation/networking/device_drivers/ethernet/intel/igc.rst b/Documentation/networking/device_drivers/ethernet/intel/igc.rst
new file mode 100644
index 000000000000..08b2cfacc7c0
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/intel/igc.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+========================================================================
+Linux Base Driver for Intel(R) Ethernet Network Controller I225 and I226
+========================================================================
+
+Intel igc Linux driver.
+Copyright(c) 1999-2024 Intel Corporation.
+
+
+Contents
+========
+- Identifying Your Adapter
+- Command Line Parameters
+- Additional Configurations
+- Support
+- Trademarks
+
+
+Identifying Your Adapter
+========================
+For information on how to identify your adapter, and for the latest Intel
+network drivers, refer to the Intel Support website:
+https://www.intel.com/support
+
+
+Command Line Parameters
+========================
+If the driver is built as a module, the following optional parameters are used
+by entering them on the command line with the modprobe command using this
+syntax::
+
+    modprobe igc [<option>=<VAL1>]
+
+NOTE: A descriptor describes a data buffer and attributes related to the data
+buffer. This information is accessed by the hardware.
+
+Debug
+-----
+:Valid Range: 0-16 (0=none,...,16=all)
+:Default Value: 0
+
+This parameter adjusts the level debug messages displayed in the system logs.
+
+
+Additional Features and Configurations
+======================================
+Time-Sensitive Networking
+-------------------------
+Selected models of Intel(R) Ethernet Controller I225 and Intel(R) Ethernet
+Controller I226 support Time-Sensitive Networking features. For more details
+about the features and supported models, please refer to:
+https://www.intel.com/content/www/us/en/support/articles/000096004/ethernet-products/gigabit-ethernet-controllers-up-to-2-5gbe.html
+
+For instructions about configuring Time-Sensitive Networking features on Linux,
+please refer to:
+https://tsn.readthedocs.io/
+
+ethtool
+-------
+The driver utilizes the ethtool interface for driver configuration and
+diagnostics, as well as displaying statistical information. The latest ethtool
+version is required for this functionality. Download it at:
+https://www.kernel.org/pub/software/network/ethtool/
+
+
+Support
+=======
+For general information, go to the Intel support website at:
+https://www.intel.com/support/
+
+If an issue is identified with the released source code on a supported kernel
+with a supported adapter, email the specific information related to the issue
+to intel-wired-lan@lists.osuosl.org
+
+
+Trademarks
+==========
+Intel is a trademark or registered trademark of Intel Corporation or its
+subsidiaries in the United States and/or other countries.
+
+* Other names and brands may be claimed as the property of others.
-- 
2.34.1


