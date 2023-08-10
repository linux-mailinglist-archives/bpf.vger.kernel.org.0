Return-Path: <bpf+bounces-7489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B87780EB
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5375728185E
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E1322EFA;
	Thu, 10 Aug 2023 19:01:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4E1F95D
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:01:53 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489882712
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 12:01:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c0290f0a8so171314866b.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691694111; x=1692298911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfTorN+mY3h3ND0FJ2XizPSgxMjBySjQBCb+VokD89U=;
        b=IFqq/m8bT8VHRPZFWLRdYSzYEEkLLBgfDoIVPKb+XCAfXu94BDVYbxoFW7W/oEwnRX
         1DsBNlK2AipGalCGZnFahgQH/LQRMRBWEqk1vyIaIkNjzImdVyzZkEk3uba/gij49ssz
         8n0MHn5rezRf13xAR1ncD4ClUxewBrHZ1iWAxu3k6LTqVgkJjh54/pSyehQus3wigIcY
         21Uw1J5QyGK+ZsPwiIOWymLj93l8MYjFENIBRuGcANNHRuCUeow0QxVP3GXQ9/vQ2goV
         IdhqDXeKpxWgS2Xl6EQEZLkXgWPFyQuTUfWjrwmFQ4bY7mMGA6ttOFK4YiCq61RNMUAR
         myyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694111; x=1692298911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfTorN+mY3h3ND0FJ2XizPSgxMjBySjQBCb+VokD89U=;
        b=VusG0u8pO6/XTNOec9CApg2a23I0ovf0SJKotb01Xaplc1VOUSDxxSSlxXkKS9qy7V
         L0Fb1BgBdL7TunwcCdc1LAMDby51c1b9AF6dPhqti2e0Iw6gP0qvqXVLY0NBLasKt34U
         z3txv1Pl3JGE5GKwpoieMJ8HkgpjawZ0n/575jaRypYe5QtsXE1/79pQ0rJ5LN8I5r2B
         cdc2r/QrEjOME05dcFwL2kKKQLZ5tegSsJefn4wk9DcrSF+4R+P9WUiio5bohF5dYVxh
         q4nNmPRn1DU+AxPr/DBdlSk26DSfsb94/G6HiLHAv/cauj2cPxuEM+SO6SSUz0pgiT0X
         4Ubw==
X-Gm-Message-State: AOJu0YyAgh0c7ES5bIMYpUQSGajJN5LO4/8yjGZEMqxtYhX9TUHc6NR0
	jvZftA0rTqWBeNXqu7k0w3c=
X-Google-Smtp-Source: AGHT+IFLReydnk4/+P4Gpb8L/0VlRQOjH17nL4ZM8m3VDDlkbX5NZNpSUQLMQ+Ejm2ZdCEaDfNGStA==
X-Received: by 2002:a17:906:76cd:b0:988:f1ec:7400 with SMTP id q13-20020a17090676cd00b00988f1ec7400mr2920798ejn.36.1691694110379;
        Thu, 10 Aug 2023 12:01:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a6-20020a17090682c600b0098669cc16b2sm1295115ejy.83.2023.08.10.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:01:49 -0700 (PDT)
Message-ID: <37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 10 Aug 2023 22:01:48 +0300
In-Reply-To: <223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
References: <87edkbnq14.fsf@oracle.com>
	 <a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	 <87a5uyiyp1.fsf@oracle.com>
	 <223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-10 at 10:45 -0700, Yonghong Song wrote:
