Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9466A66B523
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 02:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjAPBBl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 20:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjAPBBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 20:01:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC2CA279
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 17:01:36 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y19-20020a056a00191300b0058217bbc6ceso11654700pfi.4
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=oVMWfsW34/mGzPMwBFwgP503Mmst6dTXQwRmf7yhjQV3T611RrXu8SUNd69diz8msL
         k2m6ORMzKffSio7JKlJDYGbJNzNcYNM/zi4Lh+Neq+n+22h8KgrCElrqrFrNrnrW9Fwt
         4Q0aMoJtNkCMGnvh5OijMMjPPrdIaHndXZd6eLelQTfo1IFemkORMu4h77rN+LVcOu6N
         pgHQSYw04OOZlUZjQ0ilOFIuOJMHbrpCoEgdIhWSmdlrkjyOIUDGbWBQLdvu3u2qmQbX
         mHHPhWZK+IL4rEZKsQXiNAi2erx1zf9lypve5krMuoHLn300TU+ofqNc6LiwuoX1klx+
         5Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=cZl3J1SKMFEdfaWE/GqdQ47JuQBrz4nJiVM5hIQcxzP6FUJ68pAIpWgFPa7XKcCL/O
         lE9qxxT+JRU1P5Opsaler2wEZ6taFfiGy3s3hmJ1pIjdcGGVwQaCZ/ncaJixr6LrPyiV
         fbK3GJf8g72GtIr+0j4v9JLWmxoIfJurSdRTOj9UF0WDfquMPVDaHkaROjXobTBqyMAp
         5wUoQl0ANg1MbOLDj8jCypDP9onfVAiZWscurPBXmOUUEnFPf5++7VYyScLpe+cv2wGu
         cDTm6ceZPTHJG5MyNh/lhwAkIAKmX6aDq3Tpfq81WsuUYemYCPEqCTUQz67KWw3LTDeO
         Kr1Q==
X-Gm-Message-State: AFqh2koRpiP17IWWKGtAZ+kHqXbRZea5GAGIIqt3oUsKVvOwnCn6q/fb
        CeTlPvv2yComRwKhqzyVWNyTB7Un2Mqv
X-Google-Smtp-Source: AMrXdXvaEANIV4ydnJVEVN/4TOnTdYZRjSst6vBFoO6VrG5s9o9TicPq79sqg2G3TQ4ogM26FcqU7DZSUxLt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:79e:5e8e:382c:e7ce])
 (user=irogers job=sendgmr) by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id
 pa13-20020a17090b264d00b002261564643cmr5421842pjb.206.1673830895350; Sun, 15
 Jan 2023 17:01:35 -0800 (PST)
Date:   Sun, 15 Jan 2023 17:01:13 -0800
In-Reply-To: <20230116010115.490713-1-irogers@google.com>
Message-Id: <20230116010115.490713-2-irogers@google.com>
Mime-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/3] tools build: Pass libbpf feature only if libbpf 1.0+
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf 1.0 represented a cleanup and stabilization of APIs. Simplify
development by only passing the feature test if libbpf 1.0 is
installed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/build/feature/test-libbpf.c b/tools/build/feature/test-libbpf.c
index a508756cf4cc..cd9989f52119 100644
--- a/tools/build/feature/test-libbpf.c
+++ b/tools/build/feature/test-libbpf.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <bpf/libbpf.h>
 
+#if !defined(LIBBPF_MAJOR_VERSION) || (LIBBPF_MAJOR_VERSION < 1)
+#error At least libbpf 1.0 is required for Linux tools.
+#endif
+
 int main(void)
 {
 	return bpf_object__open("test") ? 0 : -1;
-- 
2.39.0.314.g84b9a713c41-goog

