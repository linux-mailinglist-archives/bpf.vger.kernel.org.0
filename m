Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1A6807EF
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 09:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjA3Izx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 03:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjA3Izu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 03:55:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEF3EF93
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 00:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C3A3B80EBC
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 08:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C039C433EF;
        Mon, 30 Jan 2023 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675068946;
        bh=x9RCHyu44d8tNc+crndSMu6mAgLs001/tjW7KudogyY=;
        h=From:To:Cc:Subject:Date:From;
        b=N9NFwAi7QMkeWw2fTbXxsCm6BiAS1flOmPVspUguBYBnhiVN1Elhx8+jJygzrUzl3
         BXw40vJdyAp7M5eybYWm9UEtnpu0t+klg6b907yfxlwl0Uv6DgXpXruAssoOMpIso7
         zdEtZFRb/PIl443fFJ0cOmgr5og1Y5dBmbbqa1vVYoD5I5p5EWAffY3QZFXo1Hw5Da
         PLBIgZujHdJt/TcJYQlU+xTaSDAhg09ZGV93I+PMKzj/emNdBPMlvwzK/Um2u5Qxab
         mdnEAyVi/aiyQXiLTbTIzWE3oA6FaCFfXrQFsH1tC4vwwlWIPqCnXu5mO0rIrL/VLP
         ZmoWvzfa3AsCQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv2 bpf-next 0/7] bpf: Move kernel test kfuncs into bpf_testmod
Date:   Mon, 30 Jan 2023 09:55:33 +0100
Message-Id: <20230130085540.410638-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
I noticed several times in discussions that we should move test kfuncs
into kernel module, now perhaps even more pressing with all the kfunc
effort. This patchset moves all the test kfuncs into bpf_testmod.

I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
bpf_testmod kernel module and BPF programs, which brings some difficulties
with __ksym define. But I'm not sure having separate headers for BPF
programs and for kernel module would be better.

This patchset also needs:
  74bc3a5acc82 bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
which is only in bpf/master now.

v2 changes:
  - add 74bc3a5acc82 into bpf-next/master CI, so the test would pass
    https://github.com/kernel-patches/vmtest/pull/192
  - remove extra externs [Artem]
  - using un/load_bpf_testmod in other tests
  - rebased

thanks,
jirka


---
Jiri Olsa (7):
      selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
      selftests/bpf: Move test_progs helpers to testing_helpers object
      selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
      selftests/bpf: Use un/load_bpf_testmod functions in tests
      selftests/bpf: Load bpf_testmod for verifier test
      selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
      bpf: Move kernel test kfuncs to bpf_testmod

 net/bpf/test_run.c                                          | 262 +------------------------------------------------------------------------------------------
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h |  92 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c       |  34 ++----------
 tools/testing/selftests/bpf/prog_tests/module_attach.c      |  12 ++---
 tools/testing/selftests/bpf/progs/cb_refs.c                 |   4 +-
 tools/testing/selftests/bpf/progs/jit_probe_mem.c           |   4 +-
 tools/testing/selftests/bpf/progs/kfunc_call_destructive.c  |   3 +-
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c         |   9 +---
 tools/testing/selftests/bpf/progs/kfunc_call_race.c         |   3 +-
 tools/testing/selftests/bpf/progs/kfunc_call_test.c         |  16 +-----
 tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c |  17 ++++--
 tools/testing/selftests/bpf/progs/map_kptr.c                |   6 +--
 tools/testing/selftests/bpf/progs/map_kptr_fail.c           |   5 +-
 tools/testing/selftests/bpf/test_progs.c                    |  76 ++++-----------------------
 tools/testing/selftests/bpf/test_progs.h                    |   1 -
 tools/testing/selftests/bpf/test_verifier.c                 | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/testing/selftests/bpf/testing_helpers.c               |  61 +++++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h               |  10 ++++
 19 files changed, 549 insertions(+), 434 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
