Return-Path: <bpf+bounces-50217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B4A242F9
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B87188A992
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072071F1907;
	Fri, 31 Jan 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7hcT5hP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD184E1C;
	Fri, 31 Jan 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349673; cv=none; b=iQZOf9e9xG4043W4foi3q3nMk89mq80g1dAv2/fqHBjtqQyEBS8t664/QByPNg/aSGeqSmexHhg4xLw1FznBrS330EeW8NdzrEGwRnsao1PXIDc6Jb/nXIH1jWuBD89n7RRSuujqcWE0wEMQCXFn06qYM/iwJ/M1cE6npgE/cVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349673; c=relaxed/simple;
	bh=2ZH1fSzAviT3nmz3hzJ8ThSlJfLChWeBhesQfGX3UTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eikEwZ+6KaIiCIPSBE5hrOxTsL+JyVJqe4k8XkehEuS2uM+TJJzaKtV8ka9i6n5fj2oTLycqbNua+MAVjzcA+dtY077kvykE9bVsEYdhCTeLDLtZIbh7adiM+wXeHQhQb+j9s83jMLQz7H3vK4gMRd/YbQiKv3fQNVH/cDrf49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7hcT5hP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738349671; x=1769885671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ZH1fSzAviT3nmz3hzJ8ThSlJfLChWeBhesQfGX3UTk=;
  b=U7hcT5hPKjjh0+57A4sSFvxu47V7CYF07567Zfq44cJtcihTJCqZ8q6z
   0JdzuQz1r2yD+BzSYIVWEaUSTXAufU85S4iEZ1KTDeBRA9FsYcPGb4nrU
   hxH/bTNnOA6ZeEQ+2cLIAsFuDZyQSJaBrMLTxONatEPWIpZVmxaNxGZMe
   dMuPfjXwiEErpcZGRau0SdaY3Wo2JRsdrZg97A7RyeL+i4fq/Qts2VtLj
   jbAYUi40n3prB4apPO/I+FSjUSOXzbUc09t+W754XRMe14bBM9CqFQZnX
   T1P0ZFeL2gX62NVve5961iCaPU3VU3937D4JwOzVxG6hzMGhePS/UDrLi
   A==;
X-CSE-ConnectionGUID: kg43JS6GRsiBuN/NBaR2qQ==
X-CSE-MsgGUID: Z5PKRJ+WSUGeJzQnd5fVjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38163409"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="38163409"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 10:54:25 -0800
X-CSE-ConnectionGUID: UVr9HECrQiKrnHfVn9VMrw==
X-CSE-MsgGUID: PVVSud1dR62b2PO3qv4GJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110149719"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 31 Jan 2025 10:54:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	horms@kernel.org,
	xudu@redhat.com,
	jmaxwell@redhat.com
Subject: [PATCH net 0/3][pull request] ice: fix Rx data path for heavy 9k MTU traffic
Date: Fri, 31 Jan 2025 10:54:10 -0800
Message-ID: <20250131185415.3741532-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maciej Fijalkowski says:

This patchset fixes a pretty nasty issue that was reported by RedHat
folks which occurred after ~30 minutes (this value varied, just trying
here to state that it was not observed immediately but rather after a
considerable longer amount of time) when ice driver was tortured with
jumbo frames via mix of iperf traffic executed simultaneously with
wrk/nginx on client/server sides (HTTP and TCP workloads basically).

The reported splats were spanning across all the bad things that can
happen to the state of page - refcount underflow, use-after-free, etc.
One of these looked as follows:

[ 2084.019891] BUG: Bad page state in process swapper/34  pfn:97fcd0
[ 2084.025990] page:00000000a60ee772 refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x97fcd0
[ 2084.035462] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[ 2084.041990] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[ 2084.049730] raw: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000000
[ 2084.057468] page dumped because: nonzero _refcount
[ 2084.062260] Modules linked in: bonding tls sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200 irqd
[ 2084.137829] CPU: 34 PID: 0 Comm: swapper/34 Kdump: loaded Not tainted 5.14.0-427.37.1.el9_4.x86_64 #1
[ 2084.147039] Hardware name: Dell Inc. PowerEdge R750/0216NK, BIOS 1.13.2 12/19/2023
[ 2084.154604] Call Trace:
[ 2084.157058]  <IRQ>
[ 2084.159080]  dump_stack_lvl+0x34/0x48
[ 2084.162752]  bad_page.cold+0x63/0x94
[ 2084.166333]  check_new_pages+0xb3/0xe0
[ 2084.170083]  rmqueue_bulk+0x2d2/0x9e0
[ 2084.173749]  ? ktime_get+0x35/0xa0
[ 2084.177159]  rmqueue_pcplist+0x13b/0x210
[ 2084.181081]  rmqueue+0x7d3/0xd40
[ 2084.184316]  ? xas_load+0x9/0xa0
[ 2084.187547]  ? xas_find+0x183/0x1d0
[ 2084.191041]  ? xa_find_after+0xd0/0x130
[ 2084.194879]  ? intel_iommu_iotlb_sync_map+0x89/0xe0
[ 2084.199759]  get_page_from_freelist+0x11f/0x530
[ 2084.204291]  __alloc_pages+0xf2/0x250
[ 2084.207958]  ice_alloc_rx_bufs+0xcc/0x1c0 [ice]
[ 2084.212543]  ice_clean_rx_irq+0x631/0xa20 [ice]
[ 2084.217111]  ice_napi_poll+0xdf/0x2a0 [ice]
[ 2084.221330]  __napi_poll+0x27/0x170
[ 2084.224824]  net_rx_action+0x233/0x2f0
[ 2084.228575]  __do_softirq+0xc7/0x2ac
[ 2084.232155]  __irq_exit_rcu+0xa1/0xc0
[ 2084.235821]  common_interrupt+0x80/0xa0
[ 2084.239662]  </IRQ>
[ 2084.241768]  <TASK>

The fix is mostly about reverting what was done in commit 1dc1a7e7f410
("ice: Centrallize Rx buffer recycling") followed by proper timing on
page_count() storage and then removing the ice_rx_buf::act related logic
(which was mostly introduced for purposes from cited commit).

Special thanks to Xu Du for providing reproducer and Jacob Keller for
initial extensive analysis.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250123150118.583039-1-maciej.fijalkowski@intel.com/

The following are changes since commit c2933b2befe25309f4c5cfbea0ca80909735fd76:
  Merge tag 'net-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Maciej Fijalkowski (3):
  ice: put Rx buffers after being done with current frame
  ice: gather page_count()'s of each frag right before XDP prog call
  ice: stop storing XDP verdict within ice_rx_buf

 drivers/net/ethernet/intel/ice/ice_txrx.c     | 150 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  43 -----
 3 files changed, 103 insertions(+), 91 deletions(-)

-- 
2.47.1


