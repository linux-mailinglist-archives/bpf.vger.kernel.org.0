Return-Path: <bpf+bounces-6353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D603F7685AF
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1202B1C209C3
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F22102;
	Sun, 30 Jul 2023 13:42:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08120FF
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D9C433C8;
	Sun, 30 Jul 2023 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724559;
	bh=utKDWO49AuejMEatoqjlcZuGpD8iQDlQ5/Hvs1h8uJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYYkhuW9HVQUJK1QfWk7w4X6X4SoqhHEFqGmfE+ElGNAvVBdup7CGpPRMWrPgDRZf
	 aE5GlAB7ReOaJZyFA890H4odSWfkBf2aF2yQBERtP/+uyDq4UFIzqRLXIen9XV01Ev
	 DvAUyVP8sIf6CuH5Szi3+x10Kx3AHSjJFYvt2CRASX0jOSAl6iLhMPlvCs52KhomAh
	 4PvAnQTwX5j6224o9lfmWchE6eUFanreU/8gXuErIFWBZQtf+Rw8os+L8g9tXMqLrC
	 O0eIJndEBzXwLnRofmmuL9HFvmuzpTlSdecUkrNoFgSQ9x7LFHmHubTywpgabi+7KL
	 TOaDSDr3hKUig==
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv5 bpf-next 01/28] bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
Date: Sun, 30 Jul 2023 15:41:56 +0200
Message-ID: <20230730134223.94496-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730134223.94496-1-jolsa@kernel.org>
References: <20230730134223.94496-1-jolsa@kernel.org>
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
index 70da85200695..7abb382dc6c1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1186,7 +1186,9 @@ enum bpf_perf_event_type {
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
-#define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
+enum {
+	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+};
 
 /* link_create.netfilter.flags used in LINK_CREATE command for
  * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70da85200695..7abb382dc6c1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1186,7 +1186,9 @@ enum bpf_perf_event_type {
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
-#define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
+enum {
+	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+};
 
 /* link_create.netfilter.flags used in LINK_CREATE command for
  * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
-- 
2.41.0


