Return-Path: <bpf+bounces-43281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DEE9B2DAB
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215F9B21DC2
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD961DEFCC;
	Mon, 28 Oct 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFGQ/Awr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E41DE882;
	Mon, 28 Oct 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112718; cv=none; b=gRoNeNYk16K37gySHGkY6JB6+fZKO6MKsBnZlocf2K+EWrB66gFpAS/1Kh2SUPoFTyExGFKxIOrdY9qkfjkuqOMl0F9GnzLe7ZcRbOJILhsP9rUl3+56w0h1weM7zn3FpzCuPh8ZwyMvFrBAlNq29ftjiO6uodM55Y9PAGZauWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112718; c=relaxed/simple;
	bh=gZLT8NE+c1jwdla9fCNmT1L9FriaHH37p8/XIyg9HYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iv1hDtJi6WWa6uFil1GJuhMnGS3mBk6eEDRRhNFUynSrVxOoFqECpfv3JXYQiMlYcBTk1zkSpchdaOvMRHe6JcxND0oFlgdlRo09D8K+xrknzJM9LbMUozFaAgWGkBKDi8WAb6emksJD7FHjsQofU99p7qD3HNt4+sn0y6Jsm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFGQ/Awr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC36C4CEE3;
	Mon, 28 Oct 2024 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112717;
	bh=gZLT8NE+c1jwdla9fCNmT1L9FriaHH37p8/XIyg9HYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFGQ/AwrynFajhfgVcKvtFRHdIZQmCsGSZAR+EQ/n5i3kfpb8kyw3/bRCWv/pRG2Z
	 KfJuE0D1UA4XrY+KnOQNC6AneW5JGqFGQM/LEtpgepmWVXmHQRHqq9fzOcvgviWmSx
	 gTrUaqXY2wvbZ5z6JZzYJnEnb5mS/RzY6ShR9TjxiiPiUke7QUI2iBqQqd3O7wQnB9
	 d9MtVm5/s/xyzknHQSfyDyFDR2bTxbtNVWi1p44jdUlyYRO30AWCGqp+O8+587tT+X
	 HzixIRD6H167nioYm5Y/6345Qwv77VBdtcYBi49x5QMTs2LXs7JBBvS8GVm0pdGBR5
	 /UUAawYssIIVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 27/32] bpf: Check validity of link->type in bpf_link_show_fdinfo()
Date: Mon, 28 Oct 2024 06:50:09 -0400
Message-ID: <20241028105050.3559169-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 8421d4c8762bd022cb491f2f0f7019ef51b4f0a7 ]

If a newly-added link type doesn't invoke BPF_LINK_TYPE(), accessing
bpf_link_type_strs[link->type] may result in an out-of-bounds access.

To spot such missed invocations early in the future, checking the
validity of link->type in bpf_link_show_fdinfo() and emitting a warning
when such invocations are missed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241024013558.1135167-3-houtao@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 21fb9c4d498fb..0a9ce41bd12eb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3136,13 +3136,17 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_link *link = filp->private_data;
 	const struct bpf_prog *prog = link->prog;
+	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
-	seq_printf(m,
-		   "link_type:\t%s\n"
-		   "link_id:\t%u\n",
-		   bpf_link_type_strs[link->type],
-		   link->id);
+	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
+		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+	} else {
+		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
+		seq_printf(m, "link_type:\t<%u>\n", type);
+	}
+	seq_printf(m, "link_id:\t%u\n", link->id);
+
 	if (prog) {
 		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 		seq_printf(m,
-- 
2.43.0


