Return-Path: <bpf+bounces-5895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96287627D1
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 02:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB051281AFE
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F010EB;
	Wed, 26 Jul 2023 00:39:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F55A7C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 00:39:54 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687E219B4
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:39:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so9589524e87.2
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690331990; x=1690936790;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pj904KzY/yc++fs+DyYH1wTgRuhX5JICZrphOG3Bx+0=;
        b=eSyUsmGAcj2NSqKvimtJmq/RyRVF6rx8CFR3GwFHZ3K6P+MzUnRAWeTCo/n6Gq9uoh
         rWgNJgyY++g4hAkBggpqtHw4hwui3Rw9OfuNZVNzezVDBakG2yEg2/rwDQ6WbkOOhziF
         D5TiJuBrQe+TFg2oJhzD6MuzzqYtfZZhCkJMwX/saYDqIlnuxjdd90W5rtVFLPLk8zgJ
         16C32znQlmhc9xicmJR1g1ngRcOz0/cOk5kisNfeMQWlqCYDY8mUXQ37wISj7IswmPUR
         J6nkrCIpLQ/Qm7Iw8GZ5PsVyyP3Qtknh91WvUl9F6oqKpFP6ECsdbQOHxVmTYv1JHj/H
         wP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690331990; x=1690936790;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pj904KzY/yc++fs+DyYH1wTgRuhX5JICZrphOG3Bx+0=;
        b=IMh2N1jFrUeynOUI6o3pYjd47AfFq/tQ1HaLit6WoNNZOBBcafA5XSJTWc7rl56FqZ
         ThpZKk9O/qKMkVHsYzeJ4W33tLzANiZphU0ln4ApTBnYnQ/oy+jtdQLqSvor3F4yepCs
         zZyq4Bc4ipcFAOKpYCi9J/0eVxMazL63LbnoiyNSZD65ivBHZjPcmv9+yJ1uirrKcbrq
         1Q840YUNEl20vWoOW5s20Fv4uw876eXvCRKurg+7+efrAKI0TGCYIvIIGma4lT0jCk2d
         KhOR62dJwUQEMo5DPUwbCuA6wKvbV/AvGo8uvbf0O4egard/x18FL70OCyk2E/0ZOFhg
         mcCQ==
X-Gm-Message-State: ABy/qLYwuqumNkROm83sTAAZxD0WWtvovgM2aomIz9CN4Xcs6qPUaygQ
	7T7mF1xuSzfAnVht9YORAiE=
X-Google-Smtp-Source: APBJJlGQn6dIZmzNkANVv63122xRiwVYLxG/wCRZTdh9ctTICgI865itNu2eyz10uR+Pe92cRZF5ww==
X-Received: by 2002:a05:6512:2521:b0:4f8:5ab0:68c4 with SMTP id be33-20020a056512252100b004f85ab068c4mr407359lfb.59.1690331990269;
        Tue, 25 Jul 2023 17:39:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e21-20020a056402105500b0051e22660835sm8163187edu.46.2023.07.25.17.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:39:49 -0700 (PDT)
Message-ID: <a1371ac96bdca45a07366868d331410a9836204e.camel@gmail.com>
Subject: Re: Register encoding in assembly for load/store instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "Jose E. Marchesi"
	 <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Yonghong Song <yhs@meta.com>,
 bpf <bpf@vger.kernel.org>
Date: Wed, 26 Jul 2023 03:39:48 +0300
In-Reply-To: <CAADnVQLDGUSSCkhxjgt6bxxN7hOh7L-86-wzESp2Oo8SQ91hOg@mail.gmail.com>
References: <87ila7dhmp.fsf@oracle.com>
	 <5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev>
	 <87o7jzbz0z.fsf@oracle.com>
	 <146bc14b-e15c-6e62-1fa0-4e9e67c974c9@linux.dev>
	 <87zg3jah2s.fsf@oracle.com>
	 <6a102de2-2bd4-6933-e901-de00cda10045@linux.dev>
	 <87v8e78w63.fsf@oracle.com>
	 <CAADnVQLDGUSSCkhxjgt6bxxN7hOh7L-86-wzESp2Oo8SQ91hOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 17:31 -0700, Alexei Starovoitov wrote:
> On Tue, Jul 25, 2023 at 3:28=E2=80=AFPM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
> >=20
> >=20
> > > On 7/25/23 1:09 PM, Jose E. Marchesi wrote:
> > > >=20
> > > > > On 7/25/23 11:56 AM, Jose E. Marchesi wrote:
> > > > > >=20
> > > > > > > On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
> > > > > > > > Hello Yonghong.
> > > > > > > > We have noticed that the llvm disassembler uses different n=
otations
> > > > > > > > for
> > > > > > > > registers in load and store instructions, depending somehow=
 on the width
