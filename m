Return-Path: <bpf+bounces-7293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF07755A1
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4882F1C2048F
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854013FE6;
	Wed,  9 Aug 2023 08:34:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4003D64
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CC8C433C8;
	Wed,  9 Aug 2023 08:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570095;
	bh=ThIfq/8h2HHQWcMjoiaz6g/y+EyFgy5+xC+0pRwqc68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJgyAB9EeAhE3DmIvHGaC1zVSh47QDbJcHvTX9m+VxzP6Ej3UkSR0byktthS4Bji9
	 TRNl4QZ0CniD0QxE4EZP4JNZxDlXnzaZGtWrMimSbVEA1ELAK7NjXUjg+LoQ3gI6bQ
	 ZkGCMbQH2VZ4a9KSmscds9/0862mxC9mJnRTdS+lhvk1BzeJI5r7rTtx++nKJZ3JZW
	 OnQJZA1/zU+TUvH6dRRFmH2nI4OaAabx6GYUaqGU5R0fFbGguYCPIInJAV49/ptNdK
	 3qJRxT0/UqFMjgYzwacI0vZbwW20KnWyEM+rzFcUTlbzQHhtuqxawS4cDcYO7QBMuz
	 8Gyt5zuAE7VbA==
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
Subject: [PATCHv7 bpf-next 01/28] bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
Date: Wed,  9 Aug 2023 10:34:13 +0200
Message-ID: <20230809083440.3209381-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
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
index d21deb46f49f..a4e55e5e84a7 100644
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
index d21deb46f49f..a4e55e5e84a7 100644
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


