Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7553458CE23
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiHHS6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 14:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244086AbiHHS6K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 14:58:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C671834C
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 11:58:05 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a2so7178635qkk.2
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aS9foFym22Ym3nm/+GI5NjtfanGnG5x1WdG+Bb6ikDM=;
        b=PA89YVHuM6X5P0brGzVHtsDAdu9/2OQGWnhPAqZ+w5VSyqlTo1Qge/s2W+xS4yGIHN
         pwwTIVogFl80UG00aWWKF/CI/xZ04/qE+I8a2x66IiII4NCsQKPQ+PwdL6K8LjrXphGq
         iJkOI6IoKbQs1JRKdoE2c950ifQUW7rAOQSxi8gf/TJZOTNogbCcSmIH9f1mKxpfXuzX
         5jJsAun27iHR+Mxd2phIF3r8Pkz2XfOnHykMG83cKhq/nd/Zg24mNmXYLksLVFv1eGjt
         M2+UN+rLnv/nmuHxdm298YSzcre1K8fnzM+tL1GTFy2zUwsVEEVA1OuCzXwou75ZZwDa
         M8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aS9foFym22Ym3nm/+GI5NjtfanGnG5x1WdG+Bb6ikDM=;
        b=kzM9YFTYzgGCRKZ3sY/Jeq+gzCKvl8k9pWmGsKF6i3CLWnTwoDhzVlyRsD0u+rOamP
         27wQ+/v46zvN/VObpaOZO9krBE8ZIPxiFe2hXGca6QuloWtEPiny7C8Tzox7KCx62zrd
         AUK7ZCd9A4kaAvQgTvxspBvLbYfaao0J7UJL9r8FWa/DNkMU4DJBAGNXDuaIQG7A3O4p
         02oYxzqPVBUS4JSMwc8S37nAdRZiHSgcI86sP5ZHK0Gy2ouY+7VG8M+7NSp/SpnRJRZS
         DS/PUPmUwxHPTxCR1/qaU1lG9MQ11LzQ/Df3HFwWlIDoiki5/t1PhvaiVK3o/4PIZCpV
         /c7w==
X-Gm-Message-State: ACgBeo1ttpeNIJ3uFl45u6p+TYm9vjK03WdR+MgSthK43ivrHkmmyWpl
        ctfoKGx1ecQldskW8CbwDAER8BKkPI8B4GqGk/zAeg==
X-Google-Smtp-Source: AA6agR6/8L0dlzASGfl5G40giiFvJCP79JS8mXRCVJE7nKMm54hM0Zzv4zCblk4How/h/PYD+X8Q8n6RVXZX5yA7SJI=
X-Received: by 2002:a37:650e:0:b0:6b9:4a21:ebb2 with SMTP id
 z14-20020a37650e000000b006b94a21ebb2mr4884104qkb.669.1659985084560; Mon, 08
 Aug 2022 11:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155248.2475981-1-void@manifault.com>
In-Reply-To: <20220808155248.2475981-1-void@manifault.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 8 Aug 2022 11:57:53 -0700
Message-ID: <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
Subject: Re: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

On Mon, Aug 8, 2022 at 8:52 AM David Vernet <void@manifault.com> wrote:
>
> This patch set defines a new map type, BPF_MAP_TYPE_USER_RINGBUF, which
> provides single-user-space-producer / single-kernel-consumer semantics over
> a ringbuffer.  Along with the new map type, a helper function called
> bpf_user_ringbuf_drain() is added which allows a BPF program to specify a
> callback with the following signature, to which samples are posted by the
> helper:
>
> void (struct bpf_dynptr *dynptr, void *context);
>
> The program can then use the bpf_dynptr_read() or bpf_dynptr_data() helper
> functions to safely read the sample from the dynptr. There are currently no
> helpers available to determine the size of the sample, but one could easily
> be added if required.
>
> On the user-space side, libbpf has been updated to export a new
> 'struct ring_buffer_user' type, along with the following symbols:
>
> struct ring_buffer_user *
> ring_buffer_user__new(int map_fd,
>                       const struct ring_buffer_user_opts *opts);
> void ring_buffer_user__free(struct ring_buffer_user *rb);
> void *ring_buffer_user__reserve(struct ring_buffer_user *rb, uint32_t size);
> void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
>                              int timeout_ms);
> void ring_buffer_user__discard(struct ring_buffer_user *rb, void *sample);
> void ring_buffer_user__submit(struct ring_buffer_user *rb, void *sample);
>
> These symbols are exported for inclusion in libbpf version 1.0.0.
>
> Note that one thing that is not included in this patch-set is the ability
> to kick the kernel from user-space to have it drain messages. The selftests
> included in this patch-set currently just use progs with syscall hooks to
> "kick" the kernel and have it drain samples from a user-producer
> ringbuffer, but being able to kick the kernel using some other mechanism
> that doesn't rely on such hooks would be very useful as well. I'm planning
> on adding this in a future patch-set.
>

This could be done using iters. Basically, you can perform draining in
bpf_iter programs and export iter links as bpffs files. Then to kick
the kernel, you simply just read() the file.

> Signed-off-by: David Vernet <void@manifault.com>
> --
>
> David Vernet (5):
>   bpf: Clear callee saved regs after updating REG0
>   bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
>   bpf: Add bpf_user_ringbuf_drain() helper
>   bpf: Add libbpf logic for user-space ring buffer
>   selftests/bpf: Add selftests validating the user ringbuf
>
>  include/linux/bpf.h                           |   6 +-
>  include/linux/bpf_types.h                     |   1 +
>  include/uapi/linux/bpf.h                      |   9 +
>  kernel/bpf/helpers.c                          |   2 +
>  kernel/bpf/ringbuf.c                          | 232 ++++++-
>  kernel/bpf/verifier.c                         |  73 ++-
>  tools/include/uapi/linux/bpf.h                |   9 +
>  tools/lib/bpf/libbpf.c                        |  11 +-
>  tools/lib/bpf/libbpf.h                        |  19 +
>  tools/lib/bpf/libbpf.map                      |   6 +
>  tools/lib/bpf/libbpf_probes.c                 |   1 +
>  tools/lib/bpf/ringbuf.c                       | 214 +++++++
>  .../selftests/bpf/prog_tests/user_ringbuf.c   | 592 ++++++++++++++++++
>  .../selftests/bpf/progs/user_ringbuf_fail.c   | 174 +++++
>  .../bpf/progs/user_ringbuf_success.c          | 227 +++++++
>  .../testing/selftests/bpf/test_user_ringbuf.h |  28 +
>  16 files changed, 1579 insertions(+), 25 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
>  create mode 100644 tools/testing/selftests/bpf/test_user_ringbuf.h
>
> --
> 2.30.2
>
