Return-Path: <bpf+bounces-28028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF48B46D6
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C0F1F227C1
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3478A932;
	Sat, 27 Apr 2024 15:27:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03158A934;
	Sat, 27 Apr 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714231675; cv=none; b=G4+muYL9GKqOcqwkG7O4zqLt8KJ3e2gejYOcSmhHZ5Y3UdiWMLbrJGldArUORY8DHvvNQMlGPWzAwSTmrsALlsr7nyNofPEkXuCKyU7sWLeBq+Rs7JrMr3i8+pn8x7Evs+vcK2TukM4sWlTKW6UtuM7+MksoBR6ykjWQZ6f8x2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714231675; c=relaxed/simple;
	bh=+sN9NUCa3ushUzlEGn+2urtd+hdtrRzzNExlOeY09/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqN2o1lLziiRBpC4DYhxnHwneZ+Kh00aFo3Bhswj+84Ii0wSe/pRODN+tTsmdmmMlOp43G1fpj+hfeplXSz8BBuAfmlOrlM/rxhe8qDhV3gyIw7tcLs9OAYNomSFjPdoXLbb7DcS0Ed+IriftKcMq+gBG+gJuqhbBvE7qCYg//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next] bpf: add support to read cpu_entry in bpf program
Date: Sat, 27 Apr 2024 17:18:25 +0200
Message-ID: <20240427151825.174486-1-dev@der-flo.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new field "cpu_entry" to bpf_perf_event_data which could be read by
bpf programs attached to perf events. The value contains the CPU value
recorded by specifying sample_type with PERF_SAMPLE_CPU when calling
perf_event_open().

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 include/uapi/linux/bpf_perf_event.h       |  4 ++++
 kernel/trace/bpf_trace.c                  | 13 +++++++++++++
 tools/include/uapi/linux/bpf_perf_event.h |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..4856b4396ece 100644
--- a/include/uapi/linux/bpf_perf_event.h
+++ b/include/uapi/linux/bpf_perf_event.h
@@ -14,6 +14,10 @@ struct bpf_perf_event_data {
 	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
 	__u64 addr;
+	struct {
+		u32	cpu;
+		u32	reserved;
+	}			cpu_entry;
 };
 
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index afb232b1d7c2..2b303221af5c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2176,6 +2176,11 @@ static bool pe_prog_is_valid_access(int off, int size, enum bpf_access_type type
 		if (!bpf_ctx_narrow_access_ok(off, size, size_u64))
 			return false;
 		break;
+	case bpf_ctx_range(struct bpf_perf_event_data, cpu_entry):
+		bpf_ctx_record_field_size(info, size_u64);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_u64))
+			return false;
+		break;
 	default:
 		if (size != sizeof(long))
 			return false;
@@ -2208,6 +2213,14 @@ static u32 pe_prog_convert_ctx_access(enum bpf_access_type type,
 				      bpf_target_off(struct perf_sample_data, addr, 8,
 						     target_size));
 		break;
+	case offsetof(struct bpf_perf_event_data, cpu_entry):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_perf_event_data_kern,
+						       data), si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_perf_event_data_kern, data));
+		*insn++ = BPF_LDX_MEM(BPF_DW, si->dst_reg, si->dst_reg,
+				      bpf_target_off(struct perf_sample_data, cpu_entry, 8,
+						     target_size));
+		break;
 	default:
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_perf_event_data_kern,
 						       regs), si->dst_reg, si->src_reg,
diff --git a/tools/include/uapi/linux/bpf_perf_event.h b/tools/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..4856b4396ece 100644
--- a/tools/include/uapi/linux/bpf_perf_event.h
+++ b/tools/include/uapi/linux/bpf_perf_event.h
@@ -14,6 +14,10 @@ struct bpf_perf_event_data {
 	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
 	__u64 addr;
+	struct {
+		u32	cpu;
+		u32	reserved;
+	}			cpu_entry;
 };
 
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
-- 
2.44.0


