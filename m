Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9986C3971
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCUSqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCUSq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:46:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AFD56537
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so21263915pjv.5
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679424350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2I8quhFbc4vtkKyPv2g0+bAejfUzQ0M28B7xFlLMww=;
        b=Ci1LNHOvS/bCINF6xdghYzt8y5OvEz6H7oGUl90XFYvowKMIu2o87UvS3hxRyqsSx2
         KqCrH3t1RPokuE3Flyi0km1jDh3znDAZZRi/N4h9lEzFnJqNrG+ST6j5OQ0bAPczzn0z
         Ir2easmGoCNTXqCdkit/taS1qq8RCtCF2AryGu72U/dG933cX6XxBQyvbaHQ/cj2OEQj
         Jj4XqGPscSxNHxcjHRjOlgdOEAXZU8jwT16Ip3w4TnRJj0Cl7L9ZqI7lNG2MsyKNdNah
         dBLMELtaKTBm1E3obq4CDJuQsUWV7q9W1nAwIHd2oOqqwrBklzao+NtxLNf4Hz/koRIR
         yBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2I8quhFbc4vtkKyPv2g0+bAejfUzQ0M28B7xFlLMww=;
        b=zK4K2g4PBjJmYGVbLHM6HbdKA/o1zazwSKLBzrK44O+C49oV8t355FoygQZ7BFTKIr
         V3a3w9NtZY+gswYNIlq6WrkermAOveT6QA8MOp9yhMN0Dku7/XvGFPDvauxgGfV8c49/
         Nag6IrbyR66CpYRB6h94tt5JHSKTXOhx/yaKfK9BLq80KEdAHhnORmxwhffrDsNVTDRL
         E+fCcrbTvgm8pzKhUdLQTOG/7CJCSK8b0dfDbTaNcys6PKTj5xnJELKHhx91tCQrTV7u
         ZPk8UxsH5DR4UWqdfx5cRK5bgU156rrbZC1Lr+sQpHaeA/1Wjj/R+A8vdKu6oZhZUuq6
         NyTw==
X-Gm-Message-State: AO0yUKV9YRq2Jl1Sv4eLrxZKhy3kS9E+libet+yztqhr4dxvmzlagoJ+
        pdY+p3XUT0jSO4YghBoSti3H3/FMdEUyDObQzWA=
X-Google-Smtp-Source: AK7set9wv+gfg/D5F7prkanrzjRiPDZrwBSHEo2e66LQ5zZv4HUGhwst8JSCw+zzNKgrsFSZVPOrnQ==
X-Received: by 2002:a17:902:e5d2:b0:1a1:956e:542f with SMTP id u18-20020a170902e5d200b001a1956e542fmr171121plf.19.1679424349728;
        Tue, 21 Mar 2023 11:45:49 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019cf747253csm9095878plj.87.2023.03.21.11.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:45:49 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v3 bpf-next 2/5] bpf: Add bpf_sock_destroy kfunc
Date:   Tue, 21 Mar 2023 18:45:38 +0000
Message-Id: <20230321184541.1857363-3-aditi.ghag@isovalent.com>
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

The socket destroy kfunc is used to forcefully terminate sockets from
certain BPF contexts. We plan to use the capability in Cilium to force
client sockets to reconnect when their remote load-balancing backends are
deleted. The other use case is on-the-fly policy enforcement where existing
socket connections prevented by policies need to be forcefully terminated.
The helper allows terminating sockets that may or may not be actively
sending traffic.

The helper is currently exposed to certain BPF iterators where users can
filter, and terminate selected sockets.  Additionally, the helper can only
be called from these BPF contexts that ensure socket locking in order to
allow synchronous execution of destroy helpers that also acquire socket
locks. The previous commit that batches UDP sockets during iteration
facilitated a synchronous invocation of the destroy helper from BPF context
by skipping taking socket locks in the destroy handler. TCP iterators
already supported batching.

