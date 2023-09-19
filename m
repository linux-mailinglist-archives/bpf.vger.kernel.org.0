Return-Path: <bpf+bounces-10414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD67A6EE6
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 01:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB48528177C
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 23:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02127339B6;
	Tue, 19 Sep 2023 23:03:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713346A1
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 23:03:05 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2847C0
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:03:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso5466045f8f.3
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164582; x=1695769382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2XLuflDZJeS02yoL2FQPGhJ84jZMkzQXV0TQa0r7Hg=;
        b=F2GHC59rNxJ3Ay9WKBXN0ewOCQZKSa3AVZ7M1yi6jnHkzmpe5HySyc7NGFFeYz082g
         iAsMB64qFX72ewtLOV5xhti8gGfiunJyfAKlMaAsKimpOb4g8+OV4iAnfceboUv1cuN7
         yDtDkP2R7/bfCEUUxu2EvxVS1ohmT2Ie3Rj0QGbW+b7lvuDKhaW+0EbVDiO7rGOaGfHb
         XWt0XD6Z5jrnQsFHlPUZ0Ov7QvAkvr6/s4K+21Qc0OP74nejJynoaOqJjEkt2ia8bU7h
         DPAU3fEJDrTusNSXKe4md9siGOEHIjdugtDwaJqLKtX2+hjatWyJ0UgyoN15a7ChLac7
         GGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164582; x=1695769382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2XLuflDZJeS02yoL2FQPGhJ84jZMkzQXV0TQa0r7Hg=;
        b=Rh2cl+j9th1EXgyMFQWJin6fSJgr+7Nah2JeMQJQ4+RicuQ5Ad4McLZQe2Ba42fBHS
         YxPsrt6+H9x/WxnPhSXwNFWwMxvDTLkey/617E6XyrmSZlXjllQsyipNWvejDrGNVGVi
         AHvMLUGwR1OMc086tm5H4u4sYoEebul0EO9c2It2asLiCcziOCoD9TN44HL1QIoXqSsU
         lSJkyDiQPGKhWpqNBHtCGhJbf9lUb20llV17RWux8xSSM4xsAJS61rn2E3ZrYzYoPdPt
         b7sbjv/nzfuN9c0tRumg/iKdjrlLUR2fEcifCnIGleeCHf5O/CXlJ19YwOZM3TnSdh+5
         BMYQ==
X-Gm-Message-State: AOJu0Yxaqyen0RvRc1rWtx/RynCnxH95BKnY43kxFOuhnbnb3oRK1Icn
	2FVwI70FBGAgBSdHUEOxEeJA4U3lL4HTR8Oyf0Y896tp01M=
X-Google-Smtp-Source: AGHT+IF9/fbRKXubCLvXxCnDSpvOxSEm9jtY8EXWCrtqmQ6AGElz2lNWhlAz84sq2qEao/rIJQWayHhg3pKaukPE3RI=
X-Received: by 2002:adf:f291:0:b0:321:4c58:7722 with SMTP id
 k17-20020adff291000000b003214c587722mr792855wro.69.1695164582091; Tue, 19 Sep
 2023 16:03:02 -0700 (PDT)
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
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com> <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
In-Reply-To: <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Sep 2023 16:02:50 -0700
Message-ID: <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
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

On Tue, Sep 19, 2023 at 9:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> It looks like I hit a related but slightly different bug with bpf_iter_ne=
xt().
> Consider the following example:
>
>     SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>     int num_iter_bug(const void *ctx) {
>         struct bpf_iter_num it;                 // fp[-8] below
>         __u64 val =3D 0;                          // fp[-16] in the below
>         __u64 *ptr =3D &val;                      // r7 below
>         __u64 rnd =3D bpf_get_current_pid_tgid(); // r6 below
>         void *v;
>
>         bpf_iter_num_new(&it, 0, 10);
>         while ((v =3D bpf_iter_num_next(&it))) {
>             rnd++;
>             if (rnd =3D=3D 42) {
>                 ptr =3D (void*)(0xdead);
>                 continue;
>             }
>             bpf_probe_read_user(ptr, 8, (void*)(0xdeadbeef));
>         }
>         bpf_iter_num_destroy(&it);
>         return 0;
>     }
>
> (Unfortunately, it had to be converted to assembly to avoid compiler
>  clobbering loop structure, complete test case is at the end of the email=
).
>
> The example is not safe because of 0xdead being a possible `ptr` value.
> However, currently it is marked as safe.
>
> This happens because of states_equal() usage for iterator convergence
> detection:
>
>     static int is_state_visited(struct bpf_verifier_env *env, int insn_id=
x)
>         ...
>         while (sl)
>                 states_cnt++;
>                 if (sl->state.insn_idx !=3D insn_idx)
>                         goto next;
>
>                 if (sl->state.branches)
>                 ...
>                         if (is_iter_next_insn(env, insn_idx)) {
>                                 if (states_equal(env, &sl->state, cur)) {
>                         ...
>                                         if (iter_state->iter.state =3D=3D=
 BPF_ITER_STATE_ACTIVE)
>                                                 goto hit;
>                                 }
>                                 goto skip_inf_loop_check;
>                         }
>         ...
>
> With some additional logging I see that the following states are
> considered equal:
>
>     13: (85) call bpf_iter_num_next#59908
>     ...
>     at is_iter_next_insn(insn 13):
>       old state:
>          R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3Dfp-16 R10=
=3Dfp0
>          fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=3D0=
0000000 refs=3D2
>       cur state:
>          R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3Dfp=
-8 R6=3D42 R7_w=3D57005
>          R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) f=
p-16=3D00000000 refs=3D2
>     states_equal()?: true
>
> Note that R7=3Dfp-16 in old state vs R7_w=3D57005 in cur state.
> The registers are considered equal because R7 does not have a read mark.
> However read marks are not yet finalized for old state because
> sl->state.branches !=3D 0. (Note: precision marks are not finalized as
> well, which should be a problem, but this requires another example).

