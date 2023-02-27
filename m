Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56D46A421E
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 13:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjB0M6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 07:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjB0M6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 07:58:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C5F83F2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:58:44 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy6so25419776edb.5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bnN8En8MIIEsxNbUSj1AxEdoKskco/X9MF3E6PrJjvg=;
        b=gpOJyzP8HKQB8R9RRY9ka3OLphnMB8iD4T/QDMe8/v7ogsm6W74u3KQI0CYe6l4yVv
         4QWFWFpnp2BYpMlLbeIM4+xWzbN7P7jox/oS6hBDwgn/ccHwBj7uySxrJIC05ZYx8Ut0
         k1Cabs2U4+dLz7Y4tGeYCDFRB0FOOeFngcKMJqsGQ35Sz8W0oSFGWKml3dIfAW+5AznY
         XZ/Lx2zh6mAY1l85YmlxTO94M333fge+P4iwbj/vZbP9zIJX31omZ+UIDGCxsITLfunt
         7k1iPpIXaAQFGwN+xbYuPmr448b7alcNLTeYM4j7QMQZeUYc/RYyl6xl7VTcPMDRK0IB
         Yjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnN8En8MIIEsxNbUSj1AxEdoKskco/X9MF3E6PrJjvg=;
        b=i8uahCp8x4DY6g2m9aKHSHxYVrLz7RxMr4ilgpSfhbrmiceKq+F4RAeFutePi9IAXc
         JRaINlfggbDravnoA7McOfHafUIUwyKGLM9jwPMjtH67B/4Zo/epIzqOPVh+3wfzS4j/
         0A0Mcf0FfyZeaxb2khaGzlzC3noKxwx0vvjkoWI4D+4Yszw3D4Z1CHGvPQgxnHboQ17/
         KXy/1U8yzj/XtVrQnPMasW4jqkaAXgFamOREUexPQr1UKN4ZkCELqSGeq7GGPdxRhpFu
         xU6a/qiD+XIrW3KCkxTd23uqrYvZ8YbKTfOgF1z9dejXGy7x+KUQ2nZ83+ut3m2fZfOj
         BuyA==
X-Gm-Message-State: AO0yUKWb8r0ky2WswmIDR9N6iJGQ5fdWoBlumlh2GGIncQRIIrIT6/La
        XWfnymS2PeyodeOf3sC+O6k=
X-Google-Smtp-Source: AK7set//U/3fRqVfvIeEkib+qtQbxteL/b6r1Gp30z75K91Fpi3UvWmQp97Ko1WTzXuc8mjX9urinA==
X-Received: by 2002:a05:6402:1a59:b0:4b1:2051:43b1 with SMTP id bf25-20020a0564021a5900b004b1205143b1mr7509474edb.37.1677502723318;
        Mon, 27 Feb 2023 04:58:43 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id hg21-20020a1709072cd500b008deba75e89csm3223957ejc.66.2023.02.27.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:58:42 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 27 Feb 2023 13:58:40 +0100
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v8 0/2] Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
Message-ID: <Y/ypANvmdYzNRLP+@krava>
References: <cover.1677075137.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677075137.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 03:35:27PM +0100, Viktor Malik wrote:
> I noticed that the verifier behaves incorrectly when attaching to fentry
> of multiple functions of the same name located in different modules (or
> in vmlinux). The reason for this is that if the target program is not
> specified, the verifier will search kallsyms for the trampoline address
> to attach to. The entire kallsyms is always searched, not respecting the
> module in which the function to attach to is located.
> 
> As Yonghong correctly pointed out, there is yet another issue - the
> trampoline acquires the module reference in register_fentry which means
> that if the module is unloaded between the place where the address is
> found in the verifier and register_fentry, it is possible that another
> module is loaded to the same address in the meantime, which may lead to
> errors.
> 
> This patch fixes the above issues by extracting the module name from the
> BTF of the attachment target (which must be specified) and by doing the
> search in kallsyms of the correct module. At the same time, the module
> reference is acquired right after the address is found and only released
> right before the program itself is unloaded.
> 
> ---
> Changes in v8:
> - added module_put to error paths in bpf_check_attach_target after the
>   module reference is acquired

I sent 2 other comments, but other than that it looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Changes in v7:
> - refactored the module reference manipulation (comments by Jiri Olsa)
> - cleaned up the test (comments by Andrii Nakryiko)
> 
> Changes in v6:
> - storing the module reference inside bpf_prog_aux instead of
>   bpf_trampoline and releasing it when the program is unloaded
>   (suggested by Jiri Olsa)
> 
> Changes in v5:
> - fixed acquiring and releasing of module references by trampolines to
>   prevent modules being unloaded between address lookup and trampoline
>   allocation
> 
> Changes in v4:
> - reworked module kallsyms lookup approach using existing functions,
>   verifier now calls btf_try_get_module to retrieve the module and
>   find_kallsyms_symbol_value to get the symbol address (suggested by
>   Alexei)
> - included Jiri Olsa's comments
> - improved description of the new test and added it as a comment into
>   the test source
> 
> Changes in v3:
> - added trivial implementation for kallsyms_lookup_name_in_module() for
>   !CONFIG_MODULES (noticed by test robot, fix suggested by Hao Luo)
> 
> Changes in v2:
> - introduced and used more space-efficient kallsyms lookup function,
>   suggested by Jiri Olsa
> - included Hao Luo's comments
> 
> Viktor Malik (2):
>   bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
>   bpf/selftests: Test fentry attachment to shadowed functions
> 
>  include/linux/bpf.h                           |   2 +
>  kernel/bpf/syscall.c                          |   6 +
>  kernel/bpf/trampoline.c                       |  27 ----
>  kernel/bpf/verifier.c                         |  18 ++-
>  kernel/module/internal.h                      |   5 +
>  net/bpf/test_run.c                            |   5 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
>  .../bpf/prog_tests/module_attach_shadow.c     | 128 ++++++++++++++++++
>  8 files changed, 169 insertions(+), 28 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> 
> -- 
> 2.39.1
> 
