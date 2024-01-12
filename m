Return-Path: <bpf+bounces-19478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449882C5BD
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A97E1C21DD9
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0605B15E99;
	Fri, 12 Jan 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pgbUZPzN"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503E15AF4
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705086347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EG1Fm30d64Jq9C37U8HPAFG7ALNQNq/G51lBvu4loso=;
	b=pgbUZPzNKUVHp2mPdEsaqFS4ZchuVA/1/9dAC35LQwsAYojMI7EdNjQqsVtZjo3psnaH9G
	b8Y5uPmI69vBBLs3TUCk3+YauaP35ZCSATYBeyOk+/mqY1QHgge1+qZeRRwMX9XjJyag3n
	0XWh/wZ5iGObYwkPAXuVqThWgpnookg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH v3 bpf 1/3] bpf: iter_udp: Retry with a larger batch size without going back to the previous bucket
Date: Fri, 12 Jan 2024 11:05:28 -0800
Message-Id: <20240112190530.3751661-2-martin.lau@linux.dev>
In-Reply-To: <20240112190530.3751661-1-martin.lau@linux.dev>
References: <20240112190530.3751661-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The current logic is to use a default size 16 to batch the whole bucket.
If it is too small, it will retry with a larger batch size.

The current code accidentally does a state->bucket-- before retrying.
This goes back to retry with the previous bucket which has already
been done. This patch fixed it.

It is hard to create a selftest. I added a WARN_ON(state->bucket < 0),
forced a particular port to be hashed to the first bucket,
created >16 sockets, and observed the for-loop went back
to the "-1" bucket.

Cc: Aditi Ghag <aditi.ghag@isovalent.com>
Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets iterator")
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv4/udp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e..978b83d3c094 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3213,7 +3213,6 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
 		 */
-		state->bucket--;
 		goto again;
 	}
 done:
-- 
2.34.1


