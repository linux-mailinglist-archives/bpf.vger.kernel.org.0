Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7841F60CDBD
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJYNl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYNlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 09:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68F182C68
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 06:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6896195F
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 13:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D1DC433C1;
        Tue, 25 Oct 2022 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666705314;
        bh=tHar8XVdBSj3XD60n5Qfn5LdqhBET+sKBLMeH2tOYZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=n+zW7zNbJGbt4+hPcpDdO2o2hk7uBWBvs1xoD/PTNVi1FPU0Y2L2C5CPhDWSyPJPj
         K/xBn0IU2uzRQiKNl9UUw2tkRQ7exJFwSghzt5xBT8sKV+hGnPoPr+e2T8LS15FfCU
         g9x0PXh0Fx2nIbT13up6eH1NG3C/eNLwDnFklY0bK1R9L9DRaR7UZ6GSvTZExbAfF5
         DAn9nRBdnQeBlKHcBbfkvpigG4f0UgJp6tPLftCN91KynS5Yx+F1kdT5OdhOytHdi2
         BgfWzPf0lWuaSvVAhKqLazrxuHRQcNFQyge1I+qr6W42TT4q5/fboeoWGpCQedOHdj
         GxFbF2zbJVNCA==
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
Subject: [PATCHv3 bpf-next 0/8] bpf: Fixes for kprobe multi on kernel modules
Date:   Tue, 25 Oct 2022 15:41:40 +0200
Message-Id: <20221025134148.3300700-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
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
Martynas reported kprobe _multi link does not resolve symbols
from kernel modules, which attach by address works.

In addition while fixing that I realized we do not take module
reference if the module has kprobe_multi link on top of it and
can be removed.

There's mo crash related to this, it will silently disappear from
ftrace tables, while kprobe_multi link stays up with no data.

This patchset has fixes for both issues.

v3 changes:
  - reorder fields in struct bpf_kprobe_multi_link [Andrii]
  - added ack [Andrii]

v2 changes:
  - added acks (Song)
  - added comment to kallsyms_callback (Song)
  - change module_callback realloc logic (Andrii)
  - get rid of macros in tests (Andrii)

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
      selftests/bpf: Add kprobe_multi check to module attach test
      selftests/bpf: Add kprobe_multi kmod attach api tests

 include/linux/module.h                                             |  9 +++++++++
 kernel/module/kallsyms.c                                           |  2 --
 kernel/trace/bpf_trace.c                                           | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/ftrace.c                                              | 16 +++++++++++-----
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c              | 24 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/module_attach.c             |  7 +++++++
 tools/testing/selftests/bpf/progs/kprobe_multi.c                   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_module_attach.c             |  6 ++++++
 tools/testing/selftests/bpf/trace_helpers.c                        | 20 +++++++++++++-------
 tools/testing/selftests/bpf/trace_helpers.h                        |  2 ++
 11 files changed, 306 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
