Return-Path: <bpf+bounces-10471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC66E7A8958
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36C21C20A94
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592753E462;
	Wed, 20 Sep 2023 16:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A63D3BF
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:20:36 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F4ED
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:20:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so8253012a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695226833; x=1695831633; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KvQFgL/CIZURXhHTqA1Ctesy0CbZsegG4kyqna2Nnwc=;
        b=LC+alC7u1E3UGoXED5AXla6aeqlEW63nUtKW7a1pNBYS0O435gcY6GVcvNtonvhdK8
         TlyvGEgP8CNpyAbtFcOHKdOt9lHxGvP1PvnhesR6EwC8aUS3BR5Fwnogb6L3lTOx+D5E
         Soz78hXijxy2XZWl6jtTZRTcAE25EqgZD40mqmxj7YXID1Yf5pALupyEhUkQv5fFIn7Z
         u9UlXtD7pxqzv2LMhAo56E0aBtIta8OFo2XXahnh4aQt7SbUB2nKXOKTc5T4UwUGtMj+
         yAI+ryz3Qe8WtvyqcZlLtrwiUtPShlZkxf3qSCSOJu5S2NVQsP9jBEfudgyI/WD6itZc
         /2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695226833; x=1695831633;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvQFgL/CIZURXhHTqA1Ctesy0CbZsegG4kyqna2Nnwc=;
        b=uUdE95yCcvWNRsNi8T7wlVgoscRyKzcZ81vNFEQd3Qp0MKsBPyZYiPgSD/x8d1Gbz0
         RFzMeId2H+9zL45q3KBLGzYzn5hj4tz7w/yKeGZtoDzKFsyPpqElG6hND3WvG/0N7lal
         HCohKIN15dYQpq3ewhu3XlmI5iTnCvTp2Uugc00DYixWIwCHhNavC+gT042WjIZD4FFa
         Bkj92oNnF5UanrPmLe3/Y2ieyjKHCOZUFLID0xiJ6zbifM4OZONeMr9za6Iy1gpRVH8h
         EdmrQm8PdbpaRmxBMJuy3anPYNmhMdrRwQic+fY9yyds3vEhpbeuIppiQ0v8wpi2Hpn9
         PdDA==
X-Gm-Message-State: AOJu0YykKavTOeSQfo0DpAgTCtgrqeYge5T+1Q5mx36DHzY5VxCMXQpa
	swWlt6oDM3MLM6wNbeZmkVp55XNVc6zjmQ==
X-Google-Smtp-Source: AGHT+IH0vt7znxXEkN5vhJFsJ/1VkLnCAtKnAC0mwpRk1/ID+Aow75oTbi2eFLGOzHAS1ICdBzfbrg==
X-Received: by 2002:a17:906:1010:b0:9ae:48df:2235 with SMTP id 16-20020a170906101000b009ae48df2235mr2397887ejm.55.1695226832516;
        Wed, 20 Sep 2023 09:20:32 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sy5-20020a1709076f0500b009adc7433419sm8645288ejc.18.2023.09.20.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:20:31 -0700 (PDT)
Message-ID: <b9706fdd932a30f161c4c5f3c4fe4fd4d19cf9df.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Sep 2023 19:20:30 +0300
In-Reply-To: <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
References: 
	<CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
	 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
	 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
	 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
	 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
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

On Wed, 2023-09-20 at 03:19 +0300, Eduard Zingerman wrote:
[...]
> Liveness is a precondition for all subsequent checks, so example
> involving precision would also involve liveness. Here is a combined
> example:
>=20
>     r8 =3D 0
>     fp[-16] =3D 0
>     r7 =3D -16
>     r6 =3D bpf_get_current_pid_tgid()
>     bpf_iter_num_new(&fp[-8], 0, 10)
>     while (bpf_iter_num_next(&fp[-8])) {
>       r6++
>       if (r6 !=3D 42) {
>         r7 =3D -32
>         continue;
>       }
>       r0 =3D r10
>       r0 +=3D r7
>       r8 =3D *(u64 *)(r0 + 0)
>     }
>     bpf_iter_num_destroy(&fp[-8])
>     return r8
>=20
> (Complete source code is at the end of the email).
>=20
> The call to bpf_iter_num_next() is reachable with r7 values -16 and -32.
> State with r7=3D-16 is visited first, at which point r7 has no read mark
> and is not marked precise.
> State with r7=3D-32 is visited second:
> - states_equal() for is_iter_next_insn() should ignore absence of
>   REG_LIVE_READ mark on r7, otherwise both states would be considered
>   identical;
> - states_equal() for is_iter_next_insn() should ignore absence of
>   precision mark on r7, otherwise both states would be considered
>   identical.
>=20
> > > A possible fix is to add a special flag to states_equal() and
> > > conditionally ignore logic related to liveness and precision when thi=
s
> > > flag is set. Set this flag for is_iter_next_insn() branch above.
> >=20
> > Probably not completely ignore liveness (and maybe precision, but
> > let's do it one step at a time), but only at least one of the
> > registers or stack slots are marked as written or read in one of
> > old/new states? Basically, if some register/slot at the end of
> > iteration is read or modified, it must be important for loop
> > invariant, so even if the parent state says it's not read, we still
> > treat it as read. Can you please try that with just read/write marks
> > and see if anything fails?
>=20
> Unfortunately for the example above neither liveness nor precision
> marks are present when states are compared, e.g. here is the
> (extended) log:
>=20
> 12: (85) call bpf_iter_num_next#52356
> ...
> is_iter_next (12):
>   old:
>      R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3D-16 R8_r=3D0 R=
10=3Dfp0
>      fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=3D00000=
000 refs=3D2
>   new:
>      R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3Dfp-8 R=
6=3D42 R7_w=3D-32 R8=3D0 R10=3Dfp0
>      fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) fp-16=3D0000000=
0 refs=3D2
> > hit

