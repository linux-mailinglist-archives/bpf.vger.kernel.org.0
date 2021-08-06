Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF23E3146
	for <lists+bpf@lfdr.de>; Fri,  6 Aug 2021 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbhHFVmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Aug 2021 17:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244279AbhHFVmg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 17:42:36 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6808C061798
        for <bpf@vger.kernel.org>; Fri,  6 Aug 2021 14:42:19 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k65so17551397yba.13
        for <bpf@vger.kernel.org>; Fri, 06 Aug 2021 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bF9u8PG/K1TI5y17aawkkdS9NQrb1CsEAfiScDboqY=;
        b=qEgU/GCkmuh3IsLEA/T3RtQmaBsfuCJM0yhrIKrZ2OluHMKoaP9mhoTHhwCiglmgQB
         QDSi9DId2nr6xTCkEzUXYEUNDSRKR25hRgDnrsRJfmpbXl+rRtssWtWzRPsFdCMKOuhv
         Y/D7hzSg0nTABLedPhFPNnX1eTT0jXK7anKR+4TRjnvMvjoFqxEZhLhnIvGV1dnqIdCf
         o/rX6u3Ou3vzE0IFPnFf7kc5V0HJiffUQ8WVhWEIjQMc6IU/Wxix+PM6xkDHC0Wk2M3u
         84w7yN9Q7rCdg1Wn1P/A1oy6y3QN0q9T9xgE9pCxerPl9GDeEuc73jvwfdhPCHN5jTJg
         9pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bF9u8PG/K1TI5y17aawkkdS9NQrb1CsEAfiScDboqY=;
        b=VXDMPBnn8l44XoWL3Za+Nse4VyeBRQfGi99+TuWVuNBkK1yIT0PmZ0t0N2cs8PdbXK
         9IEMaaFo0XZUaEA5gFyZ4nrFdzHqWIiOxg42JEC5lvjlrRF+UViqlWgaH2A1QnFFIhbM
         1rm85ZqUOzX/nlPavSdOSgeq06F2+IlVD5WOWVB9mMNMU6NoTVe9RrWlgDH6v8YuM43y
         Q5z4LlwB6FXD+tgE32ipjQvnGi+2zUmtmYouV1MHfUwgwLSItxSZJ/6vyKte0hU+k2Cf
         SNbl1jgQ2rN0MMq5Qs5YD/FZLDRRquyJXu6pWWlIK9jbwe7g/3q3fMnv+36UmqX9IjsQ
         APbA==
X-Gm-Message-State: AOAM530UxFKaAFM5o9WR96F/Eg3V1lqx62g3NkW9c8XXJ8YgjC9Kda0n
        gx/YCwirEQxMPVEmpvN/ld1A0NXXYVpZD5AkfME=
X-Google-Smtp-Source: ABdhPJwpKk5N7c14G4hQIXTkcjZIgeqPAlykLft1G52uAvELfbKohwp29EpPat5tlFQc4jovzy6MVZCPB/dq75255OE=
X-Received: by 2002:a25:5054:: with SMTP id e81mr7348597ybb.510.1628286139127;
 Fri, 06 Aug 2021 14:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620763117.git.denis.salopek@sartura.hr>
 <CAEf4BzZ1ndGcnprF+zxVPiP2KpxEhbbm86WLjKtxycYgJSUM6Q@mail.gmail.com>
 <CAEf4BzZ6KVP4JdOgSadg6bEXyyTsf-rMxx_R-ioCnfU5mP8Luw@mail.gmail.com> <YQ0dAcuYWpiI3nOF@gmail.com>
In-Reply-To: <YQ0dAcuYWpiI3nOF@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 Aug 2021 14:42:08 -0700
Message-ID: <CAEf4BzahF+sCSqkefXEruHoghq4ZwUySJOe-qGSXYOSn4qrS9A@mail.gmail.com>
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

