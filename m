Return-Path: <bpf+bounces-64351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41CB11BD9
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613F35A472D
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C82E9735;
	Fri, 25 Jul 2025 10:08:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217B2E3365;
	Fri, 25 Jul 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438118; cv=none; b=qT2+gAo2gxRsxH6h4RxRWSh5ES9okR+i5M/X3kU/oZ7IMqc+b7Vf+kPIis0++jEmQCmKjTkOLXoSQyPlkP7oQUBqMuT7xxy8FapBqmoJcKk9tJP3ZG6GTGkSgT5SHeMSr5dF+2X92wW8zsYr2hb+ujxpVWXUF5RXOJqPfENhcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438118; c=relaxed/simple;
	bh=7cyml8Yx9LrT/GiCd2nhThh6sBVeJwNVx9qws069z5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XE3nFl3lYYjeba9sRlLy7Q8KNRwleWh3mm5rGnVuNI+hjwECTCZKCERItW7eCTFruKFA4aGLUtQUuXwhkWHTTJcQqV63A37OmJeq9NDuNMoF3Mt5DZxcVkmiis4GEWr+8dTZDVJkkWupTqxzkx6UwPg4GzhlNKJ6tIVfZPimfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31CCF2C1E;
	Fri, 25 Jul 2025 03:08:29 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEFAC3F5A1;
	Fri, 25 Jul 2025 03:08:31 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 25 Jul 2025 11:08:12 +0100
Subject: [PATCH RESEND v3 2/6] bpf: Add bpf_perf_event_aux_pause kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-perf_aux_pause_resume_bpf_rebase-v3-2-ae21deb49d1a@arm.com>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-ae21deb49d1a@arm.com>
In-Reply-To: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-ae21deb49d1a@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 James Clark <james.clark@linaro.org>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753438103; l=2404;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7cyml8Yx9LrT/GiCd2nhThh6sBVeJwNVx9qws069z5M=;
 b=S3seupvm0QeNkZqul2qen6v8J36ZvOvtFO7fQxpdxHey9MkJThqfrynJ8u1fMJvbOiIe3yy3y
 7Xy5mVC2zOOAyIY97w/kxSGN1R/cn5VGJAiKEIdi+Ru3IqxHLUu065C
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The bpf_perf_event_aux_pause kfunc is introduced for pause and resume
the Perf AUX trace used by eBPF programs.

An attached tracepoint (e.g., ftrace tracepoint or a dynamic tracepoint
using uprobe or kprobe) can invoke bpf_perf_event_aux_pause() to pause
or resume AUX trace. This is useful for fine-grained tracing.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/trace/bpf_trace.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae61a5d60b43c764d3e267bd32e1085..fbed1f9a92cce666e2a61d6bfceaabfd5efade1c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -704,6 +704,61 @@ static const struct bpf_func_proto bpf_perf_event_output_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_perf_event_aux_pause(void *p__map, u64 flags, bool pause)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	unsigned int cpu = smp_processor_id();
+	u64 index = flags & BPF_F_INDEX_MASK;
+	struct bpf_event_entry *ee;
+
+	if (map->map_type != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
+		return -EINVAL;
+
+	/* Disabling IRQ avoids race condition with perf event flows. */
+	guard(irqsave)();
+
+	if (unlikely(flags & ~(BPF_F_INDEX_MASK)))
+		return -EINVAL;
+
+	if (index == BPF_F_CURRENT_CPU)
+		index = cpu;
+
+	if (unlikely(index >= array->map.max_entries))
+		return -E2BIG;
+
+	ee = READ_ONCE(array->ptrs[index]);
+	if (!ee)
+		return -ENOENT;
+
+	if (!has_aux(ee->event))
+		return -EINVAL;
+
+	perf_event_aux_pause(ee->event, pause);
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(perf_event_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_perf_event_aux_pause, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(perf_event_kfunc_set_ids)
+
+static const struct btf_kfunc_id_set bpf_perf_event_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &perf_event_kfunc_set_ids,
+};
+
+static int __init bpf_perf_event_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					 &bpf_perf_event_kfunc_set);
+}
+
+late_initcall(bpf_perf_event_kfuncs_init);
+
 static DEFINE_PER_CPU(int, bpf_event_output_nest_level);
 struct bpf_nested_pt_regs {
 	struct pt_regs regs[3];

-- 
2.34.1


