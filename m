Return-Path: <bpf+bounces-42749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B359A99FD
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B49C285673
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A8214659B;
	Tue, 22 Oct 2024 06:38:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C812C491;
	Tue, 22 Oct 2024 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579131; cv=none; b=FbYMDmBMn0LLXbjwvXEDIoefIs1tMgHJ7voQkg/U274v1evD0obs0CIjRWUvo74ntdBTJSAOvnvAe9OEKjPeV64NyIGCbpoQtbSE/1xHm66z+HEc6p+kZduh0l2DAbSk3Y/OGrEEGDE8TDUvzNhvu/Btr2E3O12YF3RnadPvEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579131; c=relaxed/simple;
	bh=k14RtmqwKfkvlT+nCUP+ARSG0sVw9XIzZz6Ejz/ouNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mr5tX2skJw69nMf620AFFfXAaOE9P553n8KZ9BM6rmq+8bHlXc1ybtWJuBOAU17A8PvsPtJntRNuN6GxcXRF3zM3jOCaHHMIvUWF5luff8b/xFYQW5cRdnxkE0DKcwkAghtD6Kq7RTXUSzaH/RIN9MVNcteS2WAL2SZBnUkiDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXjBn3fhpzpXJ3;
	Tue, 22 Oct 2024 14:36:49 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B6B52140384;
	Tue, 22 Oct 2024 14:38:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Oct
 2024 14:38:45 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>,
	<maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v3 net 0/4] Fix passing 0 to ERR_PTR in intel ether drivers
Date: Tue, 22 Oct 2024 14:56:19 +0800
Message-ID: <20241022065623.1282224-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Fixing sparse error in xdp run code by introducing new variable xdp_res
instead of overloading this into the skb pointer as i40e drivers done
in commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") and
commit ae4393dfd472 ("i40e: fix broken XDP support").

v3: Fix uninitialized 'xdp_res' in patch 3 and 4 which Reported-by
    kernel test robot
v2: Fix this as i40e drivers done instead of return NULL in xdp run code

Yue Haibing (4):
  igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
  igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
  ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
  ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()

 drivers/net/ethernet/intel/igb/igb_main.c     | 22 +++++++-----------
 drivers/net/ethernet/intel/igc/igc_main.c     | 20 ++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
 4 files changed, 34 insertions(+), 54 deletions(-)

-- 
2.34.1


