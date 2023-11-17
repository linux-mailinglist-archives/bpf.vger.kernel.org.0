Return-Path: <bpf+bounces-15264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D07EF8AD
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5164B20B34
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC545BF7;
	Fri, 17 Nov 2023 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKRjX/Fk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8D120
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:27:56 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50906f941so33757431fa.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252875; x=1700857675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPbaghy3RGD1swbJaTULkENyrmabXrLWvT97AdvhqJk=;
        b=eKRjX/Fkoi5/wEPGIO2YbjBqfbCkbNylMFaBjEI3fGRabhtemHoepD5Jyg4vnjw8dw
         yfICO28HPIgWNYHEDVPO5yv42QXtBlj191ELGAzbVKIshwYi+lek9Dae5QLB/wdTh8OD
         OikBA4cgTwRPwKLY6f3qqoQySE5KEViRVwGZvyaASQYzYQGOVJ6xlvu6sM3sZSAKs+CG
         c47q2e1x0cz7UnpF6ga2yuPJp5NkszOqfwTOJNmTD+oInvaRcDZe/DuDx7J6XNBM9ZKn
         ztTlekTOSwwm3+5Rvl081Mr+dZD50xEPS33uqH8dmu5srHdW1s1SXevUH+0E9fDntEeY
         UIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252875; x=1700857675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPbaghy3RGD1swbJaTULkENyrmabXrLWvT97AdvhqJk=;
        b=kPHPqhYTB4xKPzlrhYQ9u+8N077o6MqoT3SkTtdKpcmjCIab6xm5k50Z0U0sz3Vnra
         n18J/rwa0m4Y1h7jxnVbzNonCSaHfe2PXD5WEKeI5cNqGroUts34jWi7bomePYGLewJB
         fRXlGFMmCNJ29dMgGSRBczpzetmfd6gSjEagRLVcG3pM6n362PTwWcwo5B7FjrWqugV1
         8hWCG3NKeYEUc6gN/Mh3SKZeoAbnlH/cuKPE/lCgUV7NgTGhNtGHKhqkCwzFIhKSj+xQ
         VF+FrSDskc2BJtecx7p7yyl3wmgU/BAGTTMD4WwoXQqVQZyQ9vJ4ybX/ly3OsgILTtgm
         TY+g==
X-Gm-Message-State: AOJu0Yw7iBH2DyA5Owksn+H+8YbbLlw0haDpzDXEAp0kM6cSkNDUQa3G
	wV+sRMFqY1/mYSJiv/LbwbBOcymwxFXcJasBG6A=
X-Google-Smtp-Source: AGHT+IFB5wAXTSoNdQUTeS8E+kOFqp0/pKDGtXUWTwu1+N8jm5p7SurwpF/KshEqRMbRd1mEpFoU0M2FO0jzv4/JhnI=
X-Received: by 2002:a2e:9bd6:0:b0:2c5:40a:5d92 with SMTP id
 w22-20020a2e9bd6000000b002c5040a5d92mr520674ljj.28.1700252874622; Fri, 17 Nov
 2023 12:27:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-7-eddyz87@gmail.com>
 <CAEf4BzZCdYvjj_xoBsdTwoT33Q2gBJLfGRTPcsv3bDusf9cgJA@mail.gmail.com> <8625aa3eef7af265a25c4c02c6152aaefd99d230.camel@gmail.com>
In-Reply-To: <8625aa3eef7af265a25c4c02c6152aaefd99d230.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 15:27:43 -0500
Message-ID: <CAEf4BzZKFj_kP-CkH-T=Eu0iazVGBTVA6YYrCrABYDmKnOum8Q@mail.gmail.com>
Subject: Re: [PATCH bpf 06/12] bpf: verify callbacks as if they are called
 unknown number of times
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 11:46 -0500, Andrii Nakryiko wrote:
> [...]
> > > +static bool is_callback_iter_next(struct bpf_verifier_env *env, int =
insn_idx);
> > > +
> > >  /* For given verifier state backtrack_insn() is called from the last=
 insn to
> > >   * the first insn. Its purpose is to compute a bitmask of registers =
and
> > >   * stack slots that needs precision in the parent verifier state.
> > > @@ -4030,10 +4044,7 @@ static int backtrack_insn(struct bpf_verifier_=
env *env, int idx, int subseq_idx,
> > >                                         return -EFAULT;
> > >                                 return 0;
> > >                         }
> > > -               } else if ((bpf_helper_call(insn) &&
> > > -                           is_callback_calling_function(insn->imm) &=
&
> > > -                           !is_async_callback_calling_function(insn-=
>imm)) ||
> > > -                          (bpf_pseudo_kfunc_call(insn) && is_callbac=
k_calling_kfunc(insn->imm))) {
> > > +               } else if (is_sync_callback_calling_insn(insn) && idx=
 !=3D subseq_idx - 1) {
> >
> > can you leave a comment why we need idx !=3D subseq_idx - 1 check?
>
> This check is needed to make sure that we on the arc from callback
> return to callback calling function, I'll extend the comment below.

great, thanks

>
> > >                         /* callback-calling helper or kfunc call, whi=
ch means
> > >                          * we are exiting from subprog, but unlike th=
e subprog
> > >                          * call handling above, we shouldn't propagat=
e
> >
> > [...]
> >
> > > @@ -12176,6 +12216,21 @@ static int check_kfunc_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn,
> > >                 return -EACCES;
> > >         }
> > >
> > > +       /* Check the arguments */
> > > +       err =3D check_kfunc_args(env, &meta, insn_idx);
> > > +       if (err < 0)
> > > +               return err;
> > > +
> > > +       if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_=
impl]) {
> >
> > can't we use is_sync_callback_calling_kfunc() here?
>
> No, because it uses 'set_rbtree_add_callback_state' as a parameter,
> specific to rbtree_add, not just any kfunc.
>

ah, ok, never mind then

> > > +               err =3D push_callback_call(env, insn, insn_idx, meta.=
subprogno,
> > > +                                        set_rbtree_add_callback_stat=
e);
> > > +               if (err) {
> > > +                       verbose(env, "kfunc %s#%d failed callback ver=
ification\n",
> > > +                               func_name, meta.func_id);
> > > +                       return err;
> > > +               }
> > > +       }
> > > +
>
> [...]
>
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools=
/testing/selftests/bpf/prog_tests/cb_refs.c
> > > index 3bff680de16c..b5aa168889c1 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> > > @@ -21,12 +21,14 @@ void test_cb_refs(void)
> > >  {
> > >         LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf =3D l=
og_buf,
> > >                                                 .kernel_log_size =3D =
sizeof(log_buf),
> > > -                                               .kernel_log_level =3D=
 1);
