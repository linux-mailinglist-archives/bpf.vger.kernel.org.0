Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107EF6DB920
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 07:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjDHFwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 01:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjDHFwQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 01:52:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CED529
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 22:52:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c23fab905so48882547b3.14
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680933134;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2dWon3rHJ1nD139lVaQ1WrnfCqCvaQvEhPXDcZYjwM=;
        b=T4kCWB3JooK6L8NchDif5VHk4VQ5lliH7Lz9Ifuwebm2kE6RsdT8Fvu7FrnnUI4Twb
         w8xWnsMr9cHk+6Gw43Fcov8QfAOXzSaORpROP+WxtHVeAQ+Y8BBI13RWv6DjQgj8h+iI
         aPzBV0PV9cOgVOoMvGjAlAHXyf2ToqnvCkAcHvJQ62O/XI1zRCjaU709aLtFRTHUr2ss
         +O0NSJbTj8wKI47aaEL+nm/UnpB+eiFyXlQC6noLORyr9g8TyW88UJOVYECivc0QxE7x
         UGEwPwn/pE5Pd2rrdcSQCjUMMrrmAAvXZm3IhSIrqJPSv4KThFWM98XtuY6cnl+bwIIT
         Pfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680933134;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2dWon3rHJ1nD139lVaQ1WrnfCqCvaQvEhPXDcZYjwM=;
        b=LDDSMNLy4qCIxze5DXxglJLChoxMCsxXn1IMjz9+Lyr5qF6Y/FgED/NJkeIu5QO1oa
         ilRnTq9gRAUFS1WmSMcCpO3OwrrpBs0rHgefG9LY2EFyZ7ovAe8izsDFMAWRZom+rkM9
         +LwjuvxBqa9XT3viH8uFYByK+0fKO9lJsRdmxSHEjib9WTPKAo6XivN+efeDZuitsj8Q
         7RKdaBsVJ50mJk0VzTDTGR3xk9/EevEaVInJRCKzA5v7upddZjnccq3EKLQZtMNfsOH1
         8FfxjRZcxwIduA9AYS1XcYpJLxtCeFH8hUT4H9Rt5McwBcUB68kCEJ6edceKbWp+OIBv
         jbRg==
X-Gm-Message-State: AAQBX9eSUtu+nQVFW1wK+X7fm6nfnio45yJmIc0eyC7rg9ekxQT2M9Wi
        aknDp14fbrrI7lx+BdgvOF4xDkjF8mZY
X-Google-Smtp-Source: AKy350Z7mK7eScp79F3uWgqZbq7wHnhBRy2d3bczXxjBl3iURo4swsW9rkDpDn/cynJWxcjKuqzwsGHyNbH+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a25:d988:0:b0:997:c919:4484 with SMTP id
 q130-20020a25d988000000b00997c9194484mr651735ybg.6.1680933134194; Fri, 07 Apr
 2023 22:52:14 -0700 (PDT)
Date:   Fri,  7 Apr 2023 22:52:08 -0700
In-Reply-To: <20230408055208.1283832-1-irogers@google.com>
Message-Id: <20230408055208.1283832-2-irogers@google.com>
Mime-Version: 1.0
References: <20230408055208.1283832-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 2/2] perf bpf filter: Support pre-5.16 kernels
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The mem_hops bits were added in 5.16 with no prior equivalent.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 28 ++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 57e3c67d6d37..cffe493af1ed 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -24,6 +24,24 @@ struct perf_sample_data___new {
 	__u64 sample_flags;
 } __attribute__((preserve_access_index));
 
+/* new kernel perf_mem_data_src definition */
+union perf_mem_data_src__new {
+	__u64 val;
+	struct {
+		__u64   mem_op:5,	/* type of opcode */
+			mem_lvl:14,	/* memory hierarchy level */
+			mem_snoop:5,	/* snoop mode */
+			mem_lock:2,	/* lock instr */
+			mem_dtlb:7,	/* tlb access */
+			mem_lvl_num:4,	/* memory hierarchy level number */
+			mem_remote:1,   /* remote */
+			mem_snoopx:2,	/* snoop mode, ext */
+			mem_blk:3,	/* access blocked */
+			mem_hops:3,	/* hop level */
+			mem_rsvd:18;
+	};
+};
+
 /* helper function to return the given perf sample data */
 static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 				    struct perf_bpf_filter_entry *entry)
@@ -89,8 +107,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 			return kctx->data->data_src.mem_dtlb;
 		if (entry->part == 7)
 			return kctx->data->data_src.mem_blk;
-		if (entry->part == 8)
-			return kctx->data->data_src.mem_hops;
+		if (entry->part == 8) {
+			union perf_mem_data_src__new *data = (void *)&kctx->data->data_src;
+
+			if (bpf_core_field_exists(data->mem_hops))
+				return data->mem_hops;
+
+			return 0;
+		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
 	default:
-- 
2.40.0.577.gac1e443424-goog

