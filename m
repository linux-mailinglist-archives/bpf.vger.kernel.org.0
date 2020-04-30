Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD131BFE08
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 16:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgD3OY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgD3OYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 10:24:25 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCDC035495
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 07:24:25 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id z8so6606097qki.13
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i/C9Y5GBkF2sbab6q3+mjJTMGZ+JZWwA9+KZOitr3OM=;
        b=Uk/IVd7JCTjsWFv97jNMCas7BQBBx5POqcL+MxXjSs5PP1g4haTpXWRTtc5NKn2VdK
         aH5+k3jgElDkEGJcADkiJoy9vdCrRaMX+doMcVWpGMhs8/nxBmGVjoMJyYNAyPz/gTDA
         hcK542kKVi9f9ClzNsDbt7RwxBYaqrNXTJDLTebYmKCSV+WNszePKqWkzSY6m8+gdgRm
         wEgWlLmvu19YH9iLb/hqElh/hvLkOby8gWxh9ABfOMqT8SaHGDGrASxql0wYLc/tfnJf
         KglE1rU7Y2A7vasVj+Qu+t7HYwG42FTTT2CTSEUHBJWdWrm4GATf9BSVkjpvaGI38IIw
         4vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i/C9Y5GBkF2sbab6q3+mjJTMGZ+JZWwA9+KZOitr3OM=;
        b=fMs3NaVEr8wVgeMY2ehmw8foAOWntNxnkDWiPzScLWgR/7JqnulIVijKvB3gmpEP2Y
         uELyZW89UhQZhwF9dnY4yRQWyFPR6+Sxugflv0dPvwplBdm9TnEzbt10VZXhrJ4Q4Vik
         amLgND24vD2Jac4dFVd+jRRxqBSc7Lo10YFO0NxxBOMk54owN2GDKhW7AfP7R5pom3wz
         Y4twhMhC4KxEY47MCWOk6HrWyUTI/Co/gBk8HSE2j5wICs9vIFhgWe6JDifTxud6ZvGu
         iMP6NuWFry5Mata5PqGZiOZThkQ/sjXWCB5gl3ZaeXkfU0lyNu2RD+QNL6Y3GJy1c5iW
         dBhw==
X-Gm-Message-State: AGi0PuaeGmqb6Gc0rbyjwHBbkpTSj0Fs6Hi5YgXhfwDeOW+9chFczpNA
        0LU3J5etJgpAQLE5tSRPIlScVfgH13cQ
X-Google-Smtp-Source: APiQypKP1zBW8q2AAwdPS9E/7mblPhFugkRftNjhh+3oJHyi895hdKUfL/Si2nyV7ycNpADdY3f8KYvSloaL
X-Received: by 2002:a0c:a8e5:: with SMTP id h37mr3258473qvc.69.1588256664346;
 Thu, 30 Apr 2020 07:24:24 -0700 (PDT)
Date:   Thu, 30 Apr 2020 07:24:16 -0700
In-Reply-To: <20200430142419.252180-1-irogers@google.com>
Message-Id: <20200430142419.252180-2-irogers@google.com>
Mime-Version: 1.0
References: <20200430142419.252180-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 1/4] perf doc: pass ASCIIDOC_EXTRA as an argument
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

commit e9cfa47e687d ("perf doc: allow ASCIIDOC_EXTRA to be an argument")
allowed ASCIIDOC_EXTRA to be passed as an option to the Documentation
Makefile. This change passes ASCIIDOC_EXTRA, set by detected features or
command line options, prior to doing a Documentation build. This is
necessary to allow conditional compilation, based on configuration
variables, in asciidoc code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d15a311408f1..94a495594e99 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -188,7 +188,7 @@ AWK     = awk
 # non-config cases
 config := 1
 
-NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help install-doc install-man install-html install-info install-pdf doc man html info pdf
+NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help
 
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
@@ -832,7 +832,7 @@ INSTALL_DOC_TARGETS += quick-install-doc quick-install-man quick-install-html
 
 # 'make doc' should call 'make -C Documentation all'
 $(DOC_TARGETS):
-	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA)
 
 TAG_FOLDERS= . ../lib ../include
 TAG_FILES= ../../include/uapi/linux/perf_event.h
@@ -959,7 +959,7 @@ install-python_ext:
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA)
 
 ### Cleaning rules
 
-- 
2.26.2.303.gf8c07b1a785-goog

