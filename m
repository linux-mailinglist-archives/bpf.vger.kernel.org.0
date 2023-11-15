Return-Path: <bpf+bounces-15128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A77ED10E
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C810D2817AB
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209753EA7E;
	Wed, 15 Nov 2023 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7mv8naE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3E3EA62;
	Wed, 15 Nov 2023 19:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA8AC433C8;
	Wed, 15 Nov 2023 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700078347;
	bh=NNVtTDSA2SCvFpMrYU8VXGiEIFvdbpZIOK5Y/8yQ6a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7mv8naEtjyL3BxoKq+6BJEi1epzDxU7ZrXJ1gyFA7eiRTZeMeyfGSJVefvujdCaM
	 WENf4RLw2hr6bjfOzYU5Tw6I0BxyDsUQ5KA0xcyndE2mIFiqRM8OF2NRtnQSZponkV
	 c23p2YpC/nUlWAIWZA9S/scRVmAka42pP8hwXwFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 266/379] perf record: Fix BTF type checks in the off-cpu profiling
Date: Wed, 15 Nov 2023 14:25:41 -0500
Message-ID: <20231115192700.865914644@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 0e501a65d35bf72414379fed0e31a0b6b81ab57d ]

The BTF func proto for a tracepoint has one more argument than the
actual tracepoint function since it has a context argument at the
begining.  So it should compare to 5 when the tracepoint has 4
arguments.

  typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct *, struct task_struct *, unsigned int);

Also, recent change in the perf tool would use a hand-written minimal
vmlinux.h to generate BTF in the skeleton.  So it won't have the info
of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
check the type in the kernel.

Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch")
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Song Liu <song@kernel.org>
Cc: Hao Luo <haoluo@google.com>
CC: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230922234444.3115821-1-namhyung@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 01f70b8e705a8..21f4d9ba023d9 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -98,7 +98,7 @@ static void off_cpu_finish(void *arg __maybe_unused)
 /* v5.18 kernel added prev_state arg, so it needs to check the signature */
 static void check_sched_switch_args(void)
 {
-	const struct btf *btf = bpf_object__btf(skel->obj);
+	const struct btf *btf = btf__load_vmlinux_btf();
 	const struct btf_type *t1, *t2, *t3;
 	u32 type_id;
 
@@ -116,7 +116,8 @@ static void check_sched_switch_args(void)
 		return;
 
 	t3 = btf__type_by_id(btf, t2->type);
-	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 4) {
+	/* btf_trace func proto has one more argument for the context */
+	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 5) {
 		/* new format: pass prev_state as 4th arg */
 		skel->rodata->has_prev_state = true;
 	}
-- 
2.42.0




