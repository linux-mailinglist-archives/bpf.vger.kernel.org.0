Return-Path: <bpf+bounces-52762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E44A48228
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 15:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB93A84AC
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32825F7A7;
	Thu, 27 Feb 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbn6GtNz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646925E83C;
	Thu, 27 Feb 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668162; cv=none; b=cpLH/TGsmLaBJSPldCODWcWDBaFEDxlJ+x3egExvkQeJKO/w+EDaLLSQARUQ+f9+PVIynBlCJkmV2+vNaJ0/ha/vZ/fE6czoPUnnpaXW4DXmQsSv0zSXsOWiE90xhkWtLWYK0iQoOFStKBc9HpnVnJv9WCpyyt3Fxg5ST4jlaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668162; c=relaxed/simple;
	bh=xBxyHViRnMNLpWWV/9D9fdnOIXzCT8hfDorGk325Mks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szGZp4isP3nJDyJPcDtenB2YqnaNVJUfJSgrwweofxE6kCxkkyWtiTvGDkyNhzxuSIIOR+NhYJK3IFiDu2BKe70Ts77M1B756kQgIa1pwP+ceKCKTl/ET64LzD2iIBsqgIPoDJsMGgJde+NEENiOiXOlnItUWd9BVzZhJBCSslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbn6GtNz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740668162; x=1772204162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xBxyHViRnMNLpWWV/9D9fdnOIXzCT8hfDorGk325Mks=;
  b=nbn6GtNzHVG5fF0gIfkenmIeYb56lwRqRML2at5wFzOpR2qx/K4UNv0P
   dL9a5NnkLwC1S6L86jQpWajMHRtHqqYSEzum/Xx8qtmhgyqaK5SNRMc0J
   j6g3vGYw86n3nE8ZoGzPSJhigT+XH0QgtgKsw4zq8TVEDgVV6szys27Ji
   P2KKNOJAbn/1pwQGCm9wxVoxoo0jLD9Qw2lcmF5t1llhKOzI2CwJZwM8z
   xk/Sk4kcTqamdY0wuSHXHOvZM9S8FSmUwsE2m5d4cO9LtJ+TOX5feaOJ+
   TQHaKnrk7/k/PiCaGjfEU/cOWUSz7+n2ZNCExk3QPRHyzldt2CEkbUciL
   A==;
X-CSE-ConnectionGUID: j0qwggcbQkq/CkVsQ9GSmw==
X-CSE-MsgGUID: l7Tgmb0OTn2RoskD6LRxGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41480548"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41480548"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:56:01 -0800
X-CSE-ConnectionGUID: 5Up5l9ePSXaPFabxVB+6CA==
X-CSE-MsgGUID: +uzJA3nwT7WcGjmmaHnxfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117541122"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:55:57 -0800
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
Subject: [PATCH bpf-next v2 1/2] selftests/xsk: Add packet stream replacement function
Date: Thu, 27 Feb 2025 14:27:36 +0000
Message-Id: <20250227142737.165268-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227142737.165268-1-tushar.vyavahare@intel.com>
References: <20250227142737.165268-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pkt_stream_replace_ifobject function to replace the packet stream for
a given ifobject.

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


