Return-Path: <bpf+bounces-521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5A702E69
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32019281298
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E89C8FA;
	Mon, 15 May 2023 13:38:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B279D4
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E7BC433D2;
	Mon, 15 May 2023 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157881;
	bh=o/9Q4mQYyL9nghoVBnsLc5mbAVHrF3PZiTClZWxsY9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=nTH7vu7wvADOWT8AL+4dj2+a1h13XmgAXXzslidz6xlRvBaTnzD80UNcd/61D5npL
	 EXEjBcNpLa+of+B/4rDZbzsKiGcSEUbyhvbdDmjrc27h1iImH2FMda4604tS/fBf19
	 eZ8RvHU7s1ffM3a1gF3BNUCN/1TK3Q6yofEVKtwxmxpPAHsw5BaNUrOGosGoovvqQa
	 sh79XP1OmjKySBqN5bFwv9IkLeZ92VJBaJuTlvUfR64AU8Uye7s/9PZyELxP3R/v2w
	 5eEsXM2DypYM3orKrwgdbiVaIQH7qSmgnd9nn8BJBhPA9y+yR+EzkQ5inF7Ic3T0TP
	 soZimis7iqeWA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	David Vernet <void@manifault.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 00/10] bpf: Move kernel test kfuncs into bpf_testmod
Date: Mon, 15 May 2023 15:37:46 +0200
Message-Id: <20230515133756.1658301-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
I noticed several times in discussions that we should move test kfuncs
into kernel module, now perhaps even more pressing with all the kfunc
effort. This patchset moves all the test kfuncs into bpf_testmod.

I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
bpf_testmod kernel module and BPF programs.

v4 changes:
  - s390 supports long calls [1] now, so it can call now kfuncs from module [Ilya]
  - added acks [David]
  - cleanups for ptr_to_u64 function [David]
  - use relative path for bpf_testmod_kfunc.h include [Andrii]
  - new libbpf fix (patch 1) for gen_loader

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


[1] 1cf3bfc60f98 bpf: Support 64-bit pointers to kfuncs
---
Jiri Olsa (10):
      libbpf: Store zero fd to fd_array for loader kfunc relocation
      selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
      selftests/bpf: Move test_progs helpers to testing_helpers object
      selftests/bpf: Use only stdout in un/load_bpf_testmod functions
      selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
      selftests/bpf: Use un/load_bpf_testmod functions in tests
      selftests/bpf: Load bpf_testmod for verifier test
      selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
      selftests/bpf: Remove extern from kfuncs declarations
      bpf: Move kernel test kfuncs to bpf_testmod

 net/bpf/test_run.c                                          | 201 ------------------------------------------------------------------------------------------------------------------------------------------------
 tools/lib/bpf/gen_loader.c                                  |  14 +++++-----
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c       |  34 ++++---------------------
 tools/testing/selftests/bpf/prog_tests/module_attach.c      |  12 +++------
 tools/testing/selftests/bpf/progs/cb_refs.c                 |   4 +--
 tools/testing/selftests/bpf/progs/jit_probe_mem.c           |   4 +--
 tools/testing/selftests/bpf/progs/kfunc_call_destructive.c  |   3 +--
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c         |   9 +------
 tools/testing/selftests/bpf/progs/kfunc_call_race.c         |   3 +--
 tools/testing/selftests/bpf/progs/kfunc_call_test.c         |  17 +------------
 tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c |   9 ++-----
 tools/testing/selftests/bpf/progs/local_kptr_stash.c        |   5 ++--
 tools/testing/selftests/bpf/progs/map_kptr.c                |   5 +---
 tools/testing/selftests/bpf/progs/map_kptr_fail.c           |   4 +--
 tools/testing/selftests/bpf/test_progs.c                    |  76 +++++++------------------------------------------------
 tools/testing/selftests/bpf/test_progs.h                    |   1 -
 tools/testing/selftests/bpf/test_verifier.c                 | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 tools/testing/selftests/bpf/testing_helpers.c               |  61 ++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h               |   9 +++++++
 21 files changed, 521 insertions(+), 386 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h

