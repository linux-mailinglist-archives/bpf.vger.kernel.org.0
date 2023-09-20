Return-Path: <bpf+bounces-10421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120987A6FD1
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 02:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AA01C20985
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 00:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2815A5;
	Wed, 20 Sep 2023 00:19:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D054A23
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 00:19:54 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278EFAB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:19:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a9cd066db5so828821566b.0
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695169190; x=1695773990; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S27RLi3gYTgX5eDiNPQ9d1UCRuuRPLJ28bXshs7WLZc=;
        b=ndDNUZqPFguTkyA6PJTKwqNQT0x5f5sjuGqCITvJXTunlurW6YteqlbOGAVIKe7313
         V01yQkP1DgOtVz5mxLZI8rP3DGpcx7ZjbZ0cJtVo1yar7dN0hdeZ/WL5eZbZVL+/MPJF
         B3ikfvLFkYxIxss8T/JRsRscKpRplpU1DS4jowd7NuYkBw9WAlKgPVDZ03yuy5ffEoie
         a1zkovMm0CZIypYr0kJO9XQqEhaVHGEUWTQ3oh9drjafYTWkRB3PXzvHvhi21UNa51FQ
         TnWkhOC32ILMIdWJOybjyIlAAi6RX4xkXCM5I99zXM54Fyc2Il52ppc6Edj+49EynJ/V
         Yx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695169190; x=1695773990;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S27RLi3gYTgX5eDiNPQ9d1UCRuuRPLJ28bXshs7WLZc=;
        b=ixvDpE6zRU8dR0NcKZ9+HLzi/ARCYYLo3b0ZS047N2qCABaypENinKmBeWqQ+Bvh2d
         m8L7/ACUGDrUZUDAD53ERWafhYpWmO2pyqHHPhNwrTxdbVR9h2H8xztd09o1sur+7dEb
         Fg2kSlr1YaUPA7xy7VLr/x/JwlUVNE1MEmF1ImUdRbi1m7UMNQa/+ggxThBBNz3Z7qmV
         WAdGRqoeUPllKG7eUZXGUWHWa75gm9TuLGEB2Rcu9zYzBW9wsaXK9fxrQttk4UmArbb9
         lb8jTeWl+Pt1NVQEr8oxv06Z9ul2G4C3aMitTOz1h/+iAnmspOp3rGhhaGhQPKtDlNkx
         4A6g==
X-Gm-Message-State: AOJu0YypLeNzndaTSSLaNVeVNH14S6C4WQ+U+IOswd7GVy1JLUN5P2fN
	+wEoFQX3ypYmRP36OVzo+9k=
X-Google-Smtp-Source: AGHT+IE7A9wwvI8oj/qimifcTKCfP8vIcQZBqS56qiYFQaHZhPCyT8gwD/npUrNWLVHTNZ/kESsKMw==
X-Received: by 2002:a17:907:2c61:b0:9a4:dd49:da3e with SMTP id ib1-20020a1709072c6100b009a4dd49da3emr605674ejc.68.1695169190427;
        Tue, 19 Sep 2023 17:19:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906248a00b00993928e4d1bsm8375911ejb.24.2023.09.19.17.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:19:50 -0700 (PDT)
Message-ID: <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Sep 2023 03:19:48 +0300
In-Reply-To: <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
References:
	  <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
	 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
	 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
	 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
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

On Tue, 2023-09-19 at 16:02 -0700, Andrii Nakryiko wrote:
> On Tue, Sep 19, 2023 at 9:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > It looks like I hit a related but slightly different bug with bpf_iter_=
next().
> > Consider the following example:
> >=20
> >     SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> >     int num_iter_bug(const void *ctx) {
> >         struct bpf_iter_num it;                 // fp[-8] below
> >         __u64 val =3D 0;                          // fp[-16] in the bel=
ow
> >         __u64 *ptr =3D &val;                      // r7 below
> >         __u64 rnd =3D bpf_get_current_pid_tgid(); // r6 below
> >         void *v;
> >=20
> >         bpf_iter_num_new(&it, 0, 10);
> >         while ((v =3D bpf_iter_num_next(&it))) {
> >             rnd++;
> >             if (rnd =3D=3D 42) {
> >                 ptr =3D (void*)(0xdead);
> >                 continue;
> >             }
> >             bpf_probe_read_user(ptr, 8, (void*)(0xdeadbeef));
> >         }
> >         bpf_iter_num_destroy(&it);
> >         return 0;
> >     }
> >=20
> > (Unfortunately, it had to be converted to assembly to avoid compiler
> >  clobbering loop structure, complete test case is at the end of the ema=
il).
> >=20
> > The example is not safe because of 0xdead being a possible `ptr` value.
> > However, currently it is marked as safe.
> >=20
> > This happens because of states_equal() usage for iterator convergence
> > detection:
> >=20
> >     static int is_state_visited(struct bpf_verifier_env *env, int insn_=
idx)
> >         ...
> >         while (sl)
> >                 states_cnt++;
> >                 if (sl->state.insn_idx !=3D insn_idx)
> >                         goto next;
> >=20
> >                 if (sl->state.branches)
> >                 ...
> >                         if (is_iter_next_insn(env, insn_idx)) {
> >                                 if (states_equal(env, &sl->state, cur))=
 {
> >                         ...
> >                                         if (iter_state->iter.state =3D=
=3D BPF_ITER_STATE_ACTIVE)
> >                                                 goto hit;
> >                                 }
> >                                 goto skip_inf_loop_check;
> >                         }
> >         ...
> >=20
> > With some additional logging I see that the following states are
> > considered equal:
> >=20
> >     13: (85) call bpf_iter_num_next#59908
> >     ...
> >     at is_iter_next_insn(insn 13):
> >       old state:
> >          R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3Dfp-16 R1=
0=3Dfp0
> >          fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=
=3D00000000 refs=3D2
> >       cur state:
> >          R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3D=
fp-8 R6=3D42 R7_w=3D57005
> >          R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1)=
 fp-16=3D00000000 refs=3D2