> > > > > > > > of the data being loaded or stored.
> > > > > > > > For example, this is an excerpt from the assembler-disassem=
bler.s
> > > > > > > > test
> > > > > > > > file in llvm:
> > > > > > > >      // Note: For the group below w1 is used as a destinati=
on for
> > > > > > > > sizes u8, u16, u32.
> > > > > > > >      //       This is disassembler quirk, but is technicall=
y not wrong, as there are
> > > > > > > >      //       no different encodings for 'r1 =3D load' vs '=
w1 =3D load'.
> > > > > > > >      //
> > > > > > > >      // CHECK: 71 21 2a 00 00 00 00 00   w1 =3D *(u8 *)(r2 =
+ 0x2a)
> > > > > > > >      // CHECK: 69 21 2a 00 00 00 00 00   w1 =3D *(u16 *)(r2=
 + 0x2a)
> > > > > > > >      // CHECK: 61 21 2a 00 00 00 00 00   w1 =3D *(u32 *)(r2=
 + 0x2a)
> > > > > > > >      // CHECK: 79 21 2a 00 00 00 00 00   r1 =3D *(u64 *)(r2=
 + 0x2a)
> > > > > > > >      r1 =3D *(u8*)(r2 + 42)
> > > > > > > >      r1 =3D *(u16*)(r2 + 42)
> > > > > > > >      r1 =3D *(u32*)(r2 + 42)
> > > > > > > >      r1 =3D *(u64*)(r2 + 42)
> > > > > > > > The comment there clarifies that the usage of wN instead of=
 rN in
> > > > > > > > the
> > > > > > > > u8, u16 and u32 cases is a "disassembler quirk".
> > > > > > > > Anyway, the problem is that it seems that `clang -S' actual=
ly emits
> > > > > > > > these forms with wN.
> > > > > > > > Is that intended?
> > > > > > >=20
> > > > > > > Yes, this is intended since alu32 mode is enabled where
> > > > > > > w* registers are used for 8/16/32 bit load.
> > > > > > So then why suppporting 'r1 =3D 8948 8*9r2 + 0x2a)'?  The mode =
is
> > > > > > still
> > > > > > alu32 mode.  Isn't the u{8,16,32} part enough to discriminate?
> > > > >=20
> > > > > What does this 'r1 =3D 8948 8*9r2 + 0x2a)' mean?
> > > > >=20
> > > > > For u8/u16/u32 loads, if objdump with option to indicate alu32 mo=
de,
> > > > > then w* register is used. If no alu32 mode for objdump, then r* r=
egister
> > > > > is used. Basically the same insn, disasm is different depending o=
n
> > > > > alu32 mode or not. u8/u16/u32 is not enough to differentiate.
> > > > Ok, so the llvm objdump has a switch that tells when to use rN or w=
N
> > > > when printing these particular instructions.  Thats the "disassembl=
er
> > > > quirk".  To what purpose?  Isnt the person passing the command line
> > > > switch the same person reading the disassembled program?  Is this "=
alu32
> > > > mode" more than a cosmetic thing?
> > > > But what concern us is the assembler, not the disassembler.
> > > > clang -S (which is not objdump) seems to generate these instruction=
s
> > > > with wN (see https://godbolt.org/z/5G433Yvrb for a store instructio=
n for
> > > > example) and we assume the output of clang -S is intended to be pas=
sed
> > > > to an assembler, much like with gcc -S.
> > > > So, should we support both syntaxes as _input_ syntax in the
> > > > assembler?
> > >=20
> > > Considering -mcpu=3Dv3 is recommended cpu flavor (at least in bpf mai=
ling
> > > list), and -mcpu=3Dv3 has alu32 enabled by default. So I think
> > > gcc can start to emit insn assuming alu32 mode is on by default.
> > > So
> > >    w1 =3D *(u8 *)(r2 + 42)
> > > is preferred.
> >=20
> > We have V4 by default now.  So we can emit
> >=20
> >   w1 =3D *(u8 *)(r2 + 42)
> >=20
> > when -mcpu is v3 or higher, or if -malu32 is specified, and
> >=20
> >   r1 =3D *(u8 *)(r2 + 42)
> >=20
> > when -mcpu is v2 or lower, or if -mnoalu32 is specified.
> >=20
> > Sounds good?
> >=20
> > However this implies that the assembler should indeed recognize both
> > forms of instructions.  But note that it will assembly them to the
> > exactly same encoded instruction.  This includes inline asm (remember
> > GCC does not have an integrated assembler.)
>=20
> Good point.
> I think we made a mistake in clang.
> We shouldn't be printing
> w1 =3D *(u8 *)(r2 + 42)
> since such instruction doesn't exist in BPF ISA
> and it's confusing.
> There is only one instruction:
> r1 =3D *(u8 *)(r2 + 42)
> which is an 8-bit load that zero extends into 64-bit.
> x86 JIT actually implements it as 8-bit load that stores
> into a 32-bit subregister, so it kinda matches w1,
> but that's an implementation detail of the JIT.
>=20
> I think both gcc and clang should always print r1 =3D *(u8 *)(r2 + 42)
> regardless of alu32 or not.
> In gas and clang assembler we can support both w1=3D and r1=3D
> flavors for backward compat.
>=20

I agree with Alexei (the ... disassembler quirk ... comment is left by me :=
).
Can dig into clang part of things if this is a consensus.

