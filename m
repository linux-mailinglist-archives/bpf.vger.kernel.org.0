Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E07353893
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhDDPUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDPUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Apr 2021 11:20:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED4C061756;
        Sun,  4 Apr 2021 08:19:56 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d2so8300294ilm.10;
        Sun, 04 Apr 2021 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=oorif4U10p1gj+stQZVhVCmGelEmfcPvRUrY2NK3cBI=;
        b=Ke22id8kLBs/PUWYVt4iPvjCEzkv3Zmrm4jW556d+JfonPDxnvkVY9CVPOaYPKt8kB
         XdM3a31BCfRHuFpuYLI4dhCFX+QFCEJe3Y7G/Oo+6Qk05mHADOtf/PQRu24gqvVc+Z9u
         RhLHm8/4SUgpD3r3R8q7Th+c70k7ScHvglrd1ZYRxlZ7cvouz3HmEN+3FXpjTjJaBM2T
         0+Mp08+v3le+h4kTCiXuMOvan7Sq4gbtG30UuUMgT1fJftOiayUzGGpNlN+1D9ZD3W7s
         WJjyqF9C6bFcuH9ZGO7aJVCkHh5Z1WXQ02d1fCq2wVOAhrXXf5V08DbXo4+AP0e/wCxg
         SPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=oorif4U10p1gj+stQZVhVCmGelEmfcPvRUrY2NK3cBI=;
        b=cGIwtxctkvhjubC2dexCfo8ffdfXK+9eXDcNjFT2pKUjch8DnLHZqSa7yQPq3UjnXq
         4qB5BW+HfN9m9vf8iJvGUy/05VmQomn9190fUkJOiKYA+Kanj54KZOpnWnyMQbE4GJXL
         OxUKATRKrSE1d+e5LzC4Hte0C7G5EhB5pqxwWMO/y4HocIIDACa7eUmKg3pmlyhvN3ZT
         ibQN1whTHT19KeTfe73hlJWo9HM1Tcb6uFl/qBJNmGNYbuyus/QvI3jE9AIabd0Xq+CY
         MnRv/+jWDzHWP7hiB+5xD8grcCwmwGQa8gH4a6l6pt7YLD8aJOXaHxoJ48621GSzKYvn
         1Pjg==
X-Gm-Message-State: AOAM531VbMoXp9kvrIQLici2MphripCyhQUoOSsv/GFOtELTJUn6XGiF
        EszCsDrh+d3QNwVupmLWydSMBZRbSAkXKHGRGzc=
X-Google-Smtp-Source: ABdhPJw0pdYejVqgApJAzWgx+VMZlo91fE4WGuG7sobiTNRSM2WLMukNsmccAh3Q0ezElkLpbM0PcAyUioMmtIGbhbo=
X-Received: by 2002:a05:6e02:12cc:: with SMTP id i12mr17468978ilm.10.1617549595570;
 Sun, 04 Apr 2021 08:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUVxpkCJVnibqm3+OYdfdh5U=eU_u7pPKUZMoPm3XzZWPQ@mail.gmail.com>
In-Reply-To: <CA+icZUVxpkCJVnibqm3+OYdfdh5U=eU_u7pPKUZMoPm3XzZWPQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 4 Apr 2021 17:19:21 +0200
Message-ID: <CA+icZUVYiX0PrxPddfv-RfGnkOUTFW_Xbv9LvPkuu+ZH3X_MCA@mail.gmail.com>
Subject: Re: Usage of CXX in tools directory
To:     Masahiro Yamada <masahiroy@kernel.org>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> So you need to pass CXX=clang++ manually when playing in tools directory:
>
> MAKE="make V=1
> MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
> CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1"
> MAKE_OPTS="MAKE_OPTS $PAHOLE=/opt/pahole/bin/pahole"
>
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ clean
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/
>

Correct:

MAKE="make V=1"
MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1"
MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"

- Sedat -
