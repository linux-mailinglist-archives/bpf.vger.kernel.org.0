Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8A5F23C7
	for <lists+bpf@lfdr.de>; Sun,  2 Oct 2022 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJBPLv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJBPLu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 11:11:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA21032BBA
        for <bpf@vger.kernel.org>; Sun,  2 Oct 2022 08:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59ADDB80D6E
        for <bpf@vger.kernel.org>; Sun,  2 Oct 2022 15:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EFAC433C1;
        Sun,  2 Oct 2022 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664723507;
        bh=UMqNLg1jdswiK+pzi/U8XNoS/r2JS1jiEwQHoX92TeY=;
        h=From:To:Cc:Subject:Date:From;
        b=gKX/saU/JySz2SzVqsW7v3Zh5xC9Jpd3gt66orFVlP+jko1JbAcD7xSST/+ZBVBKH
         DkPfOXG1mDm+6+6+631LEaETnUmL7EzOxufmRc9eyODsD5up6Fwo+aoE4nRZN90ZzJ
         iX6My+jGMAoKxHjn3uF6EgDpw4G6MfS9f5KJPVSbSqUn4MFg5mvczNlIyDKpdG7OG/
         Z1FRhgTdhaVx8vtkVZ074S0c5ttDBp8cW2nB2SRgh2mmN8jkSzU69ywohuwtE/jcWg
         5sF/Y7yNTezKLp4u8TF05EnVPNrfcv1ayflVtmwzBYPvFP8j6QIlsdaxnskg6OMHGq
         Zbhz9B4eW9tIQ==
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
Subject: [PATCH bpf-next] selftests/bpf: Add missing bpf_iter_vma_offset__destroy call
Date:   Sun,  2 Oct 2022 17:11:41 +0200
Message-Id: <20221002151141.1074196-1-jolsa@kernel.org>
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

Adding missing bpf_iter_vma_offset__destroy call to
test_task_vma_offset_common function and related goto jumps.

Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
Cc: Kui-Feng Lee <kuifeng@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 3369c5ec3a17..462fe92e0736 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1515,11 +1515,11 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
 
 	link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
-		return;
+		goto exit_skel;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
 	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
-		goto exit;
+		goto exit_link;
 
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
@@ -1534,8 +1534,10 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
 
 	close(iter_fd);
 
-exit:
+exit_link:
 	bpf_link__destroy(link);
+exit_skel:
+	bpf_iter_vma_offset__destroy(skel);
 }
 
 static void test_task_vma_offset(void)
-- 
2.37.3

