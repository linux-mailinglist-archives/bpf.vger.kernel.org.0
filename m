Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617866D094A
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjC3PTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjC3PTp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D0C177
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s19so11565428pgi.0
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680189501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWfRXbE3ZHJxRbTfZMhbXzd5pM7CkBXB2XSVU2K7wQg=;
        b=VGIhDQLitwDCmpbkeatBNhkdDs0EGqswBMH6tBuv5mgYpdnzz4TLxJtFcL7r822cH4
         6dn8ArNMN1psAvBeqVh+mw32DEOMnmZxyWBSMsPdenNTrAcJiWgXcQdmFD6RaD9YJYx5
         4px4izwWwZXohIF2Bdi4ot/bVh3Z0YY3sNnxSt0aSyvx5DeVSfz1eadOHuxTZH20nIPu
         qqDIr7YIfqT/jc6uzVe7u0XcK2ZTAATbW6u1YWADrYN7lJPFB5x7t+UOw0ZirvA+39wB
         8/1rHrmFjewsroUa+C9G9Nf66EQqMpyxIBGLvCPxFZqzhSNhtZ2j9h1bVuZJXA754eTY
         F+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWfRXbE3ZHJxRbTfZMhbXzd5pM7CkBXB2XSVU2K7wQg=;
        b=ynAeiZoI5Swq8repkvEgIbRcLvvOacGl78AejQDNZu6UuWdZ3XKnUv0Tm0sneDFtZ1
         qQFY5P+971JezDvHNUwzjuVsU54Crm4aV+5EpIKGe8HsX8GFdQN3IEy0tQZ0ysC3VyE3
         Dk3+blYvpnFYhqq+H1RGqAcWGEU1ZRHNMLxSPVYct4llIC0ARP8pd1Z9uAXoupi6ODlD
         3pjuH0lkUZISl34Dy3pEDbYLQUXNIcfjpn1OZrkK3LIJ0Q7OO4e6AHV37WhYJDlNXJtf
         VrHBEaFJD97DsX8k+zc803RpdwHsO05hbR+dy+ymoKsUMXxmPhfg3bic9vPIEPAda21Y
         4ooQ==
X-Gm-Message-State: AAQBX9dQJrqvXEe0W3IzNxjkIGC7ioZTQHkcp3UoNXTeXnvS1/XNMmOx
        uJZpjnhAvCVYl4pibxaY3e8C6tU3q9kXtw03yyY=
X-Google-Smtp-Source: AKy350ajT4HmzuzO8AU0+E0rmcMGV9yQLCWkQwrq++cb4U2WN0vuti7Bnkq1zFy06Id02q24M9K+xA==
X-Received: by 2002:aa7:8e8e:0:b0:625:7300:5550 with SMTP id a14-20020aa78e8e000000b0062573005550mr24366541pfr.31.1680189501147;
        Thu, 30 Mar 2023 08:18:21 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a63de11000000b004fc1d91e695sm23401177pgg.79.2023.03.30.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:18:20 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com, Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v5 bpf-next 4/7] bpf: udp: Implement batching for sockets iterator
Date:   Thu, 30 Mar 2023 15:17:55 +0000
Message-Id: <20230330151758.531170-5-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330151758.531170-1-aditi.ghag@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 net/ipv4/udp.c | 230 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 213 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cead4acb64c6..9af23d1c8d6b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3140,7 +3140,19 @@ struct bpf_iter__udp {
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
 static unsigned short seq_file_family(const struct seq_file *seq);
+static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
+				      unsigned int new_batch_sz);
 
 static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
 {
@@ -3151,6 +3163,149 @@ static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
 		net_eq(sock_net(sk), seq_file_net(seq)));
 }
 
+static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
+{
+	struct bpf_udp_iter_state *iter = seq->private;
+	struct udp_iter_state *state = &iter->state;
+	struct net *net = seq_file_net(seq);
+	struct sock *first_sk = NULL;
+	struct udp_seq_afinfo afinfo;
+	struct udp_table *udptable;
+	unsigned int batch_sks = 0;
+	bool resized = false;
+	struct sock *sk;
+	int offset = 0;
+	int new_offset;
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
+	if (state->bucket > udptable->mask) {
+		state->bucket = 0;
+		iter->offset = 0;
+		return NULL;
+	}
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
+	first_sk = NULL;
+	batch_sks = 0;
+	offset = iter->offset;
+
+	for (; state->bucket <= udptable->mask; state->bucket++) {
+		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
+
+		if (hlist_empty(&hslot2->head)) {
+			offset = 0;
+			continue;
+		}
+		new_offset = offset;
+
+		spin_lock_bh(&hslot2->lock);
+		udp_portaddr_for_each_entry(sk, &hslot2->head) {
+			if (seq_sk_match(seq, sk)) {
+				/* Resume from the last iterated socket at the
+				 * offset in the bucket before iterator was stopped.
+				 */
+				if (offset) {
+					--offset;
+					continue;
+				}
+				if (!first_sk)
+					first_sk = sk;
+				if (iter->end_sk < iter->max_sk) {
+					sock_hold(sk);
+					iter->batch[iter->end_sk++] = sk;
+				}
+				batch_sks++;
+				new_offset++;
+			}
+		}
+		spin_unlock_bh(&hslot2->lock);
+
+		if (first_sk)
+			break;
+
+		/* Reset the current bucket's offset before moving to the next bucket. */
+		offset = 0;
+	}
+
+	/* All done: no batch made. */
+	if (!first_sk)
+		goto ret;
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
+	iter->offset = new_offset;
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
@@ -3171,18 +3326,37 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
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
 
@@ -3193,12 +3367,15 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
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
@@ -3425,38 +3602,57 @@ static struct pernet_operations __net_initdata udp_sysctl_ops = {
 DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
-static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
+static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
+				      unsigned int new_batch_sz)
 {
-	struct udp_iter_state *st = priv_data;
-	struct udp_seq_afinfo *afinfo;
-	int ret;
+	struct sock **new_batch;
 
-	afinfo = kmalloc(sizeof(*afinfo), GFP_USER | __GFP_NOWARN);
-	if (!afinfo)
+	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
+				   GFP_USER | __GFP_NOWARN);
+	if (!new_batch)
 		return -ENOMEM;
 
-	afinfo->family = AF_UNSPEC;
-	afinfo->udp_table = NULL;
-	st->bpf_seq_afinfo = afinfo;
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
+static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	struct bpf_udp_iter_state *iter = priv_data;
+	int ret;
+
 	ret = bpf_iter_init_seq_net(priv_data, aux);
 	if (ret)
-		kfree(afinfo);
+		return ret;
+
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	if (ret) {
+		bpf_iter_fini_seq_net(priv_data);
+		return ret;
+	}
+
 	return ret;
 }
 
 static void bpf_iter_fini_udp(void *priv_data)
 {
-	struct udp_iter_state *st = priv_data;
+	struct bpf_udp_iter_state *iter = priv_data;
 
-	kfree(st->bpf_seq_afinfo);
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

