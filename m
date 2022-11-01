Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EFD61442E
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 06:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKAFXu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 01:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 01:23:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C3BF7;
        Mon, 31 Oct 2022 22:23:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c2so12602209plz.11;
        Mon, 31 Oct 2022 22:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=US7eYoRgQfEJ8iwJ/HYz2Irbm2/CnXBZTSFBhyzNSKU=;
        b=TwB435OqOnyusuoq+5d5AKgRP4giBYxr8W8IgTdWFMvTVDDJQYlq9319JwmPds56uZ
         dzoVZQtMx/QQregnaa+XVbyMhfB8kh8BRAYHhZudrRWqBqa01WXaaPxgJzZhXmP5ekNb
         5+zFgAW1d+utQqBy2FvNBDM+UsZCRFjbpsH7rv/p5BQ2e1X5yy0nFYYsPRoISkJtat43
         lRVNEIYFSoTe8Hu4MVPlcQuaxR3j6ZpEcLnd2Xj22LBr8AYtVoRlcXzLid11Ey/Lj6Jd
         I2rFoC53iWYS0jlKxSHGe7pPwqqNVmfjLlEWzER3DYcwU2rnPngK2qEC+Ea7WIei4UAA
         7dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=US7eYoRgQfEJ8iwJ/HYz2Irbm2/CnXBZTSFBhyzNSKU=;
        b=ZvnShUBITDFmfA8laRZOPajBgVeXYig4Rn7tVoYHo1GP5UEjpKGaqLSprQVwB/oh5i
         63LsZjtNLLPDjbd0FuAo1VEDkRSuWwvkrUNCyLPihWgPFngLeak+m75YL2QBpr1+YCcJ
         Zs0UMlugKJgCPSdZy+Hq1U1eZSUoH1+MYlevwkq0z2ySP32UA20FpGkbfnuXe2Vi9kXv
         1g1Layo/OgGu1eoCSQ4jAxge1saKZ0Epk/6AbBLTvztqHrrYnu6oq6BY8Jz7w22pBBFo
         vzVsie+vGLa4htIJwLiDIIail+PYIv7bCDKFwzKbsFIjtUFi7VmWd9Ss8zy1rUolwBT3
         6VGw==
X-Gm-Message-State: ACrzQf2TCtEncTsdUyuNJXJ8f5klJJeEnbJQKVXxY5+Zq6Zc3/8H5+Sk
        9ao16EDL3jnK8wYGO1qQweA=
X-Google-Smtp-Source: AMsMyM6SDZpZ5IJTtJDrILuaQrRxOCObo6+1U+G6Yh17BXvUiyY6q0RfIbk8F2L0Y2yB+hJ4dqcJGA==
X-Received: by 2002:a17:903:41cf:b0:186:ac4b:21b7 with SMTP id u15-20020a17090341cf00b00186ac4b21b7mr17851016ple.123.1667280225104;
        Mon, 31 Oct 2022 22:23:45 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:7e9:8a64:69f2:c3c7])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b00561b53512b0sm5532254pfk.195.2022.10.31.22.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:23:44 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 1/3] perf/core: Prepare sample data before calling BPF
Date:   Mon, 31 Oct 2022 22:23:38 -0700
Message-Id: <20221101052340.1210239-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221101052340.1210239-1-namhyung@kernel.org>
References: <20221101052340.1210239-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To allow bpf overflow handler to access the perf sample data, it needs to
prepare missing but requested data before calling the handler.

I'm taking a conservative approach to allow a list of sample formats only
instead of allowing them all.  For now, IP and ADDR data are allowed and
I think it's good enough to build and verify general BPF-based sample
filters for perf events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aefc1e08e015..519f30c33a24 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7329,8 +7329,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 	filtered_sample_type = sample_type & ~data->sample_flags;
 	__perf_event_header__init_id(header, data, event, filtered_sample_type);
 
-	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
-		data->ip = perf_instruction_pointer(regs);
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
+		if (filtered_sample_type & PERF_SAMPLE_IP)
+			data->ip = perf_instruction_pointer(regs);
+	}
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
@@ -10006,6 +10008,32 @@ static void perf_event_free_filter(struct perf_event *event)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+static void bpf_prepare_sample(struct bpf_prog *prog,
+			       struct perf_event *event,
+			       struct perf_sample_data *data,
+			       struct pt_regs *regs)
+{
+	u64 filtered_sample_type;
+
+	filtered_sample_type = event->attr.sample_type & ~data->sample_flags;
+
+	if (prog->call_get_stack &&
+	    (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)) {
+		data->callchain = perf_callchain(event, regs);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+	}
+
+	if (filtered_sample_type & PERF_SAMPLE_IP) {
+		data->ip = perf_instruction_pointer(regs);
+		data->sample_flags |= PERF_SAMPLE_IP;
+	}
+
+	if (filtered_sample_type & PERF_SAMPLE_ADDR) {
+		data->addr = 0;
+		data->sample_flags |= PERF_SAMPLE_ADDR;
+	}
+}
+
 static void bpf_overflow_handler(struct perf_event *event,
 				 struct perf_sample_data *data,
 				 struct pt_regs *regs)
@@ -10023,13 +10051,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
-		if (prog->call_get_stack &&
-		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
-		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
-			data->callchain = perf_callchain(event, regs);
-			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-		}
-
+		bpf_prepare_sample(prog, event, data, regs);
 		ret = bpf_prog_run(prog, &ctx);
 	}
 	rcu_read_unlock();
-- 
2.38.1.273.g43a17bfeac-goog

