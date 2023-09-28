Return-Path: <bpf+bounces-11013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3854C7B103A
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 03:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 58832B209E3
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE510EB;
	Thu, 28 Sep 2023 01:10:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13BC370
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 01:09:59 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D947DBF
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 18:09:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so19523390e87.1
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 18:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695863396; x=1696468196; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lA7+sXRSagFL3sb20TPIwI5yOYt1B4FDJBN06OC52KQ=;
        b=kdpTqnw4L5auI3SYVkkeLaJH5A+3N6GVvuUaQmtx1pOoVPCo7kox/HCkdx4xrwMJwi
         zlZi5XBK6nXibKvm6lAzlDG4sC3Mw1Q/SGjHjewN2jN6CFcnMl64Y7w0TLMGQyE0jsVE
         YoryYQTBi9cOIdVtcGY73hNXTsC6hCP+oQu1JzgHfX/6rfVse+Fb6k1Ar5m2oxCR8l8a
         eAiRdEewrYFkn0t0z4GuYMSdZTLpPnzEHq7OMvQhWdDoUW6pvTlxGActHYUVLnU4gVXP
         uJF6MCNZ3eW1aCjuTMyxBwcwN0f7LW8Npdnk9o9LprlGhJUQr6eKHciz+mzNemz7DAQC
         aKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695863396; x=1696468196;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lA7+sXRSagFL3sb20TPIwI5yOYt1B4FDJBN06OC52KQ=;
        b=YDbrH8yf6jgs4iQIclqq1rHHSIAITzQnA6zN9n7STkyUUqehyUw3l+DVoWvEZrMenh
         tUkag+WBJiwcjtSIiSbRAKCitkKVbkZBdHbhD6M3njgbe+5lXIccHp9d1nO6j12nMN3N
         YrlIXgf3sHqLDnzmGj+f4/h49mXL7TMMQsyd2jCY0pJvp5ifakDHKX88DiTyCNhAKVnM
         Yq9EqLrIbpDoIUSpDlNmsVQFVxNakFsw1o3T9jvLoNcP7EkQ4ncrwccTFutmcVTpDb+K
         W9Om5ZegrBOH3tjGa5CG/hu+DTLkjbFVVWe7nf/g/XWrTy0YqFe4HentYwNcKcMWirSx
         vjdw==
X-Gm-Message-State: AOJu0YzKrhJgWXkHjFcE6c6hV9TGnKpEm5m0wd9FSkc5GmZMe8ISpboU
	LQjFaZ7NXq93FBi4Ey+ADls=
X-Google-Smtp-Source: AGHT+IFa3RfUbj/KvRPtnyYLukkiLbUpibeXSQQJVjWCD+COC0JYXe4hh6Ulcz0pXtf6RnWrg6MH+Q==
X-Received: by 2002:a05:6512:713:b0:503:fee:584b with SMTP id b19-20020a056512071300b005030fee584bmr2360054lfs.13.1695863395671;
        Wed, 27 Sep 2023 18:09:55 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q6-20020ac246e6000000b005032ebff21asm2794809lfo.279.2023.09.27.18.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 18:09:54 -0700 (PDT)
Message-ID: <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Sep 2023 04:09:53 +0300
In-Reply-To: <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
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
	 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
	 <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
	 <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
	 <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
	 <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
	 <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
	 <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
	 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
	 <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
	 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
	 <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
	 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
	 <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
	 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
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

On Tue, 2023-09-26 at 09:25 -0700, Andrii Nakryiko wrote:
[...]
> > In other words there is a function states_equal' for comparison of
> > states when old{.branches > 0}, which differs from states_equal in
> > the following way:
> > - considers all registers read;
> > - considers all scalars precise.
> >
>=20
> Not really. The important aspect is to mark registers that were
> required to be imprecise in old state as "required to be imprecise",
> and if later we decide that this register has to be precise, too bad,
> too late, game over (which is why I didn't propose it, this seems too
> restrictive).

Could you please elaborate a bit? What's wrong with the following:
Suppose I see a register R that differs between V and C an is not
precise in both. I fork C as C', mark R unbound in C' and proceed with
C' verification. At some point during that verification I see that
some precise R's value is necessary, thus C' verification fails.
If that happens verification resumes from C, otherwise C is discarded.
I also postpone read and precision marks propagation from C' to it's
parent until C' verification succeeds (if it succeeds).

[...]
> 1. If V and C (using your terminology from earlier, where V is the old
> parent state at some next() call instruction, and C is the current one
> on the same instruction) are different -- we just keep going. So
> always try to explore different input states for the loop.
>=20
> 2. But if V and C are equivalent, it's too early to conclude anything.
> So enqueue C for later in a separate BFS queue (and perhaps that queue
> is per-instruction, actually; or maybe even per-state, not sure), and
> keep exploring all the other pending queues from the (global) DFS
> queue, until we get back to state V again. At that point we need to
> start looking at postponed states for that V state. But this time we
> should be sure that precision and read marks are propagated from all
> those terminatable code paths.
>=20
> Basically, this tries to make sure that we do mark every register that
> is important for all the branching decision making, memory
> dereferences, etc. And just avoids going into endless loops with the
> same input conditions.
>=20
> Give it some fresh thought and let's see if we are missing something
> again. Thanks!

This should work for examples we've seen so far.
Why do you think a separate per-instruction queue is necessary?
The way I read it the following algorithm should suffice:
- add a field bpf_verifier_env::iter_head similar to 'head' but for
  postponed looping states;
- add functions push_iter_stack(), pop_iter_stack() similar to
  push_stack() and pop_stack();
- modify is_state_visited() as follows:

 static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
     ...
     while (sl) {
         ...
         if (sl->state.branches) {
             ...
             if (is_iter_next_insn(env, insn_idx)) {
                 if (states_equal(env, &sl->state, cur)) {
                     ...
                     iter_state =3D &func(env, iter_reg)->stack[spi].spille=
d_ptr;
                     if (iter_state->iter.state =3D=3D BPF_ITER_STATE_ACTIV=
E) {
+                        // Don't want to proceed with 'cur' verification,
+                        // push it to iters queue to check again if states
+                        // are still equal after env->head is exahusted.
+                        if (env->stack_size !=3D 0)
+                            push_iter_stack(env, cur, ...);
                         goto hit;
                     }
                 }
                 goto skip_inf_loop_check;
             }
     ...
 }
=20
- modify do_check() to do pop_iter_stack() if pop_stack() is
  exhausted, the popped state would get into is_state_visited() and
  checked against old state, which at that moment should have all
  read/precision masks that env->head could have provided.

After working on "widening conjectures" implementation a bit this
approach seems to be much simpler. Need to think harder if I can break it.

