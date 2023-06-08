Return-Path: <bpf+bounces-2167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FC3728B2A
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20557281837
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E621F16B;
	Thu,  8 Jun 2023 22:37:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D833FC
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 22:37:52 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABBD2695
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 15:37:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-97668583210so176039966b.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686263868; x=1688855868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QndjWLlyY2Wp936D9V7FLOSWPKVT8K957XKRJdGSrUM=;
        b=p0EtI30s4itFsjqP6FipHb7lprNiYV4lpRc9zKJnldw3aB8ZQYeuNN90OPmAnHAXZy
         1WHqs20KEmCc6Ul5X4JY45Z33HT63/7CUA6KCCNrMShsvHJiGk//a3z87fpSo4PPzg9n
         1aDtfNCc8NjxbItd6ZeEwoKwG8m/LxFGJAxD27zwdAHF0Ls8dGLEmw5X7MFFqBrQNffF
         P6y53nhPJAlw7mBthYcmKt/Q2+84enGT/PeXpL6kD0WEopXUrY/zzuDKt+pUMiJSN6Hi
         82VEc+Tb37D4i4xG5o+aQ48tmDrXaqhA0FhxM2tMeFlU1Jmh4QnQrmOjDy0uNwMchyj1
         ylww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686263868; x=1688855868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QndjWLlyY2Wp936D9V7FLOSWPKVT8K957XKRJdGSrUM=;
        b=O9tDmWSDh95cb6BYgyKMb24I7RYswMFFIZq6up4vdJ58qNYzKx5jrLruE3GlTZxi57
         Cw2+z3jdCL/7l1VCVgElVbuzjXk1+LYM9aMIRc5fZQy1FiMAQuUwnosryExnERBpAFw1
         wNjtfBeXQPXLxzGR3uFASe16lki/yqDdhWNDpLU1g2//DT8zO/AbTWT6drnqySAx0P9m
         BS7Pd3ZyV7yQ1C21T9GWx4nx+CWifPPjXLJDOcjg98wCc9ZadqbJ944iy/ziVZK/SvMf
         FJu7az4cL9jda0T+L/0tUkVPzpeciKAl1NdxrdCuh8rFd7dkUNDDSlnF9ckn/bGWvems
         2KGA==
X-Gm-Message-State: AC+VfDx2hatbYWeVwUnedSRoGEHIGhTVkjNdcVikCCx+tBfXFQk9AcD6
	6E5Oz1bLfROPBy4MKZZpmsBRxsDsc8D+9Fr2gm1UfRw4sWUqHw==
X-Google-Smtp-Source: ACHHUZ4ZkjQmP6Gj6XYyOsibbXTNh9HI/RZBWT/jcEbUXQm7EU8JTqcmBvgFcBV2szWwYiQUAWZNB7RVX8BvjlO8abQ=
X-Received: by 2002:a17:907:849:b0:96f:e45f:92e9 with SMTP id
 ww9-20020a170907084900b0096fe45f92e9mr446177ejb.16.1686263868390; Thu, 08 Jun
 2023 15:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-4-eddyz87@gmail.com>
 <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com>
 <cc31b95783afa7dc8fb806c973f8420d22a49e58.camel@gmail.com>
 <CAEf4Bzaj6K4UuLQU-eRPWQt+nnyXwj_-yf9NAyqMkW-fc1m0OA@mail.gmail.com>
 <5bb3a6c3daf8c36a88eae6d0a3a8e52d7b24f842.camel@gmail.com> <342f5aaa30ad5ad1a476ffe997e1669d58a8c8ed.camel@gmail.com>
In-Reply-To: <342f5aaa30ad5ad1a476ffe997e1669d58a8c8ed.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 15:37:36 -0700
Message-ID: <CAEf4BzZ8u9MWgcx4DqBVWW6tLx4mVCrc9ZW0fgoJvfA-DhxgkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 1:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2023-06-08 at 22:05 +0300, Eduard Zingerman wrote:
> [...]
> > > Hm.. It's clever and pretty minimal, I like it. We are basically
> > > allocating virtual ID for SCALAR that doesn't have id, just to make
> > > sure we get a conflict if the SCALAR with ID cannot be mapped into tw=
o
> > > different SCALARs, right?
> > >
> > > The only question would be if it's safe to do that for case when
> > > old_reg->id !=3D 0 and cur_reg->id =3D=3D 0? E.g., if in old (verifie=
d)
> > > state we have r6.id =3D r7.id =3D 123, and in new state we have r6.id=
 =3D 0
> > > and r7.id =3D 0, then your implementation above will say that states =
are
> > > equivalent. But are they, given there is a link between r6 and r7 tha=
t
> > > might be required for correctness. Which we don't have in current
> > > state.
> >
> > You mean the other way around, rold.id =3D=3D 0, rcur.id !=3D 0, right?
> > (below 0/2 means: original value 0, replaced by new id 2).

no, I actually meant what I wrote, but I didn't realize that
check_ids() is kind of broken... Because it shouldn't allow the same
ID from cur state to be mapped to two different IDs in old state,
should it?

> >
> > (1)   old cur
> > r6.id 0/2   1
> > r7.id 0/3   1 check_ids returns true

I think this should be rejected.

> >
> > (2)   old cur
> > r6.id 1   0/2
> > r7.id 1   0/3 check_ids returns false

