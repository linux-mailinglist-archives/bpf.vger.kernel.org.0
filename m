Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB2E6A88C4
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 19:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCBS6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 13:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCBS6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 13:58:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892FD13DF7;
        Thu,  2 Mar 2023 10:58:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so372pjz.1;
        Thu, 02 Mar 2023 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VrTnLYcBM5sdj/5jPc/8vHx06BJ4wuh8IZTgTZbTpM4=;
        b=f4oD1kCTLGwpj+45qsJH2wR5kcuUwNCgFI83sgqApq+KcuxSkpEFTZMvw4L9N7nrEY
         V1a66afSo/Ed1CIXbt5D3SKFpHgaQfmKSwVlGazXMBxumYAzMspN+frw8ABUyvj36dr+
         aI9eUd0klLaSKKz0G+W8JMhkEBUtF0DWiGDskrk/cICKUbCr3KsJG47GVmCEgan8q5js
         ZvZ3hDMI07g8GZjl+3bfsQaGRN8ARa795eOI0dLdfHyK/JrcOrW4dCpRdw2g9nKHnL/q
         +mDFdI1fw1T67ghJbdShjcRw5WC1YHybndr71JS06XQyQNPDs7k7XI2g4Ty2ypxiqsQj
         Uk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrTnLYcBM5sdj/5jPc/8vHx06BJ4wuh8IZTgTZbTpM4=;
        b=v3SSE0VTIyLNmhjPn0NmqtvX18Gv2+RSkT8tUliCKL6wpQ9TAaRoR4Ssf0AGvj2VSh
         BnXPX0RQPAyn5FJvAZDHngkYvQ+3T+JMYsrseAkA0x2DgvHkeaTAMjDFI10Et7+sMr5G
         IfTmUsWzT5HO6rf8b+3i4gvFsmcStBokOgJLenNtr6xTg2rUg4Hgjd8rN/3aViNUj4Cl
         4o0rno+7NQnzttstaK1mLzz1qLfjqnziE++H/1j8K0t5BSsOxesNRnDkTyaTcd9nkDfL
         Bve/co+ZsIw/WMPwljjBPH/+i1nEfcNdzsi1sDTjjJo1UkUApzMcLP+juzJ+uy322FFM
         0DZg==
X-Gm-Message-State: AO0yUKUOXU2fei2MOrntg81+d3+lCj+rWu2CWYClMZSGYVprWl6ZX6Qy
        Zr5ooXBdsI3iPqZAdBlvyLc=
X-Google-Smtp-Source: AK7set+BPAfEO94Eo0SfyhLJQVlqmnpLTONljPq0+jMirkpZVrDEjvhEr5rnm92FbaTbdkU1+M+4+A==
X-Received: by 2002:a17:902:d2c5:b0:19a:a9d8:e48a with SMTP id n5-20020a170902d2c500b0019aa9d8e48amr13650135plc.22.1677783510785;
        Thu, 02 Mar 2023 10:58:30 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:7baa])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b0019460ac7c6asm24980plb.283.2023.03.02.10.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:58:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Mar 2023 08:58:28 -1000
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
Subject: [PATCH bpf-next] bpf: Make bpf_get_current_[ancestor_]cgroup_id()
 available for all program types
Message-ID: <ZADx1NQBOGeImnrC@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Please note that while test_verifier results remain the same, I'm unsure
whether subjecting their availability to perfmon_capable() is the right
decision.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/cgroup.c      | 4 ----
 kernel/bpf/helpers.c     | 6 ++++++
 kernel/trace/bpf_trace.c | 4 ----
 net/core/filter.c        | 6 ------
 4 files changed, 6 insertions(+), 14 deletions(-)

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
index 49a2ab8eb0bb..6f8545738a19 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1726,6 +1726,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_task_pt_regs_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+#ifdef CONFIG_CGROUPS
+	case BPF_FUNC_get_current_cgroup_id:
+		return &bpf_get_current_cgroup_id_proto;
+	case BPF_FUNC_get_current_ancestor_cgroup_id:
+		return &bpf_get_current_ancestor_cgroup_id_proto;
+#endif
 	default:
 		return NULL;
 	}
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

