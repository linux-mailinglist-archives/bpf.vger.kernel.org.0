Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874BC52AECD
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiEQXpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiEQXpj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:45:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A58B3A5D6
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:45:38 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t2so401410ilm.13
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7jJgR7NsuPevLfW+kLFYqo95HDEnFI1O8uHN6rJr2Q=;
        b=YtJvymFBc1cAtwNApMUnKJ5ubG6eCrY83ibm+NiM0jgSlhPEF3XBN4pHEikWMbUJVX
         HlTVUckrzoYmaIaYem/RHx6wIEABELAz7XMbr0ylfQ1Afo1IlChVGoKOUwomIYNLwFW8
         sC7OEiFowyVvETZgmOfTcEqzsjZzn8xe+BPf1IdzO+pVP2q5HDLi9tO1VfhN/L3AvZ5F
         +8+5CYA3g0YAR0MaCB59Ch57i4W1FPH6e+Z7dmjkdamwFLZHVFSL+CSpoYrLfQWKeV9H
         RyMB6K1maHghpXkMvkdaxTJF1pxXLrkhRdHUHGFpmE5RTKquaEgqxVp/ZC/ZU7Hs7IgL
         whdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7jJgR7NsuPevLfW+kLFYqo95HDEnFI1O8uHN6rJr2Q=;
        b=T20cannLhtVWcUIaRSbnO+3tcnR9SThH8edvNGo30XQ8PxfVh5hrFA2/xf+j+RvOpF
         4ijfVryrUgST/S5YoBJ9pA2cNDFzY/1VkzbicCRFod2THaX7q+MUcjifjjV/Q9o2VYZ0
         PPuiPDJPBvvhgKyhY3eHUVQ4pKr9mcsvzL9tO+wOsrqZpozJTr95KE+MZ2HJC2SDXEL6
         44y/0raT9sYuraMfuftW2tY3lGqbDpFVxa/2DyCQgDGfcc2+ciRlJhMBT3NauocAblsB
         tiwpeo9axvQlZb9uWbATby1zpbazfyrDrAtj7kolqCvG2WjNxo0LhInU2BraCc/aRcUq
         MHOA==
X-Gm-Message-State: AOAM5337DWio23loMESD0FM80RH4C2t/SmliZy1os/eovBb29rLOWgPv
        SdxbEjOLxbOHjCbE+8nRR7OKaF3S7jpYrlPtWUw/BCShePk=
X-Google-Smtp-Source: ABdhPJzFzh1gT5JoBPrTJK9hAdS8FiFzl/aANe6TWUMSkV4eSjxdJPoJGXsBXzzqaaAoDvSYXNhegkkfbCu2ihFqrA8=
X-Received: by 2002:a05:6e02:1d85:b0:2d1:39cf:380c with SMTP id
 h5-20020a056e021d8500b002d139cf380cmr2876533ila.239.1652831137494; Tue, 17
 May 2022 16:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031350.3247432-1-yhs@fb.com>
In-Reply-To: <20220514031350.3247432-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:45:26 -0700
Message-ID: <CAEf4BzaQYByqHEUB70mLu+VFVfSRpNE7okV1HJckMQ692B-a5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] selftests/bpf: Clarify llvm dependency
 with possible selftest failures
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, May 13, 2022 at 8:14 PM Yonghong Song <yhs@fb.com> wrote:
>
> Certain subtests in selftests core_reloc and core_reloc_btfgen
> requires llvm ENUM64 support in llvm15. If an older compiler
> is used, these subtests will fail. Make this requirement clear
> in selftests README.rst file.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/README.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index eb1b7541f39d..a83d78a58014 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -266,3 +266,21 @@ from running test_progs will look like:
>    test_xdpwall:FAIL:Does LLVM have https://reviews.llvm.org/D109073? unexpected error: -4007
>
>  __ https://reviews.llvm.org/D109073
> +
> +ENUM64 support and Clang version
> +================================
> +
> +There are a few selftests requiring LLVM ENUM64 support. The LLVM ENUM64 is
> +introduced in `Clang 15` [0_]. Without proper compiler support, the following selftests
> +will fail:
> +
> +.. code-block:: console
> +
> +  #45 /73    core_reloc/enum64val:FAIL
> +  #45 /74    core_reloc/enum64val___diff:FAIL
> +  #45 /75    core_reloc/enum64val___val3_missing:FAIL
> +  #46 /73    core_reloc_btfgen/enum64val:FAIL
> +  #46 /74    core_reloc_btfgen/enum64val___diff:FAIL
> +  #46 /75    core_reloc_btfgen/enum64val___val3_missing:FAIL
> +
> +.. _0: https://reviews.llvm.org/D124641
> --
> 2.30.2
>
