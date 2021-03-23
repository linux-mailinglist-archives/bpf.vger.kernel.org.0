Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC3346B12
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 22:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhCWV2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 17:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhCWV21 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 17:28:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CAEC061765
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 14:28:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i26so12914588lfl.1
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oE8Re7U2eiRTAh9p3PAj7D06IDZ16XlxhTmOYb89s/8=;
        b=FJMeWXH+SaUw1EE94VwNSxeUROOX72sUs1KyGDlEqEifmVqm6Nm3+EZZBosnRVkNGA
         DwxLHCyqmfawP6Noi2RmaV7umcSzUA11e/grp81xPwUhI1/iUNw/31OWqPVezUi91wPY
         utRanRrza0bGC2bDni7GFzhhO8qr0A+tJ0WoLmYS03HJlVuW9rKonI4L+EpSvQFYjHz9
         bx+e6/Rti7mbXHAHS4ixI/leP99NIwuDcxTcvOG3aXffNhVOM7g7cM+FEvnwPm4H6KYn
         FURJXnuQWRaVS4qInf/SKXxXGqlhptU8V21fgmbumrv01osdiuNJB+olA1xskDVq/+2Q
         LP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oE8Re7U2eiRTAh9p3PAj7D06IDZ16XlxhTmOYb89s/8=;
        b=n12FUPshxfqBeVMcMrplgP6e50ZG79wlrVZcNAeNHq3khHjiwanSSsg+PrUBakBgJe
         jAgi3U+erqA2qSPkCHxKg4wiM2R66kPPnOMp7jdMF4Zn1ZLF1URAnf+L1RWHXmHMTGXl
         bvcMYiCWs+oufeUqzn5X2iV5X+o/QNc60KWiFHuELpM3jvIl+weOJubR5cpYAMl1O306
         U7xHC6UaCXIjJPyAHT7aD4XtLfKsHn8fEKc+T3+HmL1EeOQU5u4nSF7RZ6HlL33Ij8CT
         kKasdecJCXZZ9vXIxVoZW4NVT4u0voIKqufejcYThhGcbDuwB+0aZ9s9yCrODs9mScLl
         gzog==
X-Gm-Message-State: AOAM530efB9QL0dGvjEfvMNMsHQXbcSu9nABakWhjZZbuRbJRL2Tz6F+
        lLgA30F28nw1qt4CKIn17Ed9HJNen1Uyv7YDqePAqg==
X-Google-Smtp-Source: ABdhPJyQ7qsEvILqWPc3g5iRiytFJpTt4UTAmMg5r+eaD3LvYwwXBwdUjRC4U6ywX5x/yBprcY72YeaBiQ3jH5EanL4=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr1333lfd.547.1616534904876;
 Tue, 23 Mar 2021 14:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com> <20210323203946.2159693-10-samitolvanen@google.com>
In-Reply-To: <20210323203946.2159693-10-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Mar 2021 14:28:13 -0700
Message-ID: <CAKwvOdnZwMKjJKd5Fbx5hH1Ute1ZkMZGP=Kn0tJq=rxF2P3eNw@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] treewide: Change list_sort to use const pointers
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 1:40 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> list_sort() internally casts the comparison function passed to it
> to a different type with constant struct list_head pointers, and
> uses this pointer to call the functions, which trips indirect call
> Control-Flow Integrity (CFI) checking.
>
> Instead of removing the consts, this change defines the
> list_cmp_func_t type and changes the comparison function types of
> all list_sort() callers to use const pointers, thus avoiding type
> mismatches.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kvm/vgic/vgic-its.c                  |  8 ++++----
>  arch/arm64/kvm/vgic/vgic.c                      |  3 ++-
>  block/blk-mq-sched.c                            |  3 ++-
>  block/blk-mq.c                                  |  3 ++-
>  drivers/acpi/nfit/core.c                        |  3 ++-
>  drivers/acpi/numa/hmat.c                        |  3 ++-
>  drivers/clk/keystone/sci-clk.c                  |  4 ++--
>  drivers/gpu/drm/drm_modes.c                     |  3 ++-
>  drivers/gpu/drm/i915/gt/intel_engine_user.c     |  3 ++-
>  drivers/gpu/drm/i915/gvt/debugfs.c              |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c   |  3 ++-
>  drivers/gpu/drm/radeon/radeon_cs.c              |  4 ++--
>  .../hw/usnic/usnic_uiom_interval_tree.c         |  3 ++-
>  drivers/interconnect/qcom/bcm-voter.c           |  2 +-
>  drivers/md/raid5.c                              |  3 ++-
>  drivers/misc/sram.c                             |  4 ++--
>  drivers/nvme/host/core.c                        |  3 ++-
>  .../pci/controller/cadence/pcie-cadence-host.c  |  3 ++-
>  drivers/spi/spi-loopback-test.c                 |  3 ++-
>  fs/btrfs/raid56.c                               |  3 ++-
>  fs/btrfs/tree-log.c                             |  3 ++-
>  fs/btrfs/volumes.c                              |  3 ++-
>  fs/ext4/fsmap.c                                 |  4 ++--
>  fs/gfs2/glock.c                                 |  3 ++-
>  fs/gfs2/log.c                                   |  2 +-
>  fs/gfs2/lops.c                                  |  3 ++-
>  fs/iomap/buffered-io.c                          |  3 ++-
>  fs/ubifs/gc.c                                   |  7 ++++---
>  fs/ubifs/replay.c                               |  4 ++--
>  fs/xfs/scrub/bitmap.c                           |  4 ++--
>  fs/xfs/xfs_bmap_item.c                          |  4 ++--
>  fs/xfs/xfs_buf.c                                |  6 +++---
>  fs/xfs/xfs_extent_busy.c                        |  4 ++--
>  fs/xfs/xfs_extent_busy.h                        |  3 ++-
>  fs/xfs/xfs_extfree_item.c                       |  4 ++--
>  fs/xfs/xfs_refcount_item.c                      |  4 ++--
>  fs/xfs/xfs_rmap_item.c                          |  4 ++--
>  include/linux/list_sort.h                       |  7 ++++---
>  lib/list_sort.c                                 | 17 ++++++-----------
>  lib/test_list_sort.c                            |  3 ++-
>  net/tipc/name_table.c                           |  4 ++--
>  41 files changed, 90 insertions(+), 72 deletions(-)

This looks like all of the call sites I could find.  Yes, this looks
much better, thank you for taking the time to fix all of these. I ran
this through some build tests of ARCH=arm64 defconfig, allyesconfig,
and same for my host (x86_64). All LGTM.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
