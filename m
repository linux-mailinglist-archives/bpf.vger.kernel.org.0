Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00736E4D97
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDQPsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDQPs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:48:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A0E4A;
        Mon, 17 Apr 2023 08:48:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so15807982pjk.4;
        Mon, 17 Apr 2023 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746494; x=1684338494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j/CiSSG6ZrIbfi+5KIf4ADOVLoZxvO0xQE+FQMboro=;
        b=L4ucy6foP1tgbPdfjmtcWLR9O6NvDjMOviPj9FRo9r4eC6YpO97ReM/IZcIQc0avJc
         IjRzxMtU/7kh0VByS1OveKJdDtKa7X2HuCYDyG3vAjNxjf2oIfQYzVT0zPGIB69vlcOp
         aokhYgtBOr6meHto8CrxzX9Nw7gqmofgx4yrAyUOHTqiSa6eJPNw2f8dQ8QqRCBaLmXI
         dHCbZFM/k99HM6NyUbJSNQgUTYTs3+tYRDC2il9otYn+4CHQ2qz3isxJeN3cW172YdsZ
         p62CaDwsza36iIVv972A48L9ld6dyXKjo6IrxwGdyWfwn8iUGgqBFVMNj8OxMCc9QJUS
         ANUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746494; x=1684338494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+j/CiSSG6ZrIbfi+5KIf4ADOVLoZxvO0xQE+FQMboro=;
        b=LX3GVxtl5YmtEFj6wJz1fMrytgFbGLb9lvzsi7YEINF2cWh+v8BhUDbZt7F160vxdb
         MKvsiMtpil96XeoCUR/m8a+Ju+BdacULXN2GwNxAq9cWG27QAt5fdayQ9y3D7clQYYta
         duIpMHmqz+05sQQ+E8LargQuZc0hnkU/RMLgRUVejdQnr4QUexzvX7jKwa1sAr51B2C1
         H9wemTcsKhlO7AOaoK2MPXkkvAkxzYNJmMntDLaqlmYzCTjbxY5ddoquWXvdtO8qIC50
         xTSVj+FbxMaCK+WiqJy5+QRxT0SapbT3QYAoW+UCIdooQbc0NoarbiI15uZDk0epx8OA
         fLXA==
X-Gm-Message-State: AAQBX9eeNdUXB8okM34nPpgAcobN2/fSAC3rO7dW5wrhZgIGeZE7fnb1
        a0Q5FTIWSEe1fu7uo72OnEk=
X-Google-Smtp-Source: AKy350bgwC2lfDcoQkj9QHscMZ03FcyOAfrdc/v3lrED+lpWp4Gl+sSCT3Cm0sDQxI/ArAB6ME4Urw==
X-Received: by 2002:a17:903:645:b0:1a6:46f2:4365 with SMTP id kh5-20020a170903064500b001a646f24365mr10744242plb.30.1681746493962;
        Mon, 17 Apr 2023 08:48:13 -0700 (PDT)
