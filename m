Return-Path: <bpf+bounces-6268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A62767798
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141B71C20A32
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C11F93F;
	Fri, 28 Jul 2023 21:29:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21F1DA42
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 21:29:22 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A463AA8
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 14:29:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so16155401fa.3
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690579758; x=1691184558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdlmSRg/Vnodlu/Nv8GvXnc5BvNmXJ0F/OVTOmJs8NM=;
        b=AMMioQVCALI8SzQHWcrCYlYpGbbbuOthBMWoCwbj3JoPQDvzYp96bYF3ENgdxzCskA
         KlaYW+LH9B3OfCBq5gsnqXjgP6BVKIM67rg/AWZEzh3rIX+fTiJvcHjM0PNZDJED5ISu
         BT7tC+CpFbw8HZzkFAYbWa1VFRwOSyVvSQL9fUc7jM1bwTW5uhg5SUbZUaKthOJxKX3v
         cLcSOqX2zGPQUEeh0mZ0og3DdufwByDkdVOZWoZQolZe8B8AnpelW01Lm68eCLvtuAoU
         DgZDnFbS7mdpg7JnUQ3lfdEnafP0ZE726W30zx5m0hMPgvYd8Um+23UaBURvaN/IPP0x
         w1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690579758; x=1691184558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdlmSRg/Vnodlu/Nv8GvXnc5BvNmXJ0F/OVTOmJs8NM=;
        b=k7JIIe3LXnbBzA5Bp9XKRT27rjSoot0HuIqRwnUOp/7xBFTkH2b7kc6JYI4o0JAD65
         W7EhBvnsQlk2948fohCgZmMwEqWnG98W6/q0xnBv5VFROGMDpHaIlV/rMDhO+ryd7oE8
         TyjPg5etgmXayYfQHdYzcq9VkNnM/ANYpYwflylzewZRRdf5P8FNDIZX4kfHfUJkmGFs
         tbsu8U8rF7I25R11wuQKKqAUPemKGmvVxbg+wLUnUONhgsYrW8ORe5B9hy2CjNeJnQKu
         /IPtDwJ7JT0h2N1cc8HICZYn+arbsW7ftuCZvfY1aETqEbz1kh7xO4yExkapJMERXxBY
         ZM6A==
X-Gm-Message-State: ABy/qLbKI1V1GVDzxoSylzwSDtDtxeVkEDSMVcl2vx2SbYJ/aT1apEtT
	6XjuMfuU4x6bsGgK09tkMTf16JuDHawGGABaFTU=
X-Google-Smtp-Source: APBJJlFcfQ+6k6WCpBiPoP0l2+S3SNqhnSv4wdvewioXO8V+4shUVUdSRFP9RMZnOvOp9Udzb6Vq/S8BcHFAl2NpmfA=
X-Received: by 2002:a2e:780b:0:b0:2b9:48f1:b193 with SMTP id
 t11-20020a2e780b000000b002b948f1b193mr2326545ljc.46.1690579758239; Fri, 28
 Jul 2023 14:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ila7dhmp.fsf@oracle.com> <5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev>
 <87o7jzbz0z.fsf@oracle.com> <146bc14b-e15c-6e62-1fa0-4e9e67c974c9@linux.dev>
 <87zg3jah2s.fsf@oracle.com> <6a102de2-2bd4-6933-e901-de00cda10045@linux.dev>
 <87v8e78w63.fsf@oracle.com> <CAADnVQLDGUSSCkhxjgt6bxxN7hOh7L-86-wzESp2Oo8SQ91hOg@mail.gmail.com>
 <a1371ac96bdca45a07366868d331410a9836204e.camel@gmail.com>
 <d10ca36d-7ae6-90bf-8c2a-671cafe8f5fb@linux.dev> <f8d9ec82dd2da5fc5d18228e70bfe68f959d7ed1.camel@gmail.com>
In-Reply-To: <f8d9ec82dd2da5fc5d18228e70bfe68f959d7ed1.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 14:29:06 -0700
Message-ID: <CAADnVQKaP-nvG_4xaf95QMuXUKTaMidHZBjP5aRciTo_7c=sFA@mail.gmail.com>
Subject: Re: Register encoding in assembly for load/store instructions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 9:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:

> >
> > For disassembler, we have stx as well may use w* registers with alu32.
> > In llvm BPFDisassembler.cpp, we have
> >
> >    if ((InstClass =3D=3D BPF_LDX || InstClass =3D=3D BPF_STX) &&
> >        getInstSize(Insn) !=3D BPF_DW &&
> >        (InstMode =3D=3D BPF_MEM || InstMode =3D=3D BPF_ATOMIC) &&
> >        STI.hasFeature(BPF::ALU32))
> >      Result =3D decodeInstruction(DecoderTableBPFALU3264, Instr, Insn,
> > Address,
> >                                 this, STI);
> >    else
> >      Result =3D decodeInstruction(DecoderTableBPF64, Instr, Insn, Addre=
ss,
> > this,
> >                                 STI);
> >
> > Maybe we should just do
> >
> >    Result =3D decodeInstruction(DecoderTableBPF64, Instr, Insn, Address=
,
> > this, STI);
> >
> > So we already disassemble based on non-alu32 mode?
> >
>
> Yonghong, Alexei,
>
> I have a prototype [1] that consolidates STW/STW32, LDW/LDW32 etc
> instructions in LLVM BPF backend, thus removing the syntactic
> difference. I think it simplifies BPFInstrInfo.td a bit but that's up
> to debate.
>
> Should I proceed with it?
>
> [1] https://reviews.llvm.org/D156559

Makes sense to me.

