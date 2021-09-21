Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B74413DDE
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhIUXOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhIUXOP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 19:14:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616BDC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:12:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f22so3171407qkm.5
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XXgVJNAVK3SoH1MxvtZJvoXD/NeR+hRbIAYUJ4b2SM=;
        b=gM6hUPeXTEtZRhGEyw96ss4IWYFMP/1rIDGoGce0U+F7/VHS8KCR5IYSd/s01lVZp7
         pRkLUzNc4LKkE8bTuFxKDSv3bUhvbRojlXzwiN4kEWg62uAv6bEi0vwJTWcy2gHWnDQY
         BF1DEcFrCv+jDJ2ifMeaKEUe3+nraDkGWjj2y0fbCFp1mUfnvpdVpya5ZkG7jFRcEIkB
         /aWAvEeWcR0gVdIix0tMqKlygk6FCvCnSk9IQIC+Gyh9GUwwg+E3t/DwLzvr4WV6hrSy
         M2UCCGcL1dQCF9T+DcsBJeVzt25Cy1TwgmC633AHvttm4zKSXoEDbsvK1KT8jOoti00j
         ozJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XXgVJNAVK3SoH1MxvtZJvoXD/NeR+hRbIAYUJ4b2SM=;
        b=IVgTFCsrX1exBLr9r4PxmGTk3NvGkcCvNs4uT5mluxMD2+Uc3s1qV+qTKKVIc1Ozlg
         Ww6V030Ebl8JXBY95QorOkd1KUPZzZVoh4n2BjqfcPIGMXCp6LUvaqyTSePwNxSZK6TV
         gcK3alnR/jBUpHg0pxw87XYbW2EADw659r4T+jV9Ggf5ZuHfnX3ZwsFbrJUD6Fo90nPO
         kYzJo64LgN3axk3xqKCn7VqTB0BmIPP65wS0820bATcgx4J+Jo0V9ZWT0huuBKnXayDc
         5Ks0OanzeyF8Jfubp0pa3RCw/jHfHhUy1HRqHRVzgd79AClXDY7wUF4OcHAbgon0sm6N
         vkLA==
X-Gm-Message-State: AOAM533NOxP85ryd1Tat945X6AzemjR6WEv07gSJczrfyOPwAdk9gyWs
        EamxQiWgn7hqpuKmUc7C9J9XyQtjELWE8Jme9Uw=
X-Google-Smtp-Source: ABdhPJy7ZZop02/psoMiSqrgAG9h1ath508HPD/owBspTVgxt7QVAnyUIEEc0KoHFhATjM1jTLu3O/oEfJ1V9FDHLMQ=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr39826221ybp.51.1632265965604;
 Tue, 21 Sep 2021 16:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-4-andrii@kernel.org>
 <6ccf9689-4171-970c-c412-c0ec9652a5c7@fb.com>
In-Reply-To: <6ccf9689-4171-970c-c412-c0ec9652a5c7@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 16:12:34 -0700
Message-ID: <CAEf4BzayZcSwLmOwD5W95xS6oPc9EDLU0X=rMhoWnU3XxsjApg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/9] selftests/bpf: normalize all the rest
 SEC() uses
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 10:41 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > Normalize all the other non-conforming SEC() usages across all
> > selftests. This is in preparation for libbpf to start to enforce
> > stricter SEC() rules in libbpf 1.0 mode.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/flow_dissector.c |  4 +--
> >  .../selftests/bpf/prog_tests/sockopt_multi.c  | 30 +++++++++----------
> >  tools/testing/selftests/bpf/progs/bpf_flow.c  |  3 +-
> >  .../bpf/progs/cg_storage_multi_isolated.c     |  4 +--
> >  .../bpf/progs/cg_storage_multi_shared.c       |  4 +--
> >  .../selftests/bpf/progs/sockopt_multi.c       |  5 ++--
> >  .../selftests/bpf/progs/test_cgroup_link.c    |  4 +--
> >  .../bpf/progs/test_misc_tcp_hdr_options.c     |  2 +-
> >  .../selftests/bpf/progs/test_sk_lookup.c      |  6 ++--
> >  .../selftests/bpf/progs/test_sockmap_listen.c |  2 +-
> >  .../progs/test_sockmap_skb_verdict_attach.c   |  2 +-
> >  .../bpf/progs/test_tcp_check_syncookie_kern.c |  2 +-
> >  .../bpf/progs/test_tcp_hdr_options.c          |  2 +-
> >  .../selftests/bpf/test_tcp_check_syncookie.sh |  2 +-
>
> Ran test_tcp_check_syncookie.sh as CI suite doesn't - works.
>

Thanks for the due diligence!

> checkpatch has some line length complaints, otherwise LGTM

Keep in mind that checkpatch is not the absolute authority. I think it
also didn't get the memo about the 100 character line limit :) But
generally yes, we should try to keep it more or less happy.

>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
