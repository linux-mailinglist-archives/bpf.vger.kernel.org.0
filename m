Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAEB1C8DEA
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEGOJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgEGOIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:54 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0FC05BD0C
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n22so6870319qtp.15
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O3s1th6kwHV7OYn1BOC0SkexVvWRfaB4W2WMHJ3+QAE=;
        b=CK1m+ecJfjS+4WckyJ+MIAJmu9NSdTFzbnEvuTlhNhN2suAzSw1T5RCN8pFKx7qCp4
         n8nnqkhcZQAmfewVBnzZ6SAJQ+TjfCy93ePBEh5Frx6f707haJ1ZrHUlcr7n6906D2DN
         ojqiStE90Xd10Qio2tmn6XzaetPKq7lCzsFLSnIsfHSjm5vbOBl9vWzRWTiiM+ZvHAFN
         hC1/0b5t+keN9XBkOOOUKcIjiW4lsqVd0R1fMzlrlrGhAN0EIoQW7WWxeueiYqiI5D9N
         wAc4DchPEq05tJn/O4RH4yGj03qsYJkUcITNMNLGCEhgB8FQeT8TYfOhk24A/N4h+t8x
         7k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O3s1th6kwHV7OYn1BOC0SkexVvWRfaB4W2WMHJ3+QAE=;
        b=bFF6k+Nslq/gb35cM55C5nPHEB9utiGrotAUMVFxejiBnmyH2AA+HTCp5rPVUs92tb
         t5uzqpGMYPJScjk+936nR1TTJ73EH6Gd+oyAntnYRh+ir0BIskb1ewzyUNCHnpIGtBWX
         fKPqkCB1lztE86y5EnXTcxOkyp6Px1W+j/vt3C9i6pZV3foHkNfX7Qh3w9OO6L2BeFZf
         9Rucs6ZfrmvkKFmA9PizuVqTOGRF/0RNOAf2+KVjesYCXxeJhP5JAb7R/xzH9RH1vpjh
         oVBrg89ea18MN4hAB+uJLlcCi29h0fHwGhD78dOwUjqSqTO3MNdbopJ1lbDiM9L2zwhp
         LXsA==
X-Gm-Message-State: AGi0PuYOtliWfZ5zXFrxhHGBAtopdZ5UVJgwjK0qJwYZ2CXcOYHmB2Xr
        Xvz6mYJ0wRAe+O63LtHFBnngfQv0K+li
X-Google-Smtp-Source: APiQypIHBeiQoZpM97RY/NesSn20dHYkSwzLM+BOs1oCir4+ihIeJWG35Y9jkK+FwGLI1ItCDPmH/CkTnit7
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr14045295qvb.122.1588860533355;
 Thu, 07 May 2020 07:08:53 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:11 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-16-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 15/23] perf expr: fix memory leaks in bison
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
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a destructor for strings to reclaim memory in the event of errors.
Free the ID given for a lookup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 21e82a1e11a2..3b49b230b111 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -27,6 +27,7 @@
 %token EXPR_PARSE EXPR_OTHER EXPR_ERROR
 %token <num> NUMBER
 %token <str> ID
+%destructor { free ($$); } <str>
 %token MIN MAX IF ELSE SMT_ON
 %left MIN MAX IF
 %left '|'
@@ -94,8 +95,10 @@ if_expr:
 expr:	  NUMBER
 	| ID			{ if (lookup_id(ctx, $1, &$$) < 0) {
 					pr_debug("%s not found\n", $1);
+					free($1);
 					YYABORT;
 				  }
+				  free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
 	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
-- 
2.26.2.526.g744177e7f7-goog

