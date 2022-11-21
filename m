Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA3631AAB
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKUHxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKUHwv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:52:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A0FCE5
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:50 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b62so10480158pgc.0
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrdNyxmUm7/OayqjPE/oVvrwFtOOqyIl/5p9OFU6Fr0=;
        b=wBPQtACIGMRQsLzX5Ws93cxwnKmhVj2dH6vEvL+TNjBZDoDwssZA7uu1BLzXIx6eYP
         RTaocauylMpuPsr4c3/sA3yQZrEucPI16eXN3jlWPzI4BIALq12/mQzJKdPs1cbTVkig
         7kNh8Fms7yQu1xYBkPuDNatC/92hoz+IIiFILeRWbxSGWeJgR1v/zwNi2WfJ3Khs3Ym5
         +cpK8IIzUD4tiK1xNAaZq7tCw7GGXfUsZwTToIuVEI6CjRJJfhz1fmKXcAyLYA9fi8fK
         2L3/yXsmz8mTx+vx/IaZbuU2owjVBi3A0L3McfcGzPQsv8uEgFGWH0DSQpPE2SMJ3kwf
         Yl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrdNyxmUm7/OayqjPE/oVvrwFtOOqyIl/5p9OFU6Fr0=;
        b=8C1TD+Ju+ZudoAzysXvKJfzIefRETIyi3ddJwNabpzKh/bgLlwYEaXvBEVvT+XuZYS
         jU16YEkoK6P04VKBcQBIHiqabMyGOmENjVb+cXR/7Qu/48gtXlSUJ/rwEF6KYga9NHmx
         2xlxZqcTX1xGYMid5eplmKDOWBuy7nFKMp19CEvVKU/XLg7qk49uZYGU8LIc5PBaSspX
         FChC5Qic+4ZOIoyaEf4eoXrWshaadPY5CCGcLsDCCewD1tdVfB3NxCy9TiSPTJmGJxcp
         92B7OeW+2GNsEjW3J6n38eWo7TIoQroZfHW2/D/BLp1DQRQkP62PL2YU8RYzxE/KkpMK
         tFoQ==
X-Gm-Message-State: ANoB5plOFfZb/jx9whlKaMOOCJfnbU3coDSiyqLv8KaoSk4Wc32QAxZ7
        480DB1S0XKlaQDdJj0pjWsocqw==
X-Google-Smtp-Source: AA0mqf7ssZ3/XYk4nyVkHfrpaMxtbI8X4/OIUEO94ZfPqyrSioHxfy8AcjHOdcE8IV1JZC+7khrzcg==
X-Received: by 2002:a63:f808:0:b0:426:9c23:97da with SMTP id n8-20020a63f808000000b004269c2397damr17469280pgh.2.1669017169852;
        Sun, 20 Nov 2022 23:52:49 -0800 (PST)
Received: from leoy-huangpu.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm7006277pgm.74.2022.11.20.23.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:52:49 -0800 (PST)
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
Subject: [PATCH v1 1/5] perf trace: Use macro RAW_SYSCALL_ARGS_NUM to replace number
Date:   Mon, 21 Nov 2022 07:52:33 +0000
Message-Id: <20221121075237.127706-2-leo.yan@linaro.org>
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

This patch defines a macro RAW_SYSCALL_ARGS_NUM to replace the open
coded number '6'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3257da5cad23..22008a31684b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -88,6 +88,8 @@
 # define F_LINUX_SPECIFIC_BASE	1024
 #endif
 
+#define RAW_SYSCALL_ARGS_NUM	6
+
 /*
  * strtoul: Go from a string to a value, i.e. for msr: MSR_FS_BASE to 0xc0000100
  */
@@ -108,7 +110,7 @@ struct syscall_fmt {
 		const char *sys_enter,
 			   *sys_exit;
 	}	   bpf_prog_name;
-	struct syscall_arg_fmt arg[6];
+	struct syscall_arg_fmt arg[RAW_SYSCALL_ARGS_NUM];
 	u8	   nr_args;
 	bool	   errpid;
 	bool	   timeout;
@@ -1229,7 +1231,7 @@ struct syscall {
  */
 struct bpf_map_syscall_entry {
 	bool	enabled;
-	u16	string_args_len[6];
+	u16	string_args_len[RAW_SYSCALL_ARGS_NUM];
 };
 
 /*
@@ -1661,7 +1663,7 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
 
-	if (nr_args == 6 && sc->fmt && sc->fmt->nr_args != 0)
+	if (nr_args == RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_args != 0)
 		nr_args = sc->fmt->nr_args;
 
 	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
@@ -1812,7 +1814,8 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 		sc->tp_format = trace_event__tp_format("syscalls", tp_name);
 	}
 
-	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ? 6 : sc->tp_format->format.nr_fields))
+	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
+					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields))
 		return -ENOMEM;
 
 	if (IS_ERR(sc->tp_format))
-- 
2.34.1

