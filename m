Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27AE5360
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbfJYSIp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 14:08:45 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55743 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbfJYSIo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:44 -0400
Received: by mail-pl1-f202.google.com with SMTP id g11so1986508plm.22
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2S2DsvKndhCCCwXhy7APxIUiBul3NbHlVg5iB3GS6wI=;
        b=S1GOx2chJq005n3l26PE/OxzhX5C+hRjXWDeFhCkywyuslxoRAeqypOqIuChfSPfUu
         NA1KhxahOriQwx+Z0BGci3W2BvxgOZ4rdrGOZxI1SKIQSknC8epGu4qXsv/k893YtYdg
         WpOhSw/4+Afdl6vLLCjgFzadtYVTPJe27sil2puX6SEQfWnaOqwv913miQpe9jhpgNVP
         IwZ+wOOqqRJZaO2uGGzu2DukYz3QSOj4FjyMPSnCsMFkongN9d6l+UzyX9w+4bZESB6O
         tq6e2DSiaqb5XaJ+mIvS6WrlxxKexhmJKDP+A/AIzZiyYL3a3f8E1zVVOEwkFpBnODLK
         Q0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2S2DsvKndhCCCwXhy7APxIUiBul3NbHlVg5iB3GS6wI=;
        b=TEq3LkDI4hg10IWwh0c91wQdYGlcWhfKt74inIsBKYf6R38GXQlEf7K5tHV7RpWxU1
         doP07XN4q4xQEA2k83wFTBf+eS11ZJgGzMGYZQjjc1WMX2f81vNhDPo1QWzy4gEUerzv
         rHw1GAFbVOPQjrgFO7Kx1pe91TifZ1hd/blGOCt47VXuh8NdMHe9/o+FFPxVEBs7Hxgf
         I+DelevL3WzfziURBBK4PnrMdJeXzUVlWNdbYY+RDpTHqfKVG4B0meXEah70uwcWxdyi
         r2jLJl+nRW9IFTmuieSP7sJYSi5VXgf5nu0B0GYUk7qUhM+itd8Nl90ENnUgbHyJOAJG
         JDmg==
X-Gm-Message-State: APjAAAXG6/SRubcE3QTvhng6+l1+oSsYM7KFkXjEg0vT6225sw4IKX5W
        NbSeflPn5bOjU96gqhpFwrvETmcKqYUT
X-Google-Smtp-Source: APXvYqwCiOCxWKogyeiMwYvwOtugEYW5dgD9xy0gca9fx0LItS/FqQFuYGbkyTwUtw9zrUcH6p/Wu4erFpVv
X-Received: by 2002:a63:e60b:: with SMTP id g11mr3770780pgh.119.1572026923546;
 Fri, 25 Oct 2019 11:08:43 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:08:21 -0700
In-Reply-To: <20191025180827.191916-1-irogers@google.com>
Message-Id: <20191025180827.191916-4-irogers@google.com>
Mime-Version: 1.0
References: <20191024190202.109403-1-irogers@google.com> <20191025180827.191916-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v4 3/9] perf tools: avoid a malloc for array events
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use realloc rather than malloc+memcpy to possibly avoid a memory
allocation when appending array elements.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 5863acb34780..ffa1a1b63796 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -689,14 +689,12 @@ array_terms ',' array_term
 	struct parse_events_array new_array;
 
 	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
-	new_array.ranges = malloc(sizeof(new_array.ranges[0]) *
-				  new_array.nr_ranges);
+	new_array.ranges = realloc($1.ranges,
+				sizeof(new_array.ranges[0]) *
+				new_array.nr_ranges);
 	ABORT_ON(!new_array.ranges);
-	memcpy(&new_array.ranges[0], $1.ranges,
-	       $1.nr_ranges * sizeof(new_array.ranges[0]));
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
-	free($1.ranges);
 	free($3.ranges);
 	$$ = new_array;
 }
-- 
2.24.0.rc0.303.g954a862665-goog

