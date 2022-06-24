Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293BA55A4AB
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiFXXNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 19:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFXXNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 19:13:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EAC69999;
        Fri, 24 Jun 2022 16:13:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o18so3323885plg.2;
        Fri, 24 Jun 2022 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/W8LDN+tzFAEf2BPgwfAuc3ZnltgoEwHVT0bAe4brM=;
        b=WsF0G+VJ7ZJaU1x/sk1Qfm+U7PZteKatAdVE/LWM9L4N5BQMXcGGqMrKf+N3R9k+Vr
         uDnQNwc6BhjqQStOjG0837AISbMPODVUDT8hdU6jpv78kCkuVr51qcu14e7PqZu2nYPm
         8SJsMJUwUQ0hlfRGfE0jcXU0aYW+JdqZocvrF6IWaRku1l1ngUyFDDIGSvX4Qhvi+Gdg
         E9hb9PkBuPRDfRn98raNarAuWaTJwwY0H0MOtuwjquWAjmA6Lc/wmBkBb8D4DPjVKCzE
         dSrCll6BLJVw7oDqeRivZ0j13r7CSxCEMy70swpUTFPeSJ5gynHeYJN5pwUpMGV06Lzd
         nljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=W/W8LDN+tzFAEf2BPgwfAuc3ZnltgoEwHVT0bAe4brM=;
        b=5Wpj9nSWXD/04p8aTcK/+UIkqYrD5fX+fBUatPM9TWD0VMCsxfYRHV+Our7xtMiPDh
         ozL4h/vQqyJfOZMvkoyzo/C0BNo2a2JQiI1gOrGJlap4pxqoWo97YkCtU6DYlCrGxKti
         8iyUye6JxRP3BTBNj7w3CrAfT2+MUzt06zW0P9cZLzycFCxzsO9gICh2P/3Znktly025
         UYzxc8dwphy/YciYJHCTD96zIJzJtBFIEeaskdEIjsDzZi2vJL1I8Q+wNn1WzwAkEVxQ
         +JAgybi2cUS9QUvTjAWL/Bo73cNTq6XQVVzEr26HoCfg8mHZk5Gt2nOpORmyLgsZhx9x
         Cjaw==
X-Gm-Message-State: AJIora9ASotTQC+im7YFASQ+rk4dFhY4rh1z97D9yY4H/l8jJDSrtxRj
        PmK8KDmricOqFUhn0OjzemLwX0+ZOAs17w==
X-Google-Smtp-Source: AGRyM1t5gNy4v4K5UHhprgbyO6kecjEaSRwHg3Gm6BjqBiNSbVYJlSWnDzW0lsyjutiMi0S2TPglTg==
X-Received: by 2002:a17:90b:1650:b0:1ec:b5e7:42ae with SMTP id il16-20020a17090b165000b001ecb5e742aemr1356755pjb.15.1656112396599;
        Fri, 24 Jun 2022 16:13:16 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:eeb0:3156:8fd:28f6])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b0050dc76281e0sm2242439pfe.186.2022.06.24.16.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:13:16 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 1/6] perf offcpu: Fix a build failure on old kernels
Date:   Fri, 24 Jun 2022 16:13:08 -0700
Message-Id: <20220624231313.367909-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220624231313.367909-1-namhyung@kernel.org>
References: <20220624231313.367909-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Old kernels have task_struct which contains "state" field and newer
kernels have "__state".  While the get_task_state() in the BPF code
handles that in some way, it assumed the current kernel has the new
definition and it caused a build error on old kernels.

We should not assume anything and access them carefully.  Do not use
the task struct directly and access them using new and old definitions
in a row.

Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 792ae2847080..cc6d7fd55118 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -71,6 +71,11 @@ struct {
 	__uint(max_entries, 1);
 } cgroup_filter SEC(".maps");
 
+/* new kernel task_struct definition */
+struct task_struct___new {
+	long __state;
+} __attribute__((preserve_access_index));
+
 /* old kernel task_struct definition */
 struct task_struct___old {
 	long state;
@@ -93,14 +98,17 @@ const volatile bool uses_cgroup_v1 = false;
  */
 static inline int get_task_state(struct task_struct *t)
 {
-	if (bpf_core_field_exists(t->__state))
-		return BPF_CORE_READ(t, __state);
+	/* recast pointer to capture new type for compiler */
+	struct task_struct___new *t_new = (void *)t;
 
-	/* recast pointer to capture task_struct___old type for compiler */
-	struct task_struct___old *t_old = (void *)t;
+	if (bpf_core_field_exists(t_new->__state)) {
+		return BPF_CORE_READ(t_new, __state);
+	} else {
+		/* recast pointer to capture old type for compiler */
+		struct task_struct___old *t_old = (void *)t;
 
-	/* now use old "state" name of the field */
-	return BPF_CORE_READ(t_old, state);
+		return BPF_CORE_READ(t_old, state);
+	}
 }
 
 static inline __u64 get_cgroup_id(struct task_struct *t)
-- 
2.37.0.rc0.161.g10f37bed90-goog

