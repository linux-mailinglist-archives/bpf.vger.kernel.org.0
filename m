Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF905BD892
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiITABM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 20:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiITABK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 20:01:10 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601A3F1DB;
        Mon, 19 Sep 2022 17:01:08 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id y2so698045qtv.5;
        Mon, 19 Sep 2022 17:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nwuzadTeCdTrpWL1JAnu+9h1o1wtGuXkFbAGc6SY3hg=;
        b=HRT7MpfZFdKGdfqwyFO8hgvLtuTwejtbPvf0ooeJei2cx7YhoKFURoYvkMXmQs78xX
         ae73zggcEIVEptX4ZDFEnIuxWesb2ioQyCMEhKohMYpywrKvaBq7fm2IT3vs05wzo9vl
         ACjsPqFgLuZpXBceOrmxTaVpVk0mzibvchC3rxgzvG2cxFYEFz44wiJZCiI/d52f+VPi
         809uU23PVqgsN+aq2AiTAqcLH3rijlJK9hVjXrDKSuQag5X0XdGQpWWZlwUWcxzk6cIO
         XQdSaBNT3ervZBocbCGno7uWn/GlLjYqvTSwhXSbIogl22NNKknRb4wWnkJ9S4hh5h5X
         Xetg==
X-Gm-Message-State: ACrzQf0KsJj7d88p8EC/pAmoby41As4TJCp19va8sqW/kRn8bELVSG3s
        xT36kLzduaf1nWVsJJqiNpE=
X-Google-Smtp-Source: AMsMyM5mqtyq9cB3Vjofdt3vJTHnVugFyG50FCJPKFziPr2CtIoaN7v0/JyH/AORG5caKlKf5HtP0g==
X-Received: by 2002:a05:622a:15cc:b0:35c:f4ce:bdc8 with SMTP id d12-20020a05622a15cc00b0035cf4cebdc8mr2995184qty.383.1663632066867;
        Mon, 19 Sep 2022 17:01:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::148f])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a12a400b006ce40fbb8f6sm13166244qki.21.2022.09.19.17.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 17:01:06 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     kernel-team@fb.com, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, brho@google.com,
        joshdon@google.com
Subject: [PATCH v6 0/4] bpf: Add user-space-publisher ring buffer map type
Date:   Mon, 19 Sep 2022 19:00:56 -0500
Message-Id: <20220920000100.477320-1-void@manifault.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set defines a new map type, BPF_MAP_TYPE_USER_RINGBUF, which
provides single-user-space-producer / single-kernel-consumer semantics over
a ring buffer.  Along with the new map type, a helper function called
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
v5 -> v6:
- Fixed s/BPF_MAP_TYPE_RINGBUF/BPF_MAP_TYPE_USER_RINGBUF typo in the
  libbpf user ringbuf doxygen header comment for ring_buffer_user__new()
  (Andrii).
- Specify that pointer returned from ring_buffer_user__reserve() and its
  blocking counterpart is 8-byte aligned (Andrii).
- Renamed user_ringbuf__commit() to user_ringbuf_commit(), as it's static
  (Andrii).
- Another slight reworking of user_ring_buffer__reserve_blocking() to
  remove some extraneous nanosecond variables + checking (Andrii).
- Add a final check of user_ring_buffer__reserve() in
  user_ring_buffer__reserve_blocking().
- Moved busy bit lock / unlock logic from __bpf_user_ringbuf_peek() to
  bpf_user_ringbuf_drain() (Andrii).
- -ENOSPC -> -ENODATA for an empty ring buffer in
  __bpf_user_ringbuf_peek() (Andrii).
- Updated BPF_RB_FORCE_WAKEUP to only force a wakeup notification to be
  sent if even if no sample was drained.
- Changed a bit of the wording in the UAPI header for
  bpf_user_ringbuf_drain() to mention the BPF_RB_FORCE_WAKEUP behavior.
- Remove extra space after return in ringbuf_map_poll_user() (Andrii).
- Removed now-extraneous paragraph from the commit summary of patch 2/4
  (Andrii).
v4 -> v5:
- DENYLISTed the user-ringbuf test suite on s390x. We have a number of
  functions in the progs/user_ringbuf_success.c prog that user-space
  fires by invoking a syscall. Not all of these syscalls are available
  on s390x. If and when we add the ability to kick the kernel from
  user-space, or if we end up using iterators for that per Hao's
  suggestion, we could re-enable this test suite on s390x.
- Fixed a few more places that needed ringbuffer -> ring buffer.
v3 -> v4:
- Update BPF_MAX_USER_RINGBUF_SAMPLES to not specify a bit, and instead
  just specify a number of samples. (Andrii)
- Update "ringbuffer" in comments and commit summaries to say "ring
  buffer". (Andrii)
- Return -E2BIG from bpf_user_ringbuf_drain() both when a sample can't
  fit into the ring buffer, and when it can't fit into a dynptr. (Andrii)
- Don't loop over samples in __bpf_user_ringbuf_peek() if a sample was
  discarded. Instead, return -EAGAIN so the caller can deal with it. Also
  updated the caller to detect -EAGAIN and skip over it when iterating.
  (Andrii)
- Removed the heuristic for notifying user-space when a sample is drained,
  causing the ring buffer to no longer be full. This may be useful in the
  future, but is being removed now because it's strictly a heuristic.
- Re-add BPF_RB_FORCE_WAKEUP flag to bpf_user_ringbuf_drain(). (Andrii)
- Remove helper_allocated_dynptr tracker from verifier. (Andrii)
- Add libbpf function header comments to tools/lib/bpf/libbpf.h, so that
  they will be included in rendered libbpf docs. (Andrii)
- Add symbols to a new LIBBPF_1.1.0 section in linker version script,
  rather than including them in LIBBPF_1.0.0. (Andrii)
- Remove libbpf_err() calls from static libbpf functions. (Andrii)
- Check user_ring_buffer_opts instead of ring_buffer_opts in
  user_ring_buffer__new(). (Andrii)
- Avoid an extra if in the hot path in user_ringbuf__commit(). (Andrii)
- Use ENOSPC rather than ENODATA if no space is available in the ring
  buffer. (Andrii)
- Don't round sample size in header to 8, but still round size that is
  reserved and written to 8, and validate positions are multiples of 8
  (Andrii).
- Use nanoseconds for most calculations in
  user_ring_buffer__reserve_blocking(). (Andrii)
- Don't use CHECK() in testcases, instead use ASSERT_*. (Andrii)
- Use SEC("?raw_tp") instead of SEC("?raw_tp/sys_nanosleep") in negative
  test. (Andrii)
- Move test_user_ringbuf.h header to live next to BPF program instead of
  a directory up from both it and the user-space test program. (Andrii)
- Update bpftool help message / docs to also include user_ringbuf.
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
 include/uapi/linux/bpf.h                      |  39 +
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/ringbuf.c                          | 248 +++++-
 kernel/bpf/verifier.c                         |  62 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/include/uapi/linux/bpf.h                |  39 +
 tools/lib/bpf/libbpf.c                        |  11 +-
 tools/lib/bpf/libbpf.h                        | 106 +++
 tools/lib/bpf/libbpf.map                      |  10 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 tools/lib/bpf/ringbuf.c                       | 268 +++++++
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/user_ringbuf.c   | 754 ++++++++++++++++++
 .../selftests/bpf/progs/test_user_ringbuf.h   |  35 +
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 177 ++++
 .../bpf/progs/user_ringbuf_success.c          | 218 +++++
 20 files changed, 1968 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_user_ringbuf.h
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c

-- 
2.37.3
