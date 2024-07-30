Return-Path: <bpf+bounces-35965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCB8940373
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 03:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C92B214B5
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F98F6A;
	Tue, 30 Jul 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuJm+X4U"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72D8821;
	Tue, 30 Jul 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302587; cv=none; b=mcEAyL0DgfF6NTe8IQt/X3JrKlUpp76M6JX5OR2I8zMTmD8SsaUZjKxQy5lotxK08LWeq5y3tNg37On6DDQOzGOQJ2UbPPjjfuNlLQYPo2Hdwx/0vEx2ux8u+xBfuseZdveMF7BYLI+4fyq2VBDxYqJc8lRrJkAoz47OaS/Bzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302587; c=relaxed/simple;
	bh=mb631k4kfETjEK1XHoh+eCWwPDdm+0gqMj8RFvnugw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JSOTnoLpUnoG1C5P4hLfPxxLvDT9Bur5fLcooEh27eDqUUvKTU06PLyVn4x1cxiVMbaCyfXlkNL36QIxXKAjSs6n3mWHny+7fYbx1eDo5I1qgdHGh7yWX9zkiLClCp0d23KpimG3l/FBjGnQOpp4HEy5F5+B7qxobfwoI3Y81oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuJm+X4U; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722302584; x=1753838584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mb631k4kfETjEK1XHoh+eCWwPDdm+0gqMj8RFvnugw4=;
  b=iuJm+X4UryW6hBG2Zw9J+o5NOprPDmFfnLnTsidSrq96NcxdfF6vG3Fo
   9hUnW/5SI3tbEiIeIofiHFvkPVWeKCHuYb3oNdvgY7Mw4Tgnali+xW3tD
   uuyVK3LycyoUTv1e0xWSU6F+2MXZC+4vZD2PCSWVoJ5YVB3mqzh1UUQEi
   SqW9w33veucOGDYO4x236TgENaD5ULz2Wxy7raDgYB0VTNwiP27fLT2hb
   6MChGawgvOPfkhm2JTFiPVoXi0b44Pz7akTxyoUz1Wz5/RQLcOo4WgGZ1
   q1/vrdE+Sah9vNAzKmA5vn5aKL+X7NkRwuixAUWJF3huGk4dfz3uwzTdq
   w==;
X-CSE-ConnectionGUID: 0eqk+x7LSnqn9sc1d27D6Q==
X-CSE-MsgGUID: P5DfSweRQpSFKt6SiESjvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20242191"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20242191"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:23:03 -0700
X-CSE-ConnectionGUID: rHulb508S/qhLPcwNOHwVA==
X-CSE-MsgGUID: SjJyrrYHSca9cyPX/legFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54079212"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa010.jf.intel.com with ESMTP; 29 Jul 2024 18:22:58 -0700
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
Subject: [PATCH iwl-next,v1 0/3] Add Default Rx Queue Setting for igc driver
Date: Tue, 30 Jul 2024 09:22:12 +0800
Message-Id: <20240730012212.775814-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set introduces the support to configure default Rx queue during runtime.
A new sysfs attribute "default_rx_queue" has been added, allowing users to check
and modify the default Rx queue.

This patch set is tested on two back-to-back connected i226 on Intel ADL-S systems.

Test Steps and expected results:
1. Check default_rx_queue index:
   @DUT: $ cat /sys/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/default_rx_queue
         0

2. Check statistic of Rx packets:
   @DUT: $ ethtool -S enp2s0 | grep rx.*packets
         rx_packets: 0
         rx_queue_0_packets: 0
         rx_queue_1_packets: 0
         rx_queue_2_packets: 0
         rx_queue_3_packets: 0

3. Send 10 ARP packets:
   @LinkPartner: $ arping -c 10 -I enp170s0 169.254.1.10
                 ARPING 169.254.1.10 from 169.254.1.2 enp170s0
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.725ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.649ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.577ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.611ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.706ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.644ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.648ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.601ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.628ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.641ms
                 Sent 10 probes (1 broadcast(s))
                 Received 10 response(s)

4. Check statistic of Rx packets to make sure packets is received by default queue (RxQ0):
   @DUT: $ ethtool -S enp2s0 | grep rx.*packets
         rx_packets: 10
         rx_queue_0_packets: 10
         rx_queue_1_packets: 0
         rx_queue_2_packets: 0
         rx_queue_3_packets: 0

5. Change default_rx_queue index to Queue 3:
   @DUT: $ echo 3 | sudo tee /sys/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/default_rx_queue
         3
   @DUT: $ cat /sys/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/default_rx_queue
         3

6. Send 10 ARP packets:
   @LinkPartner: $ arping -c 10 -I enp170s0 169.254.1.10
                 ARPING 169.254.1.10 from 169.254.1.2 enp170s0
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.653ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.652ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.653ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.649ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.600ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.698ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.694ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.678ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.609ms
                 Unicast reply from 169.254.1.10 [00:A0:C9:00:00:00]  0.634ms
                 Sent 10 probes (1 broadcast(s))
                 Received 10 response(s)

7. Check statistic of Rx packets to make sure packets is received by new default queue (RxQ3):
   @DUT: $ ethtool -S enp2s0 | grep rx.*packets
         rx_packets: 20
         rx_queue_0_packets: 10
         rx_queue_1_packets: 0
         rx_queue_2_packets: 0
         rx_queue_3_packets: 10

Blanco Alcaine Hector (3):
  igc: Add documentation
  igc: Add default Rx queue configuration via sysfs
  igc: Add default Rx Queue into documentation

 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/intel/igc.rst     | 103 ++++++++++++
 drivers/net/ethernet/intel/igc/Makefile       |   3 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   6 +
 drivers/net/ethernet/intel/igc/igc_regs.h     |   6 +
 drivers/net/ethernet/intel/igc/igc_sysfs.c    | 156 ++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_sysfs.h    |  10 ++
 7 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/igc.rst
 create mode 100644 drivers/net/ethernet/intel/igc/igc_sysfs.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_sysfs.h

-- 
2.34.1