Received: from vultr.guest ([2401:c080:3800:263c:5400:4ff:fe66:d27f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a6b308fcaesm4437513plb.153.2023.04.17.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:13 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
Date:   Mon, 17 Apr 2023 15:47:36 +0000
Message-Id: <20230417154737.12740-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417154737.12740-1-laoar.shao@gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently we use prog->active to prevent tracing recursion, but it has
some downsides,

- It can't identify different contexts
  That said, if a process context is interrupted by a irq context and
  the irq context runs the same code path, it will be considered as
  recursion. For example,
    normal:
      this_cpu_inc_return(*(prog->active)) == 1 <- OK

      irq:
        this_cpu_inc_return(*(prog->active)) == 1 <- FAIL!
        [ Considered as recusion ]

- It has to maintain a percpu area
  A percpu area will be allocated for each prog when the prog is loaded
  and be freed when the prog is destroyed.

Let's replace it with the generic tracing recursion prevention mechanism,
which can work fine with anything. In the above example, the irq context
won't be considered as recursion again,
  normal:
    test_recursion_try_acquire() <- OK

    softirq:
      test_recursion_try_acquire() <- OK

      irq:
        test_recursion_try_acquire() <- OK

Note that, currently one single recursion in process context is allowed
due to the TRACE_CTX_TRANSITION workaround, which can be fixed in the
future. That said, below behavior is expected currently,
  normal:
    test_recursion_try_acquire() <- OK
    [ recursion happens ]        <- one single recursion is allowed
    test_recursion_try_acquire() <- OK
    [ recursion happens ]
    test_recursion_try_acquire() <- RECURSION!

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h      |  2 +-
 kernel/bpf/core.c        | 10 ----------
 kernel/bpf/trampoline.c  | 44 +++++++++++++++++++++++++++++++++-----------
 kernel/trace/bpf_trace.c | 12 +++++++-----
 4 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 18b592f..c42ff90 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1467,7 +1467,6 @@ struct bpf_prog {
 	u32			jited_len;	/* Size of jited insns in bytes */
 	u8			tag[BPF_TAG_SIZE];
 	struct bpf_prog_stats __percpu *stats;
-	int __percpu		*active;
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
@@ -1813,6 +1812,7 @@ struct bpf_tramp_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	u64 bpf_cookie;
 	struct bpf_run_ctx *saved_run_ctx;
+	int recursion_bit;
 };
 
 static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487..0942ab2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -103,12 +103,6 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		vfree(fp);
 		return NULL;
 	}
-	fp->active = alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
-	if (!fp->active) {
-		vfree(fp);
-		kfree(aux);
-		return NULL;
-	}
 
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
@@ -138,7 +132,6 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 
 	prog->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
 	if (!prog->stats) {
-		free_percpu(prog->active);
 		kfree(prog->aux);
 		vfree(prog);
 		return NULL;
@@ -256,7 +249,6 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 		 */
 		fp_old->aux = NULL;
 		fp_old->stats = NULL;
-		fp_old->active = NULL;
 		__bpf_prog_free(fp_old);
 	}
 
@@ -272,7 +264,6 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		kfree(fp->aux);
 	}
 	free_percpu(fp->stats);
-	free_percpu(fp->active);
 	vfree(fp);
 }
 
@@ -1385,7 +1376,6 @@ static void bpf_prog_clone_free(struct bpf_prog *fp)
 	 */
 	fp->aux = NULL;
 	fp->stats = NULL;
-	fp->active = NULL;
 	__bpf_prog_free(fp);
 }
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f61d513..3df39a5 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -842,15 +842,21 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
 static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
-	rcu_read_lock();
-	migrate_disable();
-
-	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+	int bit;
 
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	rcu_read_lock();
+	bit = test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
+	run_ctx->recursion_bit = bit;
+	if (bit < 0) {
+		preempt_disable_notrace();
 		bpf_prog_inc_misses_counter(prog);
+		preempt_enable_notrace();
 		return 0;
 	}
+
+	migrate_disable();
+
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 	return bpf_prog_start_time();
 }
 
@@ -880,11 +886,16 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 					  struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
+	if (run_ctx->recursion_bit < 0)
+		goto out;
+
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	this_cpu_dec(*(prog->active));
 	migrate_enable();
+	test_recursion_release(run_ctx->recursion_bit);
+
+out:
 	rcu_read_unlock();
 }
 
@@ -916,15 +927,21 @@ static void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx)
 {
-	rcu_read_lock_trace();
-	migrate_disable();
-	might_fault();
+	int bit;
 
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	rcu_read_lock_trace();
+	bit = test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
+	run_ctx->recursion_bit = bit;
+	if (bit < 0) {
+		preempt_disable_notrace();
 		bpf_prog_inc_misses_counter(prog);
+		preempt_enable_notrace();
 		return 0;
 	}
 
+	migrate_disable();
+	might_fault();
+
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
 	return bpf_prog_start_time();
@@ -933,11 +950,16 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
 					     struct bpf_tramp_run_ctx *run_ctx)
 {
+	if (run_ctx->recursion_bit < 0)
+		goto out;
+
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	this_cpu_dec(*(prog->active));
 	migrate_enable();
+	test_recursion_release(run_ctx->recursion_bit);
+
+out:
 	rcu_read_unlock_trace();
 }
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bcf91bc..bb9a4c9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2250,16 +2250,18 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
-	cant_sleep();
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	int bit;
+
+	bit = test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
+	if (bit < 0) {
 		bpf_prog_inc_misses_counter(prog);
-		goto out;
+		return;
 	}
+	cant_sleep();
 	rcu_read_lock();
 	(void) bpf_prog_run(prog, args);
 	rcu_read_unlock();
-out:
-	this_cpu_dec(*(prog->active));
+	test_recursion_release(bit);
 }
 
 #define UNPACK(...)			__VA_ARGS__
-- 
1.8.3.1

