Return-Path: <bpf+bounces-57518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0985CAAC71E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F146500EEA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1F281369;
	Tue,  6 May 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crFuRmYe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B128031F;
	Tue,  6 May 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539864; cv=none; b=sqAVaW3pkvqhLqAM6qwnQ1cctfV2k02+LsbLYZDW1vwTJH5iJD8lv6jRv7OdxUnjvBTebY64XB8a1l7lsWqC9Oad5z8PH/b8AFfCC8VTvtB7Wf+Lkpl7SC400LeM8ve2cYcyNCY7BzplxezdFNKWSH4sQ5cRSSl+SxkAqMFrtVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539864; c=relaxed/simple;
	bh=sW13kym7zx4ViDbOcnm3+ukXceFDUUFLgexbLiiJ7iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+LEFVsY3DzruL6nuUC4MUELK4TC7O107nn22xoFnZESj5eXTxtKz2Qp7aqxPIJKxbkZczUFtCc4A6GpVZovDQNowgkXCABIGC3xH0wO7FTaGGMWo8pSTb3Ttp99VBbJ0JU3cxpZz5RuAfIOjjhAfa7k5obhgyYJy6CUC7f6Guk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crFuRmYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897DAC4CEE4;
	Tue,  6 May 2025 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539862;
	bh=sW13kym7zx4ViDbOcnm3+ukXceFDUUFLgexbLiiJ7iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crFuRmYeD62bNWCi1p2/vdyxVh6Zc6qzw7So6XMPd18NGPKZGmz60G9X4W6XVut86
	 u3hfQV2zF/DSNQmzxxpZGD1AGLcK3pVQQ3X9V0KFz5ZqIwZKuaY82DHWjpIxhZlSMf
	 WydW6Y9QXYWgY66EovgD9uaq0YwgYPQVqIwYDjgZAaizyiTrn0HmK1aIxzvNoojGHA
	 G50LlKk6wNJzyGBFMbcVuZnJoya2J+ag3D6LQBO+casJwprE149uLxuqWvgSXRDgAk
	 G4iWfJdsGWA5SPcyePT/AOSWMm/uVHaijMtmmX93tuwZnJW3gnTrE/7Xceo5lBZ2C9
	 41U34XExgjPnQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 1/3] bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
Date: Tue,  6 May 2025 15:57:25 +0200
Message-ID: <20250506135727.3977467-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506135727.3977467-1-jolsa@kernel.org>
References: <20250506135727.3977467-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to retrieve ref_ctr_offset for uprobe perf link,
which got somehow omitted from the initial uprobe link info changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/syscall.c           | 5 +++--
 kernel/trace/trace_uprobe.c    | 2 +-
 tools/include/uapi/linux/bpf.h | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 71d5ac83cf5d..16e95398c91c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6724,6 +6724,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from file_name */
 					__u64 cookie;
+					__u64 ref_ctr_offset;
 				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
 				struct {
 					__aligned_u64 func_name; /* in/out */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index df33d19c5c3b..4b5f29168618 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3800,14 +3800,14 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 				     struct bpf_link_info *info)
 {
+	u64 ref_ctr_offset, offset;
 	char __user *uname;
-	u64 addr, offset;
 	u32 ulen, type;
 	int err;
 
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &ref_ctr_offset,
 					&type, NULL);
 	if (err)
 		return err;
@@ -3819,6 +3819,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	info->perf_event.uprobe.name_len = ulen;
 	info->perf_event.uprobe.offset = offset;
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
+	info->perf_event.uprobe.ref_ctr_offset = ref_ctr_offset;
 	return 0;
 }
 #endif
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3386439ec9f6..d9cf6ed2c106 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1489,7 +1489,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 				    : BPF_FD_TYPE_UPROBE;
 	*filename = tu->filename;
 	*probe_offset = tu->offset;
-	*probe_addr = 0;
+	*probe_addr = tu->ref_ctr_offset;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 71d5ac83cf5d..16e95398c91c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6724,6 +6724,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from file_name */
 					__u64 cookie;
+					__u64 ref_ctr_offset;
 				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
 				struct {
 					__aligned_u64 func_name; /* in/out */
-- 
2.49.0


