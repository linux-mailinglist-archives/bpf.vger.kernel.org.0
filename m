Return-Path: <bpf+bounces-33222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC4919E6B
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 06:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2142F1C22994
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 04:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D01BC58;
	Thu, 27 Jun 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFGzN7Nf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B531A702;
	Thu, 27 Jun 2024 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719464107; cv=none; b=q+yakJaM4O09MDE4xT6jluOCGCihVihGmlGTHAU/i9DabO/lVeJgnAggkKYZLbMoqEFVnHj9vRStNUiDBNnJSovF/jLU0XcwUfaZnL8KyWFWQxCAv19rb3cbIHSS3SFAgvyJ0t/3S+50tRbKekOGM/EDInHEUd2PIIX6cSGNNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719464107; c=relaxed/simple;
	bh=0rRKxmQ1dPboHlWc42zlp/yEHB6pyzPmTndiL6oWc3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVxk+heDGiM7ashwyuxF8CxRfQ8a59UKUp0IWjVownaw+qdKTZ61m13rTzLFqO8dViXW0NncNMNA7fMdpFf2EfZ+n6emuxiQ0glxW9PmVol09NkftWCJphBoKLGkGPW3Qh5Vi1NAd7wjhXBSLZu4XIjmRtCEkn21+bIfoZ0MxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFGzN7Nf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719464105; x=1751000105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0rRKxmQ1dPboHlWc42zlp/yEHB6pyzPmTndiL6oWc3I=;
  b=HFGzN7Nf/Y1S3olkbPR3LiVdN1SaXK2kot57Ikao4rvJpx0Rpyhw+SzX
   /heKT3e5G569QR6Vt5kAVC8gCmNlSV0DejOjAcNJmymWJpxGw2AvWS1ed
   XxQiD8aNeX+KQJMCtcYNXabyyqURpf9BVp1QqhvZUzTxHSMj8wZtIbLll
   u3vY3OOXShDU6SnZQK6p9sXuXYf+Id0Gxu7abkOUBTfhW7Rp8JajnBxdY
   LNndqhqAQBuxPGpBIrGaAwbv9u0Kb9k1JPOX9mr6oqg13kCzoyXnvIF3k
   ekjeCf3HVslLy9RRIXgXQQbGQlMLgqFGVt9EO1HzuDtxnM4gaAWPk8Pdf
   g==;
X-CSE-ConnectionGUID: XUK/Va28Rq6oZmHuzO2s8g==
X-CSE-MsgGUID: GL7mgeFmRxaExKD9uaj+1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27966795"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27966795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:55:04 -0700
X-CSE-ConnectionGUID: 21f6qnZiR1aA3rFd/ApOGw==
X-CSE-MsgGUID: WSSZwRspQ0aWi6laWfcPXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="49209994"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:55:01 -0700
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
Subject: [PATCH bpf-next v2 0/2] selftests/xsk: Enhance traffic validation and batch size support
Date: Thu, 27 Jun 2024 04:35:46 +0000
Message-Id: <20240627043548.221724-1-tushar.vyavahare@intel.com>
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
  fill_size and comp_size.
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


