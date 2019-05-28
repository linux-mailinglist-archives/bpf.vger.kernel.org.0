Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067BE2D0E3
	for <lists+bpf@lfdr.de>; Tue, 28 May 2019 23:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE1VO4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 17:14:56 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56013 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfE1VOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 17:14:55 -0400
Received: by mail-qt1-f201.google.com with SMTP id e20so49857qtq.22
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sdrk7zv1q4sBRbvsm6ygjzJAHzpOvMNms+yuTgEQ42g=;
        b=WEiWNt7Xiq8SYHnNq0VkecFYRpbEv+iDrhq5QcrOjaXER/SUu/0rekhS8/MqP0Ult2
         F/N0jXWn8kFm5/EHZ4Uey+F7uOVmSNoEwhFC5cM919Dy4ZBJ49n+KeuA4dRVnTDufKMc
         LDvgDDuFRUQa3yftzKguBDFFfQYWhTNImnvLudJhP/eHptKT9VqeHQo/TfsMhnXK6XkN
         jBKA/VCNfBJR3B2Otc75prMVspST544k6B7g5WTHOZZK2FBexFNLaN8JtvkUGxb7Y+31
         gEdwVi+jVzT/8sdSHaN61u4Ogf3DWBm6fbvAv94Wjq0+xV3v2TVGTU5pVJN8pXzcBGeY
         E/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sdrk7zv1q4sBRbvsm6ygjzJAHzpOvMNms+yuTgEQ42g=;
        b=m8mwQIcNHrCBnYJGoEhF9yLeLcn1nvg+tirMsSWATlZwPFcAsskwJwU8jbTEHGjovF
         8neRoCaxp3Knbyarh19IX0YmNixKBb+ytBkN437DYj6+dQ6YF9BqlzQnPbIMVcAZmVig
         DK/+oEbqE4ayxrgJlABjmGBCjB37bdxYqceyMfvZEU8xE68G1sMAWg9gXHMOKeYYSdOP
         wpl5CIkLwxKkqHiMkJuLMdYZWHOftIAgkEmH4LM04+zt9IeSu+5+jRWlSNkpkefjQo2I
         ymMBAgI4CU9la6sLtWpfE8NMZwt3foNGTzhLxAfuuJE8EmuWhqPJOlexVLNcxpagUMw/
         PswQ==
X-Gm-Message-State: APjAAAWvetF1T9t8XV0ApL5CZwDXNF1MIYvElGMJBo5HGfNY1h/FuLsb
        Ccj9FSJHcZelciilXJTrWyUkieY=
X-Google-Smtp-Source: APXvYqyNhXGiooi9MTP/MCYlzmx28nHQtDyfhH//O8FtbNBX9BsAQlOBAzy/g0AllKJSEQsyy/fHXA4=
X-Received: by 2002:aed:353d:: with SMTP id a58mr9562891qte.42.1559078094016;
 Tue, 28 May 2019 14:14:54 -0700 (PDT)
Date:   Tue, 28 May 2019 14:14:44 -0700
In-Reply-To: <20190528211444.166437-1-sdf@google.com>
Message-Id: <20190528211444.166437-4-sdf@google.com>
Mime-Version: 1.0
References: <20190528211444.166437-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH bpf-next v4 4/4] bpf: tracing: properly use bpf_prog_array api
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

