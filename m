Return-Path: <bpf+bounces-33600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD2191EED4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222DE1F224EC
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 06:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB365A110;
	Tue,  2 Jul 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHAgzBVC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9358BFA;
	Tue,  2 Jul 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901139; cv=none; b=VioukIEZWVM4hYg0lGAq6quv8Xtydx0EThOMESyOEWY1lZF0xQUE0pAYnozTXNS20TADD03MpsUETYXdN4D0tS1cdM6vQ3hHqsg6K0xoNfJxFp+WFgZ9bcm5adjt/la80PwdgtZi0tjl7bKXawQyPs0BvrPLV6U5L2u0RL9ekbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901139; c=relaxed/simple;
	bh=z2qRpavm2IBeL3dqoSrTiUiRP+4wh58flkN+8pF6XVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fvzr0b45xo4tBST4w5AM7iHNgCsLXlYa129/cU2q/3j3SLwwr5BHMUyjlKN7GYimVP6sUPtpjrYpR40aMixjgz1RpJYqQ4ZcSlxqBX0zGZIbMLrZ3DtOubgma3/prmIuM2vLfXih2a7dZpKvOxPTRiTYMfHe6waRSScQcRjb39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHAgzBVC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719901138; x=1751437138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z2qRpavm2IBeL3dqoSrTiUiRP+4wh58flkN+8pF6XVE=;
  b=kHAgzBVC3RvozzmcSNEdmAmHOSzjquarfsKT9MsxRJEJx+9Ye+x3/3yI
   G3rsmafW1bR7tt9DKNrv5q6AMioaH4G0RhMx1lCOdJihmGJnfRA6W+udS
   nIwk2q1jhtg8Um4R5UGH5P99q37n/YgRUJaPdd6bYLRRBfyV0lKURXzNj
   hJVkxhkdV73serLpj0UBXrXdpA8P+TsxyoY+XlbagoV0Hx8gIXLwmSTvN
   tw68TfNcnLVEBs3ReJ8hhF0PeIIEU4z/bAy5RRYBJTWZR49kY3O36QAOj
   XKLSVaXHi/kFYmq+SfV2Kro25LSUzViQOgy7fCnkPYmDzEUrCwwmpn0mC
   w==;
X-CSE-ConnectionGUID: ir4i/JxhTYyKXvIYqZ4DFA==
X-CSE-MsgGUID: 49TzcwbpSaSIegNPpRT3Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20866593"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20866593"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:18:57 -0700
X-CSE-ConnectionGUID: 8HtkeyqWSqikvwKjkj1khg==
X-CSE-MsgGUID: lchK49MbRE657UgWb5m37w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45919938"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:18:54 -0700
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
Subject: [PATCH bpf-next v3 0/2] selftests/xsk: Enhance traffic validation and batch size support
Date: Tue,  2 Jul 2024 05:59:14 +0000
Message-Id: <20240702055916.48071-1-tushar.vyavahare@intel.com>
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

v1->v2:
- Correctly bind UMEM queue sizes to TX and RX queues for standard
  operational alignment.
- Set cfg.rx_size directly from umem->fill_size when umem->fill_size is
  true, ensuring alignment with test specifications.

v2->v3:
- Update commit messages and cover letter for clarity and precision in
  documentation.

Patch series summary:

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


