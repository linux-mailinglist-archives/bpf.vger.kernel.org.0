Return-Path: <bpf+bounces-32516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045690EF28
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641BA1C23473
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8883614E2F4;
	Wed, 19 Jun 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zdy2Q4X6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D314D2A2;
	Wed, 19 Jun 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804399; cv=none; b=eSnQIxBHZbpDN3Q08NCGVpmArSFmr4scZsIHqfugXvUwKtq7Xdk1XOjK11JrLbmdjzlD1ThDCgR/gtqB1oLhfPs6tkAjtaIle4wPNpF/7hgNonP6zN7bOd7l8iTrZmA3RzBFj7vY+1iahC3LjR0Mam4HbsqUm7SEEKd8+5pIPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804399; c=relaxed/simple;
	bh=doXXRhywWjznxwG9wfbUn8fcrCAhqBrCWMwvMVA3O6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IfU+MWMacKQXe8mPwl7UYBUZnWhA4zjCFsjzbMm4CQUYdjNol+ukGeauMXw8GQ5i6iEw3NL7wziM9S/wtluKZkD15BLPDPCzVBXXbHfQ6E0wkk13D2uUS8cw+U7Zaz0dB+Cd4n2PWALCia7q4P5mBuyMIAdiQ6w+lf+8gYRe/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zdy2Q4X6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718804398; x=1750340398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=doXXRhywWjznxwG9wfbUn8fcrCAhqBrCWMwvMVA3O6Q=;
  b=Zdy2Q4X6nkgiYhaSg3WkP5B9lVwSXQPUZ2qpWNZA220kqr3yvBmby4Wk
   7JON4x2eGwEqPmGPimdsFnRcQBWOWBbaHRcCgt9C/rqeZb8avzyfR+sxb
   mPrPwGUJCfNGx7vivpNs3+qR29in6cGASTt9pgPr+Wk8gWn2bw8M1FlsP
   FG1OLAlEfurgDQLs5QSDo+VHuNoooa+7g43zuvMC6AVbRgUFQiQ5dVI7c
   QFUTElGvYR7/9YVRJALQOPNknok154EpgDHwcSGMQJ5Sk9fEJLba1HXjS
   /1JfcSPayLo0jn/sLfCsZWo/tRApEAbUu4ynlPl1fDH35IIa95JsgNeAm
   Q==;
X-CSE-ConnectionGUID: eheQ/b9uRz6x7Z4xqaJ0MA==
X-CSE-MsgGUID: pDyg0mAWRv+waflUUlLaiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41146129"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41146129"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:39:56 -0700
X-CSE-ConnectionGUID: ZB3buApRQ7u/W+PlphXvWA==
X-CSE-MsgGUID: NN/y/3DtT/+eqVwk+hP0Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="65167401"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:39:52 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next 0/2] selftests/xsk: Enhance traffic validation and batch size support
Date: Wed, 19 Jun 2024 13:20:46 +0000
Message-Id: <20240619132048.152830-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces enhancements to xsk selftests, focusing on
dynamic batch size configurations and robust traffic validation.

Patch 1/2: Robust traffic validation post-ring size adjustment

- Fixed the flow in HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE test cases
  to validate Tx/Rx traffic by checking the return value of
  set_ring_size(), preventing premature test termination.

Patch 2/2: Dynamic batch size configuration

- Overcomes the 2K batch size limit by introducing dynamic adjustments for
  fill_size, comp_size, tx_size, and rx_size.
- Update HW_SW_MAX_RING_SIZE test case that evaluates the maximum ring
  sizes for AF_XDP, ensuring its reliability under maximum ring utilization.

Ensure the xsk selftests patches improve overall reliability and
efficiency, allowing the system to handle larger batch sizes and
effectively validate traffic after configuration changes.

Tushar Vyavahare (2):
  selftests/xsk: Ensure traffic validation proceeds after ring size
    adjustment in xskxceiver
  selftests/xsk: Enhance batch size support with dynamic configurations

 tools/testing/selftests/bpf/xskxceiver.c | 40 +++++++++++++++++-------
 tools/testing/selftests/bpf/xskxceiver.h |  2 ++
 2 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.34.1


