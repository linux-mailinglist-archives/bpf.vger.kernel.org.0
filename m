Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA86E4D95
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjDQPsY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjDQPsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:48:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8426BAD03;
        Mon, 17 Apr 2023 08:48:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q2so31014544pll.7;
        Mon, 17 Apr 2023 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746490; x=1684338490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYG1b357oMKLvJvHyt8MmZQVmZpqrurlWW2QFSsi01Y=;
        b=aXJTmhfln+ApLe5Z5D5qMz9viP1nylI6xGYmzkwjLUNPlqIXXUdw04ZeNKdRdE2mO+
         PPg1qxngkETSBNc5iJXxeQ5xMFhyUsXL2ut2BnsTe4cK2WYOjYezUMmxwLHeFb1AuxFE
         cHSJb3lGk01ziMkBmfQABhPY7kBPLinrDTrjtgT51ibo8mX9CttpZRoQrspYpTT2sRm2
         ZC2vixgtOF5GE1HvM3nKGmCLAR/yCO58KHw4vc7XOgpJ4Af4CDhvJNuiLi1mHbC4VU0m
         nS1KaX1LUhnrCmklhlt4fkIG0Tmdfu1fkT+Nbh2FsvuNIJbKApy8oel65Xv0Yh4AUvuM
         vXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746490; x=1684338490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYG1b357oMKLvJvHyt8MmZQVmZpqrurlWW2QFSsi01Y=;
        b=j5hWUCKLsqDvhntOiea5ab1KGAVEL4Z+VPwMqLU+Kzy0H/CtLVtLUE86hDwfh1XIS9
         VLEANi7EIm98MBPaxq9RFUJetOFLpUK31SZWXwGSQ1/aycwh1l0arS+CUvdV81EE2LWQ
         B1Y22yzzxLGcd5LGuDtW8i5naP9v+qa7qkxqdR9sW8sDtsmpWZsJ8q6uBVhmWJ9VHSy+
         0k3ZBsmyBd9XOBw5ZrB1wLEncwByMaTjILQwvJ1Xim0YXNx9A8XlGZ/TaO2uXGIgxlPH
         G4spIcYgpqbpWaGZkLyIO6jM6rqvAWVn3X1UsKYnDkdYwenVVkyyD4pDx5wHR+McR6Ja
         YJNg==
X-Gm-Message-State: AAQBX9e9d0yFi2hQlxdnaWsQ59omr/sNxcxWFYPjitP2kM0wYPoyyfH+
        IbnA/mezmLTG6BymeAnqJt4=
X-Google-Smtp-Source: AKy350aGHNWC1i6+7g7/8F3wKaZQKN+hE8U1ntgTH/I5O43I5uTSY+qgOFPV1ogAWkYO2XsxLM6cHg==
X-Received: by 2002:a17:902:f14a:b0:1a1:f5dd:2dd5 with SMTP id d10-20020a170902f14a00b001a1f5dd2dd5mr10560624plb.13.1681746490024;
        Mon, 17 Apr 2023 08:48:10 -0700 (PDT)
Received: from vultr.guest ([2401:c080:3800:263c:5400:4ff:fe66:d27f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a6b308fcaesm4437513plb.153.2023.04.17.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:09 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 4/6] selftests/bpf: Allow one single recursion in fentry recursion test
Date:   Mon, 17 Apr 2023 15:47:35 +0000
Message-Id: <20230417154737.12740-5-laoar.shao@gmail.com>
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

This is a prepation for replacing prog->active with
test_recursion_{acquire,release}, in which one single recursion in the
process context is allowed. The behavior will be as follows,

SEC("fentry/htab_map_delete_elem")
    pass2++;   <<<< Turn out to be 1 after this operation.
    bpf_map_delete_elem(&hash2, &key);
         SEC("fentry/htab_map_delete_elem")    <<<< not recursion
            pass2++; <<<< Turn out to be 2 after this operation.
            bpf_map_delete_elem(&hash2, &key);
                SEC("fentry/htab_map_delete_elem") <<<< RECURSION

Hence we need to change the selftest to allow it. To be
backward-compatibility, we allow both the old value and the new value
to be expected, so a new helper ASSERT_IN_ARRAY() is introduced.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/recursion.c |  7 +++++--
 tools/testing/selftests/bpf/test_progs.h           | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursion.c b/tools/testing/selftests/bpf/prog_tests/recursion.c
index 23552d3..dfbed2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursion.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursion.c
@@ -8,6 +8,7 @@ void test_recursion(void)
 	struct bpf_prog_info prog_info = {};
 	__u32 prog_info_len = sizeof(prog_info);
 	struct recursion *skel;
+	int expected[2];
 	int key = 0;
 	int err;
 
@@ -27,9 +28,11 @@ void test_recursion(void)
 
 	ASSERT_EQ(skel->bss->pass2, 0, "pass2 == 0");
 	bpf_map_delete_elem(bpf_map__fd(skel->maps.hash2), &key);
-	ASSERT_EQ(skel->bss->pass2, 1, "pass2 == 1");
+	expected[1] = 2;
+	ASSERT_IN_ARRAY(skel->bss->pass2, expected, "pass2 in [0 2]");
 	bpf_map_delete_elem(bpf_map__fd(skel->maps.hash2), &key);
-	ASSERT_EQ(skel->bss->pass2, 2, "pass2 == 2");
+	expected[1] = 4;
+	ASSERT_IN_ARRAY(skel->bss->pass2, expected, "pass2 in [0 4]");
 
 	err = bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.on_delete),
 				      &prog_info, &prog_info_len);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 10ba432..79e96cc 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -245,6 +245,25 @@ struct msg {
 	___ok;								\
 })
 
+#define ASSERT_IN_ARRAY(actual, expected, name) ({			\
+	static int duration;						\
+	typeof(actual) ___act = (actual);				\
+	typeof((expected)[0]) * ___exp = (expected);			\
+	bool ___ok = false;						\
+	int i;								\
+									\
+	for (i = 0; i < ARRAY_SIZE(expected); i++) {			\
+		if (___act == ___exp[i]) {				\
+			___ok = true;					\
+			break;						\
+		}							\
+	}								\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld not in array\n",		\
+	      (name), (long long)(___act));				\
+	___ok;								\
+})
+
 #define ASSERT_NEQ(actual, expected, name) ({				\
 	static int duration = 0;					\
 	typeof(actual) ___act = (actual);				\
-- 
1.8.3.1

