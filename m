Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC738417E54
	for <lists+bpf@lfdr.de>; Sat, 25 Sep 2021 01:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhIXXgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhIXXgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 19:36:53 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A4DC061571
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:35:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y13so9184479ybi.6
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBNnDpeQOknM35zpCXqawbCKbr+DS8/yw8RZ4PSHVBA=;
        b=csqdR5Un9KiIhOCTMau1wGTFbLx0/885ciwfAdIndQ1tPfTLMtkffM2o80CVGQCNgw
         4p2Yu8hmap6iT8wNAqMqU3QUVSWeVSUZbt/CfhmJW8lxUr29FcjOZg0tIxOzHKB4dnoH
         mh+69oZz5/qOKlQRXyO47erJe67VdX3M4iDZ2RI9Ols3C2ezB22gbJFdsRrVQNTCS3GV
         bFNKqUTQk7e3bMiqeXhlBk8C1bUKWU3/eQHZn8mQJawWyX7/bope8BIl34XioBvGH3ak
         1HFvGu1+dgbuOM2kDgro2JfgwgzDoWQ/9jkXvYV3MADQxiTdlrl14lIaOsjKeLtFfHS+
         jVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBNnDpeQOknM35zpCXqawbCKbr+DS8/yw8RZ4PSHVBA=;
        b=2Zgdit4MZ9Ec8a398xkwtIeCo5GqOq0T3imzC+WivNYdApX0ifmAHg4gOAUR7hVsxu
         /wjNhzG2OR8pb2zOX+ivkx5UT7OVCdz54jcu+dBilO3SGA1sMmdxwFyk6S9PmZdVvSFs
         3Jx2MdKLFmTC09fISCmis7GCrgqlFCjRH0GsP4OdXXzybTP/bcmW5qI89r0aEJEPfsZx
         OHxlV41kPjnTpDpOh2DXDmkThHk/UDYjdvi/DUsD0F+dAI8qXBhIPPrUeOybNzOWjGF3
         o1NC9z0jWqW/32JryahFof1HTZ9S2A4h3Z2EUIQ9S+wVtyKrXJ1sq0EGzKNGa0A/YJ+d
         WRmg==
X-Gm-Message-State: AOAM533ngh9yQBYyLg4qyWi2XtmajQOdkXZ3NCDou/G4zYtoFtX/T+13
        Cz27dzHG8K8db6Tps/ernVsSO23JvMmOKztctQ0=
X-Google-Smtp-Source: ABdhPJz0lzoO4vLTqo3x0Ot3+EtQwnZx1FrFWIC7Xbi9UDHJ0G3D7qHg9N8xFn/gR3tiTRmHNebmtKrVQubJRolxQMg=
X-Received: by 2002:a25:83c6:: with SMTP id v6mr16087925ybm.2.1632526519150;
 Fri, 24 Sep 2021 16:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210924025856.2192476-1-yhs@fb.com> <alpine.LRH.2.23.451.2109241911100.21067@localhost>
In-Reply-To: <alpine.LRH.2.23.451.2109241911100.21067@localhost>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Sep 2021 16:35:08 -0700
Message-ID: <CAEf4BzZtcWginbqcaSG9ywm6y_juHowbQf2auNn5YLc9zpGfWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix btf_dump __int128 test
 failure with clang build kernel
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 24, 2021 at 11:13 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 24 Sep 2021, Yonghong Song wrote:
>
> > With clang build kernel (adding LLVM=1 to kernel and selftests/bpf build
> > command line), I hit the following test failure:
> >
> >   $ ./test_progs -t btf_dump
> >   ...
> >   btf_dump_data:PASS:ensure expected/actual match 0 nsec
> >   btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < expected 0
> >   btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < expected 0
> >   test_btf_dump_int_data:FAIL:dump __int128 unexpected error: -2 (errno 2)
> >   #15/9 btf_dump/btf_dump: int_data:FAIL
> >
> > Further analysis showed gcc build kernel has type "__int128" in dwarf/BTF
> > and it doesn't exist in clang build kernel. Code searching for kernel code
> > found the following:
> >   arch/s390/include/asm/types.h:  unsigned __int128 pair;
> >   crypto/ecc.c:   unsigned __int128 m = (unsigned __int128)left * right;
> >   include/linux/math64.h: return (u64)(((unsigned __int128)a * mul) >> shift);
> >   include/linux/math64.h: return (u64)(((unsigned __int128)a * mul) >> shift);
> >   lib/ubsan.h:typedef __int128 s_max;
> >   lib/ubsan.h:typedef unsigned __int128 u_max;
> >
> > In my case, CONFIG_UBSAN is not enabled. Even if we only have "unsigned __int128"
> > in the code, somehow gcc still put "__int128" in dwarf while clang didn't.
> > Hence current test works fine for gcc but not for clang.
> >
> > Enabling CONFIG_UBSAN is an option to provide __int128 type into dwarf
> > reliably for both gcc and clang, but not everybody enables CONFIG_UBSAN
> > in their kernel build. So the best choice is to use "unsigned __int128" type
> > which is available in both clang and gcc build kernels. But clang and gcc
> > dwarf encoded names for "unsigned __int128" are different:
> >
> >   [$ ~] cat t.c
> >   unsigned __int128 a;
> >   [$ ~] gcc -g -c t.c && llvm-dwarfdump t.o | grep __int128
> >                   DW_AT_type      (0x00000031 "__int128 unsigned")
> >                   DW_AT_name      ("__int128 unsigned")
> >   [$ ~] clang -g -c t.c && llvm-dwarfdump t.o | grep __int128
> >                   DW_AT_type      (0x00000033 "unsigned __int128")
> >                   DW_AT_name      ("unsigned __int128")
> >
> > The test change in this patch tries to test type name before
> > doing actual test.
> >
>
> Thanks for finding and fixing this!
>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>

Applied to bpf-next, thanks.

> > ---
> >  .../selftests/bpf/prog_tests/btf_dump.c       | 27 ++++++++++++++-----
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >

[...]
