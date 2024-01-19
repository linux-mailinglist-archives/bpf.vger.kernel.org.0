Return-Path: <bpf+bounces-19887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC2832847
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7C21C213DE
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE154C604;
	Fri, 19 Jan 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkxM2nSC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572AF1D690
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662327; cv=none; b=legaKVjov52WWnFwdVF8YGUYX8gupX8Wy3v5jjIkprpV6P4KpyZmb/tIEiDMzhAe6+lqWbc6OzD05xZpkF0WPGzodpR0afRkxH8jts73zlmTcQdTXZ9Ovges33FpB3HZbS1NPAUEuw3sgrYoa1DDKMHxEEjS+gCiO3a5TpEaneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662327; c=relaxed/simple;
	bh=K70FWn164oCR1shtndUQlraFFEUFQwzC5PyGb72O47U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oh/u6W4EbjPM+fCsyZwdYdou/HMJq1mwI/ihtzEpAqsFkOIBvb72kOS6pStj7E+sr/WmUzdBdEaDNIpA6ur4SGdh7+PLJvIJJJpXC1Jmm2iOYIbgATR7geyo1zStfdiejA/yxwDRjxDOMNIUqRgtbtBOGYTmi5NL1b4Ri8mvgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkxM2nSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E97C433F1;
	Fri, 19 Jan 2024 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705662326;
	bh=K70FWn164oCR1shtndUQlraFFEUFQwzC5PyGb72O47U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkxM2nSCjbEk8qmiWBOUW1vv+wOJ6qPha2hwNfBvheH7wk0a5tAwDIYbu0VJu0+tY
	 HGjpDjZRZK773hdW0dvmm0Khit7NOyR8RFsj5dIF3t/ttH5vnAArvLDnr1IcAlx4TH
	 Ms7/gAuRJJZEgiYtpT4N6mjLiUcqWwqdV0JVAYp5NccEQJ/hadj4M2gXIoGxsxIoOi
	 9sHyQ1WTyuKZlb9HgR4at0RpVaRFZJ1Xlx4A/pu8I6cUz4I0qBI0W91nvQmS4WH6VT
	 G0CBprl6UEplFvWyRVXV2IA0J4FBag8aGLJEKS/3DYR8xgb+fXeoZWOYF8Ohgk0+Zf
	 ct6uNISNwcLlg==
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
Subject: [PATCHv2 bpf-next 1/8] bpf: Add cookie to perf_event bpf_link_info records
Date: Fri, 19 Jan 2024 12:04:58 +0100
Message-ID: <20240119110505.400573-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
References: <20240119110505.400573-1-jolsa@kernel.org>
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
 include/uapi/linux/bpf.h       | 6 ++++++
 kernel/bpf/syscall.c           | 4 ++++
 tools/include/uapi/linux/bpf.h | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a00f8a5623e1..181e74433272 100644
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
@@ -6589,14 +6590,19 @@ struct bpf_link_info {
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
 					__u64 missed;
+					__u64 cookie;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
 					__u32 name_len;
+					__u32 :32;
+					__u64 cookie;
 				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
 				struct {
 					__u64 config;
 					__u32 type;
+					__u32 :32;
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
index a00f8a5623e1..181e74433272 100644
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
@@ -6589,14 +6590,19 @@ struct bpf_link_info {
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
 					__u64 missed;
+					__u64 cookie;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
 					__u32 name_len;
+					__u32 :32;
+					__u64 cookie;
 				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
 				struct {
 					__u64 config;
 					__u32 type;
+					__u32 :32;
+					__u64 cookie;
 				} event; /* BPF_PERF_EVENT_EVENT */
 			};
 		} perf_event;
-- 
2.43.0


