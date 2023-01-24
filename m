Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0DF67A3C8
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjAXUZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 15:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjAXUZV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 15:25:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FEE113FF;
        Tue, 24 Jan 2023 12:25:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 497B3B816B7;
        Tue, 24 Jan 2023 20:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B5BC433D2;
        Tue, 24 Jan 2023 20:25:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKPr1-003dzZ-2k;
        Tue, 24 Jan 2023 15:25:15 -0500
Message-ID: <20230124202515.716458410@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 24 Jan 2023 15:22:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 1/2] perf/tracing: Use stage6 of tracing to not duplicate macros
References: <20230124202238.563854686@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The perf events are created by the same macro magic as tracefs trace
events are. But to hook into perf, it has its own code. It duplicates many
of the same macros as the tracefs macros and this is an issue because it
misses bug fixes as well as any new enhancements that come with the other
trace macros.

As the trace macros have been put into their own staging files, have perf
take advantage of this and use the tracefs stage 6 macros that the "fast
assign" portion of the trace event macro uses.

Link: https://lore.kernel.org/lkml/1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com/

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>
Reported-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/perf.h                         | 46 +-------------------
 include/trace/stages/stage6_event_callback.h |  3 ++
 2 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index 8f3bf1e17707..2c11181c82e0 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -4,51 +4,7 @@
 
 #ifdef CONFIG_PERF_EVENTS
 
-#undef __entry
-#define __entry entry
-
-#undef __get_dynamic_array
-#define __get_dynamic_array(field)	\
-		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
-
-#undef __get_dynamic_array_len
-#define __get_dynamic_array_len(field)	\
-		((__entry->__data_loc_##field >> 16) & 0xffff)
-
-#undef __get_str
-#define __get_str(field) ((char *)__get_dynamic_array(field))
-
-#undef __get_bitmask
-#define __get_bitmask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_cpumask
-#define __get_cpumask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_sockaddr
-#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
-
-#undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)	\
-		((void *)__entry +					\
-		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +			\
-		 (__entry->__rel_loc_##field & 0xffff))
-
-#undef __get_rel_dynamic_array_len
-#define __get_rel_dynamic_array_len(field)	\
-		((__entry->__rel_loc_##field >> 16) & 0xffff)
-
-#undef __get_rel_str
-#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
-
-#undef __get_rel_bitmask
-#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_cpumask
-#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_sockaddr
-#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+#include "stages/stage6_event_callback.h"
 
 #undef __perf_count
 #define __perf_count(c)	(__count = (c))
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 49c32394b53f..919b1a4da980 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -2,6 +2,9 @@
 
 /* Stage 6 definitions for creating trace events */
 
+/* Reuse some of the stage 3 macros */
+#include "stage3_trace_output.h"
+
 #undef __entry
 #define __entry entry
 
-- 
2.39.0


