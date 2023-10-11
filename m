Return-Path: <bpf+bounces-11917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52A7C561C
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEE01C20FF8
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AFE200D8;
	Wed, 11 Oct 2023 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRzZybWu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD7200C8
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 14:01:42 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE793
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 07:01:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5045cb9c091so9224933e87.3
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697032899; x=1697637699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUeu40L6qhxw4BZOnJMqKxdfg3MCHEWCwPe9Aia4Kas=;
        b=HRzZybWuBa5hz7s8ONUmtYGyGtiPT52r8QNV2Nxy1BNITwrr8yNrOzdxfvz+oHv8mb
         M271Y5V+YVmZmrkV5mVpYzCPQIbDE5AM4KqwAZ3dpqmk6phAgMgSmowmT9RnUVO4LAlT
         pbQQ1Z+B6ur09AUM1sgxh08RcaFZ8jYZs4Ru8QGWQclJC2Ax3+DgPla3LnQ14b3DmHN+
         6z1MnF8GZS8L/o831CM0zl1pmOcNSVjbtC69iSjQWZPIzfb7kAFbH/xgWu+KBRTSiSGE
         oGcj73ryXNf+gwIoKo4tWLRLrd1DZs7sSILj9jebfu50lLiyeypL2sMKh0d7kVfI1xSe
         JxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032899; x=1697637699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUeu40L6qhxw4BZOnJMqKxdfg3MCHEWCwPe9Aia4Kas=;
        b=tEfuf1ZEoR+jxOu5iRwGEsJ3gIF4Nn1nvZy78sCCKR3Kwcx3JVtasECzwJewXthEhw
         rXwt0MzythrYp2XGWjlCFyCc2DeAHIbFPDMdCLj62LDbqEObK2SkfZH7PBCyW0ImSySA
         3aQDA+Qc89qEHJ956+H/hYl+SxJ31oxeKkSqovtofTNmsjKxw7yjs8+dzPf1BvYIA4YA
         Gx3ovGcvrX4eqB5nOHaXh9n9zfW5mr62thzi/k/HKF+zMyVO5mgNXJI283uWNXjFdli1
         /1cPBgbI73sa2xFZrAUZXOEx/WwZExrHgM4eWOo2cmbnrUM59Ph5NYRg82qSVJvAoBXq
         9k/g==
X-Gm-Message-State: AOJu0Yy1LLJcuLy8LssRIyje3k4xn+inh74f4v+jxsapQlIO/DbLD03I
	bxACjiTwy15Qskm9KxpcfDiJipJqOw1a1/KwpAFV3fsDJIyJej39
X-Google-Smtp-Source: AGHT+IGLzdcrqfvz7o6dqVO3bhXeslEeZj1mtDTkc1HGkGDaeDhN3YIiIt8k7Jbr5rSMili2ixx5NmJlsfr5XEBm50g=
X-Received: by 2002:a19:4f0f:0:b0:503:389d:1cc1 with SMTP id
 d15-20020a194f0f000000b00503389d1cc1mr17004683lfb.22.1697032898714; Wed, 11
 Oct 2023 07:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310111838.46ff5b6a-oliver.sang@intel.com>
In-Reply-To: <202310111838.46ff5b6a-oliver.sang@intel.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 11 Oct 2023 16:01:27 +0200
Message-ID: <CANk7y0g-iaZfWCae=sJA34H39x7DcNBCaNF8yjXCy0RQhX5-vA@mail.gmail.com>
Subject: Re: [linux-next:master] [bpf/tests] daabb2b098: kernel-selftests.net.test_bpf.sh.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 3:20=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> hi, Puranjay Mohan,
>
> we reported same issue when this commit is a review patch as:
> https://lore.kernel.org/all/202309261451.8934f9ad-oliver.sang@intel.com/
>
> now we noticed this commit is in linux-next/master and we still observed
> failure.
>
> is there any requirements to run new tests? Thanks
>
>
> Hello,
>
> kernel test robot noticed "kernel-selftests.net.test_bpf.sh.fail" on:
>
> commit: daabb2b098e04753fa3d1b1feed13e5a61bef61c ("bpf/tests: add tests f=
or cpuv4 instructions")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 719136e5c24768ebdf80b9daa53facebbdd377c=
3]
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-60acb023-1_20230329
> with following parameters:
>
>         group: net
>
>
>
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.0=
0GHz (Cascade Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.san=
g@intel.com
>
>
>
> ....
> # timeout set to 1500
> # selftests: net: test_bpf.sh
> # test_bpf: [FAIL]
> not ok 13 selftests: net: test_bpf.sh # exit=3D1
> ....

The test "ALU_MOVSX | BPF_W" is failing for x86_64. This is a new test
added by my patch.
This is how the test looks:
{
                "ALU_MOVSX | BPF_W",
                .u.insns_int =3D {
                        BPF_LD_IMM64(R2, 0x00000000deadbeefLL),
                        BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
                        BPF_MOVSX32_REG(R1, R3, 32),
                        BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
                        BPF_MOV32_IMM(R0, 2),
                        BPF_EXIT_INSN(),
                        BPF_MOV32_IMM(R0, 1),
                        BPF_EXIT_INSN(),
                },
                INTERNAL,
                { },
                { { 0, 0x1 } },
 }

I am creating a build for testing on my end.

>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231011/202310111838.46ff5b6a-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

Thanks,
Puranjay

