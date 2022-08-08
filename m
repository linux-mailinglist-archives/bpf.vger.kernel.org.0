Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4F58CB94
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbiHHPxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiHHPxA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:53:00 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA8D8F;
        Mon,  8 Aug 2022 08:52:59 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id 17so6745779qky.8;
        Mon, 08 Aug 2022 08:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=gIMeQqTxtshFeA9h8v+qBpYkzXb4o0KGIg6z7z9V00M=;
        b=DKDxhcBQX5VrwI8FFNN5NYRjKyVVh54mcKewaJVKh2ikdchBJBLLlQ+nhtXEBaCOx7
         VyZWUpcmyUAbQKFxJCgLk7p9XzYE6BHIhWlh5kBohjbN79EOcXQarbEcHUhe/PpIq82R
         8EacxGU1pJXcNxaYgaXI7q7r82TFdjqzzKB2MDDHXix9lPJ0Eq9oixVewviQBy++qH3d
         FN4o0dLeV2UJVczYhnsoDOm/+7X1W158uGOrq6OWcQ/j/0hcsV9cLI7uf6mVuC2hcf59
         KIHROdE0mY1ZJiIX3KC/8tLwov9W7SnYAz2HzvkK2bvxZterMI1jYpUBhGyYinxo0A4l
         0C+g==
X-Gm-Message-State: ACgBeo0Q+7wytxFd0LSTyjBb6W9kQ7VkTyOAmlrrsCcq6o9B3+Ypf1XT
        AOzOTxBoOvRarAbRVeDk/y8cdq3ouZaSwQ==
X-Google-Smtp-Source: AA6agR6BMGU4ySAPY6pbbekaFaL3Qs4yrveyBD9hbrlQkHAUgEeouW1l86QjIC2cmH35phm2HSt5yw==
X-Received: by 2002:ae9:f309:0:b0:6b5:bf22:f2e7 with SMTP id p9-20020ae9f309000000b006b5bf22f2e7mr14677973qkg.509.1659973978160;
        Mon, 08 Aug 2022 08:52:58 -0700 (PDT)
Received: from localhost (fwdproxy-ash-016.fbsv.net. [2a03:2880:20ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a0f1200b006b60f5f53ccsm9891261qkl.25.2022.08.08.08.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:52:57 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
Date:   Mon,  8 Aug 2022 08:52:43 -0700
Message-Id: <20220808155248.2475981-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set defines a new map type, BPF_MAP_TYPE_USER_RINGBUF, which
provides single-user-space-producer / single-kernel-consumer semantics over
a ringbuffer.  Along with the new map type, a helper function called
bpf_user_ringbuf_drain() is added which allows a BPF program to specify a
callback with the following signature, to which samples are posted by the
helper:

void (struct bpf_dynptr *dynptr, void *context);

The program can then use the bpf_dynptr_read() or bpf_dynptr_data() helper
functions to safely read the sample from the dynptr. There are currently no
helpers available to determine the size of the sample, but one could easily
be added if required.

On the user-space side, libbpf has been updated to export a new
'struct ring_buffer_user' type, along with the following symbols:

struct ring_buffer_user *
ring_buffer_user__new(int map_fd,
                      const struct ring_buffer_user_opts *opts);
void ring_buffer_user__free(struct ring_buffer_user *rb);
void *ring_buffer_user__reserve(struct ring_buffer_user *rb, uint32_t size);
void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
			     int timeout_ms);
void ring_buffer_user__discard(struct ring_buffer_user *rb, void *sample);
void ring_buffer_user__submit(struct ring_buffer_user *rb, void *sample);

These symbols are exported for inclusion in libbpf version 1.0.0.

Note that one thing that is not included in this patch-set is the ability
to kick the kernel from user-space to have it drain messages. The selftests
included in this patch-set currently just use progs with syscall hooks to
"kick" the kernel and have it drain samples from a user-producer
ringbuffer, but being able to kick the kernel using some other mechanism
that doesn't rely on such hooks would be very useful as well. I'm planning
on adding this in a future patch-set.

Signed-off-by: David Vernet <void@manifault.com>
--

David Vernet (5):
  bpf: Clear callee saved regs after updating REG0
  bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
  bpf: Add bpf_user_ringbuf_drain() helper
  bpf: Add libbpf logic for user-space ring buffer
  selftests/bpf: Add selftests validating the user ringbuf

 include/linux/bpf.h                           |   6 +-
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   9 +
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/ringbuf.c                          | 232 ++++++-
 kernel/bpf/verifier.c                         |  73 ++-
 tools/include/uapi/linux/bpf.h                |   9 +
 tools/lib/bpf/libbpf.c                        |  11 +-
 tools/lib/bpf/libbpf.h                        |  19 +
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/lib/bpf/ringbuf.c                       | 214 +++++++
 .../selftests/bpf/prog_tests/user_ringbuf.c   | 592 ++++++++++++++++++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 174 +++++
 .../bpf/progs/user_ringbuf_success.c          | 227 +++++++
 .../testing/selftests/bpf/test_user_ringbuf.h |  28 +
 16 files changed, 1579 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
 create mode 100644 tools/testing/selftests/bpf/test_user_ringbuf.h

-- 
2.30.2

