Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09AB3D7D1B
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhG0SKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 14:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0SKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 14:10:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EFC061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 11:10:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v46so22165597ybi.3
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK9N3EAPWM82ZhKvwlbuvxb98KASsTOYFcRvuE2FR14=;
        b=H3Zf7VsnFBGxpovTgDvrKnlDOtA9GGb7mMA1BQksFa7QwhUFdRLViVXIbDnO0zgxEa
         V3cHyoeVuV75ZsMo/rTmQaDjec+As/49opl1HxJqiF0fJAK5zWsKIsorn2NHjn3Z6cHv
         T4sS4nqPt9amzyMR9C7dtI3nE7bjRj8yrFsQtow5gy9jI67nDx5F59mgJcrPahn91AxM
         qf9XDUknVh4WDtjArlKfge7cf1dLnOgVYQ69OSHIe1pgI/pwDKbRkZEGptrAkbAj6LOl
         LrkvVKpcEdiqypxKWMBV1+Nj9TBbe7ZfQA12pOtUZWuzEHps2lc80lF5QwzgLkLWdqtb
         9ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK9N3EAPWM82ZhKvwlbuvxb98KASsTOYFcRvuE2FR14=;
        b=BFqiWPMSHSiEG9FD7BterqkQDLEo6kzDuv39AMVMwXgQN6znibCZpkqUBrakvS5DsD
         zYNkkd+IMdER8WWBecJ6J50vz1dganZC9wiKc8a3llRsSWh3adAKYQJ6a+6NiYTEqqWx
         LF0npVOQIsjKjG4pRY1Oj+v0RDq1SyQ8YBjHrewOMNqENAhRaIc9G4GwfL/XAd9c9J6I
         p8RMj488M7kWLrrS11cWQJ/S5ELB7h9JklL74FURLIxjx9isFF801EC1lPicp28Pf82w
         XQwLq7y49Kf5B6M1cEi49pRArWW7qmwdNNkdvLIoQuS06r5n1APUHxUW6sEDMamYaCBx
         /2dg==
X-Gm-Message-State: AOAM530ZMM6/oHliiyk84/jDBWp3VRjeDORuQrCzk2McV5PyYY4M9akD
        0yTctlurGlYVMuiHSfUZRncQeLdaL27SwH5ivc8=
X-Google-Smtp-Source: ABdhPJyBBC2DPEGZsJrScyOSInQ7tTgfHHzTecjSLPNfHE6qSsEF+k7gDhj5DdIXAffdpqwYwqzO+JY4XSJBtRdfk6c=
X-Received: by 2002:a25:2901:: with SMTP id p1mr21998400ybp.459.1627409423350;
 Tue, 27 Jul 2021 11:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620763117.git.denis.salopek@sartura.hr> <CAEf4BzZ1ndGcnprF+zxVPiP2KpxEhbbm86WLjKtxycYgJSUM6Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZ1ndGcnprF+zxVPiP2KpxEhbbm86WLjKtxycYgJSUM6Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Jul 2021 11:10:12 -0700
Message-ID: <CAEf4BzZ6KVP4JdOgSadg6bEXyyTsf-rMxx_R-ioCnfU5mP8Luw@mail.gmail.com>
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

On Mon, May 24, 2021 at 3:02 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 2:01 PM Denis Salopek <denis.salopek@sartura.hr> wrote:
> >
> > This patch series extends the existing bpf_map_lookup_and_delete_elem()
> > functionality with 4 more map types:
> >  - BPF_MAP_TYPE_HASH,
> >  - BPF_MAP_TYPE_PERCPU_HASH,
> >  - BPF_MAP_TYPE_LRU_HASH and
> >  - BPF_MAP_TYPE_LRU_PERCPU_HASH.
> >
> > Patch 1 adds most of its functionality and logic as well as
> > documentation.
> >
> > As it was previously limited to only stacks and queues which do not
> > support the BPF_F_LOCK flag, patch 2 enables its usage by adding a new
> > libbpf API bpf_map_lookup_and_delete_elem_flags() based on the existing
> > bpf_map_lookup_elem_flags().
> >
> > Patch 3 adds selftests for lookup_and_delete_elem().
> >
> > Changes in patch 1:
> > v7: Minor formating nits, add Acked-by.
> > v6: Remove unneeded flag check, minor code/format fixes.
> > v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
> > documentation with this changes.
> > v4: Fix the return value for unsupported map types.
> > v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> > flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> > v2: Add functionality for LRU/per-CPU, add test_progs tests.
> >
> > Changes in patch 2:
> > v7: No change.
> > v6: Add Acked-by.
> > v5: Move to the newest libbpf version (0.4.0).
> >
> > Changes in patch 3:
> > v7: Remove ASSERT_GE macro which is already added in some other commit,
> > change ASSERT_OK to ASSERT_OK_PTR, add Acked-by.
> > v6: Remove PERCPU macros, add ASSERT_GE macro to test_progs.h, remove
> > leftover code.
> > v5: Use more appropriate macros. Better check for changed value.
> >
> > Denis Salopek (3):
> >   bpf: add lookup_and_delete_elem support to hashtab
> >   bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
> >   selftests/bpf: add bpf_lookup_and_delete_elem tests
> >

Hey Denis,

I've noticed a new failure for the tests you added:

setup_prog:PASS:test_lookup_and_delete__open 0 nsec
setup_prog:PASS:bpf_map__set_type 0 nsec
setup_prog:PASS:bpf_map__set_max_entries 0 nsec
setup_prog:PASS:test_lookup_and_delete__load 0 nsec
setup_prog:PASS:bpf_map__fd 0 nsec
test_lookup_and_delete_lru_hash:PASS:setup_prog 0 nsec
fill_values:PASS:bpf_map_update_elem 0 nsec
fill_values:PASS:bpf_map_update_elem 0 nsec
test_lookup_and_delete_lru_hash:PASS:fill_values 0 nsec
trigger_tp:PASS:test_lookup_and_delete__attach 0 nsec
test_lookup_and_delete_lru_hash:PASS:trigger_tp 0 nsec
test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_and_delete_elem 0 nsec
test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_and_delete_elem 0 nsec
test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_elem 0 nsec
test_lookup_and_delete_lru_hash:FAIL:bpf_map_lookup_elem unexpected success: 0
#67/3 lookup_and_delete_lru:FAIL

I haven't seen this before, probably some timing assumptions or
something. Can you please check and see if there is anything we can do
to make the test more reliable?

See https://app.travis-ci.com/github/kernel-patches/bpf/builds/233733889
for the complete test run log. Thanks!


> >  include/linux/bpf.h                           |   2 +
> >  include/uapi/linux/bpf.h                      |  13 +
> >  kernel/bpf/hashtab.c                          |  98 ++++++
> >  kernel/bpf/syscall.c                          |  34 ++-
> >  tools/include/uapi/linux/bpf.h                |  13 +
> >  tools/lib/bpf/bpf.c                           |  13 +
> >  tools/lib/bpf/bpf.h                           |   2 +
> >  tools/lib/bpf/libbpf.map                      |   1 +
> >  .../bpf/prog_tests/lookup_and_delete.c        | 288 ++++++++++++++++++
> >  .../bpf/progs/test_lookup_and_delete.c        |  26 ++
> >  tools/testing/selftests/bpf/test_lru_map.c    |   8 +
> >  tools/testing/selftests/bpf/test_maps.c       |  17 ++
> >  12 files changed, 511 insertions(+), 4 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> >
> > --
> > 2.26.2
> >
>
> Patchbot is having a bad day...
>
> Applied to bpf-next, thanks. Fixed up a small merge conflict in libbpf.map.
