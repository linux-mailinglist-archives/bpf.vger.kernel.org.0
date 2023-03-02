Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B46A817B
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 12:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCBLqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 06:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCBLqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 06:46:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5842A98C;
        Thu,  2 Mar 2023 03:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677757594; x=1709293594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLx0q3kH81DEhARp7hQmNWOMxwl1xSU4b2mgfSyDf38=;
  b=Ue9s7B2efhoAFRCjrsBhVqPu/yond9O3mwzcIxSveLRiaHIObPdxKNnk
   IHC7E1AKMrOaB7qz3KcazJHk3ojvdxqwwQWb1Ibt1vIKqvVMx5QXBBH/4
   AsrQim6B4/0zvxr1LwlT++Ny32DthYG/OnXR9F29SH6uNmn1Z5ZbLhdCD
   M/up4BTIACl1EyENdV3/02My+PqyxnnSgnthE7MJdH5pLFJHt/32HHXA4
   9i6EmdxRWkQfTUSnw/FeiyyzpaCtspfOA5MLu0o2JNipydpkLdojUErRE
   ixGec6opCKjz9qeyWMojsaawnCKRThpHWpYjaZxI1sWb54yyASQ299yLK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332180140"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332180140"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="705229333"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="705229333"
Received: from pplank-mobl1.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.251.217.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:46:31 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] selftests/bpf: Add absolute timer test
Date:   Thu,  2 Mar 2023 13:46:14 +0200
Message-Id: <20230302114614.2985072-3-tero.kristo@linux.intel.com>
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

Add test for the absolute BPF timer under the existing timer tests. This
will run the timer two times with 1us expiration time, and then re-arm
the timer at ~35s in the future. At the end, it is verified that the
absolute timer expired exactly two times.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
v2: new patch added

 .../testing/selftests/bpf/prog_tests/timer.c  |  3 ++
 tools/testing/selftests/bpf/progs/timer.c     | 45 +++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 7eb049214859..290c21dbe65a 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -29,6 +29,9 @@ static int timer(struct timer *timer_skel)
 	/* check that timer_cb2() was executed twice */
 	ASSERT_EQ(timer_skel->bss->bss_data, 10, "bss_data");
 
+	/* check that timer_cb3() was executed twice */
+	ASSERT_EQ(timer_skel->bss->abs_data, 12, "abs_data");
+
 	/* check that there were no errors in timer execution */
 	ASSERT_EQ(timer_skel->bss->err, 0, "err");
 
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index acda5c9cea93..9a16d95213e1 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -46,7 +46,15 @@ struct {
 	__type(value, struct elem);
 } lru SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} abs_timer SEC(".maps");
+
 __u64 bss_data;
+__u64 abs_data;
 __u64 err;
 __u64 ok;
 __u64 callback_check = 52;
@@ -284,3 +292,40 @@ int BPF_PROG2(test2, int, a, int, b)
 
 	return bpf_timer_test();
 }
+
+/* callback for absolute timer */
+static int timer_cb3(void *map, int *key, struct bpf_timer *timer)
+{
+	abs_data += 6;
+
+	if (abs_data < 12) {
+		bpf_timer_start(timer, bpf_ktime_get_boot_ns() + 1000,
+				BPF_F_TIMER_ABS);
+	} else {
+		/* Re-arm timer ~35 seconds in future */
+		bpf_timer_start(timer, bpf_ktime_get_boot_ns() + (1ull << 35),
+				BPF_F_TIMER_ABS);
+	}
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test3")
+int BPF_PROG2(test3, int, a)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	bpf_printk("test3");
+
+	timer = bpf_map_lookup_elem(&abs_timer, &key);
+	if (timer) {
+		if (bpf_timer_init(timer, &abs_timer, CLOCK_BOOTTIME) != 0)
+			err |= 2048;
+		bpf_timer_set_callback(timer, timer_cb3);
+		bpf_timer_start(timer, bpf_ktime_get_boot_ns() + 1000,
+				BPF_F_TIMER_ABS);
+	}
+
+	return 0;
+}
-- 
2.25.1

