Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D783059832E
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbiHRMad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 08:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiHRMac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 08:30:32 -0400
X-Greylist: delayed 93 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 05:30:31 PDT
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BAA1D7C;
        Thu, 18 Aug 2022 05:30:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4M7kDd51zfz9v7Gc;
        Thu, 18 Aug 2022 20:08:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA38hluLP5ipRkyAA--.42926S2;
        Thu, 18 Aug 2022 13:11:34 +0100 (CET)
From:   roberto.sassu@huaweicloud.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, quentin@isovalent.com
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/3] tools/build: Fix feature detection output due to eval expansion
Date:   Thu, 18 Aug 2022 14:09:55 +0200
Message-Id: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA38hluLP5ipRkyAA--.42926S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy7KryDCFWxKFW7Xr15twb_yoW7XF1kpa
        yrCF1UAr4DGF4Fya18Ar4UuF45Gr4fJay3J3sIk34UA3WUGrnI9r4ayFWvvFZ3u3y3XF13
        KF13KFWUAw1UCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY
        07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Wr1j
        6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU0fb1UUUUUU==
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

As the first eval expansion is used only to generate Makefile statements,
messages should not be displayed at this stage, as for example conditional
expressions are not evaluated.

It can be seen for example in the output of feature detection for bpftool,
where the number of detected features does not change, despite turning on
the verbose mode (VF = 1) and there are additional features to display.

Fix this issue by escaping the $ before $(info) statements, to ensure that
messages are printed only when the function containing them is actually
executed, and not when it is expanded.

In addition, move the $(info) statement out of feature_print_status, due to
the fact that is called both inside and outside an eval context, and place
it to the caller so that the $ can be escaped when necessary. For symmetry,
move the $(info) statement also out of feature_print_text, and place it to
the caller.

Force the TMP variable evaluation in verbose mode, to display the features
in FEATURE_TESTS that are not in FEATURE_DISPLAY.

Reorder perf feature detection messages (first non-verbose, then verbose
ones) by moving the call to feature_display_entries earlier, before the VF
environment variable check.

Also, remove the newline from that function, as perf might display
additional messages. Move the newline to perf Makefile, and display another
one if displaying the detection result is not deferred as in the case of
bpftool.

Fixes: 0afc5cad387db ("perf build: Separate feature make support into config/Makefile.feature")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/build/Makefile.feature | 19 ++++++++-----------
 tools/perf/Makefile.config   | 15 ++++++++-------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index fc6ce0b2535a..9d3afbc37e15 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -177,7 +177,7 @@ endif
 #
 # Print the result of the feature test:
 #
-feature_print_status = $(eval $(feature_print_status_code)) $(info $(MSG))
+feature_print_status = $(eval $(feature_print_status_code))
 
 define feature_print_status_code
   ifeq ($(feature-$(1)), 1)
@@ -187,7 +187,7 @@ define feature_print_status_code
   endif
 endef
 
-feature_print_text = $(eval $(feature_print_text_code)) $(info $(MSG))
+feature_print_text = $(eval $(feature_print_text_code))
 define feature_print_text_code
     MSG = $(shell printf '...%30s: %s' $(1) $(2))
 endef
@@ -247,21 +247,18 @@ endif
 feature_display_entries = $(eval $(feature_display_entries_code))
 define feature_display_entries_code
   ifeq ($(feature_display),1)
-    $(info )
-    $(info Auto-detecting system features:)
-    $(foreach feat,$(FEATURE_DISPLAY),$(call feature_print_status,$(feat),))
-    ifneq ($(feature_verbose),1)
-      $(info )
-    endif
+    $$(info )
+    $$(info Auto-detecting system features:)
+    $(foreach feat,$(FEATURE_DISPLAY),$(call feature_print_status,$(feat),) $$(info $(MSG)))
   endif
 
   ifeq ($(feature_verbose),1)
-    TMP := $(filter-out $(FEATURE_DISPLAY),$(FEATURE_TESTS))
-    $(foreach feat,$(TMP),$(call feature_print_status,$(feat),))
-    $(info )
+    $(eval TMP := $(filter-out $(FEATURE_DISPLAY),$(FEATURE_TESTS)))
+    $(foreach feat,$(TMP),$(call feature_print_status,$(feat),) $$(info $(MSG)))
   endif
 endef
 
 ifeq ($(FEATURE_DISPLAY_DEFERRED),)
   $(call feature_display_entries)
+  $(info )
 endif
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0661a1cf9855..f4de6e16fbe2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1304,11 +1304,15 @@ define print_var_code
     MSG = $(shell printf '...%30s: %s' $(1) $($(1)))
 endef
 
+ifeq ($(feature_display),1)
+  $(call feature_display_entries)
+endif
+
 ifeq ($(VF),1)
   # Display EXTRA features which are detected manualy
   # from here with feature_check call and thus cannot
   # be partof global state output.
-  $(foreach feat,$(FEATURE_TESTS_EXTRA),$(call feature_print_status,$(feat),))
+  $(foreach feat,$(FEATURE_TESTS_EXTRA),$(call feature_print_status,$(feat),) $(info $(MSG)))
   $(call print_var,prefix)
   $(call print_var,bindir)
   $(call print_var,libdir)
@@ -1318,11 +1322,12 @@ ifeq ($(VF),1)
   $(call print_var,JDIR)
 
   ifeq ($(dwarf-post-unwind),1)
-    $(call feature_print_text,"DWARF post unwind library", $(dwarf-post-unwind-text))
+    $(call feature_print_text,"DWARF post unwind library", $(dwarf-post-unwind-text)) $(info $(MSG))
   endif
-  $(info )
 endif
 
+$(info )
+
 $(call detected_var,bindir_SQ)
 $(call detected_var,PYTHON_WORD)
 ifneq ($(OUTPUT),)
@@ -1352,7 +1357,3 @@ endif
 # tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-
-ifeq ($(feature_display),1)
-  $(call feature_display_entries)
-endif
-- 
2.25.1