I originally convinced myself that non-finalized precision marking is
fine, see the comment next to process_iter_next_call() for reasoning.
If you can have a dedicated example for precision that would be great.

As for read marks... Yep, that's a bummer. That r7 is not used after
the loop, so is not marked as read, and it's basically ignored for
loop invariant checking, which is definitely not what was intended.

>
> A possible fix is to add a special flag to states_equal() and
> conditionally ignore logic related to liveness and precision when this
> flag is set. Set this flag for is_iter_next_insn() branch above.

Probably not completely ignore liveness (and maybe precision, but
let's do it one step at a time), but only at least one of the
registers or stack slots are marked as written or read in one of
old/new states? Basically, if some register/slot at the end of
iteration is read or modified, it must be important for loop
invariant, so even if the parent state says it's not read, we still
treat it as read. Can you please try that with just read/write marks
and see if anything fails?


>
> ---
>
> /* BTF FUNC records are not generated for kfuncs referenced
>  * from inline assembly. These records are necessary for
>  * libbpf to link the program. The function below is a hack
>  * to ensure that BTF FUNC records are generated.
>  */
> void __kfunc_btf_root(void)
> {
>         bpf_iter_num_new(0, 0, 0);
>         bpf_iter_num_next(0);
>         bpf_iter_num_destroy(0);
> }
>
> SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> __naked int num_iter_bug(const void *ctx)
> {
>         asm volatile (
>                 // r7 =3D &fp[-16]
>                 // fp[-16] =3D 0
>                 "r7 =3D r10;"
>                 "r7 +=3D -16;"
>                 "r0 =3D 0;"
>                 "*(u64 *)(r7 + 0) =3D r0;"
>                 // r6 =3D bpf_get_current_pid_tgid()
>                 "call %[bpf_get_current_pid_tgid];"
>                 "r6 =3D r0;"
>                 // bpf_iter_num_new(&fp[-8], 0, 10)
>                 "r1 =3D r10;"
>                 "r1 +=3D -8;"
>                 "r2 =3D 0;"
>                 "r3 =3D 10;"
>                 "call %[bpf_iter_num_new];"
>                 // while (bpf_iter_num_next(&fp[-8])) {
>                 //   r6++
>                 //   if (r6 !=3D 42) {
>                 //     r7 =3D 0xdead
>                 //     continue;
>                 //   }
>                 //   bpf_probe_read_user(r7, 8, 0xdeadbeef)
>                 // }
>         "1:"
>                 "r1 =3D r10;"
>                 "r1 +=3D -8;"
>                 "call %[bpf_iter_num_next];"
>                 "if r0 =3D=3D 0 goto 2f;"
>                 "r6 +=3D 1;"
>                 "if r6 !=3D 42 goto 3f;"
>                 "r7 =3D 0xdead;"
>                 "goto 1b;"
>         "3:"
>                 "r1 =3D r7;"
>                 "r2 =3D 8;"
>                 "r3 =3D 0xdeadbeef;"
>                 "call %[bpf_probe_read_user];"
>                 "goto 1b;"
>         "2:"
>                 // bpf_iter_num_destroy(&fp[-8])
>                 "r1 =3D r10;"
>                 "r1 +=3D -8;"
>                 "call %[bpf_iter_num_destroy];"
>                 // return 0
>                 "r0 =3D 0;"
>                 "exit;"
>                 :
>                 : __imm(bpf_get_current_pid_tgid),
>                   __imm(bpf_iter_num_new),
>                   __imm(bpf_iter_num_next),
>                   __imm(bpf_iter_num_destroy),
>                   __imm(bpf_probe_read_user)
>                 : __clobber_all
>         );
> }

