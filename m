Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7781E57F729
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 23:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiGXVWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGXVV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 17:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A19DE90
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 14:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C63DB611CF
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 21:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2E6C3411E;
        Sun, 24 Jul 2022 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658697718;
        bh=taQuBYGz0PZZQ9dJYa0GeJkbLiip/7XGeKqHHFf9tBw=;
        h=From:To:Cc:Subject:Date:From;
        b=bnPNIcVwGwYJYOkys1zEemq4fcSriaGaI9Yly65jyqxNAC5r5iAjo1Cr84f1zgB48
         NH6Y67V7+Y2Cu8cAeqFYTFs3a+NTlKSxEdpM4sdIlIpiBWVH4eDH6O07xa/GSEWjbO
         tsTDioyA/7+sd799VtW7zrGEyHSD+SzALOlItcOTYz/OFplNrSd0hqtG4kjMi8uJhh
         oWm7hTuV3iB17uHvFapWY11Dg3bT99VywyoNd0heeibQzQsBfVqUxmkuYCL92q2iG6
         vzXf7hkmcckQ30U7i396BxJVI4wC1RZjTNHt6y7qezQ7ngEp9gvxPx//DeWFHPnejF
         2Y0FFU+f4qjuw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 0/5] bpf: Fixes for CONFIG_X86_KERNEL_IBT 
Date:   Sun, 24 Jul 2022 23:21:41 +0200
Message-Id: <20220724212146.383680-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
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

hi,
Martynas reported bpf_get_func_ip returning +4 address when
CONFIG_X86_KERNEL_IBT option is enabled and I found there are
some failing bpf tests when this option is enabled.

The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
function entry, so the idea is to 'fix' entry ip for kprobe_multi
and trampoline probes, because they are placed on the function
entry.

For kprobes I only fixed the bpf test program to adjust ip based
on CONFIG_X86_KERNEL_IBT option. I'm not sure what the right fix
should be in here, because I think user should be aware where the
kprobe is placed, on the other hand we move the kprobe address if
its placed on top of endbr instruction.

v1 changes:
  - read previous instruction in kprobe_multi link handler
    and adjust entry_ip for CONFIG_X86_KERNEL_IBT option
  - split first patch into 2 separate changes
  - update changelogs

thanks,
jirka


---
Jiri Olsa (5):
      ftrace: Keep the resolved addr in kallsyms_callback
      bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
      bpf: Use given function address for trampoline ip arg
      selftests/bpf: Disable kprobe attach test with offset for CONFIG_X86_KERNEL_IBT
      selftests/bpf: Fix kprobe get_func_ip tests for CONFIG_X86_KERNEL_IBT

 arch/x86/net/bpf_jit_comp.c                               |  9 ++++-----
 kernel/trace/bpf_trace.c                                  |  4 ++++
 kernel/trace/ftrace.c                                     |  3 +--
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 25 ++++++++++++++++++++-----
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      |  7 +++++--
 tools/testing/selftests/bpf/progs/kprobe_multi.c          |  2 +-
 6 files changed, 35 insertions(+), 15 deletions(-)
