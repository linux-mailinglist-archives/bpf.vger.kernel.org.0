Return-Path: <bpf+bounces-19479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B403182C5BE
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DA2285CD0
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C41640B;
	Fri, 12 Jan 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B/nBHnSk"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03116400
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705086349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fk5KKtYXOiafHUPMrRGtwvEBUmB7SmKS37R+wStADU=;
	b=B/nBHnSku1LSKtMMKfUsHUoiZO6G/RKv+QhB1bms8rd4xz9JDy/VFFihSu9rqr81M+ajJ9
	pYQzIRj+V/0ZfgJnEmW/Nhg8Ov5/HiLna6gmUIOpNyqVhSMIUndTXwfHOj1kuF/i8a7HNY
	iEVG0GgTa6GBOn9frP9uDg/yW7rEX90=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH v3 bpf 2/3] bpf: Avoid iter->offset making backward progress in bpf_iter_udp
Date: Fri, 12 Jan 2024 11:05:29 -0800
Message-Id: <20240112190530.3751661-3-martin.lau@linux.dev>
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

There is a bug in the bpf_iter_udp_batch() function that stops
the userspace from making forward progress.

The case that triggers the bug is the userspace passed in
a very small read buffer. When the bpf prog does bpf_seq_printf,
the userspace read buffer is not enough to capture the whole bucket.

When the read buffer is not large enough, the kernel will remember
the offset of the bucket in iter->offset such that the next userspace
read() can continue from where it left off.

The kernel will skip the number (== "iter->offset") of sockets in
the next read(). However, the code directly decrements the
"--iter->offset". This is incorrect because the next read() may
not consume the whole bucket either and then the next-next read()
will start from offset 0. The net effect is the userspace will
keep reading from the beginning of a bucket and the process will
never finish. "iter->offset" must always go forward until the
whole bucket is consumed.

This patch fixes it by using a local variable "resume_offset"
and "resume_bucket". "iter->offset" is always reset to 0 before
it may be used. "iter->offset" will be advanced to the
"resume_offset" when it continues from the "resume_bucket" (i.e.
"state->bucket == resume_bucket"). This brings it closer to
the bpf_iter_tcp's offset handling which does not suffer
the same bug.

Cc: Aditi Ghag <aditi.ghag@isovalent.com>
Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets iterator")
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv4/udp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 978b83d3c094..04c534a9ef89 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3137,16 +3137,18 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	struct bpf_udp_iter_state *iter = seq->private;
 	struct udp_iter_state *state = &iter->state;
 	struct net *net = seq_file_net(seq);
+	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
 	bool resized = false;
 	struct sock *sk;
 
+	resume_bucket = state->bucket;
+	resume_offset = iter->offset;
+
 	/* The current batch is done, so advance the bucket. */
-	if (iter->st_bucket_done) {
+	if (iter->st_bucket_done)
 		state->bucket++;
-		iter->offset = 0;
-	}
 
 	udptable = udp_get_table_seq(seq, net);
 
@@ -3166,19 +3168,19 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	for (; state->bucket <= udptable->mask; state->bucket++) {
 		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
 
-		if (hlist_empty(&hslot2->head)) {
-			iter->offset = 0;
+		if (hlist_empty(&hslot2->head))
 			continue;
-		}
 
+		iter->offset = 0;
 		spin_lock_bh(&hslot2->lock);
 		udp_portaddr_for_each_entry(sk, &hslot2->head) {
 			if (seq_sk_match(seq, sk)) {
 				/* Resume from the last iterated socket at the
 				 * offset in the bucket before iterator was stopped.
 				 */
-				if (iter->offset) {
-					--iter->offset;
+				if (state->bucket == resume_bucket &&
+				    iter->offset < resume_offset) {
+					++iter->offset;
 					continue;
 				}
 				if (iter->end_sk < iter->max_sk) {
@@ -3192,9 +3194,6 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 
 		if (iter->end_sk)
 			break;
-
-		/* Reset the current bucket's offset before moving to the next bucket. */
-		iter->offset = 0;
 	}
 
 	/* All done: no batch made. */
-- 
2.34.1


