Return-Path: <bpf+bounces-52080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A3A3DB97
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 14:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A1D7AAB11
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA71F754C;
	Thu, 20 Feb 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYsdalyC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468E1509A0;
	Thu, 20 Feb 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059123; cv=none; b=e/sVKW0zVzelPwPmIh1PfV6f/j9kfrcmQKtn2TA/yOdIBjCI7ZxHdJV+LvFYXjMkcnIHng58v3QGx7aqo8RgGOCIHrrAto+GxUpRpJ0HGS2ApgdfNv+kbNxE+unGrcItLKGXT4DSHKG55HAvU1OjQz1ZVNHsXDuBakyq6Oo6JGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059123; c=relaxed/simple;
	bh=0ArWCpu+ca+PqkSRqWjCgo5Cbk/vqnmqhIJCb3Cyh64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ay1Nz+AdFyAYp4HMJsYUhEPzhjcfweeGAtcuLwYc6P8cxeoTgAMJhaVpfnDBolVQuX7KEIPely2QB3xRtgnnknYK0lgqAE8hlShf/3TzxFkURuuutTXzteAnJpZutnFHQx3uH4p8HMQ3vhxr2np5XysdBD0TQyQCqs19/flK1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYsdalyC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740059122; x=1771595122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ArWCpu+ca+PqkSRqWjCgo5Cbk/vqnmqhIJCb3Cyh64=;
  b=RYsdalyCyjB3XHdTprRl/UkJFeSGCCHlbDPmKGWgvptJNhD5WmxjxCbx
   UPW1liqyp7gE5/m02d8keZ06Tdq6umiZWFhe1YaGy9TrumSr0OyaKNESZ
   PnkBlUtczt19SZBYiFNRYBXMdqeBhmMO2D9DJsuCIZkwjrmm5rMJ2RWTm
   vgCBCSdE4AJ//uYDIaUChj8qKTLPfDCl3p5y+JRDuK+3CampflBb1ewM/
   FglX3kaoFfsad7eTRUj8Iq3YhFbAjG/UEOPbctpLZSnaYoU1Los+LWehO
   tAfEK1KqM+npQkEq544w6yz0C+G1qTGfl0NrfCrkNjfNN+F6w4yd85kkX
   w==;
X-CSE-ConnectionGUID: L8Ob04ABRvamNTWLif3GNw==
X-CSE-MsgGUID: drvTGRfbTmqwWLCxC6z+3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51479210"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="51479210"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 05:45:21 -0800
X-CSE-ConnectionGUID: NH/HkyrIQJ6li+0VzFLIuA==
X-CSE-MsgGUID: Ol8ukRywSeOVHLYNR3/z0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119146238"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 20 Feb 2025 05:45:18 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	martin.lau@linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next 0/3] bpf: introduce skb refcount kfuncs
Date: Thu, 20 Feb 2025 14:45:00 +0100
Message-Id: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This patchset provides what is needed for storing skbs as kptrs in bpf
maps. We start with necessary kernel change as discussed at [0] with
Martin, then next patch adds kfuncs for handling skb refcount and on top
of that a test case is added where one program stores skbs and then next
program is able to retrieve them from map.

Martin, regarding the kernel change I decided to go with boolean
approach instead of what you initially suggested. Let me know if it
works for you.

Thanks,
Maciej

[0]: https://lore.kernel.org/bpf/Z0X%2F9PhIhvQwsgfW@boxer/

Maciej Fijalkowski (3):
  bpf: call btf_is_projection_of() conditionally
  bpf: add kfunc for skb refcounting
  selftests: bpf: implement test case for skb kptr map storage

 include/linux/btf.h                           |  4 +-
 kernel/bpf/btf.c                              | 11 +--
 kernel/bpf/verifier.c                         |  3 +-
 net/core/filter.c                             | 62 +++++++++++++++
 .../selftests/bpf/prog_tests/skb_map_kptrs.c  | 75 ++++++++++++++++++
 .../selftests/bpf/progs/skb_map_kptrs.c       | 77 +++++++++++++++++++
 6 files changed, 224 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_map_kptrs.c
 create mode 100644 tools/testing/selftests/bpf/progs/skb_map_kptrs.c

-- 
2.43.0


