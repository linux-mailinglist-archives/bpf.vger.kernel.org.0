Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D534352FE
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJTSul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhJTSuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:50:40 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B34C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:48:26 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r184so14487009ybc.10
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LofYa4F/zxeT/IxTwfAJKRBe6lv/SLsA1gnQwLkJ9fQ=;
        b=LBBy1vQu54P3Wq/7APTyaGCeeLd701JovIk109JofYSKpF6dXG4lBFzsRAsCSZxUAL
         GTuHMPlb9Pw4X1bm4c8Pi12yvP10QizARf4/BVAHLPlgiroBtR37E4v/+b1YP0nHZwB/
         2EjWpnfdvMSDhyKCP/zvwF8EGbQrJtj7vnooJJi7moI3+iSPv2X8H3jC9XY1M3DLZ1g6
         BG1PQdl77kRcmlMhD7tk0s2GmEyNmnMlyAjicc80D814M2+1cWsi2FktSWSGaLhQuZvv
         9atjSA3GqzBze1pkY5QsXSQWh5HMrrawYFSajGVDJQgicpU685C5+PCgnLpSxUDG6kC3
         0AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LofYa4F/zxeT/IxTwfAJKRBe6lv/SLsA1gnQwLkJ9fQ=;
        b=ysWbkOKLOHmawHAgJDs5CMhJkHdloFLUCknLv54Mcrl0VJVqYS4OpLItkUAAC9g2mb
         mO987LyJStvZGw9julTNZv/ko3legkmQBWneehUHEmkYE2MgWTjQ1WYcPoWcZ0Ii0f0T
         lutdOb4Y6Qt2rabangnv42C52T7b+KatUCVUjEdesYSIgMlWTNZRU77IEw6mibm3baEp
         4osYwAyKk0AwuaFQ7qr4KvLEXHF8WY3r4GkZfWXm0ZmEPFj/qqGNbp3PSLTu+MvPfhVO
         9o3qoSQgz1+folXlVUUoVq88UjbTimtpDY0C8G9PmANft0RRoRjjWIrjuyND6frWLNDU
         wtvw==
X-Gm-Message-State: AOAM533jr0xbIYahiFjBXb/+17EpJ6CIueOB3el7ccWQKzAX8AT41Zag
        guWD3of5taH2c9nICSHt19uH1V3mw/AiIHsSIxr0TEp8JF0=
X-Google-Smtp-Source: ABdhPJxqaJ8+0IRi9o8YiLCystDpcOnn3PKUyf6q9uBMvZnJ4H4kHxlOdcJxghJLNP3wtmKZN2tvWrj85LReaRG+DdM=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr922304ybk.2.1634755705537;
 Wed, 20 Oct 2021 11:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211013160902.428340-1-iii@linux.ibm.com>
In-Reply-To: <20211013160902.428340-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 11:48:14 -0700
Message-ID: <CAEf4BzZB=fzJj_aOfy+2MPYbmPHmUP0sGvEJDcZE2oK00cXEQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] btf_dump fixes for s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 13, 2021 at 9:09 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> v1: https://lore.kernel.org/bpf/20211012023218.399568-1-iii@linux.ibm.com/
> v1 -> v2:
> - Remove redundant local variables, use t->size directly instead.
> - Add btf__align_of() patch.
> Pending questions:
> - Can things like defined(__i386__) break cross-compilation?
> - Why exactly do we need both cpu_number and cpu_profile_flip? If we do,
>   is there a suitable replacement for cpu_number in common code?
>
> ---
>
> Hi,
>
> This series along with [1] and [2] fixes all the failures in the
> btf_dump testsuite currently present on s390, in particular:
>
> * [1] fixes intermittent build bug causing "failed to encode tag ..."
>   * error messages.
> * [2] fixes missing VAR entries on s390.
> * Patch 1 disables Intel-specific code in a testcase.
> * Patch 2 fixes an endianness-related bug.
> * Patch 3 fixes an alignment-related bug.
> * Patch 4 improves overly pessimistic alignment handling.
>
> [1] https://lore.kernel.org/bpf/20211012022521.399302-1-iii@linux.ibm.com/
> [2] https://lore.kernel.org/bpf/20211012022637.399365-1-iii@linux.ibm.com/
>
> Best regards,
> Ilya
>
> Ilya Leoshkevich (4):
>   selftests/bpf: Use cpu_number only on arches that have it
>   libbpf: Fix dumping big-endian bitfields
>   libbpf: Fix dumping non-aligned __int128
>   libbpf: Fix ptr_is_aligned() usages
>
>  tools/lib/bpf/btf_dump.c                      | 34 +++++++++----------
>  .../selftests/bpf/prog_tests/btf_dump.c       |  2 ++
>  2 files changed, 19 insertions(+), 17 deletions(-)
>
> --
> 2.31.1
>

I've dropped patch 4 for now, applied the first three to bpf-next, thanks.
