Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85D443AAC9
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 05:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhJZDm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 23:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhJZDm6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 23:42:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9548CC061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 20:40:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t127so31232740ybf.13
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3s+XIg0N7BekELuwc7vw+Hv6f+o/HGDTmbZoJG0DF4=;
        b=mROPP/2N9BzHZG7WTCc2OuiU+BSoW5Bv/1f15aLzIRYV1owoS+qUCYr/xfn5SYfhAz
         wsM3hOdNHnm3KXf0hvMl+k/YUnsfFj/sj8yt1HfAWOrJArw2Ftb8TUQW2AUxLrLAn9RO
         CBB0Geu9+Tj/YhtnbzxKm6uvunMmdFaExxGcZO0/O/4ggDDSlv3gl9lOxUmr5MQtaHTn
         YkIJeyc/neeNY86FRP+2463/Zn2To1AeYiJKeMZqpxYCvhPy0j3ANfNOzAzH2nxdmF3t
         HVHOs0cuX/OQqwiYYy7YtT6901YRsnNU/ikdDz+twHBpLuPhGxBlTM4Ajb77WbAFmXtE
         mdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3s+XIg0N7BekELuwc7vw+Hv6f+o/HGDTmbZoJG0DF4=;
        b=CRA55EX++/2Ks/Aj1cID/ITOCoxbm8jjasIEnwdlKo2f94y5Xbwe5q7I9h80ixgIDx
         71tQT6Fb2GaJAwxNmU/ROU0jdT+65uhb30fpSKCXT2Yt2Mqelgw5EbFy/hx6GJgesQEG
         xLpJDpl7rAFzwXNkUxrBoJWtWffdAudNeiUyzdwaPtFhNgc2g8uwnCE91viZO9q+N3Md
         /qUgoAhiWcjkPHjhXpMxIEC1x16vwmXDC6O6o8uFWkKib0xHyWaww0NXcUUS9RfwB+oa
         +y513oMypgbPlragYWvVzUXztt08TV2mHM5bXdiOLEgV6eruDCJG1th9KZPkrx7n0n9S
         gaDQ==
X-Gm-Message-State: AOAM530ILXrZHx+oF8Cb2oyEToBzB9xbRxBh8tMEVlcHegrvXvdRGjWd
        za6l11n4M8ptnv8Ldr7feyWOagyZgX5SJ3OOo0g=
X-Google-Smtp-Source: ABdhPJx3tnmGg6oS61E4f3qhjvDBf8vl09boObOkLZb8fpfnQTUEaiPBkXXxR05aX2uoKGX7/nyMqg63fT9blq4V1yg=
X-Received: by 2002:a25:aa0f:: with SMTP id s15mr15122553ybi.51.1635219634747;
 Mon, 25 Oct 2021 20:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211026010831.748682-1-iii@linux.ibm.com>
In-Reply-To: <20211026010831.748682-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 20:40:23 -0700
Message-ID: <CAEf4BzbVLEyMmpk04YY20crwp5oj5Byi2_9zZAQ5AyNyejNe7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] core_reloc fixes for s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 6:08 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> v2: https://lore.kernel.org/bpf/20211025131214.731972-1-iii@linux.ibm.com/
> v2 -> v3: Split the fix from the cleanup (Daniel).
>
> v1: https://lore.kernel.org/bpf/20211021234653.643302-1-iii@linux.ibm.com/
> v1 -> v2: Drop bpf_core_calc_field_relo() restructuring, split the
>           __BYTE_ORDER__ change (Andrii).
>
> Hi,
>
> this series fixes test failures in core_reloc on s390.
>
> Patch 1 fixes an endianness bug with __BYTE_ORDER vs __BYTE_ORDER__.
> Patches 2-5 make the rest of the code consistent in that respect.
> Patch 6 fixes an endianness issue in test_core_reloc_mods.
>

Applied to bpf-next, thanks.

> Best regards,
> Ilya
>
> Ilya Leoshkevich (6):
>   libbpf: Fix endianness detection in BPF_CORE_READ_BITFIELD_PROBED()
>   libbpf: Use __BYTE_ORDER__
>   selftests/bpf: Use __BYTE_ORDER__
>   samples: seccomp: use __BYTE_ORDER__
>   selftests/seccomp: Use __BYTE_ORDER__
>   selftests/bpf: Fix test_core_reloc_mods on big-endian machines
>
>  samples/seccomp/bpf-helper.h                       |  8 ++++----
>  tools/lib/bpf/bpf_core_read.h                      |  2 +-
>  tools/lib/bpf/btf.c                                |  4 ++--
>  tools/lib/bpf/btf_dump.c                           |  8 ++++----
>  tools/lib/bpf/libbpf.c                             |  4 ++--
>  tools/lib/bpf/linker.c                             | 12 ++++++------
>  tools/lib/bpf/relo_core.c                          |  2 +-
>  .../testing/selftests/bpf/prog_tests/btf_endian.c  |  6 +++---
>  .../selftests/bpf/progs/test_core_reloc_mods.c     |  9 +++++++++
>  tools/testing/selftests/bpf/test_sysctl.c          |  4 ++--
>  tools/testing/selftests/bpf/verifier/ctx_skb.c     | 14 +++++++-------
>  tools/testing/selftests/bpf/verifier/lwt.c         |  2 +-
>  .../bpf/verifier/perf_event_sample_period.c        |  6 +++---
>  tools/testing/selftests/seccomp/seccomp_bpf.c      |  6 +++---
>  14 files changed, 48 insertions(+), 39 deletions(-)
>
> --
> 2.31.1
>
