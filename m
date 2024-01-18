Return-Path: <bpf+bounces-19799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E483163A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A511C24F07
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96341F94D;
	Thu, 18 Jan 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwZA+3+/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABE1BDFD
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571676; cv=none; b=RwvwBke4mmwnVq6THI0iYoXb5jPJCoCD8FRCPQKeAD8fodv2BFRzN0DfkH005ceCpDdqcuzNnr97HxUIZOjHopavxKFGpDb485Iel2KvS4b5yIpmiCXbOwH4AvR4vCRTGVBfmPCz5NNlcr8Cbt4ph2eTroX99eB4w4ep9wYUnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571676; c=relaxed/simple;
	bh=/CVw6iEdBxQ82N+X3APdZM60F3VsUg7RvgxXxoTvS1k=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=N3i/aV+Mg6KIm7q73JeYAoOECOwszxFXUXBCmBUSMaamb/qMRXjuGPqah+hEyGoBTvvgZGaR3+//GzbPqLf9eGeKza9ykvs6J4Zjl1nmCU9seidrWbYyBnKWAHiT2xLR8YLfuSP2YloinTY1brxYmBe51MaA3VpHyA0kTJPnoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwZA+3+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22202C43390;
	Thu, 18 Jan 2024 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571676;
	bh=/CVw6iEdBxQ82N+X3APdZM60F3VsUg7RvgxXxoTvS1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwZA+3+/MYquqoRnk2mE1WBQR1uc4bJV5Q1Jko1wFJb4Hm4k0746npmGHkIPQ2tqZ
	 765bEISTDBmNgvx9qbzusPIfV8JNVe1cwYVTFrBJe9XXH/89UqPLsZyN+kCCsB3SEM
	 tj16po1nynqwsOcD04aDayeTnf66zEMKmZXT3jtlw9kzWfP+1tc8xxeAaYC37BK6hw
	 7t91TJXXWSaweuEhvEntv6JiKQ+QpHgwKCo1hQK+zegCP4umJ2WYurqcThjfF79o9T
	 FsKiDmWXg/2z+zcoJ0VHM6PUuDkiAWkjvxqfIMXcnb5MCtNgJWnS/GVAZSw75LLO2C
	 FRv/6rty5fvfg==
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
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/8] bpf: Add cookie to perf_event bpf_link_info records
Date: Thu, 18 Jan 2024 10:54:09 +0100
Message-ID: <20240118095416.989152-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118095416.989152-1-jolsa@kernel.org>
References: <20240118095416.989152-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment we don't store cookie for perf_event probes,
while we do that for the rest of the probes.

Adding cookie fields to struct bpf_link_info perf event
probe records:

  perf_event.uprobe
  perf_event.kprobe
  perf_event.tracepoint
  perf_event.perf_event

And the code to store that in bpf_link_info struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 4 ++++
 kernel/bpf/syscall.c           | 4 ++++
 tools/include/uapi/linux/bpf.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a00f8a5623e1..b823d367a83c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6582,6 +6582,7 @@ struct bpf_link_info {
 					__aligned_u64 file_name; /* in/out */
 					__u32 name_len;
 					__u32 offset; /* offset from file_name */
+					__u64 cookie;
 				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
 				struct {
 					__aligned_u64 func_name; /* in/out */
@@ -6589,14 +6590,17 @@ struct bpf_link_info {
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
 					__u64 missed;
+					__u64 cookie;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
 					__u32 name_len;
+					__u64 cookie;
 				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
 				struct {
 					__u64 config;
 					__u32 type;
+					__u64 cookie;
 				} event; /* BPF_PERF_EVENT_EVENT */
 			};
 		} perf_event;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a1f18681721c..13193aaafb64 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3501,6 +3501,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 	if (!kallsyms_show_value(current_cred()))
 		addr = 0;
 	info->perf_event.kprobe.addr = addr;
+	info->perf_event.kprobe.cookie = event->bpf_cookie;
 	return 0;
 }
 #endif
@@ -3526,6 +3527,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	else
 		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
 	info->perf_event.uprobe.offset = offset;
+	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	return 0;
 }
 #endif
@@ -3553,6 +3555,7 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
 	ulen = info->perf_event.tracepoint.name_len;
 	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
+	info->perf_event.tracepoint.cookie = event->bpf_cookie;
 	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL, NULL);
 }
 
@@ -3561,6 +3564,7 @@ static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
 {
 	info->perf_event.event.type = event->attr.type;
 	info->perf_event.event.config = event->attr.config;
+	info->perf_event.event.cookie = event->bpf_cookie;
 	info->perf_event.type = BPF_PERF_EVENT_EVENT;
 	return 0;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a00f8a5623e1..b823d367a83c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6582,6 +6582,7 @@ struct bpf_link_info {
 					__aligned_u64 file_name; /* in/out */
 					__u32 name_len;
 					__u32 offset; /* offset from file_name */
+					__u64 cookie;
 				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
 				struct {
 					__aligned_u64 func_name; /* in/out */
@@ -6589,14 +6590,17 @@ struct bpf_link_info {
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
 					__u64 missed;
+					__u64 cookie;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
 					__u32 name_len;
+					__u64 cookie;
 				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
 				struct {
 					__u64 config;
 					__u32 type;
+					__u64 cookie;
 				} event; /* BPF_PERF_EVENT_EVENT */
 			};
 		} perf_event;
-- 
2.43.0


