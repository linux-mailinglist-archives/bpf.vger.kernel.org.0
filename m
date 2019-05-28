Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6923C2CEB3
	for <lists+bpf@lfdr.de>; Tue, 28 May 2019 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfE1SaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 14:30:01 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:43051 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfE1S35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 14:29:57 -0400
Received: by mail-yb1-f201.google.com with SMTP id o145so8502801ybc.10
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sdrk7zv1q4sBRbvsm6ygjzJAHzpOvMNms+yuTgEQ42g=;
        b=jrHoidhNgoB65HMHvIopYGUiXI8FZgMqt3PMqVeae8wK2btEBVjehb50C2tbD8wo8X
         a4+UZ1An+r+M3VOXdtZKNRQt4XG5JtNHjBwU/pfXZiJx8y5H/1xDt7mVjYO8xCfaUdrp
         iC4t7HIZuZjU6UeigxT5KtPWWeQYwJyDRS0W20X1mr/jwtVUI9mqRo7KkYIz6poCMzIN
         WXjnzrsXOpu4j/Ty5wCEkdZhfput0I7oFNNHIEZEUpybmpP3CqvORmksSgkdIRsV71xH
         nJcd19wokFq+nndgRp2+PRpxJt9FBMZZpSKbiQoQf75GsFL5FUyFFT0KtOKA+YzRjLka
         BRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sdrk7zv1q4sBRbvsm6ygjzJAHzpOvMNms+yuTgEQ42g=;
        b=VdRG+wGmklmiWmEr86UiipSh10YBx0/Rr9d2KgeSDEblWaj85/LH8dUK66AQaFOe/L
         lGvbTxw2zHxElZjKl3q4VgnQ6ElBBiYoybnuCFSTAIBUI8hNeYjMhro3VykI2ApSXTtP
         VpSf25KNcLcd2WwK7lqqvInpLiQwRNvKA/+JYKBwRdCktfZHiwrbL0Aq7eA0HSfCjDs6
         bu4nW6RZVJ6ClenDI4FYPkqv1q7VvgLizdB1WLzt3DPbje7jnkg7b3nPF2PDV2rc5Cew
         x0PsCIMAS2QgTefYotAO/j1LNA1TWH5iM7s5A1D6o2OVfrmpNqzwHFya4B9mvCRErABd
         oaSg==
X-Gm-Message-State: APjAAAUSTtlZNfzAf+DNOmC/vx7w/4JxMAGzVLLCcpQUUo4PUtTP4Mpp
        41qG2Up69YvGlNIBd8RssLGEu7s=
X-Google-Smtp-Source: APXvYqxaFrOQsOMYSkwDJahY1PY/8v7Ge4VXn2Gmx/1WDmO90lXjEJ3x1JTnl0DUUrSJ1qd6msGec5A=
X-Received: by 2002:a0d:fcc7:: with SMTP id m190mr8070407ywf.60.1559068196801;
 Tue, 28 May 2019 11:29:56 -0700 (PDT)
Date:   Tue, 28 May 2019 11:29:46 -0700
In-Reply-To: <20190528182946.3633-1-sdf@google.com>
Message-Id: <20190528182946.3633-4-sdf@google.com>
Mime-Version: 1.0
References: <20190528182946.3633-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH bpf-next v3 4/4] bpf: tracing: properly use bpf_prog_array api
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we don't have __rcu markers on the bpf_prog_array helpers,
let's use proper rcu_dereference_protected to obtain array pointer
under mutex.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/trace/bpf_trace.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe73926a07cd..3994a231eb92 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -19,6 +19,9 @@
 #include "trace_probe.h"
 #include "trace.h"
 
+#define bpf_event_rcu_dereference(p)					\
+	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
+
 #ifdef CONFIG_MODULES
 struct bpf_trace_module {
 	struct module *module;
@@ -1099,7 +1102,7 @@ static DEFINE_MUTEX(bpf_event_mutex);
 int perf_event_attach_bpf_prog(struct perf_event *event,
 			       struct bpf_prog *prog)
 {
-	struct bpf_prog_array __rcu *old_array;
+	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	int ret = -EEXIST;
 
@@ -1117,7 +1120,7 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 	if (event->prog)
 		goto unlock;
 
-	old_array = event->tp_event->prog_array;
+	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	if (old_array &&
 	    bpf_prog_array_length(old_array) >= BPF_TRACE_MAX_PROGS) {
 		ret = -E2BIG;
@@ -1140,7 +1143,7 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 
 void perf_event_detach_bpf_prog(struct perf_event *event)
 {
-	struct bpf_prog_array __rcu *old_array;
+	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	int ret;
 
@@ -1149,7 +1152,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	if (!event->prog)
 		goto unlock;
 
-	old_array = event->tp_event->prog_array;
+	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, &new_array);
 	if (ret == -ENOENT)
 		goto unlock;
@@ -1171,6 +1174,7 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 {
 	struct perf_event_query_bpf __user *uquery = info;
 	struct perf_event_query_bpf query = {};
+	struct bpf_prog_array *progs;
 	u32 *ids, prog_cnt, ids_len;
 	int ret;
 
@@ -1195,10 +1199,8 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 	 */
 
 	mutex_lock(&bpf_event_mutex);
-	ret = bpf_prog_array_copy_info(event->tp_event->prog_array,
-				       ids,
-				       ids_len,
-				       &prog_cnt);
+	progs = bpf_event_rcu_dereference(event->tp_event->prog_array);
+	ret = bpf_prog_array_copy_info(progs, ids, ids_len, &prog_cnt);
 	mutex_unlock(&bpf_event_mutex);
 
 	if (copy_to_user(&uquery->prog_cnt, &prog_cnt, sizeof(prog_cnt)) ||
-- 
2.22.0.rc1.257.g3120a18244-goog

