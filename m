Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D458E270DB8
	for <lists+bpf@lfdr.de>; Sat, 19 Sep 2020 13:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgISLtz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Sep 2020 07:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgISLtz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 19 Sep 2020 07:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600516193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvWrhE69TT6Sm+8G4L1mS/wtkOBRHmYk3NBKVV6w15g=;
        b=BmV34hZl/Dgii1DRkKuJBuMkqZt3FCsVEV8oQjzHAb85ilcOPbX9UWs/ohv0jr++eOm6m0
        O9R4tuBe1PpOgR8z6cC49j/nEyq0tZ4YS8o34as/rwlvK4vkhdGzRkhdJPbGA3y7RzWSVL
        +b725NSqnOwqM+Ektf34UZPFZsdxMEA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-lq8CZWQGMaWlggXTcqRXIQ-1; Sat, 19 Sep 2020 07:49:51 -0400
X-MC-Unique: lq8CZWQGMaWlggXTcqRXIQ-1
Received: by mail-ej1-f70.google.com with SMTP id w17so3130870eja.10
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2020 04:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DvWrhE69TT6Sm+8G4L1mS/wtkOBRHmYk3NBKVV6w15g=;
        b=KyKRo9QsbcEpSbJzW+WuGN6ORpVuVCAyrcO+XEVwHzuLijwk6LLOl2oZPpATzwir/r
         brUphY4q/y+FMZXyrQiOLUtE7Gv6k80T8QRdVaUOwfEGhFi/74W4pGPpAiLgfzWvjm6L
         DaARZxVKLJjxo5BEyxPMkCK5BdrHHLTThwhEtwGHo8845J6SmxgdvTVuJakp8/Sc4Y5S
         joR6cQRNgYZA88BjAtEAFfyrTveFn5KPwegHE/pkXiRu0T10G5z1+r2Bxk2co5Ts8rQ3
         tm3fgaFNVSDQtkK9m86lbCN/+A9tnstvo+D/fhCAMCQ5Gu6qDqNyp8Kx9f0xCTUhQTLI
         m7sw==
X-Gm-Message-State: AOAM531iNJ4KjouLimeakgWMidNF8qrMAkmze0Bhw+r2QJpqsCHt+7hV
        rDFxtkvD10HJT7og7XWH6ZEeceQAMimG7NT828c1E+gAuYz1J0B70t4PxhHH8qr8Xi7KUt+G7eh
        dG3eHDzRIcble
X-Received: by 2002:a50:fc87:: with SMTP id f7mr43087779edq.162.1600516189140;
        Sat, 19 Sep 2020 04:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyBPednQDWIZtqphvMF/yUM0jfvNxq1+Z7aCpM+fNQhXigAvPr/30jZoEGyyyudogdf+0EGg==
X-Received: by 2002:a50:fc87:: with SMTP id f7mr43087748edq.162.1600516188498;
        Sat, 19 Sep 2020 04:49:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t12sm4344856edy.61.2020.09.19.04.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 04:49:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 70110183A93; Sat, 19 Sep 2020 13:49:47 +0200 (CEST)
Subject: [PATCH bpf-next v7 04/10] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 19 Sep 2020 13:49:47 +0200
Message-ID: <160051618733.58048.1005452269573858636.stgit@toke.dk>
In-Reply-To: <160051618267.58048.2336966160671014012.stgit@toke.dk>
References: <160051618267.58048.2336966160671014012.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

In preparation for allowing multiple attachments of freplace programs, move
the references to the target program and trampoline into the
bpf_tracing_link structure when that is created. To do this atomically,
introduce a new mutex in prog->aux to protect writing to the two pointers
to target prog and trampoline, and rename the members to make it clear that
they are related.

With this change, it is no longer possible to attach the same tracing
program multiple times (detaching in-between), since the reference from the
tracing program to the target disappears on the first attach. However,
since the next patch will let the caller supply an attach target, that will
also make it possible to attach to the same place multiple times.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h     |   15 +++++++++-----
 kernel/bpf/btf.c        |    6 +++---
 kernel/bpf/core.c       |    9 ++++++---
 kernel/bpf/syscall.c    |   49 +++++++++++++++++++++++++++++++++++++++--------
 kernel/bpf/trampoline.c |   12 ++++--------
 kernel/bpf/verifier.c   |    9 +++++----
 6 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d444021f160..7aabea7fab31 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -614,8 +614,8 @@ static __always_inline unsigned int bpf_dispatcher_nop_func(
 }
 #ifdef CONFIG_BPF_JIT
 struct bpf_trampoline *bpf_trampoline_lookup(u64 key);
