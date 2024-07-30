Return-Path: <bpf+bounces-35968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A33940388
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 03:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952271F21F6D
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519E11187;
	Tue, 30 Jul 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+lS1/99"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07DBFC08;
	Tue, 30 Jul 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302653; cv=none; b=nbj81oA76YftAsDaOZyF0pkaT+FzAw9PSJ2Lk0C+Z6TAQhX41res0g4XxYewtfz9/qlrdZZBK9/lRc2ZwSxocZhH5I0YZrVrz/vLio5dfglSJGE6iZXUvhwTDGxq/SPmED/AiXmNVnbPv2u0HjSyVj+kyCcDZKKRNQl2pfbAH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302653; c=relaxed/simple;
	bh=YhJyeBx1tD5AH76gIDYJrjbuR9IYaY+3oVHeXbhIfYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B59SlV3tc9SiPYy4T4g2O8Cj/zjt8NvaeXKA15QbM21nRjs0Aras4FLVic8RFQdVX9/O3RBdBiwude5HlEhTtX9hLd3omllkZpYz5F62eQwKL8wGrAt5OhQf77vk3275vKi88pwYTRYEU+W+1E5GOx0rC+IUypbt3Kzf7IsIHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+lS1/99; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722302652; x=1753838652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YhJyeBx1tD5AH76gIDYJrjbuR9IYaY+3oVHeXbhIfYA=;
  b=H+lS1/99PihQlSzjQ5zoEjH33vMab0+3rpqk9+uDM9JIggXb/97ie5SH
   a03ASclU9QzG6GEL7IVbD+62d+TXYi4a+eREHJ9+tjYI34zSSGVZJ7APY
   GeUSUSEGheRSbGIGrow5Tmu+b7IouB/JbjcFXm+PpN4V67od1RKdBDBYN
   8kkknHI5QuXyydrw9WODGGykNxqswFDsKjbpS3wBrBNTpWSGt/4o/QTqi
   Bs8t3gzvUu/JOWxJqmfrCsNQ1ddduIYT/unT6o5R1nK+/YvFDoLvZKS3i
   1Qty9xD+yzgVwIbKqd/z/Y6Qasz51pBtyY+ZpiT5RtdZpufi24Sv+8YNP
   Q==;
X-CSE-ConnectionGUID: nr8Sz2ikTvWLKMfqG8fyVg==
X-CSE-MsgGUID: B+S3TruzQhWrc2nrgUbmKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37570471"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="37570471"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:24:11 -0700
X-CSE-ConnectionGUID: /FPKSomRSZms2Q7Lz1hWig==
X-CSE-MsgGUID: VapJBZ7LTF2X5PXthe6Lhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="58947896"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2024 18:24:05 -0700
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
Subject: [PATCH iwl-next,v1 3/3] igc: Add default Rx Queue into documentation
Date: Tue, 30 Jul 2024 09:23:36 +0800
Message-Id: <20240730012336.775912-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>

Add description on default Rx Queue, including the get and set
method, into documentation.

Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 .../device_drivers/ethernet/intel/igc.rst     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/igc.rst b/Documentation/networking/device_drivers/ethernet/intel/igc.rst
index 08b2cfacc7c0..bef396d9ec53 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/igc.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/igc.rst
@@ -63,6 +63,27 @@ diagnostics, as well as displaying statistical information. The latest ethtool
 version is required for this functionality. Download it at:
 https://www.kernel.org/pub/software/network/ethtool/
 
+Default Rx queue selection
+--------------------------
+In Multiple Receive Queues modes, ingress traffic may be redirected to specific
+Rx queue based on different programmable filters.
+
+When none of the filters is matched, the incoming frame will be redirected to
+the "Default Rx queue", which is Rx Queue 0 by default.
+
+For configurations where Queue 0 pair is used for high priority traffic (like
+AF_XDP), this may not be desirable. To address this, the driver provides the
+option to modify the default Rx queue via sysfs.
+
+A sysfs attribute "default_rx_queue" is available under /sys/devices. E.g.:
+/sys/devices/pci0000:00/.../default_rx_queue
+
+To check the currently configured default Rx queue:
+cat /sys/devices/pci0000:00/.../default_rx_queue
+
+To set the default queue to a desired value, for example 3:
+echo 3 > /sys/devices/pci0000:00/.../default_rx_queue
+
 
 Support
 =======
-- 
2.34.1


