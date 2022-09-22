Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F85E6D89
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiIVVDf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 17:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIVVDe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 17:03:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945CE11A9
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 14:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DED37B837D2
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 21:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B74C433C1;
        Thu, 22 Sep 2022 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663880610;
        bh=42tuFMby8iYpfSIfy0IasJ6m25f6BJFJVXwra1G2VCs=;
        h=From:To:Cc:Subject:Date:From;
        b=OW37Q2YG6FYSByUtyrYkyJSGwGU3lxBcd6gvchd7RwU8PLylyj1E9iBwFHndQmK4p
         qFM/7xDH3OGj1nVyHSJooSBVHthbr+XWhq4qr2IwsEd0U4GJq9B/tPIGQBN7GHCgUY
         gKSmw85Ls3LtEPC9KLbjSWcF/mI4oQlIZpIDKwkxaBu2VCVgbjdzMJKbOW7fgelR9g
         MFnjrIfnfS+VrGi6jg7m9J4vohAunJJkrNR7BKdEBQZHAEbB26C7ZLH6QePz1ZzYAP
         1BkrHmxq6mFqiW2FDBysP6k7hKCdOY+CeSMJ2TNp++OusNRMS44RO/chYxqhdN+hUA
         oy43K+xiE4PgQ==
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv4 bpf-next 0/6] bpf: Fixes for CONFIG_X86_KERNEL_IBT 
Date:   Thu, 22 Sep 2022 23:03:14 +0200
Message-Id: <20220922210320.1076658-1-jolsa@kernel.org>
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

hi,
Martynas reported bpf_get_func_ip returning +4 address when
CONFIG_X86_KERNEL_IBT option is enabled and I found there are
some failing bpf tests when this option is enabled.

The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
function entry, so the idea is to 'fix' entry ip for kprobe_multi
and trampoline probes, because they are placed on the function
entry.

v4 changes:
  - used get_kernel_nofault to read previous instruction [Peter]
  - used movabs instruction in trampoline comment [Peter]
  - renamed fentry_ip argument in kprobe_multi_link_handler [Peter]

v3 changes:
  - using 'unused' bpf function to get IBT config option
    into selftest skeleton
  - rebased to current bpf-next/master
  - added ack/review from Masami

v2 changes:
  - change kprobes get_func_ip to return zero for kprobes
    attached within the function body [Andrii]
  - detect IBT config and properly test kprobe with offset 
    [Andrii]

v1 changes:
  - read previous instruction in kprobe_multi link handler
    and adjust entry_ip for CONFIG_X86_KERNEL_IBT option
  - split first patch into 2 separate changes
  - update changelogs

thanks,
jirka


---
Jiri Olsa (6):
      kprobes: Add new KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
      ftrace: Keep the resolved addr in kallsyms_callback
      bpf: Use given function address for trampoline ip arg
      bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
      bpf: Return value in kprobe get_func_ip only for entry address
      selftests/bpf: Fix get_func_ip offset test for CONFIG_X86_KERNEL_IBT

 arch/x86/net/bpf_jit_comp.c                               | 11 +++++------
 include/linux/kprobes.h                                   |  1 +
 kernel/kprobes.c                                          |  6 +++++-
 kernel/trace/bpf_trace.c                                  | 25 ++++++++++++++++++++++---
 kernel/trace/ftrace.c                                     |  3 +--
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 25 +++++++++++++------------
 tools/testing/selftests/bpf/progs/kprobe_multi.c          |  4 +---
 8 files changed, 96 insertions(+), 38 deletions(-)
