Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425794D08CC
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiCGUxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 15:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245320AbiCGUwy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 15:52:54 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569396E348;
        Mon,  7 Mar 2022 12:51:59 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id w4so4747181ply.13;
        Mon, 07 Mar 2022 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yR4pOnNNi+W5qKC3ntFghkt+5izb2a8c8+qMVgl1ApA=;
        b=NMPhOzq/mMkrZi5s2ob46xsjhUImMM+S51Ohw253Be5IB2AqUfkoGWIsRG78GPNIe9
         l49K8cC320ZDVF6hl6ODxby80/z1d5Dg2rk8YnabapY45nxqBojFbGsAOxe8jR+Rv3/5
         s4uZnESwccKzVjg8DwSBZ5kzofetAnaVvOMuBRdni8yqHc0+KXC8fGLoT6Sq8SxhDkb1
         j1vlzr8iCKaO2GIuxisUt2ZU4XAKG2dgWce+2fOmMZs05WasPdJw6LfyXgbGzK/Tp+p7
         cuBZH5YD7194STKKMIyxTkosa/8JXebt2/kqqZgWLwHwkoYCUlQ7WeMfWb7XU7xGPpGY
         SizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yR4pOnNNi+W5qKC3ntFghkt+5izb2a8c8+qMVgl1ApA=;
        b=5JSjylugoIY/mB5sdKLgER41jkjkxxNG099bbV1lqK2//kkQjr5eT0nwwXtpzxkicq
         K1r7+XN5vndWQiwqZbB9x+gYQKRA4zD2f8m5skjizhc7BIpMS05D4x77UFXf0wU0r5Y3
         40PPgOG1RZYsezWx3yPWrJJNerpHZGi5yvgTy1CehzR53vJ3zXxMd3R6idnNQTMmIl/5
         0ITIfemf+qUNSb/P1yEODJKLPkT6y8F1+dg0AeN6bEyZqEmuwWJlr9lEHsA6GFmHfClR
         +6LzDB0ccT6mTkKCg0GMBFJx04j6KhtXVgbfJ2gXIssHSpEoID7m6cwsGTgmFV0HRNfu
         Cudw==
X-Gm-Message-State: AOAM530/549iLNOFg74HvNxi7omwQH1kgBwOx72qesChFoNIkJjPOqky
        5utQmQcxvOgE3/slANX8c3M=
X-Google-Smtp-Source: ABdhPJxHqcU3WIyLk0oEV7FvoQHKglguPDulf9d2KfRb9YdFvgiso16bvhyigvSgEvM7VMU799xHcw==
X-Received: by 2002:a17:902:7595:b0:151:7b0b:11c4 with SMTP id j21-20020a170902759500b001517b0b11c4mr14337470pll.126.1646686318792;
        Mon, 07 Mar 2022 12:51:58 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a0022c700b004e11d3d0459sm17440929pfj.65.2022.03.07.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:51:58 -0800 (PST)
Date:   Tue, 8 Mar 2022 02:21:56 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 6/8] compiler_types.h: Add unified
 __diag_ignore_all for GCC/LLVM
Message-ID: <20220307205156.g5pv4jg3iihhffxc@apollo.legion>
References: <20220304224645.3677453-1-memxor@gmail.com>
 <20220304224645.3677453-7-memxor@gmail.com>
 <YiZdSoNcaESkzvBs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiZdSoNcaESkzvBs@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 08, 2022 at 01:00:18AM IST, Nick Desaulniers wrote:
> On Sat, Mar 05, 2022 at 04:16:43AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Add a __diag_ignore_all macro, to ignore warnings for both GCC and LLVM,
> > without having to specify the compiler type and version. By default, GCC
> > 8 and clang 11 are used. This will be used by bpf subsystem to ignore
> > -Wmissing-prototypes warning for functions that are meant to be global
> > functions so that they are in vmlinux BTF, but don't have a prototype.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/compiler-clang.h | 3 +++
> >  include/linux/compiler-gcc.h   | 3 +++
> >  include/linux/compiler_types.h | 4 ++++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index f1aa41d520bd..babb1347148c 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -90,3 +90,6 @@
> >  #else
> >  #define __diag_clang_11(s)
> >  #endif
> > +
> > +#define __diag_ignore_all(option, comment) \
> > +	__diag_clang(11, ignore, option)
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index ccbbd31b3aae..d364c98a4a80 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -151,6 +151,9 @@
> >  #define __diag_GCC_8(s)
> >  #endif
> >
> > +#define __diag_ignore_all(option, comment) \
> > +	__diag_GCC(8, ignore, option)
>
> While this approach will work for clang, it doesn't seem scalable for
> GCC. Documentation/process/changes.rst documents that we support gcc
> 5.1+. This approach will only disable diagnostics for gcc 8+.
>

ISTM the original commit adding these macros only defined them for GCC 8+, so
coverage for previous versions is already not there, unrelated to this change.
I am not sure what the reason for that was, though.

> > +
> >  /*
> >   * Prior to 9.1, -Wno-alloc-size-larger-than (and therefore the "alloc_size"
> >   * attribute) do not work, and must be disabled.
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 3f31ff400432..8e5d2f50f951 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -371,4 +371,8 @@ struct ftrace_likely_data {
> >  #define __diag_error(compiler, version, option, comment) \
> >  	__diag_ ## compiler(version, error, option)
> >
> > +#ifndef __diag_ignore_all
> > +#define __diag_ignore_all(option, comment)
> > +#endif
> > +
> >  #endif /* __LINUX_COMPILER_TYPES_H */
> > --
> > 2.35.1
> >

--
Kartikeya
