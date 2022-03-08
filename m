Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39B4D0DA3
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 02:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiCHBpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 20:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiCHBpU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 20:45:20 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F33C3B03B
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 17:44:25 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o12so3605690ilg.5
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0RQ2IhupddfihnnOQJR0xL9KZyig+Yf0OQhHwUAqpg=;
        b=CQG26rBXZ+IcG1wh+cfa1gVCistaeRHl6M57Y7PAPu0HJd8fKLk68YhXPxdfh1MxTN
         mrs7HbljG+uitErdxguwhjt5ssSsfk/lWLZwXvmdYwwyo2YdGo/dyOjsX44Z++LLUBun
         UNpCMMfbgnmOl9H49Vx2+D9VmxtOfl8ODtY83WlD+NB1heYWxHpBygvQhLqvMyEKuAgz
         Eq0GpeTCt++w1D/olq5FTmxwHnNJPOysE4zKqMjG1Nw2OQCp+dINW+vNEcHcaH+OVEiZ
         5AFoHIcJMw9UtMvJ5zceHGpUMkARcRQLCdkMW/9on74LQ8LHXJ335SpkFf2DLsFPHefs
         1mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0RQ2IhupddfihnnOQJR0xL9KZyig+Yf0OQhHwUAqpg=;
        b=fRepmBw9Neom6YMAg+zLoX6DV64cOw6HD5YZfaDr/dOWhXuX9HMp5/qQTxJYfUfc0X
         p3eQQ7OqQT4Fwabx+8BMwH76hWl6QhjJajZl9wwDMiw+ZMMSVCc5N5zElyxv8WMawAkI
         A+w2YMFMxdSki5FiSFXNd8KT+YzkgPeBROxwhEgeCQLC4YYZ7QJxWavIhjbg0kQmDfJ6
         k6CWb5LOkhDplcW+bSIsxfit6EZSm4ch0+m9NwDqMBbVqxG5cY1NeWtUWbkUnX+e+dp1
         jVX+y7/tC4HnMnK5V9fRlJ4Ia6NMQuCiVRtXYh5zoWijg6Dj+sJ0Uz0G88iWLqbPbiDV
         1WjQ==
X-Gm-Message-State: AOAM5339npDNGchlCEtGkBEdseM3SimYjauGXqoPSweuEA3sQb2ZNdMN
        HLGQ7c1MgtQ7FetF9wZgyNEqnezIhS480UjxnaspyFEGEFdK1Q==
X-Google-Smtp-Source: ABdhPJwiRXem7JlBXdsniQhlAxdzgErkdKWuYdQcNecR9WfMBknxfo0v1y7r4UvDuxnePOJZIRsP8FEdPV1+EMKVj7U=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr13712457ilb.305.1646703864824; Mon, 07
 Mar 2022 17:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20220304191657.981240-1-haoluo@google.com> <20220304191657.981240-3-haoluo@google.com>
In-Reply-To: <20220304191657.981240-3-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Mar 2022 17:44:14 -0800
Message-ID: <CAEf4BzadmAQSUHSSDfSeiMvicvdbOKh_r7oCX2=OThbjOS-rMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] compiler_types: define __percpu as __attribute__((btf_type_tag("percpu")))
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 4, 2022 at 11:17 AM Hao Luo <haoluo@google.com> wrote:
>
> This is similar to commit 7472d5a642c9 ("compiler_types: define __user as
> __attribute__((btf_type_tag("user")))"), where a type tag "user" was
> introduced to identify the pointers that point to user memory. With that
> change, the newest compile toolchain can encode __user information into
> vmlinux BTF, which can be used by the BPF verifier to enforce safe
> program behaviors.
>
> Similarly, we have __percpu attribute, which is mainly used to indicate
> memory is allocated in percpu region. The __percpu pointers in kernel
> are supposed to be used together with functions like per_cpu_ptr() and
> this_cpu_ptr(), which perform necessary calculation on the pointer's
> base address. Without the btf_type_tag introduced in this patch,
> __percpu pointers will be treated as regular memory pointers in vmlinux
> BTF and BPF programs are allowed to directly dereference them, generating
> incorrect behaviors. Now with "percpu" btf_type_tag, the BPF verifier is
> able to differentiate __percpu pointers from regular pointers and forbids
> unexpected behaviors like direct load.
>
> The following is an example similar to the one given in commit
> 7472d5a642c9:
>
>   [$ ~] cat test.c
>   #define __percpu __attribute__((btf_type_tag("percpu")))
>   int foo(int __percpu *arg) {
>         return *arg;
>   }
>   [$ ~] clang -O2 -g -c test.c
>   [$ ~] pahole -JV test.o
>   ...
>   File test.o:
>   [1] INT int size=4 nr_bits=32 encoding=SIGNED
>   [2] TYPE_TAG percpu type_id=1
>   [3] PTR (anon) type_id=2
>   [4] FUNC_PROTO (anon) return=1 args=(3 arg)
>   [5] FUNC foo type_id=4
>   [$ ~]
>
> for the function argument "int __percpu *arg", its type is described as
>         PTR -> TYPE_TAG(percpu) -> INT
> The kernel can use this information for bpf verification or other
> use cases.
>
> Like commit 7472d5a642c9, this feature requires clang (>= clang14) and
> pahole (>= 1.23).
>
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/compiler_types.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3f31ff400432..223abf43679a 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -38,7 +38,12 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  #  define __user
>  # endif
>  # define __iomem
> -# define __percpu
> +# if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
> +       __has_attribute(btf_type_tag)
> +#  define __percpu     __attribute__((btf_type_tag("percpu")))


Maybe let's add

#if defined(CONFIG_DEBUG_INFO_BTF) &&
defined(CONFIG_PAHOLE_HAS_BTF_TAG) && __has_attribute(btf_type_tag)
#define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
#else
#define BTF_TYPE_TAG(value) /* nothing */
#endif

and use BTF_TYPE_TAG() macro unconditionally everywhere?

> +# else
> +#  define __percpu
> +# endif
>  # define __rcu
>  # define __chk_user_ptr(x)     (void)0
>  # define __chk_io_ptr(x)       (void)0
> --
> 2.35.1.616.g0bdcbb4464-goog
>
