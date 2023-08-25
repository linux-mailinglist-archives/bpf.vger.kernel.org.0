Return-Path: <bpf+bounces-8550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A57881E5
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09011C20F37
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6EB7495;
	Fri, 25 Aug 2023 08:16:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21731FD3
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:16:52 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E3F1FDB;
	Fri, 25 Aug 2023 01:16:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb54226e7so8430411fa.1;
        Fri, 25 Aug 2023 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692951409; x=1693556209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8qLj5FUc1HhOX88AvZf8qe/nxQqPd0JSuX7WV1LK3U=;
        b=QudLEjSJlDE45jVoEgorqd0O1/1o52LiTv+IUWE3+Q4kLt3FSYk4lFY1k/MmckslrS
         Ny8HAH25hgJLJCseBArQHnzPegrUqhZvJ9U/rFTPy1Zixp7vgoiGsqmcXhzVVhp/ohfx
         /cfIl58Kz5TRBMe4Rs3066BHLCnkeVH29hFB0GVtJgyVEIfvz8KChIaKghujCFesHEfP
         /ABdIhXP6HXT/5W5QGJRYRngC8VItUNd2HOebK7ZddhM/Vqou5SsjvTfls+9IIHzutIn
         fUMV+fvdncrSZZ6iCbFKzZoNkoQjdiNFWZkl2k3OBVoo8kaJBCnKKdmYxVCm2Uf+U4hi
         lnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951409; x=1693556209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8qLj5FUc1HhOX88AvZf8qe/nxQqPd0JSuX7WV1LK3U=;
        b=QV4p1atzPBLOW/Vexs+0pGDpufrGIKOeBZquVlCn7+05beW9eGRQ1/qWtl9wjRarFD
         75glVY33QYkFru3ddAbcydB5liKxWwAhx55MPi2fs2Yi3rRPtGTTJZGChWow3x9zttuq
         cu/4lub9f451gElaMGErcnQOe9B6IuflQQwpamIWhOKWSOmLP7lbr4WxA+nYWZv2Oi9g
         Rc50xEf8J2BPaJcajqfO9W1dtYAxA2+TaeOYZ+h9zTtVHtcOBASgMc5rWLryikP7L+AT
         Uegrf2HxQx1TyNloBeEH3E3qpB+6jERzs/he2dy6M7u+PHBMAdk4OMaO0ktLDfJy69dJ
         97Kg==
X-Gm-Message-State: AOJu0Yy9u/G3IKVkIShqLReugIq8lsw9qdIvwmctQSzJ86nslD2uXhCf
	uTRM/Z3C0bFrFShx1hrWg2NDKRXTwQOvqGfieFA=
X-Google-Smtp-Source: AGHT+IEwWMFcF3PSUNciUBFIp0EsqEp8/V+IZeJyYDTcpXHSu308bUJ5h4tVSR5Y5sRVVgNI8erohhczVg+T5VTRM04=
X-Received: by 2002:a05:651c:b94:b0:2b6:9f95:8118 with SMTP id
 bg20-20020a05651c0b9400b002b69f958118mr7640239ljb.7.1692951408422; Fri, 25
 Aug 2023 01:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com> <ad5ef9ee-7fa7-b945-a303-2bdcdeb0e740@huawei.com>
In-Reply-To: <ad5ef9ee-7fa7-b945-a303-2bdcdeb0e740@huawei.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 25 Aug 2023 10:16:37 +0200
Message-ID: <CANk7y0gxHpes-O4z6_+qW=b-ubkbc3Lf1=rxhkSjEU6=uR27sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] bpf, riscv: use BPF prog pack allocator
 in BPF JIT
To: Pu Lehui <pulehui@huawei.com>
Cc: bjorn@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, conor.dooley@microchip.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 10:06=E2=80=AFAM Pu Lehui <pulehui@huawei.com> wrot=
e:
>
>
>
> On 2023/8/24 21:31, Puranjay Mohan wrote:
> > Changes in v1 -> v2:
> > 1. Implement a new function patch_text_set_nosync() to be used in bpf_a=
rch_text_invalidate().
> >     The implementation in v1 called patch_text_nosync() in a loop and i=
t was bad as it would
> >     call flush_icache_range() for every word making it really slow. Thi=
s was found by running
> >     the test_tag selftest which would take forever to complete.
> >
> > Here is some data to prove the V2 fixes the problem:
> >
> > Without this series:
> > root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
> > test_tag: OK (40945 tests)
> >
> > real    7m47.562s
> > user    0m24.145s
> > sys     6m37.064s
> >
> > With this series applied:
> > root@rv-selftester:~/src/selftest/bpf# time ./test_tag
> > test_tag: OK (40945 tests)
> >
> > real    7m29.472s
> > user    0m25.865s
> > sys     6m18.401s
> >
> > BPF programs currently consume a page each on RISCV. For systems with m=
any BPF
> > programs, this adds significant pressure to instruction TLB. High iTLB =
pressure
> > usually causes slow down for the whole system.
> >
> > Song Liu introduced the BPF prog pack allocator[1] to mitigate the abov=
e issue.
> > It packs multiple BPF programs into a single huge page. It is currently=
 only
