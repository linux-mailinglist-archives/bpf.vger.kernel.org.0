Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B269AC35
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 14:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBQNNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 08:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQNNi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 08:13:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CFB30B1D
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 05:13:37 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id co2so3620345edb.13
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 05:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sklOsBxELnmJjmw8mnPdqMYtGfhUi7hJNPkHTVUK0Pg=;
        b=Au8tgpDa1MH326+ts4xXRjzMeIWRS8JI+mUT3yLFwL1p7Jhwww9JAZSOrZGijJp/Eg
         miKhF5A2a6Fi7BHSWb7l35c1XQyV65pMdomCTKRlGFc1Hs76k6nMU2JWk96NWeZoISzr
         KpzzMdkBv8896wZuS5RRGHTXUgf+O4MtST7JulgnIhsx7Fg8zZdQnjabddQtxqYQPi2I
         lzvJHg12fvOIbaujvFgdzxQYD1zS8FWTKeUOePxUckqp/VeV2hl45IvTu3ZSQ5jHOjDO
         rQluBiOAa8R5d0SrJXPrlxFPI6TmpbYazvukNTAxz6l/88T1TKNCUCazowOFKwRSqwth
         TspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sklOsBxELnmJjmw8mnPdqMYtGfhUi7hJNPkHTVUK0Pg=;
        b=oPy25bbcqjTVJ6tzrxRwKzvH6c25KQFfj7k/9ttKzm1WetOTiEYoEwElGlb7CIjzwt
         LG8llH+ZOzn0+y0Lr3cCLQeDmBSQt9JyjFxbTHttqeRUH04XIpj7pByi79JEKYVPvTpT
         yFbhAElzSyraFuTaRtHGuXXcWYKy/B2C3dSGV4sELtOgJnYWGip3fOlaHWqE9eNvlGQl
         p+AgnnGY6gpMSSBrEXP3pIa5h34+B/hUGUaLS8dRs2/ED5trpDdUg3cMIqAiTeV+C6UO
         m28oe0jgz9hiIb/0ZUnensLiFWTMBS0i1Y3spus7oUZDIs5MBTft3JLptOs0ylTcZqx9
         dlcQ==
X-Gm-Message-State: AO0yUKWZ1Ir61urosgcv1A+KxHAHTpzBJ3BcebaWI1duWCZMNGw9eD4R
        gpRJyVreH/KMpj7r4un+5jM=
X-Google-Smtp-Source: AK7set/WEIm/NXFCkDitXBml5ynuAVzlNTEYPtj896qAJkRU0gnBVAaqboMutsfsCUeEF+MRIzWSZA==
X-Received: by 2002:a05:6402:1a45:b0:4ad:7481:c2fe with SMTP id bf5-20020a0564021a4500b004ad7481c2femr3533849edb.22.1676639615291;
        Fri, 17 Feb 2023 05:13:35 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c72-20020a509fce000000b00499b6b50419sm2286608edf.11.2023.02.17.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:13:34 -0800 (PST)
Message-ID: <15b495c31b7aa6ed5ec6805a7d04e914788c0d1a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow reads from uninit stack
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Date:   Fri, 17 Feb 2023 15:13:33 +0200
In-Reply-To: <CAEf4Bza5rbWbgHW96d+G5n3Wn6eUTs8USO3oXEsH3pFX8kVqbQ@mail.gmail.com>
References: <20230216183606.2483834-1-eddyz87@gmail.com>
         <20230216183606.2483834-2-eddyz87@gmail.com>
         <CAEf4Bza5rbWbgHW96d+G5n3Wn6eUTs8USO3oXEsH3pFX8kVqbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-02-16 at 16:36 -0800, Andrii Nakryiko wrote:
> On Thu, Feb 16, 2023 at 10:36 AM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> >=20
> > This commits updates the following functions to allow reads from
> > uninitialized stack locations when env->allow_uninit_stack option is
> > enabled:
> > - check_stack_read_fixed_off()
> > - check_stack_range_initialized(), called from:
> >   - check_stack_read_var_off()
> >   - check_helper_mem_access()
> >=20
> > Such change allows to relax logic in stacksafe() to treat STACK_MISC
> > and STACK_INVALID in a same way and make the following stack slot
> > configurations equivalent:
> >=20
> >   |  Cached state    |  Current state   |
> >   |   stack slot     |   stack slot     |
> >   |------------------+------------------|
> >   | STACK_INVALID or | STACK_INVALID or |
> >   | STACK_MISC       | STACK_SPILL   or |
> >   |                  | STACK_MISC    or |
> >   |                  | STACK_ZERO    or |
> >   |                  | STACK_DYNPTR     |
> >=20
> > This leads to significant verification speed gains (see below).
> >=20
> > The idea was suggested by Andrii Nakryiko [1] and initial patch was
> > created by Alexei Starovoitov [2].
> >=20
> > Currently the env->allow_uninit_stack is allowed for programs loaded
> > by users with CAP_PERFMON or CAP_SYS_ADMIN capabilities.
> >=20
> > A number of test cases from verifier/*.c were expecting uninitialized
> > stack access to be an error. These test cases were updated to execute
> > in unprivileged mode (thus preserving the tests).
> >=20
> > The test progs/test_global_func10.c expected "invalid indirect access
> > to stack" error message because of the access to uninitialized memory
> > region. The test is updated to provoke the same error message by
> > accessing stack out of allocated range.
> >=20
> > The following tests had to be removed because these can't be made
> > unprivileged:
> > - verifier/sock.c:
> >   - "sk_storage_get(map, skb->sk, &stack_value, 1): partially init
> >   stack_value"
> >   BPF_PROG_TYPE_SCHED_CLS programs are not executed in unprivileged mod=
e.
> > - verifier/var_off.c:
> >   - "indirect variable-offset stack access, max_off+size > max_initiali=
zed"
> >   - "indirect variable-offset stack access, uninitialized"
> >   These tests verify that access to uninitialized stack values is
> >   detected when stack offset is not a constant. However, variable
> >   stack access is prohibited in unprivileged mode, thus these tests
> >   are no longer valid.
> >=20
> >  * * *
> >=20
> > Here is veristat log comparing this patch with current master on a
> > set of selftest binaries listed in tools/testing/selftests/bpf/veristat=
.cfg
> > and cilium BPF binaries (see [3]):
> >=20
> > $ ./veristat -e file,prog,states -C -f 'states_pct<-30' master.log curr=
ent.log
> > File                        Program                     States (A)  Sta=
tes (B)  States    (DIFF)
> > --------------------------  --------------------------  ----------  ---=
-------  ----------------
> > bpf_host.o                  tail_handle_ipv6_from_host         349     =
    244    -105 (-30.09%)
> > bpf_host.o                  tail_handle_nat_fwd_ipv4          1320     =
    895    -425 (-32.20%)
> > bpf_lxc.o                   tail_handle_nat_fwd_ipv4          1320     =
    895    -425 (-32.20%)
> > bpf_sock.o                  cil_sock4_connect                   70     =
     48     -22 (-31.43%)
> > bpf_sock.o                  cil_sock4_sendmsg                   68     =
     46     -22 (-32.35%)
> > bpf_xdp.o                   tail_handle_nat_fwd_ipv4          1554     =
    803    -751 (-48.33%)
> > bpf_xdp.o                   tail_lb_ipv4                      6457     =
   2473   -3984 (-61.70%)
> > bpf_xdp.o                   tail_lb_ipv6                      7249     =
   3908   -3341 (-46.09%)
> > pyperf600_bpf_loop.bpf.o    on_event                           287     =
    145    -142 (-49.48%)
> > strobemeta.bpf.o            on_event                         15915     =
   4772  -11143 (-70.02%)
> > strobemeta_nounroll2.bpf.o  on_event                         17087     =
   3820  -13267 (-77.64%)
> > xdp_synproxy_kern.bpf.o     syncookie_tc                     21271     =
   6635  -14636 (-68.81%)
> > xdp_synproxy_kern.bpf.o     syncookie_xdp                    23122     =
   6024  -17098 (-73.95%)
> > --------------------------  --------------------------  ----------  ---=
-------  ----------------
> >=20
> > Note: I limited selection by states_pct<-30%.
> >=20
> > Inspection of differences in pyperf600_bpf_loop behavior shows that
> > the following patch for the test removes almost all differences:
> >=20
> >     - a/tools/testing/selftests/bpf/progs/pyperf.h
> >     + b/tools/testing/selftests/bpf/progs/pyperf.h
> >     @ -266,8 +266,8 @ int __on_event(struct bpf_raw_tracepoint_args *ct=
x)
> >             }
> >=20
> >             if (event->pthread_match || !pidData->use_tls) {
> >     -               void* frame_ptr;
> >     -               FrameData frame;
> >     +               void* frame_ptr =3D 0;
> >     +               FrameData frame =3D {};
> >                     Symbol sym =3D {};
> >                     int cur_cpu =3D bpf_get_smp_processor_id();
> >=20
> > W/o this patch the difference comes from the following pattern
> > (for different variables):
> >=20
> >     static bool get_frame_data(... FrameData *frame ...)
> >     {
> >         ...
> >         bpf_probe_read_user(&frame->f_code, ...);
> >         if (!frame->f_code)
> >             return false;
> >         ...
> >         bpf_probe_read_user(&frame->co_name, ...);
> >         if (frame->co_name)
> >             ...;
> >     }
> >=20
> >     int __on_event(struct bpf_raw_tracepoint_args *ctx)
> >     {
> >         FrameData frame;
> >         ...
> >         get_frame_data(... &frame ...) // indirectly via a bpf_loop & c=
allback
> >         ...
> >     }
> >=20
> >     SEC("raw_tracepoint/kfree_skb")
> >     int on_event(struct bpf_raw_tracepoint_args* ctx)
> >     {
> >         ...
> >         ret |=3D __on_event(ctx);
> >         ret |=3D __on_event(ctx);
> >         ...
> >     }
> >=20
> > With regards to value `frame->co_name` the following is important:
> > - Because of the conditional `if (!frame->f_code)` each call to
> >   __on_event() produces two states, one with `frame->co_name` marked
> >   as STACK_MISC, another with it as is (and marked STACK_INVALID on a
> >   first call).
> > - The call to bpf_probe_read_user() does not mark stack slots
> >   corresponding to `&frame->co_name` as REG_LIVE_WRITTEN but it marks
> >   these slots as BPF_MISC, this happens because of the following loop
> >   in the check_helper_call():
> >=20
> >         for (i =3D 0; i < meta.access_size; i++) {
> >                 err =3D check_mem_access(env, insn_idx, meta.regno, i, =
BPF_B,
> >                                        BPF_WRITE, -1, false);
> >                 if (err)
> >                         return err;
> >         }
> >=20
> >   Note the size of the write, it is a one byte write for each byte
> >   touched by a helper. The BPF_B write does not lead to write marks
> >   for the target stack slot.
> > - Which means that w/o this patch when second __on_event() call is
> >   verified `if (frame->co_name)` will propagate read marks first to a
> >   stack slot with STACK_MISC marks and second to a stack slot with
> >   STACK_INVALID marks and these states would be considered different.
> >=20
> > [1] https://lore.kernel.org/bpf/CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSk=
qNZyn=3DxEmnPA@mail.gmail.com/
> > [2] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3r=
NV+kBLQCu7rA@mail.gmail.com/
> > [3] git@github.com:anakryiko/cilium.git
> >=20
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         |  10 ++
> >  .../selftests/bpf/progs/test_global_func10.c  |   6 +-
> >  tools/testing/selftests/bpf/verifier/calls.c  |  13 ++-
> >  .../bpf/verifier/helper_access_var_len.c      | 104 ++++++++++++------
> >  .../testing/selftests/bpf/verifier/int_ptr.c  |   9 +-
> >  .../selftests/bpf/verifier/search_pruning.c   |  13 ++-
> >  tools/testing/selftests/bpf/verifier/sock.c   |  27 -----
> >  .../selftests/bpf/verifier/spill_fill.c       |   7 +-
> >  .../testing/selftests/bpf/verifier/var_off.c  |  52 ---------
> >  9 files changed, 107 insertions(+), 134 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 272563a0b770..6fbd0e25ccab 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3826,6 +3826,8 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
> >                                                 continue;
> >                                         if (type =3D=3D STACK_MISC)
> >                                                 continue;
> > +                                       if (type =3D=3D STACK_INVALID &=
& env->allow_uninit_stack)
> > +                                               continue;
> >                                         verbose(env, "invalid read from=
 stack off %d+%d size %d\n",
> >                                                 off, i, size);
> >                                         return -EACCES;
> > @@ -3863,6 +3865,8 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
> >                                 continue;
> >                         if (type =3D=3D STACK_ZERO)
> >                                 continue;
> > +                       if (type =3D=3D STACK_INVALID && env->allow_uni=
nit_stack)
> > +                               continue;
> >                         verbose(env, "invalid read from stack off %d+%d=
 size %d\n",
> >                                 off, i, size);
> >                         return -EACCES;
> > @@ -5761,6 +5765,8 @@ static int check_stack_range_initialized(
> >                         }
> >                         goto mark;
> >                 }
> > +               if (*stype =3D=3D STACK_INVALID && env->allow_uninit_st=
ack)
> > +                       goto mark;
>=20
> should we support clobber and conversion to STACK_MISC like we do for
> STACK_ZERO? If yes, probably cleaner to just extend condition to
>=20
> if ((*stype =3D=3D STACK_ZERO) || (*stype =3D=3D STACK_INVALID &&
> env->allow_uninit_stack))
>=20
> ?

As far as I understand, conversion of STACK_ZERO to STACK_MISC is
necessary for safety reasons (like we can't be sure that memory will
remain STACK_ZERO after clobber call).

However for STACK_INVALID -> STACK_MISC case, I don't think there is a
way to observe such change (apart from log output). After this patch
there would be no difference between STACK_INVALID and STACK_MISC in
privileged mode.

Hence, such change is a matter of style and does not affect verifier
behavior. If you think that the following is more concise:

		if ((*stype =3D=3D STACK_ZERO) ||
		    (*stype =3D=3D STACK_INVALID && env->allow_uninit_stack)) {
			if (clobber) {
				/* helper can write anything into the stack */
				*stype =3D STACK_MISC;
			}
			goto mark;
		}

I can make this update and add appropriate test, checking log output.
Personally, I that intent would be more clear if the current notation
is preserved.

>=20
>=20
> Other than that, looks good:
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> >=20
> >                 if (is_spilled_reg(&state->stack[spi]) &&
> >                     (state->stack[spi].spilled_ptr.type =3D=3D SCALAR_V=
ALUE ||
> > @@ -13936,6 +13942,10 @@ static bool stacksafe(struct bpf_verifier_env =
*env, struct bpf_func_state *old,
> >                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D =
STACK_INVALID)
> >                         continue;
> >=20
> > +               if (env->allow_uninit_stack &&
> > +                   old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D =
STACK_MISC)
> > +                       continue;
> > +
> >                 /* explored stack has more populated slots than current=
 stack
> >                  * and these slots were used
> >                  */
>=20
> [...]

