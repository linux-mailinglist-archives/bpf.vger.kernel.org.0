Return-Path: <bpf+bounces-5263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF02E7590B7
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76551C20E24
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1D107A4;
	Wed, 19 Jul 2023 08:55:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211010953
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 08:55:29 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83AD1FE2
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:55:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso41247605ad.2
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689756926; x=1692348926;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yodk/9MA9Xih1f71+talTI78pAEKFUIEHKcwD26giy0=;
        b=myjVMx7VVCCC9IhO2QwaPil/TUtumPFwZNruPVIm0oQaalgFj1fADoa1eh1uQnQd4S
         VaHemR5tHPNnytGnkgCbkw6ORzHpasodGcoiP88EfY0Lnlp3CgVKF1xg4uVEsQN68H5e
         NZtnNG6yOCyyCgIAh7rxCw3WtPuCYPBvTt6+SwQ0Rz/pS0FpPOnXUP59FfHFJmILPJiH
         MVX1zeW2o0q11vF5arZNhda5AehXln4lc9uhdoCkcIrkujpuWYvB2QSslXihbG725lJd
         KjsS6i9g5NHlD152Vqxo49Kq4LXZ3YyQAt/vl/ALw1VOdrDTOMphDIwD9/Lo+XRIBdH1
         6YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756926; x=1692348926;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yodk/9MA9Xih1f71+talTI78pAEKFUIEHKcwD26giy0=;
        b=QrNnIVjnJeEKfpeAVYtrSZkZvhKhoHJUadeYEImtrmm3NRNdqhilHKTHiTELRKnofw
         nUM1zwux+fPxIA6GTXRZ1lxYzLlKMDL1KZFRr3Xa4sky0UR/Mv5fOD2Dg4XCa281nmZB
         Cilub5QH1cMkx8Du5uugBd/WJxYWWa4bo6aumcJRK/8p/3XakRcjaHC9f4jjI6F6w0Ib
         cjRm6ivQ/MqregxBmg7SeJLfx5VsbeYmuzK7XEh5S+XOfLDwZSHzAdX9OB6A6XoBHnsq
         hZYrqxM2uxKFm0VCPtuJYa57oBOrhkuThiAsgnKASTawtoyDWbrRL0ylqW9sDpRWrqVB
         uq8w==
X-Gm-Message-State: ABy/qLZ6pwZh/9TKdRnxNgOzosMeaiNZwa9fDbRWC+M/A7Xls3hiukqO
	zY4lixyXIuHNG4K591kRSJg=
X-Google-Smtp-Source: APBJJlFyhHTs+Gbo2AUbnwL29F32LrIvHhJodp4kBQ+A9sSfUFvxU+mNjDlh8BKqtci6xMi2/+CdPg==
X-Received: by 2002:a17:902:a589:b0:1b8:95fc:d12 with SMTP id az9-20020a170902a58900b001b895fc0d12mr1732349plb.54.1689756925976;
        Wed, 19 Jul 2023 01:55:25 -0700 (PDT)
Received: from smtpclient.apple ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ff0200b001b8a8154f3fsm3317560plj.270.2023.07.19.01.55.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2023 01:55:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [bug report] bpf, x86: allow function arguments up to 12 for
 TRACING
From: Menglong Dong <menglong8.dong@gmail.com>
In-Reply-To: <c519c48d-2ce7-4038-83b0-ed0244df4874@kadam.mountain>
Date: Wed, 19 Jul 2023 16:55:08 +0800
Cc: imagedong@tencent.com,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E9F760F-3026-4B59-91C3-F7D361A2B8EA@gmail.com>
References: <09784025-a812-493f-9829-5e26c8691e07@moroto.mountain>
 <61BFA874-6832-40FA-AAB7-A225BE2A7D8C@gmail.com>
 <c519c48d-2ce7-4038-83b0-ed0244df4874@kadam.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B47=E6=9C=8819=E6=97=A5 16:22=EF=BC=8CDan Carpenter =
<dan.carpenter@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jul 19, 2023 at 03:58:59PM +0800, Menglong Dong wrote:
>>>   1957                         /* copy function arguments from =
origin stack frame
>>>   1958                          * into current stack frame.
>>>   1959                          *
>>>   1960                          * The starting address of the =
arguments on-stack
>>>   1961                          * is:
>>>   1962                          *   rbp + 8(push rbp) +
>>>   1963                          *   8(return addr of origin call) +
>>>   1964                          *   8(return addr of the caller)
>>>   1965                          * which means: rbp + 24
>>>   1966                          */
>>>   1967                         for (j =3D 0; j < arg_regs; j++) {
>>>   1968                                 emit_ldx(prog, BPF_DW, =
BPF_REG_0, BPF_REG_FP,
>>>   1969                                          nr_stack_slots * 8 + =
0x18);
>>>   1970                                 emit_stx(prog, BPF_DW, =
BPF_REG_FP, BPF_REG_0,
>>>   1971                                          -stack_size);
>>>   1972=20
>>>   1973                                 if (!nr_stack_slots)
>>>   1974                                         first_off =3D =
stack_size;
>>>   1975                                 stack_size -=3D 8;
>>>   1976                                 nr_stack_slots++;
>>>   1977                         }
>>>   1978                 } else {
>>>   1979                         /* Only copy the arguments on-stack =
to current
>>>   1980                          * 'stack_size' and ignore the regs, =
used to
>>>   1981                          * prepare the arguments on-stack for =
orign call.
>>>   1982                          */
>>>   1983                         if (for_call_origin) {
>>>   1984                                 nr_regs +=3D arg_regs;
>>>   1985                                 continue;
>>>   1986                         }
>>>   1987=20
>>>   1988                         /* copy the arguments from regs into =
stack */
>>>   1989                         for (j =3D 0; j < arg_regs; j++) {
>>>   1990                                 emit_stx(prog, BPF_DW, =
BPF_REG_FP,
>>>   1991                                          nr_regs =3D=3D 5 ? =
X86_REG_R9 : BPF_REG_1 + nr_regs,
>>>   1992                                          -stack_size);
>>>   1993                                 stack_size -=3D 8;
>>>   1994                                 nr_regs++;
>>>   1995                         }
>>>   1996                 }
>>>   1997         }
>>>   1998=20
>>> --> 1999         clean_stack_garbage(m, prog, nr_stack_slots, =
first_off);
>>>   2000 }
>>=20
>> Hello,
>>=20
>> Thanks for the reporting. The variable =E2=80=98first_off=E2=80=99 =
that passed to
>> clean_stack_garbage() should be ok, as it is only used when
>> "nr_stack_slots =3D=3D 1=E2=80=9D, in which case =E2=80=9Cfirst_off=E2=80=
=9D should already be
>> initialized.
>>=20
>> (Anyway, maybe we should initialize it to avoid passing a
>> uninitialized variable to a function?)
>=20
> There is no downside to initializing it to zero.  Everyone does that
> automatically these days.
>=20
> In a case where the variable is not used, it depends on if the =
function
> is inlined or not.  If it's inlined, then it's not a bug.  If it isn't
> inlined then it's still a bug whether the variable is used or not.
> It's undefined behavior in C and it can cause runtime warnings with
> KMEMsan.

Yeah, that make sense. I=E2=80=99ll send a patch to fix it.

Thanks!
Menglong Dong

>=20
> regards,
> dan carpenter
>=20


