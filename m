Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC653631AAD
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiKUHxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiKUHw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:52:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B231572B
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:54 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d192so10656437pfd.0
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvc1zXEGR7HMHrwAlmwh9iePoKt7remHUDBQE6tcKek=;
        b=fuRSF+oqTR6nicfjS6pFRenl0ln+tt5LxFA9pJwpIX9ZXcBuWJc1wmJU+1c8s8szwo
         Hu82FRt4aTLXN9hxyqyRQltl4dGqabZuZ1GFHZHk0vTbps5p8eP8bMrPzS9yKKLe+P+h
         /PWW2gHcTnRgislEbqElp38G+hdl8iN+Nqmmn/ZvRVzpHhklh5UeAqmT00xQwnBXFDik
         hqQhA0gpN7VDwK5EjADucMgGg5qaz9NAG9Vyyq41VkagnbG42V7jeaMPREtIbh/ssMm2
         tVj1m0yXMBFJjxg56NKU/aPkshDlrpFep/WAbE5l+6I4D6A9FEFKmtKzQFzb7OXoO/K2
         CgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pvc1zXEGR7HMHrwAlmwh9iePoKt7remHUDBQE6tcKek=;
        b=zvzG9zeWMDPQX2LfRy6KGFRs5mEoyQm3Y0R+rkeElCoEtlz1OTaYpm3fKfwIW/aANV
         GypW9/drWX7+8AUiWUNyv09sth7qEtuETss0vUGtI2U8FD41JpTGiJAsv5cRETqCpbxZ
         ijK+G0+mAN/MDNmccH01oTc/yZOlpOLwg7K/0A/QxgpXPrF0oGaJk3BqCzn6Zphw35V1
         qLuHnBsaF3FvEoGODLwj8/JqJ5s9U/EhtO4HMYYSAvVGVzjPK6aB13iE2kgBfYZdp3zI
         FQ8QPlGjt7K0F749c0cx11zc3dWtzICvWIEQYy7ksVA+m+BtslgjS5LWG15eoPfO5bgT
         /0Hw==
X-Gm-Message-State: ANoB5pnuRLkqVpxYKhGl1AllMxPqko8/kHhc+Lpo/mXx8EZJqbYbBdHV
        uFksyU6P1voqBQK7i+8pAHA5lQ==
X-Google-Smtp-Source: AA0mqf4OXTlL17MY78jk8BhLknp/yfI7A9CcaXWqLY2AJZ5xBCpHvmbFiFQEA5vJ3nGAlPnv+Ij9eg==
X-Received: by 2002:a62:542:0:b0:56c:45db:4481 with SMTP id 63-20020a620542000000b0056c45db4481mr18882213pff.86.1669017173582;
        Sun, 20 Nov 2022 23:52:53 -0800 (PST)
Received: from leoy-huangpu.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm7006277pgm.74.2022.11.20.23.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:52:53 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/5] perf trace: Return error if a system call doesn't exist
Date:   Mon, 21 Nov 2022 07:52:34 +0000
Message-Id: <20221121075237.127706-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121075237.127706-1-leo.yan@linaro.org>
References: <20221121075237.127706-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a system call is not detected, the reason is either because the
system call ID is out of scope or failure to find the corresponding path
in the sysfs, trace__read_syscall_info() returns zero.  Finally, without
returning an error value it introduces confusion for the caller.

This patch lets the function trace__read_syscall_info() to return
-EEXIST when a system call doesn't exist.

Fixes: b8b1033fcaa0 ("perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 22008a31684b..bd5513b15cde 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1796,11 +1796,11 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 #endif
 	sc = trace->syscalls.table + id;
 	if (sc->nonexistent)
-		return 0;
+		return -EEXIST;
 
 	if (name == NULL) {
 		sc->nonexistent = true;
-		return 0;
+		return -EEXIST;
 	}
 
 	sc->name = name;
-- 
2.34.1

