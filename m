Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70705525947
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350464AbiEMBMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiEMBMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:12:51 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621DF222C28
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:12:48 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id p1so2661651uak.1
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EZN/Mb9B2RBK+4vJv1FC96FcsAOneNfUlzQmf8YzSpo=;
        b=H5PknNvXOcdoqKx+kwboaVEzPwIxsy8iTiOuXPBoKrvxZrvff/NHnZO0SCD/esV5EV
         96vB2dD0NEEe2hVWcsDjanBlVccV02OVDkyo9Fi35G5gIli5fpwTLQ1/DhTSSElQtqw3
         QjXXBkH7uF5Yk+o0EZUhFW52Q2uBtWHaV3vjd4KjgGYtLH9wOG8PTZAIlWGPZDrv+N0+
         KSejel3HjapS1dlzcUWmOU5peQTNPMI3cdmGLo5a4HhkwFpiDhuPae2g4SAphbbW4Z7v
         lr9Dxs5qfLvXuFIE4FyuDutXNIvcr9p3X/FDlRLZYFg2HXD7Dc8tCJGkLMAodNQ5Bk4d
         1bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EZN/Mb9B2RBK+4vJv1FC96FcsAOneNfUlzQmf8YzSpo=;
        b=shSdbARO4/UzX90FjRyhH54O+NBeKe7GOzWQpz6tMIqzH579mHyIwoDo1huYyIlPwK
         gY2Yb7ocJMJ8BvHsCg6x2Lk07ZrTHW3DU0kWgIR6ZSfu7dp76zngd3q3ETeudqkSZS93
         2n9DWvrdpCyLgadB2NVDGWNiyzGM7czEij83YRtnk0UbHrYiwTzef5Kdy4wtglhpNZPD
         fVzFylLLKbKYYAFdPYYLI6dAKrRfKRyt7veXNaLego2C2Sj1O747r4OsCtuUaHsON4xa
         im1PaCOMsAjhbyKLSK3VzNjx97w6uli5b5hV2x0FjUw6osuoA4sA9gqGjrXl7Pn5E9Fn
         s3PQ==
X-Gm-Message-State: AOAM531Ey5jE+sXDqYWqa7xKXjy3Tcb2dC25d6jzKK8SfKA2auVXybkh
        hQsp9XfL/cgDJ3GKH2+N8btadGFm0nCuZBclFXh7bMvJBk4=
X-Google-Smtp-Source: ABdhPJweHtPNddzbjVxxaJgcnLLKzvGHZuom97c5W0HpCOFIEflJMlwkhfznKCxKm7nFo8hP/LS+5/yNBPgaB9QxksA=
X-Received: by 2002:a9f:2b44:0:b0:35c:d462:f54c with SMTP id
 q4-20020a9f2b44000000b0035cd462f54cmr1522321uaj.22.1652404367193; Thu, 12 May
 2022 18:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zMMMir6_ut=fb7gGj0Merzsc9vksG3fmt9JazCvk2=WA@mail.gmail.com>
In-Reply-To: <CAK3+h2zMMMir6_ut=fb7gGj0Merzsc9vksG3fmt9JazCvk2=WA@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Thu, 12 May 2022 18:12:36 -0700
Message-ID: <CAK3+h2z74LZ5OFQxNDktex8WYxpYhycQxaWt=KqqW3ZsTu1nwg@mail.gmail.com>
Subject: Re: bpf selftest compiling error
To:     bpf <bpf@vger.kernel.org>
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

On Thu, May 12, 2022 at 5:49 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Hi,
>
> I cloned the bpf-next and tried to compile the bpf selftest.
>
> first I got error
>
> "
> CC      /usr/src/bpf
> next/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
>
> make[1]: *** No rule to make target
> '/usr/src/bpf-next/tools/include/asm-generic/bitops/find.h', needed by
> '/usr/src/bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o'.
> Stop.
>
> I could not find find.h in
> /usr/src/bpf-next/tools/include/asm-generic/bitops/find.h but I found
> it in /usr/src/bpf-next/tools/include/linux/find.h, copied it to
> /usr/src/bpf-next/tools/include/asm-generic/bitops, seems resolved the
> problem,
>
> then I got another error below,
>
>   CLNG-BPF [test_maps] map_kptr.o
>
> progs/map_kptr.c:7:29: error: unknown attribute 'btf_type_tag' ignored
> [-Werror,-Wunknown-attributes]
>
>         struct prog_test_ref_kfunc __kptr *unref_ptr;
>
>                                    ^~~~~~
>
> /usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:176:31:
> note: expanded from macro '__kptr'
>
> #define __kptr __attribute__((btf_type_tag("kptr")))
>
>                               ^~~~~~~~~~~~~~~~~~~~
>
> progs/map_kptr.c:8:29: error: unknown attribute 'btf_type_tag' ignored
> [-Werror,-Wunknown-attributes]
>
>         struct prog_test_ref_kfunc __kptr_ref *ref_ptr;
>
>                                    ^~~~~~~~~~
>
> /usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:177:35:
> note: expanded from macro '__kptr_ref'
>
> #define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
> "
>
> my clang is 12.0.1 and installed new clang from llvm github repository
>
> clang version 15.0.0 (https://github.com/llvm/llvm-project.git
> e91a73de24d60954700d7ac0293c050ab2cbe90b)
>
> it resolved the problem, but now I got error
>
>   GEN-SKEL [test_progs] test_bpf_nf.skel.h
>
> libbpf: failed to find BTF info for global/extern symbol 'bpf_skb_ct_lookup'
>
> Error: failed to link
> '/usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.o': Unknown
> error -2 (-2)
>
> make: *** [Makefile:508:
> /usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.skel.h]
> Error 254
>
> running out of ideas on how to fix the compiling error. I hope I am
> not doing something wrong :)

I recompiled the bpf-next kernel tree after clang 15 installation with
make bzImage; make modules; make and then recompiled bpf selftest, all
compiling errors are gone, sorry for the noise.
