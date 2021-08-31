Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A43FC526
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbhHaJvr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 05:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240735AbhHaJvl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 05:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cg/efFypXdgTTjnQMuhwdn9EcUQgpWsXBxL2SLIRi+8=;
        b=fc+LjW8PBc/pWgRGseXZviR4/cc/Nh8ZHNCvAvG1gZxjbuW0wHt7u7tk8MVd56V7hqnHas
        yJ4WcJhV3C6px4/pDGrODmy6t+t2pUYEe1pVQbSsJq+bA6PbKzaLXRa8VpSY0VlCY9erQb
        tiDGIgjFKbJYky9R79aZG6DZHE0Ddfo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-bSVeVucWOwyHnpPj1cSIrQ-1; Tue, 31 Aug 2021 05:50:45 -0400
X-MC-Unique: bSVeVucWOwyHnpPj1cSIrQ-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so5761976wmj.8
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 02:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cg/efFypXdgTTjnQMuhwdn9EcUQgpWsXBxL2SLIRi+8=;
        b=MIDQgOhJQNOTXC0wVnUqDKMSExXgIw+eK9nhz5Vqwi2WOjl60iTDlNmIJ6ypzdT46/
         sKitWvCo4/0F9hePLKMsSsh6A1EwXbms3SBtIY1JIQvd81LWiCpjk0awAORWyQzqv+N6
         Sok9FBCpshOksAb0oWFuZz6rleFj2lPKr3TB/WPKygJz1ohTOd2kx5ZiOVrpsQQB4b6C
         kARyNG6hYx9DceJtIz3d38o7KXuuqkySOSln0ufGaGAPOyWTAFQACVWt/Qpg4uuZ//y+
         bpFeaMo0z6j1uGNcSAbg03pQrC94XzfWDIfaXm1qWurkdEFe21ytFhy4whSYWr173Usj
         ftyw==
X-Gm-Message-State: AOAM532MdMIC+gTJhMx55E88KvU3S1zajkkzqtygMHMRmfWwhMlW8nIF
        15S0wQnD14Sr7gHEDwGgik+hEetp/j6GOZPdBgKrcEDaMEpZ0ArCVp7M6VRw796xIJxGxRgyrbM
        h2TiYBU5R+9fm
X-Received: by 2002:a1c:210a:: with SMTP id h10mr3304117wmh.117.1630403444006;
        Tue, 31 Aug 2021 02:50:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxLrCTL6wHFHkUVrKt6C7WD1cERTFV3oeo83tug8iHKfag1xxQzcrp/Vw+EVlu/3wl2x43Vg==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr3304107wmh.117.1630403443841;
        Tue, 31 Aug 2021 02:50:43 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id f3sm1962985wmj.28.2021.08.31.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:43 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 4/8] tracing: Add trampoline/graph selftest
Date:   Tue, 31 Aug 2021 11:50:13 +0200
Message-Id: <20210831095017.412311-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
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
 kernel/trace/trace_selftest.c | 49 ++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf7ef194005..f8e55b949cdd 100644
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
@@ -808,8 +811,52 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-	/* Don't test dynamic tracing, the function tracer already did */
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	tracing_reset_online_cpus(&tr->array_buffer);
+	set_graph_array(tr);
 
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
+	tracing_start();
+
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

