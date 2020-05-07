Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A426A1C8DE6
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgEGOJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgEGOJF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:09:05 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C18C05BD11
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:09:02 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n22so6870853qtp.15
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=laqIw2e8BtvC1AZBZIJa3w6PXohYXYOFdU6fqXlT6Ys=;
        b=miBj/YIZb4vpsSE1/V9tBy6cLysoVgKXoFWYcyYaRWm4OIjL9K7HI/bGFFac91Tp/n
         pplrXvFOyiiR256qko5qYm2yorUSsGtofcmxctwS0GsOuc6hoC7qytjb+wWUBdAPbUrR
         CoEm2olP4Ok49af7mbZ9FR9vY9p97g/m7FtTv6lcp0gAhZaPpBtfhgNmhGG+gr67vhpj
         P1xMFAmziZrCUi6Xz2paj+iNbpwoanrRzNsN4xtUCFcPiZVK7CymmbyofRAZnu86k9PI
         SEs+g+4YnQ9u0ffwgnQVC/gvYzxXtx6xSdtexJwxu/K/U1AIAwBTJJw+Qyi6UQro/Dy8
         3KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=laqIw2e8BtvC1AZBZIJa3w6PXohYXYOFdU6fqXlT6Ys=;
        b=UEi1YNmYQ3bHK+lOzsGO1NDgrM1QMqrhCI9tORJl1gw7IC5SHCZGaFzbOFUflfT0eQ
         cTYHqTSdA+ffj4V+LEzG5iFkgesXUsIecE4Kmd0LEURzVZd/yIwYmlm5aiY0J5Q6sHNl
         p83ByHtPTcMmod9by9GUy0FfJvFP0Wz9KZUE2C82It98UHzoRJ2nH5290jdx+VwTYAgC
         WEOOSdrqK1c+sex/Qkt6qulk4IFf+1pZPvklyb7UuV3j6vTSZPJoWZ9eBpzMTBHrIYC4
         fG2nGNMwbQYi18jRctMQ43GeAgygOKwBu17FSKbuYkqpzNoucKDzYiaGyzf9rm/N7z1S
         nCww==
X-Gm-Message-State: AGi0PuayS8dPSwzRpSBJDX+q/i31nUak5+PVIzwpU+t1KpzKPnnfmaZl
        uwOg0JcRhdV3n6n4L70TWqtataIPHy2X
X-Google-Smtp-Source: APiQypLmp6adcf0chrItrXAQRLlppnA7+FX/ggfFhId7fASLcB078wZgh5xIbvEFlCQCONBRm+74fwfq+Jaw
X-Received: by 2002:a0c:da8c:: with SMTP id z12mr13470165qvj.143.1588860541291;
 Thu, 07 May 2020 07:09:01 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:15 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-20-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 19/23] perf metricgroup: free metric_events on error
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

Avoid a simple memory leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index dcd175c05872..2356dda92a07 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -185,6 +185,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);
+			free(metric_events);
 			continue;
 		}
 		for (i = 0; metric_events[i]; i++)
@@ -192,11 +193,13 @@ static int metricgroup__setup_events(struct list_head *groups,
 		me = metricgroup__lookup(metric_events_list, evsel, true);
 		if (!me) {
 			ret = -ENOMEM;
+			free(metric_events);
 			break;
 		}
 		expr = malloc(sizeof(struct metric_expr));
 		if (!expr) {
 			ret = -ENOMEM;
+			free(metric_events);
 			break;
 		}
 		expr->metric_expr = eg->metric_expr;
-- 
2.26.2.526.g744177e7f7-goog

