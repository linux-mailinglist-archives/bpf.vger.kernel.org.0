Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6FC67B82B
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjAYROE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 12:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbjAYRN6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 12:13:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B27D7;
        Wed, 25 Jan 2023 09:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1486E6159C;
        Wed, 25 Jan 2023 17:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDCCC433EF;
        Wed, 25 Jan 2023 17:13:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKjLA-004Nvn-2v;
        Wed, 25 Jan 2023 12:13:40 -0500
Message-ID: <20230125171340.715046734@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 12:13:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [for-next][PATCH 12/12] bpf/tracing: Use stage6 of tracing to not duplicate macros
References: <20230125171252.431857411@goodmis.org>
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

The bpf events are created by the same macro magic as tracefs trace
events are. But to hook into bpf, it has its own code. It duplicates many
of the same macros as the tracefs macros and this is an issue because it
misses bug fixes as well as any new enhancements that come with the other
trace macros.

As the trace macros have been put into their own staging files, have bpf
take advantage of this and use the tracefs stage 6 macros that the "fast
ssign" portion of the trace event macro uses.

Link: https://lkml.kernel.org/r/20230124202515.873075730@goodmis.org
Link: https://lore.kernel.org/lkml/1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com/

Cc: bpf@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/bpf_probe.h | 45 +--------------------------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 155c495b89ea..1f7fc1fc590c 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -4,50 +4,7 @@
 
 #ifdef CONFIG_BPF_EVENTS
 
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
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
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
 #define __perf_count(c)	(c)
-- 
2.39.0
