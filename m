Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05DF2305DF
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgG1I5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgG1I5i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11C4C0619D2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t7so11009740pjl.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zApPOTJ5w6WkPmUvx5vPVowaf73ni3+MSfyTlKnuOkc=;
        b=qVPctGuH/HG4+XTA7hvFME+borLjNB7Wi/258LIlYdJxDTcrRABI2np+69GhB8L0nO
         6vpVGcpyvsaEXO0pk7Fz4v+exN7394Kc0Z2069OsX3fa6PS79AKb6XD+Detd9Ee0geGM
         a4d6fEFc0dNgSKuqnBCDaM4VKS0f5jhUhv2/zzhq5/ANb2fgfsSjfe+kQ6rMFfrBcyDu
         xuAHW7+j1UPNSZ+B9zGEDfrqi9COIwp9srOyW25eelrqDW3ZwQzN7n8OLgoOPqdiCRdW
         EmCbkMIj3d8F92W9duND0KeSxxX4WjS5aVSb/vCt7u+3vO+4EvqeZXMPKnd0zvTh+fDj
         ozXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zApPOTJ5w6WkPmUvx5vPVowaf73ni3+MSfyTlKnuOkc=;
        b=J5FJbwfy6/yL6RUSZ9O5zD7S0nztwFhX4O/ITmaJs8ZweaRKCAqzapp8xoDcGaOR7G
         eN2ypzw3/ieOL4VUFyt6wmpWI5hwfqtraKqdfKfyxg0N6w7TlERocR4mkWsqBY7JkSrn
         prI14056VAVNketUlK9BL+EvP3W+3F22aHpv3pcZybAxJgDRzAaiiOooLvbpH/Bo4rUk
         /DF8BYsMk0YiCwBDRyop6CH/YRi8MEbdBs9V/uMJLRMg9hAodqx4IAI3JK2V3Zl2d5G2
         mBZBUWHBEPQXVm4f8H6qtruyp7QHZskMnRIp+M+YvLS1dR7PA9l/6HYSHYrwXZUCx79S
         ZTxg==
X-Gm-Message-State: AOAM532Ig4v5gXW0WH9P1R6J7SQcugUn57Yt6pMfbpu8xJZg0ur42TBw
        1Grww1uvLdnBmK7GrdZM1Nxl8EJmMVPP
X-Google-Smtp-Source: ABdhPJzp83NiP8b/o4uH19SGyysIaVwxKeYF+HyDxcxZ8xc1fksLiuPjHA+FG6eQYmGTOsc3580CmkQI7IKw
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr3542331pjb.147.1595926658191;
 Tue, 28 Jul 2020 01:57:38 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:30 -0700
In-Reply-To: <20200728085734.609930-1-irogers@google.com>
Message-Id: <20200728085734.609930-2-irogers@google.com>
Mime-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 1/5] perf record: Set PERF_RECORD_PERIOD if attr->freq is set.
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        David Sharp <dhsharp@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Sharp <dhsharp@google.com>

evsel__config() would only set PERF_RECORD_PERIOD if it set attr->freq
from perf record options. When it is set by libpfm events, it would not
get set. This changes evsel__config to see if attr->freq is set outside of
whether or not it changes attr->freq itself.

Signed-off-by: David Sharp <dhsharp@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef802f6d40c1..811f538f7d77 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -979,13 +979,18 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
 				     opts->user_interval != ULLONG_MAX)) {
 		if (opts->freq) {
-			evsel__set_sample_bit(evsel, PERIOD);
 			attr->freq		= 1;
 			attr->sample_freq	= opts->freq;
 		} else {
 			attr->sample_period = opts->default_interval;
 		}
 	}
+	/*
+	 * If attr->freq was set (here or earlier), ask for period
+	 * to be sampled.
+	 */
+	if (attr->freq)
+		evsel__set_sample_bit(evsel, PERIOD);
 
 	if (opts->no_samples)
 		attr->sample_freq = 0;
-- 
2.28.0.163.g6104cc2f0b6-goog

