Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80AE60C1A2
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 04:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJYCXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 22:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJYCXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 22:23:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2911D18C8
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 19:23:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y14so9156308ejd.9
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 19:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DGTBEWq2/9K9ra1zChERwd/ddcmqw2Da6UA/ARvWCM4=;
        b=F9vNOirLbQV3nRuqeJNzFwUokbz3WKmwBHuJQ7G0wdqrimx8PG9DJVSd46DHeURrFe
         Ni2kInlzCzCBxIl5sTz50xGoQ9Jb970XS1WQwdxn4aGBrTi1aFqMJMKihXmGVj6h1OaH
         s2fkTazrg7U+/E5WJaec4OYMrrCYlCKffKMTdxdidAW+ihtn2ml7eLlC0DWmZ5X7zs/H
         lHvBZYY/lNCA7+veKtw0LKy1S/mxHGpsNP2PNMjvxZ0A0uxrLDOERI9j9rtLOgp4sPZv
         1NtT2mVEnzHR7rdmxV3UdbjMf97mkrKaGdCYkGnD30uCl4wbHDhoM8OdFiwu7IQOuC24
         uFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGTBEWq2/9K9ra1zChERwd/ddcmqw2Da6UA/ARvWCM4=;
        b=RbH+LqvsDcQbxIwrrRaF0EKiVHY7bHy0SUUoVsloBJbbE8HzXSNsDYzHBJcGqfyQId
         Kx5cMAI9PspVS6dhU/XzxH/EQ4F4zXjd7+0s1awYh/+T49flZ/Oq6qEbSrSdk4VZoZ+b
         ExDJuQl6oh6vRnUBEZQSnyUJOkGsNM5tMjC12Ostic9dYAAg/6t267HKltc1nYFpBEra
         NVC6gzpIRzvE7268iWG31l9dYBRdvz/rkdEVFNRsBniPhsC1+rPFDbERRc5Ks0Z6ixWe
         gt3lRbBxEufRzkDDlDGck6H/tqMbO0Yg+ihUZSsalxKtCJSJ/+SxiRq8L91plTEAynOa
         K13w==
X-Gm-Message-State: ACrzQf29sA9JdpV2gExZYV4r7CmdTZZ1qrA8YFk2Gg8y1/Q2feNrQOyO
        yjsZ8YndJuuyIzSIA2fO4s+8Kevl/To/JgfOnas=
X-Google-Smtp-Source: AMsMyM4qsocwy2fyUh7srX9tdO8wNiP0nU+kDkwmQdETbv28HTeRd0sO2WJ2SRUT9TMxpiCCQlC6eZRkD3RVdypejzc=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr31017377ejc.676.1666664614384; Mon, 24
 Oct 2022 19:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221020123704.91203-1-quentin@isovalent.com> <20221020123704.91203-7-quentin@isovalent.com>
 <CAADnVQKHk88YFcTE55GXu7HwQkTb0TGNpnrB8Ec7PVZy9uVhOw@mail.gmail.com>
 <1dc2c77a-2dea-25a4-fa64-b65460c7f1cb@isovalent.com> <CAADnVQ+4ErnQCZSz=hVqv_FJ9UHTV5LqsTWwP2ve_ujqabwOgw@mail.gmail.com>
In-Reply-To: <CAADnVQ+4ErnQCZSz=hVqv_FJ9UHTV5LqsTWwP2ve_ujqabwOgw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Oct 2022 19:23:23 -0700
Message-ID: <CAADnVQJGvrQ1AVC9EFKw_mWEk-K7wfHKMdeBEgr7zJoGYQFhxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
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

On Mon, Oct 24, 2022 at 11:40 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 4:05 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2022-10-20 10:49 UTC-0700 ~ Alexei Starovoitov
> > <alexei.starovoitov@gmail.com>
> > > On Thu, Oct 20, 2022 at 5:37 AM Quentin Monnet <quentin@isovalent.com> wrote:
> > >>
> > >> +
> > >> +/* This callback to set the ref_type is necessary to have the LLVM disassembler
> > >> + * print PC-relative addresses instead of byte offsets for branch instruction
> > >> + * targets.
> > >> + */
> > >> +static const char *
> > >> +symbol_lookup_callback(__maybe_unused void *disasm_info,
> > >> +                      __maybe_unused uint64_t ref_value,
> > >> +                      uint64_t *ref_type, __maybe_unused uint64_t ref_PC,
> > >> +                      __maybe_unused const char **ref_name)
> > >> +{
> > >> +       *ref_type = LLVMDisassembler_ReferenceType_InOut_None;
> > >> +       return NULL;
> > >> +}
> > >
> > > Could you give an example before/after for asm
> > > that contains 'call foo' instructions?
> > > I'm not sure that above InOut_None will not break
> > > symbolization.
> >
> > Hi Alexei, I ran a quick test and it doesn't seem we lose any
> > information. Building from:
>
> Thanks for checking. The output looks good.

Please rebase. It doesn't apply anymore.
