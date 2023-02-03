Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67E689F13
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjBCQXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBCQXo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:23:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A35A6BB1
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:23:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FA861F87
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A17BC433EF;
        Fri,  3 Feb 2023 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441421;
        bh=k5yV3uKp+hGzGMoCGJPXOrlLZWSERMElfplPQEtFn9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=BKqXmtI4z0WzRN4EgFJM7DZo+yD8eZa/Nps4rW8Pi4CAWBdgtg9MZfe//rSkyQQo9
         GbYffnlczMQqNllis2Ycfrk6iKQwvOyXHhthRTagbehRqKgWF/Phkyik8jPLOPsFGS
         wu7CG01O36NNFTcNysI6S6+AUEdjGjqA1nLbDRYB/8B3gaq6zNJ6q8pEg8n1K4pW7A
         JXKaRr1ola0CurzCh/VIibttzkx8e0lX1jvG+qy9CW26LJ75E1ma35JuPPZAv6mxp9
         S0eyTRxzzdtZw9/JaAs0tOdVC75jZqxB5HfYSMLyBtmSFvUYiJZQzMcAv6iujytIGf
         AFT5pMvpDOVjA==
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
Subject: [PATCHv3 bpf-next 0/9] bpf: Move kernel test kfuncs into bpf_testmod
Date:   Fri,  3 Feb 2023 17:23:27 +0100
Message-Id: <20230203162336.608323-1-jolsa@kernel.org>
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

v3 changes:
  - added acks [David]
  - added bpf_testmod.ko make dependency for bpf test progs [David]
  - better handling of __ksym and refcount_t in bpf_testmod_kfunc.h [David]
  - removed 'extern' from kfuncs declarations [David]
  - typo in header guard macro [David]
  - use only stdout in un/load_bpf_testmod

v2 changes:
  - add 74bc3a5acc82 into bpf-next/master CI, so the test would pass
    https://github.com/kernel-patches/vmtest/pull/192
  - remove extra externs [Artem]
  - using un/load_bpf_testmod in other tests
  - rebased

thanks,
jirka


---
Jiri Olsa (9):
      selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
      selftests/bpf: Move test_progs helpers to testing_helpers object
      selftests/bpf: Use only stdout in un/load_bpf_testmod functions
      selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
      selftests/bpf: Use un/load_bpf_testmod functions in tests
      selftests/bpf: Load bpf_testmod for verifier test
      selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
      selftests/bpf: Remove extern from kfuncs declarations
      bpf: Move kernel test kfuncs to bpf_testmod

 net/bpf/test_run.c                                          | 271 +------------------------------------------------------------------------------------------
 tools/testing/selftests/bpf/Makefile                        |   1 +
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 206 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h | 102 ++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c       |  34 ++----------
 tools/testing/selftests/bpf/prog_tests/module_attach.c      |  12 ++--
 tools/testing/selftests/bpf/progs/cb_refs.c                 |   4 +-
 tools/testing/selftests/bpf/progs/jit_probe_mem.c           |   4 +-
 tools/testing/selftests/bpf/progs/kfunc_call_destructive.c  |   3 +-
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c         |   9 +--
 tools/testing/selftests/bpf/progs/kfunc_call_race.c         |   3 +-
 tools/testing/selftests/bpf/progs/kfunc_call_test.c         |  17 +-----
 tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c |   9 +--
 tools/testing/selftests/bpf/progs/map_kptr.c                |   6 +-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c           |   5 +-
 tools/testing/selftests/bpf/test_progs.c                    |  76 +++-----------------------
 tools/testing/selftests/bpf/test_progs.h                    |   1 -
 tools/testing/selftests/bpf/test_verifier.c                 | 170 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/testing/selftests/bpf/testing_helpers.c               |  61 +++++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h               |  10 ++++
 20 files changed, 556 insertions(+), 448 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
