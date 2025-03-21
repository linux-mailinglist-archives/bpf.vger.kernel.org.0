Return-Path: <bpf+bounces-54517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD87A6B2A0
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 02:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4329A7A646F
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3781C5D76;
	Fri, 21 Mar 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCC0F7fs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B11B6CF1;
	Fri, 21 Mar 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742520185; cv=none; b=EP+kAzivF2s9lzCryELIVO9alVgLq1cxpvO8aViN0BhkXqx9GaL6VnzdBil605qmJEsCWOVpCgCH/7uLbtvN69DVXc7rOPi/OlhuyRRlAkbhWooQsMD6356wzd6nH/1S1ZKTqg3CBjbWKW9De941Tq3deZJmAQ2FE72e/PpgrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742520185; c=relaxed/simple;
	bh=g4Zh7PWt0OMM2HXc1+ZsM/TpYkbBCUj4fIzfriMtXek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGRJ4SL1LdPFyVz1QFa/7UW1gnLPbUm3+O4s0/M3Pa9+rnw75iH3ywrpqPjTIr+VGXQpRc3LHyggFIaRj8oX9HJIoM9MlyM02elcEf8Wn3qWpaElEU3f6ArvhHCAHh3x1kQ1Ck6Hfc1qsAfhbbs1UHeJ4IVKk8YJa8en0G/dhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCC0F7fs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742520183; x=1774056183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4Zh7PWt0OMM2HXc1+ZsM/TpYkbBCUj4fIzfriMtXek=;
  b=cCC0F7fsW2Mztdgx/2FJ2yfqsM9XAnBf98l+k8JUicPig0vXBQByQ7XE
   6O3BPMYLFA/Qjb/x7jTdbsGn/GmUjNzAUP8dfhcm/SFOrXBCH/nreQjhd
   hZ2fJjy9mD3eogWGQ76nga3VsX3d1mGEZN7+Z2Fh9voxWUG4y8iouZgN4
   +YJJva/su71fhSOhVY4e2qKRhfFYV+7lp2Rm4v+4yIKWphad8uyzVNKDl
   gk5sxKGdVNLGL22PDGKKgeIPjfr8SMZLyFsLA83jfY2Wm4XQ9S25J6wOh
   AGLB1zL738lutsbhwYx652O5k5fflcK1BImu/E1htHmx4g/ykEz03A/gz
   g==;
X-CSE-ConnectionGUID: JYh73wC6QBGgDsHL1Y9o8g==
X-CSE-MsgGUID: C7tRqg76S+KO9lDtGAVglA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43658359"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43658359"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:23:03 -0700
X-CSE-ConnectionGUID: 4c1grbUJQaa1Gyejm6wEjw==
X-CSE-MsgGUID: YPm+TcJbShODrpWvFp0w7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123777070"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:22:58 -0700
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
Subject: [PATCH bpf-next v4 1/2] selftests/xsk: Add packet stream replacement function
Date: Fri, 21 Mar 2025 00:54:18 +0000
Message-Id: <20250321005419.684036-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321005419.684036-1-tushar.vyavahare@intel.com>
References: <20250321005419.684036-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pkt_stream_replace_ifobject function to replace the packet stream for
a given ifobject.

Enable separate TX and RX packet replacement, allowing RX side packet
length adjustments using bpf_xdp_adjust_tail() in the upcoming patch.
Currently, pkt_stream_replace() works on both TX and RX packet streams,
and this new function provides the ability to modify one of them.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 11f047b8af75..d60ee6a31c09 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -757,14 +757,15 @@ static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
 	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
 }
 
-static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
+static void pkt_stream_replace_ifobject(struct ifobject *ifobj, u32 nb_pkts, u32 pkt_len)
 {
-	struct pkt_stream *pkt_stream;
+	ifobj->xsk->pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
+}
 
-	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
-	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
-	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
-	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
+static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
+{
+	pkt_stream_replace_ifobject(test->ifobj_tx, nb_pkts, pkt_len);
+	pkt_stream_replace_ifobject(test->ifobj_rx, nb_pkts, pkt_len);
 }
 
 static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
-- 
2.34.1


