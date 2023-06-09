Return-Path: <bpf+bounces-2274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782572A634
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07531C209E3
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53524E90;
	Fri,  9 Jun 2023 22:17:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8823403
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 22:17:07 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA01730
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 15:17:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1fe3a1a73so25027901fa.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686349023; x=1688941023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/d1aDHPMmBe2fMkVNlNOdJtsBgC5q+CAc13r31wb9o4=;
        b=axMV4+NhqRCGaeWNZWT0spOgDdvkkWuCM7p3A9mAdlTFmSUpd7gkpsmJ9IrGSCwKTV
         0PHojH4w1p2m/3KBpa+5jM0IQji7v3iSobFxPmA3wPuNsz0IThzkXqbW5nHyXXfvGIxd
         +Vg1gnRMvXBHPuQu+K91ur+v4ZXNgq+OnpoWPEpAonQcNXm+r5YVTXyPBiYJiSY7ocMp
         dfG2yzutBFsh2RHqjzUDzh/7jaLxsGkRN5ZxVcRFT/9gyiOlOIWbFIL8qJFUIatJEtI2
         P+WEpa/aTNSU/YGqm2wnOSLLtaL/ZHNA58n+OfYrYcKps6X4AjgYoV0bQqB1V/W8Napo
         BuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686349023; x=1688941023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d1aDHPMmBe2fMkVNlNOdJtsBgC5q+CAc13r31wb9o4=;
        b=TjJhdFIvBRNUzENLynZDLMLAHb/buXAcf1BxXgHT5PrNxpzZRySrdAkPCWxvOlB5ic
         /scY8Lqyv93bL7qh3bJqwUrM8yqPCGLcQhbXK1gGmQyRAa6E/a7KU8QluXZOTGxYZndp
         oOVEs3cn2xQd+HPQOVuvCh7dCX5qFQvH/diOHBGka+DlST+t8iuBbzb9VftITVYMLH4R
         oCavRtA3X58cqSA9T9jgaRU/uIlGDkxhkwxwTsmQaACdZtCNabl/aq9pZofikFfUttRA
         jtmS/qRGtKL5eSCipovHvnoKlZ8fepyPVwDHzVFP+p5sd6j8F9euEu2J/6yG32Obr3Xq
         KULQ==
X-Gm-Message-State: AC+VfDxxFt5tQcHL4QOe03ck9XbJAry7oH+Kteqv/MAClbo8pgP/sIue
	MvFmClkClv0D909ZJP+3JqWYFKdusrQ=
X-Google-Smtp-Source: ACHHUZ6OwGwnYUphGjMp3aOIboMpVKlikBxuwSh0fXh4vY2m01Djl5Xq79dWD40Sv0v3T0qQbflGjg==
X-Received: by 2002:a2e:9cd2:0:b0:2b2:1f2f:705f with SMTP id g18-20020a2e9cd2000000b002b21f2f705fmr47013ljj.4.1686349023229;
        Fri, 09 Jun 2023 15:17:03 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s16-20020a2e81d0000000b002adf8d948dasm551165ljg.35.2023.06.09.15.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:17:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	dan.carpenter@linaro.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1] selftests/bpf: fix invalid pointer check in get_xlated_program()
Date: Sat, 10 Jun 2023 01:16:37 +0300
Message-Id: <20230609221637.2631800-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Carpenter reported invalid check for calloc() result in
test_verifier.c:get_xlated_program():

  ./tools/testing/selftests/bpf/test_verifier.c:1365 get_xlated_program()
  warn: variable dereferenced before check 'buf' (see line 1364)

  ./tools/testing/selftests/bpf/test_verifier.c
    1363		*cnt = xlated_prog_len / buf_element_size;
    1364		*buf = calloc(*cnt, buf_element_size);
    1365		if (!buf) {

  This should be if (!*buf) {

    1366			perror("can't allocate xlated program buffer");
    1367			return -ENOMEM;

This commit refactors the get_xlated_program() to avoid using double
pointer type.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/ZH7u0hEGVB4MjGZq@moroto/
Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in test_verifier tests")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 71704a38cac3..c6bc9e26d333 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1341,45 +1341,48 @@ static bool cmp_str_seq(const char *log, const char *exp)
 	return true;
 }
 
-static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
+static struct bpf_insn *get_xlated_program(int fd_prog, int *cnt)
 {
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
+	__u32 buf_element_size;
 	__u32 xlated_prog_len;
-	__u32 buf_element_size = sizeof(struct bpf_insn);
+	struct bpf_insn *buf;
+
+	buf_element_size = sizeof(struct bpf_insn);
 
 	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
 		perror("bpf_prog_get_info_by_fd failed");
-		return -1;
+		return NULL;
 	}
 
 	xlated_prog_len = info.xlated_prog_len;
 	if (xlated_prog_len % buf_element_size) {
 		printf("Program length %d is not multiple of %d\n",
 		       xlated_prog_len, buf_element_size);
-		return -1;
+		return NULL;
 	}
 
 	*cnt = xlated_prog_len / buf_element_size;
-	*buf = calloc(*cnt, buf_element_size);
+	buf = calloc(*cnt, buf_element_size);
 	if (!buf) {
 		perror("can't allocate xlated program buffer");
-		return -ENOMEM;
+		return NULL;
 	}
 
 	bzero(&info, sizeof(info));
 	info.xlated_prog_len = xlated_prog_len;
-	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
+	info.xlated_prog_insns = (__u64)(unsigned long)buf;
 	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
 		perror("second bpf_prog_get_info_by_fd failed");
 		goto out_free_buf;
 	}
 
-	return 0;
+	return buf;
 
 out_free_buf:
-	free(*buf);
-	return -1;
+	free(buf);
+	return NULL;
 }
 
 static bool is_null_insn(struct bpf_insn *insn)
@@ -1512,7 +1515,8 @@ static bool check_xlated_program(struct bpf_test *test, int fd_prog)
 	if (!check_expected && !check_unexpected)
 		goto out;
 
-	if (get_xlated_program(fd_prog, &buf, &cnt)) {
+	buf = get_xlated_program(fd_prog, &cnt);
+	if (!buf) {
 		printf("FAIL: can't get xlated program\n");
 		result = false;
 		goto out;
-- 
2.40.1


