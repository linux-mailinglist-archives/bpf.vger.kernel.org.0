Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1154561442D
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 06:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKAFXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAFXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 01:23:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D318C11;
        Mon, 31 Oct 2022 22:23:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so12028677pjd.4;
        Mon, 31 Oct 2022 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQCTwzJqtSBW9Z3UsnAgIL2hpfLmbH6kApaX3wUbVJU=;
        b=n/2Fq8bQktUiyLhfPxdi+eDo6YGcRrwDABHyI1zooAFSozgpZWpN29PWyrQfpze+oC
         G42smNXVAAMLZnVXPPTUzDZz89PrOboLcWuOyo8wfkC1DLh+a9GgvSN4v6YejCdTvbAG
         W83XFWPxzoKIbe1PfAjoLjRvdodoDa7o7XLH7URY5Dd5o3oP1bHMF6KJSxseT1klrroM
         0PrnphxCsBYQMA9fbGOLFvioR4vchvJ9vbk+HuuJ3cksKoRCj0Lh2RJsYnXNby8Hulk8
         LshACXvoFG4pmjB5Z2Fl+pRocFpIx7squoPZ7yO5hZ5Mvbs8weFOxYP0HZyybUcYi0uI
         N/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQCTwzJqtSBW9Z3UsnAgIL2hpfLmbH6kApaX3wUbVJU=;
        b=CaUEsQPzCQfcaTkl+7AuA6MSP4ccBCDrDgOmvDqmDBAKpWdaBgbl1qk0/l7bFmLYL2
         LftBo6IMchWZJRgwVUu/MWyQw7GokFzzjv6hJOAIHfn2qL/vX7+Ws8j8eiLQyJ+tiBRO
         QmZnEXwwpE1jzZa1liXHickJa+3OQ7ypnCrghf8uwQOXPyAAL1oAH8/ZsF2ejabt4xNq
         yXlhslPSg7/Avnodlsr1JCwiDwJNBz3H30KghJ8UVfW0sYKTvcoIh9epbzPrFg/MlYUC
         MhB9gIRaz9a973p5gg+thcKVZ8cB/mulMU/GoIDIv7H5IaQpFJkLANjrhfdKHtfwe1nF
         xfLQ==
X-Gm-Message-State: ACrzQf0pJly2NvFQMlrmkWvplyajZ8CIE9DgyOPLnYEUfwM7f8+21pTp
        NEt6ce7l1VorYi3EV8LJ1VM=
X-Google-Smtp-Source: AMsMyM4NYx8Jr9vWUge/8JjcrDpS+ni02eXYgJ75yv02VYRtVNQht5P+pJ2N8/1imOPoozzzUErsCw==
X-Received: by 2002:a17:902:6aca:b0:186:8431:d7e4 with SMTP id i10-20020a1709026aca00b001868431d7e4mr18017807plt.89.1667280226566;
        Mon, 31 Oct 2022 22:23:46 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:7e9:8a64:69f2:c3c7])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b00561b53512b0sm5532254pfk.195.2022.10.31.22.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:23:46 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
Date:   Mon, 31 Oct 2022 22:23:39 -0700
Message-Id: <20221101052340.1210239-3-namhyung@kernel.org>
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

The bpf_perf_event_read_sample() helper is to get the specified sample
data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
decision for filtering on samples.  Currently PERF_SAMPLE_IP and
PERF_SAMPLE_DATA flags are supported only.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/uapi/linux/bpf.h       | 23 ++++++++++++++++
 kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 94659f6b3395..cba501de9373 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5481,6 +5481,28 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		sample data associated to *ctx*	and store it in the buffer
+ *		pointed by *buf* up to size *size* bytes.
+ *
+ *		The *sample_flags* should contain a single value in the
+ *		**enum perf_event_sample_format**.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		The *buf* can be set to **NULL** to return the number of bytes
+ *		required to store the requested sample data.
+ *
+ *		**-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
+ *
+ *		**-ENOENT** if the associated perf event doesn't have the data.
+ *
+ *		**-ENOSYS** if system doesn't support the sample data to be
+ *		retrieved.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5695,6 +5717,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(perf_event_read_sample, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ce0228c72a93..befd937afa3c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -28,6 +28,7 @@
 
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
+#include <uapi/linux/perf_event.h>
 
 #include <asm/tlb.h>
 
@@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.arg4_type      = ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
+	   void *, buf, u32, size, u64, flags)
+{
+	struct perf_sample_data *sd = ctx->data;
+	void *data;
+	u32 to_copy = sizeof(u64);
+
+	/* only allow a single sample flag */
+	if (!is_power_of_2(flags))
+		return -EINVAL;
+
+	/* support reading only already populated info */
+	if (flags & ~sd->sample_flags)
+		return -ENOENT;
+
+	switch (flags) {
+	case PERF_SAMPLE_IP:
+		data = &sd->ip;
+		break;
+	case PERF_SAMPLE_ADDR:
+		data = &sd->addr;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	if (!buf)
+		return to_copy;
+
+	if (size < to_copy)
+		to_copy = size;
+
+	memcpy(buf, data, to_copy);
+	return to_copy;
+}
+
+static const struct bpf_func_proto bpf_perf_event_read_sample_proto = {
+	.func           = bpf_perf_event_read_sample,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type      = ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1759,6 +1806,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_read_branch_records_proto;
 	case BPF_FUNC_get_attach_cookie:
 		return &bpf_get_attach_cookie_proto_pe;
+	case BPF_FUNC_perf_event_read_sample:
+		return &bpf_perf_event_read_sample_proto;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 94659f6b3395..cba501de9373 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5481,6 +5481,28 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		sample data associated to *ctx*	and store it in the buffer
+ *		pointed by *buf* up to size *size* bytes.
+ *
+ *		The *sample_flags* should contain a single value in the
+ *		**enum perf_event_sample_format**.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		The *buf* can be set to **NULL** to return the number of bytes
+ *		required to store the requested sample data.
+ *
+ *		**-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
+ *
+ *		**-ENOENT** if the associated perf event doesn't have the data.
+ *
+ *		**-ENOSYS** if system doesn't support the sample data to be
+ *		retrieved.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5695,6 +5717,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(perf_event_read_sample, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.38.1.273.g43a17bfeac-goog

