Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762D64380B5
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 01:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhJVXky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 19:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJVXky (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 19:40:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9103C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 16:38:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v200so10336597ybe.11
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slq52cAdHRoa9atgU3dV2eltaTrBwuhOstDQ5DaWuWo=;
        b=gad642RYSSTjRhAXTXl0PalNId8GCpgTvv2q3xDQAaGgqHncjNJ08kySLPQ9kSj7zp
         TJ1Z/4IJdcHShff1PoP33xksfB5pf/hVxcMVEBU07c4sARa0ZvUK1vkRtI6m5KUo+3sG
         FPyuih0s7mQIXY0MVeoqKkTcLkjC05BahkNyMLwQge7rf5aYhS4Lq3SX0lH+Gb4CWtLz
         6oEj6zKKBRCosDzUXNkRZYZivEQRqDh5yas4tZYK6nZUk0cj/oGN3Ke5oQyHRHErpNco
         N5EZDkGcHsLQJRbPPREWE5EtfwQ0fM3fr5lhHW8swO3ASq6QQ2INL0DxhiscdENgcxma
         9zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slq52cAdHRoa9atgU3dV2eltaTrBwuhOstDQ5DaWuWo=;
        b=dSSCQ/w8wQv/Xr4Ps0siZBXmAz4DLynR4oZIUj47sbmbxdQePmmUo+7+pNu5AveoRN
         0MfXl06FkJuCS02izWciidZDg5EZTesoONh3yCWBxkAAg1GqNik9YUSFiR+HmhDcUuHW
         Mgn9C+lD9B17ZB7DcEwEV/3ek0nUVqgWV55ddzaqkTO1iGGlHTr8ekch06jkEChY+bgS
         lGcfpL4gur8DRSsaeUmlNuhjl9w9dMGzYiGiGFTsw4E2iSr8lZdk97oBkJYRAD5/ZwqW
         w0pw0yaHwoPVwJBi0ITwHvpaN3Pa84nZBpcshAAIl78gKTNPt26ovDFYiEZYbgFWnZK7
         /o3g==
X-Gm-Message-State: AOAM530YV3kbDW1RFrt35XEPP51fgXCIW71e25wmpKIF6zvdrs4EQLo9
        P5QUqD42i7AlHKkZMWb3cXMszsMMZ7W5ypZ6LNtE1MtsCs0=
X-Google-Smtp-Source: ABdhPJxTIKu/rWvhMDEKQNDfUVg49oOwE/KbX2ULjUn01bsfyeYiQD9NqDTN88jMePvDhVcQO+XwOXLlfvEEL3I7G00=
X-Received: by 2002:a25:8749:: with SMTP id e9mr1472909ybn.2.1634945914999;
 Fri, 22 Oct 2021 16:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211021234653.643302-1-iii@linux.ibm.com>
In-Reply-To: <20211021234653.643302-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Oct 2021 16:38:24 -0700
Message-ID: <CAEf4BzZBTDpcbEzpm5v7GUE7z_bZ+Azxf-Gt3oqqKGWFRYQP-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] core_reloc fixes for s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 4:47 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Hi,
>
> this series fixes test failures in core_reloc on s390.
>
> Patch 1 fixes a bug in byte order determination.
> Patch 2 fixes an endianness issue in bitfield relocation.
> Patch 3 fixes an endianness issue in test_core_reloc_mods.
>

This doesn't apply cleanly anymore. Please rebase and re-submit. You
mentioned that patch #2 is not necessary, so please drop it as well.
As for the patch #1, can you please split it into libbpf, selftests
and samples patches? Thanks.


> Best regards,
> Ilya
>
> Ilya Leoshkevich (3):
>   bpf: Use __BYTE_ORDER__ everywhere
>   libbpf: Fix relocating big-endian bitfields
>   selftests/bpf: Fix test_core_reloc_mods on big-endian machines
>
>  samples/seccomp/bpf-helper.h                       |  8 ++++----
>  tools/lib/bpf/bpf_core_read.h                      |  2 +-
>  tools/lib/bpf/btf.c                                |  4 ++--
>  tools/lib/bpf/btf_dump.c                           |  8 ++++----
>  tools/lib/bpf/libbpf.c                             |  4 ++--
>  tools/lib/bpf/linker.c                             | 12 ++++++------
>  tools/lib/bpf/relo_core.c                          | 13 +++++++++----
>  .../testing/selftests/bpf/prog_tests/btf_endian.c  |  6 +++---
>  .../selftests/bpf/progs/test_core_reloc_mods.c     |  9 +++++++++
>  tools/testing/selftests/bpf/test_sysctl.c          |  4 ++--
>  tools/testing/selftests/bpf/verifier/ctx_skb.c     | 14 +++++++-------
>  tools/testing/selftests/bpf/verifier/lwt.c         |  2 +-
>  .../bpf/verifier/perf_event_sample_period.c        |  6 +++---
>  tools/testing/selftests/seccomp/seccomp_bpf.c      |  6 +++---
>  14 files changed, 56 insertions(+), 42 deletions(-)
>
> --
> 2.31.1
>
