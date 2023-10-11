Return-Path: <bpf+bounces-11919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911687C56D1
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18B11C20EC6
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5AF2033D;
	Wed, 11 Oct 2023 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTPBFArj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F222032C
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 14:29:34 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE690
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 07:29:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50325ce89e9so9160459e87.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697034570; x=1697639370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJDQD0YO+1hmRPj2gjzPqkberRxZIp9HO672Ebr5SVs=;
        b=DTPBFArjub7eQ2mxIxs/vgwUNrYRGMw9ggzTdhx5TLZgrx1pKJXbAeSurHFw662WID
         3bJB/bTTFhqH9Lj8X6pabFCx8WIdhWCXrp8xcYSkkAAdw8CjzCXQIXrCCNSgL+7DrU0Z
         p91pFwIxant1UNVdmcgnP+ESwGFHVQ2UNROKQxYwdyXGEoFIqMFKW0PC71fOlgYyUM14
         jRYVNJbec2hT4Y0ey+f0pLn0v2+gam/PwIJVzao4mGzN/VYgk50+fbR6JuKNUTuJtHVT
         eKuR3o0cZt31MpnFBiYhbR3FCZDRrmKSoBlaXQjrUgEqf7ppqbbe+ILk37Np9IBBzrHE
         kHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697034570; x=1697639370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJDQD0YO+1hmRPj2gjzPqkberRxZIp9HO672Ebr5SVs=;
        b=PA8zcXoE06TWizS5RUcw4a2IH8xt77hBC1STBiNT9mCoUQMazpNucLCecP4qyTr0LM
         i+x8VdaDK1XngxPG+nR9h+EXmqp4qhRu7D6ykrziu86AReHqbSL9/xo3Nf5AfuPUb41g
         +RQCMA1cCj3/cVZUBxf2yjwxXthLTu3j1uVYOPbbrzrzdfvQQjkZxSNCVgZoHZVZcXPr
         SLuYBHwn0ScHZ88CT/xReYIFmgMXvLOV8TVjGNVo34I+3xh3S/7hBkjCj4l/YeXJSFMK
         jnlcg1dci0I+bupcToyX/k0ZPYb1YoiU1MZs3Oj0W5BlBCpTqVx2U2drZay9Lq3WilzT
         vR1Q==
X-Gm-Message-State: AOJu0YxbulOFFD6ICq28NFXQ0YwWAhf87ZgDjga3Y51QJYsHa6O+SwQo
	OqndvrggAZp16CdrcJke9taINCf4yPnBUnpyblpnsXE4hFttkw4U
X-Google-Smtp-Source: AGHT+IGvpsYxD60ppYTEpXFCxXgv/0qAuvtG9murFtrfy8bO9HjYOUJ9widfOB70iHhjBWly6NJCO3PINQAE8KVmIWs=
X-Received: by 2002:ac2:4add:0:b0:506:947f:6b75 with SMTP id
 m29-20020ac24add000000b00506947f6b75mr7882826lfp.14.1697034569905; Wed, 11
 Oct 2023 07:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310111838.46ff5b6a-oliver.sang@intel.com> <CANk7y0g-iaZfWCae=sJA34H39x7DcNBCaNF8yjXCy0RQhX5-vA@mail.gmail.com>
In-Reply-To: <CANk7y0g-iaZfWCae=sJA34H39x7DcNBCaNF8yjXCy0RQhX5-vA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 11 Oct 2023 16:29:18 +0200
Message-ID: <CANk7y0jMMuqL12zGL-6Yvb2=4h15mHdMp3e8n-Sd+pHRj8wXxg@mail.gmail.com>
Subject: Re: [linux-next:master] [bpf/tests] daabb2b098: kernel-selftests.net.test_bpf.sh.fail
To: Yonghong Song <yonghong.song@linux.dev>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yonghong,

On Wed, Oct 11, 2023 at 4:01=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Wed, Oct 11, 2023 at 3:20=E2=80=AFPM kernel test robot <oliver.sang@in=
tel.com> wrote:
> >
> >
> > hi, Puranjay Mohan,
> >
> > we reported same issue when this commit is a review patch as:
> > https://lore.kernel.org/all/202309261451.8934f9ad-oliver.sang@intel.com=
/
> >
> > now we noticed this commit is in linux-next/master and we still observe=
d
> > failure.
> >
> > is there any requirements to run new tests? Thanks
> >
> >
> > Hello,
> >
> > kernel test robot noticed "kernel-selftests.net.test_bpf.sh.fail" on:
> >
> > commit: daabb2b098e04753fa3d1b1feed13e5a61bef61c ("bpf/tests: add tests=
 for cpuv4 instructions")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master 719136e5c24768ebdf80b9daa53facebbdd37=
7c3]
> >
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-60acb023-1_20230329
> > with following parameters:
> >
> >         group: net
> >
> >
> >
> > compiler: gcc-12
> > test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3=
.00GHz (Cascade Lake) with 32G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.s=
ang@intel.com
> >
> >
> >
> > ....
> > # timeout set to 1500
> > # selftests: net: test_bpf.sh
> > # test_bpf: [FAIL]
> > not ok 13 selftests: net: test_bpf.sh # exit=3D1
> > ....
>
> The test "ALU_MOVSX | BPF_W" is failing for x86_64. This is a new test
> added by my patch.
> This is how the test looks:

As you have worked more on cpu=3Dv4 instructions.
Is it a requirement that MOVSX32 can only have offset =3D 8/16 and never 32=
.
I know that MOVSX32 with offset=3D32 is equivalent to normal MOV32.

If this is a requirement then the below test is running an invalid
instruction and we can remove it from test_bpf.

> {
>                 "ALU_MOVSX | BPF_W",
>                 .u.insns_int =3D {
>                         BPF_LD_IMM64(R2, 0x00000000deadbeefLL),
>                         BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
>                         BPF_MOVSX32_REG(R1, R3, 32),
>                         BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
>                         BPF_MOV32_IMM(R0, 2),
>                         BPF_EXIT_INSN(),
>                         BPF_MOV32_IMM(R0, 1),
>                         BPF_EXIT_INSN(),
>                 },
>                 INTERNAL,
>                 { },
>                 { { 0, 0x1 } },
>  }
>
> I am creating a build for testing on my end.
>
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20231011/202310111838.46ff5b6a-=
oliver.sang@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>
> Thanks,
> Puranjay

