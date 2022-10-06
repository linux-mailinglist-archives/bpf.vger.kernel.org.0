Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA285F62B5
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJFIbW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 04:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJFIbR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 04:31:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F59259E
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 01:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C561B8203F
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 08:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64AFC433D6;
        Thu,  6 Oct 2022 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665045072;
        bh=iZlXlpq78HDhTHj8R1rlpejb4Yq8QkEpMX1CknHfXNE=;
        h=From:To:Cc:Subject:Date:From;
        b=fhJD6hSWqYGrgRcIle6bQm05htwOs6IRNfx20z0skh4dOSzF3jUP11ejvL7fl0UKT
         cWN2GIFPIBeAUMv1+9e8Q1pmXv1R37m4eG1HPNptGGXmy8ydba/b7Uyg7V0LGsDF1S
         OWdvTkTC8hMFplqPG6dPOTiOT/AQmuIOhw/sycnXAue5R0k9TtcoLfsILPzcpFkJnl
         yoOu8HpSSJB1orW5BfYSEqIn8Xb+KQD8NHTAUBqUwq/meKYUSqMcgLuQymxK7Tzb02
         YY1B8+02ecXQlK7Be353j2bHWjLTQlijiz/rOKQF6NdJmyjr+RPpwxEEgpRgiMSrXF
         9Uj+vlnia6reA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next] selftests/bpf: Add missing bpf_iter_vma_offset__destroy call
Date:   Thu,  6 Oct 2022 10:31:06 +0200
Message-Id: <20221006083106.117987-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
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

Adding missing bpf_iter_vma_offset__destroy call and using in-skeletin
link pointer so we don't need extra bpf_link__destroy call.

Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
Cc: Kui-Feng Lee <kuifeng@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 v2 changes:
 - use in-skeletin link pointer and destroy call [Martin]

 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 3369c5ec3a17..d4437a2bba28 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1498,7 +1498,6 @@ static noinline int trigger_func(int arg)
 static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool one_proc)
 {
 	struct bpf_iter_vma_offset *skel;
-	struct bpf_link *link;
 	char buf[16] = {};
 	int iter_fd, len;
 	int pgsz, shift;
@@ -1513,11 +1512,13 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
 		;
 	skel->bss->page_shift = shift;
 
-	link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
-	if (!ASSERT_OK_PTR(link, "attach_iter"))
-		return;
+	skel->links.get_vma_offset = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
+	if (!ASSERT_OK_PTR(skel->links.get_vma_offset, "attach_iter")) {
+		skel->links.get_vma_offset = NULL;
+		goto exit;
+	}
 
-	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.get_vma_offset));
 	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
 		goto exit;
 
@@ -1535,7 +1536,7 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
 	close(iter_fd);
 
 exit:
-	bpf_link__destroy(link);
+	bpf_iter_vma_offset__destroy(skel);
 }
 
 static void test_task_vma_offset(void)
-- 
2.37.3

