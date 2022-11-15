Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F462A48C
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiKOVzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 16:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiKOVzA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 16:55:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649628E04
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B1161A4E
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 21:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A9CC433D7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668549298;
        bh=FkwNcIJqGGamLt011iLTJ7zJo/CK72Y6usvbBaNt3+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qr3500K/tqi1WqGzh7pn/bSvedry9IR239IEJQiUiOYwtBLKJaOqqRK4Cve+M4Oln
         uDCO9TTNABkmpOGEzKy21kTJAm1EDLlMQZ/4C+KJJGLeFhbyCKbySGepyKmm52VwiU
         mzFMhH3UAm7JzuuxiPziHQGxOntRP63xtVjz3/0QT8KzQI342WjwiBxPGyt6gsiBxo
         QQdMKxCpD7QhdmM3Lm6MPpGJkKwJlXqRHIPrTJGLXTr21kToBjJLjjaBjXLeQTBLn3
         xrcST5vE6IvtrD6cyR7KdQMt0IP6h2RRQB/9yS7doJO+Zvx/FcZYIutX+UlysGmliz
         h3Og0BtpZhl8w==
Received: by mail-ed1-f54.google.com with SMTP id i21so23902388edj.10
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:54:58 -0800 (PST)
X-Gm-Message-State: ANoB5pnp5D9uvRxM18xxU1lUhuNZdodlGEiVixNMbKs8J8kS+XV8ZfE9
        3WGZMNXLZPEdBWEP3uyvseyXy7VXcqy0pUJ+W1w=
X-Google-Smtp-Source: AA0mqf5a/6rdvupjvmUGbpWqbD57+Pf89dMK5ea/DHCCSjfoGocpQnumMVMIn2mRWl6RBaN5UJMEJroIEbZzcqgMeJk=
X-Received: by 2002:aa7:c684:0:b0:462:9bc2:d039 with SMTP id
 n4-20020aa7c684000000b004629bc2d039mr16900435edq.127.1668549296786; Tue, 15
 Nov 2022 13:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
In-Reply-To: <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Nov 2022 13:54:44 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com>
Message-ID: <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>, "Lu, Aaron" <aaron.lu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 9:34 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-11-14 at 17:30 -0800, Song Liu wrote:
> > Currently, I have got the following action items for v3:
> > 1. Add unify API to allocate text memory to motivation;
> > 2. Update Documentation/x86/x86_64/mm.rst;
> > 3. Allow none PMD_SIZE allocation for powerpc.
>
> So what do we think about supporting the fallback mechanism for the
> first version, like:
>
> https://lore.kernel.org/all/9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com/
>
> It helps the (1) story by actually being usable by non-text_poke()
> architectures.

I personally think this might be a good idea. We will need this when we use
execmem_alloc for modules. But I haven't got a chance to look at module code in
great detail. I was thinking of adding this logic with changes in module code.

Thanks,
Song
