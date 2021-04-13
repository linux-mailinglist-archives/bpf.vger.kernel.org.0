Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8E35E8C1
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhDMWF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhDMWFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 18:05:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB6C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:05:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l14so13607468ybf.11
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ux1w4UDhlfbV7DG0hOnj23LfZ66Fnt8n7ohYkQ6cWg0=;
        b=piJ+AkDSvplU7Gen/cWxg7tIegDEhvfB0ZCsK0bE+1f4CMKggT2ofgOVlPzBHOMhDI
         zZX4qFO3mKdt2Ja7hVodUhHIZkQzusseUKSEGXCIbEDShJeLVXbImNsq3/sDMMd2DGT2
         s8xcdtwelsYQpv/KstjKQC7sa0MK6HoAmX8W4Odlgw4oIQAFx5LLL4qia3906DyN0VPR
         TsiH+2imAm4/i3pKxnCNlFTt4QKdY96ccIHcKEEzU7FAsGcHuPKVnRL8adXFC6U7+JPq
         vl+oUaqcTGgY91tYYyzrGytgufbO4FaqZEvL0keaYjWH8CHTrLWt5on6L95mt0OR0+xo
         Yu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ux1w4UDhlfbV7DG0hOnj23LfZ66Fnt8n7ohYkQ6cWg0=;
        b=YTBWwbp3+LoKcKjs8mG106jZqG6NE19qGA/oYmqMfXWFRm0bKPrSqra/P0fbLHfyRH
         fqFjpA+Ah1dN5zDUd/nfjAJfdBHW8LbHtuj6ntjnni5m4KiHHa0itL6JKY0wFIWL2ESe
         HdP3JwWvMasTtCcxtwZmwDgoiQWLQb1NiXw/2arTpWm9C2bpmQszF6sZ4X7DFY+v2cAK
         zB2ZrhLExnekaAyPp3K9yhy15ACjTYEQW0ICvp+MY7NnJd/fg4vYzWHjQ/MkNBWIYnrG
         WtXv3ohegm0gJU32Xdev6QFxDfuacUR7cShl+l0nFMvRMwD2EA0VW3HyCwpFh2VIDPlC
         P4AA==
X-Gm-Message-State: AOAM531Rq6tAL49CYXwslzy9Sl6OAtzVqfu8lzPw75SZOtBXa8yQTsSy
        BcBPAgkM8LHasWMogWjyww20huy4gZ48s0oSWYU=
X-Google-Smtp-Source: ABdhPJzcRazza5JuuUsuH2CHwx0pjTogBpyI+4dEUlZeh2Nh6DA3N1eDfHgevqGuWPBHmwgHzl4tI5Je5mcdmU3CC8w=
X-Received: by 2002:a25:3357:: with SMTP id z84mr39048394ybz.260.1618351533471;
 Tue, 13 Apr 2021 15:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210413153408.3027270-1-yhs@fb.com> <20210413153424.3028986-1-yhs@fb.com>
In-Reply-To: <20210413153424.3028986-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 15:05:22 -0700
Message-ID: <CAEf4BzbNro7ZUjx2A=RV1pafW87Ebh7WxK-gtrmpP7Wtf3t+ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] selftests/bpf: fix test_cpp compilation
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

On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
>
> With clang compiler:
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> the test_cpp build failed due to the failure:
>   warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
>   clang-13: error: cannot specify -o when generating multiple output files
>
> test_cpp compilation flag looks like:
>   clang++ -g -Og -rdynamic -Wall -I<...> ... \
>   -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
>   test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
>   -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
>
> The clang++ compiler complains the header file in the command line and
> also failed the compilation due to this.
> Let us remove the header file from the command line which is not intended
> any way, and this fixed the compilation problem.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6448c626498f..dcc2dc1f2a86 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  # Make sure we are able to include and link libbpf against c++.
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>         $(call msg,CXX,,$@)
> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
> +       $(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
>
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
> --
> 2.30.2
>
