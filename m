Return-Path: <bpf+bounces-808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A63707030
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A9D2815E9
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED9B31EF2;
	Wed, 17 May 2023 17:57:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACF31EF1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:57:38 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015273A8D
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:57:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so945855a12.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346250; x=1686938250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bacljcxrDeAgSZeFU8xK+6nN1o9Ylg1NYfYtT1T+joA=;
        b=R5itWy7pnKmpcxXYDRmuuf/Ce18CIfcnSWmylOa5SMs8HjOiW6J+81nDsMhtPENkCg
         vIaarG4s6GQL60MVxZCMwFh5iXiFf69QfoeBPYzjNQdrOiorMmLaCrZHDYR6ZvSvSQqU
         CHO27SWL9JvuA3xiruW7oX3h47jgSC9g5del5kmvfysxMT4CLQ8WusUX+7M22BY6NE13
         c/8Jxjok+T2IumyXviB/dZ0v16kLYRwlHjooSyl8oynDcQfJv/SQJ8q8pmm0Pl7i1nmS
         5K3netNVC7bURk07V2ADkkAUrCcbQE7NMVsg45kvDv8pdFGNVC1+Hhv20b9uVzUwnxkL
         LHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346250; x=1686938250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bacljcxrDeAgSZeFU8xK+6nN1o9Ylg1NYfYtT1T+joA=;
        b=fWeeI0x20bGwhGGq4ckhmB7J/orY7hqGB8mo8P5lEOVayyHPRrT5AzZFwpkhAQCW/0
         JDEU264Tr3v3uLr6JSONZlsK3SueC8qx6eo9IPVKNmEqI7Smnz71ac/zrLJ/2dwcpMBW
         VViJ4eETg+EEtkWzcLFCCLj+g7byfitFIyk/UYP6XXQrQmfQK1MRJiMjxuRUo49OmbAf
         lcqHzp4VVC8MZ14Mz3qcCNkVvMYzhySpOJAvuMMFopiQZTAL8Cr4/MbS1W9WJlZ2n6IQ
         hLGwUVZMebaTuMDpK+0+lniV4MDFFJniSZ1O6PHGMDP9ZFnj3MMw/c2uZPAHFRBIr4mV
         ye3g==
X-Gm-Message-State: AC+VfDwijgLYqJxp14Ic4Ch64/Qx3G9k4pvSOcgX9lTf4M0ULoBzdS8k
	xX0SyekqCGIemyyZaMBI4LZGNk8EwwTUB3K7yTw=
X-Google-Smtp-Source: ACHHUZ7Y8r/zZ4TFvaEJDBLAixdkk436r3GBQtZOWS4IAbeA2a28ArDBjBEpDUykzvdEd4cVcLaQoA==
X-Received: by 2002:a17:90b:2388:b0:24e:1215:c280 with SMTP id mr8-20020a17090b238800b0024e1215c280mr404872pjb.45.1684346250058;
        Wed, 17 May 2023 10:57:30 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id hg14-20020a17090b300e00b0025043a8185dsm1882855pjb.23.2023.05.17.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:57:29 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v8 bpf-next 05/10] bpf: udp: Implement batching for sockets iterator
Date: Wed, 17 May 2023 17:57:25 +0000
Message-Id: <20230517175725.528192-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Batch UDP sockets from BPF iterator that allows for overlapping locking
semantics in BPF/kernel helpers executed in BPF programs.  This facilitates
BPF socket destroy kfunc (introduced by follow-up patches) to execute from
BPF iterator programs.

Previously, BPF iterators acquired the sock lock and sockets hash table
bucket lock while executing BPF programs. This prevented BPF helpers that
again acquire these locks to be executed from BPF iterators.  With the
batching approach, we acquire a bucket lock, batch all the bucket sockets,
and then release the bucket lock. This enables BPF or kernel helpers to
skip sock locking when invoked in the supported BPF contexts.

The batching logic is similar to the logic implemented in TCP iterator:
https://lore.kernel.org/bpf/20210701200613.1036157-1-kafai@fb.com/.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/udp.c | 205 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 199 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 289ef05b5c15..8fe2fd6255cc 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3150,6 +3150,143 @@ struct bpf_iter__udp {
 	int bucket __aligned(8);
 };
 
