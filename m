Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5895C318316
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 02:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhBKBcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 20:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhBKBcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 20:32:05 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63720C061574
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 17:31:25 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v5so4042905ybi.3
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 17:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TY+5ATDl5HKx695kxNMZo3nbTQY+9CIPIMhhNUTzqAo=;
        b=MK7xmoXhtOyGF7nm2JTbtcYSN0syON91gA6F6/zEXWfFxmDLluHPaTXFb0x/ZUBSsz
         IsPW0LXtm81oMsnDjZidLE7NZqShaziANlyNb5w87zXhzsWZOtQYXN/idtLIAg4Ajomy
         e+544s9RDl5sY97iZMxv4QjqDB3Vui58idE62myo9zVJ0r4POneU8VXMBYy4+S95kcpS
         vC8ySXA4/IO4uTF8/RUgk4qyDXI6w9eWzD+1TprrMp9kkVPe6mW/Lv63Yh4pG4SKepdB
         IJbONJbDz9p+k1271hQOJq1sWCAULIrE9Mokf7b1T4DQsscxDkW90YnDdwPWCDcUtsru
         KzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TY+5ATDl5HKx695kxNMZo3nbTQY+9CIPIMhhNUTzqAo=;
        b=e8pjZgf0ugV5Gz6RlgYccXrgWXq73XS9qtwW3Eflgy6mwi+ml0nRIyFRafAkINsaXB
         8G4c2s013JYKRNLUgNX4AIomNqNro91QSTdwemd7fz44J9Mj1iHNwHZyYBW+868Sbf5d
         UAhQg+/DQHRuKAy99lAG4hV6vpALEDtTT4DiE8Z180b71ChcM8ZytuUVmBX9JG/NP0fd
         oo70ZMuCHlVliiuegbcXW37ea7VHOWNZ4fTNPXCOUVk3VLoh8mvYM0avz5LnAyFaB5JC
         H/6yJjDQuVyqRx32tI65D62lfKDBZqCtZW+fqScyJ1G20MafwgeJchy1N2BiM8dCfw4e
         vZmw==
X-Gm-Message-State: AOAM53022QqHuTLRoGTLEsQFExD2ycmSpqQLqG/pv6wSjzDAZ1WxKTdH
        8BtwP4To5NYxy67FC9V37EFJxrq91/uCFvbparQ=
X-Google-Smtp-Source: ABdhPJyLYerOmfXktp6am23dtlZNKD0QswNsX9G43iefbGR9vN+AMwkW0/Jam4iAcIe89YMBR1XpnlnXZACftXz2W14=
X-Received: by 2002:a25:9882:: with SMTP id l2mr7710206ybo.425.1613007084492;
 Wed, 10 Feb 2021 17:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20210210030317.78820-1-iii@linux.ibm.com>
In-Reply-To: <20210210030317.78820-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 17:31:13 -0800
Message-ID: <CAEf4BzaUe4_yJMPS2QR0tsCn2av=tMzNrP3S94fKw-Cd77w5SQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 7:03 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Some BPF programs compiled on s390 fail to load, because s390
> arch-specific linux headers contain float and double types.
>
> Introduce support for such types by representing them using the new
> BTF_KIND_FLOAT. This series deals with libbpf, bpftool, in-kernel BTF
> parser as well as selftests and documentation.
>
> There are also pahole and LLVM parts:
>
> * https://github.com/iii-i/dwarves/commit/btf-kind-float-v1
> * https://reviews.llvm.org/D83289
>
> but they should go in after the libbpf part is integrated.
>
> There is also an open question: should we go forward with
> BTF_KIND_FLOAT, or should this be merely a BTF_KIND_INT encoding? The
> argument for BTF_KIND_FLOAT is that it's more explicit and therefore
> less prone to unintentional mixups. The argument for BTF_KIND_INT
> encoding is that there would be less code and the overall integration
> process would be simpler.

Less code is not the only or main motivation for representing floats
as just an encoding of BTF_KIND_INT. I think float is not sufficiently
different from bool and int to warrant its own type (kind). And BTF,
in general, is pretty good about having only essential types (kinds).
Float/double is a primitive type, just like bool or char/int/long,
supported by the compiler natively and it represents some indivisible
arrangement of bits in memory.

Surely, there are some semantic differences in how compiler and CPU
are handling such types, but that's none of type system's concern.
E.g., ABI calling conventions dictating which registers or stack
locations arguments go into are not described by BTF. Also, consider
bool. You can treat it as a single byte integer, but it's not just
that: compiler treats it specially (with the 0 and 1 regularization,
when converting to integer representation). Similarly for floats, code
generated for use of floats will be different from integers, but
that's none of type system's concerns. But when using BTF types to
describe memory contents, bool, int, and float are exactly the same
thing: a set of bytes in memory, which are up to interpretation. And
that's why it leads to less code and overall simpler integration.

The only place I can think of where BPF verifier would care about
float vs int, is when processing function signature, because (at least
for some architectures) float will be put in different registers than
non-floats. But BPF verifier can easily distinguish that case by
checking the encoding, so I don't buy the "unintentional mixups"
argument.


>
> Ilya Leoshkevich (6):
>   bpf: Add BTF_KIND_FLOAT to uapi
>   libbpf: Add BTF_KIND_FLOAT support
>   tools/bpftool: Add BTF_KIND_FLOAT support
>   bpf: Add BTF_KIND_FLOAT support
>   selftest/bpf: Add BTF_KIND_FLOAT tests
>   bpf: Document BTF_KIND_FLOAT in btf.rst
>
>  Documentation/bpf/btf.rst                    |  19 ++-
>  include/uapi/linux/btf.h                     |  10 +-
>  kernel/bpf/btf.c                             | 101 ++++++++++++-
>  tools/bpf/bpftool/btf.c                      |  13 ++
>  tools/bpf/bpftool/btf_dumper.c               |   1 +
>  tools/include/uapi/linux/btf.h               |  10 +-
>  tools/lib/bpf/btf.c                          |  85 ++++++++---
>  tools/lib/bpf/btf.h                          |  13 ++
>  tools/lib/bpf/btf_dump.c                     |   4 +
>  tools/lib/bpf/libbpf.c                       |  32 +++-
>  tools/lib/bpf/libbpf.map                     |   5 +
>  tools/lib/bpf/libbpf_internal.h              |   4 +
>  tools/testing/selftests/bpf/btf_helpers.c    |   4 +
>  tools/testing/selftests/bpf/prog_tests/btf.c | 145 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |   5 +
>  15 files changed, 418 insertions(+), 33 deletions(-)
>
> --
> 2.29.2
>
