Return-Path: <bpf+bounces-8712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FC7891C2
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D464D1C21026
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73CA3D6A;
	Fri, 25 Aug 2023 22:35:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A71C02
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:35:55 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C2926A5
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:35:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50078eba7afso2202441e87.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693002940; x=1693607740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POOb+S89mIRPcNM8QHuEQ7h2qIW/YDqb1u7QUz6l4pU=;
        b=Jp14p7o17FpjB96EXEOl7cN5HFRJkLz31iO/7maL5RYI548uqdY8JCXVGn3S+0KnQS
         rWqnDFRZLQreRuOIt78sL60TCOrtJ01cR/T0MnlBoIvJE3T+hP4ndRCpn+GZZz2oNS+I
         sapvJ+8HaluykMOpPyhg8rZhaR5iGUxSdD+BpN5hPbLZPP/hjTivbUPiGzMyBFkR62cs
         anqieiqfHRSD8wv8wMFZnyI409gXPSX9pGOsqvl6qHAqKVPv6uKyQcXOTRJLqqwX39E1
         NSnqex37pXcdN3r08bu0P8KYQlQrKP1u//4zNdJ87S3qPtGQiCGaGodoHHyNX3jjjzLN
         AgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002940; x=1693607740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POOb+S89mIRPcNM8QHuEQ7h2qIW/YDqb1u7QUz6l4pU=;
        b=Gpbp0oSaRbQjOzWVRgZkeerGSOBchfrtg0rhnPRY8LSxAFdJURvDOh6eOVo598ELU2
         TghSOhC+jbZflF0XuBYK9slngtBGGIzuKfSnO0XJrgv+WDj9evIorCo62ys4n4TFWfoi
         gWspwFPvF53hhCRtnIAvySPQd8oB7CGSPxqxTgkEeDu9wYlYw15IiaPqvAG7vyCBnVQ1
         9G/S4UDaZif17REqpx82x2DUt/GNbetcdGrU3XQ0YFYIUnhjm0+gke0kgU/8xMpGTDkj
         ZuyqB19Wd8gZ8/qnnY1P6fjmR9joUkx0rpbxyaEF0tNrs/kiufk+7BDp5qqbr1vHzBvq
         A9nQ==
X-Gm-Message-State: AOJu0YyRUzf4B0tnQYmaurnzcoU1GhqasZAS0oF88B4002/V+TZoxzjb
	tK0LPFi2LWaoG5TDbJLIg7yu5GrZ9lUxmOTNwKLKoD8Q
X-Google-Smtp-Source: AGHT+IHl1Q3SIVmTz/HQZSPsw7cmK3pdOablA/Oh+e3BXTa25Cg8NvOWR3Bcm9X08plNEZcBmF6Dhg08HUL6iwUvcxg=
X-Received: by 2002:a05:6512:a86:b0:4f8:64f5:f591 with SMTP id
 m6-20020a0565120a8600b004f864f5f591mr14509482lfu.12.1693002939891; Fri, 25
 Aug 2023 15:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824230102.2117902-1-eddyz87@gmail.com> <CAEf4BzYzhHHSDA9MTMbrR_on-e7uqBUdOo690bEtCXYjg5cC6A@mail.gmail.com>
 <0538002efbbc5e887c9e740c7891d2f88ca17e4b.camel@gmail.com> <ce1a7b11bb7b3efece5869a185e92114c571ac66.camel@gmail.com>
In-Reply-To: <ce1a7b11bb7b3efece5869a185e92114c571ac66.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 15:35:28 -0700
Message-ID: <CAEf4BzY34_gky2c8FxfR8SB6r5v9Ude3zixZpYeEfDODEOvgpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 3:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2023-08-26 at 00:10 +0300, Eduard Zingerman wrote:
> [...]
> > >
> > > Instead of referencing BPF_MOV specifically, would it be useful to
> > > incorporate all the different instructions that can be relocated?
> > > bpf_core_patch_insn comment has a nice summary, maybe we can somehow
> > > reuse it in this doc as well?
> > >
> > >  * Currently supported classes of BPF instruction are:
> > >  * 1. rX =3D <imm> (assignment with immediate operand);
> > >  * 2. rX +=3D <imm> (arithmetic operations with immediate operand);
> > >  * 3. rX =3D <imm64> (load with 64-bit immediate value);
> > >  * 4. rX =3D *(T *)(rY + <off>), where T is one of {u8, u16, u32, u64=
};
> > >  * 5. *(T *)(rX + <off>) =3D rY, where T is one of {u8, u16, u32, u64=
};
> > >  * 6. *(T *)(rX + <off>) =3D <imm>, where T is one of {u8, u16, u32, =
u64}.
> >
> > Good point. I will keep the BPF_MOV as an example for relocation kind
> > groups description and add this comment describing all relocatable
> > instructions.
> >
>
> Actually, this comment does not mention atomic instructions or loads
> with sign extension. bpf_core_patch_insn() operates basing on
> instruction class. I'll describe it as follows:
>
>   Field to patch is selected basing on the instruction class:
>
>   * For BPF_ALU, BPF_ALU64, BPF_LD immediate field is patched;
>   * For BPF_LDX, BPF_STX, BPF_ST offset field is patched;
>
> WDYT?

SGTM. As a human I still like the `rX +=3D <imm>` notation, but for
documentation BPF_ALU would be more precise and appropriate.

>
> [...]

