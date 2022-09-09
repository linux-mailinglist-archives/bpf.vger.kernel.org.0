Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267D15B34E3
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIIKMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIIKMy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:12:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0DD5725
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 774B2B8247B
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F10C433D7;
        Fri,  9 Sep 2022 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718371;
        bh=yDZIXIy21L6RAjRLN8cOV8rIEumjhDVTwYRylcXQRcc=;
        h=From:To:Cc:Subject:Date:From;
        b=vHfDGc1jYCDK9ZYxkHnI/QhWOTa37Xt/t0QI1McGjgxX1wjZm5LKeD+/qMCyvgeij
         VHX6oj7ny0sLAuAuGiF444+/Bux0NZAWhcH/YoPKE1QckGcf8P0ctMkvejhJL86koI
         B3NXpbE8PyMN8vMuQziLCjvazvNjMH54iMpJoH+an7gt20jfo8OyGy1yOfjZmMwgGv
         JvK68Zh/1awj9OfebJ6VuUqm7Gww9hpjByVLw+N4e0WGAu1zmNDbjuBr99Vx8qUxoj
         eBS+bd2VtnX04WgNNj1m5mp9yfAvIDdv4VmoA83vJtzZOZjVwQ5SC9W+uS3VwCJxK6
         ZJ2VGQrBI5jww==
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
Subject: [PATCHv3 bpf-next 0/6] bpf: Fixes for CONFIG_X86_KERNEL_IBT 
Date:   Fri,  9 Sep 2022 12:12:39 +0200
Message-Id: <20220909101245.347173-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 arch/x86/net/bpf_jit_comp.c                               |  9 ++++-----
 include/linux/kprobes.h                                   |  1 +
 kernel/kprobes.c                                          |  6 +++++-
 kernel/trace/bpf_trace.c                                  | 15 ++++++++++++++-
 kernel/trace/ftrace.c                                     |  3 +--
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 25 +++++++++++++------------
 tools/testing/selftests/bpf/progs/kprobe_multi.c          |  4 +---
 8 files changed, 87 insertions(+), 35 deletions(-)
