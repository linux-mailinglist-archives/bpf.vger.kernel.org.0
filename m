Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD43F8ED8
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbhHZTkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243507AbhHZTkk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cg/efFypXdgTTjnQMuhwdn9EcUQgpWsXBxL2SLIRi+8=;
        b=J+Mc6Uu8pc7u6/+vyZSxsyxPQLkiqP6vO9fT/OZ2rdogni4XGcNj30JQLS5kcyHsinTwhi
        ibEA0r5WYfXjTvoCcA0pQV3ETTdmxYcq9rfCornFA/YtgXoA2ld3H2007+gu7z1tXSl2+C
        +/mA9Xgjkpgq+V33MOfAt2INdNlxC3A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-BctiasJlPpOFFMnSWXKJbA-1; Thu, 26 Aug 2021 15:39:49 -0400
X-MC-Unique: BctiasJlPpOFFMnSWXKJbA-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so4748562wmj.8
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cg/efFypXdgTTjnQMuhwdn9EcUQgpWsXBxL2SLIRi+8=;
        b=c9zjP8hgFB1QZCTJqPXDuDlwmrAdtriVdsmRrEOI5UsGa4SfRGdRUdOmu/BOSbV7D+
         5eMfdmiiZ4jUQ0PNgPNdd4QjuGbXVTPss3dhie7KJVq0S+mIbK6uSnYiMUvcwbPOWJfh
         yGGAMwMC+8ZvixcsOnG6auItRTwXp/cEZg2M+dRKOklCCGexUnBzBKEZhAPVcmpNnCJz
         BO//Sc7h/nVT6tP9X88RDkg9/5+AAh06b0+scGvsQATxrPIScA8Gem8oakvMRBrbp1Lr
         heAQpIfW00snqyHBYT41iKSnU8lysz8IMWESEP9do1js3QsXQREaWunvVs54hfPmT6mY
         N0FA==
X-Gm-Message-State: AOAM531t/+p5zs7BIvlJZAczvMzqmtNb2GJ+tau4LJicfk71KcByAI+1
        dUnjxXprklI75wORDXWNVhrnnL6mRGX6X2afjTj/WQrgFCP0nwHGtC+wzOKH3j9gxZS4B88rs+Z
        6ycH5aO5+W3al
X-Received: by 2002:a05:600c:1c9c:: with SMTP id k28mr16247263wms.148.1630006788444;
        Thu, 26 Aug 2021 12:39:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzErSIb9da71+bd4eM+gpeR8ymg1W/1JdN8FsOYvZ/k0CPgNeUBQMNrL2cqD8lXC1MrP68OqQ==
X-Received: by 2002:a05:600c:1c9c:: with SMTP id k28mr16247245wms.148.1630006788257;
        Thu, 26 Aug 2021 12:39:48 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id i14sm3327180wmq.40.2021.08.26.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:39:48 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 04/27] tracing: Add trampoline/graph selftest
Date:   Thu, 26 Aug 2021 21:38:59 +0200
Message-Id: <20210826193922.66204-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
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

