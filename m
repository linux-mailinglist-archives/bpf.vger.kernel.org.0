Return-Path: <bpf+bounces-55173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97402A793E6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49603B42D0
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F361C861F;
	Wed,  2 Apr 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSD69hQ8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679A1A38E1;
	Wed,  2 Apr 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615553; cv=none; b=UpbY6VMGa7UMe/0Mn0GqgLfn3vqTD1YhpVCeUSYwsm9ENv2YFBXkV+0pns8wvVB4UihZPWX6m2NO5MEPhEUtIbsC0wRR6mXMSHK/5oWL+73ol0H27jftsKU02Gv5m8m2sI2TRmNA7rm/iQibG3ot80BfwG32m4XVCiHUgEqhZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615553; c=relaxed/simple;
	bh=jNwFDxTuOCH8lyUs09sANxzuuVeAM/rbcLgVg4H6dsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Irm9JyvpkgK8m4MeixtO7ddXZHY+1kvzpACgpZEZ+fS3A07gwLlhW7V7o7491dNFsUL1XsxMORF4WKvp9igN6H4Y68r7L9ikf5EA8isoDdr+dk4THUsJ+AsTziGZ0L49pwerqzjRe0QslOrS7UOawzLjgZR+t8iDj0vz34A0Sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSD69hQ8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743615551; x=1775151551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jNwFDxTuOCH8lyUs09sANxzuuVeAM/rbcLgVg4H6dsg=;
  b=SSD69hQ8Ohknpo8uxIccFl+NOjcxKZfidiYc5MB6qIIlF8TVnj3kSTVA
   FUbmu0syhtvQvREkVrWoLSwYJp5Vos85bHVhCoBJupCfcBM9BwtIVAdas
   oDjBZA1iAnNjVsrNR4YLMK4pUFXjlqi8dtNdk20/kJVdZYGhsbJNK04lM
   Vxhpld0C1vsnZlGXcIm8J3haNDfNerIUcixIyp82IskCSW7itYGVonR47
   C3amgOpGZ+O3ooIaDSjAnGk4I4yaO1xkuHtYEyAJQal0bQcoAx5Erqb9a
   ukvnIRq6UlGxnLs82I8cjhVJ0IYxuB9TDbOrvGxEYBR2yAmMBbmA2/guW
   w==;
X-CSE-ConnectionGUID: Tk9kVoglT+K+xipyulGQMg==
X-CSE-MsgGUID: RFOyCye2Qk+Jgyz75ridmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44257269"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44257269"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:39:10 -0700
X-CSE-ConnectionGUID: p2GHOo/VQNmyOgcQ+JIrIg==
X-CSE-MsgGUID: 7kOBXsLKRbyTzowjtSdWEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149968781"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2025 10:39:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Zdenek Bouska <zdenek.bouska@siemens.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 2/5] igc: Fix TX drops in XDP ZC
Date: Wed,  2 Apr 2025 10:38:54 -0700
Message-ID: <20250402173900.1957261-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
References: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zdenek Bouska <zdenek.bouska@siemens.com>

Fixes TX frame drops in AF_XDP zero copy mode when budget < 4.
xsk_tx_peek_desc() consumed TX frame and it was ignored because of
low budget. Not even AF_XDP completion was done for dropped frames.

It can be reproduced on i226 by sending 100000x 60 B frames with
launch time set to minimal IPG (672 ns between starts of frames)
on 1Gbit/s. Always 1026 frames are not sent and are missing a
completion.

Fixes: 9acf59a752d4c ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
Reviewed-by: Song Yoong Siang <yoong.siang.song@intel.com>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27c99ff59ed4..156d123c0e21 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3042,7 +3042,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	 * descriptors. Therefore, to be safe, we always ensure we have at least
 	 * 4 descriptors available.
 	 */
-	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
+	while (budget >= 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
 		struct igc_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		struct igc_tx_buffer *bi;
-- 
2.47.1


