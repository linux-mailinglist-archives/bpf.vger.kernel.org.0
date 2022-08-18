Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37259832B
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbiHRM3G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244219AbiHRM3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 08:29:05 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D48D57245
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 05:28:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4M7kBq39nfz9v7H3;
        Thu, 18 Aug 2022 20:06:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA38hluLP5ipRkyAA--.42926S3;
        Thu, 18 Aug 2022 13:11:40 +0100 (CET)
From:   roberto.sassu@huaweicloud.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, quentin@isovalent.com
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 2/3] tools/build: Increment room for feature name in feature detection output
Date:   Thu, 18 Aug 2022 14:09:56 +0200
Message-Id: <20220818120957.319995-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA38hluLP5ipRkyAA--.42926S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1Utr17Kw43uF4xZw1DKFg_yoW8WFy8p3
        93CrW8Cr4DAr4Yk3W0yrs8ur43Gws7Xay7tFZ3Zw4jvFy8JF9Fvw1ayF4IqFs2g34Fqr45
        Wr9Fga1UAw10ywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7
        xC0wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
        KfnxnUUI43ZEXa7IUnwqXPUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Since now there are features with a long name, increase the room for them,
so that fields are correctly aligned.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/build/Makefile.feature | 6 +++---
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9d3afbc37e15..6c809941ff01 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -181,15 +181,15 @@ feature_print_status = $(eval $(feature_print_status_code))
 
 define feature_print_status_code
   ifeq ($(feature-$(1)), 1)
-    MSG = $(shell printf '...%30s: [ \033[32mon\033[m  ]' $(1))
+    MSG = $(shell printf '...%40s: [ \033[32mon\033[m  ]' $(1))
   else
-    MSG = $(shell printf '...%30s: [ \033[31mOFF\033[m ]' $(1))
+    MSG = $(shell printf '...%40s: [ \033[31mOFF\033[m ]' $(1))
   endif
 endef
 
 feature_print_text = $(eval $(feature_print_text_code))
 define feature_print_text_code
-    MSG = $(shell printf '...%30s: %s' $(1) $(2))
+    MSG = $(shell printf '...%40s: %s' $(1) $(2))
 endef
 
 #
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f4de6e16fbe2..c41a090c0652 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1301,7 +1301,7 @@ endif
 
 print_var = $(eval $(print_var_code)) $(info $(MSG))
 define print_var_code
-    MSG = $(shell printf '...%30s: %s' $(1) $($(1)))
+    MSG = $(shell printf '...%40s: %s' $(1) $($(1)))
 endef
 
 ifeq ($(feature_display),1)
-- 
2.25.1

