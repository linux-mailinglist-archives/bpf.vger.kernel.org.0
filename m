Return-Path: <bpf+bounces-5442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3E75AD13
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0621C21383
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552AA17756;
	Thu, 20 Jul 2023 11:36:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D817744
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CACC433C7;
	Thu, 20 Jul 2023 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689852965;
	bh=d7+hmam9/TesJxs4w+SMUGKpL20xYWIxXk3Rgy9dj/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phHmWU1zIMcWZMOrLBYyj2Fg/087dmMbWGB34LtGFax0Sy2bSJZSdr5wnawVbzlat
	 VH+/x4SXFRHL2feUVYLubo/Sz9nIKxvbjeuW6/N2MF2NljA2UGDXJ/B1ykdThiAoOn
	 Fq+M+BJxwAFef6y/8/BzDF0+FtsbRNIw8Z4HVAWU99ZgP7ssdxg/J6VH3nvqoTDJks
	 nsTrQA6rSiGeg9Bm4ekh7sCmoRHmDs4XrlTSbADxJ8TTYToMcBiVwdEK/X5ttZnjAl
	 jWW956RKiionJBy5mBKgl9Fu8WEZg3uj790JBsjgMABshta2/TIHw+q7dc99pNBkZc
	 syGLSb0DrUfcA==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 01/28] bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
Date: Thu, 20 Jul 2023 13:35:23 +0200
Message-ID: <20230720113550.369257-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720113550.369257-1-jolsa@kernel.org>
References: <20230720113550.369257-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching BPF_F_KPROBE_MULTI_RETURN macro to anonymous enum,
so it'd show up in vmlinux.h. There's not functional change
compared to having this as macro.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 4 +++-
 tools/include/uapi/linux/bpf.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9ed59896ebc5..730c0ec99a11 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1178,7 +1178,9 @@ enum bpf_perf_event_type {
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
-#define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
+enum {
+	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+};
 
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 600d0caebbd8..f1ce5c149eee 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1178,7 +1178,9 @@ enum bpf_perf_event_type {
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
-#define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
+enum {
+	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+};
 
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
-- 
2.41.0


