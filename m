Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F363296C
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKUQ3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 11:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKUQ3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 11:29:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DBEC6BE1
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 08:29:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C614C6130B
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 16:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C071C433B5
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669048174;
        bh=tx7jP67HFo49+y0VIsIc/GUAg3vqpQei3XqgeIoEai4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qgsh95QJWz6KW2TsZQKfGzC5n2wfJY+mA95j2PX7AjmEOwhrNrE+Yk2QCbTWquqbX
         UjFN3TRnGibFnvHp7wkz48vNb3QcoeY8mWRGACWRElnhG8+Blz6NVD/Da2LMTsSYqk
         B1LzX1mrjnaUZJ4bDRdP86sdiNMkqoolf4I7JgQDpl3gmZKEm4eeeEs/OmI2j3cysA
         U9ZR6aYKSIe49Zmies3zqpxLML6p43vqgkfZ9/wwjezxaJEtgFI8rnediLPdcdgRh0
         EZzBj5B7VikXqmIO3zJojcINSuX3L2R6J4xUDFlVoB3PzwvQDc+q6/hBbAPz5I16KB
         tWRQbISfWVQ5A==
Received: by mail-ej1-f48.google.com with SMTP id f27so29877878eje.1
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 08:29:34 -0800 (PST)
X-Gm-Message-State: ANoB5pl/k8apJ/4zwVpI0VwvUkdObaYzZ9JSatcEoOlJkTmqdvOkhweg
        9yeRikZ+4IxIHGfXtbZuYZ0U6+0NSZAdDcOo/R8=
X-Google-Smtp-Source: AA0mqf4iiHsRycYhTs3zx4H4PbZSAw1I/zHfeOe5675IDkA8GtzjNlii+FL6u9e+2BilQ1vI4/gpKu82b6MfZWidSc4=
X-Received: by 2002:a17:906:a198:b0:7b4:bc42:3b44 with SMTP id
 s24-20020a170906a19800b007b4bc423b44mr8124302ejy.101.1669048172416; Mon, 21
 Nov 2022 08:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20221117202322.944661-1-song@kernel.org> <20221117202322.944661-2-song@kernel.org>
 <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net> <20221121155542.GA27879@lst.de>
In-Reply-To: <20221121155542.GA27879@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Nov 2022 09:29:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com>
Message-ID: <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 8:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 21, 2022 at 04:52:24PM +0100, Daniel Borkmann wrote:
> >> +void *execmem_fill(void *dst, void *src, size_t len)
> >> +{
> >> +    return ERR_PTR(-EOPNOTSUPP);
> >> +}
> >
> > Don't they need EXPORT_SYMBOL_GPL, too?
>
> None of these should be exported.  Modular code has absolutely no
> business creating executable mappings.

I added these exports for test_vmalloc.ko. Is there a way to only export
them to test_vmalloc.ko but nothing else?

Thanks,
Song
