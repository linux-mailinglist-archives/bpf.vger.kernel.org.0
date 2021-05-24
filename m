Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572E438F54C
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhEXWDw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbhEXWDw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 18:03:52 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BECC061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:02:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l16so7281826ybf.0
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XVTfiR/BV7KCFF6IxBMeSZIVo9yodlSAeE/YUX/2QY=;
        b=QlVX+9V7hSq/XpK3RdwSty+xIRPteLHjQ/BAh+53MHZ2Ed+zuHYFp/XZSfDqtXNdiX
         O9igYR95Ndsoc3iKrdBoV/VoYsRysqkwv5krqWO16mLHB6AYox6U+x22V/2e7ZlyAGh6
         4UyFoNnkZtLzgmIAp6zxbU0cuZ6iuJBeWw1y5CoShU3NqSmAg2aSNaYZbGJbV3VP5Pfc
         YEQhpOtUYTEL53W/5WMWwuqNIn5dnBKzSCCKtt+Te2f786NXqi5J5bcphW0IsczJNqYk
         jJbcb8yfTUBSB4A+4W3lg4pWxQ/FMjEfwkXIMK3UYmuDpq4nz8Yogd9r7ziPyVLSiQAk
         YGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XVTfiR/BV7KCFF6IxBMeSZIVo9yodlSAeE/YUX/2QY=;
        b=P0QVnSY1noaQF90l6rihR4bo7wTbZZXHceZoKGpPUXhYGtrqg/xXqv8xFFKUP7o9iT
         iEdD+OCHuMacTEYwfm3mFlEbFhSmXPPf3Tv3KQFZd7ePjjpPBPhTYiFTcBjon6aiCQPw
         PDhOWMJnIiwHKE7lXSmbNV3NxDlH//hfq13pFjc09EmLCoWRbl3LTVZKUimuubEvxLzB
         tDszEvTjwmoThblhW+Wv0j8iq4CjwKwR6rw5sJOM9W+k/ANWM63IzKNGMW2VxwTC8P77
         wXwTHT7omPAQj3jntkVwXhGVJ6bElMFlsTbhsEUlJ376cS2OZpmsAHNcJPYGcFZnJPbQ
         dOTQ==
X-Gm-Message-State: AOAM533ZNrTh2vl55+OKE2UPXrjWrbdRlHuuC5RwOFP6EulTyHjA1dGv
        TGOVJjrOoqRgC7L0oNtz7JAXLITOy/s0j+vIzVo=
X-Google-Smtp-Source: ABdhPJxUDevIm2aLCudE/j1RXkjuCkENvfn08nxgwnWhDmmVgIvMc5DsPrGpTjAclNUapp6hQnZHQk8/hAD6dLkRnLI=
X-Received: by 2002:a25:9942:: with SMTP id n2mr39227978ybo.230.1621893741711;
 Mon, 24 May 2021 15:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620763117.git.denis.salopek@sartura.hr>
In-Reply-To: <cover.1620763117.git.denis.salopek@sartura.hr>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 15:02:10 -0700
Message-ID: <CAEf4BzZ1ndGcnprF+zxVPiP2KpxEhbbm86WLjKtxycYgJSUM6Q@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 0/3] Add lookup_and_delete_elem support to BPF
 hash map types
To:     Denis Salopek <denis.salopek@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 2:01 PM Denis Salopek <denis.salopek@sartura.hr> wrote:
>
> This patch series extends the existing bpf_map_lookup_and_delete_elem()
> functionality with 4 more map types:
>  - BPF_MAP_TYPE_HASH,
>  - BPF_MAP_TYPE_PERCPU_HASH,
>  - BPF_MAP_TYPE_LRU_HASH and
>  - BPF_MAP_TYPE_LRU_PERCPU_HASH.
>
> Patch 1 adds most of its functionality and logic as well as
> documentation.
>
> As it was previously limited to only stacks and queues which do not
> support the BPF_F_LOCK flag, patch 2 enables its usage by adding a new
> libbpf API bpf_map_lookup_and_delete_elem_flags() based on the existing
> bpf_map_lookup_elem_flags().
>
> Patch 3 adds selftests for lookup_and_delete_elem().
>
> Changes in patch 1:
> v7: Minor formating nits, add Acked-by.
> v6: Remove unneeded flag check, minor code/format fixes.
> v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
> documentation with this changes.
> v4: Fix the return value for unsupported map types.
> v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> v2: Add functionality for LRU/per-CPU, add test_progs tests.
>
> Changes in patch 2:
> v7: No change.
> v6: Add Acked-by.
> v5: Move to the newest libbpf version (0.4.0).
>
> Changes in patch 3:
> v7: Remove ASSERT_GE macro which is already added in some other commit,
> change ASSERT_OK to ASSERT_OK_PTR, add Acked-by.
> v6: Remove PERCPU macros, add ASSERT_GE macro to test_progs.h, remove
> leftover code.
> v5: Use more appropriate macros. Better check for changed value.
>
> Denis Salopek (3):
>   bpf: add lookup_and_delete_elem support to hashtab
>   bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
>   selftests/bpf: add bpf_lookup_and_delete_elem tests
>
>  include/linux/bpf.h                           |   2 +
>  include/uapi/linux/bpf.h                      |  13 +
>  kernel/bpf/hashtab.c                          |  98 ++++++
>  kernel/bpf/syscall.c                          |  34 ++-
>  tools/include/uapi/linux/bpf.h                |  13 +
>  tools/lib/bpf/bpf.c                           |  13 +
>  tools/lib/bpf/bpf.h                           |   2 +
>  tools/lib/bpf/libbpf.map                      |   1 +
>  .../bpf/prog_tests/lookup_and_delete.c        | 288 ++++++++++++++++++
>  .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>  tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>  tools/testing/selftests/bpf/test_maps.c       |  17 ++
>  12 files changed, 511 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
>
> --
> 2.26.2
>

Patchbot is having a bad day...

Applied to bpf-next, thanks. Fixed up a small merge conflict in libbpf.map.
