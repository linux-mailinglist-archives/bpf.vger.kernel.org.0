Return-Path: <bpf+bounces-9063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FC78EE51
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF7D2813DE
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D51171D;
	Thu, 31 Aug 2023 13:16:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7727D7481
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 13:16:08 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE24CF3;
	Thu, 31 Aug 2023 06:16:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso14338521fa.0;
        Thu, 31 Aug 2023 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487764; x=1694092564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElGTcVHLy75b73RkQix7jGCTm6pcHFnJzehv0DUiBQU=;
        b=lrx7zCc+nvlE/uQBwq4PIAioFt3TJF65Arn4hJ6XfeQofE7gmmeaBT2BeE0ru6rF8q
         1JHf148gb8DcyrmDo7OeXmrapPgRGrE5Eji/CbGI1aRYFDwyCdp45A5WO9MiVD0Nn3pv
         gykk/d4cY5nw2QR8k8eU5NJjhCXSJGAE7BQwWbh1epNxBBfa4wujIGd4bzBT7uZdk1d6
         YVu1Ls/VR7cqLUEF3fAj4pifAp8/vHS5s4xnsv/u6nyUJ3OGV6Rfv2BCqc3d7B1XYXAO
         JNRHzH7q9Nz9Eez5+2nVTOdH4mkKvPj9hWSh8/tbdmKe/nLoAzlAERL4oznPX77DAjhq
         miHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487764; x=1694092564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElGTcVHLy75b73RkQix7jGCTm6pcHFnJzehv0DUiBQU=;
        b=XPKTE6/MPvaDs4kxo8DElxqAhKu77ovozsSJGHRgVDfID0JC+fhJI/Nx1TYjk8Jy0b
         fMOfH7vZwub5Km0U1oZCwPnV6yXM7DqUgjeVf6YR35qNuG639g0Bnc9Y/s8u1SXxp41h
         4nyWnpyCeVXbBamhhFfYacBnfVDKwZEEXO6YhXOMIr8kboFWYWCJzRCtj+Ouffj2F5wn
         uQnqbe+hysGSuhTpkVruSB20mREy1pTlusU87rcD/WWzIsU062x6qQ02/0o1OYRVsC8k
         z4Skqs5fhwWM40R5TG1h5oCqxiOgTMjXVgTc0GXAqOv5BZoHx78fi7awTMqM5ojEYoPp
         wvwQ==
X-Gm-Message-State: AOJu0YxUN1uR3+lLJokMbaMJOf15/X9jFi/HKKc13y5d1MjauZ1GBEus
	azAycywBaGmbN5icxACa3dE0wvwnuBaRTesacZc=
X-Google-Smtp-Source: AGHT+IFIidBA270cNOZse7F227U3vdMwLmh2tRMnRoiOic7ci1qpx4vgWbFlRsY/Ps5hpfUmi/KYXIK4pYeqSY8DBoc=
X-Received: by 2002:a2e:6816:0:b0:2bd:1f8d:e89d with SMTP id
 c22-20020a2e6816000000b002bd1f8de89dmr4526357lja.3.1693487763836; Thu, 31 Aug
 2023 06:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mhng-ac1c6e6a-8f27-4539-83bb-6c10ff4d264e@palmer-ri-x1c9> <9e31c290-f1f0-ecfd-c68b-51f8d706db2c@iogearbox.net>
