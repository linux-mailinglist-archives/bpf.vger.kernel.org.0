Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D58618A24
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKCVEJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKCVEH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BB26E0
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9912E62007
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0653EC43140
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667509446;
        bh=nseTDyxyu0yRm9gZT+OFw4Dhw1UAyXHDHko2gLKfinI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qMT8ajE9HpOjUvF3ngCGud3jLZw630zCFxPea8P644TVB6oZ1aiZxm4qFOikMFG/G
         X/MjikTe8THD4a2ve5KVJZybanlLm/UYLPish69/vjHtWKefOF3aFjLkqdIM4bY6Xb
         AcwGjrO2TirgEhQ1SX3NOShdmDxXr6Ntr2rvCcEuPBOI+EcF9YUc1c22K8ZkFwMC3N
         xeQfhEsPZDawtey6TVui3idmHGIa15qxqlQgy32EiZKM/kHV+ytGmEIEch2Qmfijsu
         swTnXlUJyW7xMByjIIF1dpjibZ/EjO/Uq8MbxlFzXfly1iquArcpFfddseN4wmz4G0
         isIRXB4qHXVOQ==
Received: by mail-ej1-f43.google.com with SMTP id 13so8645313ejn.3
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 14:04:05 -0700 (PDT)
X-Gm-Message-State: ACrzQf1c7qhVVzLjN24xwsZb7LP82zOH5Mpr5YsGeDL3VMkzbT/nj8o2
        7LKetzhbLiIG4pPCpwfQW0ZzC2USn7BjI0D7rTs=
X-Google-Smtp-Source: AMsMyM5+SExDA6gWyjMON5e/XKuPJGG6vDE35nbZ27zwUi5RdN79dqxVqX7NELDyhK2eWMgtZlV9HPjujhJ4RApDCUc=
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id
 nd15-20020a170907628f00b0072f58fc3815mr30383160ejc.719.1667509444205; Thu, 03
 Nov 2022 14:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221031222541.1773452-1-song@kernel.org> <20221031222541.1773452-3-song@kernel.org>
 <d298ae748f267a336f0089f6aa649e3291f1081a.camel@intel.com>
In-Reply-To: <d298ae748f267a336f0089f6aa649e3291f1081a.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 3 Nov 2022 14:03:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6QDrz=YW9UddAkGo4meZTwnmmRuSKkEZ6RiTOFutxX0g@mail.gmail.com>
Message-ID: <CAPhsuW6QDrz=YW9UddAkGo4meZTwnmmRuSKkEZ6RiTOFutxX0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 2/5] x86/alternative: support
 vmalloc_exec() and vfree_exec()
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 2, 2022 at 3:22 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-10-31 at 15:25 -0700, Song Liu wrote:
> > diff --git a/arch/x86/kernel/alternative.c
> > b/arch/x86/kernel/alternative.c
> > index 5cadcea035e0..73d89774ace3 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1270,6 +1270,18 @@ void *text_poke_copy(void *addr, const void
> > *opcode, size_t len)
> >         return addr;
> >  }
> >
> > +void *arch_vcopy_exec(void *dst, void *src, size_t len)
> > +{
> > +       if (text_poke_copy(dst, src, len) == NULL)
> > +               return ERR_PTR(-EINVAL);
> > +       return dst;
> > +}
>
> Except for this, there are no more users of text_poke_copy() right?
> Should it just be replaced with arch_vcopy_exec()?

I guess this is not really necessary, as we may have other use
cases for text_poke_copy(), and the text_poke_* calls make a good
API.

I won't object if folks agree removing text_poke_copy() for now is a
better approach.

Thanks,
Song
