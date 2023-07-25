Return-Path: <bpf+bounces-5807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF7760D57
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7B62816EC
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E2912B99;
	Tue, 25 Jul 2023 08:42:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A4944B
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 08:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEFBC433C9;
	Tue, 25 Jul 2023 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690274541;
	bh=fo0v5P0JSUACaPdDTYgpPP1FbJZQh204rapPNYt2lc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AE49/xcw1BVfDggCoL685KhXsFBEp3vJwug4w7VcZF3xHwfjQvg5owH35lvivxfIg
	 K3QVCP7Ha+xNK0XpTZDEXFdhWaoX58Kns+rd/syo2ZNmM7+lz7Wvi18CcjcCDUlx64
	 EOS18jF8q76pPaZ/Ww73cMm3qroidYLKnxjnA+oWNXS7uVCSXTeOGK4Wa/r//CVo/g
	 Gm1c3O0+4Y1zG0LZi3oB/oiMMON5I86uRrlpSzLWrbwJmPv6ujzzEnmmMLj0vfJ7lx
	 qK0nUg+Zbt7d1GoSLEPGA3BRqoD7V5VI+F01EnQIVGPavosCVAL+ChjJWKJbjAidld
	 iAgZHpxjdBeGw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf 1/2] bpf: Disable preemption in bpf_perf_event_output
Date: Tue, 25 Jul 2023 10:42:05 +0200
Message-ID: <20230725084206.580930-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725084206.580930-1-jolsa@kernel.org>
References: <20230725084206.580930-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nesting protection in bpf_perf_event_output relies on disabled
preemption, which is guaranteed for kprobes and tracepoints.

However bpf_perf_event_output can be also called from uprobes context
through bpf_prog_run_array_sleepable function which disables migration,
but keeps preemption enabled.

This can cause task to be preempted by another one inside the nesting
protection and lead eventually to two tasks using same perf_sample_data
buffer and cause crashes like:

  kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
  BUG: unable to handle page fault for address: ffffffff82be3eea
  ...
  Call Trace:
   ? __die+0x1f/0x70
   ? page_fault_oops+0x176/0x4d0
   ? exc_page_fault+0x132/0x230
   ? asm_exc_page_fault+0x22/0x30
   ? perf_output_sample+0x12b/0x910
   ? perf_event_output+0xd0/0x1d0
   ? bpf_perf_event_output+0x162/0x1d0
   ? bpf_prog_c6271286d9a4c938_krava1+0x76/0x87
   ? __uprobe_perf_func+0x12b/0x540
   ? uprobe_dispatcher+0x2c4/0x430
   ? uprobe_notify_resume+0x2da/0xce0
   ? atomic_notifier_call_chain+0x7b/0x110
   ? exit_to_user_mode_prepare+0x13e/0x290
   ? irqentry_exit_to_user_mode+0x5/0x30
   ? asm_exc_int3+0x35/0x40

Fixing this by disabling preemption in bpf_perf_event_output.

Cc: stable@vger.kernel.org
Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5f2dcabad202..14c9a1a548c9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -661,8 +661,7 @@ static DEFINE_PER_CPU(int, bpf_trace_nest_level);
 BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags, void *, data, u64, size)
 {
-	struct bpf_trace_sample_data *sds = this_cpu_ptr(&bpf_trace_sds);
-	int nest_level = this_cpu_inc_return(bpf_trace_nest_level);
+	struct bpf_trace_sample_data *sds;
 	struct perf_raw_record raw = {
 		.frag = {
 			.size = size,
@@ -670,7 +669,12 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 		},
 	};
 	struct perf_sample_data *sd;
-	int err;
+	int nest_level, err;
+
+	preempt_disable();
+
+	sds = this_cpu_ptr(&bpf_trace_sds);
+	nest_level = this_cpu_inc_return(bpf_trace_nest_level);
 
 	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
 		err = -EBUSY;
@@ -691,6 +695,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 
 out:
 	this_cpu_dec(bpf_trace_nest_level);
+	preempt_enable();
 	return err;
 }
 
-- 
2.41.0


