Return-Path: <bpf+bounces-67085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A1B3DE7C
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7051767B8
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A830E82D;
	Mon,  1 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWiGdzX4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2930C352
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718648; cv=none; b=DHQSc1uaROWngYC70R96TkOhpfttetkIatS5dTWacCk88Lck4/PKqSRzyPHZyVQNMpD+GOiPGNpupRUoUwphHC3TkemxCFFDkksqazk6tlJ8P76ZE6MfY8laSlio5KwkCGh4PuXJGkVDVdRNS26aTJCdC4vI42WVdgc1TZxQJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718648; c=relaxed/simple;
	bh=8vsTXsnV6HMy0qhyRfkY0SLtwxf7E7B3z7u2WYzNy6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTfdkVSJ3SoHLJbdV65+Ay5sNogWgZnxxwU8tr0TiKBx7gX2PeETlpm3u0DBhycek1f/zksnyfZACE3CraDN0vXyFnMbK/5VBs+PZK+UmFtZQPYpMDn9CRPJAwetZHLcmz467HxIosfbRdg8rdv6BaMt/s9GIjSctWynS9HYdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWiGdzX4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756718647; x=1788254647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8vsTXsnV6HMy0qhyRfkY0SLtwxf7E7B3z7u2WYzNy6s=;
  b=kWiGdzX4SUjc+GdtqyuUAjSnarURGiCr3hdVlMIOUb3MrjQsPs+/Fa/U
   Zn++W0dPTVtiPqkxY7WLpzNIzJENtssM1MxWqfrKNlHYWXyR3YG/wpVji
   xB5PI61ovz3jOyNDrYcXNE5GfYjlfD6Xrs2AH9DoHG3xv+Krw2qXqEOyG
   PMtQaFJqegFJjTs1ftXvSHXzsh9Q0MQ6eL/m4uCjSbi9V4K2y/dfc9i6I
   NqSccCeYu3S+z/StkEAgN0s1o9r5jyIuvQup86eUu8Urit6ztSxmVsrtG
   VYZIJisWcuSFfOi7kLXNn7LiyT8IwmJ0A3jTaxRtfxvzzZRJRgYjtcX4N
   A==;
X-CSE-ConnectionGUID: m1T1dnF6THGstxuDDbgNWA==
X-CSE-MsgGUID: ZfBLnRaUTemx8f7rXAPUtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62803782"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62803782"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 02:24:07 -0700
X-CSE-ConnectionGUID: 7DDBox9VSQuIjCCFQASavw==
X-CSE-MsgGUID: E4jbRbQdTIaT7L1Inpjh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170824036"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa007.jf.intel.com with ESMTP; 01 Sep 2025 02:24:04 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/bpf/bpftool: fix buffer handling in get_fd_type()
Date: Mon,  1 Sep 2025 14:52:34 +0530
Message-Id: <20250901092234.3974937-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current check "if (n == sizeof(buf))" is incorrect for detecting
buffer overflow from readlink(). When readlink() fills the entire
buffer, it returns sizeof(buf) but does not null-terminate the string,
leading to potential buffer overrun in subsequent string operations.

Fix by changing the condition to "n >= sizeof(buf)" to properly detect
when the buffer is completely filled, ensuring space is reserved for
null termination.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index b07317d2842f..eebaa6896bd1 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -464,7 +464,7 @@ int get_fd_type(int fd)
 		p_err("can't read link type: %s", strerror(errno));
 		return -1;
 	}
-	if (n == sizeof(buf)) {
+	if (n >= sizeof(buf)) {
 		p_err("can't read link type: path too long!");
 		return -1;
 	}
-- 
2.34.1


