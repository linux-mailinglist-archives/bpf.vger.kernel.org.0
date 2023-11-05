Return-Path: <bpf+bounces-14224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5237E13B1
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF76DB20E43
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A5C8E8;
	Sun,  5 Nov 2023 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gItYMMWt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7452C8CB
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 13:35:12 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064BD3
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 05:35:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5b99bfca064so2341670a12.3
        for <bpf@vger.kernel.org>; Sun, 05 Nov 2023 05:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699191311; x=1699796111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swp+JLszvo8UgDu1mzYB5hmOrgxxrAi9cx00dgZy/vo=;
        b=gItYMMWt7ru2eki8ZV0J/BXu4cafBhZrit7drvgTgZ1dJ/wf5DdF69k84qsNC3foAz
         AZsqkCXaJCLedo6AnBYiewWJ1gG/pdVAuJLEBPps7PCdjCjZdRekWqScNoGQ5oDZ1Z1w
         27QLVSwPr0eMGTsQNokU2EjyE/OV/YyPzyR9bLmFyK3AcqKTIJvPx4wbnbuQ6IMEuy7V
         bMzDtrSzIfvU52WIOpvWYdV/p6Q/cN13w3ZKpFUfdnla9IHGHA5cjjZXAeHW939UnR8t
         UsD2+QY17MKQu+fGteqx3du5BB15vh/+5ohynCv8lK/mPT40t2fyWbYY7pRniY3xNLU3
         0/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699191311; x=1699796111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swp+JLszvo8UgDu1mzYB5hmOrgxxrAi9cx00dgZy/vo=;
        b=FG0rYlvMLYx7rjirg0zTWn687Ka8B+CzbCVAd0d+Zg1wWgJlI/BRmEO0IJRYVsTnFs
         QGdpiBknTS7NQFJjG7mEi0hGE+4UTysI9ohJ6A2cMpmMpCwRV1lPhlpxTzyV3SFKmfME
         EKKCO6CK05IdkCGUyoS4N2W5ieUjRWCyqHL9tWFlRjsEKPnW5Wr1nH+Wp6JMMkCNvYvO
         gSo2vq/bjn2dublgF13L3u1/yLjkQDUmbzpTKe5D0kKolZppnbPjxQp3Dg9IHN8ul54U
         1eMByVsjXGG1V12U11YhepInHuadS66zR5eyHIuQ9HAWuQ8W0QXYD6AWJvfQ0VBGL+mu
         DYLg==
X-Gm-Message-State: AOJu0YzHQB6fEv3NKS9MStwigimN4McZkFB1/ALBorQTqgfSO62Fqy3d
	dt+DL+3yuB6la8prmL2VVDHoiYAZdHNLx5m979A=
X-Google-Smtp-Source: AGHT+IGLykO+eu1IfUVnGQmCJjg+EWmIdm0yJAUP3ajk8AV8TszEIJqBzG7jGfu0PB6QQwr2x1JDOA==
X-Received: by 2002:a05:6a20:a115:b0:13d:df16:cf29 with SMTP id q21-20020a056a20a11500b0013ddf16cf29mr24351296pzk.15.1699191311062;
        Sun, 05 Nov 2023 05:35:11 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001c8a0879805sm4219711plb.206.2023.11.05.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 05:35:10 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf 2/2] selftests/bpf: get trusted cgrp from bpf_iter__cgroup directly
Date: Sun,  5 Nov 2023 21:34:58 +0800
Message-Id: <20231105133458.1315620-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f49843afde (selftests/bpf: Add tests for css_task iter combining
with cgroup iter) added a test which demonstrates how css_task iter can be
combined with cgroup iter. That test used bpf_cgroup_from_id() to convert
bpf_iter__cgroup->cgroup to a trusted ptr which is pointless now, since
with the previous fix, we can get a trusted cgroup directly from
bpf_iter__cgroup.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../testing/selftests/bpf/progs/iters_css_task.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
index e180aa1b1..9ac758649 100644
--- a/tools/testing/selftests/bpf/progs/iters_css_task.c
+++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
@@ -56,12 +56,9 @@ SEC("?iter/cgroup")
 int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
 {
 	struct seq_file *seq = ctx->meta->seq;
-	struct cgroup *cgrp, *acquired;
+	struct cgroup *cgrp = ctx->cgroup;
 	struct cgroup_subsys_state *css;
 	struct task_struct *task;
-	u64 cgrp_id;
-
-	cgrp = ctx->cgroup;
 
 	/* epilogue */
 	if (cgrp == NULL) {
@@ -73,20 +70,15 @@ int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
 	if (ctx->meta->seq_num == 0)
 		BPF_SEQ_PRINTF(seq, "prologue\n");
 
-	cgrp_id = cgroup_id(cgrp);
-
-	BPF_SEQ_PRINTF(seq, "%8llu\n", cgrp_id);
+	BPF_SEQ_PRINTF(seq, "%8llu\n", cgroup_id(cgrp));
 
-	acquired = bpf_cgroup_from_id(cgrp_id);
-	if (!acquired)
-		return 0;
-	css = &acquired->self;
+	css = &cgrp->self;
 	css_task_cnt = 0;
 	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
 		if (task->pid == target_pid)
 			css_task_cnt++;
 	}
-	bpf_cgroup_release(acquired);
+
 	return 0;
 }
 
-- 
2.20.1


