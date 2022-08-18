Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3459904A
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbiHRWMi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 18:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345993AbiHRWMh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 18:12:37 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD6D293D;
        Thu, 18 Aug 2022 15:12:36 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id c20so2187260qtw.8;
        Thu, 18 Aug 2022 15:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=I26lls4Mfb612F+KzYc+ZI6gC3kbPTGpUHBaWUGVe4w=;
        b=mu+ApUjthwBByM/LuGotVMyw6AvVcC08Q/6IFFhzXzwRf0Yadxt1/rNkyPGr9XhpL6
         sMn0EkY7FQahlcw/jjisab0SYuUkoUuD4CR4/JgFQxmjGqvB/v7q3OVc0w5Duxe5ztnC
         H2L0TEIauVo5XYmTDpnBgv7v52v+uqdPcKc7mD3xdQSFt545muqNd/jXS4aM9/Ec//kj
         SQdDnrnV97wbIAVdguEVE3r+RwMSUdBDciDtLa4WDEPIZyuyDPKkMOWRR8gqDCeOvTtI
         q1UJT742Wg3UGemQzevVV9BwLbmFVL6Sb8YqS4JoQ1GhoqZtv/YPmuzhE7jAAlT1BS/b
         81OQ==
X-Gm-Message-State: ACgBeo08zuh2P78KJXVyEyRYbJVf18SbQ5SJg4QCxkWvI3jLpMMnEizm
        nLlgPyqHnhdnH0+AKv09OPvOzuCI9MRnbQ6z
X-Google-Smtp-Source: AA6agR5ApjN02LMDIT3XJ6+ssuYeH3FM05pgbSvy39YdeDqnO8Z8AebSEaGKT1mhY6c2hGi+fhkinA==
X-Received: by 2002:a05:622a:14c8:b0:342:f7fe:ab33 with SMTP id u8-20020a05622a14c800b00342f7feab33mr4463639qtx.327.1660860755184;
        Thu, 18 Aug 2022 15:12:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::70d6])
        by smtp.gmail.com with ESMTPSA id f3-20020ac80683000000b00339163a06fcsm1827952qth.6.2022.08.18.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:12:34 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     kernel-team@fb.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        joannelkoong@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] bpf: Add user-space-publisher ringbuffer map type
Date:   Thu, 18 Aug 2022 17:12:09 -0500
Message-Id: <20220818221212.464487-1-void@manifault.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
void *ring_buffer_user__reserve(struct ring_buffer_user *rb,
				uint32_t size);
void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
			     int timeout_ms);
void ring_buffer_user__discard(struct ring_buffer_user *rb, void *sample);
void ring_buffer_user__submit(struct ring_buffer_user *rb, void *sample);

These symbols are exported for inclusion in libbpf version 1.0.0.

Signed-off-by: David Vernet <void@manifault.com>
--
v2 -> v3:
- Lots of formatting fixes, such as keeping things on one line if they fit
  within 100 characters, and removing some extraneous newlines. Applies
  to all diffs in the patch-set. (Andrii)
- Renamed ring_buffer_user__* symbols to user_ring_buffer__*. (Andrii)
- Added a missing smb_mb__before_atomic() in
  __bpf_user_ringbuf_sample_release(). (Hao)
- Restructure how and when notification events are sent from the kernel to
  the user-space producers via the .map_poll() callback for the
  BPF_MAP_TYPE_USER_RINGBUF map. Before, we only sent a notification when
  the ringbuffer was fully drained. Now, we guarantee user-space that
  we'll send an event at least once per bpf_user_ringbuf_drain(), as long
  as at least one sample was drained, and BPF_RB_NO_WAKEUP was not passed.
  As a heuristic, we also send a notification event any time a sample being
  drained causes the ringbuffer to no longer be full. (Andrii)
- Continuing on the above point, updated
  user_ring_buffer__reserve_blocking() to loop around epoll_wait() until a
  sufficiently large sample is found. (Andrii)
