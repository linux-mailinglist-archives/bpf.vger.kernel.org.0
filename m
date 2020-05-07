Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B3A1C8E0C
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgEGOLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgEGOIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD71C05BD14
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j4so7095854ybj.20
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GWDC0G8zdjTIbAQzpkGDW81gGtVpMcQxDDRhUTLRxU0=;
        b=T+1cogAdt0n02y2jqAw41O7Bk8sA6Jf4XCUnSnfYTBqJpIsyU0WPefin2OHEYEI45+
         o/9MwEtPsPJij1EYwHb1Lu6klSvi1+2btmPp5Ql/wWGp19O3NlKU7TSIkwmuGqBOL2Dn
         4T1wiNVGZMtse46TlnA6Ttll0Y+62fIP56uQf2SHjBwiNJN0+lhDje6RkrStlgw9LQKE
         Y2uI5QbbVPhjZdrByM8NFg5XmnCFHEJ1IsE1jXijiawuSM12PXK7NX1qZXkjkT56AHI1
         Ww14oU9XSVVgUMowvbNPuKsoLtk+yG/x2N+kV99JnUuam+xo5AS/q8puh7fFXrMmaZtq
         Pqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GWDC0G8zdjTIbAQzpkGDW81gGtVpMcQxDDRhUTLRxU0=;
        b=nMQ8dsB9r4+86slcXPQvkn1EQGMSsPJezaAH4gNRYbbtAMak861UP64WVEgjBFewld
         hk5LcQG/m/cGuboCMmSdYlFfOGADVba9TunKlOjOtb2T14Zv9Sbc+B4NnjJMjaMh9Rr1
         nXDijUz+6jtbsvuOzxIp6jez2nAJA1L0FC3DzPs9hkKClOA9Ewy/Be6magsE44DK2ZA5
         QBnc/nhUoimxpFrv69qBG1On28HXnXjpz7J1nc1+pFgou3mBbsNc2CSP9KaxcFqpRn9h
         IBn4jLcGfmXnywO5eIsJrHJDAH4ieMUkywwCd5I0VFyTM4aGkzBRy4GmasoZm32NdeAi
         G8dQ==
X-Gm-Message-State: AGi0PuZebqonPeGXaDbaFyTTWVAgPsSceUJRzImRTdF8G+C9QPonY5SH
        WSwjVXdZhxl9KVdR1oIsPH7rdaXHI3Ws
X-Google-Smtp-Source: APiQypII+pofeMePrCdwL9H6ly5MPDNyJmaXpPXlFjcDcOFl0KGQPvb58+bFjzlM4Dr5VpZbynepihaloLfR
X-Received: by 2002:a25:7dc6:: with SMTP id y189mr22247645ybc.218.1588860511591;
 Thu, 07 May 2020 07:08:31 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:00 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-5-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 04/23] perf expr: allow ',' to be an other token
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

Corrects parse errors in expr__find_other of expressions with min.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index cd17486c1c5d..54260094b947 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -80,7 +80,7 @@ other: ID
 	ctx->ids[ctx->num_ids++].name = $1;
 }
 |
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')'
+MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
 
 
 all_expr: if_expr			{ *final_val = $1; }
-- 
2.26.2.526.g744177e7f7-goog

