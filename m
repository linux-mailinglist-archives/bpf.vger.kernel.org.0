Return-Path: <bpf+bounces-34165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C7092AC68
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04C71C21E32
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00CE152DF2;
	Mon,  8 Jul 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BV6r4vkO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB701514F6;
	Mon,  8 Jul 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480082; cv=none; b=RyvYe8NUlWBWJmTp1kVQ+OS/FyR9CzV0gERpSBwBgU+mzxSY8IJIe9HFlIQnO4u93flUfG26OAfCQWXCC3pbjSL6exqUmKi98DZD2YsIehz56LP0G0199C5hN+UB+IcVhv8MKXCVUibVZn8k8uu2MTFn9XwitfBqYPJrosQzfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480082; c=relaxed/simple;
	bh=sQxv7teCO1hbAAxVG0Cg2IVIt2j1aE8dnopocu70pcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUQT1YEmivcIkTU0wiQRnwpi4WlUEFC8URcYspzyuJF+XUM6niA6ZZoDQtcXpVT4PiClc/12jo6Wq0lQXNPW6MhUgj75E4PifPHMvYIicb5A6znovaD8Ra9Njr73y5e5QUN9ZIdv1JDIO15nO3WB2s+zVLtSvZAzCplH89mLN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BV6r4vkO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720480080; x=1752016080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sQxv7teCO1hbAAxVG0Cg2IVIt2j1aE8dnopocu70pcQ=;
  b=BV6r4vkOOfgW1ie0J9nQ2EVTXys0jR+gWX1ydRDuzR8ysguS/6vdUH29
   R2nPrWb++1R45K1DJ4scB59E9Z/PWWN4RBEMDcU+I4bJnrPkocKyir4Wh
   sp506oWHcU6hc90tRAta9pPtwjPKmQ0bGOXuj3ktuxBBgmyIpixAfe5AH
   RZoUwvhOLKSPtK/07hoPpoa1SMm82pLpAicAQzJCy/3VWQ1zL2Fi1N7m+
   WxGVFksmFabntm3laoRZnYI20krqMXRFKhoZIqiPMnbeLA3p4SnJ2GIyv
   vslScYLmSuHjr12YhPHAHm0jtQX9QW15R+KnNHnDDQfPQotmJZY+JOOwX
   A==;
X-CSE-ConnectionGUID: +Q1H78u+SM6NxMYpJR8OAw==
X-CSE-MsgGUID: nXPZUtRkR6yPeWS7Ug4nsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17540093"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17540093"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 16:08:00 -0700
X-CSE-ConnectionGUID: oeg7xK9wR4uTwqtl8Bh/pw==
X-CSE-MsgGUID: NCjnMFRyTlSv4tHkNu4xQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="85189019"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2024 16:07:59 -0700
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
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net] i40e: Fix XDP program unloading while removing the driver
Date: Mon,  8 Jul 2024 16:07:49 -0700
Message-ID: <20240708230750.625986-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
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

The example kernel warning log:

[  +0.004646] WARNING: CPU: 94 PID: 10395 at net/core/dev.c:9290 unregister_netdevice_many_notify+0x7a9/0x870
[...]
[  +0.010959] RIP: 0010:unregister_netdevice_many_notify+0x7a9/0x870
[...]
[  +0.002726] Call Trace:
[  +0.002457]  <TASK>
[  +0.002119]  ? __warn+0x80/0x120
[  +0.003245]  ? unregister_netdevice_many_notify+0x7a9/0x870
[  +0.005586]  ? report_bug+0x164/0x190
[  +0.003678]  ? handle_bug+0x3c/0x80
[  +0.003503]  ? exc_invalid_op+0x17/0x70
[  +0.003846]  ? asm_exc_invalid_op+0x1a/0x20
[  +0.004200]  ? unregister_netdevice_many_notify+0x7a9/0x870
[  +0.005579]  ? unregister_netdevice_many_notify+0x3cc/0x870
[  +0.005586]  unregister_netdevice_queue+0xf7/0x140
[  +0.004806]  unregister_netdev+0x1c/0x30
[  +0.003933]  i40e_vsi_release+0x87/0x2f0 [i40e]
[  +0.004604]  i40e_remove+0x1a1/0x420 [i40e]
[  +0.004220]  pci_device_remove+0x3f/0xb0
[  +0.003943]  device_release_driver_internal+0x19f/0x200
[  +0.005243]  driver_detach+0x48/0x90
[  +0.003586]  bus_remove_driver+0x6d/0xf0
[  +0.003939]  pci_unregister_driver+0x2e/0xb0
[  +0.004278]  i40e_exit_module+0x10/0x5f0 [i40e]
[  +0.004570]  __do_sys_delete_module.isra.0+0x197/0x310
[  +0.005153]  do_syscall_64+0x85/0x170
[  +0.003684]  ? syscall_exit_to_user_mode+0x69/0x220
[  +0.004886]  ? do_syscall_64+0x95/0x170
[  +0.003851]  ? exc_page_fault+0x7e/0x180
[  +0.003932]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[  +0.005064] RIP: 0033:0x7f59dc9347cb
[  +0.003648] Code: 73 01 c3 48 8b 0d 65 16 0c 00 f7 d8 64 89 01 48 83
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 35 16 0c 00 f7 d8 64 89 01 48
[  +0.018753] RSP: 002b:00007ffffac99048 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  +0.007577] RAX: ffffffffffffffda RBX: 0000559b9bb2f6e0 RCX: 00007f59dc9347cb
[  +0.007140] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000559b9bb2f748
[  +0.007146] RBP: 00007ffffac99070 R08: 1999999999999999 R09: 0000000000000000
[  +0.007133] R10: 00007f59dc9a5ac0 R11: 0000000000000206 R12: 0000000000000000
[  +0.007141] R13: 00007ffffac992d8 R14: 0000559b9bb2f6e0 R15: 0000000000000000
[  +0.007151]  </TASK>
[  +0.002204] ---[ end trace 0000000000000000 ]---

Fix this by checking if the XDP program is being loaded or unloaded.
Then, block only loading a new program while "__I40E_IN_REMOVE" is set.
Also, move testing "__I40E_IN_REMOVE" flag to the beginning of XDP_SETUP
callback to avoid unnecessary operations and checks.

Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
Originally from: https://lore.kernel.org/netdev/20240611184239.1518418-2-anthony.l.nguyen@intel.com/#t

Changes:
- simplify the fix according to Kuba's suggestions, i.e. remove
  checking 'NETREG_UNREGISTERING' flag directly from ndo_bpf
  and remove a separate handling for 'unregister' context.
- update the commit message accordingly
- add an example of the kernel warning for the issue being fixed.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 284c3fad5a6e..310513d9321b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13293,6 +13293,10 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 	bool need_reset;
 	int i;
 
+	/* VSI shall be deleted in a moment, block loading new programs */
+	if (prog && test_bit(__I40E_IN_REMOVE, pf->state))
+		return -EINVAL;
+
 	/* Don't allow frames that span over multiple buffers */
 	if (vsi->netdev->mtu > frame_size - I40E_PACKET_HDR_PAD) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for linear frames and XDP prog does not support frags");
@@ -13301,14 +13305,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 
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


