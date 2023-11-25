Return-Path: <bpf+bounces-15844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F067F8DF5
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DB31C20C19
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771222F85E;
	Sat, 25 Nov 2023 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N81vee9E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED228E03
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 19:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC80C433C8;
	Sat, 25 Nov 2023 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940719;
	bh=S4DD8K2VejzvMBvl45dBwmaZGLLVLlfty+QFbuRqZWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N81vee9EEl/0zNP9L647DMWMjug6zDKEi86PIZxDszETw5hy3QWOf8qt7XHwBkgRR
	 MYeeDbUEBNbtMzNxb4jC7PXQFbb46VwpTBVE8dqG2LlsV4Fa6pI2opsKYZzfRf5Yvt
	 jKo/UtZ51Dd7sNSFrbGBNJSrcj3lubHhR6fqcRuVGo6M2P5Jm1JxAHcRTvxL0n6czW
	 s3nR0OSNxFOwCz61Rg7UvJsK0j5oWoLZVqbfC86iNOVZvUvClri4paHpjuunHyTV6o
	 CYwEwmRB7jF1d1qOuPFMM3tNWmc2u9elLH3GF7079127SV92RzZwTs2jeNhS6vIz4N
	 3RkjHGJ+3nJmQ==
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
Subject: [PATCHv4 bpf-next 2/6] bpf: Store ref_ctr_offsets values in bpf_uprobe array
Date: Sat, 25 Nov 2023 20:31:26 +0100
Message-ID: <20231125193130.834322-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125193130.834322-1-jolsa@kernel.org>
References: <20231125193130.834322-1-jolsa@kernel.org>
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


