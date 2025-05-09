Return-Path: <bpf+bounces-57860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABEAB18D5
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540951BA229C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7E22F764;
	Fri,  9 May 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJsqWgUg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4022F166;
	Fri,  9 May 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804962; cv=none; b=pOqcFtOOYYv97r0Y7YI3Qt7sRbKC/VfC2hrXqyuslrWmrEXQQB8WamNk4ZR1sbuSSDoDL60v6Zclrpm0czL2vxvKRjPPZO5nPd5fBm2Mb7kQJR06Evs0+x0UUwCXodZ/8I5fMH0sZVz8lytTMZm52v4mHDurFzXr0v8RP7jisu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804962; c=relaxed/simple;
	bh=4zIqPekil3Gn1cy+8PVvvu6qmWr6DsChIb/OZqLzFM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6dOMU6yApvz+JY+symok8W9E4Bks6G0cVkk/WMOcMec52vUtU3DW0RRukYGnpPb9SbALlRTbXAi9yjqQlJaotMEBZi099nXnx254iEZplaBJxOyUzuucG1IpPCCFP5CE8XH45RSL0HfMsglLlssEReSjHYbHOQqQOcnQ3arrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJsqWgUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F78C4CEE4;
	Fri,  9 May 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746804961;
	bh=4zIqPekil3Gn1cy+8PVvvu6qmWr6DsChIb/OZqLzFM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJsqWgUgSpp3UFkelufKPH5GL59Yg+W75F9Az3JIzvO6OxJPHNODKoAzpfADw2eya
	 BoO/Ma5yxg47SiiyB6G1U9wLpVkj68Rg1LtjjR0dZ1YDwE5bNYoPX0lG0vmX7lCz1K
	 UGIkzMdF7uOmI2jRMWeRogDDPcSYQN4k6d4mWL3hiRS0XMgT1KJnqWgLgqCXxDlp/w
	 8EXXtEw4RuO2GlzhpcCUcm/2jUs6dmpspBAbT4kyMzwoZM4MXdB7FE2WAj5azsHySg
	 dbVyXU/7pXGxYIa2zKYsjHmzbn6C6ffSkdGZHIsCnMdILjtIQefiZxo3gOul3f1K7T
	 IunX7AamzM0Rw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCHv2 bpf-next 1/3] bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
Date: Fri,  9 May 2025 17:35:37 +0200
Message-ID: <20250509153539.779599-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509153539.779599-1-jolsa@kernel.org>
References: <20250509153539.779599-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to retrieve ref_ctr_offset for uprobe perf link,
which got somehow omitted from the initial uprobe link info changes.

Acked-by: Yafang Shao <laoar.shao@gmail.com>
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


