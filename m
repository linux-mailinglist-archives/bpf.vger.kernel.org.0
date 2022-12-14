Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587764C167
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 01:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiLNAi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 19:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiLNAiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 19:38:06 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9F25C61
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so40842078ejc.12
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nP1Z5y7tRgnn7Eo63g7D0818Vh1h/F8FMG7Nnb+a8qE=;
        b=n8lGsSdzU8SZbQmYIAu4wab5L7t+osXZVHTI1N2I8yCVvm1vYKw8OguDq3uN4DPlP0
         5ye8Pt3F5So9Di13mJ+kZqsGOy5LrN1fkVRY8dMpWnhTQqQAB4jMLLWReEQML3GcpoL7
         Eqyd6X3TFdKu63Xo37hIQEecAMEfvz3jUaX7Y5+bvCIueDfM/O9f7PXxBJgj9is3F2pZ
         KJuW43shRAopvQ62ageSmCLpniEIZLgXIjTEMLadvSApSWoUWvY9rYzvoJSMJkedcH5O
         ckWEiYG9ON0hTY4EFQ2pZAyMrN+a5YbDNX45pseAEd+MxOLclWAFKw9MNJoCmGrLZlUk
         uFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nP1Z5y7tRgnn7Eo63g7D0818Vh1h/F8FMG7Nnb+a8qE=;
        b=DNhQ8IanhLqJiWCub1f3SVEiGBeDJWEf/XQvnsM7FCpX/jqt+k3DPGB2l4OEuNZi8l
         MZMe5hBlL4N0WYhrq09odS+LE6+pvPpkR2hnFj35cLHhaKYz/81Oe7XSiV56vc2Iqttr
         5DDTDkb+zW3m/vgXaWZr4bs4DMi80XP5ZhMufNi6idsaFeLJD1IdRd1O0qND5TFSrbtA
         I1Hzw71eMMXZQylnwOEnXqqIThqJ4lo2AO5IgPO4uEsptms+qNOryzMTMr2K0NeR7c1+
         OtKq9iA8IR7csXrv5UDU2fz6ZiqnDmS7Q9hfxeHyJJgj0Y0iiRnN9iHoYlVFG5HJk7qF
         q5RA==
X-Gm-Message-State: ANoB5pmemVN8AGkCcL25Uc/8R6VHRuGGpYbYYLzQ2g9S2gFK2hMwE0+V
        7y6d1yE/uLZxlmDZ1scAX1a27esLQHlAHE4Iu2U=
X-Google-Smtp-Source: AA0mqf4NvBZC1ejL+5kgU4sR3eG9AveNDsYKNoMP+QC8uhIQgxsXl4yXVIx5WEGPKIdLeJ1ER2tgB4aQ8LT+9VPWFOU=
X-Received: by 2002:a17:906:3e53:b0:7c1:1f2b:945f with SMTP id
 t19-20020a1709063e5300b007c11f2b945fmr5906524eji.302.1670978111945; Tue, 13
 Dec 2022 16:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20221209135733.28851-1-eddyz87@gmail.com>
In-Reply-To: <20221209135733.28851-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Dec 2022 16:34:59 -0800
Message-ID: <CAEf4BzbUxdxJMZ2Ln+7jD8+kq0hiea-XJU4VY5W06dJ_KWJC3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] stricter register ID checking in regsafe()
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> This patch-set consists of a series of bug fixes for register ID
> tracking in verifier.c:states_equal()/regsafe() functions:
>  - for registers of type PTR_TO_MAP_{KEY,VALUE}, PTR_TO_PACKET[_META]
>    the regsafe() should call check_ids() even if registers are
>    byte-to-byte equal;
>  - states_equal() must maintain idmap that covers all function frames
>    in the state because functions like mark_ptr_or_null_regs() operate
>    on all registers in the state;
>  - regsafe() must compare spin lock ids for PTR_TO_MAP_VALUE registers.
>
> The last point covers issue reported by Kumar Kartikeya Dwivedi in [1],
> I borrowed the test commit from there.
> Note, that there is also an issue with register id tracking for
> scalars described here [2], it would be addressed separately.
>

Awesome set of patches, thanks for working on this! I left a few
comments and suggestions, please take a look, and if they do make
sense, consider sending follow up patches.

Let's really try to use asm() next time for selftests, though.

It would be awesome to somehow automatically move test_verifier's
tests to this test_progs-based embedded assembly way, but that
probably takes some Python hackery (awesome project for some curious
soul, for sure).

Anyways, back to the point I wanted to make. Given you've clearly
thought about all the ID checks a lot, consider checking refsafe()
(not regsafe()!) as well. I think we should do check_ids() there as
well. And you did all the preliminary work with making idmap
persistent across all frames. Just something to improve (and looks
straightforward, unlike many other things you've dealt with recently
;).

Anyways, great work, thanks!

> [1] https://lore.kernel.org/bpf/20221111202719.982118-1-memxor@gmail.com/
> [2] https://lore.kernel.org/bpf/20221128163442.280187-2-eddyz87@gmail.com/
>
> Eduard Zingerman (6):
>   bpf: regsafe() must not skip check_ids()
>   selftests/bpf: test cases for regsafe() bug skipping check_id()
>   bpf: states_equal() must build idmap for all function frames
>   selftests/bpf: verify states_equal() maintains idmap across all frames
>   bpf: use check_ids() for active_lock comparison
>   selftests/bpf: test case for relaxed prunning of active_lock.id
>
> Kumar Kartikeya Dwivedi (1):
>   selftests/bpf: Add pruning test case for bpf_spin_lock
>
>  include/linux/bpf_verifier.h                  |   4 +-
>  kernel/bpf/verifier.c                         |  48 ++++----
>  tools/testing/selftests/bpf/verifier/calls.c  |  82 +++++++++++++
>  .../bpf/verifier/direct_packet_access.c       |  54 +++++++++
>  .../selftests/bpf/verifier/spin_lock.c        | 114 ++++++++++++++++++
>  .../selftests/bpf/verifier/value_or_null.c    |  49 ++++++++
>  6 files changed, 324 insertions(+), 27 deletions(-)
>
> --
> 2.34.1
>
