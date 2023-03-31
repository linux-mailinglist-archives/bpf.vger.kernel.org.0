Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E726D1C6D
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjCaJcj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCaJcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 05:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31411D865
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 02:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD1F86264F
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94629C433EF;
        Fri, 31 Mar 2023 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680255123;
        bh=nN2IlFKOn1Su/noqBAY4K6iNOzwKxvEqe166UsbvLoA=;
        h=From:To:Cc:Subject:Date:From;
        b=fiT2lSnYYmBjrbulcluMxA3HZvMYKxkLhv9c0Wq7IHnTM1wj5EY1rWQfNqvNJnSTe
         gaPGAjjC8R4KPVDKvyBS9H5cZKcvJx883+AsziymaJgIoODsSKZd3Y2jxVW34p0sBm
         gVIx9TdIiXFSXeJ2tcdOMs1uZDHyQoTMY7ASvcLZFSUyVAij7sIE+gLyjrpu1a7iMS
         CzlAO9GoICWuKVO9gUI15DdA0bOEnz4uNuc09WAnKYOYP1lItVAdK27djXPxlpnOk3
         SyqhEz64Ffk/cQ32Dap8lEpVHXAJa4fjpv/plcg0istydsFuHqNfqKe0ou6DE6Nfx6
         r3nk08BzzWCZA==
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
Subject: [PATCHv4 bpf-next 0/3] selftests/bpf: Add read_build_id function
Date:   Fri, 31 Mar 2023 11:31:54 +0200
Message-Id: <20230331093157.1749137-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
this selftests cleanup was previously posted as part of file build id changes [1],
which might take more time, so I'm sending the selftests changes separately so it
won't get stuck.

v4 changes:
  - added size argument to read_build_id [Andrii]
  - condition changes in parse_build_id_buf [Andrii]
  - use ELF_C_READ_MMAP in elf_begin [Andrii]
  - return -ENOENT in read_build_id if build id is not found [Andrii]
  - dropped elf class check [Andrii]

thanks,
jirka


[1] https://lore.kernel.org/bpf/20230316170149.4106586-1-jolsa@kernel.org/
---
Jiri Olsa (3):
      selftests/bpf: Add err.h header
      selftests/bpf: Add read_build_id function
      selftests/bpf: Replace extract_build_id with read_build_id

 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c     | 19 +++++++------------
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c | 17 ++++++-----------
 tools/testing/selftests/bpf/progs/err.h                          | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/profiler.inc.h                 |  3 +--
 tools/testing/selftests/bpf/test_progs.c                         | 25 -------------------------
 tools/testing/selftests/bpf/test_progs.h                         |  1 -
 tools/testing/selftests/bpf/trace_helpers.c                      | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h                      |  5 +++++
 8 files changed, 119 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/err.h
