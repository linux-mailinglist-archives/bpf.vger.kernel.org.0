Return-Path: <bpf+bounces-14570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A57E66C1
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E98B20E02
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2117125CD;
	Thu,  9 Nov 2023 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVs+Z36o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DB11CA9
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B9C433C7;
	Thu,  9 Nov 2023 09:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699522145;
	bh=YdyESkV+VWejXGpCD4/JhWwNi6fVHQTmOH4gR6FFg6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVs+Z36oAki99MNQQAU+4oVFM5vRnotwk9LQkb06xqzlcyk5/QCPD7kgiBgBkb395
	 ZiX4hEj8gUCcNO+C9zBvqBwXOiTnHM6BKEaTRyc+hcRJaUiP41zm5bp1LDU8+OJX8E
	 1HKn7+doGw3JlrZLbdjlhO+tZ2iBgozDKzckoHiyKqytqRfU/NfIDD2phsKGqnXRMy
	 4P9TOitZMnKlkHhkoAFio44axURwTMXVkMlp9rMmcldQ1PT1cX65cC9PTX16IdzdiH
	 MW3/18jr05fK81ysBlaPJDECnviDfJQlrTMl5FfCDNrm/YTnXffGp82C9i4oBDNMez
	 sI/P4Y79MrTlA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv2 bpf-next 2/6] bpf: Store ref_ctr_offsets values in bpf_uprobe array
Date: Thu,  9 Nov 2023 10:28:34 +0100
Message-ID: <20231109092838.721233-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109092838.721233-1-jolsa@kernel.org>
References: <20231109092838.721233-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will need to return ref_ctr_offsets values through link_info
interface in following change, so we need to keep them around.

Storing ref_ctr_offsets values directly into bpf_uprobe array.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d525a22b8d56..52c1ec3a0467 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3035,6 +3035,7 @@ struct bpf_uprobe_multi_link;
 struct bpf_uprobe {
 	struct bpf_uprobe_multi_link *link;
 	loff_t offset;
+	unsigned long ref_ctr_offset;
 	u64 cookie;
 	struct uprobe_consumer consumer;
 };
@@ -3174,7 +3175,6 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 {
 	struct bpf_uprobe_multi_link *link = NULL;
 	unsigned long __user *uref_ctr_offsets;
-	unsigned long *ref_ctr_offsets = NULL;
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
 	struct task_struct *task = NULL;
@@ -3247,18 +3247,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!uprobes || !link)
 		goto error_free;
 
-	if (uref_ctr_offsets) {
-		ref_ctr_offsets = kvcalloc(cnt, sizeof(*ref_ctr_offsets), GFP_KERNEL);
-		if (!ref_ctr_offsets)
-			goto error_free;
-	}
-
 	for (i = 0; i < cnt; i++) {
 		if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
 			err = -EFAULT;
 			goto error_free;
 		}
-		if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], uref_ctr_offsets + i)) {
+		if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_offsets + i)) {
 			err = -EFAULT;
 			goto error_free;
 		}
@@ -3289,7 +3283,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	for (i = 0; i < cnt; i++) {
 		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
 					     uprobes[i].offset,
-					     ref_ctr_offsets ? ref_ctr_offsets[i] : 0,
+					     uprobes[i].ref_ctr_offset,
 					     &uprobes[i].consumer);
 		if (err) {
 			bpf_uprobe_unregister(&path, uprobes, i);
@@ -3301,11 +3295,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (err)
 		goto error_free;
 
-	kvfree(ref_ctr_offsets);
 	return bpf_link_settle(&link_primer);
 
 error_free:
-	kvfree(ref_ctr_offsets);
 	kvfree(uprobes);
 	kfree(link);
 	if (task)
-- 
2.41.0


