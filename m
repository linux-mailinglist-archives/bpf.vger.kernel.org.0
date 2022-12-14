Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4C64CD1C
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 16:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLNPdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 10:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiLNPdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 10:33:54 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283EE10061
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 07:33:53 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so11026890lfb.13
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 07:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4u5lopAcG/zXgk+SG+Sj+hA4xAfz0l5h4uQkKhdhU4=;
        b=OUohwP/L2giP+B1+cB5Yx6pMyUECNl+LpHnKW6RkHAqX3FZrbjQM/Qps+8ldtdTASM
         +yIr5rAzhLUtcb6vaShSQfWesjcTqE0X/TU9MiIbqCOf+/BcauazwjWGdb3oQY1Xz1Cr
         +Krjhb26Xrkp83l8+nWmULY3VyllMiB9Lv9118fB66Q5Y3YH8+JJ7OgdOk8k85kaPjtA
         8tH+NcFSP9QFTZVQa1CPGBg+vkdXiSerT85a7ZrzjTYogTbNKLrxJhRdU3LLbLfYO2xA
         iCtXTYbV8XUxFMNJ5c6U71KW8lu7zsVPZrk7EhPenVSwuWeKrphmItSn7JaEVhncHhjS
         I6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4u5lopAcG/zXgk+SG+Sj+hA4xAfz0l5h4uQkKhdhU4=;
        b=Z96CdubMZu+rmfKCR2NauhKrnyKX20T/F7gNDNCIrLQpYem3iXQvx+raxUhDXgi0kH
         GkEZyweap2vb3U/Fpcymn6M0ho1p2LBaelasUnGQKbxU7ig+sqrobTT2+W5ZORqyLyit
         LBViEKFOJu/Wv8MdjOpQ67VyE5lAYnK3k0YaK6XVjFIftBs10BGaTOWtl6Eg8X7XFlOg
         Hntaznfcx7S2fUZasRWIFrodg2PHfI1ZR6BPgI6nshlWqtOJO2zdi375Cw5jJmM8shnl
         hKsRMmt/bw7gllokiA8iTJej2yPgZ+7tDAvLZpNlxMi1g9tAJq+FNPswPxSNNjfCuMxN
         H76w==
X-Gm-Message-State: ANoB5plPzgxAsv7mI7da7AjkCDyvoVgHAnzdHudyZBYX/PmMAavUULp9
        Tr+zf+xUFEZ0gXBY/Hl/HhA=
X-Google-Smtp-Source: AA0mqf5+SzeymiqyH8tT+iArtzEILnYcDKcn8TzqA5oqhNT9LOhUtFIHMQZFH9UyOzIcEHBGP/T5qA==
X-Received: by 2002:a05:6512:c3:b0:4b5:7054:3b55 with SMTP id c3-20020a05651200c300b004b570543b55mr5914000lfp.68.1671032031224;
        Wed, 14 Dec 2022 07:33:51 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u20-20020a196a14000000b004b4ec76016esm840539lfu.113.2022.12.14.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:33:50 -0800 (PST)
Message-ID: <bcca335872185eff732dd9b11f661cc1d872cfea.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: states_equal() must build idmap for
 all function frames
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
Date:   Wed, 14 Dec 2022 17:33:48 +0200
In-Reply-To: <CAEf4BzZRx8XaD4fvSA04U2iRDnmWiYzbAGTiB_MDS1RqWXztBQ@mail.gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
         <20221209135733.28851-4-eddyz87@gmail.com>
         <CAEf4BzZRx8XaD4fvSA04U2iRDnmWiYzbAGTiB_MDS1RqWXztBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-12-13 at 16:35 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > verifier.c:states_equal() must maintain register ID mapping across all
> > function frames. Otherwise the following example might be erroneously
> > marked as safe:
> >=20
> > main:
> >     fp[-24] =3D map_lookup_elem(...)  ; frame[0].fp[-24].id =3D=3D 1
> >     fp[-32] =3D map_lookup_elem(...)  ; frame[0].fp[-32].id =3D=3D 2
> >     r1 =3D &fp[-24]
> >     r2 =3D &fp[-32]
> >     call foo()
> >     r0 =3D 0
> >     exit
> >=20
> > foo:
> >   0: r9 =3D r1
> >   1: r8 =3D r2
> >   2: r7 =3D ktime_get_ns()
> >   3: r6 =3D ktime_get_ns()
> >   4: if (r6 > r7) goto skip_assign
> >   5: r9 =3D r8
> >=20
> > skip_assign:                ; <--- checkpoint
> >   6: r9 =3D *r9               ; (a) frame[1].r9.id =3D=3D 2
> >                             ; (b) frame[1].r9.id =3D=3D 1
> >=20
> >   7: if r9 =3D=3D 0 goto exit:  ; mark_ptr_or_null_regs() transfers !=
=3D 0 info
> >                             ; for all regs sharing ID:
> >                             ;   (a) r9 !=3D 0 =3D> &frame[0].fp[-32] !=
=3D 0
> >                             ;   (b) r9 !=3D 0 =3D> &frame[0].fp[-24] !=
=3D 0
> >=20
> >   8: r8 =3D *r8               ; (a) r8 =3D=3D &frame[0].fp[-32]
> >                             ; (b) r8 =3D=3D &frame[0].fp[-32]
> >   9: r0 =3D *r8               ; (a) safe
> >                             ; (b) unsafe
> >=20
> > exit:
> >  10: exit
> >=20
> > While processing call to foo() verifier considers the following
> > execution paths:
> >=20
> > (a) 0-10
> > (b) 0-4,6-10
> > (There is also path 0-7,10 but it is not interesting for the issue at
> >  hand. (a) is verified first.)
> >=20
> > Suppose that checkpoint is created at (6) when path (a) is verified,
> > next path (b) is verified and (6) is reached.
> >=20
> > If states_equal() maintains separate 'idmap' for each frame the
> > mapping at (6) for frame[1] would be empty and
> > regsafe(r9)::check_ids() would add a pair 2->1 and return true,
> > which is an error.
> >=20
> > If states_equal() maintains single 'idmap' for all frames the mapping
> > at (6) would be { 1->1, 2->2 } and regsafe(r9)::check_ids() would
> > return false when trying to add a pair 2->1.
> >=20
> > This issue was suggested in the following discussion:
> > https://lore.kernel.org/bpf/CAEf4BzbFB5g4oUfyxk9rHy-PJSLQ3h8q9mV=3DrVoX=
fr_JVm8+1Q@mail.gmail.com/
> >=20
> > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h | 4 ++--
> >  kernel/bpf/verifier.c        | 3 ++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 70d06a99f0b8..c1f769515beb 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -273,9 +273,9 @@ struct bpf_id_pair {
> >         u32 cur;
> >  };
> >=20
> > -/* Maximum number of register states that can exist at once */
> > -#define BPF_ID_MAP_SIZE (MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE)
> >  #define MAX_CALL_FRAMES 8
> > +/* Maximum number of register states that can exist at once */
> > +#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) =
* MAX_CALL_FRAMES)
>=20
> this is overly pessimistic, the total number of stack slots doesn't
> change no matter how many call frames we have, it would be better to
> define this as:
>=20
> #define BPF_ID_MAP_SIZE (MAX_BPF_REG * MAX_CALL_FRAMES + MAX_BPF_STACK
> / BPF_REG_SIZE)
>=20
> Unless I missed something.