In-Reply-To: <9e31c290-f1f0-ecfd-c68b-51f8d706db2c@iogearbox.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 31 Aug 2023 15:15:52 +0200
Message-ID: <CANk7y0i1zGRQRa+cD6gbBSx9pSy1hor=4oUzXNBfbrObvykqQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf, riscv: use BPF prog pack allocator
 in BPF JIT
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, bjorn@kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, pulehui@huawei.com, 
	Conor Dooley <conor.dooley@microchip.com>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, kpsingh@kernel.org, 
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 12:48=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/30/23 3:54 PM, Palmer Dabbelt wrote:
> > On Wed, 30 Aug 2023 01:18:46 PDT (-0700), daniel@iogearbox.net wrote:
> >> On 8/29/23 12:06 PM, Bj=C3=B6rn T=C3=B6pel wrote:
> >>> Puranjay Mohan <puranjay12@gmail.com> writes:
> >>>
> >>>> Changes in v2 -> v3:
> >>>> 1. Fix maximum width of code in patches from 80 to 100. [All patches=
]
> >>>> 2. Add checks for ctx->ro_insns =3D=3D NULL. [Patch 3]
> >>>> 3. Fix check for edge condition where amount of text to set > 2 * pa=
gesize
> >>>>     [Patch 1 and 2]
> >>>> 4. Add reviewed-by in patches.
> >>>> 5. Adding results of selftest here:
> >>>>     Using the command: ./test_progs on qemu
> >>>>     Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAI=
LED
> >>>>     With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILE=
D
> >>>>
> >>>> Changes in v1 -> v2:
> >>>> 1. Implement a new function patch_text_set_nosync() to be used in bp=
f_arch_text_invalidate().
> >>>>     The implementation in v1 called patch_text_nosync() in a loop an=
d it was bad as it would
> >>>>     call flush_icache_range() for every word making it really slow. =
This was found by running
> >>>>     the test_tag selftest which would take forever to complete.
> >>>>
> >>>> Here is some data to prove the V2 fixes the problem:
> >>>>
> >>>> Without this series:
> >>>> root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
> >>>> test_tag: OK (40945 tests)
> >>>>
> >>>> real    7m47.562s
> >>>> user    0m24.145s
> >>>> sys     6m37.064s
> >>>>
> >>>> With this series applied:
> >>>> root@rv-selftester:~/src/selftest/bpf# time ./test_tag
> >>>> test_tag: OK (40945 tests)
> >>>>
> >>>> real    7m29.472s
> >>>> user    0m25.865s
> >>>> sys     6m18.401s
> >>>>
> >>>> BPF programs currently consume a page each on RISCV. For systems wit=
h many BPF
> >>>> programs, this adds significant pressure to instruction TLB. High iT=
LB pressure
> >>>> usually causes slow down for the whole system.
> >>>>
> >>>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the a=
bove issue.
> >>>> It packs multiple BPF programs into a single huge page. It is curren=
tly only
> >>>> enabled for the x86_64 BPF JIT.
> >>>>
> >>>> I enabled this allocator on the ARM64 BPF JIT[2]. It is being review=
ed now.
> >>>>
> >>>> This patch series enables the BPF prog pack allocator for the RISCV =
BPF JIT.
> >>>> This series needs a patch[3] from the ARM64 series to work.
> >>>>
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>>> Performance Analysis of prog pack allocator on RISCV64
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Test setup:
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Host machine: Debian GNU/Linux 11 (bullseye)
> >>>> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
> >>>> u-boot-qemu Version: 2023.07+dfsg-1
> >>>> opensbi Version: 1.3-1
> >>>>
> >>>> To test the performance of the BPF prog pack allocator on RV, a stre=
sser
> >>>> tool[4] linked below was built. This tool loads 8 BPF programs on th=
e system and
> >>>> triggers 5 of them in an infinite loop by doing system calls.
> >>>>
> >>>> The runner script starts 20 instances of the above which loads 8*20=
=3D160 BPF
> >>>> programs on the system, 5*20=3D100 of which are being constantly tri=
ggered.
> >>>> The script is passed a command which would be run in the above envir=
onment.
> >>>>
> >>>> The script was run with following perf command:
> >>>> ./run.sh "perf stat -a \
> >>>>          -e iTLB-load-misses \
> >>>>          -e dTLB-load-misses  \
> >>>>          -e dTLB-store-misses \
> >>>>          -e instructions \
> >>>>          --timeout 60000"
> >>>>
> >>>> The output of the above command is discussed below before and after =
enabling the
> >>>> BPF prog pack allocator.
> >>>>
> >>>> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. T=
he rootfs
> >>>> was created using Bjorn's riscv-cross-builder[5] docker container li=
nked below.
> >>>>
> >>>> Results
> >>>> =3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Before enabling prog pack allocator:
> >>>> ------------------------------------
> >>>>
> >>>> Performance counter stats for 'system wide':
> >>>>
> >>>>             4939048      iTLB-load-misses
> >>>>             5468689      dTLB-load-misses
> >>>>              465234      dTLB-store-misses
> >>>>       1441082097998      instructions
> >>>>
> >>>>        60.045791200 seconds time elapsed
> >>>>
> >>>> After enabling prog pack allocator:
> >>>> -----------------------------------
> >>>>
> >>>> Performance counter stats for 'system wide':
> >>>>
> >>>>             3430035      iTLB-load-misses
> >>>>             5008745      dTLB-load-misses
> >>>>              409944      dTLB-store-misses
> >>>>       1441535637988      instructions
> >>>>
> >>>>        60.046296600 seconds time elapsed
> >>>>
> >>>> Improvements in metrics
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>>>
> >>>> It was expected that the iTLB-load-misses would decrease as now a si=
ngle huge
> >>>> page is used to keep all the BPF programs compared to a single page =
for each
> >>>> program earlier.
> >>>>
> >>>> --------------------------------------------
> >>>> The improvement in iTLB-load-misses: -30.5 %
> >>>> --------------------------------------------
> >>>>
> >>>> I repeated this expriment more than 100 times in different setups an=
d the
> >>>> improvement was always greater than 30%.
> >>>>
> >>>> This patch series is boot tested on the Starfive VisionFive 2 board[=
6].
> >>>> The performance analysis was not done on the board because it doesn'=
t
> >>>> expose iTLB-load-misses, etc. The stresser program was run on the bo=
ard to test
> >>>> the loading and unloading of BPF programs
> >>>>
> >>>> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.=
org/
> >>>> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@=
gmail.com/
> >>>> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@=
gmail.com/
> >>>> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
> >>>> [5] https://github.com/bjoto/riscv-cross-builder
> >>>> [6] https://www.starfivetech.com/en/site/boards
> >>>>
> >>>> Puranjay Mohan (3):
> >>>>    riscv: extend patch_text_nosync() for multiple pages
> >>>>    riscv: implement a memset like function for text
> >>>>    bpf, riscv: use prog pack allocator in the BPF JIT
> >>>
> >>> Thank you! For the series:
> >>>
> >>> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> >>> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >>>
> >>> @Alexei @Daniel This series depends on a core BPF patch from the Arm
> >>>                  series [3].
> >>>
> >>> @Palmer LMK if you have any concerns taking the RISC-V text patching
> >>>          stuff via the BPF tree.
> >>
> >> Palmer, did the riscv PR already go to Linus?
> >
> > Not yet, I usually send on Friday mornings -- and I also generally send=
 two, as there's some stragglers/fixes for the second week.  I'm fine takin=
g it (Bjorn just poked me), can someone provide a base commit? Bjorn says i=
t depends on something in Linus' tree, so I'll just pick it up as a straggl=
er for next week.
>
> Okay, sgtm.
>
> > Also, do you mind sending an Ack?
>
> Bj=C3=B6rn / Puranjay, just to clarify since the arm64 series did not lan=
d, you are referring
> to this one as a dependency [0], right? Meaning, you'd route [0] + this s=
eries via riscv
> PR to Linus then during this merge win.
>
> If yes, could one of you send the complete 4-patch series with the prior =
Acks from [0] + this
> series collected to both bpf+riscv list (with the small request to extend=
 the commit desc
> in [0] a bit to better document implications of the change itself for oth=
er JITs)? After a
> final look and if BPF CI goes through we can then ack as well and unblock=
 the routing.
>
> Thanks,
> Daniel
>
>    [0] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gm=
ail.com/

Hi Daniel,

I have sent the v4[0] of this with the core patch included.

[0]https://lore.kernel.org/all/20230831131229.497941-1-puranjay12@gmail.com=
/

Thanks.
Puranjay

