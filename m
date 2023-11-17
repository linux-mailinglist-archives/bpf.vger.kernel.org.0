Return-Path: <bpf+bounces-15258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F27EF794
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0578BB209B1
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E142C0B;
	Fri, 17 Nov 2023 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXfanYkF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73319E6
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:00 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d10972e63eso327792466b.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700247179; x=1700851979; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lJ4qJoJ92I9tsNcnsDSBXxRJs3b35jEa409y33RIH4=;
        b=IXfanYkFzRq4YkBYzX4UURtAuSNRx4mJM/D1PkDyiK7eDM78kREhE/+tybFNUrODRo
         TNr13MpQSEH5qdW/wEAYUgq+Sb71Pk71AoVbKZdVpsiWbU7kK78EVCEngF7FwNdzB0pO
         Vc46SexcrhTPFJSmIje6G1Oh6GvXWH4tPy9/8YPla4W64/9gTeAj7BPCmNXPwZpQAy9n
         Fw9tL0HC3g0EmvZgWJif60ic+7SGOczQ18c2SkRdqDWgfGHCiW+P4cdeDnklKK0WOu8S
         4LgeIsmLLUF3HuF4QAJvkerMGKCPLpRHm/G8DyiRqVi64YMOZgBTemmWjzlw1ioxLHFr
         kngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247179; x=1700851979;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lJ4qJoJ92I9tsNcnsDSBXxRJs3b35jEa409y33RIH4=;
        b=B/M2uBmCvhLsWiHECt4CXbTYTqf9GthgMuuwlWSm/xuisMnK8El1hIqpTjt8vEifPh
         59u2Sg8utG3l5Iz58nHB4vdAsVodEVrRrOFvSDCJHB0HgsfcCytY/+6tMCFm6Kl5hZvu
         ayi2Yt23vBVJO10UEVy+exbVIem3CKxqRkBZZQN7pHvwncVZH9RbJ3LtgKxWi13y8WIH
         ZGE1EgDjOb6O4trnx0kttKoG32USnU7qztNH9r93kgT2K/Js1x4PCZRmN0E10z6m2CSp
         lNjx53FwGOjM/xhJe0vJkMkbBCJ7GmVi1LRrQ50Zlufq6RSF9SC/IMsh1x1n1Rt8LXjG
         w5vw==
X-Gm-Message-State: AOJu0YzVJ8Nu/VRlfaD2+Xg1IHhJnkICFiom3E/r3P+NpR1/1U0CtBAR
	eY6CG4QJcy75J/KKIIkBEUA=
X-Google-Smtp-Source: AGHT+IEowo7zMFBf8vLMO4qdPep5iuPJ7t0MMKc4Yp0fQPqxksIhXrowtFvJ/BAJgFoUy3lVWtTv5Q==
X-Received: by 2002:a17:906:5357:b0:9e7:c1cd:a4dc with SMTP id j23-20020a170906535700b009e7c1cda4dcmr52125ejo.6.1700247178902;
        Fri, 17 Nov 2023 10:52:58 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090673d100b009f55119af1dsm1068054ejl.47.2023.11.17.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:52:58 -0800 (PST)
Message-ID: <8625aa3eef7af265a25c4c02c6152aaefd99d230.camel@gmail.com>
Subject: Re: [PATCH bpf 06/12] bpf: verify callbacks as if they are called
 unknown number of times
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 20:52:57 +0200
In-Reply-To: <CAEf4BzZCdYvjj_xoBsdTwoT33Q2gBJLfGRTPcsv3bDusf9cgJA@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-7-eddyz87@gmail.com>
	 <CAEf4BzZCdYvjj_xoBsdTwoT33Q2gBJLfGRTPcsv3bDusf9cgJA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-17 at 11:46 -0500, Andrii Nakryiko wrote:
[...]
> > +static bool is_callback_iter_next(struct bpf_verifier_env *env, int in=
sn_idx);
> > +
> >  /* For given verifier state backtrack_insn() is called from the last i=
nsn to
> >   * the first insn. Its purpose is to compute a bitmask of registers an=
d
> >   * stack slots that needs precision in the parent verifier state.
> > @@ -4030,10 +4044,7 @@ static int backtrack_insn(struct bpf_verifier_en=
v *env, int idx, int subseq_idx,
> >                                         return -EFAULT;
> >                                 return 0;
> >                         }
> > -               } else if ((bpf_helper_call(insn) &&
> > -                           is_callback_calling_function(insn->imm) &&
> > -                           !is_async_callback_calling_function(insn->i=
mm)) ||
> > -                          (bpf_pseudo_kfunc_call(insn) && is_callback_=
calling_kfunc(insn->imm))) {
> > +               } else if (is_sync_callback_calling_insn(insn) && idx !=
=3D subseq_idx - 1) {
>=20
> can you leave a comment why we need idx !=3D subseq_idx - 1 check?

This check is needed to make sure that we on the arc from callback
return to callback calling function, I'll extend the comment below.

> >                         /* callback-calling helper or kfunc call, which=
 means
> >                          * we are exiting from subprog, but unlike the =
subprog
> >                          * call handling above, we shouldn't propagate
>=20
> [...]
>=20
> > @@ -12176,6 +12216,21 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >                 return -EACCES;
> >         }
> >=20
> > +       /* Check the arguments */
> > +       err =3D check_kfunc_args(env, &meta, insn_idx);
> > +       if (err < 0)
> > +               return err;
> > +
> > +       if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_im=
pl]) {
>=20
> can't we use is_sync_callback_calling_kfunc() here?

No, because it uses 'set_rbtree_add_callback_state' as a parameter,
specific to rbtree_add, not just any kfunc.

> > +               err =3D push_callback_call(env, insn, insn_idx, meta.su=
bprogno,
> > +                                        set_rbtree_add_callback_state)=
;
> > +               if (err) {
> > +                       verbose(env, "kfunc %s#%d failed callback verif=
ication\n",
> > +                               func_name, meta.func_id);
> > +                       return err;
> > +               }
> > +       }
> > +