And this should be rejected.

> >
> > Also, (1) is no different from (3):
> >
> > (3)   old cur
> > r6.id 1     3
> > r7.id 2     3 check_ids returns true

And this definitely should be rejected.

The only situation that might not be rejected would be:

        old    cur
r6.id   0/1    3
r7.id.  0/2    4

And perhaps this one is ok as well?

        old    cur
r6.id   3      0/1
r7.id.  4      0/2


And my assumption was that that's what you are trying to do. But
weirdly check_ids() is enforcing only that old ID has to have a unique
mapping, which seems like a bug.

> >
> > Current check:
> >
> >               if (!rold->precise)
> >                       return true;
> >               return range_within(rold, rcur) &&
> >                      tnum_in(rold->var_off, rcur->var_off) &&
> >                      check_ids(rold->id, rcur->id, idmap);
> >
> > Will reject (1) and (2), but will accept (3).
> >
> > New check:
> >
> >               if (!rold->precise)
> >                       return true;
> >               return range_within(rold, rcur) &&
> >                      tnum_in(rold->var_off, rcur->var_off) &&
> >                      check_scalar_ids(rold->id, rcur->id, idmap);
> >
> > Will reject (2), but will accept (1) and (3).
> >
> > And modification of check_scalar_ids() to generate IDs only for rold
> > or only for rcur would not reject (3) either.
> >
> > (3) would be rejected only if current check is used together with
> > elimination of unique scalar IDs from old states.
> >
> > My previous experiments show that eliminating unique IDs from old
> > states and not eliminating unique IDs from cur states is *very* bad
> > for performance.
> >
> > >
> > > So with this we are getting to my original concerns with your
> > > !rold->id approach, which tries to ignore the necessity of link
> > > between registers.
> > >
> > > What if we do this only for old registers? Then, (in old state) r6.id
> > > =3D 0, r7.id =3D 0, (in new state) r6.id =3D r7.id =3D 123. This will=
 be
> > > rejected because first we'll map 123 to newly allocated X for r6.id,
> > > and then when we try to match r7.id=3D123 to another allocated ID X+1
> > > we'll get a conflict, right?
>
> [...]
>
> Ok, here is what I think is the final version:
> a. for each old or cur ID generate temporary unique ID;
> b. for scalars use modified check_ids that forbids mapping same 'cur'
>    ID to several different 'old' IDs.
>
> (a) allows to reject situations like:
>
>   (1)   old cur   (2)   old cur
>   r6.id 0   1     r6.id 1   0
>   r7.id 0   1     r7.id 1   0
>
> (b) allows to reject situations like:
>
>   (3)   old cur
>   r6.id 1   3
>   r7.id 2   3
>
> And whether some scalar ID is unique or not does not matter for the
> algorithm.
>
> Tests are passing, katran example is fine (350k insns, 29K states),
> minor veristat regression:
>
> File       Program                         States (DIFF)
> ---------  ------------------------------  -------------
> bpf_xdp.o  tail_nodeport_nat_ingress_ipv4    +3 (+0.80%)
> bpf_xdp.o  tail_rev_nodeport_lb4             +2 (+0.50%)
>
> --- 8< -----------------------------
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 235d7eded565..5794dc7830db 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15149,6 +15149,31 @@ static bool check_ids(u32 old_id, u32 cur_id, st=
ruct bpf_id_pair *idmap)
>         return false;
>  }
>
> +static bool check_scalar_ids(struct bpf_verifier_env *env, u32 old_id, u=
32 cur_id,
> +                            struct bpf_id_pair *idmap)
> +{
> +       unsigned int i;
> +
> +       old_id =3D old_id ? old_id : env->id_gen++;
> +       cur_id =3D cur_id ? cur_id : env->id_gen++;
> +
> +       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> +               if (!idmap[i].old) {
> +                       /* Reached an empty slot; haven't seen this id be=
fore */
> +                       idmap[i].old =3D old_id;
> +                       idmap[i].cur =3D cur_id;
> +                       return true;
> +               }
> +               if (idmap[i].old =3D=3D old_id)
> +                       return idmap[i].cur =3D=3D cur_id;
> +               if (idmap[i].cur =3D=3D cur_id)
> +                       return false;

I think this should just be added to existing check_ids(), I think
it's a bug that we don't check this condition today in check_ids().


But I'd say let's land fixes you have right now. And then work on
fixing and optimizing scala ID checks separately. We are doing too
many things at the same time :(

> +       }
> +       /* We ran out of idmap slots, which should be impossible */
> +       WARN_ON_ONCE(1);
> +       return false;
> +}
> +
>  static void clean_func_state(struct bpf_verifier_env *env,
>                              struct bpf_func_state *st)
>  {
> @@ -15325,7 +15350,7 @@ static bool regsafe(struct bpf_verifier_env *env,=
 struct bpf_reg_state *rold,
>                  */
>                 return range_within(rold, rcur) &&
>                        tnum_in(rold->var_off, rcur->var_off) &&
> -                      check_ids(rold->id, rcur->id, idmap);
> +                      check_scalar_ids(env, rold->id, rcur->id, idmap);
>         case PTR_TO_MAP_KEY:
>         case PTR_TO_MAP_VALUE:
>         case PTR_TO_MEM:
>
> ----------------------------- >8 ---

