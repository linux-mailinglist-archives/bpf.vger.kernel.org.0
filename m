Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA46E6829
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjDRPcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjDRPcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6AE79
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so1476920a91.0
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681831922; x=1684423922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efU6hnJJgSZ1G+H3G+oVBU3mRSmbJcHbOU8ItivXOpU=;
        b=eGDyrROKHd87UsvY8ukv5fl861gHaAYH12ZzJPOmq2wiJd69FW0tW+sgn9j+btyakY
         JCZSKGZbVNKZU4VJyQmLEVft8WLRauVY4zjIGR0Owcw30Sg645J6VpQOA8joLNm4EI2i
         pVb27raOVse8DvZwfHVvY7h3fjmTeG58zGcY1UU2VFvJj5y2V6quJD5zkp8uzb5ROwaT
         pTuq0Nf8+wFCPDuWK5A1iK7r+NCFkowSmEaeXPQRUIDVGKJGWJZ1gBviuE0IAx0+WTVD
         KkXZSe/44/f4F3zlnikS+tI6FL6vde21dUEINu3CDRjjE3VhMKL5BXPIG/oeeS1AHuxM
         d9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831922; x=1684423922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efU6hnJJgSZ1G+H3G+oVBU3mRSmbJcHbOU8ItivXOpU=;
        b=ei5H1K7NLz+UeyKkf+K7I6XEiJn54gxd1vMDbrjwyxkFe9JxBEj2ZnU0U7KJtOsAxI
         /DJh4Vj6rHbwKbcFCfw/bORIAn8f/GE5EcrEUJ9x36O34zjAKnWuKkcNZ1zP7zOpVhNv
         cVMPOyLEvu7ixAX3FgkU7l6nUXhcvY5ThngSguTwLBxbVKDW3qvykOvZM7pPNVQnPyxV
         i1WWHUiIsYaoEMfYiLmVLsYQZmDBR9pYB5YTn7lx7Eq6i89W+vYmwPYtSmJ2OSaH1HQf
         5KtTcFR7qheUUqvarFdmrJTuNo7t2X+Fqi+YgoBRJM29kdU3VjuA2wuAQPEs1A72pp+Q
         0Ztw==
X-Gm-Message-State: AAQBX9dyEPLxlFmhBFsVxOZQvdJoYoUlFlQnAZ69jDLP+D59nlRYR4FD
        FDBwM4L8XOqxypeifQjftzT+sDhxjC1OjW3nZ5U=
X-Google-Smtp-Source: AKy350a04czOqn/VQjYVzug54qWjnpYNkdQ0KwDaY+1xkwoSKNRFrgkk6usyBhulKeJZWbcA7JBxlg==
X-Received: by 2002:a17:902:ce0c:b0:1a1:a800:96a7 with SMTP id k12-20020a170902ce0c00b001a1a80096a7mr2548581plg.8.1681831921971;
        Tue, 18 Apr 2023 08:32:01 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id ba4-20020a170902720400b001a647709864sm9769630plb.155.2023.04.18.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:32:01 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com, Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 4/7] bpf: udp: Implement batching for sockets iterator
Date:   Tue, 18 Apr 2023 15:31:45 +0000
Message-Id: <20230418153148.2231644-5-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 net/ipv4/udp.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 203 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8689ed171776..f1c001641e53 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3148,6 +3148,145 @@ struct bpf_iter__udp {
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
+	struct udp_seq_afinfo afinfo;
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
+	afinfo.family = AF_UNSPEC;
+	afinfo.udp_table = NULL;
+	udptable = udp_get_table_afinfo(&afinfo, net);
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
+		goto ret;
+	}
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+		resized = true;
+		/* Go back to the previous bucket to resize its batch. */
+		state->bucket--;
+		goto again;
+	}
+ret:
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
@@ -3168,18 +3307,37 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_prog *prog;
 	struct sock *sk = v;
 	uid_t uid;
+	int rc;
 
 	if (v == SEQ_START_TOKEN)
 		return 0;
 
+	lock_sock(sk);
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
+	release_sock(sk);
+	return rc;
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
 
@@ -3190,12 +3348,15 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
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
@@ -3424,21 +3585,57 @@ static struct pernet_operations __net_initdata udp_sysctl_ops = {
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
+	if (ret) {
+		bpf_iter_fini_seq_net(priv_data);
+		return ret;
+	}
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

