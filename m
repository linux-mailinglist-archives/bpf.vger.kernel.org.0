Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E255F1532
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiI3Vsy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiI3Vsv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:48:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41737182744
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:48:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 29so7610279edv.7
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QxVyG4LW97IEnGQ0KgXwhdd9wIQTUWqCRW4u5ieX6lE=;
        b=F6J8RSRAiSJivvWLIu859NF3H/Kqd8EkQY+SOG4ZtGq64kJntwfeW0k8FqCF8bwcKE
         h4zpSSNu48w4VJsaz8XaX14ligwj9EDPLaHew23RvlmaPJ1HejfauKoLTua9P44aMZ4m
         4c0iYEtVciGL6rsoOpEWB+4G7l9z8SUSfhtOc1Qtq0TYJJy/bFuzTIDXZo0d48v98qTi
         RUVcT+DfvRFOt//JamWMNuMkjtw6G9MNZpv91D7rLFQ4Fr8JkMCekbDebgHIQxkl53h1
         s9alz+gcPQzHHN8hOJk1wYLP8xLpYE73t1hlvxa2oaYPdstkAWjT3f77r6droke1PDHA
         D7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QxVyG4LW97IEnGQ0KgXwhdd9wIQTUWqCRW4u5ieX6lE=;
        b=XnK6+YGLnW3ckNx8EkpDLdDHapQsZRh3vBMbubUJrrSQyEg8ztC2CNY38Obe/X1XTo
         yGdwuRrjIki8cOboZz8gDLif532D00FECbZkCawG/eWovE29fOotgrcsfSedX1fcAgi0
         MJ5lqkZiwsK2ai9+sVPUDvzTWcLlMN8UD8D4QSXmHqGawRZoZIIrRfsfJRMCGPcoP2bu
         nwhSVMf/A9VlTveuqtnDlsG4CyoYLaWjvpYszELnDPjsZIRMDVjSOtD+tmetrXgbRidU
         Kg+6OFZdRwEp1fBOsOwcI4PCLshusdQtVS0REn4JG+jEVINZ/bHeohRxGLQ5R+/PR7KO
         wHcw==
X-Gm-Message-State: ACrzQf0jUfnoZVu9FN994kJ2830wbS5I+O2tZdK7caUE5uNPA8Q4aG1q
        5VkGiJQqOEddp5VcoHz+iAxNBX8jK2B+Nj+53/I4RVOcCNA=
X-Google-Smtp-Source: AMsMyM672sdDuPxkBN9BBlS2sCDK6V0mXJtyNEgPLbtXY0Axwm2uCFIt9Vm/LyDcOmqsnB7oLxlO4qDuZQ6tfUooFgE=
X-Received: by 2002:a05:6402:529a:b0:458:2a37:88b1 with SMTP id
 en26-20020a056402529a00b004582a3788b1mr8548168edb.209.1664574528714; Fri, 30
 Sep 2022 14:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <CACbfJv8tn5dZmz=6+SMC4HZV05s-vnV2Nq19pC0D=eTLUu91Pg@mail.gmail.com>
 <877d1loocx.fsf@oracle.com>
In-Reply-To: <877d1loocx.fsf@oracle.com>
From:   Johnny young <johnny96.young@gmail.com>
Date:   Fri, 30 Sep 2022 14:48:37 -0700
Message-ID: <CACbfJv8hxB7Fw0KACjTqm+dWEbwMg4tJ2CSXTVx7yfdcYGECXQ@mail.gmail.com>
Subject: Re: Is BTF info sufficient enough for BPFTrace and other debug tools
 to run ?
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Stephen,

Thank you for the detailed explanation. I hope that after your work is
done for drgn as mentioned and the necessary work is done from the
debug tool side,  then the debug tools will rely on the kernel
internal symbol table and BTF only in the future.  That's wonderful.

Best,

On Thu, Sep 29, 2022 at 2:35 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Johnny young <johnny96.young@gmail.com> writes:
> > Hello BPF
> >
> > I understand that CONFIG_DEBUG_INFO_BTF=y will generate .BTF and
> > .BTF_xx  sections in the kernel image which are much smaller than
> > those DWARF sections.  But I also try to understand how BTF can impact
> > bpftrace and the existing debug tools:
> >
> > 1) If the kernel is built with CONFIG_DEBUG_INFO_BTF=y, can
> > bpftrace relies on BTF only without kernel_devel ?
> >
> > 2) Can the existing kernel debugging tools like crash(1) or
> > kgdb(1) take advantage of BTF ?
>
> Hi Johnny,
>
> I can't answer all your questions but I can chime in regarding
> debuggers. BTF could provide information to both of these debuggers, but
> currently neither of them know how to use it. There's a few reasons and
> challenges.
>
> 1. Kernel and module BTF today only includes the type information
>    necessary to describe all functions, and percpu variables. Most
>    debuggers would also like to know the types of global variables. I've
>    got a patch series [1] which allows pahole (which generates the
>    kernel & module BTF) to output information for global variable
>    declarations as well.
>
> 2. Assuming you had the BTF, you'd also need a symbol table.  The kernel
>    has kallsyms, which is an internal symbol table, and most debuggers
>    today don't know how to read that - instead, they rely on the symbol
>    table from the ELF debuginfo file. I frequently work with a debugger
>    library called drgn [2], and I've got a branch out for review [3]
>    which enables drgn to read the kallsyms. In order to do that,
>    debuggers need to be able to *find* the kallsyms table, so I added
>    information to the vmcoreinfo note in the commits 5fd8fea935a1
>    ("vmcoreinfo: include kallsyms symbols") and f09bddbd8661
>    ("vmcoreinfo: add kallsyms_num_syms symbol").
>
> 3. Assuming you have symbol table access and the BTF is complete enough
>    for you to use it for real debugging, then your debugger still needs
>    to have logic to *find* the BTF and parse it (probably with libbpf).
>    I've got a branch for drgn [4] which implements BTF parsing on top of
>    the kallsyms parsing logic. With those things together, you get a
>    debugger which relies on nothing except data it finds inside the
>    kernel, and it works well enough.
>
> So the short answer is - no, currently there is no debugger (that I know
> of) which can leverage BTF. But it's in the works for drgn, and once we
> get there with drgn, I'd hope to see that developers for other debuggers
> might see the power of it and consider implementing it.
>
> [1]: https://lore.kernel.org/bpf/20220826184911.168442-1-stephen.s.brennan@oracle.com/
> [2]: https://drgn.readthedocs.io/
> [3]: https://github.com/osandov/drgn/pull/177
> [4]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
>
> >
> > 3) If the kernel is built with CONFIG_DEBUG_INFO_BTF=y, are the
> > symbolic info and types info in the debug-info section replaced with
> > BTF formatted info?
>
> No, BTF is generated _in addition to_ the existing type information. BTF
> doesn't store "symbolic info" i.e. symbol table data, so it couldn't
> replace that data. It only stores type information, so hypothetically it
> could be used instead of DWARF .debug_types data, but in practice that
> doesn't happen.
>
> Stephen
>
> >
> > 4) Given the current upstream development effort for BTF, can we run
> > bpftrace without LLVM now ? and can we run bpftrace without the help
> > of kernel header files (kernel-devel) ?
> >
> > 5) Has bpf CO-RE become reality now?
> >
> > Thank you!
> > Johnny
