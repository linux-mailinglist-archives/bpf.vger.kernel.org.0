Return-Path: <bpf+bounces-11216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CAE7B58AC
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 206D51C204F6
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5B1DDEB;
	Mon,  2 Oct 2023 17:18:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2471A73C
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 17:18:24 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB52B4
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 10:18:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c16757987fso176903031fa.3
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696267101; x=1696871901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bt0f/5V02Y5BZoxMTn/T6yVJC+2/WufRPZJqiL6v+C4=;
        b=TDtADpWw0csYwbu0l1OfKu1Y38sGqK1HZA6NJ8x6phfMZpu5I2d7EiJPWZY2VLV4pp
         smq+XXyMt3rAloxmV6kMc2PJmd/1Ndvh9Da65VgZvJrWZEtMX717ZBhRmLpfUQpOsY4i
         J2fYeNFeU8Ezed/aAVyDNyAeByDF/yKacXxrXM6jO/6oF+RKpNHhdbog6sqDK0BEWTpj
         3WT/qFVaYEunlP2CKDQOM2HAxIhYrs3bo8FpLBljQlXiaY1Fh4ZKbDqN4BQ6pIJmOvsr
         8DEMeEalyrwrj0cGKiPzaJfVo6JGteVuMvnd/IKmicEY1yl3agz5975RX8jjF7YkRupa
         c7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267101; x=1696871901;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt0f/5V02Y5BZoxMTn/T6yVJC+2/WufRPZJqiL6v+C4=;
        b=KR/4kiRNkuYQJeMfQ7Q3OUfinfrwX5sqc/64Uv2lXI+lSYILaHWB/0jjcaEPGNnNVx
         x6XXFmBY2fxyqe05+N+3lKGai//NXxPJ+dFi/R1UoYxVIgBPqY1iX49cwcBXixqpiYMi
         c9CCmsD7ucTzdHi0Mz0CNizDTCiV18s1Y7seoLStqbtystWBgtgMJbA2yaJhxHhAi23H
         viCdOwbhbYGI78JgT0dXM2ideRwBiuj28HeP9dQktjw1TWp1r3EfU8N0HhwxIRfdCBS2
         Dfgik5B2YvAzyQqtTh8HDMAL8DNR/mrFh2C2IUm5mY58nIvpO/RE2ux4xywLWSz5YDjj
         P1mQ==
X-Gm-Message-State: AOJu0YyggyT1fZmnx71U6WomOl767KiWIjvdw1kUGe2w0du88YMUyjrC
	eaVvOTMsK11MR6/THF4JXHQiTeq88mNA9mCW
X-Google-Smtp-Source: AGHT+IETkDzBgymT6wERffet7c5mbFlSaRFO2FyhKjSp/X5MIkbESxYN9DstMEJjuEgniKgrsP3HlQ==
X-Received: by 2002:a2e:9ecb:0:b0:2bc:df3f:7140 with SMTP id h11-20020a2e9ecb000000b002bcdf3f7140mr9211730ljk.17.1696267100376;
        Mon, 02 Oct 2023 10:18:20 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x26-20020a2e9dda000000b002c004175d26sm5408176ljj.56.2023.10.02.10.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:18:19 -0700 (PDT)
Message-ID: <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 02 Oct 2023 20:18:18 +0300
In-Reply-To: <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
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
	 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
	 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
	 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
	 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-02 at 09:29 -0700, Alexei Starovoitov wrote:
[...]
> > I'd like to argue about B "widening" for a bit, as I think it might be
> > interesting in general, and put A aside for now. The algorithm for
> > widening looks as follows:
> > - In is_states_equal() for (sl->state.branches > 0 && is_iter_next_insn=
()) case:
> >   - Check if states are equal exactly:
> >     - ignore liveness marks on old state;
> >     - demand same type for registers and stack slots;
> >     - ignore precision marks, instead compare scalars using
> >       regs_exact() [this differs from my previous emails, I'm now sure
> >       that for this scheme to be correct regs_exact() is needed].
> >   - If there is an exact match then follow "hit" branch. The idea
> >     being that visiting exactly the same state can't produce new
> >     execution paths (like with graph traversal).
>=20
> Right. Exactly the same C state won't produce new paths
> as seen in visited state V, but
> if C=3D=3DV at the same insn indx it means we're in the infinite loop.

This is true in general, but for bpf_iter_next() we have a guarantee
that iteration would end eventually.

> > More formally, before pruning potential looping states we need to
> > make sure that all precision and read marks are in place.
> > To achieve this:
> > - Process states from env->head while those are available, in case if
> >   potential looping state (is_states_equal()) is reached put it to a
> >   separate queue.
> > - Once all env->head states are processed the only source for new read
> >   and precision marks is in postponed looping states, some of which
> >   might not be is_states_equal() anymore. Submit each such state for
> >   verification until fixed point is reached (repeating steps for
> >   env->head processing).
>=20
> Comparing if (sl->state.branches) makes sense to find infinite loop.
> It's waste for the verifier to consider visited state V with branches > 0
> for pruning.
> The safety of V is unknown. The lack of liveness and precision
> is just one part. The verifier didn't conclude that V is safe yet.
> The current state C being equivalent to V doesn't tell us anything.
>=20
> If infinite loop detection logic trips us, let's disable it.
> I feel the fix should be in process_iter_next_call() to somehow
> make it stop doing push_stack() when states_equal(N-1, N-2).

Consider that we get to the environment state where:
- all env->head states are exhausted;
- all potentially looping states (stored in as a separate set of
  states instead of env->head) are states_equal() to some already
  explored state.

I argue that if such environment state is reached the program should
be safe, because:
- Each looping state L is a sub-state of some explored state V and
  every path from V leads to either safe exit or another loop.
- Iterator loops are guaranteed to exit eventually.

Achieving this steady state is the mechanism that tells verifier that
there is no need to schedule exploration of the N+1 iteration level
for any iterator in the program.

