Return-Path: <bpf+bounces-14402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752747E3FF8
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3133A28105C
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0730CE8;
	Tue,  7 Nov 2023 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fQrQdKZj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667802FE3B
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 13:22:24 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D14A93
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 05:22:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso2785392b3a.1
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 05:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699363342; x=1699968142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnY5L7zS0GT7b91/4e+NG++hSn4g9OQWiY3TrFeXNlc=;
        b=fQrQdKZj90Un3Ekm1TfpFWhFWSfiAQR/qQiUBgx3D3rXHdEMvRJzRcnr7yGa8zgYgZ
         QWaWU8MrXG2NQLx6p8xDKLwVx85LWSysRwZdkb/QrLZiWyowjWJDZ0PlynmsL6RDSP3w
         Ye9AYLlgap/CM0H2haCRuMZj9n2HCpQJZ1wnohWxAWm/lSpGG3CtPZHHBtPTeYhJ/HNP
         V+oJFfn0vhsK0p7GHEuzR11qE7jkyX4mGHFyQMlFvXSOpaTtiRImIJ0JeZpPxngTIomh
         Xw4VKqp7IhnNaGRsDm+HtdKQtxcHPgkWfGDIj3eSnffzBA2I729bVPIa/QFUPlTSqZpu
         Nsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363342; x=1699968142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnY5L7zS0GT7b91/4e+NG++hSn4g9OQWiY3TrFeXNlc=;
        b=O5m70iJ/Lvomj5+z76exmtv68HtEfeTfPbvg1ZZ9a9a5c0wtgm7LOQ1wmfz+Vk4ylN
         QlFgqXyUgMklJbfrAgsrFRCIyI8dKDBcGBtBrv8P2Ww/E7EDJF1OoRjYasdOh+EqnsgK
         qIQHP9Gkd2eedneOcZj+jTX8pQ7x1z3bKFJPiTNKbtKDUkCoCOQVu4Gyx/XOFjg8pS4n
         fd9eGMgOm0QiHgOhDhdt55ZVgVK6hsJZmvOJWaNMkbTb9n64FiIiIZSxtWvFevkeWYN5
         qBsVCecf6vGKKdTrKMS06cZ2oRMtmEcAOuqXEt+r+rls/DToMkrFQYCGP8fsgb/vq965
         pgqg==
X-Gm-Message-State: AOJu0YxmLjEsJDmic6XtBVCETkJh1MIuqviZUZK3gD7Glkaqizz8+bh2
	lNwWTM5N78kHSWSQGb00eQjnujPaVtTcvXr8Vw0=
X-Google-Smtp-Source: AGHT+IEs8O5ut0r1aid3tAhLxsW5KeYnRCTcwZ6HFDuc3R+bni6l8JAgj3S5BO3g8GBDMXOH7zEW2w==
X-Received: by 2002:a05:6a21:3393:b0:137:23f1:4281 with SMTP id yy19-20020a056a21339300b0013723f14281mr32232981pzb.12.1699363342395;
        Tue, 07 Nov 2023 05:22:22 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.70])
        by smtp.gmail.com with ESMTPSA id y36-20020a056a00182400b0068790c41ca2sm7218881pfa.27.2023.11.07.05.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:22:22 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf v2 2/2] selftests/bpf: get trusted cgrp from bpf_iter__cgroup directly
Date: Tue,  7 Nov 2023 21:22:04 +0800
Message-Id: <20231107132204.912120-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231107132204.912120-1-zhouchuyi@bytedance.com>
References: <20231107132204.912120-1-zhouchuyi@bytedance.com>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
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


