Return-Path: <bpf+bounces-19888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE13832848
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B621F22DF8
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3554C60C;
	Fri, 19 Jan 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RouubcS8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453321D690
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662339; cv=none; b=uPMGovlDT1Hhh1ubZfCM1nRx6SV/3AebiBN66IrllvNwx7QnkI5FsxJhYnixsOtNRm0jVrMKQO6cNcnPuDe6KlWSiIbKEMqE1xD1qE9jTa0kSZycngCyeHhwR3u66rBT0Z02zfdYsIy2TLtgiMtGzOTrVbAB77CeQamzlAjXD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662339; c=relaxed/simple;
	bh=txje+sof+QfvEDTVQppzGAvcx3Rj8EUo18UQtbo9d+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8CJv74f1xxu/8EGEK0GBv/FMXTM/wjnpS6n21vzGPcuqopC70EwqHAgXY2CCloi/E3ol9yUaZwCp/0twrvS5KeSGv5IZ/jMxDuKJvhUYwKjNxd9BbPLxkHrty/4J61TtiKxnCXSomvgayD4u/ys9OlaoBiLg8PNwI4+VcLFjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RouubcS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9911CC433F1;
	Fri, 19 Jan 2024 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705662338;
	bh=txje+sof+QfvEDTVQppzGAvcx3Rj8EUo18UQtbo9d+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RouubcS8BxWcpZHnZ+HIjVjO16S64MbCccesBNU6frbRMtyN+cYq7Bx803FSlzwiS
	 Z6S6pDJ5b9CIe+R5uFau4KXSAFIcxiKYCFh38b2vUyF05m/OAH+fzVB7iNKgjkQtLK
	 xiYWFbk5NVuGxiDNN3nJ2Iw+l/kKDfWMz1MCVBY1MUsT2MbijoUuVgErGmjmBKB+fJ
	 q7fDuTB1CioIOP4LHD7F8ScBlYAqPk4cVWOTtQIfylJ/iJn6bYnwu0rHqEtwztY2HP
	 +Mj8t7R7GGNImZdd6f0mdrftW3nkYNi8EecqjPLeQfoA8fsfV6QvlmCMwseS+mEfgp
	 jvl2BJxhiZR1A==
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
	Hao Luo <haoluo@google.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 2/8] bpf: Store cookies in kprobe_multi bpf_link_info data
Date: Fri, 19 Jan 2024 12:04:59 +0100
Message-ID: <20240119110505.400573-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
References: <20240119110505.400573-1-jolsa@kernel.org>
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

Acked-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/trace/bpf_trace.c       | 15 +++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 181e74433272..287d05732668 100644
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
index 181e74433272..287d05732668 100644
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


