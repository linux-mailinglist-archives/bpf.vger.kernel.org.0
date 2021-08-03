Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B599B3DF660
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhHCU1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Aug 2021 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhHCU1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Aug 2021 16:27:51 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7AEC061757
        for <bpf@vger.kernel.org>; Tue,  3 Aug 2021 13:27:39 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id m193so649976ybf.9
        for <bpf@vger.kernel.org>; Tue, 03 Aug 2021 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGFN8ZFjf6ViU9kn6KVvxu+wGrz/prTY4VTXhYC8rvw=;
        b=aWU3WVWChhUTckvJQUEmAR9zD9kAZHJ04uimEsYktD1t1Tcwgc+Gvq6LwMPWS7F0IG
         D/6oppE5zkr2ghDtVEAVCBak2aTp0MP/lS6CHTPQPeNMg/fbMwHiX7f2s3RfyjPkoFGZ
         JEfOd5bOWapgfB55H1d6VIjlxlTWQ5b9icE6zYTzNjmJzRZKEbpp2E7jFrbp3LCrCd9o
         TK62PnUECp60nD6vPijxROYKLQK9/OPZdV4G7sz128ObcsZ3r9ujQDWxeSZs78DEX6us
         di/PEU1wAaL2eY8yBihaQ/G2Ir0M67qbNq2x7TSFTykwFCZYYCBLkO5yJGq7bKrnnEcn
         y18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGFN8ZFjf6ViU9kn6KVvxu+wGrz/prTY4VTXhYC8rvw=;
        b=VG7fRfNrsrvpCdChMzg/R2yvsVoq6NUUTzfR3DK5SbUiRiJr/+EUM0fYf+RqJwPHvg
         RPOCCxmsGR91lGLRu73SR//MMpnKo4o+QgurIQhQQY95Su98NuQKqhqbmAXFv6muQqRW
         av7R70TGmTkwneW1jYkzkI/woCG8EZuNWq2InJYzSJ5lzMqBCVR5iosVb9KQmrfRMxo5
         kwz1iuOtIOqScVk05BOGJfoksiVajnjNfdwte4ThOQQzukPJkfcF5NIvNJi49sLeOFcX
         bzyaIQFi5BRO9rpv0XIeSL7BJg54xwTSw5Vpaaec88dt4xrArY/sfW7CbTMuXs+0UPz2
         4+fg==
X-Gm-Message-State: AOAM533Dmbv2jUR7d9AB67I3wdNyeiw3X/IuztobMSLnYgSJkBpUVhp2
        lioK1SQNPHVWVzb2uXfjLGjUatv38b5FOTIkImM=
X-Google-Smtp-Source: ABdhPJyHRFD8XKzeo+o4UMjBaKyFscRu+lJM8xZKER+gE6HgvvlGIcH+I1GkLc2RgSdbzMxdI/lAMzPWHBA+TlEG6og=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr17729837ybg.347.1628022458284;
 Tue, 03 Aug 2021 13:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620763117.git.denis.salopek@sartura.hr>
 <CAEf4BzZ1ndGcnprF+zxVPiP2KpxEhbbm86WLjKtxycYgJSUM6Q@mail.gmail.com> <CAEf4BzZ6KVP4JdOgSadg6bEXyyTsf-rMxx_R-ioCnfU5mP8Luw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6KVP4JdOgSadg6bEXyyTsf-rMxx_R-ioCnfU5mP8Luw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Aug 2021 13:27:27 -0700
Message-ID: <CAEf4BzYrnTT1mrZtWg3PDcuaUdKTsPZNMy8Rr-QAo3fFrh9f2Q@mail.gmail.com>
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

