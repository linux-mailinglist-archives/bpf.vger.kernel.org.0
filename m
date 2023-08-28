Return-Path: <bpf+bounces-8824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6678A6E0
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A253A1C20889
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF710FE;
	Mon, 28 Aug 2023 07:56:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42457EC2
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093ACC433C8;
	Mon, 28 Aug 2023 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209385;
	bh=bQL0k7ZDaX82GIXlUjop8lzK89glSdv3YhmALUlQz34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTMxdRx7Wbr+kvuExxsKyDeFvnq3Mh2W7mUSE8c3Z0ELWIPtNDZseyvGq9DTvD6ef
	 QKCwh3tcnfvIfImhGQrOmVS9Ae7d6D5G0kYRsPV+bhQ5EtBMczb1zXtzVMEsdUEDXC
	 8PuzWnd3w8eQm7CGIljJ5uRvB+l5JRcj4Wtkg23vBr5A4rBB/Up5mZecscYLuBXV6u
	 mrb5PMo/tCjjUYF7Q7tHKMDv9VmSrM6HOjTOBOoo0o3YXtodKkIYvU9chSKIzG+ecJ
	 COQeiIvoiBJH54+kOCXjPHVh1SjL5vV6J2Hp0FzGfvaUKjg1gUUApbzI8RQoxjsYl5
	 aVFEaUHYGSXLg==
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
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH bpf-next 04/12] bpf: Add missed value to kprobe_multi link info
Date: Mon, 28 Aug 2023 09:55:29 +0200
Message-ID: <20230828075537.194192-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/trace/bpf_trace.c       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8790b3962e4b..b754edfb0cd7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6523,6 +6523,7 @@ struct bpf_link_info {
 			__aligned_u64 addrs;
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
+			__u64 missed;
 		} kprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a8685fc1eee..0eaec3c4a5fd 100644
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
index 8790b3962e4b..b754edfb0cd7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6523,6 +6523,7 @@ struct bpf_link_info {
 			__aligned_u64 addrs;
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
+			__u64 missed;
 		} kprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
-- 
2.41.0


