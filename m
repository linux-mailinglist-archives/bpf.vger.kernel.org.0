Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB81A4EB9
	for <lists+bpf@lfdr.de>; Sat, 11 Apr 2020 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDKHqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 03:46:44 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:39934 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKHqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Apr 2020 03:46:40 -0400
Received: by mail-pj1-f73.google.com with SMTP id q19so4021078pjp.4
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2020 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=pya11oqHarWpTYxwODdIqynYlkaLXmV1d2hppdiQFs9jE6GP9TqhqSgm/lEo2W6DHM
         knMfT1/EgHvAaF1emcvZmVo1YPOqMSDuOV7qy0oT+DN0TcJVCZYBTH1yr0wrCMhsOEWE
         5ViRQrvG4OCyuFCcjLQVS3pPdIbIutnpF85lGMhdwdf/qPDyZBp770gFEhgDQFQgbj9/
         p4L9mrt6DkABIuHUKgpbobu+UvR+gi1cQ8Hks6yT6qbu4sSQqWn84+UNHwr5rX1gs82h
         fg5+rSn5kv2QTvw7F7AbVlAdqHTJKSVwWqX9KO5VpgImc4OOqL8KtHqK2RrVVXl/TAHJ
         0YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=hZd3jnuxcRXiEezKk19GI6oQlQGkh6rxJZz0bn87nIOqOiwwVxSV19ZggRtv/tpwkM
         xazGG71kOq5tBOLvKtp6CGGA+wu4cBQ2y5vYI/L7UhxUE7BotV96+5yBeU2c4bGHlvV+
         Y2BJgRaP5ejlByAlJd0KeVWvRFUjz2fdBx3v0gx2nfw7fXiDpToi6eLxpyec6jPhB4we
         C9C0Qb6JUxXy2LYk1Tw3QNX/jdzmGcBXwXlNILFtJCHwxTP003tZi/dQ3aNBRTEEsLlR
         d8DeRad3CmKbinx0Eufo2ignpCHZHqplky7mW6qWPH09PFq0vkFAmNJZg/4/hBzQn4gS
         wUVg==
X-Gm-Message-State: AGi0PuYB/iEvgBmStREHUfoSRrV39V3wl1wlMRYvL7wxQaUZ6faZRTjz
        ftYKuSwXbAhcdqcIk8ikf8t7XEnGaigi
X-Google-Smtp-Source: APiQypI2tVneneaPlqGAZNeLD+mCjhAGq9/MeUYtcKI6K3wWh2sJQjynMkhC31Mp5LE7kIZGknMpCbu7ffPK
X-Received: by 2002:a17:90a:fd90:: with SMTP id cx16mr9878027pjb.41.1586591198310;
 Sat, 11 Apr 2020 00:46:38 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:46:28 -0700
In-Reply-To: <20200411074631.9486-1-irogers@google.com>
Message-Id: <20200411074631.9486-2-irogers@google.com>
Mime-Version: 1.0
References: <20200411074631.9486-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v8 1/4] perf doc: allow ASCIIDOC_EXTRA to be an argument
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

This will allow parent makefiles to pass values to asciidoc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 31824d5269cc..6e54979c2124 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -48,7 +48,7 @@ man5dir=$(mandir)/man5
 man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
-ASCIIDOC_EXTRA = --unsafe -f asciidoc.conf
+ASCIIDOC_EXTRA += --unsafe -f asciidoc.conf
 ASCIIDOC_HTML = xhtml11
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
@@ -59,7 +59,7 @@ HTML_REF = origin/html
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
-ASCIIDOC_EXTRA = -a compat-mode
+ASCIIDOC_EXTRA += -a compat-mode
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -a mansource="perf" -a manmanual="perf Manual"
 ASCIIDOC_HTML = xhtml5
-- 
2.26.0.110.g2183baf09c-goog

