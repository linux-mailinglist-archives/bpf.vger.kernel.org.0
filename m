Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D803017EFD
	for <lists+bpf@lfdr.de>; Wed,  8 May 2019 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfEHRS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 May 2019 13:18:58 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41331 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfEHRS6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 May 2019 13:18:58 -0400
Received: by mail-pg1-f202.google.com with SMTP id d7so7608429pgc.8
        for <bpf@vger.kernel.org>; Wed, 08 May 2019 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Oc7kGTxNNeGPMnF+md75kkPiq5ynkJFXLqMqAf1RaYg=;
        b=sCcoidYMTgO8wDHVNyo0zWkArtuSb7+lrPRlpqwpffe0Qu3asnZmSU3fYLKVcgq4OG
         cvdqIziG4VFAUaXw5hlGpmPAxzyN2fGyhXIxCqwCd8PMTgb62S7MPB/6SvM0fYeaPRC5
         q5l24qgY2+rD3nsgx2QYGgw0ohAfXfww3oU0BAJYO8NOJCMFCl57QvdEDJVw1K0FgmHe
         WIuGspqMa+feZ7XQbBsTFd+qPatPsh++1NPW4i7A+9AnoLE19Df3PcrZBikTobBqcYvl
         jNaFIyOo+H3IwNWC4JxrOZMKaUXa4dyZ7nuQEVCN/ubWWz/j4q1Z8xwepbS6J6GmdR2C
         K8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Oc7kGTxNNeGPMnF+md75kkPiq5ynkJFXLqMqAf1RaYg=;
        b=FHic9zFvVGlJFk2zb8c6Z5BblW0hsdmYU5Uv+pGW2jUwlKaRnx183rd5Hq8IhqzB/r
         NdB2FwSHh5ydz59ZJmXu5xsenAhPQuMS/FRTGy17OSv4O/t1vHT+B/XiburUhUM0LVJN
         QXyMEoJw0WC/DeDVPJh3WFdLxKFcpLeEIW+tw7upUmeAMCMcS1UM91dqacmK+ZGsPj4Z
         lQ/1rrjse7iUxmvPEeVgpr0w/djbgIt0+hxdpAA47XRUGoqChzqnNfmrZHu+2OnP4x4z
         7QuDNVA9L0gFG2hmaV3A8Gj0sAqt3ltomjbdk+TXtdXb981WZ4Ij9V0fvUHHqGeNfd3o
         Gdnw==
X-Gm-Message-State: APjAAAWdQPrcPlE266yBuU+3QS2fLHhYVCwrcCuoTxpxH4XBI1qy6pFc
        Hc3UnMWMO87ZOmUDvLSJ3fBVuWk=
X-Google-Smtp-Source: APXvYqzuMXoR4vtaeQnTo9Th5W6+ExYtT4hBDJZP8CCSEYSCPHu3PrFjoogcKMz4CIiw8wE10YkgZkI=
X-Received: by 2002:a63:191b:: with SMTP id z27mr48733425pgl.327.1557335937408;
 Wed, 08 May 2019 10:18:57 -0700 (PDT)
Date:   Wed,  8 May 2019 10:18:45 -0700
In-Reply-To: <20190508171845.201303-1-sdf@google.com>
Message-Id: <20190508171845.201303-5-sdf@google.com>
Mime-Version: 1.0
References: <20190508171845.201303-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf 4/4] bpf: tracing: properly use bpf_prog_array api
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we don't have __rcu markers on the bpf_prog_array helpers,
let's use proper rcu_dereference_protected to obtain array pointer
under mutex.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/trace/bpf_trace.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d64c00afceb5..5f8f7fdbe27c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -17,6 +17,9 @@
 #include "trace_probe.h"
 #include "trace.h"
 
+#define bpf_event_dereference(p)					\
+	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
+
 #ifdef CONFIG_MODULES
 struct bpf_trace_module {
 	struct module *module;
@@ -999,7 +1002,7 @@ static DEFINE_MUTEX(bpf_event_mutex);
 int perf_event_attach_bpf_prog(struct perf_event *event,
 			       struct bpf_prog *prog)
 {
-	struct bpf_prog_array __rcu *old_array;
+	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	int ret = -EEXIST;
 
@@ -1017,7 +1020,7 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 	if (event->prog)
 		goto unlock;
 
-	old_array = event->tp_event->prog_array;
+	old_array = bpf_event_dereference(event->tp_event->prog_array);
 	if (old_array &&
 	    bpf_prog_array_length(old_array) >= BPF_TRACE_MAX_PROGS) {
 		ret = -E2BIG;
@@ -1040,7 +1043,7 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 
 void perf_event_detach_bpf_prog(struct perf_event *event)
 {
-	struct bpf_prog_array __rcu *old_array;
+	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	int ret;
 
@@ -1049,7 +1052,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	if (!event->prog)
 		goto unlock;
 
-	old_array = event->tp_event->prog_array;
+	old_array = bpf_event_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, &new_array);
 	if (ret == -ENOENT)
 		goto unlock;
@@ -1071,6 +1074,7 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 {
 	struct perf_event_query_bpf __user *uquery = info;
 	struct perf_event_query_bpf query = {};
+	struct bpf_prog_array *progs;
 	u32 *ids, prog_cnt, ids_len;
 	int ret;
 
@@ -1095,10 +1099,8 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 	 */
 
 	mutex_lock(&bpf_event_mutex);
-	ret = bpf_prog_array_copy_info(event->tp_event->prog_array,
-				       ids,
-				       ids_len,
-				       &prog_cnt);
+	progs = bpf_event_dereference(event->tp_event->prog_array);
+	ret = bpf_prog_array_copy_info(progs, ids, ids_len, &prog_cnt);
 	mutex_unlock(&bpf_event_mutex);
 
 	if (copy_to_user(&uquery->prog_cnt, &prog_cnt, sizeof(prog_cnt)) ||
-- 
2.21.0.1020.gf2820cf01a-goog

