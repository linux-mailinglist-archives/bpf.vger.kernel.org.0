Return-Path: <bpf+bounces-77698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A2CEF214
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9767A301BE98
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A62727FC;
	Fri,  2 Jan 2026 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMD0AHKx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1392FF169
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376874; cv=none; b=YPejoJ2z+BakI+LPyd5QszwbVt5zDTrJuF5JzI6A4ekpxbJFitxYNqz4sd60+oLM3so8BiGj3VaiVus1zhLqY4RL3s6SKK4bpcSLntfPdiE70JOJlIYLLKu1DYnONfdZdZRO+scwD9emo00nWyBsgigSdjAjwg7sGCfOKXULKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376874; c=relaxed/simple;
	bh=DTLxsycZx3H2hztjrKTJLEaouj1STjAnZiOoHAqFkNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEoR0nzHJSemNx7MDPUyFxgBh6qhBWgzxib/NLuMvmNkj8I4tc0/QZRg3b9Tn1w5LzqZ3cjFxKkRcXk5wsQZxqlY9ys/3nIuYmSY9taQZ6fKzNfRN5rhF0+2SfDP4LvaEa0SHTLNoeI36u3dplSeYJeSVBbk/6dTC17kLMNpWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMD0AHKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB21C116D0;
	Fri,  2 Jan 2026 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376873;
	bh=DTLxsycZx3H2hztjrKTJLEaouj1STjAnZiOoHAqFkNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMD0AHKxbz93f3X26L8QinXlcC9qaO1KaDdX4Q3pZAggPgaGnObC9SnbEd/BW+Z+0
	 PZOzfAR8iseF4iD8AL7qPYqDR4Rv9lXYrl78iXLbmmWoIKWoW5wKy4O3dmge5I1zIX
	 buDonSrSJOQTqSPNHfYkeuw+zgWX22tJ6t36Tf+JorUvgM/3aMvTExH2fNCoyw5vWL
	 yhxG3XxW41epkO9VeRvrkgWxTlTSH4z0sZ5RnMlRkTzxrORJGzoxUxvgxQnlMWRbwI
	 hj1hfui9zvsmq7oy3DWmVa2E17zRp6jWtjjUpBa2Be0VPrUnRvIePJAL4N2j7fH52G
	 1V2BAM1SzeroA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/10] HID: bpf: drop dead NULL checks in kfuncs
Date: Fri,  2 Jan 2026 10:00:31 -0800
Message-ID: <20260102180038.2708325-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As KF_TRUSTED_ARGS is now considered default for all kfuns, the verifier
will not allow passing NULL pointers to these kfuns. These checks for
NULL pointers can therefore be removed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 9a06f9b0e4ef..892aca026ffa 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -295,9 +295,6 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
 {
 	struct hid_bpf_ctx_kern *ctx_kern;
 
-	if (!ctx)
-		return NULL;
-
 	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
 
 	if (rdwr_buf_size + offset > ctx->allocated_size)
@@ -364,7 +361,7 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 	u32 report_len;
 
 	/* check arguments */
-	if (!ctx || !hid_ops || !buf)
+	if (!hid_ops)
 		return -EINVAL;
 
 	switch (rtype) {
-- 
2.47.3


