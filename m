Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA935D4F8
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 03:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbhDMBvQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 21:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbhDMBvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 21:51:16 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DBAC061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 18:50:56 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d2so12758779ilm.10
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 18:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YR2TtVmJS26bI6cLHo+6sxirusWSHLHYWFMX+xzdxrg=;
        b=a3qQTcUpWGM8beZRzuUpwQQ4iSFHzqiph/4+voBe1UPl/sesUR4J6Cxa9E3lIkzWou
         25Hwe04gx+o6fTwPO8NUIQsnaLhBX2ZPMnmg3nwnpYFp6FWkogjv4xmAjyY36UvTUvSZ
         HjwxXctVSGEXQk7qJoT+m+B540EUvtEQbpoEHxjEMbDIc+39DCu/Ng3g8RR3CqT2iN1f
         uTH8lYRi2WjDKdH66LC0PbEIDH5vmeViPoffBrzKTeS8Heu407pQJ0+u4BT3mZHUUYUY
         IQTjd0vSVZIE+72PiIl59Dkm60N/RlcVMsp/otTXhI1B/C2P8FW0AdWlsYXtYIPgUAFF
         w8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YR2TtVmJS26bI6cLHo+6sxirusWSHLHYWFMX+xzdxrg=;
        b=IJZa9crHqU05ce0t+evE4zx2kex9bRzRRHJJj/4HDbnMwfPrCIUq8Ng+U3pW39Zgqo
         Tozsj2ya39LNgQm573zMpF02pGjYs79xtJY6poDQgVn61NcRnmDBphbIzP0b5fFpT5C3
         dPa5IaME4eN+OXkQvqhbr4W06PjvrzLgQ+Ci2Dp2R9IR5/iBWVYu6zXRsBSsW7pzY093
         VeQ7tGjrIEXuSdl+19ICrKUBz4vP+CCFm4aWaJOrVVQ8X3mCjqUo/UoG8k6vl5Z5Lsrr
         qu54lmj8RcTmQmCxUPhElZQ6b52BS0hcjNPIUGQfG+2dbzLnocI25uGpryZ0W1UlG6UK
         pH5w==
X-Gm-Message-State: AOAM530U7hzTOA+j+/bg28gI0mOFPFSfFYp0qhVsLWbZ0rFgJFA6F89E
        ealzbteGsjWC4R3dr92AqPeukHXA/NwAGvikFNY=
X-Google-Smtp-Source: ABdhPJzJZlE26+M3Leib7A4iKva07rjFok2frqnoBiZ3FLDCS2c5p0pBOcFeG9VICoB79R/en9HqJkEF3EZ16iK8OZQ=
X-Received: by 2002:a05:6e02:1ca7:: with SMTP id x7mr10112776ill.10.1618278655809;
 Mon, 12 Apr 2021 18:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com>
In-Reply-To: <20210412142905.266942-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 13 Apr 2021 03:50:23 +0200
Message-ID: <CA+icZUXch0c8DXiubBTfnTwop5WT+-rq4dLNErCSyECn1ZjNXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 4:29 PM Yonghong Song <yhs@fb.com> wrote:
>
> To build kernel with clang, people typically use
>   make -j60 LLVM=1 LLVM_IAS=1

Just as a side note:

When building with a high parallel-make-job like above "-j60" I saw
that "test_core_extern.skel.h" was not generated which is a pre-req
header file for building stuff like test_cpp.cpp.

I have in my build-script:

MAXCPUS="$(($(getconf _NPROCESSORS_ONLN)))"
MAKE_JOBS="${MAXCPUS}"

Thanks.

- Sedat -


> LLVM_IAS=1 is not required for non-LTO build but
> is required for LTO build. In my environment,
> I am always having LLVM_IAS=1 regardless of
> whether LTO is enabled or not.
>
> After kernel is build with clang, the following command
> can be used to build selftests with clang:
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>
> But currently, using the above command, some compilations
> still use gcc and there are also compilation errors and warnings.
> This patch set intends to fix these issues.
> Patch #1 and #2 fixed the issue so clang/clang++ is
> used instead of gcc/g++. Patch #3 fixed a compilation
> failure. Patch #4 and #5 fixed various compiler warnings.
>
> Changelog:
>   v1 -> v2:
>     . add -Wno-unused-command-line-argument and -Wno-format-security
>       for clang only as (1). gcc does not exhibit those
>       warnings, and (2). -Wno-unused-command-line-argument is
>       only supported by clang. (Sedat)
>
> Yonghong Song (5):
>   selftests: set CC to clang in lib.mk if LLVM is set
>   tools: allow proper CC/CXX/... override with LLVM=1 in
>     Makefile.include
>   selftests/bpf: fix test_cpp compilation failure with clang
>   selftests/bpf: silence clang compilation warnings
>   bpftool: fix a clang compilation warning
>
>  tools/bpf/bpftool/net.c              |  2 +-
>  tools/scripts/Makefile.include       | 12 ++++++++++--
>  tools/testing/selftests/bpf/Makefile |  7 ++++++-
>  tools/testing/selftests/lib.mk       |  4 ++++
>  4 files changed, 21 insertions(+), 4 deletions(-)
>
> --
> 2.30.2
>
