Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C56C3973
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCUSqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCUSq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:46:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E7356534
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u5so17001191plq.7
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679424349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37RotG0IIxyZ+FCfQpVz+Q9+HYtoydoJMOkMmFnsZuI=;
        b=MFsMJThQ+6h8rA4rz/2vUFiNSLWloE/AZDMRqwIrr0VbJ3VKDujY2XCWEVP4P9Kyz8
         nuZHy7iMu89449cT/wHuQjeRXrBTy1moAbi9vMLRat4D2W1+p4jkZIbCmc0pRJaPyr+x
         5APH2PNH5a7SqkhwPAtKsZdtF9hEv+M1lWGLCTIMemrAymQk9MVHYZ8QvIKKEMLafbAg
         VGX7rn83mUvGZPC/mSoY9vgcBilYERujM9JftGMYzaNmKp8VmsyT1ekF00ZvxB9twhOG
         d/QvkWijtJhUgCrcHCR+LOBTmc5qgx5ILDOoJBLzKAe+GF9mHH4NpzzLtElwNekgoEA5
         2MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37RotG0IIxyZ+FCfQpVz+Q9+HYtoydoJMOkMmFnsZuI=;
        b=aPhboFpbkaqMWbb72k9QLVXemW4IpZ31RrfH0twqOdkKTnuiG6Zk2ghaifCveACCOk
         iBZQKGDaF8Tl8T6hHCfIQbl/0GSybtEogM6M3DZdyMNyFkgxz6QbAFLESJ6AuoanIIXl
         kxk2VSuBiR/80CgYbIGbgzVI9DsKh6VxCUUrl6KbRQH7OI1Jp+4odNUoeGOCRDYNt/D4
         IUf/ilv88w8hOWE3OpBeVYSQRAu2ur5vNVetjnBnMlwu6/6NiNcVYh7LjA4v+qndYzUX
         iurqXWJP2tKCzsO/UBbTK9orjYtNkwlR6M0o7WwdDIwmkE4w8U1k4YjElNs7z3swkgdm
         jROA==
X-Gm-Message-State: AO0yUKXvjXDMc2XbUL3XhnmXG7oEnIBTk+ouYOFQe3b1B+uhxc9WpyMO
        qID5NDKSC4NcKcdkLCdkgz9PHPDJ7IOx2u6jTas=
X-Google-Smtp-Source: AK7set/aUMS47cbcrWi5sWZQ9lFSKkmEFYSqLjNu6b+ajSMohZHg9AAevuQUhRatj7oZsWsRZl6CwQ==
X-Received: by 2002:a17:903:290f:b0:1a1:98a9:4069 with SMTP id lh15-20020a170903290f00b001a198a94069mr114436plb.9.1679424348670;
        Tue, 21 Mar 2023 11:45:48 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019cf747253csm9095878plj.87.2023.03.21.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:45:48 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com, Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v3 bpf-next 1/5] bpf: Implement batching in UDP iterator
Date:   Tue, 21 Mar 2023 18:45:37 +0000
Message-Id: <20230321184541.1857363-2-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
 net/ipv4/udp.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 213 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c605d171eb2d..545e56329355 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3152,6 +3152,141 @@ struct bpf_iter__udp {
 	int bucket __aligned(8);
 };
 
