Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE2521562
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbiEJMaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbiEJMaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 08:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110132A28F0;
        Tue, 10 May 2022 05:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8255460BCA;
        Tue, 10 May 2022 12:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39472C385A6;
        Tue, 10 May 2022 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652185583;
        bh=QSxYepskwcWV7Tkn3CUsvJPqN+ix+vyCqeVa72VJxTU=;
        h=From:To:Cc:Subject:Date:From;
        b=JCBI4a7mFboQi7xYPOjeFGkvNUW5ONFkymVJJDtbVAAeeZX2u5nS/s3y7ZOWcMeP+
         lSSjG18P9QCdkOqPy5zKZZiUMJC/ppUFJQpIHFABmABoqtoAV+6w34j3RhbaOh1KQo
         67jEWL5uF+AjDFqVJ/EwRkvaY07mPAniWwWXvCl4Mot1XhBGX/SOUydMvzwORE9KXD
         F6ySdglwA2f4PyKW8PuWFIZD5RFnckTFHUkyBHfyvHBzJkIUXdPrM2EV9p0bW9P2sm
         FOxB2p0YjkS03XCslzyIPjejYUWdo6aHzcr8qehQ/uv/h77lI/SnPLVs9fE3gjU1Cf
         Ve+IPXWzmEDow==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv6 bpf-next 0/5] bpf: Speed up symbol resolving in kprobe multi link
Date:   Tue, 10 May 2022 14:26:11 +0200
Message-Id: <20220510122616.2652285-1-jolsa@kernel.org>
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

hi,
sending additional fix for symbol resolving in kprobe multi link
requested by Alexei and Andrii [1].

This speeds up bpftrace kprobe attachment, when using pure symbols
(3344 symbols) to attach:

Before:

  # perf stat -r 5 -e cycles ./src/bpftrace -e 'kprobe:x* {  } i:ms:1 { exit(); }'
  ...
  6.5681 +- 0.0225 seconds time elapsed  ( +-  0.34% )

After:

  # perf stat -r 5 -e cycles ./src/bpftrace -e 'kprobe:x* {  } i:ms:1 { exit(); }'
  ...
  0.5661 +- 0.0275 seconds time elapsed  ( +-  4.85% )

v6 changes:
  - rewrote patch 1 changelog and fixed the line length [Christoph]

v5 changes:
  - added acks [Masami]
  - workaround in selftest for RCU warning by filtering out several
    functions to attach

v4 changes:
  - fix compile issue [kernel test robot]
  - added acks [Andrii]

v3 changes:
  - renamed kallsyms_lookup_names to ftrace_lookup_symbols
    and moved it to ftrace.c [Masami]
  - added ack [Andrii]
  - couple small test fixes [Andrii]

v2 changes (first version [2]):
  - removed the 2 seconds check [Alexei]
  - moving/forcing symbols sorting out of kallsyms_lookup_names function [Alexei]
  - skipping one array allocation and copy_from_user [Andrii]
  - several small fixes [Masami,Andrii]
  - build fix [kernel test robot]

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAEf4BzZtQaiUxQ-sm_hH2qKPRaqGHyOfEsW96DxtBHRaKLoL3Q@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20220407125224.310255-1-jolsa@kernel.org/
---
Jiri Olsa (5):
      kallsyms: Make kallsyms_on_each_symbol generally available
      ftrace: Add ftrace_lookup_symbols function
      fprobe: Resolve symbols with ftrace_lookup_symbols
      bpf: Resolve symbols with ftrace_lookup_symbols for kprobe multi link
      selftests/bpf: Add attach bench test

 include/linux/ftrace.h                                     |   6 ++++
 include/linux/kallsyms.h                                   |   7 ++++-
 kernel/kallsyms.c                                          |   3 +-
 kernel/trace/bpf_trace.c                                   | 112 ++++++++++++++++++++++++++++++++++++++++++------------------------------
 kernel/trace/fprobe.c                                      |  32 ++++++++-------------
 kernel/trace/ftrace.c                                      |  62 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_empty.c     |  12 ++++++++
 8 files changed, 308 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_empty.c
