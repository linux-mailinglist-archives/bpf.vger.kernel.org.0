Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105B689F1F
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjBCQZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjBCQZE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:25:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9EA6C3C
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:24:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69840B82AF4
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1222C433D2;
        Fri,  3 Feb 2023 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441487;
        bh=qda/XOodt+Yq6V97egViYuwtQkQSaqbxp+LMHRX4dAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7Ck7S4tJ4RA74BaofP3Jkh6Y33hxq25Rm/xVP81jR+3XMAMvHBVh/fSP88LQlSoN
         nIFOVYM30vSsayZLeq2wacb4K1AgScHiKeg8sYTO+WqukKX7ntVZ1sEwJ52uSb0pg1
         /a4R+iK6i/Xx/9S5A5qsDd92NDwhmiuxtp8fYmkfJROLoJIB1aaIYHz1mMXh9yJVPd
         Uoo4vI3qTODpQW5WxoBISPZXU99HDH7xCgCbZWH9Qreo85KorzUfbgfi7Rj6HoMBUv
         m3UWKT87MqTR4QMdktlkWVQtnOTIZlkCV3DSpiOGf28hTyrTA6INZov22tkt6W8mn4
         oeYYDWz0i9oWQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv3 bpf-next 6/9] selftests/bpf: Load bpf_testmod for verifier test
Date:   Fri,  3 Feb 2023 17:23:33 +0100
Message-Id: <20230203162336.608323-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203162336.608323-1-jolsa@kernel.org>
References: <20230203162336.608323-1-jolsa@kernel.org>
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

Loading bpf_testmod kernel module for verifier test. We will
move all the tests kfuncs into bpf_testmod in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 887c49dc5abd..14f11f2dfbce 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -45,6 +45,7 @@
 #include "bpf_util.h"
 #include "test_btf.h"
 #include "../../../include/linux/filter.h"
+#include "testing_helpers.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -1705,6 +1706,12 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 {
 	int i, passes = 0, errors = 0;
 
+	/* ensure previous instance of the module is unloaded */
+	unload_bpf_testmod(verbose);
+
+	if (load_bpf_testmod(verbose))
+		return EXIT_FAILURE;
+
 	for (i = from; i < to; i++) {
 		struct bpf_test *test = &tests[i];
 
@@ -1732,6 +1739,8 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 		}
 	}
 
+	unload_bpf_testmod(verbose);
+
 	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
 	       skips, errors);
 	return errors ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.39.1

