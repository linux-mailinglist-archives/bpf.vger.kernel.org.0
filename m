Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24358F9D3
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 11:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiHKJPp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiHKJPg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 05:15:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127F12613
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 02:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F60FB81F99
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 09:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF5CC433C1;
        Thu, 11 Aug 2022 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660209333;
        bh=PG8D+86ya+A02xuGcQ2gR18cMTOZfRb0+fGYe6uGB4o=;
        h=From:To:Cc:Subject:Date:From;
        b=CJ7bpOs/Zx8VLOcjGDQzZatP8qFIBLhZ2Ym6AGjARFcatCDXmlY+Ybuk+jMl1+a0/
         nL4hzA+v3JDW9NMMKxpfrYaZfKea4VyxQgPPtL03rMBbFHYUt06T0bpQsiaCzvvzKe
         /X/qS6RZRPixaGzCtD84nYSfiXLcsjppP6OgQHxupVmcDIJQQkyuW7e4J55Vaz1+lG
         2f0AMsbPsGsIJId2T4k9Ff9YRXcDK5Zig0nc00TOe8Q2jg2zBCO8hYYfjvvHIzUt5f
         7lrHcwwRnzRgIGwt3iF0bcqMuBVkI8252ZT+POkJSuXUafVKS8qqW9pp2JViV8J0Po
         D80dp6calnB7A==
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
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 0/6] bpf: Fixes for CONFIG_X86_KERNEL_IBT 
Date:   Thu, 11 Aug 2022 11:15:20 +0200
Message-Id: <20220811091526.172610-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
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

hi,
Martynas reported bpf_get_func_ip returning +4 address when
CONFIG_X86_KERNEL_IBT option is enabled and I found there are
some failing bpf tests when this option is enabled.

The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
function entry, so the idea is to 'fix' entry ip for kprobe_multi
and trampoline probes, because they are placed on the function
entry.

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

 arch/x86/net/bpf_jit_comp.c                               |  9 ++++-----
 include/linux/kprobes.h                                   |  1 +
 kernel/kprobes.c                                          |  6 +++++-
 kernel/trace/bpf_trace.c                                  | 15 ++++++++++++++-
 kernel/trace/ftrace.c                                     |  3 +--
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 22 ++++++++++------------
 tools/testing/selftests/bpf/progs/kprobe_multi.c          |  4 +---
 8 files changed, 87 insertions(+), 35 deletions(-)
