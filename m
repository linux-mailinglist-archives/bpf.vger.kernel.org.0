Return-Path: <bpf+bounces-979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC070A2F0
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5913D1C21164
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319606ABB;
	Fri, 19 May 2023 22:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B86AB3
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:13 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7AF118
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5307502146aso2676372a12.1
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536727; x=1687128727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bacljcxrDeAgSZeFU8xK+6nN1o9Ylg1NYfYtT1T+joA=;
        b=iTabYBjfZczqFprKIunAQZThHTcefXY9y4ZgGPxeTx3zFcFuSU0/mmVRswcwV/0NxT
         mAgvHxhjx6lwRlz7oHVe0WHu9Sd4kWt9F1pZIQYIaM3auOfrefs4vFZd1dktTRkIq1Zk
         6RHBCHg2aGUnaJA47ZqvnGBWMpoAitmypn5DkjYGiSTZnp/3xGremOYzrm8tDveCBRgZ
         dmEqG4Xynx/q/i5cg9e1q6KVTIHcndWs7e1sZ5mX+ZsoGXw+XN/12ccOBznERsr/kD4P
         CkzUloht+8Zg09pYF6luIiaeLkVpo7WZpPm7e2lvOrKC7+emNX1ZbvEAo5MsJVqnbL+j
         VnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536727; x=1687128727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bacljcxrDeAgSZeFU8xK+6nN1o9Ylg1NYfYtT1T+joA=;
        b=KxN00d3SC82FqtYAQtlTxv/6t5E7q3og1ClDcIdBnRMp3RNkzhxkRZf8GbrohngqTo
         IE9gvA2wBopAklbApt4PdbMO4Zg1InzwGf/II25PGSipQDCZyZZOX7VO0hRirFtx+GY4
         42sx+R5wd27NH+o8hsoO8QEagnhGHoDSRq+V498W85QSl5FPU1ml408Vz8zgzqoX0v3I
         br7q3lve/1XrfS/TqAmCzYKNYQypFmHvocctfqlcfBRP9viQOR9HoZE3DTQl0QZWWGXd
         TW0NgcGtqGr/WhuchDPsbd0HQpQdG66G/GkwjGazyP/GvZH1H+TB87Mdpv5TO/9PSIvC
         yU1w==
X-Gm-Message-State: AC+VfDyPA3Ukj9MKoyMvkxEPzssK+W5rHj+dSQSUX4vNwT4yInRSzFfX
	EhP4aOBAIWb1q61oLOZwSGWVjUdUXo/+Jwjr3+k=
X-Google-Smtp-Source: ACHHUZ7XVVA4RXbHtAZgit9YR5i2i+PYriUfwuhqcHFCBSd/CWuJu5h/wPS77y+SfpepyypB2ePMDw==
X-Received: by 2002:a17:902:748c:b0:1ad:cf40:4f0c with SMTP id h12-20020a170902748c00b001adcf404f0cmr3792849pll.53.1684536727261;
        Fri, 19 May 2023 15:52:07 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:06 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v9 bpf-next 5/9] bpf: udp: Implement batching for sockets iterator
Date: Fri, 19 May 2023 22:51:53 +0000
Message-Id: <20230519225157.760788-6-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
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


