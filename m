Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B57C1AD2B3
	for <lists+bpf@lfdr.de>; Fri, 17 Apr 2020 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgDPWPu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 18:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729211AbgDPWPK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 18:15:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF6C061BD3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 15:15:07 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id np3so313025pjb.7
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 15:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k3QSq09zanfq5knFKJrjyOnoqvaU4fvmN7ei3XY39p0=;
        b=ij9XEvT3aXr6l5eyUvBkNPOYhjEfzqKviY5SwFPCtHDKHZrLLA6FVEkPFGhwlTos4g
         uWFWTbM0hDJv3km7dJ8bnRS8pWWxqvKkcQT1ssYjFn6WIFUXWTqOcHbdxKI4JlSN9s+b
         8hPVKXQwgj0OeGLepYScqYQdGiwPFpem1ZpyBbqs+IckK2Svkvw7xXkYAtLbn/9ek+PS
         VRiPOYxWQdsEDYCanWZWyZBgT/f3hnSsyksguMuDPV/PHpPpN90SsCjnqbh9kIp7yYV9
         2p20StG8AkCebRvVKg1T3c2XuirtxWIKDUwpTSxjUOYk38CrF/YBMfNAZWDcUVh3PxxJ
         ITGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k3QSq09zanfq5knFKJrjyOnoqvaU4fvmN7ei3XY39p0=;
        b=j47mZrl0s/KIFwex5tHN1la5hEIsPIlII/tIqJEUUsaAivR9NPt7zGotuooC86DKFq
         hO6Tv038b24x8CclhYhAHNCTMWRay8NGbFPrdgcoLM+Rb+r8oQpNpflcNG0aLu7/KLzS
         YrAYXilyC5mq/tPehkkZnzYflCIy2/QzOY7deiNHl1gNiCKvuSKApaCUZnTRQObSTsKB
         4ZwzZ2hqUw0/JwWQAnFRYoTphYO4JWGDtFyHLTozUDIGxZiEn6u1g3K+Cl11pDpVylfE
         C/XbxassFIzXQvSP3lUpfYSLYFe6o8ZhHwEoVOexc68qg+i6BZVrb1o4FP/2iKEH7Wck
         uvbw==
X-Gm-Message-State: AGi0PuaXutEtekZecy0zJmc5hWMf/AYLNWAwxfIAyEAlDvfBkF5eFVFB
        JzoyLnYGbAuyEBFto/UbBhoPSrG18H7S
X-Google-Smtp-Source: APiQypIbzfPbmBqTxVmavYGmc61I3o/ZWDrXaFgye3NwXk4/QJrwHtqk6G6vmzEXg1H/MjcQgaIguXjCfNCN
X-Received: by 2002:a17:90a:a796:: with SMTP id f22mr593806pjq.134.1587075307009;
 Thu, 16 Apr 2020 15:15:07 -0700 (PDT)
Date:   Thu, 16 Apr 2020 15:14:54 -0700
In-Reply-To: <20200416221457.46710-1-irogers@google.com>
Message-Id: <20200416221457.46710-2-irogers@google.com>
Mime-Version: 1.0
References: <20200416221457.46710-1-irogers@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 1/4] perf doc: allow ASCIIDOC_EXTRA to be an argument
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
2.26.1.301.g55bc3eb7cb9-goog

