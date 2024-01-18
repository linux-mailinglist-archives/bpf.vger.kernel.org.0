Return-Path: <bpf+bounces-19800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7660C83163B
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93541C24F1F
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D71F95A;
	Thu, 18 Jan 2024 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dehSbbaw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD11F945
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571688; cv=none; b=oeJpbJIe3+kvoaeDORQQeKPzxyqgyzbkVFONSxclikhggXNL2FNiTUNYnm2vm76YlP1MJjcMsJUh8/K+267V1QwwAoewFlF5bCU+M/EyAyRkVeEfVfn/OtJwtXMYIiUvSZWC3v4Zd05bN3iW5suLeCG64wDgKOHCFlEWMxp0dIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571688; c=relaxed/simple;
	bh=p4TP+tRas0Igj++ikt8IRJIGjqCP22mZMiof9YPUXJY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=e+Mv6njaIQmVHvOrHY5XCM9pmj2Pgxgq5oYnR65P7KsqruYoqXtA7ls9xBFRzDNoJWUULK4TxLAM8Blsu1YfvdcXg69npkGuH/M6KxoVAms8rsd2/ZWHqwcFr48j0GDBaH/gIW1upl2/tCidr1AgoTq439A+1CdclhdK1aQfi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dehSbbaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB08C433F1;
	Thu, 18 Jan 2024 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571687;
	bh=p4TP+tRas0Igj++ikt8IRJIGjqCP22mZMiof9YPUXJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dehSbbawq1IpMTjRh3We9K4oCqfMoJGdvsTOYvxwafu8acfSj/EK6DLTac1Ige0oj
	 08FC/DtsYPsQkvsp/sIudzSoGJ36VZdOyIfOkBCtDw7UrCNu11Zy4R23eDon+8G4QW
	 k5oB5NoIRC72YfhsmzfEM7jF3EPcjo/KWdydk7o1mvAGdRrpBsUQQ4/MF0ZT+8cIwo
	 jd8z7jfpg5JCZoD3NIdz9iP4hG2P7/fibP/keIZAkNT50oXhtlkWFd7eNAh3SVqB/z
	 h4KFvxW5FvNw6re/LGXBq8cy0rfk+aj5ddwGZnfkH69V/kNd2ClYD7ITc7B9fXUmRO
	 KF5l3R4vtXurA==
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
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/8] bpf: Store cookies in kprobe_multi bpf_link_info data
Date: Thu, 18 Jan 2024 10:54:10 +0100
Message-ID: <20240118095416.989152-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118095416.989152-1-jolsa@kernel.org>
References: <20240118095416.989152-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Storing cookies in kprobe_multi bpf_link_info data. The cookies
field is optional and if provided it needs to be an array of
__u64 with kprobe_multi.count length.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/trace/bpf_trace.c       | 15 +++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b823d367a83c..199cb93dca7f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6563,6 +6563,7 @@ struct bpf_link_info {
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
 			__u64 missed;
+			__aligned_u64 cookies;
 		} kprobe_multi;
 		struct {
 			__aligned_u64 path;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7ac6c52b25eb..c98c20abaf99 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2679,6 +2679,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 						struct bpf_link_info *info)
 {
+	u64 __user *ucookies = u64_to_user_ptr(info->kprobe_multi.cookies);
 	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
 	struct bpf_kprobe_multi_link *kmulti_link;
 	u32 ucount = info->kprobe_multi.count;
@@ -2686,6 +2687,8 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 	if (!uaddrs ^ !ucount)
 		return -EINVAL;
+	if (ucookies && !ucount)
+		return -EINVAL;
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	info->kprobe_multi.count = kmulti_link->cnt;
@@ -2699,6 +2702,18 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	else
 		ucount = kmulti_link->cnt;
 
+	if (ucookies) {
+		if (kmulti_link->cookies) {
+			if (copy_to_user(ucookies, kmulti_link->cookies, ucount * sizeof(u64)))
+				return -EFAULT;
+		} else {
+			for (i = 0; i < ucount; i++) {
+				if (put_user(0, ucookies + i))
+					return -EFAULT;
+			}
+		}
+	}
+
 	if (kallsyms_show_value(current_cred())) {
 		if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
 			return -EFAULT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b823d367a83c..199cb93dca7f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6563,6 +6563,7 @@ struct bpf_link_info {
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
 			__u64 missed;
+			__aligned_u64 cookies;
 		} kprobe_multi;
 		struct {
 			__aligned_u64 path;
-- 
2.43.0


