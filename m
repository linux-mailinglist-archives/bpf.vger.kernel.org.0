Return-Path: <bpf+bounces-8114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59257816EA
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 05:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F536281E38
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C641100;
	Sat, 19 Aug 2023 03:01:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5201ED8
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 03:01:50 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AFE3C34
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:49 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d6a5207d9d8so3715737276.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692414108; x=1693018908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isfnt8xxQu2vEYSiPUbmnt9K0kd+VySH+bQvzCMsoUE=;
        b=VaAej+6ONDj8EI95aNsoiADXKjuKWKc6ZFKNQ7Xhr47R+qhx/xs/5aVcSpW2eyvAla
         eGtYbspkJm7mFhy8SE3MX8Efa2As6XCyfgYYt6MFGGSR7mZQ+1qZ28yPAeVATGTJ9BvM
         4dZhV8NWyrB/vkLywU1plqRxhtRDSRryyrEV+JqBrqDvoDUfx1Z7NQt7gCYcbgXZMBir
         emrwTGCqS3VBSAZHtm36X4wj/MWJfQbVHDczapQLt/osfmR0MyUU0oFd9ojs4hDGMrPg
         yrKHGQkXlCobaaES01/dZG0GSLKdU/7R/h4M2AJvfa53cKTg69e9mMWhOb+PDHsqtl5m
         4DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414108; x=1693018908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Isfnt8xxQu2vEYSiPUbmnt9K0kd+VySH+bQvzCMsoUE=;
        b=BeQA3PLG7BUAu/t0l0Q2OiY8uxtjul1W31PdoSR/rlELtd+gByhnnzq8iL7IJqcyDY
         upXcqgRZVnqk7qjn0biJmOb8b9zCg/LhGphujzr3zwHawsPaZYx2GUlBu2p0c9Te/5Hq
         0o6SIZ3L8tJSWq5jveQseJaMs1pBB/FMrV/FJffxfI0mvex0rSrSQlGL3GwVB0/j1VYv
         bVr11xm9lVjA9xYY7g+Oq9Z42qNXhpUph2pDCcJyi87GQoJqTinyAPJrJ+KtXd37+RVM
         r1+Ywf+XlEEc9J2iwUAaCiHviguCnUe2VbJCpxobCK/Vmf5Nritu4x2PMrlyFZBBMOdL
         xvdg==
X-Gm-Message-State: AOJu0YwgJCSix4t1QfiRK+oJCE1DWDOhceF1qTbUcDCTHUrLZlJ8n/Hj
	a/jKqOjF6jQiPHRUSvKVQBMRCj1cHyIhlA==
X-Google-Smtp-Source: AGHT+IFq0qIEkrGW3457UyT6CCUJto78n1qJ9wwc629Po8tP8A5g4rn/Sf0ZF7+06SIJE/EeBi8mKw==
X-Received: by 2002:a0d:ca0b:0:b0:57a:3942:bb74 with SMTP id m11-20020a0dca0b000000b0057a3942bb74mr793392ywd.17.1692414108713;
        Fri, 18 Aug 2023 20:01:48 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a059:9262:e315:4c20])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm903897ywd.40.2023.08.18.20.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:01:48 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 2/6] libbpf: add sleepable sections for {get,set}sockopt()
Date: Fri, 18 Aug 2023 20:01:39 -0700
Message-Id: <20230819030143.419729-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819030143.419729-1-thinker.li@gmail.com>
References: <20230819030143.419729-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Enable libbpf users to define sleepable programs attached on
{get,set}sockopt().  The sleepable programs should be defined with
SEC("cgroup/getsockopt.s") and SEC("cgroup/setsockopt.s") respectively.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b14a4376a86e..ddd6dc166e3e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8766,7 +8766,9 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsockopt.s",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE | SEC_SLEEPABLE),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/setsockopt.s",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE | SEC_SLEEPABLE),
 	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
-- 
2.34.1


