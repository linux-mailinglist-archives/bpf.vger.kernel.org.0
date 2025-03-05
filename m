Return-Path: <bpf+bounces-53343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6013A502BB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C0D189B75A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB924EA92;
	Wed,  5 Mar 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m75+p/gl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF53594C;
	Wed,  5 Mar 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186001; cv=none; b=ZHl2QBjPVQAjqlB38dYZ/OwqxprZjQxsrmrKPjuuGDSXUi2pLdfFrp+rlL1i5ia6faFwrYwCOSSL5XECy/EPVp4VygMVTo3CuZAya5ODSf4ZYQMCecvJdXFqqqbtkWe+3COvIIBtQYILm8FXZ9g5Y0tmMCZ2aBKyXdpMkJk5hac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186001; c=relaxed/simple;
	bh=xBxyHViRnMNLpWWV/9D9fdnOIXzCT8hfDorGk325Mks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxe8YDIpr81irZWIaLqZnB58R8uiIhVvVdbs7PMZx+bPuRRKskqPfPZ054YeqvSqZP1XS3bLN7vpxoWSi8Dz5uWHCLZgmRnv/aukQMIjZmhXrjqS+HDAu5AQZo4iBu+bzKip5oYZWoab6zQTax7r3e0Qm8cwfNo/sjHNArJ95JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m75+p/gl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741186000; x=1772722000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xBxyHViRnMNLpWWV/9D9fdnOIXzCT8hfDorGk325Mks=;
  b=m75+p/glb+T/cgDt+N5G5F/98jhFTA4VzJZZ3TX1z086IZscHanyINSo
   pvGeEK8HyJt2Bj87izXmltE5ta/R6Ehdi315KSck4zdQ7PPNLyGD6Rqiv
   6OFoamDPANiTecmlJnC6tro8mNpVyqbBvSUk2yz9eUTXVXwfZDKQy+mlV
   xBlXzZ3Kxu9DMvEkYOJ6iZRCvxIAYrKkU4qDToOTFB/dGUtjYMBaSG0sh
   AgoWGdLvbsxq6nko5f5AVxjYuNfRcxYpYfhldRRHOQYAe6s3MzznAFtl0
   n8lvJJ4/NP1a3kuz5L/9JUquTj2HNEi2Jq4CiYWfw0DIy5Vg1mKIWaoEk
   w==;
X-CSE-ConnectionGUID: EZieSZ5rTsSlwQtWsTd1Fw==
X-CSE-MsgGUID: 6EnBJg+VQEq6S7k2hphNog==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52355906"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52355906"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:46:40 -0800
X-CSE-ConnectionGUID: vmIZ07xRQtyswrtCwOHuHA==
X-CSE-MsgGUID: XeAf8NMsSlOn/TnnKufQbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123296901"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:46:37 -0800
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
Subject: [PATCH bpf-next v3 1/2] selftests/xsk: Add packet stream replacement function
Date: Wed,  5 Mar 2025 14:18:12 +0000
Message-Id: <20250305141813.286906-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305141813.286906-1-tushar.vyavahare@intel.com>
References: <20250305141813.286906-1-tushar.vyavahare@intel.com>
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


