Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0671C3541D5
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhDELrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhDELrW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 07:47:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173EC061756;
        Mon,  5 Apr 2021 04:47:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id j26so6505034iog.13;
        Mon, 05 Apr 2021 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=83h86ygFFZRKIs8Bw626CgYS4RjwINa+bifYturwgLQ=;
        b=FDANN6LGalkQEXwACJoXN/HRAYUPpYhfecuez5MwswNGCWN1jqL6MuoM5ze8SNQ1aL
         3kCKX97pKdiYRxTMH/NLp212QVqn6gPtCd1ystMofPplEvMqtSr8g1mvYgOrAHjERfUL
         GzkD2SF47nCWYrMtUJeUuvTzsbOnaWrjkmlzjut/nd6eHhBjm3VzoHjMCH1ehClUEX0C
         uuFC8otHMdAITk2fvuJl1H/A0uPtJliUnC/xRusELWEP/f7UECHKUvsb/XGHdaLV0Iv8
         tnhWExbpNMGC1zxRnt5acIn+8LMo1a3i1/8BCPj+6IgoUG9yeD67lEgVKHEYFeDKWteG
         R7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=83h86ygFFZRKIs8Bw626CgYS4RjwINa+bifYturwgLQ=;
        b=E58acjF/cozxOohAYpO0PZKumFjKZcSXXjZHNrX+n6esgSqL24H3pwfjyELesoKKkg
         n+JuqafdExRProTx0oWRhst7Rz4zf/un0orPRahtuSPpmy1//eRqWe5CyiOcnj/+yFl/
         b0jQyZCZR0sxUVmEE5xPuW43mBVHft6NoBMaMb4nLLokxX8no8J8tAgTgrDn0f/zRWi0
         0dDJpZsXxTCfGNxVrXkKq01g4vl4Y6pQ1wg8OSHUurj36PbmC8pU/z+cSXodvJoyH5OJ
         A+b/SFO9LZsbjMo2BtG9/GIRLdkYKIN2JfxTt5gflvV5L0lARFm4iE6MnSGB8xyQ513d
         j8qg==
X-Gm-Message-State: AOAM533PmbkGVNO0JL3dW+MCWqBzSs+dR2F6LPDLuhcCALeZ947S9cXm
        I27BcEjyichZjxc6QX8X6m3jHhXvSFVKUz8+5DgAgb4Eu8gjNA==
X-Google-Smtp-Source: ABdhPJyZ+oGB0JGspGhnZizWZjSGQ9vNA589tDrMfCg6eNH4yiH7QTgStIxbGvCYtn+hVYYs5a8MpNC7ilHeolDBBoQ=
X-Received: by 2002:a5e:8610:: with SMTP id z16mr18882588ioj.57.1617623235886;
 Mon, 05 Apr 2021 04:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com> <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
 <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com> <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
 <458faf4c-7681-13eb-023d-c51f582bfec6@fb.com> <CA+icZUVcQ+vQjc0VavetA3s6jzNhC20dU4Sa9ApBLNXbY=w5wA@mail.gmail.com>
 <CA+icZUUa_gad43TeUC8Ufz0kMgXMQoFy9a_hwzPwOPZHNfmNeA@mail.gmail.com>
In-Reply-To: <CA+icZUUa_gad43TeUC8Ufz0kMgXMQoFy9a_hwzPwOPZHNfmNeA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Apr 2021 13:46:42 +0200
Message-ID: <CA+icZUW9cviiDWYSn7Fwi5LHSmufBn3pj4dN3hU3dZw-Q3NmpA@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        David Blaikie <dblaikie@gmail.com>, kernel-team@fb.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 5, 2021 at 1:04 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> I hoped to drop "test_core_extern.skel.h"
> tools/testing/selftests/bpf/Makefile as test_cpp.cpp includes it:
>
> $ git grep include tools/testing/selftests/bpf/test_cpp.cpp
> tools/testing/selftests/bpf/test_cpp.cpp:#include "test_core_extern.skel.h"
>
> $ git diff
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 044bfdcf5b74..a93e4d6ff93c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -450,7 +450,7 @@ $(OUTPUT)/test_verifier: test_verifier.c
> verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>        $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> # Make sure we are able to include and link libbpf against c++.
> -$(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
> +$(OUTPUT)/test_cpp: test_cpp.cpp $(BPFOBJ)
>        $(call msg,CXX,,$@)
>        $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
>
> When using g++:
>
> $ llvm-objdump-12 -Dr test_cpp | grep test_core_extern
>    77dd: e8 be 01 00 00                callq   0x79a0
> <_ZL25test_core_extern__destroyP16test_core_extern>
>    7842: e8 59 01 00 00                callq   0x79a0
> <_ZL25test_core_extern__destroyP16test_core_extern>
> 00000000000079a0 <_ZL25test_core_extern__destroyP16test_core_extern>:
>    79a3: 74 1a                         je      0x79bf
> <_ZL25test_core_extern__destroyP16test_core_extern+0x1f>
>    79af: 74 05                         je      0x79b6
> <_ZL25test_core_extern__destroyP16test_core_extern+0x16>
>    799e: 74 06                         je      0x79a6
> <_ZL25test_core_extern__destroyP16test_core_extern+0x6>
>    7942: 73 61                         jae     0x79a5
> <_ZL25test_core_extern__destroyP16test_core_extern+0x5>
>    7945: 70 6c                         jo      0x79b3
> <_ZL25test_core_extern__destroyP16test_core_extern+0x13>
>    794b: 70 65                         jo      0x79b2
> <_ZL25test_core_extern__destroyP16test_core_extern+0x12>
>    7954: 73 5f                         jae     0x79b5
> <_ZL25test_core_extern__destroyP16test_core_extern+0x15>
>    79aa: 79 00                         jns     0x79ac
> <_ZL25test_core_extern__destroyP16test_core_extern+0xc>
>

Just to clarify:
Using g++ results in the same llvm-objdump output - independent of
keeping or dropping "$(OUTPUT)/test_core_extern.skel.h".

- Sedat -
