Return-Path: <bpf+bounces-21976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D7854D0D
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A27B26729
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BD95D756;
	Wed, 14 Feb 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlx3Kdn8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F015CDC9;
	Wed, 14 Feb 2024 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925141; cv=none; b=SjwJDmS7U3UVcRDa3uiaia1H/Hndcl5/9hGWBUkjWlyUfHCALq8hs+0N7axs/EUqpWqaTUTOH2b2NQCmzGe7f7TDX31duacW2ORd9uzr03NYwkrj9734OYtOXqD7W3xFuVeoSRb9aMPiuriI6cq3Xz0ifi6+xvq96sXJWk+qBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925141; c=relaxed/simple;
	bh=j9jvXH0vsZH1F67chvjpprea3OfhpV6nIJl3B4ccIIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haAOukt+HlvI6atltG2cO2BU1NJhJ+rac3eW2+SufMkp5ki3RMTh71LuNyoxal6jgoo7hzRlk6DoS3+nwf8HQEBTA7D4qDeYrjUxJO6dn90QgblskZ/9X5a+NVRII9ywqDMYoeROlpw5W0MhknWRC8dtRFeSfJ/cG4JEsLQVNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlx3Kdn8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707925139; x=1739461139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j9jvXH0vsZH1F67chvjpprea3OfhpV6nIJl3B4ccIIY=;
  b=dlx3Kdn8fse6qckoACTj92+ZxDnKNxTTFxdEEeJyaSaXMDNAf7cdihvP
   S4+0CAIF0gFlk6VqzlvPuQ/n8T/OHGqDHMcvRNZf1lADEjXG49mQr+U6A
   XFFmiQMLAkWEox6QhIhRv4Iu/Ne9thKEPUJf3bzB+k7TkGIy6yP0Ug9rL
   yIp0nPPIBPhPOJxN1Hsu6kM6F9yolIVW2MIBX2DZrFVF5F7N23UL00Vmj
   dlNxC6hjulEBY9n5bNBPoymoMV0Ww78C0VA4wDoH10Wl7G/wQ/QeO7LSG
   A0N/cj5gqOCRhVPCG5HxtR1hcnWS0edV2R1fZJg/WTS6Z8NQ3rj7Wxsiy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2118380"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2118380"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="34281480"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa001.fm.intel.com with ESMTP; 14 Feb 2024 07:38:56 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf/test_run: increase Page Pool's ptr_ring size in live frames mode
Date: Wed, 14 Feb 2024 16:38:38 +0100
Message-ID: <20240214153838.4159970-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when running xdp-trafficgen, test_run creates page_pools with
the ptr_ring size of %NAPI_POLL_WEIGHT (64).
This might work fine if XDP Tx queues are polled with the budget
limitation. However, we often clear them with no limitation to ensure
maximum free space when sending.
For example, in ice and idpf (upcoming), we use "lazy" cleaning, i.e. we
clean XDP Tx queue only when the free space there is less than 1/4 of
the queue size. Let's take the ring size of 512 just as an example. 3/4
of the ring is 384 and often times, when we're entering the cleaning
function, we have this whole amount ready (or 256 or 192, doesn't
matter).
Then we're calling xdp_return_frame_bulk() and after 64th frame,
page_pool_put_page_bulk() starts returning pages to the page allocator
due to that the ptr_ring is already full. put_page(), alloc_page() et at
starts consuming a ton of CPU time and leading the board of the perf top
output.

Let's not limit ptr_ring to 64 for no real reason and allow more pages
to be recycled. Just don't put anything to page_pool_params::size and
let the Page Pool core pick the default of 1024 entries (I don't believe
there are real use cases to clean more than that amount of descriptors).
After the change, the MM layer disappears from the perf top output and
all pages get recycled to the PP. On my test setup on idpf with the
default ring size (512), this gives +80% of Tx performance with no
visible memory consumption increase.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/bpf/test_run.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd919374017..1ad4f1ddcb88 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -163,7 +163,6 @@ static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_c
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = 0,
-		.pool_size = xdp->batch_size,
 		.nid = NUMA_NO_NODE,
 		.init_callback = xdp_test_run_init_page,
 		.init_arg = xdp,
-- 
2.43.0


