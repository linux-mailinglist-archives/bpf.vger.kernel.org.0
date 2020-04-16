Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521811ACD8E
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442784AbgDPQV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733188AbgDPQVH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 12:21:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32EC0610D5
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 09:21:06 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id w4so3361089pjt.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k3QSq09zanfq5knFKJrjyOnoqvaU4fvmN7ei3XY39p0=;
        b=UzhNifbb77t2kPxIOe5h2V6OwBCa1u7KeMtcqkcPkXVRhkl1nGkMlT/ABsDO/4ITvX
         7O4KYePjbVagmc2hQ7j/xtUKlHeAwXFVXksjkeeeBrPfGXybWvZ/Rx2bjyW5iPlKWNb/
         D59msAcPOaGcQHUX5gDH8EAaTUuwAfmj6oHGtyXeqjLcruyPweUM5TN3mIsAGw/a+HE0
         GmBL4EbKY4V0hucEB1JqGZsyAfhnnspNPKR9V/IzJDbX7hkDSA/qylpxp+1QzDQQuPoI
         iP0H290G4LmvEfZdClc7HWN7Nebpkf88L5ho3A9pxLKo/lFJ1hPdpDGFhjIiYWhho+xV
         J+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k3QSq09zanfq5knFKJrjyOnoqvaU4fvmN7ei3XY39p0=;
        b=jkUxnkybjA0N0Zr7zWyUlKw6Ot7t0sBxLp/HgEKWmWvyXc4/7Jtn/qjoH2i2/WEtzX
         dHqTh2fbcn3PyPj3cwQRLCRDhywpt5Il5E7nltZCZaW0Bowu0rAqVhxbfUyeijMhmGIt
         yNLrp9iJXnq60bLG0H6KmjZhPmY992SJZuSqIHTLheb65hN0EKZ1SsMAmFIKr0K7pH7P
         XiPKa0OOB55gMUaDRq05juToTUUXpRwdMmDBoNw56Ei2wQfsMdV3JKxmCAnV3968gC3U
         aFeyzrviRZngkKkx6Vm/Y97MPCWluBbgIrO6cwM7fGRs1+/LIiFCQiTOJjHXTa0qVryA
         U1Ug==
X-Gm-Message-State: AGi0PuZxBP1qmFk81CCELtdAbfQrO/aNEeRwOpwDzlMGu5SNwEn6kSRu
        t3vVkvVEB3rAsdhbBwAwpstx5UfNNFZn
X-Google-Smtp-Source: APiQypLhs9XROYXNcpvjGVHUmUynnZRHW/PXhtVi1TmAZoN3NUmY+pas6oCPFDiJuNmYVx4+hDre2vk3/Z00
X-Received: by 2002:a63:4d5e:: with SMTP id n30mr25221209pgl.154.1587054065331;
 Thu, 16 Apr 2020 09:21:05 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:20:55 -0700
In-Reply-To: <20200416162058.201954-1-irogers@google.com>
Message-Id: <20200416162058.201954-2-irogers@google.com>
Mime-Version: 1.0
References: <20200416162058.201954-1-irogers@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v10 1/4] perf doc: allow ASCIIDOC_EXTRA to be an argument
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

