Return-Path: <bpf+bounces-31836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD12903CE2
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 15:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709CE1F226CB
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5817BB35;
	Tue, 11 Jun 2024 13:16:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.andestech.com (59-120-53-16.hinet-ip.hinet.net [59.120.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5024211;
	Tue, 11 Jun 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.53.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111779; cv=none; b=K4bOxYMY6/rvsUgtri7UCWq4haNm0d4FxHiqtowo0vn/ZNuHDltHZb1lrHwoWUo0b6neYqTcj8RRmo3K2Ap3JAN7iSMOGTT1ltla0znjxGioM0s/c8SdxuP2wrZ47g229YK190fL6oCmuSOOL8f4tB1p4aS0PzVR4vnuy2Vr+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111779; c=relaxed/simple;
	bh=A8/SxLeo0g/QJrVx1kZZfMcvIx9lsikrYLFelitJ4Hg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKncQzlagRoCh+QoJYemT4dCA81cMqf2r1Y4/yRXNOZKFrM2i/d4iu67K9Zdn9SUTbUeRR4j3LcUPjfpQLc96eD9P2eDQ/apfjLlB9HleHCc9LRvy8krLRLmUqVGq4CxDPYzyiFJzHWgm5sZurlfp2wnn6Oa2ykiiCWC1kr9jPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=59.120.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 11 Jun
 2024 21:13:06 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <akpm@linux-foundation.org>, <urezki@gmail.com>, <hch@infradead.org>,
	<lstoakes@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <rick.p.edgecombe@intel.com>
CC: <patrick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [RFC PATCH 1/1] mm/vmalloc: Modify permission reset procedure to avoid invalid access
Date: Tue, 11 Jun 2024 21:13:01 +0800
Message-ID: <20240611131301.2988047-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)

The previous reset procedure is
1. Set direct map attribute to invalid
2. Flush TLB
3. Reset direct map attribute to default

It is possible that kernel forks another process
on another core that access the invalid mappings after
sync_kernel_mappings.

We could reproduce this scenario by running LTP/bpf_prog
multiple times on RV32 kernel on QEMU.

Therefore, the following procedure is proposed
to avoid mappings being invalid.
1. Reset direct map attribute to default
2. Flush TLB

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 mm/vmalloc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 45e1506d58c3..58ef2fc51e43 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3248,14 +3248,9 @@ static void vm_reset_perms(struct vm_struct *area)
 		}
 	}
 
-	/*
-	 * Set direct map to something invalid so that it won't be cached if
-	 * there are any accesses after the TLB flush, then flush the TLB and
-	 * reset the direct map permissions to the default.
-	 */
-	set_area_direct_map(area, set_direct_map_invalid_noflush);
-	_vm_unmap_aliases(start, end, flush_dmap);
+	/* Reset direct map permissions to default, then flush the TLB */
 	set_area_direct_map(area, set_direct_map_default_noflush);
+	_vm_unmap_aliases(start, end, flush_dmap);
 }
 
 static void delayed_vfree_work(struct work_struct *w)
-- 
2.34.1