- Communicate BPF_RINGBUF_BUSY_BIT and BPF_RINGBUF_DISCARD_BIT in sample
  headers. The ringbuffer implementation still only supports
  single-producer semantics, but we can now add synchronization support in
  user_ring_buffer__reserve(), and will automatically get multi-producer
  semantics. (Andrii)
- Updated some commit summaries, specifically adding more details where
  warranted. (Andrii)
- Improved function documentation for bpf_user_ringbuf_drain(), more
  clearly explaining all function arguments and return types, as well as
  the semantics for waking up user-space producers.
- Add function header comments for user_ring_buffer__reserve{_blocking}().
  (Andrii)
- Rounding-up all samples to 8-bytes in the user-space producer, and
  enforcing that all samples are properly aligned in the kernel. (Andrii)
- Added testcases that verify that bpf_user_ringbuf_drain() properly
  validates samples, and returns error conditions if any invalid samples
  are encountered. (Andrii)
- Move atomic_t busy field out of the consumer page, and into the
  struct bpf_ringbuf. (Andrii)
- Split ringbuf_map_{mmap, poll}_{kern, user}() into separate
  implementations. (Andrii)
- Don't silently consume errors in bpf_user_ringbuf_drain(). (Andrii)
- Remove magic number of samples (4096) from bpf_user_ringbuf_drain(),
  and instead use BPF_MAX_USER_RINGBUF_SAMPLES macro, which allows
  128k samples. (Andrii)
- Remove MEM_ALLOC modifier from PTR_TO_DYNPTR register in verifier, and
  instead rely solely on the register being PTR_TO_DYNPTR. (Andrii)
- Move freeing of atomic_t busy bit to before we invoke irq_work_queue() in
  __bpf_user_ringbuf_sample_release(). (Andrii)
- Only check for BPF_RB_NO_WAKEUP flag in bpf_ringbuf_drain().
- Remove libbpf function names from kernel smp_{load, store}* comments in
  the kernel. (Andrii)
- Don't use double-underscore naming convention in libbpf functions.
  (Andrii)
- Use proper __u32 and __u64 for types where we need to guarantee their
  size. (Andrii)

v1 -> v2:
- Following Joanne landing 883743422ced ("bpf: Fix ref_obj_id for dynptr
  data slices in verifier") [0], removed [PATCH 1/5] bpf: Clear callee
  saved regs after updating REG0 [1]. (Joanne)
- Following the above adjustment, updated check_helper_call() to not store
  a reference for bpf_dynptr_data() if the register containing the dynptr
  is of type MEM_ALLOC. (Joanne)
- Fixed casting issue pointed out by kernel test robot by adding a missing
  (uintptr_t) cast. (lkp)

[0] https://lore.kernel.org/all/20220809214055.4050604-1-joannelkoong@gmail.com/
[1] https://lore.kernel.org/all/20220808155341.2479054-1-void@manifault.com/

David Vernet (4):
  bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
  bpf: Add bpf_user_ringbuf_drain() helper
  bpf: Add libbpf logic for user-space ring buffer
  selftests/bpf: Add selftests validating the user ringbuf

 include/linux/bpf.h                           |  11 +-
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  37 +
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/ringbuf.c                          | 272 ++++++-
 kernel/bpf/verifier.c                         |  73 +-
 tools/include/uapi/linux/bpf.h                |  37 +
 tools/lib/bpf/libbpf.c                        |  11 +-
 tools/lib/bpf/libbpf.h                        |  21 +
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/lib/bpf/ringbuf.c                       | 327 ++++++++
 .../selftests/bpf/prog_tests/user_ringbuf.c   | 715 ++++++++++++++++++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 177 +++++
 .../bpf/progs/user_ringbuf_success.c          | 220 ++++++
 .../testing/selftests/bpf/test_user_ringbuf.h |  35 +
 16 files changed, 1924 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
 create mode 100644 tools/testing/selftests/bpf/test_user_ringbuf.h

-- 
2.37.1

