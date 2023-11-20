Return-Path: <bpf+bounces-15364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D47F1683
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366271F24E3D
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500D1C6B9;
	Mon, 20 Nov 2023 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+mhdq3c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610E1C68F
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 14:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDADC433C8;
	Mon, 20 Nov 2023 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700492227;
	bh=S4DD8K2VejzvMBvl45dBwmaZGLLVLlfty+QFbuRqZWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+mhdq3cShaQkCzggnlPjZedsQCpx608YS8OFURe988Fr4g0tXRGNUT9xVLdxFTsZ
	 ksXCUKdPNonnDxj0RcBEMlZq1Rv5ywPR0l+AM5bnLklv0519tfV1DBWYQ7Iz45w1Eg
	 fFZq72vaVMDfT38lf9+Bak7Texarq1Gw6tKHGC7k/fzp4+0214q1C9PRzbQS31OqL9
	 bGyxV8dnq2C1S38IXUWThvM2REu0gJdhoVLMB6CNjaK0o7qCXPxkyhNmcyNmrQj7sZ
	 /9O0VzGDyu2AxRkfvXjTyPJgsnZm2OWSrPuGgwmEaXRM1qTGc2v+LB49ELYaOjDdV2
	 tXvgTDQrTXEuw==
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
Subject: [PATCHv3 bpf-next 2/6] bpf: Store ref_ctr_offsets values in bpf_uprobe array
Date: Mon, 20 Nov 2023 15:56:35 +0100
Message-ID: <20231120145639.3179656-3-jolsa@kernel.org>
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

We will need to return ref_ctr_offsets values through link_info
interface in following change, so we need to keep them around.

Storing ref_ctr_offsets values directly into bpf_uprobe array.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f0b8b7c29126..ad0323f27288 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3033,6 +3033,7 @@ struct bpf_uprobe_multi_link;
 struct bpf_uprobe {
 	struct bpf_uprobe_multi_link *link;
 	loff_t offset;
+	unsigned long ref_ctr_offset;
 	u64 cookie;
 	struct uprobe_consumer consumer;
 };
@@ -3172,7 +3173,6 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 {
 	struct bpf_uprobe_multi_link *link = NULL;
 	unsigned long __user *uref_ctr_offsets;
-	unsigned long *ref_ctr_offsets = NULL;
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
 	struct task_struct *task = NULL;
@@ -3245,18 +3245,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
@@ -3287,7 +3281,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	for (i = 0; i < cnt; i++) {
 		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
 					     uprobes[i].offset,
-					     ref_ctr_offsets ? ref_ctr_offsets[i] : 0,
+					     uprobes[i].ref_ctr_offset,
 					     &uprobes[i].consumer);
 		if (err) {
 			bpf_uprobe_unregister(&path, uprobes, i);
@@ -3299,11 +3293,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
2.42.0


