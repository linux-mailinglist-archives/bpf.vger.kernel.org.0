Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A36664EB7
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 23:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjAJWWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 17:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjAJWWJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 17:22:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A02020
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:21:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso14341446ybp.20
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FtIYr0/RheXwrssHV0cFATW8LMtUvVk/N1uI6ptIqc=;
        b=RNYP627ovo2gwEzsZZbFylrtQb+tRstmx8+kwVlpER/K5C5tNb2oBe50zVPZpE1xuZ
         NU9zXXblOxx6EAKLVYDrvaw3SP0ZyRrbegvCU8UFWhy7tdpYKJsjdqHS8Q8fCYTB2AA1
         XfxIcjNfCJVewHShT9ogfUdkxa5rGgTTPcO795wa5pyopE3PY7OwUHSfWNK2py18qEHb
         lU9rAZ5slO3ij3YjOrOQ5FnhJPYOoz0FdvRAzlSJcgOtT3Q85Tvra/8+nQofX8xCCpMS
         FEo/8EYdWVgxNvEjlwcyYar4md8dE1bKiVeg7zyJe6xTPO25BRQ85Hz4YMsQr4Ew/YJj
         ifFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FtIYr0/RheXwrssHV0cFATW8LMtUvVk/N1uI6ptIqc=;
        b=0bnM8FPuAs2xt4a7097ukaguJY5j/3inWe4iCH0Hfgh3Y2htse6wmyFBh2i/DKeCjg
         CFlgOPJtQbQ5Q0e70ahplgPTrEaMse9Yxg+9HfHyz3revrLOKROYw0Es5yFJDUWTrbfd
         tQC54VNM5W755ZoQeoqRxyGVW3PkFkhnauj0ojQ4DWy7yo5Ep1kUTVB1x8RBGh7mEvXw
         k9HMAnt05YGA4cGvOqi7TkybFsZ20yP6CHT65lSeB30WfxpyFK2CQk+6C9qA7IYO8x10
         eH7fEGF26nv7EerkSZVOM8xEW0qammLvD9A9Wv2EJbs+jgHhp28yY7P3tXoTnm3NvmpO
         UJ4Q==
X-Gm-Message-State: AFqh2kpvjbGio1eEZKpcNG0NSQtpIo8/Cwbb7xx9NZyAnNPf0fOE4yLH
        p5I6Ihfu+V04W4K0/HZzg73sbJx2oduc
X-Google-Smtp-Source: AMrXdXt8x+kd9UlLPbZYhu5Ooy9hNfxVHcOZmgh4OR3ywtB1lSBt3xtVEtTcEV9ZxG+DMlVpkAwMcWwdvcU8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:8110:0:b0:6f6:ec71:8ede with SMTP id
 o16-20020a258110000000b006f6ec718edemr5909003ybk.422.1673389272586; Tue, 10
 Jan 2023 14:21:12 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:20:02 -0800
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
Message-Id: <20230110222003.1591436-7-irogers@google.com>
Mime-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 6/7] perf help: Use run_command_strbuf
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
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove boiler plate by using library routine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-help.c | 47 ++++++++++++---------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 8874e1e0335b..1cb87358cd20 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -70,46 +70,27 @@ static const char *get_man_viewer_info(const char *name)
 static int check_emacsclient_version(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
-	struct child_process ec_process;
-	const char *argv_ec[] = { "emacsclient", "--version", NULL };
-	int version;
 	int ret = -1;
 
-	/* emacsclient prints its version number on stderr */
-	memset(&ec_process, 0, sizeof(ec_process));
-	ec_process.argv = argv_ec;
-	ec_process.err = -1;
-	ec_process.stdout_to_stderr = 1;
-	if (start_command(&ec_process)) {
-		fprintf(stderr, "Failed to start emacsclient.\n");
-		return -1;
-	}
-	if (strbuf_read(&buffer, ec_process.err, 20) < 0) {
-		fprintf(stderr, "Failed to read emacsclient version\n");
-		goto out;
-	}
-	close(ec_process.err);
-
 	/*
-	 * Don't bother checking return value, because "emacsclient --version"
-	 * seems to always exits with code 1.
+	 * emacsclient may print its version number on stderr. Don't bother
+	 * checking return value, because some "emacsclient --version" commands
+	 * seem to always exits with code 1.
 	 */
-	finish_command(&ec_process);
+	run_command_strbuf("emacsclient --version 2>&1", &buffer);
 
-	if (!strstarts(buffer.buf, "emacsclient")) {
+	if (!strstarts(buffer.buf, "emacsclient"))
 		fprintf(stderr, "Failed to parse emacsclient version.\n");
-		goto out;
-	}
-
-	version = atoi(buffer.buf + strlen("emacsclient"));
+	else {
+		int version = atoi(buffer.buf + strlen("emacsclient"));
 
-	if (version < 22) {
-		fprintf(stderr,
-			"emacsclient version '%d' too old (< 22).\n",
-			version);
-	} else
-		ret = 0;
-out:
+		if (version < 22) {
+			fprintf(stderr,
+				"emacsclient version '%d' too old (< 22).\n",
+				version);
+		} else
+			ret = 0;
+	}
 	strbuf_release(&buffer);
 	return ret;
 }
-- 
2.39.0.314.g84b9a713c41-goog

