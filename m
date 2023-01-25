Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA967B4F0
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjAYOkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 09:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjAYOkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 09:40:13 -0500
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB8AD26;
        Wed, 25 Jan 2023 06:39:43 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id bs10so808241vkb.3;
        Wed, 25 Jan 2023 06:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTz9rWTHtKZ1MdagbfZKTdu+fe8rzlCpxSijJtcJzkk=;
        b=sOx2rbh4oRY0P4EHsc5JL1CJiYSdmewGbIH4RolKwqTNje3tWC3ZDz29yxj0l9U6hP
         MHOlhyJOk3d5RW8NUzwqs+jVskxr6S3cKGaarjsC8zKNPgxeyxVs+GYbexdeoKqb3Pcw
         PBh2BqH3Sa2eU6W8leuiiAnKpS/zCfN92j9evmPKvxZvo8+uDwkus/AoHUFesJ9F+u37
         mWlaUBakN0S9Uf/0dQj+O8DNyXTAMiwRUFai7KMmacMvTRkdAR7GdiGfLsPwN3XbFFDT
         xl8uogURJh/mL2w7Dh9Z6PZ4nvPOZSUIZ9qw8MHC2WO+OUdwi6zWjmMbagDl+v6FvBNi
         RFCw==
X-Gm-Message-State: AO0yUKVpNTca5jDxzNeZNxjZ99hL0c22t+787sV1+6KT6izOwv9A17EA
        W16ERvZkDNt4UwfJpZ8SKAHOlNWVGM/r0jHv
X-Google-Smtp-Source: AK7set/gkd3DVIrE6Rsx4XnhoZWQZgWwqmAMrmHL5F3BTvWzk9h4MYMvW3FAlzh2jbQEJt+oUK5IHw==
X-Received: by 2002:a05:6122:1690:b0:3e3:44e3:3d97 with SMTP id 16-20020a056122169000b003e344e33d97mr2713395vkl.14.1674657498506;
        Wed, 25 Jan 2023 06:38:18 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id e127-20020a376985000000b006f9ddaaf01esm3537783qkc.102.2023.01.25.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:38:18 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v3 0/7] Enable cpumasks to be used as kptrs
Date:   Wed, 25 Jan 2023 08:38:09 -0600
Message-Id: <20230125143816.721952-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is part 3 of https://lore.kernel.org/all/20230119235833.2948341-1-void@manifault.com/

Part 2: https://lore.kernel.org/bpf/20230120192523.3650503-1-void@manifault.com/

This series is based off of commit b613d335a743 ("bpf: Allow trusted
args to walk struct when checking BTF IDs").

Changelog:
----------
v2 -> v3:
- Rebase onto master (commit described above). Only conflict that
  required resolution was updating the task_kfunc selftest suite error
  message location.
- Put copyright onto one line in kernel/bpf/cpumask.c.
- Remove now-unneeded pid-checking logic from
  progs/nested_trust_success.c.
- Fix a couple of small grammatical typos in documentation.

v1 -> v2:
- Put back 'static' keyword in bpf_find_btf_id()
  (kernel test robot <lkp@intel.com>)
- Surround cpumask kfuncs in __diag() blocks to avoid no-prototype build
  warnings (kernel test robot <lkp@intel.com>)
- Enable ___init suffixes to a type definition to signal that a type is
  a nocast alias of another type. That is, that when passed to a kfunc
  that expects one of the two types, the verifier will reject the other
  even if they're equivalent according to the C standard (Kumar and
  Alexei)
- Reject NULL for all trusted args, not just PTR_TO_MEM (Kumar)
- Reject both NULL and PTR_MAYBE_NULL for all trusted args (Kumar and
  Alexei )
- Improve examples given in cpumask documentation (Alexei)
- Use __success macro for nested_trust test (Alexei)
- Fix comment typo in struct bpf_cpumask comment header.
- Fix another example in the bpf_cpumask doc examples.
- Add documentation for ___init suffix change mentioned above.


David Vernet (7):
  bpf: Disallow NULLable pointers for trusted kfuncs
  bpf: Enable cpumasks to be queried and used as kptrs
  selftests/bpf: Add nested trust selftests suite
  selftests/bpf: Add selftest suite for cpumask kfuncs
  bpf/docs: Document cpumask kfuncs in a new file
  bpf/docs: Document how nested trusted fields may be defined
  bpf/docs: Document the nocast aliasing behavior of ___init

 Documentation/bpf/cpumasks.rst                | 393 +++++++++++++++
 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/kfuncs.rst                  |  76 ++-
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/cpumask.c                          | 476 ++++++++++++++++++
 kernel/bpf/verifier.c                         |   6 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   2 +
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     |   4 +-
 .../selftests/bpf/prog_tests/cpumask.c        |  74 +++
 .../selftests/bpf/prog_tests/nested_trust.c   |  12 +
 .../selftests/bpf/progs/cpumask_common.h      | 114 +++++
 .../selftests/bpf/progs/cpumask_failure.c     | 126 +++++
 .../selftests/bpf/progs/cpumask_success.c     | 426 ++++++++++++++++
 .../selftests/bpf/progs/nested_trust_common.h |  12 +
 .../bpf/progs/nested_trust_failure.c          |  33 ++
 .../bpf/progs/nested_trust_success.c          |  19 +
 .../selftests/bpf/progs/task_kfunc_failure.c  |   4 +-
 17 files changed, 1774 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/bpf/cpumasks.rst
 create mode 100644 kernel/bpf/cpumask.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/nested_trust.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_success.c

-- 
2.39.0

