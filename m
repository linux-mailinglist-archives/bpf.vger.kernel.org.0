Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B15209F6
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 02:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiEJAXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 20:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiEJAW3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 20:22:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D442A28C9DD
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 17:18:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id t29-20020a056a00139d00b005107ebaefeaso3832498pfg.20
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KcVlDhYIqiGAy0xA6Ny1iEWIuZrHDDkBi7OMZAuyAKA=;
        b=CbFDRQM+DJHPuLYLBakMiPuPtWC2dPz39UZfOmcu4qup9XyxZPCJINo69q4jZT4AoC
         dLRunNzKgmtg9/SjwCmLiNW5Q87qDk2kiCE3Bvr3D+WjbNu8Syu3BhuMYSNbGa207ILF
         Qh7apNc/4HgAHnDy45R3N6ppLnbRqI6AWkGDHHxN3ezenAc++v64jfbpcV8RvtKTW5OW
         H5cK0SaNA8KayXojnjkq3df/p9zd5sCw6q/pivecBUNQfPA6gTBNzpdlsha/+JCX+EP2
         b27F5hHeQOk9I6B+LWTtNHptDhwCCBC3wK41+O8Y1dY+/ywCr06lqwmPK5GvIEQsBDUo
         dI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KcVlDhYIqiGAy0xA6Ny1iEWIuZrHDDkBi7OMZAuyAKA=;
        b=4KISH5YLEiQZOj6SWzZUTLxoCvGKuFCWmmW9Ic/4VekkUAMUwPJuNSkq+KiBUmpE3F
         d3+17XyyN1GyPji42M8LCJG0sY4uuFg370dKsjnhzoONd73XmPs1oKm4LkUa6R68/2rY
         H5BwOC7ZbBzLQS41NeJyek9uoNae5vOthLmFkLSZtkmQ91Zd6MfZox21FAVMH02V9D0z
         gtIlFel5L6mU9H/+rwN7m04uAAzAMG5l10VxsA1HvhYCBqJZRpX+rK7agJ9c0tWLnvfa
         95jlLkIK6IxY6UlfQQRN0DsuPF5zZYKgcBT3leqNtxHaND9TLyNYTR7/20GtfACFJgMQ
         5OxA==
X-Gm-Message-State: AOAM5336WeZ6WY4creEQ7+c1rlzdmavg00K1N76gaj+VXUjg4Fr+5pKR
        oSu50BtfwwqjrANqngZjxKm+CAeL8gLuAQ3+
X-Google-Smtp-Source: ABdhPJzYYkjJ3ZLtAxYLy2pZUwKzXH4+bOWrXeRHBvANSFiGZs994Oo4pdOYa15sJhMjmUsYw0Y5YSKbOxkEbCUX
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:2311:b0:1d9:277e:edad with SMTP
 id mt17-20020a17090b231100b001d9277eedadmr20549707pjb.190.1652141907370; Mon,
 09 May 2022 17:18:27 -0700 (PDT)
Date:   Tue, 10 May 2022 00:18:02 +0000
In-Reply-To: <20220510001807.4132027-1-yosryahmed@google.com>
Message-Id: <20220510001807.4132027-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [RFC PATCH bpf-next 4/9] bpf: add bpf rstat helpers
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_cgroup_rstat_updated() and bpf_cgroup_rstat_flush() helpers
to enable  bpf programs that collect and output cgroup stats
to communicate with the rstat frameworkto add a cgroup to the rstat
updated tree or trigger an rstat flush before reading stats.

ARG_ANYTHING is used here for the struct *cgroup parameter. Would it be
better to add a task_cgroup(subsys_id) helper that returns a cgroup
pointer so that we can use a BTF argument instead?

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
 kernel/bpf/helpers.c           | 30 ++++++++++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f4855fa85db..fce5535579d6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5149,6 +5149,22 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * void bpf_cgroup_rstat_updated(struct cgroup *cgrp)
+ *	Description
+ *		Notify the rstat framework that bpf stats were updated for
+ *		*cgrp* on the current cpu. Directly calls cgroup_rstat_updated
+ *		with the given *cgrp* and the current cpu.
+ *	Return
+ *		0
+ *
+ * void bpf_cgroup_rstat_flush(struct cgroup *cgrp)
+ *	Description
+ *		Collect all per-cpu stats in *cgrp*'s subtree into global
+ *		counters and propagate them upwards. Directly calls
+ *		cgroup_rstat_flush_irqsafe with the given *cgrp*.
+ *	Return
+ *		0
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5345,6 +5361,8 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(cgroup_rstat_updated),	\
+	FN(cgroup_rstat_flush),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 315053ef6a75..d124eed97ad7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1374,6 +1374,32 @@ void bpf_timer_cancel_and_free(void *val)
 	kfree(t);
 }
 
+BPF_CALL_1(bpf_cgroup_rstat_updated, struct cgroup *, cgrp)
+{
+	cgroup_rstat_updated(cgrp, smp_processor_id());
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_cgroup_rstat_updated_proto = {
+	.func		= bpf_cgroup_rstat_updated,
+	.gpl_only	= false,
+	.ret_type	= RET_VOID,
+	.arg1_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_1(bpf_cgroup_rstat_flush, struct cgroup *, cgrp)
+{
+	cgroup_rstat_flush_irqsafe(cgrp);
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_cgroup_rstat_flush_proto = {
+	.func		= bpf_cgroup_rstat_flush,
+	.gpl_only	= false,
+	.ret_type	= RET_VOID,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1426,6 +1452,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
+	case BPF_FUNC_cgroup_rstat_updated:
+		return &bpf_cgroup_rstat_updated_proto;
+	case BPF_FUNC_cgroup_rstat_flush:
+		return &bpf_cgroup_rstat_flush_proto;
 	default:
 		break;
 	}
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 096625242475..9e2b08557a6f 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -633,6 +633,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct cgroup',
     ]
     known_types = {
             '...',
@@ -682,6 +683,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct cgroup',
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f4855fa85db..fce5535579d6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5149,6 +5149,22 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * void bpf_cgroup_rstat_updated(struct cgroup *cgrp)
+ *	Description
+ *		Notify the rstat framework that bpf stats were updated for
+ *		*cgrp* on the current cpu. Directly calls cgroup_rstat_updated
+ *		with the given *cgrp* and the current cpu.
+ *	Return
+ *		0
+ *
+ * void bpf_cgroup_rstat_flush(struct cgroup *cgrp)
+ *	Description
+ *		Collect all per-cpu stats in *cgrp*'s subtree into global
+ *		counters and propagate them upwards. Directly calls
+ *		cgroup_rstat_flush_irqsafe with the given *cgrp*.
+ *	Return
+ *		0
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5345,6 +5361,8 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(cgroup_rstat_updated),	\
+	FN(cgroup_rstat_flush),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.36.0.512.ge40c2bad7a-goog

