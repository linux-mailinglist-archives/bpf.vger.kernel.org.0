Return-Path: <bpf+bounces-5434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4775A9FE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 10:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A94280F80
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1E04424;
	Thu, 20 Jul 2023 08:57:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C8199F5
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85816C433C8;
	Thu, 20 Jul 2023 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689843451;
	bh=eWsO3usRBxHzLz/MzFKOIEMz2QGTjBq5921O/fZkWio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mN8IXOYq6D2qJy2Cf1hagci1WaCtu05O541e5O39kDYn1Qhe0ELeV8YJJSaUf7V92
	 cgGBEHIoLwi4BXKYiQsgVvzBasJazE7dohFDKEK7P1xU/AUQBw9PCuC6qMK09iITdh
	 MJSB4zGewq9vRi7OIcxOhZjbBYuWYTbZuMevNN1/1HXJPwwG9Yr96o/X68ePuQUOcu
	 CKHaZ44FvM7LJLAOxd/I6b6qNop9ZX0wIPNNZlhdgpYCL7HTXvbyrfbqMWQ89MtMvt
	 v2msdB7rAPQ9EaS5AP4k44FmDeVGIvCgH1P8gHM59EDlFKeKEO3h+QmsmRLkGDD1mN
	 UVXKV6Z+M78wA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf 2/2] bpf: Disable preemption in bpf_event_output
Date: Thu, 20 Jul 2023 10:57:04 +0200
Message-ID: <20230720085704.190592-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720085704.190592-1-jolsa@kernel.org>
References: <20230720085704.190592-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We received report [1] of kernel crash, which is caused by
using nesting protection without disabled preemption.

The bpf_event_output can be called by programs executed by
bpf_prog_run_array_cg function that disabled migration but
keeps preemption enabled.

This can cause task to be preempted by another one inside the
nesting protection and lead eventually to two tasks using same
perf_sample_data buffer and cause crashes like:

  BUG: kernel NULL pointer dereference, address: 0000000000000001
  #PF: supervisor instruction fetch in kernel mode
  #PF: error_code(0x0010) - not-present page
  ...
  ? perf_output_sample+0x12a/0x9a0
  ? finish_task_switch.isra.0+0x81/0x280
  ? perf_event_output+0x66/0xa0
  ? bpf_event_output+0x13a/0x190
  ? bpf_event_output_data+0x22/0x40
  ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
  ? xa_load+0x87/0xe0
  ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
  ? release_sock+0x3e/0x90
  ? sk_setsockopt+0x1a1/0x12f0
  ? udp_pre_connect+0x36/0x50
  ? inet_dgram_connect+0x93/0xa0
  ? __sys_connect+0xb4/0xe0
  ? udp_setsockopt+0x27/0x40
  ? __pfx_udp_push_pending_frames+0x10/0x10
  ? __sys_setsockopt+0xdf/0x1a0
  ? __x64_sys_connect+0xf/0x20
  ? do_syscall_64+0x3a/0x90
  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixing this by disabling preemption in bpf_event_output.

[1] https://github.com/cilium/cilium/issues/26756
Cc: stable@vger.kernel.org
Reported-by:  Oleg "livelace" Popov <o.popov@livelace.ru>
Fixes: 2a916f2f546c bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 14c9a1a548c9..6826ebf750b0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -720,7 +720,6 @@ static DEFINE_PER_CPU(struct bpf_trace_sample_data, bpf_misc_sds);
 u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 		     void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
 {
-	int nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
 	struct perf_raw_frag frag = {
 		.copy		= ctx_copy,
 		.size		= ctx_size,
@@ -737,8 +736,13 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	};
 	struct perf_sample_data *sd;
 	struct pt_regs *regs;
+	int nest_level;
 	u64 ret;
 
+	preempt_disable();
+
+	nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
+
 	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bpf_misc_sds.sds))) {
 		ret = -EBUSY;
 		goto out;
@@ -753,6 +757,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
+	preempt_enable();
 	return ret;
 }
 
-- 
2.41.0


