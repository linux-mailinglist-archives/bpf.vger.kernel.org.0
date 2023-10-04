Return-Path: <bpf+bounces-11360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667697B7E7C
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EE5801C2082C
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85D134C2;
	Wed,  4 Oct 2023 11:52:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4AFD514
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 11:52:39 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1E90
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 04:52:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so22572941fa.3
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696420356; x=1697025156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bywsjutvSVrRJlayJLYGqHf0DvORnYfEmsv+1rx0ERc=;
        b=jAEZCWUt2LWM21rx+ATQLTVEAbazW6ftKoeQNsbuz4AJCXm9rwj15Ki0Nmbl3mX7Kg
         c+rJwajXReUTH6zVtl+en0uVGVu1OhCTGs0Y0ui2aUoJ98+GrTgBLs7VneOj4zHmUyLR
         SmrdQiFnglw3Y8uZmvd0dD92pt7fLX+u2XUa+eHtaxgWhPTv1yXfIa4kbkmbsmzBg0S5
         uZyLba8gD+70XwcUarzv1e/1+xVvXMr+hvCgwQi5KJg71Pk3AeN6tk+epJHuODeqf5nb
         9G7GJxx8sJ9sKyZH3dw3qSh8h+rsSV65n1Lk2e42wkL0uwHI5bWzU9tYTYeu9M81Ul5w
         3GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696420356; x=1697025156;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bywsjutvSVrRJlayJLYGqHf0DvORnYfEmsv+1rx0ERc=;
        b=FlDNz867JgAXKdVAwyELVqMaYD9rxIi5q/GTFFl34kTa2/NIL28e8XeX6HSRkB72OV
         tk90gGJn8EPrP5JW2eRFAsYlJ2XPsMPqVSzEiKqXsyNGTNuYCP1h72CAyoR/WDJx39KS
         ctkUN2stEH8ENCwioTdH2iqedE3E/GH0QVEmHe6NAhaAFA92puY8Oh+DBUZQqU1BYFoK
         2gk15LWAFSJ2ySnf0VOOH1NiHJosqKaXl9axwyPCe7+OEOR5iRKiQ5RElFEQHYUprk3I
         JPcvp6q/gExie8+XA2pcU4XzUazKE+fYJpdsxHAgZO1BNiU2d8P1uwbZfxthcq7ARj83
         amvw==
X-Gm-Message-State: AOJu0YzP4SjBQq2jhUwR23Gwnw2PFRwO6yTYxgGVHW76n/V0akYZaLGG
	IDc2cYS4aFbAls0lkUTjwg1QxjDLVkmrXQ==
X-Google-Smtp-Source: AGHT+IHU33D7qyrZHEkiJkzlggab7aJTzg0ghqAraZI0LcbaeYpba41yyOtvwVZVOlt+GZgopj5bTA==
X-Received: by 2002:a2e:7401:0:b0:2c0:720:e836 with SMTP id p1-20020a2e7401000000b002c00720e836mr1934556ljc.12.1696420355947;
        Wed, 04 Oct 2023 04:52:35 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n9-20020a2e9049000000b002bfe25d5641sm636828ljg.107.2023.10.04.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:52:35 -0700 (PDT)
Message-ID: <4d6faf13143da0722de17f8c551c481222c3cb50.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 04 Oct 2023 14:52:33 +0300
In-Reply-To: <20231004025731.ft7xjnr2nxdhxjq5@MacBook-Pro-49.local>
References: 
	<CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
	 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
	 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
	 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
	 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
	 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
	 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
	 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
	 <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
	 <3d88ede5cbe38ae96be0c148770454b2344fdcce.camel@gmail.com>
	 <20231004025731.ft7xjnr2nxdhxjq5@MacBook-Pro-49.local>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
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

On Tue, 2023-10-03 at 19:57 -0700, Alexei Starovoitov wrote:
> > Yes. This may be an issue. I'll try to hack a layered variant I talked
> > before to see what are the underlying issues. The idea is to verify
> > every child state of the loop entry before moving to any branches of
> > loop's parent states.=20
>=20
> Isn't that what current DFS logic does?

With a twist: it should wait for local loop convergence before
declaring loop entry state safe. I described it in [1].
Upon entry to a top level loop state E:
1. do DFS for E, disallow switching to any branches that are not
   children of E, collect all loop states generated by E's DFS;
3. reschedule loop states;
4. do DFS for rescheduled states, collect all loop states generated in
   the process;
5. repeat from 3 until no loop state could be rescheduled;
6. mark E safe, proceed from regular states stack.

[1] https://lore.kernel.org/bpf/8b75e01d27696cd6661890e49bdc06b1e96092c7.ca=
mel@gmail.com/

> > The idea is that when `env->stack.size =3D=3D 0` all V's non-delayed
> > children states are explored and relevant precision marks are
> > propagated to V.=20
>=20
> But that is not true.
> if (is_iter_next_insn(env, insn_idx)) {
>   if (states_equal(env, &sl->state, cur)) {
> with sl->state.branches > 0
> will prevent exploration of all children.

Yes, it would postpone exploration of some children, but it would be
given a chance to reschedule.

> Hence I still believe that fine tunning this equavalence check is
> the first step in any fix.

Maybe, but so far states_equal(V, C) seems ok:
1. values read by V are defined in C;
2. non-precise scalars are equivalent unconditionally;
3. precise scalars in C are sub-ranges of precise scalars in V;
4. non-scalar values are compared exactly (modulo idmap).

Which of these points are overly optimistic in your opinion?

> > If at this point some states_equal(V, C') is false it
> > is necessary to schedule C' for one more exploration round as it might
> > visit some code blocks that were not visited on the path from V to C'
> > (as different predictions decisions could be made).
>=20
> exactly my point above,
> but because of broken double 'if' above the 2nd pass might be hitting
> the same issues as the first. Because some path wasn't explored
> the precision marks might still be wrong.
>=20
> More loop states can be created and delayed again into loop_stack?

Yes, and new reschedule would be done and so on.

> > If a point is reached when for all loop states C' there are some
> > states V such that states_equal(V, C'), there are no more
> > configurations that can visit code blocks not visited on the path from
> > V to C', as prediction decisions would be the same.
>=20
> and it not, we can repeat loop_stack->stack->loop_stack potentially forev=
er?

It might be the case that such logic would not converge, e.g. as in
the following simple example:

  it =3D iter_new();
  i =3D 0;
  while (iter_next(it)) {
    if (i & 0x1 =3D=3D 0)
      printk("'i' is precise and different in each state");
    ++i;
  }
  iter_destroy(it);

However:
- we have such limitation already;
- examples like this don't play well with current states pruning logic
  in general (I think that doing some opportunistic widening of
  precise values is an interesting idea (loosing or worsening precision
  with ability to backtrack on failure), but this is a different topic).

If loop logic would not converge verifier would report an error:
either instruction or jump limit would be reached.

For the cases when this logic does converge we end up in a state when
no new read or precision marks could be gained, thus it is safe to
accept states_equal =3D=3D true verdicts.

> Did you look at my broken patch? yes. it's buggy, but it demonstrates
> the idea where it removes above problematic double 'if' and uses
> states_equal() on states where st->branches=3D=3D0 && st->looping_states=
=3D=3D1

<replied in a different email>

> meaning that in those states all paths were explored except the one
> forked by iter_next kfunc.
> So precision and liveness is correct,

That's probably true.

> while doing states_equal on V with branches=3D2+ is broken.

Not that it is broken, but it's meaning is "maybe a sub-state" instead
of "definitely a sub-state".

