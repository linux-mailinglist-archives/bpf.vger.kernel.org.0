Return-Path: <bpf+bounces-3029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FF73869B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8312A1C20481
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6818C10;
	Wed, 21 Jun 2023 14:16:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2717ABF;
	Wed, 21 Jun 2023 14:16:56 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745F94;
	Wed, 21 Jun 2023 07:16:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so4832233e87.2;
        Wed, 21 Jun 2023 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687357013; x=1689949013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LR4PDkdrWuA9l6EMLBodrJpcuDoMtm6x2sjEnKK0/g=;
        b=gNpimUkP1cs4UTNo1wIvH1qZNiTeD/bZfYbPdos3JSpGi6pVBiYbcGA8IB9dm0Zr73
         XcicJY5BcOs3K4ePaCTtc42IxwXTCnyTzWFyBLHZFwD3RKnBJvSEwRz3g9ey0LiRo2qU
         KlyUVg8PXt1UiEuzPkP+eReAHyzvSV32fG1wgveLWYh3klx4OA6Q5UzqPaNxldQjFtET
         gkkcM1JJjBDJAKG6WJOz2moSX2ZpxnSsuOA7l/NaqMwhABK9HcdpKZEDOgIqHYvaO1b9
         3TjKKXBX8C3IurDigaqSNqETH+lGbcHDmz0nypKR7VtCjgCZHW0/9vaqvGfHWbL9oxao
         oMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687357013; x=1689949013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LR4PDkdrWuA9l6EMLBodrJpcuDoMtm6x2sjEnKK0/g=;
        b=InbLtiMv+cqObhgMmCiPsMdCKL8V61yfdTOJoWyi+0m6wkI5eJRmw0hwSuk0LP6x+W
         zSow9r6NXnijRPqgYkUYbpmifXmVWsNilSjfqeNC/Tm1nbc7gn2+LF2l/61b3XrzENbq
         cIhXadJuTv8uZ4u7DbnslEvH1BKQptW89rt6hQEk1jTeVTGQSAD2upoM1ShlAXXeAIhf
         NczKj0g0gO0YyNiDbZO1udVSijBnTXfxy5YSDY2ZXcOPnzTdc0Erf6PvrlylGbqUSjZl
         cfIKCouNgHxDMOwdptq9K4zsVb6vBdSS2/2DoDvvypv+35OzM+rpMpCEiQrsjLMBlXVK
         Ko1A==
X-Gm-Message-State: AC+VfDxZzdyM3oqRpkeKceJ37/EfqBXLqnpvPKTKhf0cZLtuppOn6034
	X4nsVFeDKP0/F+DWcF8Njxxje9LnB5wv07fNPAFI54DkeO+tTC8b
X-Google-Smtp-Source: ACHHUZ6EsUy2gEekvKGVwx2OrwqXQoMyqztFrXefrGmHMyoPNN6lvKi5cGJPxdCBDpK0pgPB6fvfY/HzgL7K7au/tS8=
X-Received: by 2002:a05:651c:1048:b0:2b5:828c:bfc7 with SMTP id
 x8-20020a05651c104800b002b5828cbfc7mr1616891ljm.19.1687357012701; Wed, 21 Jun
 2023 07:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <CA+G9fYvwriD8X+kmDx35PavSv-youSUmYTuYTfQ4oBWnZzVRUQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvwriD8X+kmDx35PavSv-youSUmYTuYTfQ4oBWnZzVRUQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 21 Jun 2023 16:16:41 +0200
Message-ID: <CANk7y0imD3tK1Jox_V_f1vfzFi2tPhUzGOA_mLLkYy-VDHdncg@mail.gmail.com>
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

On Wed, Jun 21, 2023 at 3:39=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Wed, 21 Jun 2023 at 18:27, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > Following boot warnings and crashes noticed on arm64 Rpi4 device runn=
ing
> > > Linux next-20230621 kernel.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > boot log:
> > >
> > > [   22.331748] Kernel text patching generated an invalid instruction
> > > at 0xffff8000835d6580!
> > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] PRE=
EMPT SMP
> >
> > This indicates execution of AARCH64_BREAK_FAULT.
>
> I see kernel panic with kselftest merge configs on Juno-r2 and Rpi4.

Is there a way to reproduce this setup on Qemu?

I am able to build the linux-next kernel with the config given below.
But the bug doesn't reproduce in Qemu with debian rootfs.

I guess I would need the Rootfs that is being used here to reproduce it.
Can you point me to the rootfs for this?

Thanks,
Puranjay

> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 15e71592dbae49a674429c618a10401d7f992ac3
>   git_describe: next-20230621
>   kernel_version: 6.4.0-rc7
>   kernel-config:
>     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia3Y=
DkqaoV6ztyqdW/config
>   artifact-location:
>     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia3Y=
DkqaoV6ztyqdW/
>   toolchain: gcc-11
>   build_name: gcc-11-lkftconfig-kselftest
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org

