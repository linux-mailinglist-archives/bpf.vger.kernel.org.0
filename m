Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0234BB2D
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 07:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhC1FGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 01:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhC1FFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Mar 2021 01:05:47 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649AC061762
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 22:05:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id w8so10254187ybt.3
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 22:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nb65MT4QGUkWAZR1Xteh1g+CLgtMoC7uxMJIgleVjg=;
        b=Utyh67jiQajkFLj1PF0yKlQ1OhJ31ZcN+lM4fSr9tKhUUn3jgIjcztOQsYS67oEm6q
         /h2tZlTD4I4ns2mCF1Y2BPt6KjipYTRA6ND4mHvlB8/UssHAcxF2gk+DRRw8A6Ghg9Qo
         vCOpF1Y93OzI3br62YrsUtOuiiryzrq6QQQPkHw3Ahhs3gC1L2T9vGkRfksBMkGPl1iF
         /hqYSJd50nAyRN/M0IsnM8BEF9SJVBDC2sl5NGtvNJkyzs9fYR+02RdAZR0NmOCaAEPv
         TN/Fh217eZlUnCeeB/Cjj4YfJOKHpxTqaHO+2DktrK0GIDCxYjtC6jZSZhQa1pmnLlra
         4rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nb65MT4QGUkWAZR1Xteh1g+CLgtMoC7uxMJIgleVjg=;
        b=NX34gD29NCAjK6jHGFey1aPdZpKIWT9otWUQf71X3VLYnrt4+UVd+gVmGnWrwQHgna
         pFag0a7g4opukO88cDdmKxZOsyEpbu7knf3phFwoUGo47YXl7Db10grIq1dL8SSpFjKK
         NfWZ1uTv7ty3FKrBUgcsJSb/qp1RoT1l2lobJifufr3xIMYSNWFHc2rBOxmEG+gCf/Xf
         5TSuhWBpOKNBdzXrMjSUMMV4WCbr0slTAqLj4gaas2zHPF1xxInvqROs8FUBQtc2s9Q0
         Y+urbz+FCJF8JY/zwoeRotjZk1+ZhkYVqNfgsLtxwbUheM2ymPAJ9rcUCwSLELBcJcrK
         82eg==
X-Gm-Message-State: AOAM5323ZH2yl1+ygU8V3BW77pzLQuoWowNI5EZVOEVbxTifeGcLsIg9
        cW5K4H+mDThEIkiXCimhfKtZbdGfWats72BIbkLcnLGKlCA=
X-Google-Smtp-Source: ABdhPJwOYcf56uz3brB7/LnxBKSvsgb/gWIMq0waI4okQ6W0j0Xd7biUz2nmgJ0Cd1UUZ2Guz+y9vyRXTkXaiQuc5PE=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr29917924ybc.425.1616907946749;
 Sat, 27 Mar 2021 22:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com> <20210326122407.211174-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326122407.211174-1-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Mar 2021 22:05:35 -0700
Message-ID: <CAEf4BzY_=Fj4+TetwHatiid=XM7rtjuZwfCA3fe9n7mhEhmwcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] bpf/selftests: page size fixes
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 5:24 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> A set of fixes for selftests to make them working on systems with PAGE_SIZE > 4K
>
> 2 questions left:
>
> - about `nit: if (!ASSERT_OK(err, "setsockopt_attach"))`. I left
>   CHECK() for now since otherwise it has too many negations. But
>   should I anyway use ASSERT?

CHECK itself is a negation as much more confusing, IMO. if
(!ASSERT_OK(err)) is pretty clear, as for me.

>
> - https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/mmap.c#L41
>   and below -- it works now as is, but should be switched also to page_size?

replied on another patch, it is possible to set all that at runtime
with bpf_map__set_max_entries().


Overall, please specify the [PATCH bpf-next] prefix to denote that it
targets bpf-next.


>
> --
> v1->v2:
>
> - add missed 'selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton'
>
> Yauheni Kaliuta (4):
>
>   selftests/bpf: test_progs/sockopt_sk: pass page size from userspace
>   bpf: selftests: test_progs/sockopt_sk: remove version
>   selftests/bpf: ringbuf, mmap: bump up page size to 64K
>
>  .../selftests/bpf/prog_tests/ringbuf.c        |  9 ++-
>  .../selftests/bpf/prog_tests/sockopt_sk.c     | 68 ++++++-------------
>  .../selftests/bpf/progs/map_ptr_kern.c        |  9 ++-
>  .../testing/selftests/bpf/progs/sockopt_sk.c  | 11 ++-
>  tools/testing/selftests/bpf/progs/test_mmap.c | 10 ++-
>  .../selftests/bpf/progs/test_ringbuf.c        |  8 ++-
>  .../selftests/bpf/progs/test_ringbuf_multi.c  |  7 +-
>  7 files changed, 61 insertions(+), 61 deletions(-)
>
> --
> 2.29.2
>
