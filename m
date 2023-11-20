Return-Path: <bpf+bounces-15365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84C7F1684
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6501C21857
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2491C6BA;
	Mon, 20 Nov 2023 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af/vMTkO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B71BDFF
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 14:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8855C433C9;
	Mon, 20 Nov 2023 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700492238;
	bh=XI2dQy5ACcVXxYG0JmP4cdeBiDe3AwvMfuJEvv5EFKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=af/vMTkO300CX/Qpovc4xOHg7x5c8CCpczw8eLZg9/72EW51ZJWT+g/FodoOU036i
	 5J/p6ZSk4Fq6rXb86itnNwriUDTbRJQmGg9eQ+WR38LThWHuxy7yxGpgecpk5M+07Y
	 KzrNnSBHiJnKHGMDkXbJdl8jxXQdWmI878XwIr/inNYR6RbQs8uO8YXAIeuizSskGy
	 XfJyhW8uRSpkeLq9r9pt0n2n77wt+EvLP2sFKOz+8aQuWKv+4ilwrqB3TN18BlHMb9
	 4RxjqlL8Ex3aMVdxHSvZkzi0zElwDcqRFR22hyc1b4QPGBPMLEeMH89BuBVxptfnlP
	 XmuQYM+20epDg==
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
Subject: [PATCHv3 bpf-next 3/6] bpf: Add link_info support for uprobe multi link
Date: Mon, 20 Nov 2023 15:56:36 +0100
Message-ID: <20231120145639.3179656-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145639.3179656-1-jolsa@kernel.org>
References: <20231120145639.3179656-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c       | 72 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 10 +++++
 3 files changed, 92 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7a5498242eaa..a63b5eb7f9ec 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6562,6 +6562,16 @@ struct bpf_link_info {
 			__u32 flags;
 			__u64 missed;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 path;
+			__aligned_u64 offsets;
+			__aligned_u64 ref_ctr_offsets;
+			__aligned_u64 cookies;
+			__u32 path_size; /* in/out: real path size on success */
+			__u32 count; /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
+			__u32 flags;
+			__u32 pid;
+		} uprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
 			__u32 :32;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ad0323f27288..ca453b642819 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3044,6 +3044,7 @@ struct bpf_uprobe_multi_link {
 	u32 cnt;
 	struct bpf_uprobe *uprobes;
 	struct task_struct *task;
+	u32 flags;
 };
 
 struct bpf_uprobe_multi_run_ctx {
@@ -3083,9 +3084,79 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(umulti_link);
 }
 
+static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
+	u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
+	u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
+	u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
+	u32 upath_size = info->uprobe_multi.path_size;
+	struct bpf_uprobe_multi_link *umulti_link;
+	u32 ucount = info->uprobe_multi.count;
+	int err = 0, i;
+	long left;
+
+	if (!upath ^ !upath_size)
+		return -EINVAL;
+
+	if ((uoffsets || uref_ctr_offsets || ucookies) && !ucount)
+		return -EINVAL;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+	info->uprobe_multi.count = umulti_link->cnt;
+	info->uprobe_multi.flags = umulti_link->flags;
+	info->uprobe_multi.pid = umulti_link->task ?
+				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
+
+	if (upath) {
+		char *p, *buf;
+
+		upath_size = min_t(u32, upath_size, PATH_MAX);
+
+		buf = kmalloc(upath_size, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		p = d_path(&umulti_link->path, buf, upath_size);
+		if (IS_ERR(p)) {
+			kfree(buf);
+			return -ENOSPC;
+		}
+		upath_size = buf + upath_size - p;
+		left = copy_to_user(upath, p, upath_size);
+		kfree(buf);
+		if (left)
+			return -EFAULT;
+		info->uprobe_multi.path_size = upath_size - 1 /* NULL */;
+	}
+
+	if (!uoffsets && !ucookies && !uref_ctr_offsets)
+		return 0;
+
+	if (ucount < umulti_link->cnt)
+		err = -ENOSPC;
+	else
+		ucount = umulti_link->cnt;
+
+	for (i = 0; i < ucount; i++) {
+		if (uoffsets &&
+		    put_user(umulti_link->uprobes[i].offset, uoffsets + i))
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
@@ -3274,6 +3345,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->uprobes = uprobes;
 	link->path = path;
 	link->task = task;
+	link->flags = flags;
 
 	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
 		      &bpf_uprobe_multi_link_lops, prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7a5498242eaa..a63b5eb7f9ec 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6562,6 +6562,16 @@ struct bpf_link_info {
 			__u32 flags;
 			__u64 missed;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 path;
+			__aligned_u64 offsets;
+			__aligned_u64 ref_ctr_offsets;
+			__aligned_u64 cookies;
+			__u32 path_size; /* in/out: real path size on success */
+			__u32 count; /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
+			__u32 flags;
+			__u32 pid;
+		} uprobe_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
 			__u32 :32;
-- 
2.42.0


