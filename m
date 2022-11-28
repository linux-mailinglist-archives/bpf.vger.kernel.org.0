Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DB63A97C
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 14:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiK1N3l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 08:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiK1N32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 08:29:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4B1D328
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 05:29:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BCCDB80DB5
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171CBC433C1;
        Mon, 28 Nov 2022 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669642162;
        bh=A9GooZGZYRI2aUV4IQUux5F1uOxjFpaIKyUClp91XA8=;
        h=From:To:Cc:Subject:Date:From;
        b=WEGeDOWWjee7w/RrduC4x8Ndb+IWDeJBLIUlZGh9o79nuJrp4lrmXXmyaOFXzU0wC
         8XAGRsEPq9u78YUYnyJgYRWJfyfMn01a41ccz8imR8ZwazD5Tm/Rk1o/l4ubrEnGEf
         YG8JpGuQfY1nONg0bls5cOxCOCtqoQH/DlXwKwAF9zKilZvKUinqHCgaO5RMm5mB59
         v8aSx/u+XAYgg4Zhf6c9eK/3bSfwG7Z3LlPe6efT13xoJmfTjcs7qBeiMJNx/hQBC1
         dpTq6a/MxhAWl6n8epeT6dMVDG2HsPgkx+e0usJy+M6k+tj8HfhJfULHZaUWMZLONy
         5CRqnHklGw0tQ==
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
Subject: [PATCHv4 bpf-next 0/4] bpf: Add bpf_vma_build_id_parse kfunc
Date:   Mon, 28 Nov 2022 14:29:11 +0100
Message-Id: <20221128132915.141211-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
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
first version of this patchset added helper for this functionality,
but based Alexei's feedback [1], changing it to kfunc.

With the current build_id_parse function as kfunc we can't effectively
check buffer size provided by user. Therefore adding new function as
bpf kfunc:

  int bpf_vma_build_id_parse(struct vm_area_struct *vma,
                             unsigned char *build_id,
                             size_t build_id__sz);

that triggers kfunc's verifier check for build_id/build_id__sz buffer
size and calls build_id_parse.

v4 changes:
  - vma object is now passed as trusted pointer argument [Alexei]
    - marked bpf_vma_build_id_parse with KF_TRUSTED_ARGS flag
      so it can be called only with PTR_TRUSTED args
    - marked vma objects from task_vma iter and find_vma callback
      as PTR_TRUSTED
  - added test for task_vma iterator

v3 changes:
  - restrict bpf_vma_build_id_parse to bpf_find_vma callback
  - move bpf_vma_build_id_parse to kernel/trace/bpf_trace.c
    and add new tracing_kfunc_set

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAADnVQKyT4Mm4EdTCYK8c070E-BwPZS_FOkWKLJC80riSGmLTg@mail.gmail.com/
---
Jiri Olsa (4):
      bpf: Mark vma objects as trusted for task_vma iter and find_vma callback
      bpf: Add bpf_vma_build_id_parse function and kfunc
      selftests/bpf: Add bpf_vma_build_id_parse find_vma callback test
      selftests/bpf: Add bpf_vma_build_id_parse task vma iterator test

 include/linux/bpf.h                                             |  4 ++++
 kernel/bpf/task_iter.c                                          |  2 +-
 kernel/bpf/verifier.c                                           |  2 +-
 kernel/trace/bpf_trace.c                                        | 31 +++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c               | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter_build_id.c           | 41 +++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.c                     | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h                     |  1 +
 10 files changed, 258 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