On Fri, Aug 6, 2021 at 4:29 AM Denis Salopek <denis.salopek@sartura.hr> wrote:
>
> On Tue, Jul 27, 2021 at 11:10:12AM -0700, Andrii Nakryiko wrote:
> > On Mon, May 24, 2021 at 3:02 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, May 11, 2021 at 2:01 PM Denis Salopek <denis.salopek@sartura.hr> wrote:
> > > >
> > > > This patch series extends the existing bpf_map_lookup_and_delete_elem()
> > > > functionality with 4 more map types:
> > > >  - BPF_MAP_TYPE_HASH,
> > > >  - BPF_MAP_TYPE_PERCPU_HASH,
> > > >  - BPF_MAP_TYPE_LRU_HASH and
> > > >  - BPF_MAP_TYPE_LRU_PERCPU_HASH.
> > > >
> > > > Patch 1 adds most of its functionality and logic as well as
> > > > documentation.
> > > >
> > > > As it was previously limited to only stacks and queues which do not
> > > > support the BPF_F_LOCK flag, patch 2 enables its usage by adding a new
> > > > libbpf API bpf_map_lookup_and_delete_elem_flags() based on the existing
> > > > bpf_map_lookup_elem_flags().
> > > >
> > > > Patch 3 adds selftests for lookup_and_delete_elem().
> > > >
> > > > Changes in patch 1:
> > > > v7: Minor formating nits, add Acked-by.
> > > > v6: Remove unneeded flag check, minor code/format fixes.
> > > > v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
> > > > documentation with this changes.
> > > > v4: Fix the return value for unsupported map types.
> > > > v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> > > > flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> > > > v2: Add functionality for LRU/per-CPU, add test_progs tests.
> > > >
> > > > Changes in patch 2:
> > > > v7: No change.
> > > > v6: Add Acked-by.
> > > > v5: Move to the newest libbpf version (0.4.0).
> > > >
> > > > Changes in patch 3:
> > > > v7: Remove ASSERT_GE macro which is already added in some other commit,
> > > > change ASSERT_OK to ASSERT_OK_PTR, add Acked-by.
> > > > v6: Remove PERCPU macros, add ASSERT_GE macro to test_progs.h, remove
> > > > leftover code.
> > > > v5: Use more appropriate macros. Better check for changed value.
> > > >
> > > > Denis Salopek (3):
> > > >   bpf: add lookup_and_delete_elem support to hashtab
> > > >   bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
> > > >   selftests/bpf: add bpf_lookup_and_delete_elem tests
> > > >
> >
> > Hey Denis,
> >
> > I've noticed a new failure for the tests you added:
> >
> > setup_prog:PASS:test_lookup_and_delete__open 0 nsec
> > setup_prog:PASS:bpf_map__set_type 0 nsec
> > setup_prog:PASS:bpf_map__set_max_entries 0 nsec
> > setup_prog:PASS:test_lookup_and_delete__load 0 nsec
> > setup_prog:PASS:bpf_map__fd 0 nsec
> > test_lookup_and_delete_lru_hash:PASS:setup_prog 0 nsec
> > fill_values:PASS:bpf_map_update_elem 0 nsec
> > fill_values:PASS:bpf_map_update_elem 0 nsec
> > test_lookup_and_delete_lru_hash:PASS:fill_values 0 nsec
> > trigger_tp:PASS:test_lookup_and_delete__attach 0 nsec
> > test_lookup_and_delete_lru_hash:PASS:trigger_tp 0 nsec
> > test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_and_delete_elem 0 nsec
> > test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_and_delete_elem 0 nsec
> > test_lookup_and_delete_lru_hash:PASS:bpf_map_lookup_elem 0 nsec
> > test_lookup_and_delete_lru_hash:FAIL:bpf_map_lookup_elem unexpected success: 0
> > #67/3 lookup_and_delete_lru:FAIL
> >
> > I haven't seen this before, probably some timing assumptions or
> > something. Can you please check and see if there is anything we can do
> > to make the test more reliable?
> >
> > See https://app.travis-ci.com/github/kernel-patches/bpf/builds/233733889
> > for the complete test run log. Thanks!
>
> Hello Andrii,
>
> I figured the LRU tests would go like this:
> 1. We create LRU hash map with 2 elements.
> 2. We fill both of those elements with a default value (1234) at keys 1
> and 2.
> 3. We trigger the outside BPF program that sets the element at key 3 to
> a new value (4321). My initial presumption was that since the map is
> full, the new element will cause the 'oldest' one (key = 1) to be
> deleted and add the new one, leaving only keys 2 and 3 in the map.
> 4. We lookup_and_delete the newly added element at key = 3 (so only key
> = 2 remains in the map).
> 5. We check whether key = 3 exists in the map -> it shouldn't and it
> doesn't.
> 6. We check whether key = 1 exists in the map -> it shouldn't, but it
> does.
>
> So, the LRU test fails at the last check.
>
> The lookup_and_deleted element at key = 3 is really deleted, as the test
> gives us PASS (one line before FAIL), and as that is the point of this
> test, I guess we can just skip the last check for the deleted LRU
> element?

Of course not. The test that wasn't supposed to fail fails, we can't
just remove "inconvenient" check. Checking kernel code it's not clear
how we might end up with "resurrected" element. Very strange. This
doesn't happen often, so I'll keep the test as is. If we get this
again, we should look into this much more.

Thanks for investigating!

>
> The LRU_PERCPU test (which passes, by the way) does the same thing as
> the LRU test, so we can make the same changes on both of them, if you
> agree with the above.
>
> Kind regards,
> Denis
>
> >
> >
> > > >  include/linux/bpf.h                           |   2 +
> > > >  include/uapi/linux/bpf.h                      |  13 +
> > > >  kernel/bpf/hashtab.c                          |  98 ++++++
> > > >  kernel/bpf/syscall.c                          |  34 ++-
> > > >  tools/include/uapi/linux/bpf.h                |  13 +
> > > >  tools/lib/bpf/bpf.c                           |  13 +
> > > >  tools/lib/bpf/bpf.h                           |   2 +
> > > >  tools/lib/bpf/libbpf.map                      |   1 +
> > > >  .../bpf/prog_tests/lookup_and_delete.c        | 288 ++++++++++++++++++
> > > >  .../bpf/progs/test_lookup_and_delete.c        |  26 ++
> > > >  tools/testing/selftests/bpf/test_lru_map.c    |   8 +
> > > >  tools/testing/selftests/bpf/test_maps.c       |  17 ++
> > > >  12 files changed, 511 insertions(+), 4 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> > > >
> > > > --
> > > > 2.26.2
> > > >
> > >
> > > Patchbot is having a bad day...
> > >
> > > Applied to bpf-next, thanks. Fixed up a small merge conflict in libbpf.map.