-int bpf_trampoline_link_prog(struct bpf_prog *prog);
-int bpf_trampoline_unlink_prog(struct bpf_prog *prog);
+int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
+int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
 struct bpf_trampoline *bpf_trampoline_get(u64 key, void *addr,
 					  struct btf_func_model *fmodel);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
@@ -666,11 +666,13 @@ static inline struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 {
 	return NULL;
 }
-static inline int bpf_trampoline_link_prog(struct bpf_prog *prog)
+static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
+					   struct bpf_trampoline *tr)
 {
 	return -ENOTSUPP;
 }
-static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
+static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
+					     struct bpf_trampoline *tr)
 {
 	return -ENOTSUPP;
 }
@@ -741,7 +743,9 @@ struct bpf_prog_aux {
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
 	const struct bpf_ctx_arg_aux *ctx_arg_info;
-	struct bpf_prog *linked_prog;
+	struct mutex tgt_mutex; /* protects writing of tgt_* pointers below */
+	struct bpf_prog *tgt_prog;
+	struct bpf_trampoline *tgt_trampoline;
 	bool verifier_zext; /* Zero extensions has been inserted by verifier. */
 	bool offload_requested;
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
@@ -749,7 +753,6 @@ struct bpf_prog_aux {
 	bool sleepable;
 	bool tail_call_reachable;
 	enum bpf_tramp_prog_type trampoline_prog_type;
-	struct bpf_trampoline *trampoline;
 	struct hlist_node tramp_hlist;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2ace56c99c36..9228af9917a8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3706,7 +3706,7 @@ struct btf *btf_parse_vmlinux(void)
 
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 {
-	struct bpf_prog *tgt_prog = prog->aux->linked_prog;
+	struct bpf_prog *tgt_prog = prog->aux->tgt_prog;
 
 	if (tgt_prog) {
 		return tgt_prog->aux->btf;
@@ -3733,7 +3733,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    struct bpf_insn_access_aux *info)
 {
 	const struct btf_type *t = prog->aux->attach_func_proto;
-	struct bpf_prog *tgt_prog = prog->aux->linked_prog;
+	struct bpf_prog *tgt_prog = prog->aux->tgt_prog;
 	struct btf *btf = bpf_prog_get_target_btf(prog);
 	const char *tname = prog->aux->attach_func_name;
 	struct bpf_verifier_log *log = info->log;
@@ -4572,7 +4572,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 		return -EFAULT;
 	}
 	if (prog_type == BPF_PROG_TYPE_EXT)
-		prog_type = prog->aux->linked_prog->type;
+		prog_type = prog->aux->tgt_prog->type;
 
 	t = btf_type_by_id(btf, t->type);
 	if (!t || !btf_type_is_func_proto(t)) {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c4811b139caa..0eb5f7501e29 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -99,6 +99,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 
 	INIT_LIST_HEAD_RCU(&fp->aux->ksym.lnode);
 	mutex_init(&fp->aux->used_maps_mutex);
+	mutex_init(&fp->aux->tgt_mutex);
 
 	return fp;
 }
@@ -255,6 +256,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 {
 	if (fp->aux) {
 		mutex_destroy(&fp->aux->used_maps_mutex);
+		mutex_destroy(&fp->aux->tgt_mutex);
 		free_percpu(fp->aux->stats);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
@@ -2138,7 +2140,8 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	if (aux->prog->has_callchain_buf)
 		put_callchain_buffers();
 #endif
-	bpf_trampoline_put(aux->trampoline);
+	if (aux->tgt_trampoline)
+		bpf_trampoline_put(aux->tgt_trampoline);
 	for (i = 0; i < aux->func_cnt; i++)
 		bpf_jit_free(aux->func[i]);
 	if (aux->func_cnt) {
@@ -2154,8 +2157,8 @@ void bpf_prog_free(struct bpf_prog *fp)
 {
 	struct bpf_prog_aux *aux = fp->aux;
 
-	if (aux->linked_prog)
-		bpf_prog_put(aux->linked_prog);
+	if (aux->tgt_prog)
+		bpf_prog_put(aux->tgt_prog);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
 	schedule_work(&aux->work);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2ce32cad5c8e..4af35a59d0d9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2161,7 +2161,9 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 			err = PTR_ERR(tgt_prog);
 			goto free_prog_nouncharge;
 		}
-		prog->aux->linked_prog = tgt_prog;
+		mutex_lock(&prog->aux->tgt_mutex);
+		prog->aux->tgt_prog = tgt_prog;
+		mutex_unlock(&prog->aux->tgt_mutex);
 	}
 
 	prog->aux->offload_requested = !!attr->prog_ifindex;
@@ -2498,11 +2500,22 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 struct bpf_tracing_link {
 	struct bpf_link link;
 	enum bpf_attach_type attach_type;
+	struct bpf_trampoline *trampoline;
+	struct bpf_prog *tgt_prog;
 };
 
 static void bpf_tracing_link_release(struct bpf_link *link)
 {
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(link->prog));
+	struct bpf_tracing_link *tr_link =
+		container_of(link, struct bpf_tracing_link, link);
+
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(link->prog,
+						tr_link->trampoline));
+
+	bpf_trampoline_put(tr_link->trampoline);
+
+	if (tr_link->tgt_prog)
+		bpf_prog_put(tr_link->tgt_prog);
 }
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -2545,7 +2558,9 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
 static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 {
 	struct bpf_link_primer link_primer;
+	struct bpf_prog *tgt_prog = NULL;
 	struct bpf_tracing_link *link;
+	struct bpf_trampoline *tr;
 	int err;
 
 	switch (prog->type) {
@@ -2583,19 +2598,37 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type = prog->expected_attach_type;
 
-	err = bpf_link_prime(&link->link, &link_primer);
-	if (err) {
-		kfree(link);
-		goto out_put_prog;
+	mutex_lock(&prog->aux->tgt_mutex);
+
+	if (!prog->aux->tgt_trampoline) {
+		err = -ENOENT;
+		goto out_unlock;
 	}
+	tr = prog->aux->tgt_trampoline;
+	tgt_prog = prog->aux->tgt_prog;
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto out_unlock;
 
-	err = bpf_trampoline_link_prog(prog);
+	err = bpf_trampoline_link_prog(prog, tr);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
-		goto out_put_prog;
+		link = NULL;
+		goto out_unlock;
 	}
 
+	link->tgt_prog = tgt_prog;
+	link->trampoline = tr;
+
+	prog->aux->tgt_prog = NULL;
+	prog->aux->tgt_trampoline = NULL;
+	mutex_unlock(&prog->aux->tgt_mutex);
+
 	return bpf_link_settle(&link_primer);
+out_unlock:
+	mutex_unlock(&prog->aux->tgt_mutex);
+	kfree(link);
 out_put_prog:
 	bpf_prog_put(prog);
 	return err;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e86d32f7f7dc..3145615647a5 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -261,14 +261,12 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-int bpf_trampoline_link_prog(struct bpf_prog *prog)
+int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
-	struct bpf_trampoline *tr;
 	int err = 0;
 	int cnt;
 
-	tr = prog->aux->trampoline;
 	kind = bpf_attach_type_to_tramp(prog);
 	mutex_lock(&tr->mutex);
 	if (tr->extension_prog) {
@@ -301,7 +299,7 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog)
 	}
 	hlist_add_head(&prog->aux->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
-	err = bpf_trampoline_update(prog->aux->trampoline);
+	err = bpf_trampoline_update(tr);
 	if (err) {
 		hlist_del(&prog->aux->tramp_hlist);
 		tr->progs_cnt[kind]--;
@@ -312,13 +310,11 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog)
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
-int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
+int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
-	struct bpf_trampoline *tr;
 	int err;
 
-	tr = prog->aux->trampoline;
 	kind = bpf_attach_type_to_tramp(prog);
 	mutex_lock(&tr->mutex);
 	if (kind == BPF_TRAMP_REPLACE) {
@@ -330,7 +326,7 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
 	}
 	hlist_del(&prog->aux->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	err = bpf_trampoline_update(prog->aux->trampoline);
+	err = bpf_trampoline_update(tr);
 out:
 	mutex_unlock(&tr->mutex);
 	return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 412b0810807f..7a53736e67b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2635,8 +2635,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 
 static enum bpf_prog_type resolve_prog_type(struct bpf_prog *prog)
 {
-	return prog->aux->linked_prog ? prog->aux->linked_prog->type
-				      : prog->type;
+	return prog->aux->tgt_prog ? prog->aux->tgt_prog->type : prog->type;
 }
 
 static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
@@ -11418,8 +11417,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 static int check_attach_btf_id(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
-	struct bpf_prog *tgt_prog = prog->aux->linked_prog;
 	u32 btf_id = prog->aux->attach_btf_id;
+	struct bpf_prog *tgt_prog = prog->aux->tgt_prog;
 	struct btf_func_model fmodel;
 	struct bpf_trampoline *tr;
 	const struct btf_type *t;
@@ -11483,7 +11482,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (!tr)
 		return -ENOMEM;
 
-	prog->aux->trampoline = tr;
+	mutex_lock(&prog->aux->tgt_mutex);
+	prog->aux->tgt_trampoline = tr;
+	mutex_unlock(&prog->aux->tgt_mutex);
 	return 0;
 }
 

