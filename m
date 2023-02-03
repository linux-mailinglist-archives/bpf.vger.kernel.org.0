Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C268A207
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 19:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBCS2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 13:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBCS2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 13:28:22 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB2196A2
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 10:28:21 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g18so4166733qtb.6
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwkDk2qVtPs7PR0+XfIPIXhSWZGch953amdBTFJ1cPE=;
        b=Jel5ERfsKzBgXPVKRDYGuAdrIOOxZtwIWoQwCalFf9VSKVGuHFmtK+k9Ikzlv6FDxh
         l4wufhiF0X+c05lmstB7U7HJxvbPbNhbdSUesD2KAZoY8xKTQf/ihMPHahJPgjmW58Pr
         sqdy0ZNoi4DV0WNwZBazyu46cndP3HqQibKvk5Ed2G+F2AzYuGheL8gwk6Wrom6ZbY7V
         w5CR/92FReQLZKkheETJ5TkM8buZGYuyr+RCNbDIeC2YqkrGbjCnQ8EVArdKJD8c9nKY
         HcH25LOkRzkQcPzCfrMs9dKmLfnVvgRMMLzudr6SCXwMjqJR/bI6rIBDu2wNLDy/cZSI
         QJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwkDk2qVtPs7PR0+XfIPIXhSWZGch953amdBTFJ1cPE=;
        b=i8C+V77e2XmdrQVEfN9MGw+JttUo9ZnXBz9+4ThBoYgt8I/pu6e7eOBum8jggJnoJs
         B2BfbqLHlVRYJfuuayl5T02fnxsYOtzMQ24jcvaQ9cY8K9Hzu1VFj3rchE7smwXwBYO2
         BrFRidmwwY0KAxmGMKVS4vyywLf1b544k+Z4vlRFRaY3J6wBcSMf3vyiEiW+lppJIN5l
         TiTdpqWUcgH9IxOYSDlG4aTKjUrnh9RrdNsnMQXTK0YhWY4ecwQyXTjDpTBmZFZYxACw
         rwVNXEdq30Jg3oJJ6sQa8xODyFRCIwAZPKKj0iAJGaBQ+LnQDjsHK8+tJW2kXkWJYME5
         I9tg==
X-Gm-Message-State: AO0yUKXfHkYsk50juSMU04knsngB0TIrHxEz2oRtt4nlCZLyu4M0nvXf
        QC1TOs66mKA0LBXJfTQT7uXweWtQE8te6A==
X-Google-Smtp-Source: AK7set+lFqRS8hpxeUsJ5GdWSrywe4DY/pr4Zs9Y1wF+6UEyiHgNpv/9o9zGtNIKMwcGN4Gk7/l5nw==
X-Received: by 2002:a05:622a:412:b0:3b8:61df:1c0 with SMTP id n18-20020a05622a041200b003b861df01c0mr19663023qtx.59.1675448900183;
        Fri, 03 Feb 2023 10:28:20 -0800 (PST)
Received: from grant-fedora.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id l16-20020ac84cd0000000b003b9bf862c04sm1983972qtv.55.2023.02.03.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:28:19 -0800 (PST)
From:   Grant Seltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kpsingh@kernel.org,
        Grant Seltzer <grantseltzer@gmail.com>
Subject: [PATCH v2 bpf-next] Add support for tracing programs in BPF_PROG_RUN
Date:   Fri,  3 Feb 2023 13:28:12 -0500
Message-Id: <20230203182812.20657-1-grantseltzer@gmail.com>
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

Changes v1 -> v2:
- Fixed unused variable and logic for how the fmod_ret test is handled

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 net/bpf/test_run.c | 77 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8da0d73b368e..0c36ed7dd88e 100644
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
-	u16 side_effect = 0, ret = 0;
-	int b = 2, err = -EFAULT;
-	u32 retval = 0;
+	int b = 2, err = -EFAULT, current_cpu;
+
+	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	struct bpf_tracing_test_run_info info;
+	int cpu = kattr->test.cpu;
+	u16 side_effect = 0;
 
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
@@ -820,7 +840,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
-		ret = bpf_modify_return_test(1, &b);
+		bpf_modify_return_test(1, &b);
 		if (b != 2)
 			side_effect = 1;
 		break;
@@ -828,11 +848,54 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
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
+	info.retval = ((u32)side_effect << 16) | info.retval;
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