>=20
> On 8/10/23 10:39 AM, Jose E. Marchesi wrote:
> >=20
> > > On 8/10/23 3:35 AM, Jose E. Marchesi wrote:
> > > > Hello.
> > > > We found that some of the BPF selftests use the "p" constraint in
> > > > inline
> > > > assembly snippets, for input operands for MOV (rN =3D rM) instructi=
ons.
> > > > This is mainly done via the __imm_ptr macro defined in
> > > > tools/testing/selftests/bpf/progs/bpf_misc.h:
> > > >     #define __imm_ptr(name) [name]"p"(&name)
> > > > Example:
> > > >     int consume_first_item_only(void *ctx)
> > > >     {
> > > >           struct bpf_iter_num iter;
> > > >           asm volatile (
> > > >                   /* create iterator */
> > > >                   "r1 =3D %[iter];"
> > > >                   [...]
> > > >                   :
> > > >                   : __imm_ptr(iter)
> > > >                   : CLOBBERS);
> > > >           [...]
> > > >     }
> > > > Little equivalent reproducer:
> > > >     int bar ()
> > > >     {
> > > >       int jorl;
> > > >       asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));
> > > >       return jorl;
> > > >     }
> > > > The "p" constraint is a tricky one.  It is documented in the GCC
> > > > manual
> > > > section "Simple Constraints":
> > > >     An operand that is a valid memory address is allowed.  This is
> > > > for
> > > >     ``load address'' and ``push address'' instructions.
> > > >     p in the constraint must be accompanied by address_operand as t=
he
> > > >     predicate in the match_operand.  This predicate interprets the =
mode
> > > >     specified in the match_operand as the mode of the memory refere=
nce for
> > > >     which the address would be valid.
> > > > There are two problems:
> > > > 1. It is questionable whether that constraint was ever intended to
> > > > be
> > > >      used in inline assembly templates, because its behavior really
> > > >      depends on compiler internals.  A "memory address" is not the =
same
> > > >      than a "memory operand" or a "memory reference" (constraint "m=
"), and
> > > >      in fact its usage in the template above results in an error in=
 both
> > > >      x86_64-linux-gnu and bpf-unkonwn-none:
> > > >        foo.c: In function =E2=80=98bar=E2=80=99:
> > > >        foo.c:6:3: error: invalid 'asm': invalid expression as opera=
nd
> > > >           6 |   asm volatile ("r1 =3D %[jorl]" : : [jorl]"p"(&jorl)=
);
> > > >             |   ^~~
> > > >      I would assume the same happens with aarch64, riscv, and
> > > > most/all
> > > >      other targets in GCC, that do not accept operands of the form =
A + B
> > > >      that are not wrapped either in a const or in a memory referenc=
e.
> > > >      To avoid that error, the usage of the "p" constraint in intern=
al
> > > > GCC
> > > >      instruction templates is supposed to be complemented by the 'a=
'
> > > >      modifier, like in:
> > > >        asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));
> > > >      Internally documented (in GCC's final.cc) as:
> > > >        %aN means expect operand N to be a memory address
> > > >           (not a memory reference!) and print a reference
> > > >           to that address.
> > > >      That works because when the modifier 'a' is found, GCC prints =
an
> > > >      "operand address", which is not the same than an "operand".
> > > >      But...
> > > > 2. Even if we used the internal 'a' modifier (we shouldn't) the 'rN
> > > > =3D
> > > >      rM' instruction really requires a register argument.  In cases
> > > >      involving automatics, like in the examples above, we easily en=
d with:
> > > >        bar:
> > > >           #APP
> > > >               r1 =3D r10-4
> > > >           #NO_APP
> > > >      In other cases we could conceibly also end with a 64-bit label
> > > > that
> > > >      may overflow the 32-bit immediate operand of `rN =3D imm32'
> > > >      instructions:
> > > >           r1 =3D foo
> > > >      All of which is clearly wrong.
> > > > clang happens to do "the right thing" in the current usage of
> > > > __imm_ptr
> > > > in the BPF tests, because even with -O2 it seems to "reload" the
> > > > fp-relative address of the automatic to a register like in:
> > > >     bar:
> > > > 	r1 =3D r10
> > > > 	r1 +=3D -4
> > > > 	#APP
> > > > 	r1 =3D r1
> > > > 	#NO_APP
> > >=20
> > > Unfortunately, the modifier 'a' won't work for clang.
> > >=20
> > > $ cat t.c  int bar ()  {     int jorl;     asm volatile ("r1 =3D
> > > %a[jorl]" : : [jorl]"p"(&jorl));     return jorl;  }  $ gcc -O2 -g -S
> > > t.c  $ clang --target=3Dbpf -O2 -g -S t.c  clang:
> > > ../lib/Target/BPF/BPFAsmPrinter.cpp:126: virtual bool
> > > {anonymous}::BPFAsmPrinter::PrintAsmMemoryOperand(const
> > > llvm::MachineInstr*, unsigned int, const char*, llvm::raw_ostream&):
> > > Assertion `Offs
> > > etMO.isImm() && "Unexpected offset for inline asm memory operand."' f=
ailed.
> > > ...
> > >=20
> > > I guess BPF backend can try to add support for this 'a' modifier
> > > if necessary.
> >=20
> > I wouldn't advise that: it is an internal GCC detail that just happens
> > to work in inline asm.  Also, even if you did that constraint may resul=
t
> > in operands that are not single registers.  It would be better to use
> > "r" constraint instead.
>=20
> Sounds good. We also do not want to add support for this 'a' thing
> if there are alternatives.
>=20
> >=20
> > >=20
> > > > Which is what GCC would generate with -O0.  Whether this is by chan=
ce or
> > > > by design (Nick, do you know?) I don't think the compiler should be
> > > > expected to do that reload driven by the "p" constraint.
> > > > I would suggest to change that macro (and similar out of macro
> > > > usages of
> > > > the "p" constraint in selftests/bpf/progs/iters.c) to use the "r"
> > > > constraint instead.  If a register is what is required, we should l=
et
> > > > the compiler know.
> > >=20
> > > Could you specify what is the syntax ("r" constraint) which will work
> > > for both clang and gcc?
> >=20
> > Instead of:
> >=20
> >     #define __imm_ptr(name) [name]"p"(&name)
> >=20
> > Use this:
> >=20
> >     #define __imm_ptr(name) [name]"r"(&name)
> >=20
> > That assures that the operand (the pointer value) will be available in
> > the form of a single register.
>=20
> Okay, this seems work for both gcc and clang.
> Eduard, what do you think about the above suggested change?

BPF selftests are passing with this change.
The macro in question is used in 3 files:
- verifier_subprog_precision.c
- iters_state_safety.c
- iters_looping.c

I don't see any difference in the generated object files
(at-least for cpuv4).

So, I guess we should be fine.

>=20
> >=20
> > >=20
> > > > Thoughts?
> > > > PS: I am aware that the x86 port of the kernel uses the "p"
> > > > constraint
> > > >       in the percpu macros (arch/x86/include/asm/percpu.h) but that=
 usage
> > > >       is in a different context (I would assume it is used in x86
> > > >       instructions that get constant addresses or global addresses =
loaded
> > > >       in registers and not automatics) where it seems to work well.
> > > >=20
>=20


