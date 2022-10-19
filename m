Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C36048ED
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJSORC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiJSOQs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 10:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03674151B
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 06:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5252F6174E
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0099C433B5;
        Wed, 19 Oct 2022 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187845;
        bh=ogxU8tjugCvxWzR3aDxxMmZu2zuBgAr+MP53Oi6zSko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkFX7lqhhaCEVAkmTQqo2Dags+UoXnX9Hqd5r1N3i3COJvPYsxzE6uZIX+eaZc8/k
         utIVmhqaiLjBQmnWGEIZtwSQ+2WAQTQKyGana2QTwTzJJyt2V/Oiihfek7EI+kBe00
         lBGa4k7uDfTfmsPXBIAeEvQqkZIwrW0/g0rdYRgwKOP4zeutzSSjpEfsyt5zhN73A2
         S0rGvC8xI0MmQK1jfEDBtEjAXKr50EuMQGiuU8OHKDFxSzR5A2AlK5H4N5uN9grA8q
         n/l72poMZ5d5i43qgEeVgSIalXyiW8ik8LqFufOsK2/A6yHCiU0jK1pfp+KoHHsAOG
         F+yPKnuZAmaJA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv2 bpf-next 5/8] selftests/bpf: Add load_kallsyms_refresh function
Date:   Wed, 19 Oct 2022 15:56:18 +0200
Message-Id: <20221019135621.1480923-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019135621.1480923-1-jolsa@kernel.org>
References: <20221019135621.1480923-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding load_kallsyms_refresh function to re-read symbols from
/proc/kallsyms file.

This will be needed to get proper functions addresses from
bpf_testmod.ko module, which is loaded/unloaded several times
during the tests run, so symbols might be already old when
we need to use them.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 20 +++++++++++++-------
 tools/testing/selftests/bpf/trace_helpers.h |  2 ++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 9c4be2cdb21a..09a16a77bae4 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -23,7 +23,7 @@ static int ksym_cmp(const void *p1, const void *p2)
 	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
 }
 
-int load_kallsyms(void)
+int load_kallsyms_refresh(void)
 {
 	FILE *f;
 	char func[256], buf[256];
@@ -31,12 +31,7 @@ int load_kallsyms(void)
 	void *addr;
 	int i = 0;
 
-	/*
-	 * This is called/used from multiplace places,
-	 * load symbols just once.
-	 */
-	if (sym_cnt)
-		return 0;
+	sym_cnt = 0;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -57,6 +52,17 @@ int load_kallsyms(void)
 	return 0;
 }
 
+int load_kallsyms(void)
+{
+	/*
+	 * This is called/used from multiplace places,
+	 * load symbols just once.
+	 */
+	if (sym_cnt)
+		return 0;
+	return load_kallsyms_refresh();
+}
+
 struct ksym *ksym_search(long key)
 {
 	int start = 0, end = sym_cnt;
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 238a9c98cde2..53efde0e2998 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -10,6 +10,8 @@ struct ksym {
 };
 
 int load_kallsyms(void);
+int load_kallsyms_refresh(void);
+
 struct ksym *ksym_search(long key);
 long ksym_get_addr(const char *name);
 
-- 
2.37.3

