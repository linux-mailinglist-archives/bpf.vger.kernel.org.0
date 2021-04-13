Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAC35D683
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 06:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhDMEc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 00:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhDMEc6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 00:32:58 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E76C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:32:39 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so16705452ybi.12
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rz1Za0B1D9+GzGO0agdnLO/MEQqtVzeqwQI5C4bKxNQ=;
        b=R3MqB3tIwRcSrMvHieO1JFIPL8Wi83BK49k82Vn8aZg/HinKx24NVXywIPaH9bpbMV
         ze2gR88vcog9KXseEFzXarOXgZ+ftgLw07qaZiPCZXnyxopCqfoFmNCNeQVTislrM/VW
         mXTMOvq65x0L0zSw74lQCwVqzGjz+pYz6ytKdNiwdMwSbeGP5aNAb2x3gXpU00HBg9VH
         ipeDZzuzgH6OEi68ENUDZxrb9OdGtcKLEKJkTFrx4DYW92MjJurS8IuejGWwmouues0h
         WC2FamDtTeMKixco+nQ4pLmke8GmUOeRvgtqqqrn8B8GN4TBSR75taW/4R4PcXTozC2T
         Ddbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rz1Za0B1D9+GzGO0agdnLO/MEQqtVzeqwQI5C4bKxNQ=;
        b=d6mu2ES1jGWjwPWFXFA/hreqi5Q5TJDVhRPlhDQQUGHYSJCROVME+ooCnuqKWteQBo
         1ihbh6HlNBisGCzOm5/ENFAOn2NFnyTyIhnUX8cCAFySg4iYmaQbWEy/5S+amEh7bpIJ
         QtotvjfZj5MOPONoiHq8sOMka1cFuvYp5eg/fg7ITh6A5gD175BBbLu7cXFwtXGHoZNt
         cj+w1Aw2RZ0pjajBD1/xfbLouNFagtQWNFTWGzKqX3BR5jPtQF3fb+61DANiAlDI9cV1
         cZpwv8OTx2UwpSRr8FUOpJdbA68tTDLY9MnhhV2mACSNPqLiCAccWv3HjknVJ4ZwZHYv
         OEFA==
X-Gm-Message-State: AOAM531o4fLVQHJCgvU555917Whe6yULOgMF9qn4Kc8obHpnwB+T7QzG
        fTnKMuQ+adKLpQKYmKtNhwHDu/kMzE89o5nmM8g=
X-Google-Smtp-Source: ABdhPJyrg3FDH5Io0VX9asirzBUTjlT8W+cBZQs9VQBjtCVNWFacss+5487iYfHJTQiKJR42leEFcg0wLgDYv3y7YSo=
X-Received: by 2002:a25:dc46:: with SMTP id y67mr17022073ybe.27.1618288358426;
 Mon, 12 Apr 2021 21:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164940.770304-1-yhs@fb.com>
In-Reply-To: <20210410164940.770304-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 21:32:27 -0700
Message-ID: <CAEf4BzbhbAhRqfkqrzXODVr=ETm7MmwpTDZ5jKd=bGmFvU9G7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 10, 2021 at 9:49 AM Yonghong Song <yhs@fb.com> wrote:
>
> With clang compiler:
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> the test_cpp build failed due to the failure:
>   warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
>   clang-13: warning: cannot specify -o when generating multiple output files
>
> test_cpp compilation flag looks like:
>   clang++ -g -Og -rdynamic -Wall -I<...> ... \
>   -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
>   test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
>   -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
>
> The clang++ compiler complains the header file in the command line.
> Let us remove the header file from the command line which is not intended
> any way, and this fixed the problem.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6448c626498f..bbd61cc3889b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  # Make sure we are able to include and link libbpf against c++.
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>         $(call msg,CXX,,$@)
> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
> +       $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@

see what we do for other binaries:

$(filter %.a %.o %.c,$^)

It's more generic. Add %.cpp, of course.

>
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
> --
> 2.30.2
>
