Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A317A1C8E13
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGOLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgEGOI2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7811C05BD0B
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i2so6727716ybg.17
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=agpNpPb9ABPgrcjzE8UbvUM5oHf8Sq5TEvUJcEJ/6IE=;
        b=HhhT+08K3dom3gSLbiMkAIr7jNEs49Fw2OajOhbnL5wIg5CUFHIYBQ9EtWdbUNEDG6
         R0zI6+Jrakz3Qpp9wkCrm8q3A5+C+RtcOZaD0fvTcsL03G6O3B58p50n1Gxi4JkhPWZJ
         mkEyf8DOSTA7lyGsbVcG6T2jv7m1JhdqrwuWygpbowcTaSVvPjeExQK7r0pKMdDmupcM
         mg0QYgFfTEkih4qS7g/sTAG/KpeOTLKAO+d/doYvjC/7wOIowP9Gw52bDgBdJ0SGNPxK
         Nx8z7l67LaHUwTNB3IQax3Aom5B6VouckVz50bQUK1b5SbJ1y7UKTgFAA3q6d6z7leO3
         l8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=agpNpPb9ABPgrcjzE8UbvUM5oHf8Sq5TEvUJcEJ/6IE=;
        b=JXlgdBZMirjv+dMRnpQlC7QmGmx9goo2F3+055ltenbIJDhKiPzATD3y1J2WjRWDI1
         HjEAe+DSlAOE46+mixKgHTPvmeSTOM4U4FwTnOdi6T+fN3VRM23ZacZ4O5m3dHfUauZf
         3FEsn5Cx+uQaV5xyzT42nDf+6Vkf3t/nhwrqhyZup5j3D5jmHDys8IG5y3jBl5IcI6wA
         +SKhCE+o/9nCgxN9PjXEfnSUgp6X57mIGyVsBvWvkEl1+Ln8iTTreOvLoRtL5xnj9T8S
         9OTeVWWxXdxfiZfVhUlbm/v0w54LVZgCUfv5GBCEaH2Huhlj6iVYyiQovngcmhYD33XR
         m3wA==
X-Gm-Message-State: AGi0PubYRflLmWhENfUf7WTu1qhYq4EJbZSMHjT84NIM62S7JOVZYy9z
        jQh8MI3551WPAZphRffY2TB+m8J5IFJy
X-Google-Smtp-Source: APiQypLjOQdMt93cGSI2VfMH/6fdTqBneltg7x63mwDbaxdlMbnq6lIa4ij95nm/4y6+WbNHSut8TMssroOr
X-Received: by 2002:a25:be81:: with SMTP id i1mr22413804ybk.184.1588860505757;
 Thu, 07 May 2020 07:08:25 -0700 (PDT)
Date:   Thu,  7 May 2020 07:07:57 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-2-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 01/23] perf expr: unlimited escaped characters in a symbol
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

Current expression allows 2 escaped '-,=' characters. However, some
metrics require more, for example Haswell DRAM_BW_Use.

Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 74b9b59b1aa5..73db6a9ef97e 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -86,7 +86,7 @@ number		[0-9]+
 sch		[-,=]
 spec		\\{sch}
 sym		[0-9a-zA-Z_\.:@?]+
-symbol		{spec}*{sym}*{spec}*{sym}*{spec}*{sym}
+symbol		({spec}|{sym})+
 
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
-- 
2.26.2.526.g744177e7f7-goog

