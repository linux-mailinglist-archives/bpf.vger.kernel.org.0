Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E16A8179
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 12:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCBLqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 06:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCBLqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 06:46:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6220231D8;
        Thu,  2 Mar 2023 03:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677757591; x=1709293591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/uRUelVZU3Q6oGhZ0g8qpAC23v6y/WT8NF4OlN7AJZ4=;
  b=SKAqhzQIj2ZQupsdsptP8OySuBGuV3YQIy/QanlwBwEuprTR/Fq5k1MQ
   jYCatUZZpGoSkne6pob3y2+62UYciCxv9rTY2BMhQjwXU+3AYhTO/efbP
   BDt+cnopcm/Axj4B8u1bCwafVKvRc/I0hfURt4WXUUvoA/ehdYjzjVIuO
   RH8MxvOWYAmE7W57+p6kWWLWv7BanwX6NsNgYO4gaj+ckrB1ixX5PcIWj
   lusqcg5GiS9SGFueOYOJJbEHTMLClEUduovEv8nUp+mQvMracDz27Tw25
   NUdeuaWaDRB454xBH9516MNRi6jV/NXX/xXeBqhsu51iB8jLSYwfSdGqT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332180134"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332180134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="705229331"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="705229331"
Received: from pplank-mobl1.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.251.217.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:46:29 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCHv2 1/2] bpf: Add support for absolute value BPF timers
Date:   Thu,  2 Mar 2023 13:46:13 +0200
Message-Id: <20230302114614.2985072-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302114614.2985072-1-tero.kristo@linux.intel.com>
References: <20230302114614.2985072-1-tero.kristo@linux.intel.com>
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
with latencies induced by both the BPF and timer subsystems.

Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
v2:
 - added suggested by from Artem
 - copied the change from include/uapi/linux/bpf.h to tools/include also
   
 include/uapi/linux/bpf.h       | 15 +++++++++++++++
 kernel/bpf/helpers.c           | 11 +++++++++--
 tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 464ca3f01fe7..7f5b71847984 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
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
-- 
2.25.1

