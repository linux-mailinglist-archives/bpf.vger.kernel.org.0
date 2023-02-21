Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A269E29F
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 15:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjBUOsL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 09:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjBUOsK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 09:48:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702F3C3B;
        Tue, 21 Feb 2023 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676990889; x=1708526889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywd+JZNDR2jmJtryHqa+ea9UJUbbLZv/MDZRRFcw54g=;
  b=XQv1+KNsbveNHPCNZGBEdBOrny0yg89phl+bjI7yDBXK8Vl6w35z4slg
   oHThDp+5l3iOc7ndRYRn0+UuXwcfdpog5MFizZyc16aLOGGIGbenAMdy9
   /3NdwVaNCOVUUrJdG/IIe4OmIODLFQqypG+aXv2bAomEFOWqLJk7Z/iLl
   I55pJDJmcKQnpeRZU4A3thuKQzimmTohyciV6X/wdxph5CY+sVIApp7lC
   vFezaHeM4jCLseFfw1psOHq/Y/6Bsg8ghdMHUsJxt0Jh8qMJp5mC4Tq/5
   H0MkjmhShKegTmF7orFMZ5Y4pXmQ/D492mM/AR+z6sahRWv+595Y92NmR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="395128096"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="395128096"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 06:48:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="1000634665"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="1000634665"
Received: from tveit-mobl.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.249.39.132])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 06:48:06 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Cc:     inux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Add support for absolute value BPF timers
Date:   Tue, 21 Feb 2023 16:48:03 +0200
Message-Id: <20230221144803.2216876-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new flag BPF_F_TIMER_ABS that can be passed to bpf_timer_start()
to start an absolute value timer instead of the default relative value.
This makes the timer expire at an exact point in time, instead of a time
with latencies and jitter induced by both the BPF and timer subsystems.
This is useful e.g. in certain time sensitive profiling cases, where we
need a timer to expire at an exact point in time.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 include/uapi/linux/bpf.h | 15 +++++++++++++++
 kernel/bpf/helpers.c     | 11 +++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 464ca3f01fe7..7f5b71847984 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4951,6 +4951,12 @@ union bpf_attr {
  *		different maps if key/value layout matches across maps.
  *		Every bpf_timer_set_callback() can have different callback_fn.
  *
+ *		*flags* can be one of:
+ *
+ *		**BPF_F_TIMER_ABS**
+ *			Start the timer in absolute expire value instead of the
+ *			default relative one.
+ *
  *	Return
  *		0 on success.
  *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier
@@ -7050,4 +7056,13 @@ struct bpf_core_relo {
 	enum bpf_core_relo_kind kind;
 };
 
+/*
+ * Flags to control bpf_timer_start() behaviour.
+ *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
+ *       relative to current time.
+ */
+enum {
+	BPF_F_TIMER_ABS = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index af30c6cbd65d..924849d89828 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1253,10 +1253,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 {
 	struct bpf_hrtimer *t;
 	int ret = 0;
+	enum hrtimer_mode mode;
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	if (flags)
+	if (flags > BPF_F_TIMER_ABS)
 		return -EINVAL;
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
@@ -1264,7 +1265,13 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 		ret = -EINVAL;
 		goto out;
 	}
-	hrtimer_start(&t->timer, ns_to_ktime(nsecs), HRTIMER_MODE_REL_SOFT);
+
+	if (flags & BPF_F_TIMER_ABS)
+		mode = HRTIMER_MODE_ABS_SOFT;
+	else
+		mode = HRTIMER_MODE_REL_SOFT;
+
+	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
-- 
2.25.1