> > > +                                               .kernel_log_level =3D=
 1 | 2 | 4);
> >
> > nit: 1 is redundant if 2 is specified, so just `2 | 4` ?
>
> This is a leftover, sorry, I'll remove changes to cb_refs.c.
>
> [...]
>
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_preci=
sion.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> > > index db6b3143338b..ead358679fe2 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> > > @@ -120,14 +120,12 @@ __naked int global_subprog_result_precise(void)
> > >  SEC("?raw_tp")
> > >  __success __log_level(2)
> > >  __msg("14: (0f) r1 +=3D r6")
> > > -__msg("mark_precise: frame0: last_idx 14 first_idx 10")
> > > +__msg("mark_precise: frame0: last_idx 14 first_idx 9")
> > >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 13: (bf) r1 =
=3D r7")
> > >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 12: (27) r6 *=
=3D 4")
> > >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 11: (25) if r=
6 > 0x3 goto pc+4")
> > >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 10: (bf) r6 =
=3D r0")
> > > -__msg("mark_precise: frame0: parent state regs=3Dr0 stack=3D:")
> > > -__msg("mark_precise: frame0: last_idx 18 first_idx 0")
> > > -__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 18: (95) exit=
")
> > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 9: (85) call =
bpf_loop")
> >
> > you are right that r0 returned from bpf_loop is not r0 returned from
> > bpf_loop's callback, but we still have to go through callback
> > instructions, right?
>
> Should we? We are looking to make r0 precise, but what are the rules
> for propagating that across callback boundary?

rules are that r0 in parent frame stays marked as precise, then when
we go into child (subprog) frame, we clear r0 *for that frame*, but we
still need to process callback instruction validation history to
eventually get back to caller instructions again

> For bpf_loop() and for bpf_for_each_map_elem() that would be marking
> r0 inside callback as precise, but in general that is callback specific.
>
> In a separate discussion with you and Alexei you mentioned that you
> are going to send a patch-set that would force all r0 precise on exit,
> which would cover current situation. Imo, it would make sense to wait
> for that patch-set, as it would be simpler than changes in
> backtrack_insn(), wdyt?

this is a completely different issue

>
> > so you removed few __msg() from subprog
> > instruction history because it was too long a history or what? I'd
> > actually keep those but update that in subprog we don't need r0 to be
> > precise, that will make this test even clearer
> >
> > >  __naked int callback_result_precise(void)
>
> Here is relevant log fragment:
>
> 14: (0f) r1 +=3D r6
> mark_precise: frame0: last_idx 14 first_idx 9 subseq_idx -1
> mark_precise: frame0: regs=3Dr6 stack=3D before 13: (bf) r1 =3D r7
> mark_precise: frame0: regs=3Dr6 stack=3D before 12: (27) r6 *=3D 4
> mark_precise: frame0: regs=3Dr6 stack=3D before 11: (25) if r6 > 0x3 goto=
 pc+4
> mark_precise: frame0: regs=3Dr6 stack=3D before 10: (bf) r6 =3D r0
> mark_precise: frame0: regs=3Dr0 stack=3D before 9: (85) call bpf_loop#181
> 15: R1_w=3Dmap_value(off=3D0,ks=3D4,vs=3D16,smin=3Dsmin32=3D0,smax=3Dumax=
=3Dsmax32=3Dumax32=3D12,var_off=3D(0x0; 0xc))
>     R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D12,va=
r_off=3D(0x0; 0xc))
> 15: (61) r0 =3D *(u32 *)(r1 +0)         ; R0_w=3Dscalar(smin=3D0,smax=3Du=
max=3D4294967295,var_off=3D(0x0; 0xffffffff))
>                                         R1_w=3Dmap_value(off=3D0,ks=3D4,v=
s=3D16,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D12,var_off=3D(0x0;=
 0xc))
> 16: (95) exit
>

So I assume this is the case where bpf_loop callback is not executed
at all, right? What I'm asking is to keep log expectation where
callback *is* executed once, so that we can validate that r0 in the
caller is not propagated to callback through callback_calling helpers
(like bpf_loop).

