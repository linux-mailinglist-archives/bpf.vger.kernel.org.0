Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD75F8F1D
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJIWAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJIWAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 18:00:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94882197
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 15:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 848A6B80D9A
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 22:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C6C433D6;
        Sun,  9 Oct 2022 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665352831;
        bh=Ugb1S+SKiQxCjjiNH3QlRHqRkeO+B4L+2Hymxu+xXwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcPDd1xS/i8CbSMQKB3xgAwbPR18dSfZqy4ANSFuRvWMV6T5e/a8dbzHySq8U10m3
         7jUDI7+M6VuiXgY5n+GSRgCoEwJg/EzqWuHnQ9qNUzm/llwvIQfxs/EADlGzuGwh8y
         Cancns59gqFm610XKYvii+Kgd7G49QSa4HPEvsi8yvGUuZlSyUovVNPDu9/hI+p615
         tQftePqMhurwhyr/QQhvR8xmHPfVfnbh7skGWTxZaDdYZ3Vhe71u72XlFsQdeI1Wf6
         1BQEPFft8Tj3urbwo2BKCjqt5CCdWZRpXE2RENHAFp3ugaRXaWnsf0WGxuwu+MlsSC
         PfS0XJQjQJ6mQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf-next 5/8] selftests/bpf: Add load_kallsyms_refresh function
Date:   Sun,  9 Oct 2022 23:59:23 +0200
Message-Id: <20221009215926.970164-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009215926.970164-1-jolsa@kernel.org>
References: <20221009215926.970164-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

