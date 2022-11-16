Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD2C62B71D
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 11:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKPKCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 05:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiKPKCr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 05:02:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DEDC25
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 02:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0BE8B81CC7
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 10:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBE9C433C1;
        Wed, 16 Nov 2022 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668592963;
        bh=OpbNoL8Syvun6ALgjpYWP+8IBRgmTvq2iOpXuALe5os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOMSlb4adawCR1Gffl+qM5SPmRxWheccCbjgqat+rYg6WoWOPMuyxq+I97wr9VeBv
         F5ZFF3vXkXrwbgs8XrBgvQhmUH/XpCEOvO6h1XufU0TQSLmiBobWf4ak0rs92R6+ta
         MpZay+r69XVsY1kRcfPTcOnQwnKjaLfW4V2DqzoJO9OeB3qmlIh5rQdkI8gPv96o29
         yIV11cCSeODN/fpmOArY00hNIWSMzklPRnBmY4Dn7+JRWy6TeEH9dTuU5GNoa+o+hO
         Q5MzYm55SXoEBETDF+F9KxS/hcVKihyMNOVOCG5PkGOlxZYIBePfQFH4ZRNFXHPxfM
         BtXw1au9WbaRA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Make test_bench_attach serial
Date:   Wed, 16 Nov 2022 11:02:28 +0100
Message-Id: <20221116100228.2064612-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116100228.2064612-1-jolsa@kernel.org>
References: <20221116100228.2064612-1-jolsa@kernel.org>
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

Alexei hit another rcu warnings because of this test.

Making test_bench_attach serial so it does not disrupts
other tests during parallel tests run.

While this change is not the fix, it should be less likely
to hit it with this test being executed serially.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index b43928967515..a4b4133d39e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -402,7 +402,7 @@ static int get_syms(char ***symsp, size_t *cntp)
 	return err;
 }
 
-static void test_bench_attach(void)
+void serial_test_kprobe_multi_bench_attach(void)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
 	struct kprobe_multi_empty *skel = NULL;
@@ -470,6 +470,4 @@ void test_kprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
-	if (test__start_subtest("bench_attach"))
-		test_bench_attach();
 }
-- 
2.38.1

