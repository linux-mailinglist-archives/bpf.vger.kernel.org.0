Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD7631AAF
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiKUHxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiKUHxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:53:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401F18B2A
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:58 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jn7so8014320plb.13
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6Y107DNA2h9x1jFeZux4gnXIStbDXBkeJQpL1mBr6o=;
        b=C/0DTzrfe1WiC81ULqWXVG8uqC+cxWZaE46z38bg2ldaZUyDoMboRI6+YTdf7UEWM4
         Pf635lAErhsUFqKe/pFEMAURdZTLRijqz3LqQWeTUgK403nR79SGis+uf6rbYi5ex6v0
         LH03gj4MlW/af7YyhHPQxqq3CoLyy8kJNF6fakvv9eeK0V5kOnAoZZoe/a7JS8EYpMXp
         X3FQl4YKFyWRejDIg/9DYzt0S7QHhdPHyrK0t9hgbby8zrb36fN+jM9hU8d/hlzWuVKL
         tEWnB1+7t30ZkygZfvfkqb83K0EKNNyFC8yrqoa/R4xdu5xf1xjqyFs3sJke9micx/6y
         lztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6Y107DNA2h9x1jFeZux4gnXIStbDXBkeJQpL1mBr6o=;
        b=QV7r+CWcTSbUEZ1/GD+dL1G5iG8oVP3OtVoayEzv7P468g/dTGTqDwYcAM46M7Tx5K
         d97Eot2zwu76T2RJF+fNt1B/td5WTNVXZaXojdwe83WLLkkbyxlgOYfHw5pHLuF66EDB
         lloIXC7UhXsLph48Y8EV2uCQ5sLXxYcKYlfGVzc9ugR2Q93dpqOeSd/8mt1yMOifBkTY
         Xia2JMGf5zaQh4m2XecWf/f5VpYQfSz7I1bsoGe14dXY6+b5i05RGZCAHGM4wVYzgFB5
         8320Jk6TRH3i88NvICwHpWugpKhz7VIortHTw9pq90Yg8RKcCxO0Uow0J5pTRsQjywhx
         R1Bw==
X-Gm-Message-State: ANoB5pnRoxysMhW5gy4n6FzD8+0FLkuTtIofmIQNWlik8h2nax0qXz32
        s4sQqN6FD96Y5VKnxNqD3qeBHg==
X-Google-Smtp-Source: AA0mqf4heA29f+3z9aBG54hP4uqX83h4XI0cuLRu+sTd8uFpm6DZPLXxmb7YUevJpUCqZVKmIwbTZQ==
X-Received: by 2002:a17:902:c409:b0:182:bccf:619f with SMTP id k9-20020a170902c40900b00182bccf619fmr10787696plk.9.1669017177711;
        Sun, 20 Nov 2022 23:52:57 -0800 (PST)
Received: from leoy-huangpu.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm7006277pgm.74.2022.11.20.23.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:52:57 -0800 (PST)
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
Subject: [PATCH v1 3/5] perf trace: Handle failure when trace point folder is missed
Date:   Mon, 21 Nov 2022 07:52:35 +0000
Message-Id: <20221121075237.127706-4-leo.yan@linaro.org>
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

On Arm64 a case is perf tools fails to find the corresponding trace
point folder for system calls listed in the table 'syscalltbl_arm64',
e.g. the generated system call table contains "lookup_dcookie" but we
cannot find out the matched trace point folder for it.

We need to figure out if there have any issue for the generated system
call table, on the other hand, we need to handle the case when trace
point folder is missed under sysfs, this patch sets the flag
syscall::nonexistent as true and returns the error from
trace__read_syscall_info().

Another problem is for trace__syscall_info(), it returns two different
values if a system call doesn't exist: at the first time calling
trace__syscall_info() it returns NULL when the system call doesn't exist,
later if call trace__syscall_info() again for the same missed system
call, it returns pointer of syscall.  trace__syscall_info() checks the
condition 'syscalls.table[id].name == NULL', but the name will be
assigned in the first invoking even the system call is not found.

So checking system call's name in trace__syscall_info() is not the right
thing to do, this patch simply checks flag syscall::nonexistent to make
decision if a system call exists or not, finally trace__syscall_info()
returns the consistent result (NULL) if a system call doesn't existed.

Fixes: b8b1033fcaa0 ("perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bd5513b15cde..071e7598391f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1814,13 +1814,19 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 		sc->tp_format = trace_event__tp_format("syscalls", tp_name);
 	}
 
+	/*
+	 * Fails to read trace point format via sysfs node, so the trace point
+	 * doesn't exist.  Set the 'nonexistent' flag as true.
+	 */
+	if (IS_ERR(sc->tp_format)) {
+		sc->nonexistent = true;
+		return PTR_ERR(sc->tp_format);
+	}
+
 	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
 					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields))
 		return -ENOMEM;
 
-	if (IS_ERR(sc->tp_format))
-		return PTR_ERR(sc->tp_format);
-
 	sc->args = sc->tp_format->format.fields;
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
@@ -2137,11 +2143,8 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
-	if (trace->syscalls.table[id].name == NULL) {
-		if (trace->syscalls.table[id].nonexistent)
-			return NULL;
+	if (trace->syscalls.table && trace->syscalls.table[id].nonexistent)
 		goto out_cant_read;
-	}
 
 	return &trace->syscalls.table[id];
 
-- 
2.34.1

