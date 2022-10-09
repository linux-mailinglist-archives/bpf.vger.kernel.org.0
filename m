Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7BB5F8F05
	for <lists+bpf@lfdr.de>; Sun,  9 Oct 2022 23:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJIV7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 17:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJIV7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 17:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798CBD
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 14:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30DE660C42
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 21:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AC4C433D6;
        Sun,  9 Oct 2022 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665352773;
        bh=Fqn1LDBSWNuF8NCkAmgwbJZ6hfw6FAnPemR785iUJGk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZuvMPLVPmx9dRaUAFKy6ZFRuzRRCz2PWbF7/nwflD0IauBv6//fJVVofTtsAKQUpr
         6x/RzilbUvaVUF7JW3WtECW8A0OdbYeiUj+InGw3cRWYO/abT/WXp04cSpG6Dg4gRi
         olcuTBjEBGY7LH8exTrX0/1p8dquqAkgFORFTbCzzbwOinZEQZ3GWr0aSeQpBpHP+0
         SjsXTjqavG0G7rEcqpsYa2nVS7aSPYhHI4xYVrwTw+jyiCGEZuNrZHqJ9toKilZr2/
         +wdV+fePqeDImUUj+8QTNfqWXxtqGkxGQufIJxdEO3fX6bmy7BJoiDCL6SMz4/HwUY
         PsbeJU7qxGMKw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf-next 0/8] bpf: Fixes for kprobe multi on kernel modules
Date:   Sun,  9 Oct 2022 23:59:18 +0200
Message-Id: <20221009215926.970164-1-jolsa@kernel.org>
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
Martynas reported kprobe _multi link does not resolve symbols
from kernel modules, which attach by address works.

In addition while fixing that I realized we do not take module
reference if the module has kprobe_multi link on top of it and
can be removed.

There's mo crash related to this, it will silently disappear from
ftrace tables, while kprobe_multi link stays up with no data.

This patchset has fixes for both issues.

thanks,
jirka


---
Jiri Olsa (8):
      kallsyms: Make module_kallsyms_on_each_symbol generally available
      ftrace: Add support to resolve module symbols in ftrace_lookup_symbols
      bpf: Rename __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp
      bpf: Take module reference on kprobe_multi link
      selftests/bpf: Add load_kallsyms_refresh function
      selftests/bpf: Add bpf_testmod_fentry_* functions
      selftests/bpf: Add kprobe_multi kmod link api tests
      selftests/bpf: Add kprobe_multi check to module attach test

 include/linux/module.h                                             |   9 ++++++++
 kernel/module/kallsyms.c                                           |   2 --
 kernel/trace/bpf_trace.c                                           | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/ftrace.c                                              |  11 +++++----
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c              |  24 +++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c |  94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/module_attach.c             |   7 ++++++
 tools/testing/selftests/bpf/progs/kprobe_multi.c                   |  51 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_module_attach.c             |   6 +++++
 tools/testing/selftests/bpf/trace_helpers.c                        |  20 ++++++++++------
 tools/testing/selftests/bpf/trace_helpers.h                        |   2 ++
 11 files changed, 315 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
