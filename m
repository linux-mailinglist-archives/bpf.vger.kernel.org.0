Return-Path: <bpf+bounces-8823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFB978A6DF
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4454D280D86
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA5D10FE;
	Mon, 28 Aug 2023 07:56:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580FEC2
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEF6C433C8;
	Mon, 28 Aug 2023 07:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209374;
	bh=72JVCuuga8W/DsobUv9aR/VCA2beTgnUF/dSaVUyqlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Feevgiw4OMjIoVFwihcv/4RCvMXRLgdo3JmMF1G36/wX3gwz2ohfgzQEOTds7v6qh
	 smLy+DDL/dXodzItr+EzuO5ZdBW6UFK2pCzkUL0wPFZJgyWI7pbveoyxEJZbpl1xz3
	 A8ZTmLiM8mX+S9cMbXE3Hy1fzhRzflTUp2UEeayYPYyBKndO4oBwI/Pe5FBlEnsK9x
	 jTLp/fD74PYmhIGLt7CCxN41nkqVxZ8De/BdTZHUJ/rrf1knvMI0W68jldSDPaH+tK
	 jtVyTii2ciLfpKmrD9ZGA6AzCsbXgdLxZ8PXNgF4KtF8tSV/nXeKDKnUjP3ocHECPC
	 MyarE3XzStMKg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH bpf-next 03/12] bpf: Count stats for kprobe_multi programs
Date: Mon, 28 Aug 2023 09:55:28 +0200
Message-ID: <20230828075537.194192-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to gather stats for kprobe_multi programs.

We now count:
  - missed stats due to bpf_prog_active protection (always)
  - cnt/nsec of the bpf program execution (if kernel.bpf_stats_enabled=1)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a7264b2c17ad..0a8685fc1eee 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2706,18 +2706,24 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		.link = link,
 		.entry_ip = entry_ip,
 	};
+	struct bpf_prog *prog = link->link.prog;
 	struct bpf_run_ctx *old_run_ctx;
+	u64 start;
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
+		bpf_prog_inc_misses_counter(prog);
 		err = 0;
 		goto out;
 	}
 
+
 	migrate_disable();
 	rcu_read_lock();
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	err = bpf_prog_run(link->link.prog, regs);
+	start = bpf_prog_start_time();
+	err = bpf_prog_run(prog, regs);
+	bpf_prog_update_prog_stats(prog, start);
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
 	migrate_enable();
-- 
2.41.0


