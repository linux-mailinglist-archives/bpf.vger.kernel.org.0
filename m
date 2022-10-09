Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9630E5F8F52
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 00:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJIWAr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJIWAp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 18:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690DB2197
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 15:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01CEE60C91
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 22:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1798AC433D6;
        Sun,  9 Oct 2022 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665352842;
        bh=4lqlGazeCHvq5QRQPW0yfpxkcQnkFM+t7T/7LmA61v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CI6DuAYCkn8VvBhKAhH/741Y6U+yo+AeCRfEdksG5ySj0JPMH2jlDmJfcJrcBIE5l
         8UqVDZgQ4V7IfmI9GritRL1uO7Om1gIAK/Zu0fDsPjEx2W0pCygUEZNBr1f+SvBDZU
         iCPBvFEcRTnnvfocmedxUh3gwj26eh3lPTn5LRFp3VUsAsg2G+eAffWiXLZTvxEJ6m
         jUPU+Iiye9QElWZ/a+YodW3ksc5eXXQaECRnFVdqNXlkqzXAj8L+AIWtzaWVZwrDuQ
         j2gVDhJgNjMHQ/j9jsyBJ8SNyZ6yHmfNCMa/EfME3Ofyy5g1+5q+PcdrR9H/owRngu
         yElSlDjNVMFZQ==
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
Subject: [PATCH bpf-next 6/8] selftests/bpf: Add bpf_testmod_fentry_* functions
Date:   Sun,  9 Oct 2022 23:59:24 +0200
Message-Id: <20221009215926.970164-7-jolsa@kernel.org>
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

Adding 3 bpf_testmod_fentry_* functions to have a way to test
kprobe multi link on kernel module. They follow bpf_fentry_test*
functions prototypes/code.

Adding equivalent functions to all bpf_fentry_test* does not
seems necessary at the moment, could be added later.

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

