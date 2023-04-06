Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083236D8C0A
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 02:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjDFAkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjDFAkn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF6D76AA
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 17:40:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso36880134ybj.5
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680741638;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f8wJOETfMk5LbkAt5hTIIj7SEycwbAoJf/W25gr+5f8=;
        b=X/Cr1dJYDVkTN7ZvVGGMWTGTPtx3tU0OJHVzAf+vzbi5Ai/vsm2qgnCLrIgHDlYgFY
         Nxy8ZU/49Bz9yxHGc+Dj5IqZ1g8DRbmgUUaqUs+uW+gHXqmWIcqYmcmx44zAzS/G7Nmt
         0xcUbqZPWofWsTH8IIkTL70sXGu2k6KPvZOzapVGTI8s0Dss1lnxrlfXgsICZL5AURrl
         TMm4m/R8RSFUbb8ZbaEIpuWxFz4ns/RpD4gIzMATa8MSLzhc6cWsUNDhM5YLxp6WoZvj
         +gIbhUhacuZ60SXdzI7qwxYCEYrhtSGchiQ5hGFlK9eFrpVRcExBjmKQITlJkI4EbGRR
         bPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680741638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8wJOETfMk5LbkAt5hTIIj7SEycwbAoJf/W25gr+5f8=;
        b=xEFQFcuIccHjyOP/mYOr99gRszcVn3NJEgcDqk67hGUPf2HDARWN+CMT2cKZVrVZCk
         V1LFyvYy00NFSa86r474xzRMaTDOiT7zhgd3KdbvSKqQ76AX/p5HTQaEb7Z6FCk0G01M
         o6GzKzMbkhXLF9Sjh3JQ7FCaZEYLsRygG/lKRI+/eNN098xkxwEWGWxq44F80yyvpHeh
         Rx38+njfaExqZAXIY7yaa7mWT8DCHreklwAOVsfj3SbxwwmsdQAtlZImHW2VRNbEBF3R
         nLKvzjh7K0pB8kcw3Pq8Ggavbp/Fy3rFP0qGjIKR8gkJdOFe8lICjCh3IT17fPCJ1r/O
         eeSg==
X-Gm-Message-State: AAQBX9ctHGjnZ6JKyAlM1xxSR1OE4EFOXSd6IMxWwOAO1/HVsT8TJczX
        +weYYzmFiGa4QLAqsInL8DR4gCRZkwAZXLvjhRA6ryg1Cma0Z6pvb0LnwQWLCYvCKZVM8ofnAmd
        rkoafx4auiZ6IZ+fGvlntyvoGI4SFcvv/+kbZjf+XuGDTwZ+nSjGBNvo+TQ==
X-Google-Smtp-Source: AKy350Y5s7wagCr2uOBka7VpOa5phS+wwbaNaXpFuChbYAP5L74Oi6tc7dDQxdsiKbYC5BJLLm9qAExTIvw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:694f:f21b:c6de:aead])
 (user=drosen job=sendgmr) by 2002:a81:af42:0:b0:546:8e4:703f with SMTP id
 x2-20020a81af42000000b0054608e4703fmr4898774ywj.8.1680741638313; Wed, 05 Apr
 2023 17:40:38 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:40:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406004018.1439952-1-drosen@google.com>
Subject: [PATCH 0/3] Dynptr Verifier Adjustments
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These patches relax a few verifier requirements around dynptrs.

I was unable to test the patch in 0003 due to unrelated issues compiling the
bpf selftests, but did run an equivalent local test program.

This is the issue I was running into:
progs/cgrp_ls_attach_cgroup.c:17:15: error: use of undeclared identifier 'BPF_MAP_TYPE_CGRP_STORAGE'; did you mean 'BPF_MAP_TYPE_CGROUP_STORAGE'?
        __uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
                     BPF_MAP_TYPE_CGROUP_STORAGE
/ssd/kernel/fuse-bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                      ^
/ssd/kernel/fuse-bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:27892:2: note: 'BPF_MAP_TYPE_CGROUP_STORAGE' declared here
        BPF_MAP_TYPE_CGROUP_STORAGE = 19,
        ^
1 error generated.

Daniel Rosenberg (3):
  bpf: verifier: Accept dynptr mem as mem in helpers
  bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
  selftests/bpf: Test allowing NULL buffer in dynptr slice

 Documentation/bpf/kfuncs.rst                  | 23 ++++++++++++-
 kernel/bpf/helpers.c                          | 32 ++++++++++++-------
 kernel/bpf/verifier.c                         | 21 ++++++++++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c      | 21 ++++++++++++
 5 files changed, 85 insertions(+), 13 deletions(-)


base-commit: 5af607a861d43ffff830fc1890033e579ec44799
-- 
2.40.0.577.gac1e443424-goog

