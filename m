Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786457D85F
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiGVCNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 22:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiGVCNe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 22:13:34 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1483197A1E
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 19:13:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n2-20020a170902e54200b0016c16832828so2012976plf.5
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 19:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tLU3GevE7EMq9svQBvmyRhnadL4Y+2gn2LprvT/4YYk=;
        b=WJ8665xaHjsgIdkrbSgYU3Vo7MtIiyG2UO4Za0C9TzTlUp7Aq7oAziFEULIp7hjp+Z
         DJ+t4zTWp0z5UXInnWyoxHHqxnN8yPduXx5pW9ds2FjqUnTEcbABw+LGgxrrAPMcN1eV
         z+MojCuD3/i7a0HJVN8Bq4eSfU8qu0zTBHPD3oCbCfVpVf65C+/xi6wlqxj1cEmBCdk3
         tMnyUSeHBrO2pQI90BwTyb4CUoCH8hvytQixa4psc0lLVTfdmU+qRCYYysor8bdLZjb7
         np/mK2MgbacYiWCOJiW3UOBBI/V/N4FwTd4baweLMkL+N9MOykrVLgcFTaV0XFvuapzF
         6dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tLU3GevE7EMq9svQBvmyRhnadL4Y+2gn2LprvT/4YYk=;
        b=y4+bJyQ7x4h2jDbQ2YlGKZiv/6MW0s5TxPC+op/KCIKA83V6B8s63y1eXPp7pGFJsx
         h+Afn2Zum7yLp6ftxjFiYP7UeWj6V/i+Xhi1VFICxdRI8daAgz5XxHx3YJk2gJB9t0B/
         tCL1pMO4JOmehoUBmCxWevbZM/c3wVc0vakvpE42Wz0XM3g5Y18xwtnRCP2qs7OMh5EU
         zgx8UByiEuoFcg6m4i7uyG2DId5cnyCHvVhhDNDiVeaQGWjCOG4MA4z/+hY0Ve8vLhW+
         RpIRLjTHuVf8aKF2Nj6m2M4jHBCV8mV4AWL4IsFGnfI7Pq+llj+neDzB5G9h6BPZipfS
         6OhA==
X-Gm-Message-State: AJIora9ECXrXwhGf9AwBrjFHda2cBSDr8V2yNjP+hw4z46F6N0k9RKG+
        alZhBDcOB4ywvtf1BN0ZndYxAfHn4kv4h1gK
X-Google-Smtp-Source: AGRyM1vDH6ZHqKhC4Dn/p1vre782Xqt/F67hZF/QuRKkjVTK5IJ5MXiMaBF1V3RKD0YfTdT5LWpuKzr2fAZnSakt
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a62:b60d:0:b0:528:99aa:da09 with SMTP
 id j13-20020a62b60d000000b0052899aada09mr1137449pff.86.1658456005918; Thu, 21
 Jul 2022 19:13:25 -0700 (PDT)
Date:   Fri, 22 Jul 2022 02:13:11 +0000
In-Reply-To: <20220722021313.3150035-1-yosryahmed@google.com>
Message-Id: <20220722021313.3150035-7-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220722021313.3150035-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH bpf-next v4 6/8] cgroup: bpf: enable bpf programs to integrate
 with rstat
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable bpf programs to make use of rstat to collect cgroup hierarchical
stats efficiently:
- Add cgroup_rstat_updated() kfunc, for bpf progs that collect stats.
- Add cgroup_rstat_flush() kfunc, for bpf progs that read stats.
- Add an empty bpf_rstat_flush() hook that is called during rstat
  flushing, for bpf progs that flush stats to attach to. Attaching a bpf
  prog to this hook effectively registers it as a flush callback.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/rstat.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..0f87c31eecc2 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -3,6 +3,11 @@
 
 #include <linux/sched/cputime.h>
 
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+
+
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
@@ -141,6 +146,31 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	return pos;
 }
 
+/*
+ * A hook for bpf stat collectors to attach to and flush their stats.
+ * Together with providing bpf kfuncs for cgroup_rstat_updated() and
+ * cgroup_rstat_flush(), this enables a complete workflow where bpf progs that
+ * collect cgroup stats can integrate with rstat for efficient flushing.
+ *
+ * A static noinline declaration here could cause the compiler to optimize away
+ * the function. A global noinline declaration will keep the definition, but may
+ * optimize away the callsite. Therefore, __weak is needed to ensure that the
+ * call is still emitted, by telling the compiler that we don't know what the
+ * function might eventually be.
+ *
+ * __diag_* below are needed to dismiss the missing prototype warning.
+ */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+__weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
+				     struct cgroup *parent, int cpu)
+{
+}
+
+__diag_pop();
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -168,6 +198,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 			struct cgroup_subsys_state *css;
 
 			cgroup_base_stat_flush(pos, cpu);
+			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
 			rcu_read_lock();
 			list_for_each_entry_rcu(css, &pos->rstat_css_list,
@@ -469,3 +500,26 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		   "system_usec %llu\n",
 		   usage, utime, stime);
 }
+
+/* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
+BTF_SET_START(bpf_rstat_check_kfunc_ids)
+BTF_ID(func, cgroup_rstat_updated)
+BTF_ID(func, cgroup_rstat_flush)
+BTF_SET_END(bpf_rstat_check_kfunc_ids)
+
+BTF_SET_START(bpf_rstat_sleepable_kfunc_ids)
+BTF_ID(func, cgroup_rstat_flush)
+BTF_SET_END(bpf_rstat_sleepable_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.check_set	= &bpf_rstat_check_kfunc_ids,
+	.sleepable_set	= &bpf_rstat_sleepable_kfunc_ids,
+};
+
+static int __init bpf_rstat_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					 &bpf_rstat_kfunc_set);
+}
+late_initcall(bpf_rstat_kfunc_init);
-- 
2.37.1.359.gd136c6c3e2-goog

