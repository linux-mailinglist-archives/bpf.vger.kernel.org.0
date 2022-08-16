Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E84595993
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiHPLMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiHPLLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 07:11:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91603FEE98
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 03:18:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w3so12871671edc.2
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=r/KIjrrw0ucqoe9AEe8UtlpiDM6xKYkAr2r68mrfLdY=;
        b=T1NqdI+Fcs2n1jiLm7JGhxl6x99b9vlORmd+XDjVY8i+StoEU/z7fys64jeGPQFnRg
         z+AwhzkmDlkuc4ttI5R7lIn7dYM2LISJmaWWwFiqS1mvEEGGEptX1zEE1Q+7E8GPJU/I
         QUxfoHKpandJD7H1Kvacs4Hg+2Zaz7pZc0A+1ag7PzKocx8GI5aYewqm8rPajUYVkml4
         ifk/sX2/P2Gz2Y25n4YnB5OZ0hp2Jw5NN7Fg9lSuadBaipsWFDIvDFSYsEJOSx/XXim6
         /HybUkDeYwpXkgpM43fSS7D0HESVcZOG5zXSbeDj+VuYi3uV9dVGuYKIfqoKHHezcMkj
         coFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=r/KIjrrw0ucqoe9AEe8UtlpiDM6xKYkAr2r68mrfLdY=;
        b=NwxG9tEv2Yqek9hCu8MYhsPKg41iSgR9wP6y5BeX8CEHMZoFez3v9ZNv4wyk2D8eB6
         o4fxH1tg2jD9Fn71FPUD3fpGRkJcwPX3v1hF4mZEHU/4XyQT98nRCasZYtSTh2ROFC4Z
         tcqrttl4QFhY7MdykNOC/JKPoh1lMUV0ckvSYrscvihlawxmlicATpq9/RGYKiCFmLsP
         qTaktfhU/jqHtG12afQ5TdTBmpNUMtB8GyZu7rBwkTcgJXMOq9pjbZ4kKsRrGAiOaGEA
         ulFiMUIQJ7OnV3Z8P+UrmxyzuWb52/Fu/dLuHoYbQqzAN4rZL/hgEn1cMatSxNU05SuL
         CMJA==
X-Gm-Message-State: ACgBeo1aucGvmPfFkki+yNf9FueGzboZ9rOE/j3ivmVljtr2MZo6J5zG
        EHnc86wAjON19UNGqHr3V2fwiTQHCmPlSA==
X-Google-Smtp-Source: AA6agR5/KQqHXD2Qh2mXkNqAln1TzEgY3ZCn+6ys/vx2pHTtXa3sRRqXOMClwAVPYCeWBbmj4WHOIA==
X-Received: by 2002:aa7:cf18:0:b0:43d:34e:11b9 with SMTP id a24-20020aa7cf18000000b0043d034e11b9mr18344543edy.145.1660645124481;
        Tue, 16 Aug 2022 03:18:44 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906504600b007306a4bc9b4sm5122890ejk.38.2022.08.16.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:18:43 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 16 Aug 2022 12:18:42 +0200
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 6/6] selftests/bpf: Fix get_func_ip offset
 test for CONFIG_X86_KERNEL_IBT
Message-ID: <YvtvAkcnsrho+Xeq@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-7-jolsa@kernel.org>
 <CAEf4BzbXBsL8zrCDEP-+VsKseEQ1fWTRvUkJtwxX5r8q9hf1OA@mail.gmail.com>
 <YvtAhPyiWDbTzCdA@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvtAhPyiWDbTzCdA@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 09:00:20AM +0200, Jiri Olsa wrote:
> On Mon, Aug 15, 2022 at 08:25:51PM -0700, Andrii Nakryiko wrote:
> > On Thu, Aug 11, 2022 at 2:16 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > With CONFIG_X86_KERNEL_IBT enabled the test for kprobe with offset
> > > won't work because of the extra endbr instruction.
> > >
> > > As suggested by Andrii adding CONFIG_X86_KERNEL_IBT detection
> > > and using appropriate offset value based on that.
> > >
> > > Also removing test7 program, because it does the same as test6.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  .../bpf/prog_tests/get_func_ip_test.c         | 62 +++++++++++++++----
> > >  .../selftests/bpf/progs/get_func_ip_test.c    | 20 +++---
> > >  2 files changed, 60 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > index 938dbd4d7c2f..a4dab2fa2258 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > > @@ -2,7 +2,9 @@
> > >  #include <test_progs.h>
> > >  #include "get_func_ip_test.skel.h"
> > >
> > > -void test_get_func_ip_test(void)
> > > +static int config_ibt;
> > > +
> > > +static void test_function_entry(void)
> > >  {
> > >         struct get_func_ip_test *skel = NULL;
> > >         int err, prog_fd;
> > > @@ -12,14 +14,6 @@ void test_get_func_ip_test(void)
> > >         if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
> > >                 return;
> > >
> > > -       /* test6 is x86_64 specifc because of the instruction
> > > -        * offset, disabling it for all other archs
> > > -        */
> > > -#ifndef __x86_64__
> > > -       bpf_program__set_autoload(skel->progs.test6, false);
> > > -       bpf_program__set_autoload(skel->progs.test7, false);
> > > -#endif
> > > -
> > >         err = get_func_ip_test__load(skel);
> > >         if (!ASSERT_OK(err, "get_func_ip_test__load"))
> > >                 goto cleanup;
> > > @@ -38,16 +32,62 @@ void test_get_func_ip_test(void)
> > >
> > >         ASSERT_OK(err, "test_run");
> > >
> > > +       config_ibt = skel->bss->config_ibt;
> > 
> > skel->bss->config_ibt isn't actually necessary, you can just check
> > skel->kconfig->CONFIG_X86_KERNEL_IBT directly. And you won't need to
> > trigger BPF program unnecessary, libbpf will fill out kconfig section
> > during object/skeleton load phase.
> 
> nice, did not know that ;-) will remove it

actually.. to get kconfig datasec generated in BTF the CONFIG_X86_KERNEL_IBT
symbol needs to be used.. so I came up with adding unused function:

  int unused(void)
  {
        return CONFIG_X86_KERNEL_IBT ? 0 : 1;
  }

but I wonder having the config_ibt variable is better and more clear

thoughts?

thanks,
jirka