The helper takes `sock_common` type argument, even though it expects, and
casts them to a `sock` pointer. This enables the verifier to allow the
sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
`sock` structs. As a comparison, BPF helpers enable this behavior with the
`ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no such
option available with the verifier logic that handles kfuncs where BTF
types are inferred. Furthermore, as `sock_common` only has a subset of
certain fields of `sock`, casting pointer to the latter type might not
always be safe. Hence, the BPF kfunc converts the argument to a full sock
before casting.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 include/net/udp.h |  1 +
 net/core/filter.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c    | 16 +++++++++----
 net/ipv4/udp.c    | 60 +++++++++++++++++++++++++++++++++++++----------
 4 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index de4b528522bb..d2999447d3f2 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -437,6 +437,7 @@ struct udp_seq_afinfo {
 struct udp_iter_state {
 	struct seq_net_private  p;
 	int			bucket;
+	int			offset;
 	struct udp_seq_afinfo	*bpf_seq_afinfo;
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 1d6f165923bf..ba3e0dac119c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 
 	return func;
 }
+
+/* Disables missing prototype warnings */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
+ *
+ * The helper expects a non-NULL pointer to a socket. It invokes the
+ * protocol specific socket destroy handlers.
+ *
+ * The helper can only be called from BPF contexts that have acquired the socket
+ * locks.
+ *
+ * Parameters:
+ * @sock: Pointer to socket to be destroyed
+ *
+ * Return:
+ * On error, may return EPROTONOSUPPORT, EINVAL.
+ * EPROTONOSUPPORT if protocol specific destroy handler is not implemented.
+ * 0 otherwise
+ */
+__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
+{
+	struct sock *sk = (struct sock *)sock;
+
+	if (!sk)
+		return -EINVAL;
+
+	/* The locking semantics that allow for synchronous execution of the
+	 * destroy handlers are only supported for TCP and UDP.
+	 */
+	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
+		return -EOPNOTSUPP;
+
+	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
+}
+
+__diag_pop()
+
+BTF_SET8_START(sock_destroy_kfunc_set)
+BTF_ID_FLAGS(func, bpf_sock_destroy)
+BTF_SET8_END(sock_destroy_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &sock_destroy_kfunc_set,
+};
+
+static int init_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sock_destroy_kfunc_set);
+}
+late_initcall(init_subsystem);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 33f559f491c8..59a833c0c872 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
 		return 0;
 	}
 
-	/* Don't race with userspace socket closes such as tcp_close. */
-	lock_sock(sk);
+	/* BPF context ensures sock locking. */
+	if (!has_current_bpf_ctx())
+		/* Don't race with userspace socket closes such as tcp_close. */
+		lock_sock(sk);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -4688,7 +4690,8 @@ int tcp_abort(struct sock *sk, int err)
 
 	/* Don't race with BH socket closes such as inet_csk_listen_stop. */
 	local_bh_disable();
-	bh_lock_sock(sk);
+	if (!has_current_bpf_ctx())
+		bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		sk->sk_err = err;
@@ -4700,10 +4703,13 @@ int tcp_abort(struct sock *sk, int err)
 		tcp_done(sk);
 	}
 
-	bh_unlock_sock(sk);
+	if (!has_current_bpf_ctx())
+		bh_unlock_sock(sk);
+
 	local_bh_enable();
 	tcp_write_queue_purge(sk);
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_abort);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 545e56329355..02d357713838 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);
 
 int udp_abort(struct sock *sk, int err)
 {
-	lock_sock(sk);
+	/* BPF context ensures sock locking. */
+	if (!has_current_bpf_ctx())
+		lock_sock(sk);
 
 	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
 	 * with close()
@@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
 	__udp_disconnect(sk, 0);
 
 out:
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 
 	return 0;
 }
@@ -3184,15 +3187,23 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	struct sock *first_sk = NULL;
 	struct sock *sk;
 	unsigned int bucket_sks = 0;
-	bool first;
 	bool resized = false;
+	int offset = 0;
+	int new_offset;
 
 	/* The current batch is done, so advance the bucket. */
-	if (iter->st_bucket_done)
+	if (iter->st_bucket_done) {
 		state->bucket++;
+		state->offset = 0;
+	}
 
 	udptable = udp_get_table_afinfo(afinfo, net);
 
+	if (state->bucket > udptable->mask) {
+		state->bucket = 0;
+		state->offset = 0;
+	}
+
 again:
 	/* New batch for the next bucket.
 	 * Iterate over the hash table to find a bucket with sockets matching
@@ -3204,43 +3215,60 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
 	iter->st_bucket_done = false;
-	first = true;
+	first_sk = NULL;
+	bucket_sks = 0;
+	offset = state->offset;
+	new_offset = offset;
 
 	for (; state->bucket <= udptable->mask; state->bucket++) {
 		struct udp_hslot *hslot = &udptable->hash[state->bucket];
 
-		if (hlist_empty(&hslot->head))
+		if (hlist_empty(&hslot->head)) {
+			offset = 0;
 			continue;
+		}
 
 		spin_lock_bh(&hslot->lock);
+		/* Resume from the last saved position in a bucket before
+		 * iterator was stopped.
+		 */
+		while (offset-- > 0) {
+			sk_for_each(sk, &hslot->head)
+				continue;
+		}
 		sk_for_each(sk, &hslot->head) {
 			if (seq_sk_match(seq, sk)) {
-				if (first) {
+				if (!first_sk)
 					first_sk = sk;
-					first = false;
-				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
 					iter->batch[iter->end_sk++] = sk;
 				}
 				bucket_sks++;
 			}
+			new_offset++;
 		}
 		spin_unlock_bh(&hslot->lock);
+
 		if (first_sk)
 			break;
+
+		/* Reset the current bucket's offset before moving to the next bucket. */
+		offset = 0;
+		new_offset = 0;
+
 	}
 
 	/* All done: no batch made. */
 	if (!first_sk)
-		return NULL;
+		goto ret;
 
 	if (iter->end_sk == bucket_sks) {
 		/* Batching is done for the current bucket; return the first
 		 * socket to be iterated from the batch.
 		 */
 		iter->st_bucket_done = true;
-		return first_sk;
+		goto ret;
 	}
 	if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 / 2)) {
 		resized = true;
@@ -3248,19 +3276,24 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		state->bucket--;
 		goto again;
 	}
+ret:
+	state->offset = new_offset;
 	return first_sk;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
+	struct udp_iter_state *state = &iter->state;
 	struct sock *sk;
 
 	/* Whenever seq_next() is called, the iter->cur_sk is
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
-	if (iter->cur_sk < iter->end_sk)
+	if (iter->cur_sk < iter->end_sk) {
 		sock_put(iter->batch[iter->cur_sk++]);
+		++state->offset;
+	}
 
 	/* After updating iter->cur_sk, check if there are more sockets
 	 * available in the current bucket batch.
@@ -3630,6 +3663,9 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	}
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
+	iter->st_bucket_done = false;
+	st->bucket = 0;
+	st->offset = 0;
 
 	return ret;
 }
-- 
2.34.1

