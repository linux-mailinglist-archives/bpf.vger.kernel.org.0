Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5359832C
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiHRM3G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiHRM3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 08:29:05 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F4F657890
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 05:29:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4M7kBx3Fwmz9v7gh;
        Thu, 18 Aug 2022 20:06:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA38hluLP5ipRkyAA--.42926S4;
        Thu, 18 Aug 2022 13:11:46 +0100 (CET)
From:   roberto.sassu@huaweicloud.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, quentin@isovalent.com
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
Date:   Thu, 18 Aug 2022 14:09:57 +0200
Message-Id: <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA38hluLP5ipRkyAA--.42926S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw47Wr18JF15JFyxGw4xCrg_yoW5uF1rp3
        yrC3W3Ar1DKr4Ika1ayr48WF4Fkr4xJay7tas2kw17JF18Grnruw1YyFW8WFZ2g3yfZ3W3
        KF1aqr4UA3WDCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7
        xC0wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU06c_3UUUUU==
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

Sometimes, features are simply different flavors of another feature, to
properly detect the exact dependencies needed by different Linux
distributions.

For example, libbfd has three flavors: libbfd if the distro does not
require any additional dependency; libbfd-liberty if it requires libiberty;
libbfd-liberty-z if it requires libiberty and libz.

It might not be clear to the user whether a feature has been successfully
detected or not, given that some of its flavors will be set to OFF, others
to ON.

Instead, display only the feature main flavor if not in verbose mode
(VF != 1), and set it to ON if at least one of its flavors has been
successfully detected (logical OR), OFF otherwise. Omit the other flavors.

Accomplish that by declaring a FEATURE_GROUP_MEMBERS-<feature main flavor>
variable, with the list of the other flavors as variable value. For now, do
it just for libbfd.

In verbose mode, of if no group is defined for a feature, show the feature
detection result as before.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/build/Makefile.feature | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 6c809941ff01..57619f240b56 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -137,6 +137,12 @@ FEATURE_DISPLAY ?=              \
          libaio			\
          libzstd
 
+#
+# Declare group members of a feature to display the logical OR of the detection
+# result instead of each member result.
+#
+FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
+
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
 # mentioned in this list we need to refactor this ;-).
@@ -179,8 +185,17 @@ endif
 #
 feature_print_status = $(eval $(feature_print_status_code))
 
+feature_group = $(eval $(feature_gen_group)) $(GROUP)
+
+define feature_gen_group
+  GROUP := $(1)
+  ifneq ($(feature_verbose),1)
+    GROUP += $(FEATURE_GROUP_MEMBERS-$(1))
+  endif
+endef
+
 define feature_print_status_code
-  ifeq ($(feature-$(1)), 1)
+  ifneq (,$(filter 1,$(foreach feat,$(call feature_group,$(feat)),$(feature-$(feat)))))
     MSG = $(shell printf '...%40s: [ \033[32mon\033[m  ]' $(1))
   else
     MSG = $(shell printf '...%40s: [ \033[31mOFF\033[m ]' $(1))
@@ -244,12 +259,20 @@ ifeq ($(VF),1)
   feature_verbose := 1
 endif
 
+ifneq ($(feature_verbose),1)
+  #
+  # Determine the features to omit from the displayed message, as only the
+  # logical OR of the detection result will be shown.
+  #
+  FEATURE_OMIT := $(foreach feat,$(FEATURE_DISPLAY),$(FEATURE_GROUP_MEMBERS-$(feat)))
+endif
+
 feature_display_entries = $(eval $(feature_display_entries_code))
 define feature_display_entries_code
   ifeq ($(feature_display),1)
     $$(info )
     $$(info Auto-detecting system features:)
-    $(foreach feat,$(FEATURE_DISPLAY),$(call feature_print_status,$(feat),) $$(info $(MSG)))
+    $(foreach feat,$(filter-out $(FEATURE_OMIT),$(FEATURE_DISPLAY)),$(call feature_print_status,$(feat),) $$(info $(MSG)))
   endif
 
   ifeq ($(feature_verbose),1)
-- 
2.25.1

