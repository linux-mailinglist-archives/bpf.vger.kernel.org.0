Return-Path: <bpf+bounces-13671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431197DC5A6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D081C20BAF
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C9748F;
	Tue, 31 Oct 2023 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jvl0qBy8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED31CA68
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:04:55 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30548F3
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2802b744e52so1898900a91.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698728693; x=1699333493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHjScvx8WEZuHjDOhihyelPybn4gwPGSDSuXuehLacg=;
        b=jvl0qBy8+E7FU2CHoFTD36zGOAQBaZjYyANqcb8bmSS/hQAkfxdn3aQGYdxoYqRID8
         ILNZPLkznpJ5/nAuUCWgic+HnKa0EjfWH6vHBnHz1zit58dTHI1vWlkUzzTp11z4g/vj
         ZgRkdx1r1uG05aEP7QCIqcYpP1hXrfjLavZTi7QAipo4DyX4dvHcqeCK54JLyFrpFjrm
         vL+2ceE6hxgyTJ8cfxcbg6oTpmmMOvPFzYJ0FuTgPTnY1puNwKfkvpWJIIwLzpTbA5BN
         qUb/fA5yivEl+opXRExgqiYmCojC7b65XJSH4d8LkHCkC9qHMRaxhZ26SLShwE6KCwka
         Qr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728693; x=1699333493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHjScvx8WEZuHjDOhihyelPybn4gwPGSDSuXuehLacg=;
        b=IbS9rvczD+ip3GcP8beOeqwq+rMf/eIc6jClI6YhPTgoyc5WzaVD79W3iyvo8+6ZES
         0743AQXUGVmdbk5DIWct/BFc2PZ9ee+Xy3qJGHgVqRPvuqvY9/EeR+4PF73MFDGM7AKl
         8Buy11wKF+Tcoh+Akz1A15+tWFr33tpyemcuPS1xrbOMhzORu+aWrXJkhkcUM2QKxUL2
         D9xPY5EGnttp05P6KmIsVQjKPMK0+50FwEe8fgMNYUpJsnjmJ1g8ya1r9qIDCGRIUQ7D
         7kjaNErbECdqPFakdC9F6U6EL7IaEFhKadYwfGcHyLl8WHh1MpsUtn/gEmoMPGIyxgxQ
         sS3g==
X-Gm-Message-State: AOJu0YyD7BinQiDhVQX3KVZFczm7GumXHErwpNwKw8UT3lNTikeHfyPp
	oBPspZNv7CctJXtANA+g763e/uyXcv+A1Aj0bKA=
X-Google-Smtp-Source: AGHT+IFcJ2iLnCohdPUcXXSHvhUQBOAl8xtEfhb33V9KDv/UuBjYUO+VPeNYJsoPOHdVmsR5HQdBEg==
X-Received: by 2002:a17:90a:600f:b0:280:8e7d:5701 with SMTP id y15-20020a17090a600f00b002808e7d5701mr2095099pji.2.1698728693503;
        Mon, 30 Oct 2023 22:04:53 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a195500b0027ce34334f5sm350951pjh.37.2023.10.30.22.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:04:53 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Add test for using css_task iter in sleepable progs
Date: Tue, 31 Oct 2023 13:04:38 +0800
Message-Id: <20231031050438.93297-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231031050438.93297-1-zhouchuyi@bytedance.com>
References: <20231031050438.93297-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This Patch add a test to prove css_task iter can be used in normal
sleepable progs.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../testing/selftests/bpf/prog_tests/iters.c  |  1 +
 .../selftests/bpf/progs/iters_css_task.c      | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index c2425791c923..bf84d4a1d9ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -294,6 +294,7 @@ void test_iters(void)
 	RUN_TESTS(iters_state_safety);
 	RUN_TESTS(iters_looping);
 	RUN_TESTS(iters);
+	RUN_TESTS(iters_css_task);
 
 	if (env.has_testmod)
 		RUN_TESTS(iters_testmod_seq);
diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
index 384ff806990f..e180aa1b1d52 100644
--- a/tools/testing/selftests/bpf/progs/iters_css_task.c
+++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
@@ -89,3 +89,22 @@ int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
 	bpf_cgroup_release(acquired);
 	return 0;
 }
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(iter_css_task_for_each_sleep)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cgrp_id);
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+
+	if (cgrp == NULL)
+		return 0;
+	css = &cgrp->self;
+
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
+
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
-- 
2.20.1


