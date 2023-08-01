Return-Path: <bpf+bounces-6562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB5F76B778
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0921C20ED4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40654263A5;
	Tue,  1 Aug 2023 14:29:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5B25172
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:29:31 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD51724
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:29:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686e0213c0bso3971665b3a.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900169; x=1691504969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zC3WGzZtaMKNMFp/YGjNb28rA0pmC4/+92OTfnwc+k=;
        b=QSiVTBUI6+DxJqeoC9Iv+0F9ZJu1Vu8Ap/c3HT75RuIuar1b7N8uwPzQJiNnLhA/Jx
         4+nXs4gdTnDHv6TTwghyuMweztKnNcShYelUFj3X66Z+QPsn2f24sday8sMyARz+JS5m
         lMFrnrkCdCoIsZIyeYE9Stsw54X66er4lh+cvENAv86kyOZcN4y0Wm+s0VCBuzKTZG4m
         K9bBluX8U/pSUEApkUs70kECCZHhpH1eCcjXx3qd9y90zjN17gj4zJT8kGDYOTjFDKDy
         IznQq9435k/Q0zGd4Hj2iXIZcVjAUmGxtBSSUS87f690yP0u1DNBSg/DcxWStxiLofA6
         u2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900169; x=1691504969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zC3WGzZtaMKNMFp/YGjNb28rA0pmC4/+92OTfnwc+k=;
        b=dVgYSq6sLBBieii/aKGG+Wflskl4Yon7EhGFl2UcYbu5AMQQ6zcXc87QH22DXGAZ6R
         37DVEcbV+uhfbkpmJxywml/C9UFFW2l0cZFxn7KNF2diiesNXEf4Zw+iHbRm0rg6m5rf
         Q3l82KYJxWWF29UafA33uG+dWul6r0q+b0AiQa/rrvXbnPLHShccbm7S1WW+UkQINDV1
         AzxEZjsvKlMR7t/bHvSSYKEB98wX8d3fCaYd8G2cVNxvwwjKQlQ1ho6JUXAFiyHnfqSP
         MyAzEhIgaiWePCynlmlvM0Kim8fUNAv01zO0atdKkIfxkvrhLab85wWVgqO0nRviGDtF
         m6lg==
X-Gm-Message-State: ABy/qLai8k0MRlr9p5tu7IJN1PuJeLIzRDlAA55fQyWL+MnV4iDo8edB
	gl8bqF2Oh5CtcJS5XKfyUT0=
X-Google-Smtp-Source: APBJJlHsRXvb5Uy63SVM3+1m+lhHr/tA42aPadDm/psfm7FHzWiO+Jswir3kNH9t/DKEl9dp/xHbkA==
X-Received: by 2002:a05:6a00:1953:b0:687:189c:4e3d with SMTP id s19-20020a056a00195300b00687189c4e3dmr11576339pfk.10.1690900169482;
        Tue, 01 Aug 2023 07:29:29 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1409:5400:4ff:fe86:cf7a])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00686a80f431dsm9391491pfo.126.2023.08.01.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:29:29 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/3] cgroup, psi: Init root cgroup psi to psi_system
Date: Tue,  1 Aug 2023 14:29:11 +0000
Message-Id: <20230801142912.55078-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230801142912.55078-1-laoar.shao@gmail.com>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By initializing the root cgroup's psi field to psi_system, we can
consistently obtain the psi information for all cgroups from the struct
cgroup.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/psi.h    | 2 +-
 kernel/cgroup/cgroup.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index e074587..8f2db51 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -34,7 +34,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 #ifdef CONFIG_CGROUPS
 static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 {
-	return cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	return cgrp->psi;
 }
 
 int psi_cgroup_alloc(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f55a40d..d7ba5fa 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -164,7 +164,10 @@ struct cgroup_subsys *cgroup_subsys[] = {
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = {
+	.cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu,
+	.cgrp.psi = &psi_system,
+};
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
-- 
1.8.3.1