On Tue, Jul 27, 2021 at 11:10 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 24, 2021 at 3:02 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 11, 2021 at 2:01 PM Denis Salopek <denis.salopek@sartura.hr> wrote:
> > >
> > > This patch series extends the existing bpf_map_lookup_and_delete_elem()
> > > functionality with 4 more map types:
> > >  - BPF_MAP_TYPE_HASH,
> > >  - BPF_MAP_TYPE_PERCPU_HASH,
> > >  - BPF_MAP_TYPE_LRU_HASH and
> > >  - BPF_MAP_TYPE_LRU_PERCPU_HASH.
> > >
> > > Patch 1 adds most of its functionality and logic as well as
> > > documentation.
> > >
> > > As it was previously limited to only stacks and queues which do not
> > > support the BPF_F_LOCK flag, patch 2 enables its usage by adding a new
> > > libbpf API bpf_map_lookup_and_delete_elem_flags() based on the existing
> > > bpf_map_lookup_elem_flags().
> > >
> > > Patch 3 adds selftests for lookup_and_delete_elem().
> > >
> > > Changes in patch 1:
> > > v7: Minor formating nits, add Acked-by.
> > > v6: Remove unneeded flag check, minor code/format fixes.
> > > v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
> > > documentation with this changes.
> > > v4: Fix the return value for unsupported map types.
> > > v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> > > flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> > > v2: Add functionality for LRU/per-CPU, add test_progs tests.
> > >
> > > Changes in patch 2:
> > > v7: No change.
> > > v6: Add Acked-by.
> > > v5: Move to the newest libbpf version (0.4.0).
> > >
> > > Changes in patch 3:
> > > v7: Remove ASSERT_GE macro which is already added in some other commit,
> > > change ASSERT_OK to ASSERT_OK_PTR, add Acked-by.
> > > v6: Remove PERCPU macros, add ASSERT_GE macro to test_progs.h, remove
> > > leftover code.
> > > v5: Use more appropriate macros. Better check for changed value.
> > >
> > > Denis Salopek (3):
> > >   bpf: add lookup_and_delete_elem support to hashtab
> > >   bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
> > >   selftests/bpf: add bpf_lookup_and_delete_elem tests
> > >
>
> Hey Denis,
>
> I've noticed a new failure for the tests you added:
>
> setup_prog:PASS:test_lookup_and_delete__open 0 nsec
> setup_prog:PASS:bpf_map__set_type 0 nsec
> setup_prog:PASS:bpf_map__set_max_entries 0 nsec
> setup_prog:PASS:test_lookup_and_delete__load 0 nsec
> setup_prog:PASS:bpf_map__fd 0 nsec
> test_lookup_and_delete_lru_hash:PASS:setup_prog 0 nsec
> fill_values:PASS:bpf_map_update_elem 0 nsec
> fill_values:PASS:bpf_map_update_elem 0 nsec
> test_lookup_and_delete_lru_hash:PASS:fill_values 0 nsec
> trigger_tp:PASS:test_lookup_and_delete__attach 0 nsec
> test_lookup_and_delete_lru_hash:PASS:trigger_tp 0 nsec
> test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_and_delete_elem 0 nsec
> test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_and_delete_elem 0 nsec
> test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_elem 0 nsec
> test_lookup_and_delete_lru_hash:FAIL:bpf_map_lookup_elem unexpected success: 0
> #67/3 lookup_and_delete_lru:FAIL
>
> I haven't seen this before, probably some timing assumptions or
> something. Can you please check and see if there is anything we can do
> to make the test more reliable?
>
> See https://app.travis-ci.com/github/kernel-patches/bpf/builds/233733889
> for the complete test run log. Thanks!
>

Ping.

>
> > >  include/linux/bpf.h                           |   2 +
> > >  include/uapi/linux/bpf.h                      |  13 +
> > >  kernel/bpf/hashtab.c                          |  98 ++++++
> > >  kernel/bpf/syscall.c                          |  34 ++-
> > >  tools/include/uapi/linux/bpf.h                |  13 +
> > >  tools/lib/bpf/bpf.c                           |  13 +
> > >  tools/lib/bpf/bpf.h                           |   2 +
> > >  tools/lib/bpf/libbpf.map                      |   1 +
> > >  .../bpf/prog_tests/lookup_and_delete.c        | 288 ++++++++++++++++++
> > >  .../bpf/progs/test_lookup_and_delete.c        |  26 ++
> > >  tools/testing/selftests/bpf/test_lru_map.c    |   8 +
> > >  tools/testing/selftests/bpf/test_maps.c       |  17 ++
> > >  12 files changed, 511 insertions(+), 4 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> > >
> > > --
> > > 2.26.2
> > >
> >
> > Patchbot is having a bad day...
> >
> > Applied to bpf-next, thanks. Fixed up a small merge conflict in libbpf.map.
