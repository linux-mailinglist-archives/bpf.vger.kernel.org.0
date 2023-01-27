Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31CB67DADF
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 01:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjA0Anr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 19:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjA0Anp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 19:43:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA36457CD
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:43:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q8so2393664wmo.5
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iTRfEeUkn143KWE9f5r8t1UEuBaHqihMC2L3zACrOeA=;
        b=Sc741u2tcvoApZkVK64f42q/O6mUFrTiGQocdL+8MOwsYU5SOhSzUy7N3ELAED+nGj
         XXF0ECXjIkl6GN8FkJiDJKgUU98PE/IUT5RgsmYCQ57U7EtxTQ7YhmgI57W33RkiwuXQ
         Y8M0SEV/Wsn/KM2uYuACcW4xOg/wAFK0SJcA3ZGSrItEqJNgT0RT1qoErxe1xKJXjb7k
         vzpUIatGUy1Y4vEt5sYyWOSw20CUcfPNq9R7Lduv7xAnjf/eWHEIakXfrbIVJ1v1sl5p
         Mkw2+aVcn+X+zFSo4jxgkcqINzuRh79ndNSxbM3YzqG7/3TNe2oi6sdc1O05XOLDAqr0
         UytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTRfEeUkn143KWE9f5r8t1UEuBaHqihMC2L3zACrOeA=;
        b=bkHYBHmEQxksV35DEYJhHLVs89wr8e3mWAiRNGKT4oYGI99JCFNw+EGHsS+xWRHyLo
         t6wvOiP8BEOXFTmf85noKEsViTvhXCI03wDblQ25n3I56q9m3HkCdkpSns3czFSrgFhF
         ojgOCTqleaGZzvq1KV5cqi1909oVnz0lD0VVHl5mKYGaf11zJKVQ9H8lF5vKYKlEG7Wj
         2t/8SZyA9CqzvA9bm4QT5rwSR16Mcqd6VwnJNP4h3uiwIcrjUYL1RjI9JcJ9ihTPZkef
         Ib3ioFxBREMRfBaCoPE6W/j/NYMqOadc8HTBj9JuwzfnCSCBqQdC2+fj8lzF0Yw/PJGR
         KzfQ==
X-Gm-Message-State: AFqh2krvMd47/gtPPacr82RotO444mmGPof/BuLJNghKd6vS8K4WpS4c
        MIHg7m8eL1BkdS5OT4Vqmq4=
X-Google-Smtp-Source: AMrXdXs7dauPSdhsznj8Moz9rZhyB42I0F337hrbdLmoYA+kZRUvqJRw3CMpr6zOuMNYbL5tvh5bGg==
X-Received: by 2002:a05:600c:1906:b0:3da:1d51:ef9d with SMTP id j6-20020a05600c190600b003da1d51ef9dmr38277927wmq.15.1674780222977;
        Thu, 26 Jan 2023 16:43:42 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e38-20020a05600c4ba600b003db11dfc687sm2726786wmp.36.2023.01.26.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:43:42 -0800 (PST)
Message-ID: <45c747ba5c1e6a77b916a8204db5d77e887ae1d1.camel@gmail.com>
Subject: Re: [RFC bpf-next 0/5] test_verifier tests migration to inline
 assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Fri, 27 Jan 2023 02:43:41 +0200
In-Reply-To: <20230126032530.nib7ov5gtt3knmc4@macbook-pro-6.dhcp.thefacebook.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
         <CAEf4Bzbu2zctHntHNRVnEDa_FJz405Ld1Sb58wvJA+JvYdS+Ag@mail.gmail.com>
         <20230126032530.nib7ov5gtt3knmc4@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-01-25 at 19:25 -0800, Alexei Starovoitov wrote:
> On Wed, Jan 25, 2023 at 05:33:42PM -0800, Andrii Nakryiko wrote:
> >=20
> > > __naked void invalid_and_of_negative_number(void)
> > >=20
> > > {
> > >         asm volatile (
> > > "       r1 =3D 0;                                         \n\
> >=20
> > Kumar recently landed similarly formatted inline asm-based test, let's
> > make sure we stick to common style. \n at the end are pretty
> > distracting, IMO (though helpful to debug syntax errors in asm, of
> > course). I'd also move starting " into the same line as asm volatile:
>=20
> +1. Pls drop \n.
> You don't have \n anyway in migrator's README on github.

I have --newlines switch there :)

>=20
> > asm volatile ("                       \
> >=20
> > this will make adding/removing asm lines at the beginning simpler (and
> > you already put closing quote on separate line, so that side is taken
> > care of)
>=20
> +1
>=20
> Also pls indent the asm code with two tabs the way Kumar did.
> I think it looks cleaner this way and single tab labels align
> with 'asm volatile ('.

Will do.

>=20
> > > All in all the current script stats are as follows:
> > > - 62 out of 93 files from progs/*.c can be converted w/o warnings;
>=20
> out of 98 in verifier/*.c ?

Sorry, yes, messed up twice in this statement:
- meant verifier/*.c not progs/*.c;
- counted 93 files after migrating one file picked to be an examle.
I just double checked and there 94 *.c files in that directory on
bpf-next master branch.

>=20
> > > - 55 converted files could be compiled;
> > > - 40 pass testing, 15 fail.
>=20
> I would land this 40 now and continue step by step.
>=20
> > >=20
> > > By submitting this RFC I seek the following feedback:
> > > - is community interested in such migration?
> >=20
> > +1
> >=20
> > This is a great work!
>=20
> +1

Thanks.

>=20
> > > - if yes, should I pursue partial or complete tests migration?
> >=20
> > I'd start with partial
> >=20
> > > - in case of partial migration which tests should be prioritized?
> >=20
> > those that work out of the box?
> >=20
> > > - should I offer migrated tests one by one or in big butches?
>=20
> Can you do one patch one file in verifier/*.c that would map
> to one new file in progs/ ?

Will do.

>=20
> > >=20
> > > [1] https://github.com/eddyz87/verifier-tests-migrator
>=20
> Having this link in patch series is enough.
> The 'migrator' itself doesn't need to be in the kernel tree.

