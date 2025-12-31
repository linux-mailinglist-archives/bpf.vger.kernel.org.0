Return-Path: <bpf+bounces-77609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D68CEC563
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E64130076BE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9329D287;
	Wed, 31 Dec 2025 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCuF+kzx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84B29D26E
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201127; cv=none; b=cTQFl6/SdX+T/du4rxFykvdHHJCYKvRxhGhZiKOd/RsogLqoJ28yeRIFOZVHc/KUeGWoXXF6D7HeQtynXgQUvrNNEP6DCxoRtLVK4V88WIggQ0YwDn2/Dpx8M6Fs32pdQBazQU6gQ0ndzWYXVE7bIOgu5UOOb7PRCvKP1VYIsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201127; c=relaxed/simple;
	bh=DTLxsycZx3H2hztjrKTJLEaouj1STjAnZiOoHAqFkNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcYO5SG4Rh0AdnpPxNogDbI+g6SefS1CAioW51hVBGv60RxZBnI+dfznBGoe3KliHb7E/a3w6qkr2jqUJpIv5BwK4z+47XAHYB1WKqsuzaOnYsq4aCzTSsLmn2YBY6xl+CkYI6v2MKwrv4LToV93++aRcdTrPKvkdhkZekNCu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCuF+kzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD13C113D0;
	Wed, 31 Dec 2025 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201124;
	bh=DTLxsycZx3H2hztjrKTJLEaouj1STjAnZiOoHAqFkNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCuF+kzxyaB3m/Jew8A5h0cUyKnE3tNA0y10IjDjTqwMa1/rpheGgMygxg5/AWqGW
	 Z8JIDEvLModjyJdD3AWaRwa19Rai0WyFUu+qHc8FT5jn2GvzcNZy3exQ9hN7RK2HKC
	 T6KSNMFqmZouOW3WEdtNknjgL6Q6wN9xpKDvkQBbsiuhNT4YV5akzIM8qKiiQu25Hw
	 psys6e8nhBpDkKJpJy8n/3iOCTzo6vWHCnEqhBfuqZJ6oSR5ONKB3CsNA/VM2L5Vmo
	 8mzItHn7VPQVxUOAr8o/3n5SoJ8cl5KIvw+v5B3UuXSbvf+L7tItG1nETrhC5I8PpT
	 riyO8AYqwNJGQ==
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 9/9] HID: bpf: drop dead NULL checks in kfuncs
Date: Wed, 31 Dec 2025 09:08:55 -0800
Message-ID: <20251231171118.1174007-10-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231171118.1174007-1-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
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