Current bpf_check() mechanics looks as follows:
- do_check_{subprogs,main}() (indirectly):
  - when a pseudo-function is called the call is processed by
    __check_func_call(), it allocates callee's struct bpf_func_state
    using kzalloc() and does not update ->stack and ->allocated_stack field=
s;
  - when a stack write is processed by check_mem_access():
    - check_stack_access_within_bounds() verifies that offset is within
      0..-MAX_BPF_STACK;
    - check_stack_write_{fixed,var}_off() calls grow_stack_state() which us=
es
      realloc_array() to increase ->stack as necessary;
    - update_stack_depth() is used to increase
      env->subprog_info[...].stack_depth as appropriate;
- check_max_stack_depth() verifies that cumulative stack depth does not
  exceed MAX_BPF_STACK using env->subprog_info[...].stack_depth values.

This means that during do_check_*() we can have MAX_CALL_FRAMES functions
each with a stack of size MAX_BPF_STACK. The following example could be
used to verify the above assumptions:

{
	"check_max_depth",
	.insns =3D {
		BPF_ST_MEM(BPF_DW, BPF_REG_FP, -512, 0),
		BPF_CALL_REL(2),
		BPF_MOV64_IMM(BPF_REG_0, 0),
		BPF_EXIT_INSN(),

		BPF_ST_MEM(BPF_DW, BPF_REG_FP, -512, 0),
		BPF_MOV64_IMM(BPF_REG_0, 0),
		BPF_EXIT_INSN(),
	},
	.result =3D REJECT,
},

Here is the verifier log that shows that two frames both of size
MAX_BPF_STACK slots were present during verification:

# ./test_verifier -vv 1030
#1030/p check_max_depth FAIL
Unexpected error message!
	EXP: (null)
	RES:
func#0 @0
func#1 @4
0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
0: (7a) *(u64 *)(r10 -512) =3D 0        ; R10=3Dfp0 fp-512_w=3Dmmmmmmmm
1: (85) call pc+2
caller:
 R10=3Dfp0 fp-512_w=3Dmmmmmmmm
callee:
 frame1: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
4: (7a) *(u64 *)(r10 -512) =3D 0        ; frame1: R10=3Dfp0 fp-512_w=3Dmmmm=
mmmm
5: (b7) r0 =3D 0                        ; frame1: R0_w=3D0
6: (95) exit
returning from callee:
 frame1: R0_w=3D0 R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0 fp-512_w=3Dmmmmmmmm
to caller at 2:
 R0_w=3D0 R10=3Dfp0 fp-512_w=3Dmmmmmmmm

from 6 to 2: R0_w=3D0 R10=3Dfp0 fp-512_w=3Dmmmmmmmm
2: (b7) r0 =3D 0                        ; R0_w=3D0
3: (95) exit
combined stack size of 2 calls is 1024. Too large
verification time 541 usec
stack depth 512+512

>=20
>=20
>=20
> >  struct bpf_verifier_state {
> >         /* call stack tracking */
> >         struct bpf_func_state *frame[MAX_CALL_FRAMES];
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d05c5d0344c6..9188370a7ebe 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13122,7 +13122,6 @@ static bool func_states_equal(struct bpf_verifi=
er_env *env, struct bpf_func_stat
> >  {
> >         int i;
> >=20
> > -       memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
> >         for (i =3D 0; i < MAX_BPF_REG; i++)
> >                 if (!regsafe(env, &old->regs[i], &cur->regs[i],
> >                              env->idmap_scratch))
> > @@ -13146,6 +13145,8 @@ static bool states_equal(struct bpf_verifier_en=
v *env,
> >         if (old->curframe !=3D cur->curframe)
> >                 return false;
> >=20
> > +       memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
> > +
> >         /* Verification state from speculative execution simulation
> >          * must never prune a non-speculative execution one.
> >          */
> > --
> > 2.34.1
> >=20

