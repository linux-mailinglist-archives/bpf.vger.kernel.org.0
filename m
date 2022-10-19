Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5C6048F0
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiJSOR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJSORi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 10:17:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E7C1D8183
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 07:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1A50B81EDB
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2309C433D6;
        Wed, 19 Oct 2022 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187868;
        bh=5ntUDp/6Up6cYJCfHl9XG8Bio8zzPLtnVfgJMeHZuYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hu60o14F0BnQjnEtL+JC6Oln2jOTspsg57AwJ6DjFX6GORfOmVfAHuEt27aKmhEY5
         36ypPqxPrkJPQTr1JEcOMYyztFZqJDULgGGCcLSmS+iEa/hwCqqpx6r3SvV2KagbPy
         GhjYvGb4SyU+7GmNFNhYPm26424ADspa37cv6ufHky290rOXXwzx+/UAYWapLycu5f
         8CZ3igWtl0GMfJvoP4h5aLq4TGyO9ojYp9tGAZ1CCpg9j9Fsca+R0+RR4oIIxA9RzW
         bpWCSCZG0bnPX7MEG7FEtV0I3SJE3CilqPXsUzjShaFByFb0Mi4SjC6uO+tg48tuNg
         8i5PQXAZhw65Q==
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
Subject: [PATCHv2 bpf-next 7/8] selftests/bpf: Add kprobe_multi check to module attach test
Date:   Wed, 19 Oct 2022 15:56:20 +0200
Message-Id: <20221019135621.1480923-8-jolsa@kernel.org>
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

Adding test that makes sure the kernel module won't be removed
if there's kprobe multi link defined on top of it.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/module_attach.c | 7 +++++++
 tools/testing/selftests/bpf/progs/test_module_attach.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 6d0e50dcf47c..7fc01ff490db 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -103,6 +103,13 @@ void test_module_attach(void)
 	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
 	bpf_link__destroy(link);
 
+	link = bpf_program__attach(skel->progs.kprobe_multi);
+	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
+		goto cleanup;
+
+	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
+	bpf_link__destroy(link);
+
 cleanup:
 	test_module_attach__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index 08628afedb77..8a1b50f3a002 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -110,4 +110,10 @@ int BPF_PROG(handle_fmod_ret,
 	return 0; /* don't override the exit code */
 }
 
+SEC("kprobe.multi/bpf_testmod_test_read")
+int BPF_PROG(kprobe_multi)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.37.3

