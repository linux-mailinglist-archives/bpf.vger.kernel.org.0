Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA861CA2D7
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 07:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEHFgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 01:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgEHFgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 01:36:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF5C05BD0B
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 22:36:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n7so757124ybh.13
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 22:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kf/Nl54LdD1Myd4Q2ihfierbY9Agfscu2MTKHIAamr0=;
        b=s3XhVoaJuVP7bfI29XP+1KV8iq/zlxEkxZpwETde6utnftcO1DZWav49uNhLe9yLot
         +5/BdgyKr/VjJ3NqNKoK+eh6gBwyC3Oa7xXwAXVvKgWiZxGCTrBsX0PWDwuZFt0LALxS
         W88zJ02aK0yyrAQaCPjn2L6BbibphSG3vz7GsueuTLhoYcdhPiz8nEzV/5ntVLYPHUSR
         Wyy7zFsHLy5pXaIkJvbLXXRvpynpq8+VYRCoy8O1Kppx1y2azcHzoMe6RCGLINLMBrbL
         fvGBdGFk+cDjvAo7kCUIID/P2Z5ZFqkjEKrZGP8BBeYhQ4u4+ELHUH0kaMTwORFRbnSK
         SULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kf/Nl54LdD1Myd4Q2ihfierbY9Agfscu2MTKHIAamr0=;
        b=j45Zbun7hciLx2/7Kq9vgrZQ6nvTL0rih8aX4thlEl7/I7npNtNFSCgvAPplwdDK9a
         ozUCF/JmfWY+bkYytOyFLuMuDFSViVw1vH0wp3XS6w8CgI0IiQtXmSGS1vadaTOWT/Ts
         dYDJYtGVlAgtexFFzeomHaQ7rTz7Fs36Q1hCSntvnp06ub4hRRZAuZL75fbeNDgUe1fE
         Mws/yO6RfUvxCUNKZ/3Xyg1hdJH+rCWAG7AOuCFpjDC9Q0pL7no15stv1Cb7iUYVFPaI
         z9V5bfqH78P1qm/+Rej7JdxJEw8gF8nevQS0rK+cDeM4pW2q0NDWR9bKXfOoJAr81Q70
         RcAQ==
X-Gm-Message-State: AGi0PuZLSNz7qcsr24XhtlMct2PMaF2gzvlpFbMdvMMSpsBOfQlHhfHp
        TW32jin2SEXq0hdTXyVK8lzEkp79vJdG
X-Google-Smtp-Source: APiQypKOjaO6fI6votAtJkqNtpxhTPzscSvTlH8sv81/G65sdjlnWRsXh9hMb8MSR2pcQmAAjFHFfSeqH1EV
X-Received: by 2002:a25:cf50:: with SMTP id f77mr1986942ybg.19.1588916202354;
 Thu, 07 May 2020 22:36:42 -0700 (PDT)
Date:   Thu,  7 May 2020 22:36:20 -0700
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Message-Id: <20200508053629.210324-6-irogers@google.com>
Mime-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [RFC PATCH v3 05/14] perf expr: fix memory leaks in bison
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
        Vince Weaver <vincent.weaver@maine.edu>,
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
2.26.2.645.ge9eca65c58-goog