[...]

> > diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/t=
esting/selftests/bpf/prog_tests/cb_refs.c
> > index 3bff680de16c..b5aa168889c1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> > @@ -21,12 +21,14 @@ void test_cb_refs(void)
> >  {
> >         LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf =3D log=
_buf,
> >                                                 .kernel_log_size =3D si=
zeof(log_buf),
> > -                                               .kernel_log_level =3D 1=
);
> > +                                               .kernel_log_level =3D 1=
 | 2 | 4);
>=20
> nit: 1 is redundant if 2 is specified, so just `2 | 4` ?

This is a leftover, sorry, I'll remove changes to cb_refs.c.

[...]

> > diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precisi=
on.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> > index db6b3143338b..ead358679fe2 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> > @@ -120,14 +120,12 @@ __naked int global_subprog_result_precise(void)
> >  SEC("?raw_tp")
> >  __success __log_level(2)
> >  __msg("14: (0f) r1 +=3D r6")
> > -__msg("mark_precise: frame0: last_idx 14 first_idx 10")
> > +__msg("mark_precise: frame0: last_idx 14 first_idx 9")
> >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 13: (bf) r1 =3D=
 r7")
> >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 12: (27) r6 *=
=3D 4")
> >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 11: (25) if r6 =
> 0x3 goto pc+4")
> >  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 10: (bf) r6 =3D=
 r0")
> > -__msg("mark_precise: frame0: parent state regs=3Dr0 stack=3D:")
> > -__msg("mark_precise: frame0: last_idx 18 first_idx 0")
> > -__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 18: (95) exit")
> > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 9: (85) call bp=
f_loop")
>=20
> you are right that r0 returned from bpf_loop is not r0 returned from
> bpf_loop's callback, but we still have to go through callback
> instructions, right?

Should we? We are looking to make r0 precise, but what are the rules
for propagating that across callback boundary?
For bpf_loop() and for bpf_for_each_map_elem() that would be marking
r0 inside callback as precise, but in general that is callback specific.

In a separate discussion with you and Alexei you mentioned that you
are going to send a patch-set that would force all r0 precise on exit,
which would cover current situation. Imo, it would make sense to wait
for that patch-set, as it would be simpler than changes in
backtrack_insn(), wdyt?

> so you removed few __msg() from subprog
> instruction history because it was too long a history or what? I'd
> actually keep those but update that in subprog we don't need r0 to be
> precise, that will make this test even clearer
>=20
> >  __naked int callback_result_precise(void)

Here is relevant log fragment:

14: (0f) r1 +=3D r6
mark_precise: frame0: last_idx 14 first_idx 9 subseq_idx -1=20
mark_precise: frame0: regs=3Dr6 stack=3D before 13: (bf) r1 =3D r7
mark_precise: frame0: regs=3Dr6 stack=3D before 12: (27) r6 *=3D 4
mark_precise: frame0: regs=3Dr6 stack=3D before 11: (25) if r6 > 0x3 goto p=
c+4
mark_precise: frame0: regs=3Dr6 stack=3D before 10: (bf) r6 =3D r0
mark_precise: frame0: regs=3Dr0 stack=3D before 9: (85) call bpf_loop#181
15: R1_w=3Dmap_value(off=3D0,ks=3D4,vs=3D16,smin=3Dsmin32=3D0,smax=3Dumax=
=3Dsmax32=3Dumax32=3D12,var_off=3D(0x0; 0xc))
    R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D12,var_=
off=3D(0x0; 0xc))
15: (61) r0 =3D *(u32 *)(r1 +0)         ; R0_w=3Dscalar(smin=3D0,smax=3Duma=
x=3D4294967295,var_off=3D(0x0; 0xffffffff))
                                        R1_w=3Dmap_value(off=3D0,ks=3D4,vs=
=3D16,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D12,var_off=3D(0x0; =
0xc))
16: (95) exit