It might be the case that I miss-read situation a bit, because there
is also R6 which is actually used to pick the branch. And it has read
mark but does not have precision mark, because jump was not predicted.

In general, if we hit an old state with .branches > 0:
- either there is an execution path "old -> safe exit";
- or there is a loop (not necessarily because of iterator) and old is
  a [grand]parent of the "cur" state.

In either case, "cur" state is safe to prune if:
- it is possible to show that it would take same jump branches as
  "old" state;
- and iteration depth differs.

All registers that took part in conditional jumps should already have
read marks in old state. However, not all jumps could be predicted,
thus not all such registers are marked as precise.

Unfortunately, treating read marks as precision marks is not sufficient.
For the particular example above:

    old: ... R6_r=3Dscalar(id=3D1) ...
    cur: ... R6=3D42 ...

Here range_within() check in regsafe() would return true and old and
cur would still be considered identical:

    static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state =
*rold,
                struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
    {
        ...
        switch (base_type(rold->type)) {
        case SCALAR_VALUE:
            ...
            if (!rold->precise)
                return true;
            ...
            return range_within(rold, rcur) &&
                   tnum_in(rold->var_off, rcur->var_off) &&
                   check_scalar_ids(rold->id, rcur->id, idmap);
        case ...
        }
        ...
    }
   =20
So it appears that there is no need to ignore liveness checks after all,
but I don't see a way to make non-exact scalar comparisons at the moment.

> Note that for old state r7 value is not really important to get to exit,
> the verification trace looks as follows:
> 1. ... start ...
> 2. bpf_iter_num_next(&fp[-8]) ;; r7=3D-16, checkpoint saved
> 3. r6++
> 4. r7 =3D -32
> 5. bpf_iter_num_next(&fp[-8]) ;; push new state with r7=3D-32
> 6. bpf_iter_num_destroy(&fp[-8])
> 7. return 8
>=20
> The r7 liveness and precision is important for state scheduled at (5)
> but it is not known yet, so when both states are compared marks are
> absent in cur and in old.
>=20
> ---
>=20
> /* BTF FUNC records are not generated for kfuncs referenced
>  * from inline assembly. These records are necessary for
>  * libbpf to link the program. The function below is a hack
>  * to ensure that BTF FUNC records are generated.
>  */
> void __kfunc_btf_root(void)
> {
> 	bpf_iter_num_new(0, 0, 0);
> 	bpf_iter_num_next(0);
> 	bpf_iter_num_destroy(0);
> }
>=20
> SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> __failure
> __msg("20: (79) r8 =3D *(u64 *)(r0 +0)")
> __msg("invalid read from stack R0 off=3D-32 size=3D8")
> __naked int iter_next_exact(const void *ctx)
> {
> 	asm volatile (
> 		"r8 =3D 0;"
> 		"*(u64 *)(r10 - 16) =3D r8;"
> 		"r7 =3D -16;"
> 		"call %[bpf_get_current_pid_tgid];"
> 		"r6 =3D r0;"
> 		"r1 =3D r10;"
> 		"r1 +=3D -8;"
> 		"r2 =3D 0;"
> 		"r3 =3D 10;"
> 		"call %[bpf_iter_num_new];"
> 	"1:"
> 		"r1 =3D r10;"
> 		"r1 +=3D -8;\n"
> 		"call %[bpf_iter_num_next];"
> 		"if r0 =3D=3D 0 goto 2f;"
> 		"r6 +=3D 1;"
> 		"if r6 !=3D 42 goto 3f;"
> 		"r7 =3D -32;"
> 		"goto 1b;\n"
> 	"3:"
> 		"r0 =3D r10;"
> 		"r0 +=3D r7;"
> 		"r8 =3D *(u64 *)(r0 + 0);"
> 		"goto 1b;\n"
> 	"2:"
> 		"r1 =3D r10;"
> 		"r1 +=3D -8;"
> 		"call %[bpf_iter_num_destroy];"
> 		"r0 =3D r8;"
> 		"exit;"
> 		:
> 		: __imm(bpf_get_current_pid_tgid),
> 		  __imm(bpf_iter_num_new),
> 		  __imm(bpf_iter_num_next),
> 		  __imm(bpf_iter_num_destroy),
> 		  __imm(bpf_probe_read_user)
> 		: __clobber_all
> 	);
> }
>=20


