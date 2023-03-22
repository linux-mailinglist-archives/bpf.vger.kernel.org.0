Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47336C552B
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 20:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCVTsa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVTs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 15:48:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8CBB470
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:48:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kq3so7874644plb.13
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679514508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTXQhon6Bpstc1RbzgguFOLJugrD7Uz5eaDl9kxx9nE=;
        b=PghKs3FNZ/SpWKrA+rqDJVQ6iDKDley3f83yGlNMFhl33sPRDn0zS+8iBiB0QEhxCn
         TCqDkybdI0Yocg4NODc/1mbQ2rx1E+TGtslT5Wow+dRiVrYuUflHOwgNZFB2+B0qaXgx
         DYpRo3gnzOnr7uPmlO2SnWz1NP6uE63l28ApetMNLEHUZOI7gCL5gWNKodWzRLM2CxVI
         j6xpBrRfP3kdsYI2SGzbLZhszlWrGqWOuN5juWvdTQZSMc0WlKJkxQPeM8NYXn7rzXZK
         eq01yavDF4I6Qaz9yKeL4G4qW+4AUtW2welDyf/8OUDJihkJLVJ1TYudeWCyF7WIohSs
         59tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTXQhon6Bpstc1RbzgguFOLJugrD7Uz5eaDl9kxx9nE=;
        b=0vo18NDvlJrkUQJugmBpK2luXVmn94HN2d1Gum1kzUBnDjfLbjWncFP4aLxicIMWXY
         Ct87AO+uDHZWXL+ajCqieFU5LPctsQ/FTW6nhv3eBgNfjogBZNeS4efKFHQH8reY6DVK
         GXchi0IITIHULkAn1GRBNKWOzmmdoWaSa8G2RIXw4Elq+CX6Mt7q6vCll/KB2Jmh/uCO
         fzcIpPnsnru6IETFj5cRCStWCXA6LOWp+HHkC2fDNWjT9Z73P6fXZ0mfeL+yUgjDAP6y
         bWYg6mEM2BQsRCh+5V0lnCQ34OAd/aKGYkqgJyfY2z2AtM66pRZw9i52ROQCZqSm1Q47
         nwhg==
X-Gm-Message-State: AO0yUKWMdj9+7mmE6vDy+DhJ1X0duS6/ogOErjEK/OgA77rzgIHV11Dv
        ZGandLvGf2M/pOIa2O04ZiNbquR632c=
X-Google-Smtp-Source: AK7set/qMxKFRqJ3RTFBW2UveW5+m7YZ2CltwUrDi3CfqmfCYvBGPdujwi3+jOj3A1oqACh8lqfZVg==
X-Received: by 2002:a17:902:d50d:b0:1a1:cc0c:a5c0 with SMTP id b13-20020a170902d50d00b001a1cc0ca5c0mr4926605plg.63.1679514508434;
        Wed, 22 Mar 2023 12:48:28 -0700 (PDT)
Received: from localhost.localdomain ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b0019c93ee6902sm10939946plh.109.2023.03.22.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:48:28 -0700 (PDT)
From:   JP Kobryn <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, yhs@meta.com,
        ast@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com
Subject: [PATCH v2 bpf-next 0/2] error checking where helpers call bpf_map_ops
Date:   Wed, 22 Mar 2023 12:47:52 -0700
Message-Id: <20230322194754.185781-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
htab_map_update_elem the corresponding assembly returns -EEXIST via %eax
(the lower 32 bits of %rax):

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

 include/linux/bpf.h                           |  14 +-
 include/linux/filter.h                        |   6 +-
 kernel/bpf/arraymap.c                         |  12 +-
 kernel/bpf/bloom_filter.c                     |  12 +-
 kernel/bpf/bpf_cgrp_storage.c                 |   6 +-
 kernel/bpf/bpf_inode_storage.c                |   6 +-
 kernel/bpf/bpf_struct_ops.c                   |   6 +-
 kernel/bpf/bpf_task_storage.c                 |   6 +-
 kernel/bpf/cpumap.c                           |   8 +-
 kernel/bpf/devmap.c                           |  24 +--
 kernel/bpf/hashtab.c                          |  36 ++--
 kernel/bpf/local_storage.c                    |   6 +-
 kernel/bpf/lpm_trie.c                         |   6 +-
 kernel/bpf/queue_stack_maps.c                 |  22 +--
 kernel/bpf/reuseport_array.c                  |   2 +-
 kernel/bpf/ringbuf.c                          |   6 +-
 kernel/bpf/stackmap.c                         |   6 +-
 kernel/bpf/verifier.c                         |  14 +-
 net/core/bpf_sk_storage.c                     |   6 +-
 net/core/sock_map.c                           |   8 +-
 net/xdp/xskmap.c                              |   8 +-
 .../selftests/bpf/prog_tests/map_ops.c        | 162 ++++++++++++++++++
 .../selftests/bpf/progs/test_map_ops.c        | 138 +++++++++++++++
 23 files changed, 410 insertions(+), 110 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_ops.c

-- 
2.39.2

