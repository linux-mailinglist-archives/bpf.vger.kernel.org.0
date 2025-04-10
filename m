Return-Path: <bpf+bounces-55624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A1A83797
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 06:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD61444003D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F41EF0A6;
	Thu, 10 Apr 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gelP1Yn3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D54A04;
	Thu, 10 Apr 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257662; cv=none; b=hqO3G3zcViZhSnETPFPrfZgva7LeRUWTjx4gl+yZrjPc2PYInWt8G2kf53cfgjmyj7qwODIr3lKcmxftct32dyLEF65rpK3uRa2Ss//w4h9jJbuz/sAJGUIJhQJFA+TeMEzUE3zK7X3FRjxGQtI+YYy3wwMObvg2yqpQ+khhu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257662; c=relaxed/simple;
	bh=18pdtt5fs99KJ9QicksFmYejw3j6l4JDHi7+23rM2wY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggJca/eOwbaa7xy7oRD7rlgyROoSvAvLqnQsjEGhAF4rY18c9m+2G1zXcQccUSzjK+Vxnviu91KhCb/X90Upor9LFqYa07lrKRAvxiZggy120D1EjuYxktwlt9XAPp8T10UnqAgmhoGF9HDaz2FZmQXGr1zf8q72kaMBKmZl6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gelP1Yn3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744257661; x=1775793661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=18pdtt5fs99KJ9QicksFmYejw3j6l4JDHi7+23rM2wY=;
  b=gelP1Yn3tz8vQIc4Q2ugec/fnKTb1UTHHJIODIoCHX0Zt6/cp/kD8TIU
   ZvOeOGyK3V4+SGgBq/4HclOY8tAE6kmbNUoUXkiAG/tp45ssrEnH4KfkS
   HAJQ+Ji9AFE1YwhFm3y1sgSVZuo6nd6ip0PrtntnWvGLZmbpTbm5EpIPe
   8yzj0PaanDvZ3gmrfpoIztZpb5AAIm63LdRo0JrqglK6EyYnXJZsDdoxU
   /0GYnu/VF/IFuAhWmzay56OQhP0dogtzg59l2GLDh5Lb4N4F21lMESbdR
   tE/hJGjeh9jwXzdlys+IgFR/wCsDvmia9cw4gHw/UxyfMlh6uiXOuVfkF
   g==;
X-CSE-ConnectionGUID: p8l/m+5qTXCmqk0AX+h3OQ==
X-CSE-MsgGUID: LU572m4RScW0lpicTvmKEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="33365741"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="33365741"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 21:01:00 -0700
X-CSE-ConnectionGUID: BFy7tdapRh+f4erHTC5plA==
X-CSE-MsgGUID: c3NAGAkNRsehu+OFzJZZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="159744143"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 21:00:56 -0700
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
Subject: [PATCH bpf-next v4 0/2] selftests/xsk: Add tests for XDP tail adjustment in AF_XDP
Date: Thu, 10 Apr 2025 03:31:14 +0000
Message-Id: <20250410033116.173617-1-tushar.vyavahare@intel.com>
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

v3 -> v4:
1. Remove `testapp_adjust_tail_common()`. [Maciej]

2. Add comments and modify code for buffer resizing logic in test cases
   (shrink/grow by specific byte sizes for testing purposes). [Maciej]

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
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

 .../selftests/bpf/progs/xsk_xdp_progs.c       |  50 ++++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
 tools/testing/selftests/bpf/xskxceiver.c      | 118 ++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h      |   2 +
 4 files changed, 163 insertions(+), 8 deletions(-)

-- 
2.34.1


