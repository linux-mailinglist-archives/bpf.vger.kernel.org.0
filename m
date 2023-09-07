Return-Path: <bpf+bounces-9396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF8797070
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 09:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4F281510
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60A1107;
	Thu,  7 Sep 2023 07:13:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EE1102
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 07:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E31C43391;
	Thu,  7 Sep 2023 07:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694070817;
	bh=vawVIUdIx08pzUBIABRKLVKaSQELz9qjSHFmVhMypTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEcZk4giqWEXSp+B2vbH3d/p7GQGr4QrKdgIm1bIz07Idc9J7QHfwjgWJInhaJb0+
	 ISnYhGizx+v/CgO1UKvBlsNfvrH+zo41z3BbAbvJj3FgFQyPhi0nCbFTarUaLKZ6pC
	 kBjNcRbiXC6jGtXoYV0/Q1ZJPWgPjCowFGzYk4/LpQf4PhclbLpxEVU2CctCDEiJxP
	 /5sML5KHQZMivKuvhA8MrVp+oZG23f8sZRQm8SpryaLRhWZ6DtwWSympxRva7c+sQC
	 vWheJfCgixJVN1clNVI4RRk8kwWJFKkuw3ujO0VqvKrkFz7L1pRqhlYxvQ9WnoMdYu
	 lQv+9Cocjp5ng==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv2 bpf-next 2/9] bpf: Add missed value to kprobe_multi link info
Date: Thu,  7 Sep 2023 09:13:04 +0200
Message-ID: <20230907071311.254313-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907071311.254313-1-jolsa@kernel.org>
References: <20230907071311.254313-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missed value to kprobe_multi link info to hold the stats of missed
kprobe_multi probe.

The missed counter gets incremented when fprobe fails the recursion
check or there's no rethook available for return probe. In either
case the attached bpf program is not executed.

Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/trace/bpf_trace.c       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 73b155e52204..e5216420ec73 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6530,6 +6530,7 @@ struct bpf_link_info {
 			__aligned_u64 addrs;
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
+			__u64 missed;
 		} kprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 279a3d370812..aec52938c703 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2614,6 +2614,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	info->kprobe_multi.count = kmulti_link->cnt;
 	info->kprobe_multi.flags = kmulti_link->flags;
+	info->kprobe_multi.missed = kmulti_link->fp.nmissed;
 
 	if (!uaddrs)
 		return 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 73b155e52204..e5216420ec73 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6530,6 +6530,7 @@ struct bpf_link_info {
 			__aligned_u64 addrs;
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
+			__u64 missed;
 		} kprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
-- 
2.41.0


