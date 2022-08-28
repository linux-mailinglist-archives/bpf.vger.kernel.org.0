Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE05A401F
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 01:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiH1XBj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 19:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH1XBi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 19:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D227CFF
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 16:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E51F860EE1
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 23:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DB6C433B5
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 23:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661727696;
        bh=Y7oltV4GFK0Ksr7rhI4ZnGuRk//AIBcZsh3JI1tlUJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L2YR+hz1ayVCqINPHueVXMdceqbpLd9+UHJ20waMD00zB6zA3zIahNSmYbIWiUo39
         trpAtYChtIzZf95xy8XN+xRzVBi6969uhgIuhvRRJ4VkPYg4YjuViNrcrxe7Cl/As6
         1JFhsQtSV/AgZebDQBCxT1UdRXl6v44NyHkKacuGgN8d1s3bFw9NJ7ydCBv8PVzHa4
         97Ssv6YJYD1zdxMRJ4nAaigLOYD35MkLuwPwyg88u7v9SsIZAJZ0sPbfzZLyULv5hA
         uEeKRLcBVv5MIl6x6dzay+Em2V8K7V9X1RtyLbes90fcWTGL7l0CR2ecWB1E7ygHwR
         RmwcuCEu+rvDQ==
Received: by mail-qv1-f49.google.com with SMTP id l5so5138789qvs.13
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 16:01:36 -0700 (PDT)
X-Gm-Message-State: ACgBeo3JXcgbsGF4SLHfawDHN8lbpJ1uJW3X6etKiMfpraHAXYi/cUS3
        h6hjq542YZ9PNAm6rlYI78bjcKxpPGoElNkw1V5peg==
X-Google-Smtp-Source: AA6agR7Vd9Bn/xFOvzXgU0/A5TMBvLV9szeVOeYCwt/kJNL+yYwfoEfdaqqZV2DmXUj9TRWritBDHKPKtlSxMeDSD/0=
X-Received: by 2002:a05:6214:2aae:b0:476:b97e:1c1e with SMTP id
 js14-20020a0562142aae00b00476b97e1c1emr8296084qvb.126.1661727695341; Sun, 28
 Aug 2022 16:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220826184608.141475-1-jolsa@kernel.org> <20220826184608.141475-3-jolsa@kernel.org>
In-Reply-To: <20220826184608.141475-3-jolsa@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 29 Aug 2022 01:01:24 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5GxZhH7iFKD-=WS450-80n78HO25-cW_7xyB7o28Xu9Q@mail.gmail.com>
Message-ID: <CACYkzJ5GxZhH7iFKD-=WS450-80n78HO25-cW_7xyB7o28Xu9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 8:46 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The dispatcher function is attached/detached to trampoline by
> dispatcher update function. At the same time it's available as
> ftrace attachable function.
>
> After discussion [1] the proposed solution is to use compiler
> attributes to alter bpf_dispatcher_##name##_func function:
>
>   - remove it from being instrumented with __no_instrument_function__
>     attribute, so ftrace has no track of it
>
>   - but still generate 5 nop instructions with patchable_function_entry(5)
>     attribute, which are expected by bpf_arch_text_poke used by
>     dispatcher update function
>
> Enabling HAVE_DYNAMIC_FTRACE_NO_PATCHABLE option for x86, so
> __patchable_function_entries functions are not part of ftrace/mcount
> locations.
>
> The dispatcher code is generated and attached only for x86 so it's safe
> to keep bpf_dispatcher func in patchable_function_entry locations for
> other archs.
>
> [1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

I read the whole discussion in
https://lore.kernel.org/bpf/CAADnVQLMY9Gbipx6Tc4dsRN3YSXo2CF8T=KwAvjU7nRDjYxRgQ@mail.gmail.com/

and this LGTM

Acked-by: KP Singh <kpsingh@kernel.org>

> ---
>  arch/x86/Kconfig    | 1 +
>  include/linux/bpf.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..089c20cefd2b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -284,6 +284,7 @@ config X86
>         select PROC_PID_ARCH_STATUS             if PROC_FS
>         select HAVE_ARCH_NODE_DEV_GROUP         if X86_SGX
>         imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
> +       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>
>  config INSTRUCTION_DECODER
>         def_bool y
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9c1674973e03..945d5414bb62 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -925,6 +925,8 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
>  }
>
>  #define DEFINE_BPF_DISPATCHER(name)                                    \
> +       __attribute__((__no_instrument_function__))                     \
> +       __attribute__((patchable_function_entry(5)))                    \
>         noinline __nocfi unsigned int bpf_dispatcher_##name##_func(     \
>                 const void *ctx,                                        \
>                 const struct bpf_insn *insnsi,                          \
> --
> 2.37.2
>
