Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE72364B470
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiLMLu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiLMLuY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:50:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982F710B67;
        Tue, 13 Dec 2022 03:50:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E0B52F4;
        Tue, 13 Dec 2022 03:51:02 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F3EB3F5A1;
        Tue, 13 Dec 2022 03:50:20 -0800 (PST)
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
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 0/4] Add VG register attr test with kernel version and feature detection
Date:   Tue, 13 Dec 2022 11:47:35 +0000
Message-Id: <20221213114739.2312862-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I didn't get any feedback on the RFC version of this that I posted a
while back [1]. I'd still like to add the test, especially now that
6.1 has been released with this new feature, so I've rebased it onto
perf/core and double checked that it's still working.

Applies to perf/core (0c3852adae83)

Thanks
James

[1]: https://lore.kernel.org/bpf/20220927154104.869029-1-james.clark@arm.com/

James Clark (4):
  perf test: Add ability to test exit code for attr tests
  perf test: Add mechanism for skipping attr tests on auxiliary vector
    values
  perf test: Add mechanism for skipping attr tests on kernel versions
  perf test arm64: Add attr tests for new VG register

 tools/perf/tests/attr.py                      | 71 +++++++++++++++++--
 .../attr/test-record-user-regs-no-sve-aarch64 |  9 +++
 .../test-record-user-regs-old-sve-aarch64     | 10 +++
 .../attr/test-record-user-regs-sve-aarch64    | 14 ++++
 4 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-sve-aarch64

-- 
2.25.1

