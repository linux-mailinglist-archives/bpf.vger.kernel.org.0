Return-Path: <bpf+bounces-3036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C57388AC
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361D82812B6
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBC19511;
	Wed, 21 Jun 2023 15:19:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A395C15E;
	Wed, 21 Jun 2023 15:19:56 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE1212F;
	Wed, 21 Jun 2023 08:19:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b46d4e1b0aso63373751fa.2;
        Wed, 21 Jun 2023 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687360793; x=1689952793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFy+7jY3Q/B3fIYTXq5qOshlUqCtAeH0fFjxezMJ7mU=;
        b=GOBaPld/+7/uckPmlyvUEOrUHbnzb/xeQVb9ttphaPlOVx7SyWpw3q1EZ9lqCOrFr1
         f8VlC75jrLsv+1oSumRkFGEobcO2HjohE6wMZ/Lkv73OS2pSAfCwpH0uaQ4sE0JSC+Db
         A14lHcRRcAU/PcHq9jab/BUjltkYhk9zTXsbt4bD2qH/PkTs4Jdwc2JxFcE1SymsO7qs
         peyVC9iKCNhEfaCkgylo0eYlRMhRaYETf3cPqeXd5Bcjfub2Dq7JSFQXnM5nIrIqv38f
         Hz8O6R7OtyG1OrGo3a+TncT2DvoDQcNUVfteo64tKc82njjnV2xrFc95C0DCJEDf+UhT
         RJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687360793; x=1689952793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFy+7jY3Q/B3fIYTXq5qOshlUqCtAeH0fFjxezMJ7mU=;
        b=ZcjmTmzLTeH+JHCtK4DwggY1k1fl1+o6RhPe/68sSSdcKN1/aa/PPjFtPNBAB4w7bN
         DCyeEL7GK7tQ0VR391LBX/lLE5/fax0algd4wRPlpRcc8s8Xwex+TJ7z/qm32/gzhoct
         G+cbezmTkx2fgBcia0Cupp58cwXCBZn0plUYa61b7Kvt9P99XchL/7goBa6qHvzxbc2q
         b+EB+Dt4CbQKdWf2KrHEhY8v4fuEn0Afo8rFofPN3XVLdmYrL3KADzCF+lg+J6G+LR0h
         0fWGv/gB2+l0Jt7U/2F8qYMj9UqawcNwdn2ztTYoHtKtYVAB6nPMs9wY2uIbzXwHmbaY
         1vEg==
X-Gm-Message-State: AC+VfDx46UPcP271zzroK5ty7XfHqPagfN8+MglklxdCEWE4VDkOZRMw
	Z0yabaAPWIo9l+qt60GQIWaaFJ1E+t7D85M6l54=
X-Google-Smtp-Source: ACHHUZ7S366xJDGv2BenqM0RSR5nG3v/w66oTeggW0Zt6a61/Wjn/ZeU0yVAL/ODGB0B6G6jG4VWc+DojP3NyAQ/DmI=
X-Received: by 2002:a2e:80c9:0:b0:2b1:c039:e977 with SMTP id
 r9-20020a2e80c9000000b002b1c039e977mr9673072ljg.16.1687360792618; Wed, 21 Jun
 2023 08:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <CA+G9fYvwriD8X+kmDx35PavSv-youSUmYTuYTfQ4oBWnZzVRUQ@mail.gmail.com>
 <CANk7y0imD3tK1Jox_V_f1vfzFi2tPhUzGOA_mLLkYy-VDHdncg@mail.gmail.com> <CA+G9fYuK4FWaLizcuVyW3ApR6fcgjMccYp3YxdAm61BOedXxzQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuK4FWaLizcuVyW3ApR6fcgjMccYp3YxdAm61BOedXxzQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 21 Jun 2023 17:19:41 +0200
Message-ID: <CANk7y0g9Qhe4H+WTbrsEUa_XXn_GkXWDOE4kP1icbxfJyri8XQ@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, 
	Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Wed, Jun 21, 2023 at 4:41=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Wed, 21 Jun 2023 at 19:46, Puranjay Mohan <puranjay12@gmail.com> wrote=
:
> >
> > Hi,
> >
> > On Wed, Jun 21, 2023 at 3:39=E2=80=AFPM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Wed, 21 Jun 2023 at 18:27, Mark Rutland <mark.rutland@arm.com> wro=
te:
> > > >
> > > > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > > > Following boot warnings and crashes noticed on arm64 Rpi4 device =
running
> > > > > Linux next-20230621 kernel.
> > > > >
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > >
> > > > > boot log:
> > > > >
> > > > > [   22.331748] Kernel text patching generated an invalid instruct=
ion
> > > > > at 0xffff8000835d6580!
> > > > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1]=
 PREEMPT SMP
> > > >
> > > > This indicates execution of AARCH64_BREAK_FAULT.
> > >
> > > I see kernel panic with kselftest merge configs on Juno-r2 and Rpi4.
> >
> > Is there a way to reproduce this setup on Qemu?
>
> Not reproducible on Qemu-arm64.
> I see only on arm64 devices Juno-r2 and Rpi4.
>
> >
> > I am able to build the linux-next kernel with the config given below.
> > But the bug doesn't reproduce in Qemu with debian rootfs.
> >
> > I guess I would need the Rootfs that is being used here to reproduce it=
.
> > Can you point me to the rootfs for this?
>
> Here is the link for rootfs - OE one.
> https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2RVA7dHPf73agY0g=
DJD6XEdBQBI/images/juno/

I tested this rootfs and couldn't reproduce on Qemu. Now, I will try
to use my raspberry pi and try to reproduce this.

Thanks.

>
> >
> > Thanks,
> > Puranjay
> >
> > > metadata:
> > >   git_ref: master
> > >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > >   git_sha: 15e71592dbae49a674429c618a10401d7f992ac3
> > >   git_describe: next-20230621
> > >   kernel_version: 6.4.0-rc7
> > >   kernel-config:
> > >     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35=
ia3YDkqaoV6ztyqdW/config
> > >   artifact-location:
> > >     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35=
ia3YDkqaoV6ztyqdW/
> > >   toolchain: gcc-11
> > >   build_name: gcc-11-lkftconfig-kselftest
> > >
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
>
> - Naresh



--
Thanks and Regards

Yours Truly,

Puranjay Mohan

