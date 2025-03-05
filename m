Return-Path: <bpf+bounces-53342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB4A502B8
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82A1188EE86
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD1248885;
	Wed,  5 Mar 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROnFcmmv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39563594C;
	Wed,  5 Mar 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185998; cv=none; b=lqm4yRbQVuKKuAjxIsl6W1TDXkGdqfwB5OCmY/6SSLa92rndtvC0C/BcgRVun75U7Fqs50cYMJT2r5HBOzVjETkxxfEXFPtMkR1iQ0p0DvD7Hpo607j+Kgv2P6fL6zudLvGcc3s1hFquSX2IYjeRAWfHp5lNP/nxT/vBt3LxVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185998; c=relaxed/simple;
	bh=UNQnrk7ea2qjUTxEYudX1sfMK1ZpSwuAnn5ETANGDms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mY+Hxu/ZaTvAVRbf3VeVaTFagIk96ewaQUONGnUa09NLsLB2jajymKMrXiChveUP2Ory65EgKH3+ZrIG51+1pXG/yEGEa6NVrUtQncZ9np/uePSLbOKblWc4IsMkrYeUGl4U5AIporUrZ3jckdCVBXaNuet2gAxoPF4N9giaFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROnFcmmv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741185997; x=1772721997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UNQnrk7ea2qjUTxEYudX1sfMK1ZpSwuAnn5ETANGDms=;
  b=ROnFcmmvnAgnfLNkNQ4ab7GAJwbq6NdIiFcMAu1Yjpegc9AJFkqIIqMk
   otMtYbxMAQ09a5jYRtpbR17lSMcHg9qwQITdEJGRQYS8ywb6S3EiB2a/l
   Xy7MxbF+HB2cbMmP594yDORVSfc3WMs57Eq5y+p9nrKtTN0wWOEgJpJGh
   6pl69+9yKJsPEPly2kwHOSsH7bWDuYgDc4Z6aXwyj+n+JRShzeuExX4XJ
   nbYA5cuRHbeFoaTZajmUqLbQQmDstLCLnDvr2OPfduq0DkHLoionzdWk/
   y3jt8G6c7yZtwZMeM8Lv+b9xBGKV6brGr9+HQ97RqTIPR96MMpF2xQjwU
   Q==;
X-CSE-ConnectionGUID: TfTo2LXyTCeeCcVXduVKnQ==
X-CSE-MsgGUID: yo8bHt+5R6iN7KaN4lgtKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52355897"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52355897"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:46:36 -0800
X-CSE-ConnectionGUID: p8lwS4tDSHyq62YldatsFw==
X-CSE-MsgGUID: sj0NcocZQvixdZxT7/WTXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123296897"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:46:33 -0800
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
Subject: [PATCH bpf-next v3 0/2] selftests/xsk: Add tests for XDP tail adjustment in AF_XDP
Date: Wed,  5 Mar 2025 14:18:11 +0000
Message-Id: <20250305141813.286906-1-tushar.vyavahare@intel.com>
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

v1 -> v2:
1. Retain and extend stream replacement: Keep `pkt_stream_replace`
   unchanged. Add `pkt_stream_replace_ifobject` for targeted ifobject
   handling.

2. Consolidate patches: Merge patches 2 to 6 for tail adjustment tests and
   check.

v2 -> v3:
1. Introduce `adjust_value` to replace `count` for clearer communication
   with userspace.

---
Patch Summary:

1. Packet stream replacement: Add `pkt_stream_replace_ifobject` to manage
   packet streams efficiently.

2. Tail adjustment tests and support check: Implement dynamic packet
   resizing in xskxceiver by adding `xsk_xdp_adjust_tail` and extend this
   functionality to userspace with `testapp_xdp_adjust_tail` for
   validation. Ensure support by adding `is_adjust_tail_supported` to
   verify the availability of `bpf_xdp_adjust_tail()`. Introduce tests for
   shrinking and growing packets using `bpf_xdp_adjust_tail()`, covering
   both single and multi-buffer scenarios when used with AF_XDP.
---

Tushar Vyavahare (2):
  selftests/xsk: Add packet stream replacement function
  selftests/xsk: Add tail adjustment tests and support check

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

 .../selftests/bpf/progs/xsk_xdp_progs.c       |  49 +++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
 tools/testing/selftests/bpf/xskxceiver.c      | 120 ++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h      |   2 +
 4 files changed, 164 insertions(+), 8 deletions(-)

-- 
2.34.1


