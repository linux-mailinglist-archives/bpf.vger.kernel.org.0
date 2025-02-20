Return-Path: <bpf+bounces-52064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA2CA3D437
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8143B6FA2
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D431EE002;
	Thu, 20 Feb 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jwkw2/RP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F321EC013;
	Thu, 20 Feb 2025 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042603; cv=none; b=caj5jC2Jol/ozyh+uTi9gpXWKwwyaiNPa1W1Qs/WGoPYy2q4YxShqR72Gba9BD8EsIgRD03wlgNmFji2B96XRJDgIizSl9w6HFogEMA8KJkEoU/gsr7DBCufG/zvNEAIVfYNHiANB6yn513+70lfgHKTG/dqBneM6Y2bt2+VNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042603; c=relaxed/simple;
	bh=xQCjIFiF9OnpX4e8BWS0rmT/hiiw7mFbf5Q+VJXlT/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqCLpiHi7vQTd2ZQxSYEsSgS/irlH/pKeuBDtA9lOJo967jzI90F6OXd52dwI5hxRgQzzzazDRKMys3P/d4IaWMygEzeU/jzQhDv/diIy+EwuORfIZCmFsi9R7s0dbamH3gUpsW3NieFb9k1PDt7W3uOKzZ76rq/QCa/9ENEN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jwkw2/RP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740042602; x=1771578602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xQCjIFiF9OnpX4e8BWS0rmT/hiiw7mFbf5Q+VJXlT/Q=;
  b=Jwkw2/RPnw8IhbnAyFNJ+JcpcHtKAGYzZzFXiaGlEUtHO6uBOfqGllij
   dpONZaKrss6AnC4TsZbU65zV8MRcq79j+MMK1pY+r1yhMpP+1U3LOwXoF
   7s+5a6fJLEiwMIZ4ai6XgGWCv08yp3uXsnGJBFQlffwwBm2DJbJOGllk1
   bFPggxGEkH697aRkUyEmztSZlaB2x2H0Ome0Emkk56iPJIf16yxBKaVXR
   H8Lbb4WW3yegeDRp+biqGSFePLTjxbUznnU5rQannzlXqS7aKyZlIwJMT
   RCZqeDBWm4LZDCBktkNQ7f2qtpHkZtczCp8hWSNj0Zci1oq/UvbuZwkNf
   A==;
X-CSE-ConnectionGUID: W8jfxey7QKi1MkmpNOIqqA==
X-CSE-MsgGUID: 6a2XOcj6SWG12Tw4fIaXvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40733452"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40733452"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:01 -0800
X-CSE-ConnectionGUID: krlOoEwlS6qBPhOg4WbFFw==
X-CSE-MsgGUID: LFq5Dt6vQLGBVvThlzGG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120084541"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:09:57 -0800
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
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next 0/6] selftests/xsk: Add tests for XDP tail adjustment in AF_XDP
Date: Thu, 20 Feb 2025 08:41:41 +0000
Message-Id: <20250220084147.94494-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds tests to validate the XDP tail adjustment
functionality, focusing on its use within the AF_XDP context. The tests
verify dynamic packet size manipulation using the bpf_xdp_adjust_tail()
helper function, covering both single and multi-buffer scenarios.

---
Patch Summary:

1. Add functions to replace packet streams for ifobjects and test_spec.

2. Introduce xsk_xdp_adjust_tail to adjust packet tails dynamically.

3. Add userspace function to adjust packet tails using XDP program.

4. Add function to check if bpf_xdp_adjust_tail() is supported.

5. Add function to test packet resizing using bpf_xdp_adjust_tail.

6. Introduce test shrinking and growing packets using
   bpf_xdp_adjust_tail(), and cover multi-buffer scenarios when used with
   AF_XDP.
---

Tushar Vyavahare (6):
  selftests/xsk: Add packet stream replacement functions
  selftests/xsk: Add tail adjustment functionality to XDP
  selftests/xsk: Add testapp_xdp_adjust_tail function to userspace for
    packet tail adjustment
  selftests/xsk: Add support check for bpf_xdp_adjust_tail() helper in
    xskxceiver
  selftests/xsk: Implement packet resizing test with bpf_xdp_adjust_tail
  selftests/xsk: Add packet resizing tests with bpf_xdp_adjust_tail for
    AF_XDP

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

 .../selftests/bpf/progs/xsk_xdp_progs.c       |  48 ++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
 tools/testing/selftests/bpf/xskxceiver.c      | 147 ++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h      |   2 +
 4 files changed, 183 insertions(+), 15 deletions(-)

-- 
2.34.1


