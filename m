Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C1679C09
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjAXOgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjAXOgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:36:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF65B84
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:36:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15C14611FD
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 14:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9727CC433D2;
        Tue, 24 Jan 2023 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674570991;
        bh=GPAGzncctuRR5WRhi5c6F/ZED2mo+hbr1zzKClTzJew=;
        h=From:To:Cc:Subject:Date:From;
        b=ixJXnBRRy9TXa85TYJb1PgCzb+DcOFq0fcQlI4uLVD1eAuDpRq1TluoU/1HGX49h4
         lN7+tgApvWYuBPEJvPNFlKoGBG5Qm3s4tuDdewj8J2kjTJS4dcxHKZNA0hf7wKe0SE
         t+9S6K/xOSxz11HeYXZcdOadHdaeTv/nQYzP3hsaFBiS0VOPXjC6QH+J7bKlq7ZoJm
         ImpoNO7rCcG3hbw02vw7979fWW2DBRWg0gaFu0TJlE6nyQd0NNVcmvjcDJAskvXJTl
         lZiL/WvNAuoBpYNFcwnVQoTEaPJIY+iWx2rPZr/5msZQAJX7xDVS8fSLYRS1+aDtjv
         RZn4r93RtCaog==
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
Subject: [PATCH bpf-next 0/5] bpf: Move kernel test kfuncs into bpf_testmod
Date:   Tue, 24 Jan 2023 15:36:21 +0100
Message-Id: <20230124143626.250719-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
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

thanks,
jirka

---
Jiri Olsa (5):
      selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
      selftests/bpf: Move test_progs helpers to testing_helpers object
      selftests/bpf: Load bpf_testmod for verifier test
      selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
      bpf: Move kernel test kfuncs to bpf_testmod

 net/bpf/test_run.c                                          | 253 +------------------------------------------------------------------------------------------
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h |  89 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/cb_refs.c                 |   1 +
 tools/testing/selftests/bpf/progs/jit_probe_mem.c           |   3 +-
 tools/testing/selftests/bpf/progs/kfunc_call_destructive.c  |   3 +-
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c         |   9 +---
 tools/testing/selftests/bpf/progs/kfunc_call_race.c         |   3 +-
 tools/testing/selftests/bpf/progs/kfunc_call_test.c         |  15 +-----
 tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c |  17 +++++--
 tools/testing/selftests/bpf/progs/map_kptr.c                |   1 +
 tools/testing/selftests/bpf/progs/map_kptr_fail.c           |   1 +
 tools/testing/selftests/bpf/test_progs.c                    |  67 +-----------------------
 tools/testing/selftests/bpf/test_verifier.c                 | 165 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/testing/selftests/bpf/testing_helpers.c               |  63 +++++++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h               |  10 ++++
 16 files changed, 520 insertions(+), 371 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