> > enabled for the x86_64 BPF JIT.
> >
> > I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed =
now.
> >
> > This patch series enables the BPF prog pack allocator for the RISCV BPF=
 JIT.
> > This series needs a patch[3] from the ARM64 series to work.
>
> Is there a new version for arm64 currently? Maybe we could submit this
> patch first as a separate patch to avoid dependencies.

Okay, I will send that patch as a separate patch because it is needed for a=
ll
architectures.

>
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > Performance Analysis of prog pack allocator on RISCV64
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > Test setup:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Host machine: Debian GNU/Linux 11 (bullseye)
> > Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
> > u-boot-qemu Version: 2023.07+dfsg-1
> > opensbi Version: 1.3-1
> >
> > To test the performance of the BPF prog pack allocator on RV, a stresse=
r
> > tool[4] linked below was built. This tool loads 8 BPF programs on the s=
ystem and
> > triggers 5 of them in an infinite loop by doing system calls.
> >
> > The runner script starts 20 instances of the above which loads 8*20=3D1=
60 BPF
> > programs on the system, 5*20=3D100 of which are being constantly trigge=
red.
> > The script is passed a command which would be run in the above environm=
ent.
> >
> > The script was run with following perf command:
> > ./run.sh "perf stat -a \
> >          -e iTLB-load-misses \
> >          -e dTLB-load-misses  \
> >          -e dTLB-store-misses \
> >          -e instructions \
> >          --timeout 60000"
> >
> > The output of the above command is discussed below before and after ena=
bling the
> > BPF prog pack allocator.
> >
> > The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The =
rootfs
> > was created using Bjorn's riscv-cross-builder[5] docker container linke=
d below.
> >
> > Results
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > Before enabling prog pack allocator:
> > ------------------------------------
> >
> > Performance counter stats for 'system wide':
> >
> >             4939048      iTLB-load-misses
> >             5468689      dTLB-load-misses
> >              465234      dTLB-store-misses
> >       1441082097998      instructions
> >
> >        60.045791200 seconds time elapsed
> >
> > After enabling prog pack allocator:
> > -----------------------------------
> >
> > Performance counter stats for 'system wide':
> >
> >             3430035      iTLB-load-misses
> >             5008745      dTLB-load-misses
> >              409944      dTLB-store-misses
> >       1441535637988      instructions
> >
> >        60.046296600 seconds time elapsed
> >
> > Improvements in metrics
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > It was expected that the iTLB-load-misses would decrease as now a singl=
e huge
> > page is used to keep all the BPF programs compared to a single page for=
 each
> > program earlier.
> >
> > --------------------------------------------
> > The improvement in iTLB-load-misses: -30.5 %
> > --------------------------------------------
> >
> > I repeated this expriment more than 100 times in different setups and t=
he
> > improvement was always greater than 30%.
> >
> > This patch series is boot tested on the Starfive VisionFive 2 board[6].
> > The performance analysis was not done on the board because it doesn't
> > expose iTLB-load-misses, etc. The stresser program was run on the board=
 to test
> > the loading and unloading of BPF programs
> >
> > [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org=
/
> > [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gma=
il.com/
> > [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gma=
il.com/
> > [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
> > [5] https://github.com/bjoto/riscv-cross-builder
> > [6] https://www.starfivetech.com/en/site/boards
> >
> > Puranjay Mohan (3):
> >    riscv: extend patch_text_nosync() for multiple pages
> >    riscv: implement a memset like function for text
> >    bpf, riscv: use prog pack allocator in the BPF JIT
> >
> >   arch/riscv/include/asm/patch.h  |   1 +
> >   arch/riscv/kernel/patch.c       | 113 ++++++++++++++++++++++++++++++-=
-
> >   arch/riscv/net/bpf_jit.h        |   3 +
> >   arch/riscv/net/bpf_jit_comp64.c |  56 +++++++++++++---
> >   arch/riscv/net/bpf_jit_core.c   | 113 +++++++++++++++++++++++++++----=
-
> >   5 files changed, 255 insertions(+), 31 deletions(-)
> >



--=20
Thanks and Regards

Yours Truly,

Puranjay Mohan

