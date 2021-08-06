Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22603E298F
	for <lists+bpf@lfdr.de>; Fri,  6 Aug 2021 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbhHFL30 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Aug 2021 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245371AbhHFL3Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 07:29:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A95C061798
        for <bpf@vger.kernel.org>; Fri,  6 Aug 2021 04:29:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id zb12so9762874ejb.5
        for <bpf@vger.kernel.org>; Fri, 06 Aug 2021 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXx+nOl1QVL74KL2GRl8sbFxt/HrFTiUM9UC3bD45gc=;
        b=RptZvUOA93wMwmxOUiriy4Sv13SVtsiLfIGrqbo+GEXUQb68RDWCr+AOhv3n2HP2Sl
         RfrDITepafU94zmcJk03eCRU8FzrjMDp74ZBPd+pfR2KPm+OAjTfcJPBZaA8ly06IkmE
         bVyseXmnFcKsNw2PTkuRKSE1Cgy1AV33S/a9crohtpNpnNUhWBxhXDrpD2ENMLG6Scd7
         M5xyH7GnOrraLBqpLdAfjb0LszvficIyqpF7tbda0xkPJQFrGRhYLIuZTiVOQqOW/Rs7
         EhtsCi8xRLqFWSE7lfSK6dPWC+V5bee6oojWsJjQD5gGcCl+SghJj/jC0VMBk2TVRwcr
         1eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXx+nOl1QVL74KL2GRl8sbFxt/HrFTiUM9UC3bD45gc=;
        b=VSAlWpqHIbmZCzaEq6fGX0hDkBlip9Uk70V9Vtr6dnhUkShyyuF39JZSp4FNsDUqEV
         S0QylyGfq6xcU+1xEGetCw9nv8vn2Z9WkOkHSCCuwvD2ETsJml7OYWpoyeU+F2KnclXt
         D9P5ssBdJLXUzVLzRFwqYA6WreIXHPncT8A7bgB7GaqEbEOkMt0bQvhpK6Jz9DU4YJsy
         eVCd716oNJ5C52blpjdE6dtOCX8KXFE7vfcE1tcg/MpEQCILKrqhUfOlcF3jmiGegYRC
         /9FVDx+UfykeqwVkc8rf0oPOojcf0UduM7MjExSj4emRLxGA6bD8vRjzM/2NC+2E7Nq3
         iq5w==
X-Gm-Message-State: AOAM531FL88FAcxEXpI2aX+sjH3wAJg9QNIf9pBCrT/7go8srEDIbRDo
        vrO+GI9bdhFc+HA83SYDhepoZw==
X-Google-Smtp-Source: ABdhPJw9ik8fkkTiU8Ms39IvV8KakDbFDyZa4YC9+hyDF6vYo2rM17a5Ccpjz/URVmcGb5jhoH8SfQ==
X-Received: by 2002:a17:906:5799:: with SMTP id k25mr9283791ejq.110.1628249348548;
        Fri, 06 Aug 2021 04:29:08 -0700 (PDT)
Received: from gmail.com ([93.140.44.60])
        by smtp.gmail.com with ESMTPSA id m9sm2783036ejn.91.2021.08.06.04.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:29:07 -0700 (PDT)
Date:   Fri, 6 Aug 2021 13:29:05 +0200
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v7 bpf-next 0/3] Add lookup_and_delete_elem support to
 BPF hash map types
Message-ID: <YQ0dAcuYWpiI3nOF@gmail.com>
References: <cover.1620763117.git.denis.salopek@sartura.hr>
 <CAEf4BzZ1ndGcnprF+zxVPiP2KpxEhbbm86WLjKtxycYgJSUM6Q@mail.gmail.com>
 <CAEf4BzZ6KVP4JdOgSadg6bEXyyTsf-rMxx_R-ioCnfU5mP8Luw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ6KVP4JdOgSadg6bEXyyTsf-rMxx_R-ioCnfU5mP8Luw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 11:10:12AM -0700, Andrii Nakryiko wrote:
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

Hello Andrii,

I figured the LRU tests would go like this:
1. We create LRU hash map with 2 elements.
2. We fill both of those elements with a default value (1234) at keys 1
and 2.
3. We trigger the outside BPF program that sets the element at key 3 to
a new value (4321). My initial presumption was that since the map is
full, the new element will cause the 'oldest' one (key = 1) to be
deleted and add the new one, leaving only keys 2 and 3 in the map.
4. We lookup_and_delete the newly added element at key = 3 (so only key
= 2 remains in the map).
5. We check whether key = 3 exists in the map -> it shouldn't and it
doesn't.
6. We check whether key = 1 exists in the map -> it shouldn't, but it
does.

So, the LRU test fails at the last check.

The lookup_and_deleted element at key = 3 is really deleted, as the test
gives us PASS (one line before FAIL), and as that is the point of this
test, I guess we can just skip the last check for the deleted LRU
element?

The LRU_PERCPU test (which passes, by the way) does the same thing as
the LRU test, so we can make the same changes on both of them, if you
agree with the above.

Kind regards,
Denis

> 
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
