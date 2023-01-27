Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CFB67F092
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 22:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjA0Vn7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 16:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjA0Vn6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 16:43:58 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B495C0F7
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 13:43:57 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h24so5233750qta.12
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 13:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UsA+27R3TBfsDeMt4sz63KudYROsIVNdtU+Tupx2XW4=;
        b=Ci4nubZTqNKPKc2H/ElkjWOQPtQX4aorAUcsOd8yprT5GAePQSIH1pbpyJruJAxdPQ
         RNhXHkIOR67WwD3oHGnoaFskq6XoK1v9C6AK31RWAUCQbit5ogH8q5v+lrOs8qnqZQem
         DKzkduFveStXUGs5Sl++YxdRV3O40GQ5NnMRH1WkaExkj+5FKgEtscLwcw3SojsTMx9Q
         daIR4iE7tVb/crhopT/KZ1GaB4FAdBLCVs9mDqfh7J8IHKwat5VcOPadlI06h7SubKYs
         7oYomYCtORhmYWEl0xxwS6umufhaz0YMyrSoe4cgAiAiDoPd2g+Wqf6jBHXdCUTHNxzi
         1GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsA+27R3TBfsDeMt4sz63KudYROsIVNdtU+Tupx2XW4=;
        b=jBWa1dhDUqfmLz9JxQ6XpdVzUCrsFooWetjw4H6DTJjkKg45seomc3w173IXlWWm3I
         rIvVeMPcLgdwxin3jenzW4Zn87xLtTcLoBXqwwqXwXoJH4mF4qot6G+5Bn+Z+beGGYic
         L2anFTBesL4JOw03KwqPbO57D7zrfaceMc79zBITy+XPfvn9f0tjE/QRYAmts2s2pQnt
         AjGMQnWjpOb7SYBo6Ng6T1o/TQFpDuL6MrCu7QzVb2u0e0qRT/8X4aRaf8SXjJUw2aKC
         qVCqAjWh8K/IBJjYGLxSEK3XE9subNGq5unvUxKmofohxEa0TjYpJkCpBdNACOXeCdtR
         /1UQ==
X-Gm-Message-State: AFqh2krWs6xDBKAKmsdlH3LcvsAdOBxpgtVlxSzwUieE3mNeXqM8My6U
        DbglduvKAweIQYlNFWq0+FtQVX8FgvL/5g==
X-Google-Smtp-Source: AMrXdXvI8MQ/PEZVKzFa2AIUW7/o8qkzzhnxe/pMFiiw/vQ+8qvD6aMIpIkJhrQOYo6cKnpSdJqM4A==
X-Received: by 2002:ac8:70d9:0:b0:3b3:7707:9b92 with SMTP id g25-20020ac870d9000000b003b377079b92mr59197589qtp.15.1674855836788;
        Fri, 27 Jan 2023 13:43:56 -0800 (PST)
Received: from grant-fedora.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id pe27-20020a05620a851b00b0071883954df4sm2009156qkn.103.2023.01.27.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:43:56 -0800 (PST)
From:   Grant Seltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] Add support for tracing programs in BPF_PROG_RUN
Date:   Fri, 27 Jan 2023 16:43:53 -0500
Message-Id: <20230127214353.628551-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch changes the behavior of how BPF_PROG_RUN treats tracing
(fentry/fexit) programs. Previously only a return value is injected
but the actual program was not run. New behavior mirrors that of
running raw tracepoint BPF programs which actually runs the
instructions of the program via `bpf_prog_run()`

Tracing programs only needs to support an input context so we validate
that non-relevant attributes are not set.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 net/bpf/test_run.c | 72 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8da0d73b368e..e4023c7b3bc7 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -794,14 +794,34 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	return data;
 }
 
+struct bpf_tracing_test_run_info {
+	struct bpf_prog *prog;
+	void *ctx;
+	u32 retval;
+};
+
+static void
+__bpf_prog_test_run_tracing(void *data)
+{
+	struct bpf_tracing_test_run_info *info = data;
+
+	rcu_read_lock();
+	info->retval = bpf_prog_run(info->prog, info->ctx);
+	rcu_read_unlock();
+}
+
 int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
 {
 	struct bpf_fentry_test_t arg = {};
 	u16 side_effect = 0, ret = 0;
-	int b = 2, err = -EFAULT;
-	u32 retval = 0;
+	int b = 2, err = -EFAULT, current_cpu;
+
+	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	struct bpf_tracing_test_run_info info;
+	int cpu = kattr->test.cpu;
 
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
@@ -828,11 +848,53 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		goto out;
 	}
 
-	retval = ((u32)side_effect << 16) | ret;
-	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
-		goto out;
+	/* doesn't support data_in/out, ctx_out, duration, or repeat */
+	if (kattr->test.data_in || kattr->test.data_out ||
+	    kattr->test.ctx_out || kattr->test.duration ||
+	    kattr->test.repeat || kattr->test.batch_size)
+		return -EINVAL;
+
+	if (ctx_size_in < prog->aux->max_ctx_offset ||
+	    ctx_size_in > MAX_BPF_FUNC_ARGS * sizeof(u64))
+		return -EINVAL;
+
+	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 && cpu != 0)
+		return -EINVAL;
+
+	if (ctx_size_in) {
+		info.ctx = memdup_user(ctx_in, ctx_size_in);
+		if (IS_ERR(info.ctx))
+			return PTR_ERR(info.ctx);
+	} else {
+		info.ctx = NULL;
+	}
 
 	err = 0;
+	info.prog = prog;
+
+	current_cpu = get_cpu();
+	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 ||
+	    cpu == current_cpu) {
+		__bpf_prog_test_run_tracing(&info);
+	} else if (cpu >= nr_cpu_ids || !cpu_online(cpu)) {
+		/* smp_call_function_single() also checks cpu_online()
+		 * after csd_lock(). However, since cpu is from user
+		 * space, let's do an extra quick check to filter out
+		 * invalid value before smp_call_function_single().
+		 */
+		err = -ENXIO;
+	} else {
+		err = smp_call_function_single(cpu, __bpf_prog_test_run_tracing,
+					       &info, 1);
+	}
+	put_cpu();
+
+	if (!err &&
+	    copy_to_user(&uattr->test.retval, &info.retval, sizeof(u32)))
+		err = -EFAULT;
+
+	kfree(info.ctx);
+
 out:
 	trace_bpf_test_finish(&err);
 	return err;
-- 
2.39.1

