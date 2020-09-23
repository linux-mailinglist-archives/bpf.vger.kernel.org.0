Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7705D27648D
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 01:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWXbx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgIWX33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 19:29:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38880C0613D1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so567533plt.9
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnYowXpX9ek9m66e/Htp70CeCYZxw6hk1IiAy6Kl5rQ=;
        b=d23i7lGk81zKYyusnqeg3ju3nwOqSpKeXXqEXfHcMkudEXxh6GYe4vsSAUdXG2Kmda
         6xUIDq6pAnsBhq4Uwb61Qv+JVTAqLdlu5ggSiDwArbU7/fQlOyXMiVKgIeSUdEW9+pdY
         Yl9rNSLOlhuM/5SpwR5+gAAFa1s7kNPrF+Xkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnYowXpX9ek9m66e/Htp70CeCYZxw6hk1IiAy6Kl5rQ=;
        b=oA5fLYRyBAdlvaCjoSREeXIOgwE4OMvDre5tXnM7DB8usuyLsX8XScjPzcMMbcfwCV
         66jyd1CgzFqAHWihpQIKhS2/4D/pCZF5K5bkYaDo2pe4P+UqHlPUh7+JcBgHgR33uKXt
         eYmYLoXXed0LRm9HNDRXjGvZdPbRarIFf83yWKGRexak+uRqv+E4a6Hq5eXfWlfV1w5J
         EI1EwibhhM80b+zeyV8OXHMG6NiO+xb2PfiDYNNcy09LMBNkGV423K3y3e2eHIHtW2iU
         1msSPdRBDsgO5SuqNsym+wg+IMjmYXMKhvymcIbVc2tNWt6OLdfhH5BHWJOmZDB5MIYC
         Xi4w==
X-Gm-Message-State: AOAM530OmrMGuIlS9BYHHkswX8XocUTjCJ3c7psQj/mE3kwvexDaQkNH
        1p2khMeoh/LyGY2WQk9L9isYiA==
X-Google-Smtp-Source: ABdhPJyayNyPvuS62S2fNWA1VUxrMaI1OAUF1FMKlIQFQYU1vC9AcNWm/orb6K3zoxr7u7I4hLjRvQ==
X-Received: by 2002:a17:902:8689:b029:d1:9bf7:230a with SMTP id g9-20020a1709028689b02900d19bf7230amr2038591plo.22.1600903768727;
        Wed, 23 Sep 2020 16:29:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm836499pgy.0.2020.09.23.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:29:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
Date:   Wed, 23 Sep 2020 16:29:17 -0700
Message-Id: <20200923232923.3142503-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

rfc: https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
alternative: https://lore.kernel.org/containers/cover.1600661418.git.yifeifz2@illinois.edu/
v1:
- rebase to for-next/seccomp
- finish X86_X32 support for both pinning and bitmaps
- replace TLB magic with Jann's emulator
- add JSET insn

TODO:
- add ALU|AND insn
- significantly more testing

Hi,

This is a refresh of my earlier constant action bitmap series. It looks
like the RFC was missed on the container list, so I've CCed it now. :)
I'd like to work from this series, as it handles the multi-architecture
stuff.

Repeating the commit log from patch 3:

    seccomp: Implement constant action bitmaps
    
    One of the most common pain points with seccomp filters has been dealing
    with the overhead of processing the filters, especially for "always allow"
    or "always reject" cases. While BPF is extremely fast[1], it will always
    have overhead associated with it. Additionally, due to seccomp's design,
    filters are layered, which means processing time goes up as the number
    of filters attached goes up.
    
    In the past, efforts have been focused on making filter execution complete
    in a shorter amount of time. For example, filters were rewritten from
    using linear if/then/else syscall search to using balanced binary trees,
    or moving tests for syscalls common to the process's workload to the
    front of the filter. However, there are limits to this, especially when
    some processes are dealing with tens of filters[2], or when some
    architectures have a less efficient BPF engine[3].
    
    The most common use of seccomp, constructing syscall block/allow-lists,
    where syscalls that are always allowed or always rejected (without regard
    to any arguments), also tends to produce the most pathological runtime
    problems, in that a large number of syscall checks in the filter need
    to be performed to come to a determination.
    
    In order to optimize these cases from O(n) to O(1), seccomp can
    use bitmaps to immediately determine the desired action. A critical
    observation in the prior paragraph bears repeating: the common case for
    syscall tests do not check arguments. For any given filter, there is a
    constant mapping from the combination of architecture and syscall to the
    seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
    there is a single architecture.). As such, it is possible to construct
    a mapping of arch/syscall to action, which can be updated as new filters
    are attached to a process.
    
    In order to build this mapping at filter attach time, each filter is
    executed for every syscall (under each possible architecture), and
    checked for any accesses of struct seccomp_data that are not the "arch"
    nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
    there is a constant mapping for that syscall, and bitmaps can be updated
    accordingly. If any accesses happen outside of those struct members,
    seccomp must not bypass filter execution for that syscall, since program
    state will be used to determine filter action result. (This logic comes
    in the next patch.)
    
    [1] https://lore.kernel.org/bpf/20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com/
    [2] https://lore.kernel.org/bpf/20200601101137.GA121847@gardel-login/
    [3] https://lore.kernel.org/bpf/717a06e7f35740ccb4c70470ec70fb2f@huawei.com/


Thanks!

-Kees


Kees Cook (6):
  seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
  x86: Enable seccomp architecture tracking
  seccomp: Implement constant action bitmaps
  seccomp: Emulate basic filters for constant action results
  selftests/seccomp: Compare bitmap vs filter overhead
  [DEBUG] seccomp: Report bitmap coverage ranges

 arch/x86/include/asm/seccomp.h                |  14 +
 include/linux/seccomp.h                       |  27 +
 include/uapi/linux/seccomp.h                  |   1 +
 kernel/seccomp.c                              | 473 +++++++++++++++++-
 net/core/filter.c                             |   3 +-
 .../selftests/seccomp/seccomp_benchmark.c     | 151 +++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c |  33 ++
 tools/testing/selftests/seccomp/settings      |   2 +-
 8 files changed, 674 insertions(+), 30 deletions(-)

-- 
2.25.1

