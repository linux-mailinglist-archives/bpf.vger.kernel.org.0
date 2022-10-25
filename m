Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3960CDC4
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJYNnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiJYNnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 09:43:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F618B48A
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 06:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61807B81D17
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 13:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC48C433D6;
        Tue, 25 Oct 2022 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666705379;
        bh=GoIjry0gYEBPgzI3NVNn8Mg+UflQtww2M7o6YxuXRvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDDKacB9qaxZ+Ml944Q8mVKSIheNh7NX4Bo3aIEFl9EIii6t3Nk9SUmkcRuERok6i
         W1d46s2HKpS0st/32jbdjpdTxqQ97HhZtyXwyIQ0RzAYzQwET/3s02muZY5gu4OlTh
         QmHwOiQlrwkEsmBjSyleyq/eq38X5gOUmpDBCQEsB2jEX7ZqYCDUtLWlLu1xumDPHE
         eG9rUbH6sTryjMbr/dpfxLADrHKHVjaZbAvMcQyUgpSSSOrbvoW34SCyhRNpdUJ94q
         +IVzIbREi8rMVYBxnUwt0xu0d3wejGlvs/N3prkfspKyewG516EdSu1h+uRFzbRzRT
         bwQUSA1hXJ/kg==
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
Subject: [PATCHv3 bpf-next 6/8] selftests/bpf: Add bpf_testmod_fentry_* functions
Date:   Tue, 25 Oct 2022 15:41:46 +0200
Message-Id: <20221025134148.3300700-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025134148.3300700-1-jolsa@kernel.org>
References: <20221025134148.3300700-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding 3 bpf_testmod_fentry_* functions to have a way to test
kprobe multi link on kernel module. They follow bpf_fentry_test*
functions prototypes/code.

Adding equivalent functions to all bpf_fentry_test* does not
seems necessary at the moment, could be added later.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a6021d6117b5..5085fea3cac5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -128,6 +128,23 @@ __weak noinline struct file *bpf_testmod_return_ptr(int arg)
 	}
 }
 
+noinline int bpf_testmod_fentry_test1(int a)
+{
+	return a + 1;
+}
+
+noinline int bpf_testmod_fentry_test2(int a, u64 b)
+{
+	return a + b;
+}
+
+noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
+{
+	return a + b + c;
+}
+
+int bpf_testmod_fentry_ok;
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      struct bin_attribute *bin_attr,
@@ -167,6 +184,13 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 			return snprintf(buf, len, "%d\n", writable.val);
 	}
 
+	if (bpf_testmod_fentry_test1(1) != 2 ||
+	    bpf_testmod_fentry_test2(2, 3) != 5 ||
+	    bpf_testmod_fentry_test3(4, 5, 6) != 15)
+		goto out;
+
+	bpf_testmod_fentry_ok = 1;
+out:
 	return -EIO; /* always fail */
 }
 EXPORT_SYMBOL(bpf_testmod_test_read);
-- 
2.37.3

