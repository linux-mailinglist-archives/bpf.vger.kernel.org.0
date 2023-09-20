Return-Path: <bpf+bounces-10475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4587A89D4
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB0D282156
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A463E486;
	Wed, 20 Sep 2023 16:57:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE83B2BE
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:57:29 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6BCF
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:57:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d58b3efbso41604f8f.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695229046; x=1695833846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+8JOmM/KupY+uCI/JJ8jEvgy1wboB8cusxLnL1scnU=;
        b=iTRk/eMw1eIYdp0g+HP5A3Y0lvqKepmdUJJyMfSK4mB6VEQgOD9FAiX5Jv+P6dlaqw
         y4H7roDASI6A0h0nXVcgaVCYVYy2lC2TJJ+e2kRXrnA8nlmcpyC9Yt3GSnin2mtIJw8d
         glWgUKe5uopsYNjwoz8Thahs8j5tiX31x4fF85EDDRluA6mEVOcsZFSUcjFnOhplzDEq
         h7C52gQZJwE7r8NsUyXX+dWfEpjOCusuCzMuffcyLG2LZ2tZF0SgT3UqUo3W36JtTksj
         lksTqVQsjSEFQHb5s0eRuRLx4mG6KsLkcWQzCvgWu7BYxI3ARb/awkxf5R4fZuNYZr5M
         ZvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229046; x=1695833846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+8JOmM/KupY+uCI/JJ8jEvgy1wboB8cusxLnL1scnU=;
        b=bGp/AhnK/ehTP1LLScyDXwF4MYR/vzKi5gxcEynVIk3mA6o9ObkVk/fl+JetP2/ulJ
         pOBg2d0fK8XyP1q8Vun+Xsw/pxDnohk4OmRK6C5FmJa2qsVOo0/atdNO8ZOs2f5fKqJ3
         Dmr9u+3q+IO81Um1RwPI3Aq4wMx69uTJN4oZZbV9gZuxwbkgMD0uGk/UMd94KZNYhJD2
         UDD2tgRrlxjkbumua1lr80HC/cAG0NUiOaGSBzc/6XL+uFNxCfMUXs623A6AwkdVr4JX
         JsHjFIi06/JEMq4ruagJ4eHZpkN7T3KWpX4DiiwMx/qQ0fLBFZCBeBjJkVaYIrotpjv6
         o1Hg==
X-Gm-Message-State: AOJu0YwDP92BbGmk3DqBn0wgkpQ4swOIRDsN0Fj5pO3B6/KxvF7ZpeNC
	KXhxsX7sNO7MpgK7KKHLkQVepDRfAZvIc3mtRys=
X-Google-Smtp-Source: AGHT+IHATuEhJYYv54wsuEBZaZcDKsGH5gGKnaraIgaX/EwlcdjyzzzCnZsH6iLlihxM7DUedTF18cCA3ePLihH4PIY=
X-Received: by 2002:adf:ee88:0:b0:317:634c:46e9 with SMTP id
 b8-20020adfee88000000b00317634c46e9mr2914543wro.43.1695229045937; Wed, 20 Sep
 2023 09:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com> <b9706fdd932a30f161c4c5f3c4fe4fd4d19cf9df.camel@gmail.com>
In-Reply-To: <b9706fdd932a30f161c4c5f3c4fe4fd4d19cf9df.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 09:57:13 -0700
Message-ID: <CAEf4BzbaBjLo3yNV2kMmEcJajromuoaV4zr9TMSL8JRNkf2Jww@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-09-20 at 03:19 +0300, Eduard Zingerman wrote:
> [...]
> > Liveness is a precondition for all subsequent checks, so example
> > involving precision would also involve liveness. Here is a combined
> > example:
> >
> >     r8 =3D 0
> >     fp[-16] =3D 0
> >     r7 =3D -16
> >     r6 =3D bpf_get_current_pid_tgid()
> >     bpf_iter_num_new(&fp[-8], 0, 10)
> >     while (bpf_iter_num_next(&fp[-8])) {
> >       r6++
> >       if (r6 !=3D 42) {
> >         r7 =3D -32
> >         continue;
> >       }
> >       r0 =3D r10
> >       r0 +=3D r7
> >       r8 =3D *(u64 *)(r0 + 0)
> >     }
> >     bpf_iter_num_destroy(&fp[-8])
> >     return r8
> >
> > (Complete source code is at the end of the email).
> >
> > The call to bpf_iter_num_next() is reachable with r7 values -16 and -32=
.
> > State with r7=3D-16 is visited first, at which point r7 has no read mar=
k
> > and is not marked precise.
> > State with r7=3D-32 is visited second:
> > - states_equal() for is_iter_next_insn() should ignore absence of
> >   REG_LIVE_READ mark on r7, otherwise both states would be considered
> >   identical;
> > - states_equal() for is_iter_next_insn() should ignore absence of
> >   precision mark on r7, otherwise both states would be considered
> >   identical.
> >
> > > > A possible fix is to add a special flag to states_equal() and
> > > > conditionally ignore logic related to liveness and precision when t=
his
> > > > flag is set. Set this flag for is_iter_next_insn() branch above.
> > >
> > > Probably not completely ignore liveness (and maybe precision, but
> > > let's do it one step at a time), but only at least one of the
> > > registers or stack slots are marked as written or read in one of
> > > old/new states? Basically, if some register/slot at the end of
> > > iteration is read or modified, it must be important for loop
> > > invariant, so even if the parent state says it's not read, we still
> > > treat it as read. Can you please try that with just read/write marks
> > > and see if anything fails?
> >
> > Unfortunately for the example above neither liveness nor precision
> > marks are present when states are compared, e.g. here is the
> > (extended) log:
> >
> > 12: (85) call bpf_iter_num_next#52356
> > ...
> > is_iter_next (12):
> >   old:
> >      R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3D-16 R8_r=3D0=
 R10=3Dfp0
> >      fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=3D000=
00000 refs=3D2
> >   new:
> >      R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3Dfp-8=
 R6=3D42 R7_w=3D-32 R8=3D0 R10=3Dfp0
> >      fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) fp-16=3D00000=
000 refs=3D2
> > > hit
>
> It might be the case that I miss-read situation a bit, because there
> is also R6 which is actually used to pick the branch. And it has read
> mark but does not have precision mark, because jump was not predicted.
>
> In general, if we hit an old state with .branches > 0:
> - either there is an execution path "old -> safe exit";
> - or there is a loop (not necessarily because of iterator) and old is
>   a [grand]parent of the "cur" state.
>
> In either case, "cur" state is safe to prune if:
> - it is possible to show that it would take same jump branches as
>   "old" state;
> - and iteration depth differs.
>
> All registers that took part in conditional jumps should already have
> read marks in old state. However, not all jumps could be predicted,
> thus not all such registers are marked as precise.
>
> Unfortunately, treating read marks as precision marks is not sufficient.
> For the particular example above:
>
>     old: ... R6_r=3Dscalar(id=3D1) ...
>     cur: ... R6=3D42 ...
>
> Here range_within() check in regsafe() would return true and old and
> cur would still be considered identical:
>
>     static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_stat=
e *rold,
>                 struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
>     {
>         ...
>         switch (base_type(rold->type)) {
>         case SCALAR_VALUE:
>             ...
>             if (!rold->precise)
>                 return true;
>             ...
>             return range_within(rold, rcur) &&
>                    tnum_in(rold->var_off, rcur->var_off) &&
>                    check_scalar_ids(rold->id, rcur->id, idmap);
>         case ...
>         }
>         ...
>     }
>
> So it appears that there is no need to ignore liveness checks after all,
> but I don't see a way to make non-exact scalar comparisons at the moment.