> >     states_equal()?: true
> >=20
> > Note that R7=3Dfp-16 in old state vs R7_w=3D57005 in cur state.
> > The registers are considered equal because R7 does not have a read mark=
.
> > However read marks are not yet finalized for old state because
> > sl->state.branches !=3D 0. (Note: precision marks are not finalized as
> > well, which should be a problem, but this requires another example).
>=20
> I originally convinced myself that non-finalized precision marking is
> fine, see the comment next to process_iter_next_call() for reasoning.
> If you can have a dedicated example for precision that would be great.
>=20
> As for read marks... Yep, that's a bummer. That r7 is not used after
> the loop, so is not marked as read, and it's basically ignored for
> loop invariant checking, which is definitely not what was intended.

Liveness is a precondition for all subsequent checks, so example
involving precision would also involve liveness. Here is a combined
example:

    r8 =3D 0
    fp[-16] =3D 0
    r7 =3D -16
    r6 =3D bpf_get_current_pid_tgid()
    bpf_iter_num_new(&fp[-8], 0, 10)
    while (bpf_iter_num_next(&fp[-8])) {
      r6++
      if (r6 !=3D 42) {
        r7 =3D -32
        continue;
      }
      r0 =3D r10
      r0 +=3D r7
      r8 =3D *(u64 *)(r0 + 0)
    }
    bpf_iter_num_destroy(&fp[-8])
    return r8

(Complete source code is at the end of the email).

The call to bpf_iter_num_next() is reachable with r7 values -16 and -32.
State with r7=3D-16 is visited first, at which point r7 has no read mark
and is not marked precise.
State with r7=3D-32 is visited second:
- states_equal() for is_iter_next_insn() should ignore absence of
  REG_LIVE_READ mark on r7, otherwise both states would be considered
  identical;
- states_equal() for is_iter_next_insn() should ignore absence of
  precision mark on r7, otherwise both states would be considered
  identical.

> > A possible fix is to add a special flag to states_equal() and
> > conditionally ignore logic related to liveness and precision when this
> > flag is set. Set this flag for is_iter_next_insn() branch above.
>=20
> Probably not completely ignore liveness (and maybe precision, but
> let's do it one step at a time), but only at least one of the
> registers or stack slots are marked as written or read in one of
> old/new states? Basically, if some register/slot at the end of
> iteration is read or modified, it must be important for loop
> invariant, so even if the parent state says it's not read, we still
> treat it as read. Can you please try that with just read/write marks
> and see if anything fails?

Unfortunately for the example above neither liveness nor precision
marks are present when states are compared, e.g. here is the
(extended) log:

12: (85) call bpf_iter_num_next#52356
...
is_iter_next (12):
  old:
     R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3D-16 R8_r=3D0 R10=
=3Dfp0
     fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=3D0000000=
0 refs=3D2
  new:
     R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3Dfp-8 R6=
=3D42 R7_w=3D-32 R8=3D0 R10=3Dfp0
     fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) fp-16=3D00000000 =
refs=3D2
> hit

Note that for old state r7 value is not really important to get to exit,
the verification trace looks as follows:
1. ... start ...
2. bpf_iter_num_next(&fp[-8]) ;; r7=3D-16, checkpoint saved
3. r6++
4. r7 =3D -32
5. bpf_iter_num_next(&fp[-8]) ;; push new state with r7=3D-32
6. bpf_iter_num_destroy(&fp[-8])
7. return 8

The r7 liveness and precision is important for state scheduled at (5)
but it is not known yet, so when both states are compared marks are
absent in cur and in old.

---

/* BTF FUNC records are not generated for kfuncs referenced
 * from inline assembly. These records are necessary for
 * libbpf to link the program. The function below is a hack
 * to ensure that BTF FUNC records are generated.
 */
void __kfunc_btf_root(void)
{
	bpf_iter_num_new(0, 0, 0);
	bpf_iter_num_next(0);
	bpf_iter_num_destroy(0);
}

SEC("fentry/" SYS_PREFIX "sys_nanosleep")
__failure
__msg("20: (79) r8 =3D *(u64 *)(r0 +0)")
__msg("invalid read from stack R0 off=3D-32 size=3D8")
__naked int iter_next_exact(const void *ctx)
{
	asm volatile (
		"r8 =3D 0;"
		"*(u64 *)(r10 - 16) =3D r8;"
		"r7 =3D -16;"
		"call %[bpf_get_current_pid_tgid];"
		"r6 =3D r0;"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"r2 =3D 0;"
		"r3 =3D 10;"
		"call %[bpf_iter_num_new];"
	"1:"
		"r1 =3D r10;"
		"r1 +=3D -8;\n"
		"call %[bpf_iter_num_next];"
		"if r0 =3D=3D 0 goto 2f;"
		"r6 +=3D 1;"
		"if r6 !=3D 42 goto 3f;"
		"r7 =3D -32;"
		"goto 1b;\n"
	"3:"
		"r0 =3D r10;"
		"r0 +=3D r7;"
		"r8 =3D *(u64 *)(r0 + 0);"
		"goto 1b;\n"
	"2:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_destroy];"
		"r0 =3D r8;"
		"exit;"
		:
		: __imm(bpf_get_current_pid_tgid),
		  __imm(bpf_iter_num_new),
		  __imm(bpf_iter_num_next),
		  __imm(bpf_iter_num_destroy),
		  __imm(bpf_probe_read_user)
		: __clobber_all
	);
}


