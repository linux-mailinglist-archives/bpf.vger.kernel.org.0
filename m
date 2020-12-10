Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5192D6419
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbgLJRxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 12:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404089AbgLJRMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 12:12:55 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62567C0613D6
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 09:12:15 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id n142so5470286qkn.2
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdjfsxGI6hNH83SeACO9md2RU+vn84B3gQ9O+YxBdJ0=;
        b=nf4NGHe4EvPlzN6IXcIMkljNtyHzw9VmhVAtZj+b5Z+oEYWEvLBoOnGE6DXS3xkMK7
         z2rDfBQQG0cxySe2PRZ5GIdoZql0/X7tJBSKEHK5iHkdq8yqM76syhcJFFRU81u/0Zts
         UO6fuhVlDiGWTqGMbt6DHUbeQSMUvT7+L4WTlh2NLN2+PgqOy/QqxLQg+Hb1cCZsQ7Iu
         iKh//Tw1lcpyrefuYJeDUcEthRxXlPD9Plf5G5E2STbzKp7dYzdymrWb045cZsivXDiv
         BXXscLFhG0ewy6dozjXykWlg+h92LuQmXgwhWWjaL3cbeB6BASQswSei3+mm3yQHjyau
         yWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdjfsxGI6hNH83SeACO9md2RU+vn84B3gQ9O+YxBdJ0=;
        b=BUVa92M+iDeJuqyUk+Hy3SkLEjLzobNoBUxQI+KMRZ4bwtsrbURtpD49zg9KFl9ndz
         CAf+lBHzUPPHvRE7v5DbxFIozCwQaQlTgmgAsOZsH18sKutrSZYxQdtgUC40t5p29jZb
         PWszBNsLK5klPI8b2JjK2Xt3LXxPN8LQPsgZv2G+EoVof8RNndrcPEoz2ojwqJoYVWjd
         4RTl8FDKf0IIQDcu3TNgZ1RLxiY0cGJUgHMQ4YllyAjfJh7b85CFoQZgEYPWFjAqxY63
         Whb2/sLumrUG1nQ9o/BOY4WSQoTC+7PF3MDyVZgL+Gq9UIi8OmUQtCMpmEUHoFi1I0wQ
         YgKw==
X-Gm-Message-State: AOAM5306bRjNdu3y6w9R0zc6LYo99e52kwmDdcJnSfeq8SBwOUtqyvCh
        elq/Ges9f2jY9PDG89WySsYXo6jAwCMBTbygRTvcy9Q9KcFSAg==
X-Google-Smtp-Source: ABdhPJw1kLJfz+wGVU8AL85UzrT8xaKpFYHfhaRcEuz+qYAQL1zYgDDiTtMSJxKpKl5FGsGutY1hjRi5Qcomutz89iY=
X-Received: by 2002:ae9:ed41:: with SMTP id c62mr10370864qkg.111.1607620334391;
 Thu, 10 Dec 2020 09:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20201209205301.2586678-1-adelg@google.com> <dddc8f10-9757-b335-4bf1-1f19c00807c8@fb.com>
In-Reply-To: <dddc8f10-9757-b335-4bf1-1f19c00807c8@fb.com>
From:   Andrew Delgadillo <adelg@google.com>
Date:   Thu, 10 Dec 2020 09:12:03 -0800
Message-ID: <CAEHm+vH1LBG+M+uTGVySubB7ZWyhpZZV5qFVQ-g1hAhohXPQ0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Drop the need for LLVM's llc
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 9, 2020 at 6:16 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/9/20 12:53 PM, Andrew Delgadillo wrote:
> > LLC is meant for compiler development and debugging. Consequently, it
> > exposes many low level options about its backend. To avoid future bugs
> > introduced by using the raw LLC tool, use clang directly so that all
> > appropriate options are passed to the back end.
>
> Agree that this indeed make build system simpler.
>
> >
> > Additionally, the native clang build rule was not being use in the
> > selftests Makefile, so remove it.
>
> This is true too. Otherwise, native clang build will require both
> clang and llc runs.
>
> The patch looks good and I have a few comments and hopefully
> you can accommodate.
>
> >
> > Signed-off-by: Andrew Delgadillo <adelg@google.com>
> > ---
> >   tools/testing/selftests/bpf/Makefile | 20 ++++----------------
> >   1 file changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 944ae17a39ed..74870d365b62 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -19,7 +19,6 @@ ifneq ($(wildcard $(GENHDR)),)
> >   endif
> >
> >   CLANG               ?= clang
> > -LLC          ?= llc
> >   LLVM_OBJCOPY        ?= llvm-objcopy
> >   BPF_GCC             ?= $(shell command -v bpf-gcc;)
> >   SAN_CFLAGS  ?=
> > @@ -256,24 +255,13 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
> >   # $3 - CFLAGS
> >   # $4 - LDFLAGS
> >   define CLANG_BPF_BUILD_RULE
> > -     $(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
> > -     $(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm                     \
> > -             -c $1 -o - || echo "BPF obj compilation failed") |      \
> > -     $(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> > +     $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > +     $(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -Xclang -target-feature -Xclang +dwarfris -mcpu=v3 $4
>
> Yes, we still use +dwarfris here.
> The original llvm patch which introduded +dwarfris is:
>
> https://github.com/llvm/llvm-project/commit/03e1c8b8f9cc7b898217b7789d3887a903443c93
> it is to workaround an elfutils/libdw issue as it does not support bpf
> backend so pahole cannot display debuginfo structures properly.
> Subsequently, the elfutils/libdw bpf support is added at
>
> https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=c1990d36cfe37a30bcc49422c37a6767fd190559
>
> Any recent pahole should already build with the above fix.
> I tested with pahole 1.16 it works fine for binaries built without
> +dwarfris. Also BTF now can be used to dump structures.
>
> So could you also accommodate the change to remove +dwarfris option?
>
>
> >   endef
> >   # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
> >   define CLANG_NOALU32_BPF_BUILD_RULE
> > -     $(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
> > -     $(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm                     \
> > -             -c $1 -o - || echo "BPF obj compilation failed") |      \
> > -     $(LLC) -march=bpf -mcpu=v2 $4 -filetype=obj -o $2
> > -endef
> > -# Similar to CLANG_BPF_BUILD_RULE, but using native Clang and bpf LLC
> > -define CLANG_NATIVE_BPF_BUILD_RULE
> >       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > -     $(Q)($(CLANG) $3 -O2 -emit-llvm                                 \
> > -             -c $1 -o - || echo "BPF obj compilation failed") |      \
> > -     $(LLC) -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> > +     $(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v2 $4
> >   endef
> >   # Build BPF object using GCC
> >   define GCC_BPF_BUILD_RULE
> > @@ -402,7 +390,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko    \
> >                      $(wildcard progs/btf_dump_test_case_*.c)
> >   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> >   TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> > -TRUNNER_BPF_LDFLAGS := -mattr=+alu32
> > +TRUNNER_BPF_LDFLAGS := -Xclang -target-feature -Xclang +alu32
>
> The +alu32 is only used for non-alu32 case where -mcpu=v3 actually
> implies alu32. So let us remove TRUNNER_BPF_LDFLAGS flag from Makefile too.
>
> >   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> >
> >   # Define test_progs-no_alu32 test runner.
> >
Thank you for reviewing. I will make those changes and send a v2 of the patch.
