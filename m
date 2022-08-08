Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301F58CA17
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiHHOGi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiHHOGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:06:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E80D73
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEB76CE1104
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D3DC433D6;
        Mon,  8 Aug 2022 14:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967593;
        bh=Jyjb2iG67Yw0o4r6uFbUuzn6Wo+JpgR0EElmyAz04xw=;
        h=From:To:Cc:Subject:Date:From;
        b=Js0losBOJTOS1bBK5AQTNsY8OjBEinXKOAfBojiVu0mldpsxBpPRPtkz0MZAFn6hy
         ic+6CCIIjjFoZW9Hj8PB0DbuedxA+LC1raf4v0sfR20SmsZ36qAYDDajSJvLT8Ifqu
         9WgdJCvdwXOvpD4eg8PXnsiN2oweSNQ22NZQQ+HXHomycVwar/7bDcqUbaMJtX1t3b
         z8Bw/P4MjQIzeoa3tTafXcfKmuQN5YTBtO13AwMPzwHXau22PHMYJ9yFMtXSGZ5mHU
         cGdrcQROfS8ze9rQs1wP26v+ltPzeqeGC26usiEU7YSNlcA+zzVF4VYMSZD2wDTRzt
         eF4q+6vhEt4eQ==
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
Subject: [RFC PATCH bpf-next 00/17] bpf: Add tracing multi link
Date:   Mon,  8 Aug 2022 16:06:09 +0200
Message-Id: <20220808140626.422731-1-jolsa@kernel.org>
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
this is another attempt to add batch attachment support for
trampolines.

The patchset adds support to create 'multi' trampoline that is
attached to set of functions represented by BTF IDs.

Previous post [0] tried to implement multi trampolines overlapping,
but it turned out too complex, so I got back to simpler rules:
(we can discuss possible overlapping changes on top this change)

  - multi trampoline can attach on top of existing single trampolines,
    which creates 2 types of function IDs:

      1) single-IDs - functions that are attached within existing
         single trampolines
      2) multi-IDs  - functions that were 'not used' and are now
         taken by new 'multi' trampoline

  - we allow overlapping of 2 'multi' trampolines if they are attached
    to same IDs
  - we do now allow any other overlapping of 2 'multi' trampolines
  - any new 'single' trampoline cannot attach to existing multi-IDs IDs


Maybe better explained on following example:
    
  - you want to attach program P to functions A,B,C,D,E,F
    via bpf_trampoline_multi_attach

  - D,E,F already have standard trampoline attached

  - the bpf_trampoline_multi_attach will create new 'multi' trampoline
    which spans over A,B,C functions and attach program P to single
    trampolines D,E,F

 -  another program can be attached to A,B,C,D,E,F multi trampoline

  - A,B,C functions are now 'not attachable' by any trampoline
    until the above 'multi' trampoline is released

 -  D,E,F functions are still attachable by any new trampoline


Also now that we have trampoline helpers for function arguments,
we can just simply use function declaration with maximum arguments
for any multi trampoline or related single trampoline.

There are couple of things missing in this post (that I know of),
which I'll add when we agree that this is the way to go:

  - attaching by functions names
  - cookies support
  - find out better way of locking trampolines in bpf_trampoline_multi_attach
    and bpf_trampoline_multi_detach
  - bpf_tramp_update_set logic of calling multiple times register_ftrace_direct_multi
    function can be replaced by calling single update ftrace function that I have
    prototype for, but I will send it out separately to ftrace for review
  - arm trampoline code changes (won't compile now)
  - tests for error paths

thanks,
jirka


[0] - https://lore.kernel.org/bpf/20211118112455.475349-1-jolsa@kernel.org/
---
Jiri Olsa (17):
      bpf: Link shimlink directly in trampoline
      bpf: Replace bpf_tramp_links with bpf_tramp_progs
      bpf: Store trampoline progs in arrays
      bpf: Add multi tracing attach types
      bpf: Add bpf_tramp_id object
      bpf: Pass image struct to reg/unreg/modify fentry functions
      bpf: Add support to postpone trampoline update
      bpf: Factor bpf_trampoline_lookup function
      bpf: Factor bpf_trampoline_put function
      bpf: Add support to attach program to multiple trampolines
      bpf: Add support to create tracing multi link
      libbpf: Add btf__find_by_glob_kind function
      libbpf: Add support to create tracing multi link
      selftests/bpf: Add fentry tracing multi func test
      selftests/bpf: Add fexit tracing multi func test
      selftests/bpf: Add fentry/fexit tracing multi func test
      selftests/bpf: Add mixed tracing multi func test

 arch/x86/net/bpf_jit_comp.c                                    |  38 ++---
 include/linux/bpf.h                                            |  98 ++++++++----
 include/linux/trace_events.h                                   |   5 +
 include/uapi/linux/bpf.h                                       |   7 +
 kernel/bpf/bpf_struct_ops.c                                    |  30 ++--
 kernel/bpf/syscall.c                                           |  56 +++++--
 kernel/bpf/trampoline.c                                        | 723 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 kernel/bpf/verifier.c                                          |   8 +-
 kernel/trace/bpf_trace.c                                       | 240 +++++++++++++++++++++++++++++
 net/bpf/bpf_dummy_struct_ops.c                                 |  16 +-
 net/bpf/test_run.c                                             |   2 +
 tools/include/uapi/linux/bpf.h                                 |   7 +
 tools/lib/bpf/bpf.c                                            |   7 +
 tools/lib/bpf/bpf.h                                            |   4 +
 tools/lib/bpf/btf.c                                            |  41 +++++
 tools/lib/bpf/btf.h                                            |   3 +
 tools/lib/bpf/libbpf.c                                         |  91 ++++++++++-
 tools/lib/bpf/libbpf.h                                         |  14 ++
 tools/lib/bpf/libbpf.map                                       |   1 +
 tools/lib/bpf/libbpf_internal.h                                |   1 +
 tools/testing/selftests/bpf/Makefile                           |   9 +-
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c         | 158 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c        | 158 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_fentry.c       |  17 +++
 tools/testing/selftests/bpf/progs/tracing_multi_fentry_fexit.c |  28 ++++
 tools/testing/selftests/bpf/progs/tracing_multi_fexit.c        |  20 +++
 tools/testing/selftests/bpf/progs/tracing_multi_mixed.c        |  43 ++++++
 27 files changed, 1624 insertions(+), 201 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fentry_fexit.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fexit.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_mixed.c
