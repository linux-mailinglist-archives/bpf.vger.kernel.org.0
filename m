Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8EA6ED1F4
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDXQE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjDXQEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F65FE4
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC0CF61C12
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E079C433EF;
        Mon, 24 Apr 2023 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352292;
        bh=fc2sy1Uhd+Wcxoz+j0ps1HwJ6PGyOxz1gQiNg1Mk7DQ=;
        h=From:To:Cc:Subject:Date:From;
        b=hAdseRrejZHIXoO5qwCz04rN+7Ho2f9p/NNLnF5nyYqOOf+SAmh5Az+oNfqYF8xnf
         /LgEYztbJdX7B0lmslNS2LVH2ukVgn18sQ0Y0RVdoSR6vJF9J+5Udw9WNl/1tXJtJy
         oyjmJZD0Uxf2TpepA2+FA4oPn3oR7i5OCBMwDIqacUlq9hi8nUerQHuGQiYUq9TA0C
         Mh2aiz8yKIeUrUfVBVpOfDw9xD2JuyOG/H73kirfJ6bnCasvzp/xQwKzePHYuKnnP0
         6LtcmGb46LDeJpZhG4PQQDPS34eMYr44vtlqPq1dihPhYgWB4w2lk81Wpwkvudd3O0
         lBpXIpMGtagzw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Viktor Malik <viktor.malik@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 00/20] bpf: Add multi uprobe link
Date:   Mon, 24 Apr 2023 18:04:27 +0200
Message-Id: <20230424160447.2005755-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
this patchset is adding support to attach multiple uprobes and usdt probes
through new uprobe_multi link.

The current uprobe is attached through the perf event and attaching many
uprobes takes a lot of time because of that.

The main reason is that we need to install perf event for each probed function
and profile shows perf event installation (perf_install_in_context) as culprit.

The new uprobe_multi link just creates raw uprobes and attaches the bpf
program to them without perf event being involved.

In addition to being faster we also save file descriptors. For the current
uprobe attach we use extra perf event fd for each probed function. The new
link just need one fd that covers all the functions we are attaching to.

By dropping perf we lose the ability to attach uprobe to specific pid.
We can workaround that by having pid check directly in the bpf program,
but we might need to check for another solution if that will turn out
to be a problem.


Attaching current bpftrace to 1000 uprobes:

  # BPFTRACE_MAX_PROBES=100000 perf stat -e cycles,instructions \
    ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:ms:1 { exit(); }' 
    ...

     126,666,390,509      cycles                                                                
      29,973,207,307      instructions                     #    0.24  insn per cycle            

        85.284833554 seconds time elapsed


Same bpftrace setup with uprobe_multi support:

  # perf stat -e cycles,instructions \
    ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:ms:1 { exit(); }' 
    ...

       6,818,470,649      cycles                                                                
      13,275,510,122      instructions                     #    1.95  insn per cycle            

         1.943269451 seconds time elapsed


I'm sending this as RFC because of:
  - I added/exported some new elf_* helper functions in libbpf,
    and I'm not sure that's the best/right way of doing this
  - I'm not completely sure about the usdt integration in bpf_program__attach_usdt,
    I was trying to detect uprobe_multi kernel support first, but ended up with
    just new field for struct bpf_usdt_opts
  - I plan to add more tests for usdt probes defined with refctr


Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  uprobe_multi

There are PRs for tetragon [1] and bpftrace [2] support.

thanks,
jirka


[1] https://github.com/cilium/tetragon/pull/936
[2] https://github.com/olsajiri/bpftrace/tree/uprobe_multi

Cc: Viktor Malik <viktor.malik@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
---
Jiri Olsa (20):
      bpf: Add multi uprobe link
      bpf: Add cookies support for uprobe_multi link
      bpf: Add bpf_get_func_ip helper support for uprobe link
      libbpf: Update uapi bpf.h tools header
      libbpf: Add uprobe_multi attach type and link names
      libbpf: Factor elf_for_each_symbol function
      libbpf: Add elf_find_multi_func_offset function
      libbpf: Add elf_find_patern_func_offset function
      libbpf: Add bpf_link_create support for multi uprobes
      libbpf: Add bpf_program__attach_uprobe_multi_opts function
      libbpf: Add support for uprobe.multi/uprobe.multi program sections
      libbpf: Add uprobe multi link support to bpf_program__attach_usdt
      selftests/bpf: Add uprobe_multi skel test
      selftests/bpf: Add uprobe_multi api test
      selftests/bpf: Add uprobe_multi link test
      selftests/bpf: Add uprobe_multi test program
      selftests/bpf: Add uprobe_multi bench test
      selftests/bpf: Add usdt_multi test program
      selftests/bpf: Add usdt_multi bench test
      selftests/bpf: Add uprobe_multi cookie test

 include/linux/trace_events.h                               |   6 +
 include/uapi/linux/bpf.h                                   |  15 +++
 kernel/bpf/syscall.c                                       |  18 ++-
 kernel/trace/bpf_trace.c                                   | 310 +++++++++++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                             |  15 +++
 tools/lib/bpf/bpf.c                                        |  10 ++
 tools/lib/bpf/bpf.h                                        |  10 +-
 tools/lib/bpf/libbpf.c                                     | 653 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/lib/bpf/libbpf.h                                     |  43 ++++++
 tools/lib/bpf/libbpf.map                                   |   3 +
 tools/lib/bpf/libbpf_internal.h                            |   2 +-
 tools/lib/bpf/usdt.c                                       | 127 +++++++++++++-----
 tools/testing/selftests/bpf/Makefile                       |  10 ++
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c        |  78 +++++++++++
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 286 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi.c           |  72 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c      |  16 +++
 tools/testing/selftests/bpf/uprobe_multi.c                 |  53 ++++++++
 tools/testing/selftests/bpf/usdt_multi.c                   |  23 ++++
 19 files changed, 1634 insertions(+), 116 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/usdt_multi.c
