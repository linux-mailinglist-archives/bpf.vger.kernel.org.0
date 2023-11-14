Return-Path: <bpf+bounces-15069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46437EB676
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 19:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F240281398
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C715AFF;
	Tue, 14 Nov 2023 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcAwpXyE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE226AC3;
	Tue, 14 Nov 2023 18:37:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A18BFE;
	Tue, 14 Nov 2023 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699987020; x=1731523020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uFA13WXAMzYBAJVna+PgOPhrM1fUoXheB3Dzlv+aedo=;
  b=IcAwpXyE8qobAD4LRFCmHUHOtFE+JfZDZhwUpqE12bQ2vC4PW6pBy5jy
   zEpTpHUiPBp88/NIKduXMKgEi6rRfNf4pAYn+Ea81z49pMiqN0FENetPv
   yoq9WztHALZAqkkSQCyDx/AwQ6nPetUNeF2jghSvkQv72djRvmE0D+vhV
   QjFhbSDoFj/Bf2WGxhrWbqjAXDEsq4PpW8R3LMpNaUxKmNnRKnQZgMX7a
   XE2yaR43uk0KJ5VpeB1IrCCI9eqXC9vf3URaEw6PClQxMVAVAEyOUsxKu
   ryqzeegVLkr7cZlb5VvZ6AbXZrQ3+wJMnCyLrUUbdp6vBXfV6pSqQcwin
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370918126"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="370918126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741174189"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741174189"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:36:58 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	vinicius.gomes@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/2][pull request] igc: Add support for physical + free-running timers
Date: Tue, 14 Nov 2023 10:36:36 -0800
Message-ID: <20231114183640.1303163-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vinicius Costa Gomes says:

The objective is to allow having functionality that depends on the
physical timer (taprio and ETF offloads, for example) and vclocks
operating together.

The "big" missing piece is the implementation of the .getcyclesx64()
function in igc, as i225/i226 have multiple timers, we use one of
those timers (timer 1) as a free-running (non adjustable) timer.

The complication is that only implementing .getcyclesx64() and nothing
else will break synchronization when using vclocks, as reading the clock
will retrieve the free-running value but timnestamps will come from the
adjustable timer. The solution is to modify "in one go" the timestamping
code to be able to retrieve the timestamp from the correct timer (if a
socket is "phc_bound" to a vclock the timestamp will come from the
free-running timer).

I was debating whether or not to do the adjustments for the internal latencies
for the free-running timestamps, decided to do the adjustments so the path
delay when using vclocks is similar to the one when using the physical clock.

One future improvement is to implement the .getcrosscycles() function.

The following are changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:
  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Vinicius Costa Gomes (2):
  igc: Simplify setting flags in the TX data descriptor
  igc: Add support for PTP .getcyclesx64()

 drivers/net/ethernet/intel/igc/igc.h         | 21 ++++++-
 drivers/net/ethernet/intel/igc/igc_base.h    |  4 ++
 drivers/net/ethernet/intel/igc/igc_defines.h |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 65 +++++++++++++-------
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 50 +++++++++------
 drivers/net/ethernet/intel/igc/igc_regs.h    |  5 ++
 6 files changed, 105 insertions(+), 42 deletions(-)

-- 
2.41.0


