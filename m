Return-Path: <bpf+bounces-6796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EADBF76E18A
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284C61C21224
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55381097E;
	Thu,  3 Aug 2023 07:34:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315C9457
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31714C433C7;
	Thu,  3 Aug 2023 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048074;
	bh=DgurW+ClGnIuFEoVNq0gV58iilNtKPN0Du1/CpMy5sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dES09JXRTdXdfIUszCzt2uzBZNU6snEwSuJ88wnsvVYSYPKbR52CBwDLW7elsBha6
	 qi86zR+5DUDGFQlU07A3qvHJJO++ue23Jaw1H8btq7O+TdEOn8YmhhESw7sSHj00Rq
	 ZOMYXgVzaCYtGUXUbDYq4Tj9Pu4R2h7qPFFadR5ADNwgNvIMtV/kvBAOM91hQACqqA
	 bKAEfkVfYlreyJw2i/rZ+qiaqRY/rM6ctjoxn6xLgYmy5SlWrThP6e/obIuCE+qOX7
	 HSCOSNh3Oztz/CKO41e9FpT7U6njNcVQio3aQ0eyOBS0okinC34UM9VKNHSclwW0dZ
	 D6DW7Pom64POw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv6 bpf-next 01/28] bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
Date: Thu,  3 Aug 2023 09:33:53 +0200
Message-ID: <20230803073420.1558613-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
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

Acked-by: Yafang Shao <laoar.shao@gmail.com>
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


