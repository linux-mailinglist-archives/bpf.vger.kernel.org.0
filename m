Return-Path: <bpf+bounces-13268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1667D7579
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 22:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE425B2124B
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091633993;
	Wed, 25 Oct 2023 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmXMxGAe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08B33983
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 20:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AD3C433C8;
	Wed, 25 Oct 2023 20:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698265498;
	bh=2Y0Gi0ZF8V4rstyRh9mQN9eOaXDtx06DFHdNVyOgh20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmXMxGAes2askKqdCg03lZm8nKnN0ZaWUUTlrFkxnfiI7YF7pqu0a51cg7/OOl0kh
	 AJjvKijjAGNwclfJVUeyFtQsoKZvjIvrMcfBZtgOjLqCXUndaGLnQ93kTok8fk2DeB
	 X3gBF1EzozDnw+nahRe3kn3DI8q+zwHNdIzsrgcRY4njSEBHOyqQnpslbMXvUNnnk6
	 LgsayZZR2g9RmkgJqtdCf+zGwVK4jll2KuCfbh6/4haQ7gErUZR+ISSS0GZDUkwnAP
	 unlKTin17cm6MjQEZyFQgaoaA7MJOpVjSlpdz7Xs68Aa3z4ekYiBOieZnYCZz7qUhC
	 f7chdHfwzsWJQ==
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
Subject: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi link
Date: Wed, 25 Oct 2023 22:24:17 +0200
Message-ID: <20231025202420.390702-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025202420.390702-1-jolsa@kernel.org>
References: <20231025202420.390702-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to get uprobe_link details through bpf_link_info
interface.

Adding new struct uprobe_multi to struct bpf_link_info to carry
the uprobe_multi link details.

The uprobe_multi.count is passed from user space to denote size
of array fields (offsets/ref_ctr_offsets/cookies). The actual
array size is stored back to uprobe_multi.count (allowing user
to find out the actual array size) and array fields are populated
up to the user passed size.

All the non-array fields (path/count/flags/pid) are always set.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 10 +++++
 kernel/trace/bpf_trace.c       | 68 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 10 +++++
 3 files changed, 88 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..960cf2914d63 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6556,6 +6556,16 @@ struct bpf_link_info {
 			__u32 flags;
 			__u64 missed;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 path;
+			__aligned_u64 offsets;
+			__aligned_u64 ref_ctr_offsets;
+			__aligned_u64 cookies;
+			__u32 path_max; /* in/out: uprobe_multi path size */
+			__u32 count;    /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
+			__u32 flags;
+			__u32 pid;
+		} uprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
 			__u32 :32;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 843b3846d3f8..9f8ad19a1a93 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3042,6 +3042,7 @@ struct bpf_uprobe_multi_link {
 	u32 cnt;
 	struct bpf_uprobe *uprobes;
 	struct task_struct *task;
+	u32 flags;
 };
 
 struct bpf_uprobe_multi_run_ctx {
@@ -3081,9 +3082,75 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(umulti_link);
 }
 
+static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
+	u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
+	u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
+	u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
+	u32 upath_max = info->uprobe_multi.path_max;
+	struct bpf_uprobe_multi_link *umulti_link;
+	u32 ucount = info->uprobe_multi.count;
+	int err = 0, i;
+	char *p, *buf;
+	long left;
+
+	if (!upath ^ !upath_max)
+		return -EINVAL;
+
+	if (!uoffsets ^ !ucount)
+		return -EINVAL;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+	info->uprobe_multi.count = umulti_link->cnt;
+	info->uprobe_multi.flags = umulti_link->flags;
+	info->uprobe_multi.pid = umulti_link->task ?
+				 task_pid_nr(umulti_link->task) : (u32) -1;
+
+	if (upath) {
+		if (upath_max > PATH_MAX)
+			return -E2BIG;
+		buf = kmalloc(upath_max, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		p = d_path(&umulti_link->path, buf, upath_max);
+		if (IS_ERR(p)) {
+			kfree(buf);
+			return -ENOSPC;
+		}
+		left = copy_to_user(upath, p, buf + upath_max - p);
+		kfree(buf);
+		if (left)
+			return -EFAULT;
+	}
+
+	if (!uoffsets)
+		return 0;
+
+	if (ucount < umulti_link->cnt)
+		err = -ENOSPC;
+	else
+		ucount = umulti_link->cnt;
+
+	for (i = 0; i < ucount; i++) {
+		if (put_user(umulti_link->uprobes[i].offset, uoffsets + i))
+			return -EFAULT;
+		if (uref_ctr_offsets &&
+		    put_user(umulti_link->uprobes[i].ref_ctr_offset, uref_ctr_offsets + i))
+			return -EFAULT;
+		if (ucookies &&
+		    put_user(umulti_link->uprobes[i].cookie, ucookies + i))
+			return -EFAULT;
+	}
+
+	return err;
+}
+
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
 	.dealloc = bpf_uprobe_multi_link_dealloc,
+	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
 };
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
@@ -3272,6 +3339,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->uprobes = uprobes;
 	link->path = path;
 	link->task = task;
+	link->flags = flags;
 
 	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
 		      &bpf_uprobe_multi_link_lops, prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f6cdf52b1da..960cf2914d63 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6556,6 +6556,16 @@ struct bpf_link_info {
 			__u32 flags;
 			__u64 missed;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 path;
+			__aligned_u64 offsets;
+			__aligned_u64 ref_ctr_offsets;
+			__aligned_u64 cookies;
+			__u32 path_max; /* in/out: uprobe_multi path size */
+			__u32 count;    /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
+			__u32 flags;
+			__u32 pid;
+		} uprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
 			__u32 :32;
-- 
2.41.0


