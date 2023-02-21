Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A897169E33F
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjBUPVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBUPVM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:21:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE81B25BB2;
        Tue, 21 Feb 2023 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676992867; x=1708528867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywd+JZNDR2jmJtryHqa+ea9UJUbbLZv/MDZRRFcw54g=;
  b=dxLcN/234cAl+auZPbD4F53/zzKQqX2RwvzGH3XjBoHnxHIuV/ZJD+G9
   pV3XSU6zIdKn4NGP+QWZ3ilP2rVWOj0hXC5nvdEgQuzTuEGlWZdV8V9nu
   vvH4nsxR0COVEFoV/YvyMuMs2bjDNO3ACPDoa/iMaYbo8q/BlpGyUicx5
   nYDuyvVwxLi/iwB/PdoEMeXvHA2R++UBuCwVOjtop9r3P0zhNlrCI6OCI
   yfDPpgGBAnWLfXJW250sDFbaEOeTnSDX+oOJrDaW9Epza6nN5TB7bbSHR
   HOdssc62h76YD/wc+JJSHy3rfob3NJLGsgSXaGydWiv0IMi3vmyhVgFub
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334020034"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334020034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 07:18:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814529284"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814529284"
Received: from tveit-mobl.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.249.39.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 07:18:48 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] bpf: Add support for absolute value BPF timers
Date:   Tue, 21 Feb 2023 17:18:46 +0200
Message-Id: <20230221151846.2218217-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

