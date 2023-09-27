Return-Path: <bpf+bounces-10968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DB17B056C
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0753AB20C7C
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C73418A;
	Wed, 27 Sep 2023 13:31:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77374328D4;
	Wed, 27 Sep 2023 13:31:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5110A;
	Wed, 27 Sep 2023 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695821496; x=1727357496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbRvVH49X8sXjq/Xsh1Weu8cJzVrIDToOE6tLkZj+yc=;
  b=PAajfq65MjsI4GnGoRx9+HIpDrrQ1M68xzdoiqBEvNQw2dS38AnVdC1x
   StXA7zddMTQoED5GmzppHyYW+Ut2XpByKCrxyimSLjp6Q4RP6b1OFdNi4
   NHlAMogsqnS67QSf7Bs6Q5dAUrWHuc95ghxqABeHAFSBneMoD0hM3Rw5K
   z1I6la3FzuptsKpDmWqYAMZoZ+P5Bkj5BHoNYscQHw4skiJyC4UMAvh6n
   uBlAWwbLcsy09lyGyjPdKasTsKXeumSpemimz8/jqG8zpGi5ZajvPYOWJ
   zEnLiqIhto7Yc1LHsAmdjPa7+9orDbQRuimb7ordH7Dm389j7tJj59/9m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="448316307"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="448316307"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698878696"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698878696"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:31:30 -0700
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
Subject: [PATCH bpf-next v3 2/8] selftests/xsk: rename xsk_xdp_metadata.h to xsk_xdp_common.h
Date: Wed, 27 Sep 2023 19:22:35 +0530
Message-Id: <20230927135241.2287547-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
References: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rename the header file to a generic name so that it can be used by all
future XDP programs. Ensure that the xsk_xdp_common.h header file includes
include guards.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c            | 2 +-
 .../selftests/bpf/{xsk_xdp_metadata.h => xsk_xdp_common.h}   | 5 +++++
 tools/testing/selftests/bpf/xskxceiver.c                     | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/bpf/{xsk_xdp_metadata.h => xsk_xdp_common.h} (55%)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 24369f242853..734f231a8534 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -3,7 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
-#include "xsk_xdp_metadata.h"
+#include "xsk_xdp_common.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
diff --git a/tools/testing/selftests/bpf/xsk_xdp_metadata.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
similarity index 55%
rename from tools/testing/selftests/bpf/xsk_xdp_metadata.h
rename to tools/testing/selftests/bpf/xsk_xdp_common.h
index 943133da378a..f55d61625336 100644
--- a/tools/testing/selftests/bpf/xsk_xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
@@ -1,5 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#ifndef XSK_XDP_COMMON_H_
+#define XSK_XDP_COMMON_H_
+
 struct xdp_info {
 	__u64 count;
 } __attribute__((aligned(32)));
+
+#endif /* XSK_XDP_COMMON_H_ */
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 16a09751b093..ad1f7f078f5f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -102,7 +102,7 @@
 #include <bpf/bpf.h>
 #include <linux/filter.h>
 #include "../kselftest.h"
-#include "xsk_xdp_metadata.h"
+#include "xsk_xdp_common.h"
 
 static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
 static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
-- 
2.34.1


