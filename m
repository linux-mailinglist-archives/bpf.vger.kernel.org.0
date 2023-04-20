Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2C6E9FD1
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjDTXYg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjDTXYf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:24:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0DD2697
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec8149907aso1008193e87.1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682033072; x=1684625072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpLh1YPaAj9o+5fwNYt3O9O1Ii34BKqLkycFi7e+Xos=;
        b=U2DgZR7lReBFwdPXwVR7okvu/r+vD6Li0gaIdFcKKGiCKeRb3Pv7V4cVUCkGoispX/
         ciit5J+5NsGx4xIKYpTWf8aPOwQoi3I5Dam0LY8rcugLGJyaDpPbCJCstm/lgIDFiEh3
         0IqZ+NY4ETonvitd5pwW06mcGSmvriLthlGMj+ZyHRfgdOsIMBgP9rO7prCcrT/mfL6s
         iP1svJ1kxDof7nkXWxaht3rtU0OGHu4WeffMWLOAvg+xFIzMeCTfSPuB1Bn6ZyO05utT
         0VKhomY9Cbjcj6nzec5A6qx6ptF4j/9ekfT4tgIzsIdqHLEeypUV4qVcXajfS4sdULMD
         JQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682033072; x=1684625072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpLh1YPaAj9o+5fwNYt3O9O1Ii34BKqLkycFi7e+Xos=;
        b=MzqbfJwi0scsidZh36xRCniXbuf4JD3XVfx/kOawld0uhp1wHKMbqValOcmondLfk/
         0RU8ZAKIOynQSOwBFgMhUcH3ehue8EfyGWMV20eMcaooHDKyRuB1pEqsOOD0YnC8uHrQ
         /OomStbFcvyGYXjZWJaahGSeANoqsd56IKc7wbsT6Hk2zjXrBlv9peE9bvoW4RHNZunp
         pY4tInq7xHrRDnZEyyB9JF3PKggTE8PCTIf2coZuoAjs6zVxfU2QbdED5jB4zfXSF2mw
         02nCeBES3/U58QNtwnmFfy0sADG2sJhN2vuB6u2wt2RIRoB/qB8LUs+po8dMME7O5UxI
         GB7w==
X-Gm-Message-State: AAQBX9de313RbXV2lG9K46Ex9jjoTof1OZvjuxFVlLH5zU9VEKIOVOMW
        TjJFiYL2GomJ/TIQZsqGE+2/7t0Dn7Q=
X-Google-Smtp-Source: AKy350YF1njc1OWl1l9mOgleYY9HuNpEyIYUJhFgLmIcwf04fuPhx3Iz4RL6gTu4Cqt4KW3rb7fEkg==
X-Received: by 2002:ac2:4314:0:b0:4eb:7e:1fa5 with SMTP id l20-20020ac24314000000b004eb007e1fa5mr654815lfh.8.1682033072597;
        Thu, 20 Apr 2023 16:24:32 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm360227lfq.155.2023.04.20.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 16:24:31 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: add pre bpf_prog_test_run_opts() callback for test_loader
Date:   Fri, 21 Apr 2023 02:23:16 +0300
Message-Id: <20230420232317.2181776-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420232317.2181776-1-eddyz87@gmail.com>
References: <20230420232317.2181776-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a test case is annotated with __retval tag the test_loader engine
would use libbpf's bpf_prog_test_run_opts() to do a test run of the
program and compare retvals.

This commit allows to perform arbitrary actions on bpf object right
before test loader invokes bpf_prog_test_run_opts(). This could be
used to setup some state for program execution, e.g. fill some maps.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 8 ++++++++
 tools/testing/selftests/bpf/test_progs.h  | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index e2a1bdc5a570..40c9b7d532c4 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -590,6 +590,14 @@ void run_subtest(struct test_loader *tester,
 		if (restore_capabilities(&caps))
 			goto tobj_cleanup;
 
+		if (tester->pre_execution_cb) {
+			err = tester->pre_execution_cb(tobj);
+			if (err) {
+				PRINT_FAIL("pre_execution_cb failed: %d\n", err);
+				goto tobj_cleanup;
+			}
+		}
+
 		do_prog_test_run(bpf_program__fd(tprog), &retval);
 		if (retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 10ba43250668..0ed3134333d4 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -424,14 +424,23 @@ int get_bpf_max_tramp_links(void);
 
 #define BPF_TESTMOD_TEST_FILE "/sys/kernel/bpf_testmod"
 
+typedef int (*pre_execution_cb)(struct bpf_object *obj);
+
 struct test_loader {
 	char *log_buf;
 	size_t log_buf_sz;
 	size_t next_match_pos;
+	pre_execution_cb pre_execution_cb;
 
 	struct bpf_object *obj;
 };
 
+static inline void test_loader__set_pre_execution_cb(struct test_loader *tester,
+						     pre_execution_cb cb)
+{
+	tester->pre_execution_cb = cb;
+}
+
 typedef const void *(*skel_elf_bytes_fn)(size_t *sz);
 
 extern void test_loader__run_subtests(struct test_loader *tester,
-- 
2.40.0

