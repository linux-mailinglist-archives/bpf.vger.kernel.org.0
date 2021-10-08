Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DA426668
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 11:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhJHJQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 05:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236555AbhJHJP6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 05:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUb/i9RBmi1Fh2lX7yds41KHjfH6nx836x27H5fnG4k=;
        b=SM6IO0K7+FnWRglD3StwEfyVuKraT9nXkD321ZV3nmeoOC+CGKo6AWxYRs6fzdE0VNF8es
        Ofb0wHDQ3j5ekpiGgtkCwzwe+ZXnSLjLEorbhRTIQAEmm+NRn/mOvs6pJ0CnD3CiRuxszT
        eNJXPcDlBQHd8s1SIYpZBLq7yJmYQ7Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-PPPEvYZlPCCd2NtMHinp2Q-1; Fri, 08 Oct 2021 05:14:02 -0400
X-MC-Unique: PPPEvYZlPCCd2NtMHinp2Q-1
Received: by mail-wr1-f69.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so3708879wrd.5
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 02:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUb/i9RBmi1Fh2lX7yds41KHjfH6nx836x27H5fnG4k=;
        b=XndNq/JUWfFoj4tt5/P8pTw6KAPI7Xi7JHw+l6JmUZkokgWtNV/OXx4bSW4YfTjZ/1
         LpXDbQA6KwEsuZoh5XerMpq3zMByY49VNxgIKkpAOghU/3746PECxFzohZQYkSC/ig+i
         jNxHYdI9HIHbhsJXZ3qQLp5wIJWRWY97vks28tfywN+79a7EEURQAyQpT8x6Wfb6+rnl
         KBe7XUAHAMgqPzmU+wW4KxYkIFgaJcJWAg+xO2GQAzhcfQ2tygXv7gI53ywrK9LAc/QL
         E0AQOOCIA/YTs/B8hw789kg5BKFh8TpzbLDHp3m39L4lJ/Dw2KWmSxE5rHDIvwoFN0gF
         Rh0Q==
X-Gm-Message-State: AOAM531OBfzxN3gHLg7jIOAbj8kfD5q5XhujNjwiuS+tDxV6d3vvdIiT
        Am6/leB+AI6+LFncTWDUv4KsZfLYxt6iUabWyufgaSJW17V5zZL4Wwuz00lp9p9XL3jOuJFwweH
        01lgHl0IgGy+y
X-Received: by 2002:adf:c986:: with SMTP id f6mr2691107wrh.216.1633684441557;
        Fri, 08 Oct 2021 02:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz74rdA9MIuzk3OP1VjqcSnfHAvyHf5rVZuc+qGDMTLv6UmeZvBAgk9qtrFDqvInkOO8GT8WA==
X-Received: by 2002:adf:c986:: with SMTP id f6mr2691081wrh.216.1633684441342;
        Fri, 08 Oct 2021 02:14:01 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k9sm1814581wrz.22.2021.10.08.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:14:01 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 4/8] tracing: Add trampoline/graph selftest
Date:   Fri,  8 Oct 2021 11:13:32 +0200
Message-Id: <20211008091336.33616-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding selftest for checking that direct trampoline can
co-exist together with graph tracer on same function.

This is supported for CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
config option, which is defined only for x86_64 for now.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/trace_selftest.c | 54 ++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf7ef194005..917b7e3bf1ec 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -750,6 +750,8 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
+noinline __noclone static void trace_direct_tramp(void) { }
+
 /*
  * Pretty much the same than for the function tracer from which the selftest
  * has been borrowed.
@@ -760,6 +762,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 {
 	int ret;
 	unsigned long count;
+	char *func_name __maybe_unused;
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (ftrace_filter_param) {
@@ -808,8 +811,57 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-	/* Don't test dynamic tracing, the function tracer already did */
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	tracing_reset_online_cpus(&tr->array_buffer);
+	set_graph_array(tr);
+
+	/*
+	 * Some archs *cough*PowerPC*cough* add characters to the
+	 * start of the function names. We simply put a '*' to
+	 * accommodate them.
+	 */
+	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
+	ftrace_set_global_filter(func_name, strlen(func_name), 1);
+
+	/*
+	 * Register direct function together with graph tracer
+	 * and make sure we get graph trace.
+	 */
+	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
+				     (unsigned long) trace_direct_tramp);
+	if (ret)
+		goto out;
+
+	ret = register_ftrace_graph(&fgraph_ops);
+	if (ret) {
+		warn_failed_init_tracer(trace, ret);
+		goto out;
+	}
+
+	DYN_FTRACE_TEST_NAME();
+
+	count = 0;
+
+	tracing_stop();
+	/* check the trace buffer */
+	ret = trace_test_buffer(&tr->array_buffer, &count);
+
+	unregister_ftrace_graph(&fgraph_ops);
+
+	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
+				       (unsigned long) trace_direct_tramp);
+	if (ret)
+		goto out;
+
+	tracing_start();
 
+	if (!ret && !count) {
+		ret = -1;
+		goto out;
+	}
+#endif
+
+	/* Don't test dynamic tracing, the function tracer already did */
 out:
 	/* Stop it if we failed */
 	if (ret)
-- 
2.31.1

