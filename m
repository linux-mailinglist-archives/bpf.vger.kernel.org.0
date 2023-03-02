Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D916A899F
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCBTnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 14:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBTnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 14:43:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB14E10FE;
        Thu,  2 Mar 2023 11:43:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so3911839pjb.1;
        Thu, 02 Mar 2023 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqgGCr3Y2hQqsVtgaOtDgK2Itfj2+UP+twnkCNai0cM=;
        b=j+O/08s9jmfUCAMCfB8jGXd4RmvK3IS0rq4XnrCtdk8IvWSvCAGdq0bvGXadxvRZj2
         l7i7Am/m06dl4up4n1MC8wdarKc92aoa4VrYUnP/5/w2H59pRsl3wk9o6+MNwI0TyHmZ
         wSxght6cfzaDf62ZYwbT/Guf+RUH2Rp7jHEUexj95KgIZH8/QO8LAtSdVC6oGHDXA9/5
         8mQup7l+XDewrf8Xk54Qe3w5Fj0mWsOVq0Tsz7NH0JQ8p3IgIfq2WoBNgoKzXtJCyuC7
         2O3pvl0wX0tKq3t16drYxeUslXGzQUAAz9i0HhhDa7wfOcY8ribsapPELNR4/1DL7oMT
         czlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqgGCr3Y2hQqsVtgaOtDgK2Itfj2+UP+twnkCNai0cM=;
        b=aFKVKkBZpZ+wf8JrHcmAhv9VPtm5D8RvfzlRlXovWpn/3YdVmaWPyViEI/5kW6fjiV
         B9qoug+ZbYu+vNTtzLEoHG/J93wfAOMe92L8D2qllVbG+tkXx4JQZZy2f/47tGhINWqa
         IGVWuibxazjdNShRxYFO0eROrDhkgEHagQS9M+XsERLNAHc5bUuhfeC784Il0WXdN5+q
         Bg2ekAt/Sb3jAAXBfmr7EUNwD2aHuI6gfawHfbs3vIRQbdvAoaw4qgXaQvEfAA5J8GZG
         LKQRk1AcgjlqU3DZfGDRj5ntixqB4MR160KqHA80RYqHmG9MeiielmVykAOR2vjqn3bo
         E3pg==
X-Gm-Message-State: AO0yUKXceu8Aj8NxQgPaCy3qfQRJ+Hl+uAKZOBeQvntlbSH1huIDMN8e
        zXo/Z4ueEha2FYog8y0L5Gs=
X-Google-Smtp-Source: AK7set/sZtsf3xPnv3Hffw0z40IesHhJQBrBrtqUL+usj73Y4HahnCy+FUxT7W32S9ShkwOacCYZmw==
X-Received: by 2002:a05:6a20:12c5:b0:cd:40b4:bc75 with SMTP id v5-20020a056a2012c500b000cd40b4bc75mr14202674pzg.48.1677786182169;
        Thu, 02 Mar 2023 11:43:02 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:7baa])
        by smtp.gmail.com with ESMTPSA id c5-20020a62e805000000b005a7f8a326a3sm86794pfi.50.2023.03.02.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:43:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Mar 2023 09:42:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 bpf-next] bpf: Make bpf_get_current_[ancestor_]cgroup_id()
 available for all program types
Message-ID: <ZAD8QyoszMZiTzBY@slm.duckdns.org>
References: <ZADx1NQBOGeImnrC@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADx1NQBOGeImnrC@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These helpers are safe to call from any context and there's no reason to
restrict access to them. Remove them from bpf_trace and filter lists and add
to bpf_base_func_proto() under perfmon_capable().

v2: After consulting with Andrii, relocated in bpf_base_func_proto() so that
    they require bpf_capable() but not perfomon_capable() as it doesn't read
    from or affect others on the system.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/cgroup.c      | 4 ----
 kernel/bpf/helpers.c     | 4 ++++
 kernel/trace/bpf_trace.c | 4 ----
 net/core/filter.c        | 6 ------
 4 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bf2fdb33fb31..a4ae422b8f12 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2529,10 +2529,6 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_get_current_comm:
 		return &bpf_get_current_comm_proto;
-	case BPF_FUNC_get_current_cgroup_id:
-		return &bpf_get_current_cgroup_id_proto;
-	case BPF_FUNC_get_current_ancestor_cgroup_id:
-		return &bpf_get_current_ancestor_cgroup_id_proto;
 #ifdef CONFIG_CGROUP_NET_CLASSID
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 49a2ab8eb0bb..d4e910fbbda9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1693,6 +1693,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_cgrp_storage_get_proto;
 	case BPF_FUNC_cgrp_storage_delete:
 		return &bpf_cgrp_storage_delete_proto;
+	case BPF_FUNC_get_current_cgroup_id:
+		return &bpf_get_current_cgroup_id_proto;
+	case BPF_FUNC_get_current_ancestor_cgroup_id:
+		return &bpf_get_current_ancestor_cgroup_id_proto;
 #endif
 	default:
 		break;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c58baf9983cc..489942354a90 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1455,10 +1455,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		       NULL : &bpf_probe_read_compat_str_proto;
 #endif
 #ifdef CONFIG_CGROUPS
-	case BPF_FUNC_get_current_cgroup_id:
-		return &bpf_get_current_cgroup_id_proto;
-	case BPF_FUNC_get_current_ancestor_cgroup_id:
-		return &bpf_get_current_ancestor_cgroup_id_proto;
 	case BPF_FUNC_cgrp_storage_get:
 		return &bpf_cgrp_storage_get_proto;
 	case BPF_FUNC_cgrp_storage_delete:
diff --git a/net/core/filter.c b/net/core/filter.c
index 1d6f165923bf..0f2589ea70f3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8144,12 +8144,6 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_delete_proto;
 	case BPF_FUNC_get_netns_cookie:
 		return &bpf_get_netns_cookie_sk_msg_proto;
-#ifdef CONFIG_CGROUPS
-	case BPF_FUNC_get_current_cgroup_id:
-		return &bpf_get_current_cgroup_id_proto;
-	case BPF_FUNC_get_current_ancestor_cgroup_id:
-		return &bpf_get_current_ancestor_cgroup_id_proto;
-#endif
 #ifdef CONFIG_CGROUP_NET_CLASSID
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
-- 
2.39.2

