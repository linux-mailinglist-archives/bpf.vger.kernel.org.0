Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1365B6461B7
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLGTaA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGT37 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:29:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEA0286E3
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:29:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8426D6197C
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 19:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDE1C43145
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670441397;
        bh=HsSJXmXPYCPPW/kSYTBNkKs8yHx1Pu2w6UyPJLVHU9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mXSATjcEjaB4Yrk9SF7Rnt8IlzNxoqDZJrH9iOCSAhRxX+lx9G1WGVC36lvVmj44B
         7feC4IB/HXSkjcBXFC7UoONHbUDqYnso72GsssjNyZLiJCB/T2kwKjZfxr20VykHD0
         euIvrgXkvEK6KjFZbXdskZ3pU2bWLCJapNSTWk//h3mCycSJBC2EGENugVuqpRDB4o
         YuPWOr3MCo2nOfAZnAVe0tE2l0vhXPJFlwkvcYXY1Ki/qrAOse5KYNHuprWEJJGHi9
         4NZxt932Ni3YJfUD3+pCmcDVKDTRA5Irvss3PS0rpelElAbMgMHarClPj2EfDDCe5B
         S4XpW6fBgfauA==
Received: by mail-ej1-f41.google.com with SMTP id vv4so16436232ejc.2
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:29:57 -0800 (PST)
X-Gm-Message-State: ANoB5pkscWu38JE3fh4ezKLesLzPmUJ6RzZz7EH1qQfwXOsKG7JepNLm
        pkDGoQ7pzAnVTu0qKGmHwjkF6dKyuRWdwnIAmq4=
X-Google-Smtp-Source: AA0mqf7DfxbzTIb1vawkuo8QNhB5zlsYy3+Z3M3gs0OrnjvDv/W4vUnCf/vNAeglk333f414zCaaDBCH/vGMerpfJ4o=
X-Received: by 2002:a17:907:7e86:b0:7af:bc9:5e8d with SMTP id
 qb6-20020a1709077e8600b007af0bc95e8dmr1077372ejc.3.1670441396081; Wed, 07 Dec
 2022 11:29:56 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx> <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx> <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx> <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
 <87v8mndy3y.ffs@tglx> <de7c70bc-94df-a372-ecfe-d2c707ad9014@csgroup.eu>
In-Reply-To: <de7c70bc-94df-a372-ecfe-d2c707ad9014@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Wed, 7 Dec 2022 11:29:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6eVZ3-EcqHagcjWBkcLXvUy1wu9OjwCY7VJEw_DS2nNA@mail.gmail.com>
Message-ID: <CAPhsuW6eVZ3-EcqHagcjWBkcLXvUy1wu9OjwCY7VJEw_DS2nNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 7, 2022 at 8:54 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 07/12/2022 =C3=A0 16:36, Thomas Gleixner a =C3=A9crit :
> >
> > The "use free space in existing mappings" mechanism is not required to
> > be PMD_SIZE based, right?
> >
> > Large page size, strict separation:
> >
> > struct mod_alloc_type_params {
> >       [MOD_ALLOC_TYPE_TEXT] =3D {
> >               .mapto_type     =3D MOD_ALLOC_TYPE_TEXT,
> >                  .flags               =3D FLAG_SHARED_PMD | FLAG_SECOND=
_ADDRESS_SPACE,
> >                  .granularity =3D PMD_SIZE,
> >                  .alignment   =3D MOD_ARCH_ALIGNMENT,
> >                  .start[0]    =3D MODULES_VADDR,
> >                  .end[0]              =3D MODULES_END,
> >                  .start[1]    =3D MODULES_VADDR_2ND,
> >                  .end[1]              =3D MODULES_END_2ND,
> >                  .pgprot              =3D PAGE_KERNEL_EXEC,
> >                  .fill                =3D text_poke,
> >                  .invalidate  =3D text_poke_invalidate,
> >       },
>
> Don't restrict implementation to PMD_SIZE only.
>
> On powerpc 8xx:
> - PMD_SIZE is 4 Mbytes
> - Large pages are 512 kbytes and 8 Mbytes.
>
> It even has large pages of size 16 kbytes when build for 4k normal page
> size.

IIUC, these customizations would fit nicely with this design. I will see ho=
w
much I can prototype with powerpc without the actual hardwares.

Thanks,
Song
