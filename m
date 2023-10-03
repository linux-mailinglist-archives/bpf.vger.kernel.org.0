Return-Path: <bpf+bounces-11298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDFA7B7152
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 97A6A1C2040D
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D41D3CCE3;
	Tue,  3 Oct 2023 18:50:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB3347CB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 18:50:28 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5D9B
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 11:50:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso1308786f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696359025; x=1696963825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7DVVpzc67wcIL5GFz6qVxVQDuuUMaEbUUuospolPNg=;
        b=Dl30VK82ZF6e2DLK/13Bo81G2sjjk86US68972RaATvEMlYvHBtJ/L4mBxt/2bP880
         SgXD5bK1ziaJXl+ZeaRh6RJrVNfepfrrz53irD8+O3pDAkLpiOpqvN0K6imWqOjubBXG
         x42Sx/hNcZwgmanpAFMYm7gt2mYsJVEKtZKAxonGKg7cDSMIUIfJfNGwmArFYvhWT44s
         veuOwLZdhKPiiFI6tXhCjPTaLxh4QWIpvRkct2rUjbisGG43KesPnO54comst0E51htZ
         vfBBBIFUrhT55oRnOfD5uXVyYkV+v8j7mKseThidwV7gVhKmDeHDoDUCzd9HzKOmmntv
         q6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696359025; x=1696963825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7DVVpzc67wcIL5GFz6qVxVQDuuUMaEbUUuospolPNg=;
        b=ULCRCJ6F6w2vE4CdbWUMHhJOg3gKo1W2PZv79381C24dqQldUtHcbjPF2JN6A0fXUo
         +16uX4yd58J39EzVJ8GqqPlddnFSMnWbx5KccdS+XJprBNqnGU/CYHVPWPoCCJz31di0
         YMIDsqZj/VXAmsdDUGHBrlNqgfb8K/WmJO1rKFYGNM1Wse8LJw1jqr+Jw68Q+cp9dNHU
         uz+EWRJcbI6RrvAN3bczmd0KSgNVHnsHwQRFU9WhhJH863SFQPvAHljO1MKorQEj05cd
         sA1bECrVNp0J2zDj/S3lkOiZtxPJ719C1M/eZoHzddgtRvjRq/9GpHdyA1C7TUftHKcg
         tiqw==
X-Gm-Message-State: AOJu0Yw8AXXcqv1y6a/PYzyGi+OWXgMypnkU+sQS9vSUucI/sk+MIkyE
	tjanPuY+U2t2V/2p0Q/hClJvWR9PReNCe/fg6cWd48g4KFA=
X-Google-Smtp-Source: AGHT+IEaO9BgGo0jSD+O5r5K21XP9TfuoN/qgnWTe7jbcZ7di/FUDq5pO3EwYLaRd4+2eMLP9gy3xfXO76/NeJoLlyI=
X-Received: by 2002:a5d:6447:0:b0:31f:fb5d:96da with SMTP id
 d7-20020a5d6447000000b0031ffb5d96damr77375wrw.64.1696359024944; Tue, 03 Oct
 2023 11:50:24 -0700 (PDT)
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
 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com> <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
In-Reply-To: <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Oct 2023 11:50:13 -0700
Message-ID: <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 8:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
>
> When I put states to the loop stack I do copy_verifier_state() and
> increase .branches counter for each state parent, so this should not
> trigger warnings with update_branch_counts().

No warn doesn't mean it's correct.
I suspect what your reschedule_loop_states() will increase
branches from 0 to 1.
Which is equivalent to increasing refcnt from zero. Not good.

> Logically, any state
> that has a loop state as it's grandchild is not verified to be safe
> until loops steady state is achieved, thus such states could not be
> used for states pruning and it is correct to keep their branch
> counters > 0.

Correct.

>
> propagate_liveness() and propagate_precision() should not be called
> for the delayed states (work-in-progress I'll update the patch).
> Behavior for non-delayed states should not be altered by these changes.

I disagree. Delayed states should not have different propagation rules.

> Iterators (and callbacks) try to diverge from regular verification
> logic of visiting all possible paths by making some general
> assumptions about loop bodies. There is no way to verify safety of
> such bodies w/o computing steady states.

Iterators and callbacks should not be special.
They are no different than bounded loops
and their verification shouldn't be much different.
Bounded loops have constant upper bound while
iterators do not, so they have to converge based on state
equivalence, but the verifier still has to do DFS and discover
all possible paths, propagate precision and liveness before
considering two states equivalent.
It does this today for bounded loops and should do the same
for iterators.
The question is how to do it.
Delaying states and breaking DFS assumptions is a non starter.

I see now that my 2nd hack is still buggy.
Differentiating state with branches vs looping_states counters
doesn't seem to work in all cases.
Your loop_state_deps1 demonstrates that. It's a great test.

