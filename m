Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45B5BF17C
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiITXqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 19:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiITXqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 19:46:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962A4B0FF
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:46:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 29so6214924edv.2
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XyX1Kef9E9hASj1mZWt5zeqFpIYJqPJDmGXWtdnth48=;
        b=DrYjlxyKSVfyVb7snrHv8srFC/wekkIcix1QaJCNlzGkh/dFE8GJCLlABUIf7YKRzl
         OZpButH6a1MWlIy0paizJaDorssNlwr9eU/3FEj2PDdLh+MDn1RBqEDEgCFnzcdnQMzp
         cZjbigc4EL5xVpQnFCLGK5NrUHvk5Vc4y26uHFS+CNmqGts2i+OAMmMm9av/7qsArGCa
         pZD198gwrS47oUNBwSrt0BD1DcjJkgTEOcEdCsqAZTkIn4rnrpdqbrm9UxlE1DftlG6U
         TQDMPEfGvitTG99zxLU760gmVD6DZvIFA8Rdry1lf7UtXHLUKhvDUeSHBI2KzEjOy5WY
         e1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XyX1Kef9E9hASj1mZWt5zeqFpIYJqPJDmGXWtdnth48=;
        b=3EFV6lUDyI7erwzuda91NUvJUfEIOGYwRkPIxHw9IScN4zBaSqQUk6JKBhc8u6o7yw
         sg4lBNwuXCHCB5CbP1udK+o7pjGtQp+k5inut79KV6BW09JltjGiKymln/YNCaICvIJ3
         BWIP9siBOziybSFtXJHabm7eX+ASJiRkpDYgZpCukZyxFacrhSdL595ARcaRHzsL7chX
         dni+wh1q+yt/NFLoTVQ0hKUNWFE6oJuJGkF3vPNuC1JOzHDlVUf4+IXTnIOW32KlB4c0
         S6U30tm6XDCv7MRrk9jMzjbZ0QrJFNDTj4oexgcPNwHO7Y5u1Hm+v22doR8+pwBfHTHi
         FoPQ==
X-Gm-Message-State: ACrzQf0sbPY5nfuzTSEcGlX4vhnZkNxR0bznbiMOo6ofcdzrL/AjEjSb
        +/JuE0lQ9DNx2ZqzDf4e6CUNw8FR56bfV4tiR9ymGXqz
X-Google-Smtp-Source: AMsMyM4Qy5NtFmy+71nGTsFxD+BJ2HARJA5Hef/UK5oBVitt1Y+T2aT4x/E2OFfCahla2D5ZJ2c5Ekh9lTK19RzswqE=
X-Received: by 2002:a05:6402:1a4f:b0:44e:f731:f7d5 with SMTP id
 bf15-20020a0564021a4f00b0044ef731f7d5mr22094025edb.357.1663717570503; Tue, 20
 Sep 2022 16:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyifpJR4uwZwvpkc@infradead.org> <DM4PR21MB3440671C5D0E203B95EAF6B4A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440671C5D0E203B95EAF6B4A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 20 Sep 2022 16:45:59 -0700
Message-ID: <CAADnVQL_ADWR=DShdehzpzQskw1vrW2kDuPKE0FCZZsqk8NvFA@mail.gmail.com>
Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, bpf <bpf@vger.kernel.org>
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

On Tue, Sep 20, 2022 at 12:58 PM Dave Thaler <dthaler@microsoft.com> wrote:

> > > +   For ISA versions prior to 3, Clang v7.0 and later can enable
> > > +``BPF_ALU`` support with
> > > +   ``-Xclang -target-feature -Xclang +alu32``.
> >
> > I also suspect the clang notes would be better off in a separate document
> > from the main ISA.
>
> No one else raised concerns at LPC when I explicitly asked this, but I
> have no strong opinion either way other than whatever we do for Linux
> notes and for Clang notes, the answer should be the same.

It feels to me it would be better to document the latest ISA
instead of diverging into -mcpu=v1,v2,v3 differences.
So the standard would include all insns as of writing of the doc
including atomics.
Older compilers and compilers with certain flags may generate
a subset of full ISA, but that can be a footnote or 'clang notes'.
No one needs to read a history of how instructions were added
over the last 8 years. That bit is in git logs anyway.
