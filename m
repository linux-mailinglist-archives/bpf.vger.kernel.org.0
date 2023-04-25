Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194A6EE08F
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjDYKpD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjDYKpB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 06:45:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C380213E;
        Tue, 25 Apr 2023 03:44:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600852F4;
        Tue, 25 Apr 2023 03:45:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 960D03F5A1;
        Tue, 25 Apr 2023 03:44:57 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] perf build: Fix unescaped # in perf build-test
Date:   Tue, 25 Apr 2023 11:44:13 +0100
Message-Id: <20230425104414.1723571-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the following bash and make versions:

  $ make --version
  GNU Make 4.2.1
  Built for aarch64-unknown-linux-gnu

  $ bash --version
  GNU bash, version 5.0.17(1)-release (aarch64-unknown-linux-gnu)

This error is encountered when running the build-test target:

  $ make -C tools/perf build-test
  tests/make:181: *** unterminated call to function 'shell': missing ')'.  Stop.
  make: *** [Makefile:103: build-test] Error 2

Fix it by escaping the # which was causing make to interpret the rest of
the line as a comment leaving the unclosed opening bracket.

Fixes: 56d5229471ee ("tools build: Pass libbpf feature only if libbpf 1.0+")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index d75876126631..8dd3f8090352 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -178,7 +178,7 @@ run += make_install_prefix_slash
 # run += make_install_pdf
 run += make_minimal
 
-old_libbpf := $(shell echo "#include <bpf/libbpf.h>" | $(CC) -E -dM -x c -| egrep -q "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
+old_libbpf := $(shell echo '\#include <bpf/libbpf.h>' | $(CC) -E -dM -x c -| egrep -q "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
 
 ifneq ($(old_libbpf),)
 run += make_libbpf_dynamic
-- 
2.34.1

