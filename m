Return-Path: <bpf+bounces-18339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0228190C7
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AED11F25F72
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C3C39861;
	Tue, 19 Dec 2023 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p5s9mhJG"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E33984A
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703014388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ox1r2WEXxeHsTeic4Ylfost3kkCNBUNrikYMpIT2fyo=;
	b=p5s9mhJGSagpWbehTYQuABwSKZpQZ++P4AhwdtSJ567WsbpV4Vus8HaLW62uwGz2XzsFYQ
	GMZhELKsOxDD04M8+Htn6wrxFFSD5eOJ7olRsPEFLxJ4rHF+x4PAu5j8KbOcxI0p/51A0e
	s9wciP8awk+shaFLJ7QkhHyWG9lxbw4=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress in bpf_iter_udp
Date: Tue, 19 Dec 2023 11:32:58 -0800
Message-Id: <20231219193259.3230692-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf_iter_udp iterates all udp_sk by iterating the udp_table.
The bpf_iter_udp stores all udp_sk of a bucket while iterating
the udp_table. The term used in the kernel code is "batch" the
whole bucket. The reason for batching is to allow lock_sock() on
each socket before calling the bpf prog such that the bpf prog can
safely call helper/kfunc that changes the sk's state,
e.g. bpf_setsockopt.

There is a bug in the bpf_iter_udp_batch() function that stops
the userspace from making forward progress.

The case that triggers the bug is the userspace passed in
a very small read buffer. When the bpf prog does bpf_seq_printf,
the userspace read buffer is not enough to capture the whole "batch".

When the read buffer is not enough for the whole "batch", the kernel
will remember the offset of the batch in iter->offset such that
the next userspace read() can continue from where it left off.

The kernel will skip the number (== "iter->offset") of sockets in
the next read(). However, the code directly decrements the
"--iter->offset". This is incorrect because the next read() may
not consume the whole "batch" either and the next next read() will
start from offset 0.

Doing "--iter->offset" is essentially making backward progress.
The net effect is the userspace will keep reading from the beginning
of a bucket and the process will never finish. "iter->offset" must always
go forward until the whole "batch" (or bucket) is consumed by the
userspace.

This patch fixes it by doing the decrement in a local stack
variable.

Cc: Aditi Ghag <aditi.ghag@isovalent.com>
Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets iterator")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv4/udp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e..6cf4151c2eb4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3141,6 +3141,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	unsigned int batch_sks = 0;
 	bool resized = false;
 	struct sock *sk;
+	int offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->st_bucket_done) {
@@ -3162,6 +3163,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	iter->end_sk = 0;
 	iter->st_bucket_done = false;
 	batch_sks = 0;
+	offset = iter->offset;
 
 	for (; state->bucket <= udptable->mask; state->bucket++) {
 		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
@@ -3177,8 +3179,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				/* Resume from the last iterated socket at the
 				 * offset in the bucket before iterator was stopped.
 				 */
-				if (iter->offset) {
-					--iter->offset;
+				if (offset) {
+					--offset;
 					continue;
 				}
 				if (iter->end_sk < iter->max_sk) {
-- 
2.34.1


