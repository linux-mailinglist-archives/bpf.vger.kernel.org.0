Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF98C6BF726
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 02:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCRBNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRBNu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 21:13:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB2AA9DC0
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:13:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a2so7126633plm.4
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679102028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+7VztUwRIILs44CCAU7q/yiASeO+Xdlqi48SoRxgRU=;
        b=JNJz7uXIKS86mRbUqoOF4oRSVrUK+vI84X4YgnmW+4s3sAlK3DqjwxpdO1dGwuEid1
         HwnaZFu7bLyv/N2VuOVCFsKr489F5/VPCPLq1N9qLLMzVMbPnILkty8MKPH4p+0OsubD
         AZf4mxopIJvhKSFzXn4NLbdMeuiBcY9xHHqWJCxin21wtgK1jcVvBod9nlYSzM+S/I+x
         04VojysuP0qwZAG3de7MHfVZ9GSsb/cZzizywpfMFPXaWLL6jYYA+MzH/aCwa77p3woP
         hoq3SozNBngA5Ln2lxBh05aJKQEZHDQuLz7B2UVc/nLB/7CJT2ybnqzB9TvjLiddSTzV
         yFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679102028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+7VztUwRIILs44CCAU7q/yiASeO+Xdlqi48SoRxgRU=;
        b=f1oyWfRA35xT6udZ/OjEfYr8nG0GT1K339aTeB4aGO0WESEMTb6LZMLWSHnedhcEP6
         XeoJz/OcxnwwKPov52qVYTLRgJbzSwV+2IZMQ3atzIkyNjLUC98wRsAT8ZNY93ijGEN5
         jczepIyODrTZjYjLEri/RlLrwFVdce2EG6hgxPTuGaURDf1OLAv/hK2JjAChXaJao3/7
         uxgjpbFkK/5dhxTTFu8mhlun3mx67SDzxqlERjHaOjHZqwcgRaYFioBZyqCWA3n/helw
         vuXeZDUmMo/0TI0uYDCdj0S22vxZXyfKMIWN+yeucIiRfCkazyJ4ZI2hWKYMZCReySVH
         BCqw==
X-Gm-Message-State: AO0yUKV2pmm1+b6Td6IjcpXzLkdVfrs+LbB0QS9ZpuIfN+affYcVfquD
        uAHNgsnnpQ3Vo9RYR0ZTy9q1G3ORLUg=
X-Google-Smtp-Source: AK7set8AF1r73uAPvVIad6EWjm4hY/CA6pVNMylvVAvOaQdiRtgB7tWhKEBBj854UA30LktzAS5bZw==
X-Received: by 2002:a17:90b:3a8f:b0:23f:63d5:c10f with SMTP id om15-20020a17090b3a8f00b0023f63d5c10fmr3430468pjb.25.1679102027698;
        Fri, 17 Mar 2023 18:13:47 -0700 (PDT)
Received: from localhost.localdomain ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090ad3d500b002309279baf8sm5483549pjw.43.2023.03.17.18.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 18:13:46 -0700 (PDT)
From:   inwardvessel <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, yhs@meta.com,
        ast@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com
Subject: [PATCH bpf-next 0/2] error checking where helpers call bpf_map_ops
Date:   Fri, 17 Mar 2023 18:13:22 -0700
Message-Id: <20230318011324.203830-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: JP Kobryn <inwardvessel@gmail.com>

Within bpf programs, the bpf helper functions can make inline calls to
kernel functions. In this scenario there can be a disconnect between the
register the kernel function writes a return value to and the register the
bpf program uses to evaluate that return value.

As an example, this bpf code:

long err = bpf_map_update_elem(...);
if (err && err != -EEXIST)
	// got some error other than -EEXIST

...can result in the bpf assembly:

; err = bpf_map_update_elem(&mymap, &key, &val, BPF_NOEXIST);
  37:	movabs $0xffff976a10730400,%rdi
  41:	mov    $0x1,%ecx
  46:	call   0xffffffffe103291c	; htab_map_update_elem
; if (err && err != -EEXIST) {
  4b:	cmp    $0xffffffffffffffef,%rax ; cmp -EEXIST,%rax
  4f:	je     0x000000000000008e
  51:	test   %rax,%rax
  54:	je     0x000000000000008e

The compare operation here evaluates %rax, while in the preceding call to 
htab_map_update_elem the corresponding assembly returns -EEXIST via %eax:

movl $0xffffffef, %r9d
...
movl %r9d, %eax

...since it's returning int (32-bit). So the resulting comparison becomes:

cmp $0xffffffffffffffef, $0x00000000ffffffef

...making it not possible to check for negative errors or specific errors,
since the sign value is left at the 32nd bit. It means in the original
example, the conditional branch will be entered even when the error is
-EEXIST, which was not intended.

The selftests added cover these cases for the different bpf_map_ops
functions. When the second patch is applied, changing the return type of
those functions to long, the comparison works as intended and the tests
pass.

JP Kobryn (2):
  bpf/selftests: coverage for bpf_map_ops errors
  bpf: return long from bpf_map_ops funcs

 include/linux/bpf.h                           |  10 +-
 kernel/bpf/arraymap.c                         |   8 +-
 kernel/bpf/bloom_filter.c                     |  12 +-
 kernel/bpf/bpf_cgrp_storage.c                 |   6 +-
 kernel/bpf/bpf_inode_storage.c                |   6 +-
 kernel/bpf/bpf_struct_ops.c                   |   6 +-
 kernel/bpf/bpf_task_storage.c                 |   6 +-
 kernel/bpf/cpumap.c                           |   6 +-
 kernel/bpf/devmap.c                           |  20 +--
 kernel/bpf/hashtab.c                          |  32 ++---
 kernel/bpf/local_storage.c                    |   6 +-
 kernel/bpf/lpm_trie.c                         |   6 +-
 kernel/bpf/queue_stack_maps.c                 |  22 +--
 kernel/bpf/reuseport_array.c                  |   2 +-
 kernel/bpf/ringbuf.c                          |   6 +-
 kernel/bpf/stackmap.c                         |   6 +-
 kernel/bpf/verifier.c                         |  10 +-
 net/core/bpf_sk_storage.c                     |   6 +-
 net/core/sock_map.c                           |   8 +-
 net/xdp/xskmap.c                              |   6 +-
 .../selftests/bpf/prog_tests/map_ops.c        | 130 ++++++++++++++++++
 .../selftests/bpf/progs/test_map_ops.c        |  90 ++++++++++++
 22 files changed, 315 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_ops.c

-- 
2.39.2

