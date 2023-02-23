Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD36A0099
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBWBaD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBWBaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:30:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE70139BAB;
        Wed, 22 Feb 2023 17:30:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z2so11219188plf.12;
        Wed, 22 Feb 2023 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFNflSpTSiIQfsf7cATy307KGQD32osdQzRAo98DNHk=;
        b=pmNzrc1sJeAwnBrsf9xyxIs5L5VV+BqKSaysmwUINjo7LHA0zS7XMUZXYlTArTJWwG
         x/Mgwdx4p9l9hL3IPsR94cu4EVT85u+B+rFRFOYNxUdci84jYYLSZ9U0NQ/L2WcKOu7T
         GPVCgPI3ca2ghxM9LBW64oKs+MJTYHzVPByVvwDeHPzMf1PXx8v14/logZiDhg5b4waK
         evkfUoX39fINxcFGcdVcr9gxBKifkK+oMP+expKmV48I+VXzkHOxk7GWhJiL8yNj4ba/
         XqIEuEnD4hfRAdtbc/gfiQBt7RPuAXAK66UH+RKo9W2vsOyZSjsQ2wdkRT0LcRMS/Cmz
         OYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFNflSpTSiIQfsf7cATy307KGQD32osdQzRAo98DNHk=;
        b=3sJb/mAIdEvhOibBimn4DslQJb5QVqJxUtmrV39BVylCxAjAkrC+iyCHtR5oMUQvJo
         kaoDY7Po7EPDY12lbG6fQEzMX0GyjalL4FFHnRxALZaCzhXsLlatylmWG508AJ6fvPni
         4Um/dFdOlLe6W9xu6mssnMe7ytc5FqrVThEsf6+qDgojLKEio8tcIdwwev/whu9SSe3q
         mcFO3iM+yXSVicgSvncYMDuqcNMr4EZxRYXDb0dKAm/4D9/9cQ+9szvjvnzAz895ycQL
         7B1YPoTVLnu+EIrwO1zVqbW51Myx36rKHiPko8d3WFo8QkNcD/V3siUN2Lqv9IdT1xRL
         tFUA==
X-Gm-Message-State: AO0yUKWlNbDI3dw8fXmCZ9iQFnyZzMxtepV9ehp5ZZ2018R0Vm6gLTD6
        rOP7tDXloyqerpRXi2vKSoA=
X-Google-Smtp-Source: AK7set8A0Lth0DJfah5RHEg9F7VEXHqH5g2RrTXzTTPm80or2qfv7Sh83+OTrnCHRcCdsHFHnOe4yQ==
X-Received: by 2002:a17:903:786:b0:19a:8338:703b with SMTP id kn6-20020a170903078600b0019a8338703bmr8421907plb.57.1677115801008;
        Wed, 22 Feb 2023 17:30:01 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:1bf3])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b0019ac5d3ee9dsm2841943plb.157.2023.02.22.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 17:30:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 22 Feb 2023 15:29:58 -1000
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
Subject: [PATCH v2 2/2 bpf-next] selftests/bpf: Add a test case for
 bpf_cgroup_from_id()
Message-ID: <Y/bBlt+tPozcQgws@slm.duckdns.org>
References: <Y/bBaG96t0/gQl9/@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/bBaG96t0/gQl9/@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 42 +++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index b3f7985c8504..adda85f97058 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -84,6 +84,7 @@ static const char * const success_tests[] = {
 	"test_cgrp_xchg_release",
 	"test_cgrp_get_release",
 	"test_cgrp_get_ancestors",
+	"test_cgrp_from_id",
 };
 
 void test_cgrp_kfunc(void)
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index 7d30855bfe78..2f8de933b957 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -24,6 +24,7 @@ struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_kptr_get(struct cgroup **pp) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 
 static inline struct __cgrps_kfunc_map_value *cgrps_kfunc_map_value_lookup(struct cgroup *cgrp)
 {
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 0c23ea32df9f..42e13aebdd62 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -168,3 +168,45 @@ int BPF_PROG(test_cgrp_get_ancestors, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_from_id, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *parent, *res;
+	u64 parent_cgid;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	/* @cgrp's ID is not visible yet, let's test with the parent */
+	parent = bpf_cgroup_ancestor(cgrp, cgrp->level - 1);
+	if (!parent) {
+		err = 1;
+		return 0;
+	}
+
+	parent_cgid = parent->kn->id;
+	bpf_cgroup_release(parent);
+
+	res = bpf_cgroup_from_id(parent_cgid);
+	if (!res) {
+		err = 2;
+		return 0;
+	}
+
+	bpf_cgroup_release(res);
+
+	if (res != parent) {
+		err = 3;
+		return 0;
+	}
+
+	res = bpf_cgroup_from_id((u64)-1);
+	if (res) {
+		bpf_cgroup_release(res);
+		err = 4;
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.39.2

