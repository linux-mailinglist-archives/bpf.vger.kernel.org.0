Return-Path: <bpf+bounces-8710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26C78915F
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A170C28185C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C41AA61;
	Fri, 25 Aug 2023 22:01:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE063193B2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:01:59 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3A26B2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:01:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so171124466b.2
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693000913; x=1693605713;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PhK+vI1oU3EItGfLcR2IVOBX5hUgc9Zh63/6e5LDqJg=;
        b=UW0TyFLOfGdIqYfszYK2Wr/UI33fsQgUFSwMj5jDgXZIeCaa9wI/QECzYjRYn1w52g
         ban9Iadxu4Tir/LjMxOObVWuQumosqrUlV/Supa73IOZX+DgFFRTh9SnKF9wgqKdGFX5
         4fkMkgY1x34m7YV9CL6cZdSvxZO3gP8Oy50BWLxNDUWbbUBg8wosZu2jeQQZ3tDKvPh0
         xSvVrWj4WtWoM3G/S3OYdmS4lEtGUHFbyzn3Jd1lvoqDvTwrwmQIaHjV3NNyRyx8Oa4R
         b+bLEYkks+hWgw6B6PLZBnzMCRwdNxctMSOD+s4vB/Ws3GsRSevsq9RgHtAzaA/zzYYn
         FHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000913; x=1693605713;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhK+vI1oU3EItGfLcR2IVOBX5hUgc9Zh63/6e5LDqJg=;
        b=HTF8NNB2jZsDVAR16Z6Br5HuMG472HVDif8Y5cxL5Dw65/t4jtybHLciQfSHkMiy7a
         hW1nh0hZdPL5z19XcdalYlo8Pjtki+rgiTUa+45uOVDtpL1pBIgdKYSUjIT3T+H9kQMV
         tEj7uJ2MNNjBTq8+7ZC5Yo3XttCMWpqlVG2jDvtkjqO/bkfvKR0+NLUce1ESB02I7tmO
         +FfGePVLwukHW4kLJEPCZ1dDr3SDtlVDZeyRpYnLxs3tWBC3fcl9IxcEvBq0p9cG0tq/
         D3IFQ7NmgPm5iQqZI6yZUvaKKqDTfFmVtYKxTpgkcNPULIF364Trt29vEg0/DMYRTLUZ
         7gQw==
X-Gm-Message-State: AOJu0YwUIPxFLTzupcKNagH2fwoN3gJuozP3Pd2lJWqPFg2ACC013TvA
	DJhnwO7dmZJXrU8GLNf1rfo=
X-Google-Smtp-Source: AGHT+IEzCvSVtfAjxro6vHtza6yekjbpsQrkCvrJXzP2uZSfTJoK6Ce/zjgeuqqlDn/O9GlKDWkbmA==
X-Received: by 2002:a17:906:8466:b0:9a5:846d:d820 with SMTP id hx6-20020a170906846600b009a5846dd820mr1519882ejc.16.1693000913003;
        Fri, 25 Aug 2023 15:01:53 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i27-20020a1709063c5b00b009928b4e3b9fsm1377065ejg.114.2023.08.25.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:01:52 -0700 (PDT)
Message-ID: <ce1a7b11bb7b3efece5869a185e92114c571ac66.camel@gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Sat, 26 Aug 2023 01:01:51 +0300
In-Reply-To: <0538002efbbc5e887c9e740c7891d2f88ca17e4b.camel@gmail.com>
References: <20230824230102.2117902-1-eddyz87@gmail.com>
	 <CAEf4BzYzhHHSDA9MTMbrR_on-e7uqBUdOo690bEtCXYjg5cC6A@mail.gmail.com>
	 <0538002efbbc5e887c9e740c7891d2f88ca17e4b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-08-26 at 00:10 +0300, Eduard Zingerman wrote:
[...]
> >=20
> > Instead of referencing BPF_MOV specifically, would it be useful to
> > incorporate all the different instructions that can be relocated?
> > bpf_core_patch_insn comment has a nice summary, maybe we can somehow
> > reuse it in this doc as well?
> >=20
> >  * Currently supported classes of BPF instruction are:
> >  * 1. rX =3D <imm> (assignment with immediate operand);
> >  * 2. rX +=3D <imm> (arithmetic operations with immediate operand);
> >  * 3. rX =3D <imm64> (load with 64-bit immediate value);
> >  * 4. rX =3D *(T *)(rY + <off>), where T is one of {u8, u16, u32, u64};
> >  * 5. *(T *)(rX + <off>) =3D rY, where T is one of {u8, u16, u32, u64};
> >  * 6. *(T *)(rX + <off>) =3D <imm>, where T is one of {u8, u16, u32, u6=
4}.
>=20
> Good point. I will keep the BPF_MOV as an example for relocation kind
> groups description and add this comment describing all relocatable
> instructions.
>=20

Actually, this comment does not mention atomic instructions or loads
with sign extension. bpf_core_patch_insn() operates basing on
instruction class. I'll describe it as follows:

  Field to patch is selected basing on the instruction class:

  * For BPF_ALU, BPF_ALU64, BPF_LD immediate field is patched;
  * For BPF_LDX, BPF_STX, BPF_ST offset field is patched;

WDYT?

[...]

