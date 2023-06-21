Return-Path: <bpf+bounces-3030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6817738758
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163B6281110
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115B617720;
	Wed, 21 Jun 2023 14:41:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0214101EA
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 14:41:31 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B91FCA
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 07:41:09 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-440bc794fcdso1193939137.3
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358468; x=1689950468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+4gmWWpq7Djs7g2QPfPh4TUyGT/CtkLCGk8CipnQN0=;
        b=PDUMfmFQYAMB9vCmB0Ttn4YY59y81gbLnOttuI3SXA3hvMlhcNUlMys3cJxMKNvkIn
         R0jyaB2SqQFBVjvACAj8dvUUMmZAXHpF9aJeD3ojF92pNf7oBSdvyYk5tq6g1Ux86zkQ
         9JWneBdpO5hhTq0dvZYdUDMbAF/aQ5QQHliarM5V6a25fv31RWp3+Ess0ufl6nRRaXtz
         tfJI3RMDuC6LBt/zQD0lsJHRJMesm4CTp3QJKF/vGKt5rDjl5Ei1Q5UpHghp/VSkf887
         UwOvoyATy6XdSDzN1sUR6KGdyX9fN1kCKfS5NZWY6dZIJlPAuRCjGk20P4/h42gXLiPJ
         4xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358468; x=1689950468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+4gmWWpq7Djs7g2QPfPh4TUyGT/CtkLCGk8CipnQN0=;
        b=TIDsm3zNyoyrj8F0zMSfniadRoHrtl85XSWpG0uZaL3VVRzWwXkKdsznGF4MJ92FuI
         eO1/cUSeV6/e3+dvTAtx95J6SorsFccmehErZ1PI+7FI1HY8DZTQkk1CqsUQGZ7xxG7J
         g1GhTv/OZzql+uzp2oJgkRRo7x5vonTgg6UE1IlxlzTiasyvu/yuCb3U4N5PnfvzFG9P
         2NOMFqBwjUO7JWntBZSRhNy62KK2eIgBg0xe7TWF0cc6PS7PQRoyUYdNREe/5idF2Hfu
         TjkWe0XhtCOcvTN0NedOsgB2KQlCOphiIHObeWJMs7xHZmQPmgodMOZhJYsxfjA5i9kr
         2apw==
X-Gm-Message-State: AC+VfDwsnGE8Ng3GJTyZUwX3+2Mj6B1/ZReAzb3+W7aMOKcjb1UqExu3
	X8VENH3e6gdLAMeUGpgWB+avLcEtXr7LwdT0yfo2gg==
X-Google-Smtp-Source: ACHHUZ4dq1LdhGzp3OOX38Raaet+ZVvDOyLhKykwG3qnsrV/Eq5wqqTteVExZp7zyq0CSly4JMNNtgMuIM2LuwsGjYs=
X-Received: by 2002:a67:f99a:0:b0:440:92ac:a909 with SMTP id
 b26-20020a67f99a000000b0044092aca909mr6641454vsq.28.1687358468495; Wed, 21
 Jun 2023 07:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <CA+G9fYvwriD8X+kmDx35PavSv-youSUmYTuYTfQ4oBWnZzVRUQ@mail.gmail.com>
 <CANk7y0imD3tK1Jox_V_f1vfzFi2tPhUzGOA_mLLkYy-VDHdncg@mail.gmail.com>
In-Reply-To: <CANk7y0imD3tK1Jox_V_f1vfzFi2tPhUzGOA_mLLkYy-VDHdncg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Jun 2023 20:10:57 +0530
Message-ID: <CA+G9fYuK4FWaLizcuVyW3ApR6fcgjMccYp3YxdAm61BOedXxzQ@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, 
	Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 21 Jun 2023 at 19:46, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jun 21, 2023 at 3:39=E2=80=AFPM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 21 Jun 2023 at 18:27, Mark Rutland <mark.rutland@arm.com> wrote=
:
> > >
> > > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > > Following boot warnings and crashes noticed on arm64 Rpi4 device ru=
nning
> > > > Linux next-20230621 kernel.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > boot log:
> > > >
> > > > [   22.331748] Kernel text patching generated an invalid instructio=
n
> > > > at 0xffff8000835d6580!
> > > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] P=
REEMPT SMP
> > >
> > > This indicates execution of AARCH64_BREAK_FAULT.
> >
> > I see kernel panic with kselftest merge configs on Juno-r2 and Rpi4.
>
> Is there a way to reproduce this setup on Qemu?

Not reproducible on Qemu-arm64.
I see only on arm64 devices Juno-r2 and Rpi4.

>
> I am able to build the linux-next kernel with the config given below.
> But the bug doesn't reproduce in Qemu with debian rootfs.
>
> I guess I would need the Rootfs that is being used here to reproduce it.
> Can you point me to the rootfs for this?

Here is the link for rootfs - OE one.
https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2RVA7dHPf73agY0gDJ=
D6XEdBQBI/images/juno/

>
> Thanks,
> Puranjay
>
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git_sha: 15e71592dbae49a674429c618a10401d7f992ac3
> >   git_describe: next-20230621
> >   kernel_version: 6.4.0-rc7
> >   kernel-config:
> >     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia=
3YDkqaoV6ztyqdW/config
> >   artifact-location:
> >     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia=
3YDkqaoV6ztyqdW/
> >   toolchain: gcc-11
> >   build_name: gcc-11-lkftconfig-kselftest
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

- Naresh