+struct bpf_udp_iter_state {
+	struct udp_iter_state state;
+	unsigned int cur_sk;
+	unsigned int end_sk;
+	unsigned int max_sk;
+	struct sock **batch;
+	bool st_bucket_done;
+};
+
+static unsigned short seq_file_family(const struct seq_file *seq);
+static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
+				      unsigned int new_batch_sz);
+
+static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
+{
+	unsigned short family = seq_file_family(seq);
+
+	/* AF_UNSPEC is used as a match all */
+	return ((family == AF_UNSPEC || family == sk->sk_family) &&
+		net_eq(sock_net(sk), seq_file_net(seq)));
+}
+
+static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
+{
+	struct bpf_udp_iter_state *iter = seq->private;
+	struct udp_iter_state *state = &iter->state;
+	struct net *net = seq_file_net(seq);
+	struct udp_seq_afinfo *afinfo = state->bpf_seq_afinfo;
+	struct udp_table *udptable;
+	struct sock *first_sk = NULL;
+	struct sock *sk;
+	unsigned int bucket_sks = 0;
+	bool first;
+	bool resized = false;
+
+	/* The current batch is done, so advance the bucket. */
+	if (iter->st_bucket_done)
+		state->bucket++;
+
+	udptable = udp_get_table_afinfo(afinfo, net);
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
+	first = true;
+
+	for (; state->bucket <= udptable->mask; state->bucket++) {
+		struct udp_hslot *hslot = &udptable->hash[state->bucket];
+
+		if (hlist_empty(&hslot->head))
+			continue;
+
+		spin_lock_bh(&hslot->lock);
+		sk_for_each(sk, &hslot->head) {
+			if (seq_sk_match(seq, sk)) {
+				if (first) {
+					first_sk = sk;
+					first = false;
+				}
+				if (iter->end_sk < iter->max_sk) {
+					sock_hold(sk);
+					iter->batch[iter->end_sk++] = sk;
+				}
+				bucket_sks++;
+			}
+		}
+		spin_unlock_bh(&hslot->lock);
+		if (first_sk)
+			break;
+	}
+
+	/* All done: no batch made. */
+	if (!first_sk)
+		return NULL;
+
+	if (iter->end_sk == bucket_sks) {
+		/* Batching is done for the current bucket; return the first
+		 * socket to be iterated from the batch.
+		 */
+		iter->st_bucket_done = true;
+		return first_sk;
+	}
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 / 2)) {
+		resized = true;
+		/* Go back to the previous bucket to resize its batch. */
+		state->bucket--;
+		goto again;
+	}
+	return first_sk;
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
+	if (iter->cur_sk < iter->end_sk)
+		sock_put(iter->batch[iter->cur_sk++]);
+
+	/* After updating iter->cur_sk, check if there are more sockets
+	 * available in the current bucket batch.
+	 */
+	if (iter->cur_sk < iter->end_sk) {
+		sk = iter->batch[iter->cur_sk];
+	} else {
+		// Prepare a new batch.
+		sk = bpf_iter_udp_batch(seq);
+	}
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
@@ -3172,18 +3307,38 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_prog *prog;
 	struct sock *sk = v;
 	uid_t uid;
+	bool slow;
+	int rc;
 
 	if (v == SEQ_START_TOKEN)
 		return 0;
 
+	slow = lock_sock_fast(sk);
+
+	if (unlikely(sk_unhashed(sk))) {
+		rc = SEQ_SKIP;
+		goto unlock;
+	}
+
 	uid = from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, false);
-	return udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
+	rc = udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
+
+unlock:
+	unlock_sock_fast(sk, slow);
+	return rc;
+}
+
+static void bpf_iter_udp_unref_batch(struct bpf_udp_iter_state *iter)
+{
+	while (iter->cur_sk < iter->end_sk)
+		sock_put(iter->batch[iter->cur_sk++]);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
 {
+	struct bpf_udp_iter_state *iter = seq->private;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 
@@ -3194,15 +3349,31 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
 			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
 	}
 
-	udp_seq_stop(seq, v);
+	if (iter->cur_sk < iter->end_sk) {
+		bpf_iter_udp_unref_batch(iter);
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
+
+static unsigned short seq_file_family(const struct seq_file *seq)
+{
+	const struct udp_seq_afinfo *afinfo;
+
+	/* BPF iterator: bpf programs to filter sockets. */
+	if (seq->op == &bpf_iter_udp_seq_ops)
+		return AF_UNSPEC;
+
+	/* Proc fs iterator */
+	afinfo = pde_data(file_inode(seq->file));
+	return afinfo->family;
+}
 #endif
 
 const struct seq_operations udp_seq_ops = {
@@ -3413,9 +3584,30 @@ static struct pernet_operations __net_initdata udp_sysctl_ops = {
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
+	bpf_iter_udp_unref_batch(iter);
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
-	struct udp_iter_state *st = priv_data;
+	struct bpf_udp_iter_state *iter = priv_data;
+	struct udp_iter_state *st = &iter->state;
 	struct udp_seq_afinfo *afinfo;
 	int ret;
 
@@ -3427,24 +3619,36 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	afinfo->udp_table = NULL;
 	st->bpf_seq_afinfo = afinfo;
 	ret = bpf_iter_init_seq_net(priv_data, aux);
-	if (ret)
+	if (ret) {
 		kfree(afinfo);
+		return ret;
+	}
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	if (ret) {
+		bpf_iter_fini_seq_net(priv_data);
+		return ret;
+	}
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
 	return ret;
 }
 
 static void bpf_iter_fini_udp(void *priv_data)
 {
-	struct udp_iter_state *st = priv_data;
+	struct bpf_udp_iter_state *iter = priv_data;
+	struct udp_iter_state *st = &iter->state;
 
-	kfree(st->bpf_seq_afinfo);
 	bpf_iter_fini_seq_net(priv_data);
+	kfree(st->bpf_seq_afinfo);
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

