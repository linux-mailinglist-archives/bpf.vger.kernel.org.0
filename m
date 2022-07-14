Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028865746A5
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiGNIX1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 04:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiGNIX0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 04:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BA73AE41
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 01:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC8061D9F
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 08:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47ACC34114;
        Thu, 14 Jul 2022 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657787003;
        bh=BQO5Jrxh7cFFNKSWmzfQ2yt5J3UsKdxaTFqtKa1ll7s=;
        h=From:To:Cc:Subject:Date:From;
        b=U4LFvsC76+K1s3VO35c9b2mizBLeKc8c0dwr3QUub8y+Xy30tH5tGLnv/+lDHBagf
         M987BCfs7u/HwM/RyHFUgMsrcATZXZ2Go9tcQBBRFSXkIOZblZpfpu6XaJclLtynP/
         1RUw7uBySHnRjxi9XIsKV3MvkTgQXy6cP7TmIUdh4mT9nMWiKyuVH0tuffkoWNg6pd
         DhX+pNTQnvmyNnE0Ksjf8DaLEl1RNub+2+P7CuqzMcETxJ/Al1eBvjAeDzxDDKYGg3
         l7xRwilCMpcYUDJlbGh0ffqtWZWYd4UDt6lau+z4F76otVWrtbVKppQB7O9LwKxLwk
         thIOkxvhJnQjw==
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
Subject: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to bpf_dispatcher_xdp_func
Date:   Thu, 14 Jul 2022 10:23:16 +0200
Message-Id: <20220714082316.479181-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei reported crash by running test_progs -j on system
with 32 cpus.

It turned out the kprobe_multi bench test that attaches all
ftrace-able functions will race with bpf_dispatcher_update,
that calls bpf_arch_text_poke on bpf_dispatcher_xdp_func,
which is ftrace-able function.

Ftrace is not aware of this update so this will cause
ftrace_bug with:

  WARNING: CPU: 6 PID: 1985 at
  arch/x86/kernel/ftrace.c:94 ftrace_verify_code+0x27/0x50
  ...
  ftrace_replace_code+0xa3/0x170
  ftrace_modify_all_code+0xbd/0x150
  ftrace_startup_enable+0x3f/0x50
  ftrace_startup+0x98/0xf0
  register_ftrace_function+0x20/0x60
  register_fprobe_ips+0xbb/0xd0
  bpf_kprobe_multi_link_attach+0x179/0x430
  __sys_bpf+0x18a1/0x2440
  ...
  ------------[ ftrace bug ]------------
  ftrace failed to modify
  [<ffffffff818d9380>] bpf_dispatcher_xdp_func+0x0/0x10
   actual:   ffffffe9:7b:ffffff9c:77:1e
  Setting ftrace call site to call ftrace function

It looks like we need some way to way to hide some functions
from ftrace, but meanwhile we workaround this by skipping
bpf_dispatcher_xdp_func from kprobe_multi bench test.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 5b93d5d0bd93..8c442051f312 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -364,6 +364,8 @@ static int get_syms(char ***symsp, size_t *cntp)
 			continue;
 		if (!strncmp(name, "rcu_", 4))
 			continue;
+		if (!strncmp(name, "bpf_dispatcher_xdp_func", 23))
+			continue;
 		if (!strncmp(name, "__ftrace_invalid_address__",
 			     sizeof("__ftrace_invalid_address__") - 1))
 			continue;
-- 
2.35.3

