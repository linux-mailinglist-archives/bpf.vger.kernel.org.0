Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E565E6D8
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjAEI1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 03:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjAEI0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 03:26:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574174C705
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 00:26:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a259006000000b00706c8bfd130so36239521ybl.11
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 00:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7v/gEXdtTx+UxkZcAUgCVgz4MqYf6krsrfnmQSxx5Nk=;
        b=MOmoDn853XiABNLgzeFY1zINcWjdyYDZgMjA+UzzOZtj9lI8m9iFChZ8xKfl5yhu7m
         GgQ4eeoUjNQwcCp66d6+VkJLXk5f1vbaPSLFAy/6UxTPSUznUMcPxKpfnw2XsTl8fgsi
         bkDwzfeHUylhi+VwwPOZh1rvzAuP2xf/p0aBbDEckSzuITvMJZGzno5h8Cz8WLU90KIv
         95qcS0l7viSe07zEj+JjfkIKsgR4APZLrfGfEpD0xTWlxPrztm2446P9poO+EtTxj4Us
         ChabmwB0Gr7DT0OlsTqIhWL1e6E1yn5yVkl+xeuXIf4/TFzX/r0cfmm5xtQi6gbpnaLo
         ECOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7v/gEXdtTx+UxkZcAUgCVgz4MqYf6krsrfnmQSxx5Nk=;
        b=0uEfo2IJAwIC5nyzPByeOHIsyr25iylWbmt/quPWZp68+EWUVUKalQLub64Tulz2aG
         vxJSLBaRtQUPu54DZjCGyx+s9V2SQeSn2vZF4OBwr6ZxznDfr1Qq8eW/W7A4Syc+xQks
         uPbXqPkAaii3Mdf3Rh9WufWMDSWc1CHbC163/Wxcy8R7xabpjwO0W4l1Z9srb5n71P9x
         /7qbE5/Dv5+48Va2XC632cyzHErFv0mQkmSCcfXOu/t2PDMqAHyWT/H3IYVLycGY89HG
         KRJLVqhAvm34zGJYKAWC+pQMI6W0fwNEXSJkZXUKZy7hWyFCKhXDne7pYnK//I8YX0m0
         lZlQ==
X-Gm-Message-State: AFqh2koBLBXSYbWyn0oo0TvpasWa07GTiwT0rcEvci0lUJRlqMcHtDUy
        mXMrOMpdwgYigYaea4SL0T7KrQDAzt6p
X-Google-Smtp-Source: AMrXdXuewYyrwXwhMLNamHCQBtT1ApP5gJHM/sJsyBFYGsV/bQVTiEcy1qsCqV8yZhxZzVYytEaqhDTrPA5G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a0d:dbce:0:b0:4ad:7104:1f63 with SMTP id
 d197-20020a0ddbce000000b004ad71041f63mr1246510ywe.49.1672907206617; Thu, 05
 Jan 2023 00:26:46 -0800 (PST)
Date:   Thu,  5 Jan 2023 00:26:09 -0800
Message-Id: <20230105082609.344538-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf llvm: Fix inadvertent file creation
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The LLVM template is first echo-ed into command_out and then
command_out executed. The echo surrounds the template with double
quotes, however, the template itself may contain quotes. This is
generally innocuous but in tools/perf/tests/bpf-script-test-prologue.c
we see:
...
SEC("func=null_lseek file->f_mode offset orig")
...
where the first double quote ends the double quote of the echo, then
the > redirects output into a file called f_mode.

To avoid this inadvertent behavior substitute redirects and similar
characters to be ASCII control codes, then substitute the output in
the echo back again.

Fixes: 5eab5a7ee032 ("perf llvm: Display eBPF compiling command in debug output")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm-utils.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 650ffe336f3a..4e8e243a6e4b 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -531,14 +531,37 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 
 	pr_debug("llvm compiling command template: %s\n", template);
 
+	/*
+	 * Below, substitute control characters for values that can cause the
+	 * echo to misbehave, then substitute the values back.
+	 */
 	err = -ENOMEM;
-	if (asprintf(&command_echo, "echo -n \"%s\"", template) < 0)
+	if (asprintf(&command_echo, "echo -n \a%s\a", template) < 0)
 		goto errout;
 
+#define SWAP_CHAR(a, b) do { if (*p == a) *p = b; } while (0)
+	for (char *p = command_echo; *p; p++) {
+		SWAP_CHAR('<', '\001');
+		SWAP_CHAR('>', '\002');
+		SWAP_CHAR('"', '\003');
+		SWAP_CHAR('\'', '\004');
+		SWAP_CHAR('|', '\005');
+		SWAP_CHAR('&', '\006');
+		SWAP_CHAR('\a', '"');
+	}
 	err = read_from_pipe(command_echo, (void **) &command_out, NULL);
 	if (err)
 		goto errout;
 
+	for (char *p = command_out; *p; p++) {
+		SWAP_CHAR('\001', '<');
+		SWAP_CHAR('\002', '>');
+		SWAP_CHAR('\003', '"');
+		SWAP_CHAR('\004', '\'');
+		SWAP_CHAR('\005', '|');
+		SWAP_CHAR('\006', '&');
+	}
+#undef SWAP_CHAR
 	pr_debug("llvm compiling command : %s\n", command_out);
 
 	err = read_from_pipe(template, &obj_buf, &obj_buf_sz);
-- 
2.39.0.314.g84b9a713c41-goog

