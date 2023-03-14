Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405536BA1AE
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 22:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCNV7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCNV7x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 17:59:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B05110CD;
        Tue, 14 Mar 2023 14:59:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p6so18143170plf.0;
        Tue, 14 Mar 2023 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678831192;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V5oa+tnNxBRfCsHNQQwG3me8RtumyZ1n0X+cpzX6ubA=;
        b=WvwN1155TYKVvu7tUubKWIepn90mQNjYZj5/fZlMOkRbc1xAUVIMIocLCI5/GtzpKD
         HQNQ3EM1pqINmdm4EhCI2leugtYnwsUW9JHpqLoAtIIFXzXx2zXukJtgCvnzGUv4PZVn
         qyXBAO0NAASGMrNMhqAT/ujDgktFpAVGSosI7D9iB4C0LAXA7nYG65TJmh2Rm5B+ff7F
         Zc2VYhHqmCm3hjtFUuiEUmPVqrKRuy1sjn/V45Q3r2a082DxdIw7dBi+PLmhMR7f4XRt
         BKmm/K0w8jf8dHB3NjqXOsrsvz5VPz7JZmSHaO5fpnA/y+Pnz9kk+HpHWFfeAJ0ZLCI5
         AOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831192;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5oa+tnNxBRfCsHNQQwG3me8RtumyZ1n0X+cpzX6ubA=;
        b=kh4Y/QMzsBLZQEiPjb3/bvKAw2Hih2T3OE42t/XvIxtEx3eR7sHQffnktVJJPapEl1
         XmTBi6pUJyCWSE1GaOjRtTr5vH4yLc1NAQljGZaCFMhMrD0//n4DMkd2uSb4cK2sT9gY
         3ZgM2f6TafcTzmXazVYMwWv5tRTlpOAtmkVn5BuPgy7xKgsxE4GKDTjcyTtOF4y2wLJq
         02l/g2DbE+AbsEMePTsbpKOGQ3R+0eoJQCPDo6jiwLG9IXQ/izQvKoLTj/PYga5/o6Q2
         1Mr+3ikjXyCnXNwu9n9CaJuV9lHVR0GaL3AS2HDHGl5DPWHN1NgHl6TPTzpRGJ5BAtIy
         1v8w==
X-Gm-Message-State: AO0yUKXMan+Rx2Jd8dzaXPsh+63WD0u85pEeLS8ejxeFF+F8juMZogBV
        cQQ+05E+XkrTlKTxcyGi4Zs=
X-Google-Smtp-Source: AK7set+NhYRdrOANDeCF454npmEVGILBi6HXfyleUWq+DGnq9ihVSM2R239W2qVt2H8t2XsK4bz94w==
X-Received: by 2002:a17:90a:1a03:b0:233:feb4:895f with SMTP id 3-20020a17090a1a0300b00233feb4895fmr38865457pjk.44.1678831192324;
        Tue, 14 Mar 2023 14:59:52 -0700 (PDT)
Received: from localhost ([2600:380:7656:8258:88b9:45ff:fe37:1816])
        by smtp.gmail.com with ESMTPSA id lk15-20020a17090308cf00b001898ee9f723sm2237528plb.2.2023.03.14.14.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:59:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Mar 2023 11:59:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf/for-next] cgroup: Make current_cgns_cgroup_dfl() safe to
 call after exit_task_namespace()
Message-ID: <ZBDuVWiFj2jiz3i8@slm.duckdns.org>
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

332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc") added
bpf_cgroup_from_id() which calls current_cgns_cgroup_dfl() through
cgroup_get_from_id(). However, BPF programs may be attached to a point where
current->nsproxy has already been cleared to NULL by exit_task_namespace()
and calling bpf_cgroup_from_id() would cause an oops.

Just return the system-wide root if nsproxy has been cleared. This allows
all cgroups to be looked up after the task passed through
exit_task_namespace(), which semantically makes sense. Given that the only
way to get this behavior is through BPF programs, it seems safe but let's
see what others think.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Fixes: 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc")
---
Hello,

Given that this is only exposed through a commit in bpf/for-next, I think
it'd be best to route it together. If this looks okay, please apply to
bpf/for-next.

Thanks.

 kernel/cgroup/cgroup.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8bfb0e2a87ee..c0da5cb9f193 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1465,8 +1465,20 @@ static struct cgroup *current_cgns_cgroup_dfl(void)
 {
 	struct css_set *cset;
 
-	cset = current->nsproxy->cgroup_ns->root_cset;
-	return __cset_cgroup_from_root(cset, &cgrp_dfl_root);
+	if (current->nsproxy) {
+		cset = current->nsproxy->cgroup_ns->root_cset;
+		return __cset_cgroup_from_root(cset, &cgrp_dfl_root);
+	} else {
+		/*
+		 * NOTE: This function may be called from bpf_cgroup_from_id()
+		 * on a task which has already passed exit_task_namespace() and
+		 * NULL nsproxy. Fall back to cgrp_dfl_root which will make all
+		 * cgroups visible for lookups. Given that BPF progs are
+		 * privileged, this shouldn't create security concerns but there
+		 * may be a better way to handle this.
+		 */
+		return &cgrp_dfl_root.cgrp;
+	}
 }
 
 /* look up cgroup associated with given css_set on the specified hierarchy */
-- 
2.39.2