Yeah, me neither. We can try something drastic like marking all
registers in the state as precise at the beginning of
iteration/callback execution. But I suspect that will pessimize
verification a lot and might start rejecting valid cases.

Don't know, I'm still trying to think of something that would work.

>
> > Note that for old state r7 value is not really important to get to exit=
,
> > the verification trace looks as follows:
> > 1. ... start ...
> > 2. bpf_iter_num_next(&fp[-8]) ;; r7=3D-16, checkpoint saved
> > 3. r6++
> > 4. r7 =3D -32
> > 5. bpf_iter_num_next(&fp[-8]) ;; push new state with r7=3D-32
> > 6. bpf_iter_num_destroy(&fp[-8])
> > 7. return 8
> >
> > The r7 liveness and precision is important for state scheduled at (5)
> > but it is not known yet, so when both states are compared marks are
> > absent in cur and in old.
> >
> > ---
> >
> > /* BTF FUNC records are not generated for kfuncs referenced
> >  * from inline assembly. These records are necessary for
> >  * libbpf to link the program. The function below is a hack
> >  * to ensure that BTF FUNC records are generated.
> >  */
> > void __kfunc_btf_root(void)
> > {
> >       bpf_iter_num_new(0, 0, 0);
> >       bpf_iter_num_next(0);
> >       bpf_iter_num_destroy(0);
> > }
> >
> > SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> > __failure
> > __msg("20: (79) r8 =3D *(u64 *)(r0 +0)")
> > __msg("invalid read from stack R0 off=3D-32 size=3D8")
> > __naked int iter_next_exact(const void *ctx)
> > {
> >       asm volatile (
> >               "r8 =3D 0;"
> >               "*(u64 *)(r10 - 16) =3D r8;"
> >               "r7 =3D -16;"
> >               "call %[bpf_get_current_pid_tgid];"
> >               "r6 =3D r0;"
> >               "r1 =3D r10;"
> >               "r1 +=3D -8;"
> >               "r2 =3D 0;"
> >               "r3 =3D 10;"
> >               "call %[bpf_iter_num_new];"
> >       "1:"
> >               "r1 =3D r10;"
> >               "r1 +=3D -8;\n"
> >               "call %[bpf_iter_num_next];"
> >               "if r0 =3D=3D 0 goto 2f;"
> >               "r6 +=3D 1;"
> >               "if r6 !=3D 42 goto 3f;"
> >               "r7 =3D -32;"
> >               "goto 1b;\n"
> >       "3:"
> >               "r0 =3D r10;"
> >               "r0 +=3D r7;"
> >               "r8 =3D *(u64 *)(r0 + 0);"
> >               "goto 1b;\n"
> >       "2:"
> >               "r1 =3D r10;"
> >               "r1 +=3D -8;"
> >               "call %[bpf_iter_num_destroy];"
> >               "r0 =3D r8;"
> >               "exit;"
> >               :
> >               : __imm(bpf_get_current_pid_tgid),
> >                 __imm(bpf_iter_num_new),
> >                 __imm(bpf_iter_num_next),
> >                 __imm(bpf_iter_num_destroy),
> >                 __imm(bpf_probe_read_user)
> >               : __clobber_all
> >       );
> > }
> >
>