+struct bpf_udp_iter_state {
+	struct udp_iter_state state;
+	unsigned int cur_sk;
+	unsigned int end_sk;
+	unsigned int max_sk;
+	int offset;
+	struct sock **batch;
+	bool st_bucket_done;
+};
+
+static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
+				      unsigned int new_batch_sz);
+static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
+{
+	struct bpf_udp_iter_state *iter = seq->private;
+	struct udp_iter_state *state = &iter->state;
+	struct net *net = seq_file_net(seq);
+	struct udp_table *udptable;
+	unsigned int batch_sks = 0;
+	bool resized = false;
+	struct sock *sk;
+
+	/* The current batch is done, so advance the bucket. */
+	if (iter->st_bucket_done) {
+		state->bucket++;
+		iter->offset = 0;
+	}
+
+	udptable = udp_get_table_seq(seq, net);
+
+again:
+	/* New batch for the next bucket.
+	 * Iterate over the hash table to find a bucket with sockets matching
+	 * the iterator attributes, and return the first matching socket from
+	 * the bucket. The remaining matched sockets from the bucket are batched
+	 * before releasing the bucket lock. This allows BPF programs that are
+	 * called in seq_show to acquire the bucket lock if needed.
+	 */
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+	iter->st_bucket_done = false;
+	batch_sks = 0;
+
+	for (; state->bucket <= udptable->mask; state->bucket++) {
+		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
+
+		if (hlist_empty(&hslot2->head)) {
+			iter->offset = 0;
+			continue;
+		}
+
+		spin_lock_bh(&hslot2->lock);
+		udp_portaddr_for_each_entry(sk, &hslot2->head) {
+			if (seq_sk_match(seq, sk)) {
+				/* Resume from the last iterated socket at the
+				 * offset in the bucket before iterator was stopped.
+				 */
+				if (iter->offset) {
+					--iter->offset;
+					continue;
+				}
+				if (iter->end_sk < iter->max_sk) {
+					sock_hold(sk);
+					iter->batch[iter->end_sk++] = sk;
+				}
+				batch_sks++;
+			}
+		}
+		spin_unlock_bh(&hslot2->lock);
+
+		if (iter->end_sk)
+			break;
+
+		/* Reset the current bucket's offset before moving to the next bucket. */
+		iter->offset = 0;
+	}
+
+	/* All done: no batch made. */
+	if (!iter->end_sk)
+		return NULL;
+
+	if (iter->end_sk == batch_sks) {
+		/* Batching is done for the current bucket; return the first
+		 * socket to be iterated from the batch.
+		 */
+		iter->st_bucket_done = true;
+		goto done;
+	}
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+		resized = true;
+		/* After allocating a larger batch, retry one more time to grab
+		 * the whole bucket.
+		 */
+		state->bucket--;
+		goto again;
+	}
+done:
+	return iter->batch[0];
+}
+
+static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpf_udp_iter_state *iter = seq->private;
+	struct sock *sk;
+
+	/* Whenever seq_next() is called, the iter->cur_sk is
+	 * done with seq_show(), so unref the iter->cur_sk.
+	 */
+	if (iter->cur_sk < iter->end_sk) {
+		sock_put(iter->batch[iter->cur_sk++]);
+		++iter->offset;
+	}
+
+	/* After updating iter->cur_sk, check if there are more sockets
+	 * available in the current bucket batch.
+	 */
+	if (iter->cur_sk < iter->end_sk)
+		sk = iter->batch[iter->cur_sk];
+	else
+		/* Prepare a new batch. */
+		sk = bpf_iter_udp_batch(seq);
+
+	++*pos;
+	return sk;
+}
+
+static void *bpf_iter_udp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	/* bpf iter does not support lseek, so it always
+	 * continue from where it was stop()-ped.
+	 */
+	if (*pos)
+		return bpf_iter_udp_batch(seq);
+
+	return SEQ_START_TOKEN;
+}
+
 static int udp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
 			     struct udp_sock *udp_sk, uid_t uid, int bucket)
 {
@@ -3170,18 +3307,37 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_prog *prog;
 	struct sock *sk = v;
 	uid_t uid;
+	int ret;
 
 	if (v == SEQ_START_TOKEN)
 		return 0;
 
+	lock_sock(sk);
+
+	if (unlikely(sk_unhashed(sk))) {
+		ret = SEQ_SKIP;
+		goto unlock;
+	}
+
 	uid = from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, false);
-	return udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
+	ret = udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
+
+unlock:
+	release_sock(sk);
+	return ret;
+}
+
+static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
+{
+	while (iter->cur_sk < iter->end_sk)
+		sock_put(iter->batch[iter->cur_sk++]);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
 {
+	struct bpf_udp_iter_state *iter = seq->private;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 
@@ -3192,12 +3348,15 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
 			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
 	}
 
-	udp_seq_stop(seq, v);
+	if (iter->cur_sk < iter->end_sk) {
+		bpf_iter_udp_put_batch(iter);
+		iter->st_bucket_done = false;
+	}
 }
 
 static const struct seq_operations bpf_iter_udp_seq_ops = {
-	.start		= udp_seq_start,
-	.next		= udp_seq_next,
+	.start		= bpf_iter_udp_seq_start,
+	.next		= bpf_iter_udp_seq_next,
 	.stop		= bpf_iter_udp_seq_stop,
 	.show		= bpf_iter_udp_seq_show,
 };
@@ -3426,21 +3585,55 @@ static struct pernet_operations __net_initdata udp_sysctl_ops = {
 DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
+static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
+				      unsigned int new_batch_sz)
+{
+	struct sock **new_batch;
+
+	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
+				   GFP_USER | __GFP_NOWARN);
+	if (!new_batch)
+		return -ENOMEM;
+
+	bpf_iter_udp_put_batch(iter);
+	kvfree(iter->batch);
+	iter->batch = new_batch;
+	iter->max_sk = new_batch_sz;
+
+	return 0;
+}
+
+#define INIT_BATCH_SZ 16
+
 static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 {
-	return bpf_iter_init_seq_net(priv_data, aux);
+	struct bpf_udp_iter_state *iter = priv_data;
+	int ret;
+
+	ret = bpf_iter_init_seq_net(priv_data, aux);
+	if (ret)
+		return ret;
+
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	if (ret)
+		bpf_iter_fini_seq_net(priv_data);
+
+	return ret;
 }
 
 static void bpf_iter_fini_udp(void *priv_data)
 {
+	struct bpf_udp_iter_state *iter = priv_data;
+
 	bpf_iter_fini_seq_net(priv_data);
+	kvfree(iter->batch);
 }
 
 static const struct bpf_iter_seq_info udp_seq_info = {
 	.seq_ops		= &bpf_iter_udp_seq_ops,
 	.init_seq_private	= bpf_iter_init_udp,
 	.fini_seq_private	= bpf_iter_fini_udp,
-	.seq_priv_size		= sizeof(struct udp_iter_state),
+	.seq_priv_size		= sizeof(struct bpf_udp_iter_state),
 };
 
 static struct bpf_iter_reg udp_reg_info = {
-- 
2.34.1


