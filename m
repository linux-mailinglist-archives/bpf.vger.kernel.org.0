Return-Path: <bpf+bounces-55625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D693A83796
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 06:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1338C2942
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 04:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD73A1F1522;
	Thu, 10 Apr 2025 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jX5N0ZF9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD31F1509;
	Thu, 10 Apr 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257665; cv=none; b=oZq0/yYi6/0+L2OwZZnLzWvFsq0tPvY0w8B5FQ4VYqkzcDoaYBkBwi1DP5BiEbodOR+G9X4DF6fLKIGrpdC60OB62Uzv1ZMfeOhAaeyPV/SYFRjAKKw1lI6iDOPk+aO2QsT0hN+W521qPKqPtb9V1xIY6iW1lQBCc3KFGkKy40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257665; c=relaxed/simple;
	bh=g4Zh7PWt0OMM2HXc1+ZsM/TpYkbBCUj4fIzfriMtXek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eg8z7cSSPjxRZxDJjW+MlGecgeXoBzoMlryKYfZ4h+BdsGc4By9y6tWBQVDSoyTw2rlOSb2Wrmpsd3xoYZmgN+kGZDIjFPvAmamD+sT7/THBtBfUllZPPXaatEe0m7NWEFN/ij4PguR5e/QKhKn2f6hMK20YDsxyz9LAtbIMm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jX5N0ZF9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744257664; x=1775793664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4Zh7PWt0OMM2HXc1+ZsM/TpYkbBCUj4fIzfriMtXek=;
  b=jX5N0ZF9QSzpTI1ueFYF9Igjv0YrxACKmmJtFKwKmWvEgo42TVyinuPC
   EOV1AJ0J0rfmqlA+zl4mBngJXytLyKddHxDYlvVD6Unzq6uxgKr48Vtbl
   J/P+lr1cOqqGzOAccP0S1r5/XJlesgaw6P9NxZb8BNd5OAUUQkA2iTbzt
   pnD++0S4As2p/Sa1tV1IL25ik8gaPZvFknFRgu895mGuWaJJs5itDyB14
   wP7DGzHK3GrEt7UWnhSA5y8FP5JnXuqS74090Ant+J+ZoU4Gh+lZMpokx
   K0AJm77GXQ8hQNPzGgfYSW/+Th2yRiOUGg3T/TxQ51/wyz06pxhSWuF8Q
   Q==;
X-CSE-ConnectionGUID: vkeR8MeJT4qDJFAecohUDA==
X-CSE-MsgGUID: 62aCedqKQKetGtyEVsiEtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="33365754"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="33365754"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 21:01:04 -0700
X-CSE-ConnectionGUID: cszIyZ01R020TpkkQbUl0g==
X-CSE-MsgGUID: KqO4Tq1kQRGSEva8uT62tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="159744164"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 21:01:00 -0700
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
Date: Thu, 10 Apr 2025 03:31:15 +0000
Message-Id: <20250410033116.173617-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410033116.173617-1-tushar.vyavahare@intel.com>
References: <20250410033116.173617-1-tushar.vyavahare@intel.com>
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


