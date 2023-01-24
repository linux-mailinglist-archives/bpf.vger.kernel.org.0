Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5067A34C
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjAXTqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAXTqQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 14:46:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B2DBF5;
        Tue, 24 Jan 2023 11:46:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 369E66132A;
        Tue, 24 Jan 2023 19:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F138AC433D2;
        Tue, 24 Jan 2023 19:46:13 +0000 (UTC)
Date:   Tue, 24 Jan 2023 14:46:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] trace: add new file under include/trace/stages/
 for perf/bpf
Message-ID: <20230124144611.3476ad36@gandalf.local.home>
In-Reply-To: <1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 16 Dec 2022 17:03:04 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> when experiment change for trace operation, the files under
> include/trace/stages/ will be changed, perf/bpf trace may compile fail.

Sorry for the late reply, I was expecting some feedback from the perf
and/or BPF folks.

> 
> add new file stage8_perf_call.h and stage9_bpf_call.h under
> include/trace/stages/, it will make sure no missing change when expriment.
> 

Actually, these are not part of the stage sequence. In fact they could
possibly be replaced *with* the stage sequences (which I think I'll apply):

For example:

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
 
