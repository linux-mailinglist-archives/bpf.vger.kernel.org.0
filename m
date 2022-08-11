Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6159094E
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 01:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiHKXt5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 19:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHKXt4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 19:49:56 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08B9C8D5;
        Thu, 11 Aug 2022 16:49:55 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id h22so9255204qtu.2;
        Thu, 11 Aug 2022 16:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4/KjfZ47/vEC5Vh9INtWzHkArTxaktEznu8FJHOXlP8=;
        b=vJqwF0a0CCG8eq83dyljzIdLOSG95qqVYjPJgBkvR+fF81MaFjj7Jgv54cTRxjg4KY
         VNYiQN1ALvFhAuz/9q5fMPH8ixms7GRqOWPjbXo5s47N0KMaS3ahWVRDZRAUuPkLX0aY
         +wx/a1P2MCRr/IhECO8vjpxMtUUJ8UQ5/CSfUG06C3t5+Cef+uz4apdceZjRi/J2NZCb
         H2YHJ6NJFPjw2IDI3Nlr4ANnH96fYeWiOu0A1NloKnnxSUYsmvyncU84K5YZVBiGY/WG
         Oa15XFpkNC5kvMDiZ4G0PNZor20SrorwDzKwiaLGhoKAIYMDovHpuaNdtfParg+cpriC
         3mOA==
X-Gm-Message-State: ACgBeo2YtZNXnXLcZzWrf7QgToSaDHwyBrrT6CXWzWGJCQ7HBlFyxidI
        1F4WI4efFCtnz4xpOGJA9uBQonfbWToFvzpC
X-Google-Smtp-Source: AA6agR7lD7u1653mNKJ9Vt+9dxuOSbfI5K0CqFhCEpzlGI1Q2A8/elmioK2SB+ipGO4JVPx8yL+dUw==
X-Received: by 2002:a05:622a:174e:b0:343:202:4e55 with SMTP id l14-20020a05622a174e00b0034302024e55mr1478321qtk.81.1660261794425;
        Thu, 11 Aug 2022 16:49:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::bfe0])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a28c100b006b935e96f0bsm519187qkp.12.2022.08.11.16.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:49:54 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     haoluo@google.com, joannelkoong@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com, tj@kernel.org
Subject: [PATCH v2 0/4] bpf: Add user-space-publisher ringbuffer map type
Date:   Thu, 11 Aug 2022 18:49:37 -0500
Message-Id: <20220811234941.887747-1-void@manifault.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Note that one thing that is not included in this patch-set is the
ability to kick the kernel from user-space to have it drain messages.
The selftests included in this patch-set currently just use progs with
syscall hooks to "kick" the kernel and have it drain samples from a
user-producer ringbuffer, but being able to kick the kernel using some
other mechanism that doesn't rely on such hooks would be very useful as
well. The intention is for this to be separate from BPF iters, which are
meant for extracting data from the kernel. This would be a method for
driving logic in BPF from user-space, for example, to run a callback
(possibly with data) for each sample that's published to a BPF program
from user-space. I'm planning on adding this in a future patch-set.

Signed-off-by: David Vernet <void@manifault.com>
--
v1 -> v2:
- Following Joanne landing 883743422ced ("bpf: Fix ref_obj_id for dynptr
  data slices in verifier") [0], removed [PATCH 1/5] bpf: Clear callee
  saved regs after updating REG0 [1].
- Following the above adjustment, updated check_helper_call() to not store
  a reference for bpf_dynptr_data() if the register containing the dynptr
  is of type MEM_ALLOC.
- Fixed casting issue pointed out by kernel test robot by adding a missing
  (uintptr_t) cast.

[0] https://lore.kernel.org/all/20220809214055.4050604-1-joannelkoong@gmail.com/
[1] https://lore.kernel.org/all/20220808155341.2479054-1-void@manifault.com/

David Vernet (4):
  bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
  bpf: Add bpf_user_ringbuf_drain() helper
  bpf: Add libbpf logic for user-space ring buffer
  selftests/bpf: Add selftests validating the user ringbuf

 include/linux/bpf.h                           |   6 +-
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/ringbuf.c                          | 232 ++++++-
 kernel/bpf/verifier.c                         |  59 +-
 tools/include/uapi/linux/bpf.h                |   8 +
 tools/lib/bpf/libbpf.c                        |  11 +-
 tools/lib/bpf/libbpf.h                        |  19 +
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/lib/bpf/ringbuf.c                       | 216 +++++++
 .../selftests/bpf/prog_tests/user_ringbuf.c   | 587 ++++++++++++++++++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 174 ++++++
 .../bpf/progs/user_ringbuf_success.c          | 220 +++++++
 .../testing/selftests/bpf/test_user_ringbuf.h |  35 ++
 16 files changed, 1566 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
 create mode 100644 tools/testing/selftests/bpf/test_user_ringbuf.h

-- 
2.37.1

