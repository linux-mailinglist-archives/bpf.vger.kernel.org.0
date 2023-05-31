Return-Path: <bpf+bounces-1527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E6718A25
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8A81C20F05
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52455200AD;
	Wed, 31 May 2023 19:31:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55E805
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:31:01 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DED107
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:30:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af30a12e84so758881fa.0
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685561458; x=1688153458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PnlzmCOC+rL5ssGqMcZzFssN3tnZidUP4NqUBdBEfMQ=;
        b=sxeUg8D/PdJ2lMpAnFWn5fN3ZAo7F4rlCAIFfFGRnDgHyNKfXsBu4AJ2AEghRraice
         ZhhXWwV97a8BUrb9RSDEGKxBacrFzZCvb1lQbgXs2awrKxaHt8sLdJ2h8j3w+l+Htlul
         yqkmOBUyb3ViwI1qbAnCaJo1UO7tKvDgkkoX9uMAgqADmxKF3hks1rpKAWLNmzg1Go7B
         237qkkFjAAihNVv5V+DQFONC/lPbNhhfGq2PMOq/EAyowscSOgsM8u/lDrvkS7U30/23
         L9aFgoHmaQN/aZZkH78fJIk9Wvqi/XCFd1O+nPVi/rCwHvF9HO9ZC+RFDSn7IZTHfozc
         hZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561458; x=1688153458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnlzmCOC+rL5ssGqMcZzFssN3tnZidUP4NqUBdBEfMQ=;
        b=GUiyeog63DXsw58HwXZ7zTb8GHJ10jnLp+X48xv/h35KGsZZUfPUP0OGFUJmacXh7v
         7j7eeF+uvfhwgaXWbU0KTI1FfxfNA+/J7x/QWfR3dzYm7eE/obwYBhVabM0hz7C34DEt
         +jRnTvAghzpuBSELgu+WbMqYCTPpL1so88VhqKkTUjOp8cLeeov9ILm+8zviY2+l/cVi
         /blDddNKJ4LsCMuREISYWplP1HNLVRX2HoIAJ7cpLD4OPaHU1xN2mMT9Qx1/LDlkLACg
         woz1Zow0dpE/MAyR2oEROhEvCu93jDbVdD31hSoBaQKa1ihQxn5ipGdbywdMb/aqiYYs
         20Bg==
X-Gm-Message-State: AC+VfDwo1w8QPc4aDK+pVuAxJMNYZzadDQSda3lL7hOe9adJuXBB5vn/
	7VCmmG+q++emJI9HLGPgfVoJsK0X2MYIMw==
X-Google-Smtp-Source: ACHHUZ62UorK2sI4XBIg98eKahQ5yuze/51EfQ+gLmJQM8mRbwjErsy4G/2On0cEfZqRDOHcSRSSTw==
X-Received: by 2002:a2e:8502:0:b0:2ad:bedc:9961 with SMTP id j2-20020a2e8502000000b002adbedc9961mr3179990lji.24.1685561457792;
        Wed, 31 May 2023 12:30:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y14-20020a2e95ce000000b002ad9057fd00sm3459963ljh.85.2023.05.31.12.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:30:57 -0700 (PDT)
Message-ID: <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Wed, 31 May 2023 22:30:55 +0300
In-Reply-To: <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
	 <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-05-31 at 11:29 -0700, Andrii Nakryiko wrote:
> On Wed, May 31, 2023 at 10:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> > [...]
> > > Also, it might make sense to drop SCALAR register IDs as soon as we
> > > have only one instance of it left (e.g., if "paired" register was
> > > overwritten already). I.e., aggressively drop IDs when they become
> > > useless. WDYT?
> >=20
> > I added modification which resets sole scalar IDs to zero before
> > states comparison, it shows some speedup but is still slow:
> >=20
> >   Filter        | Number of programs | Number of programs
> >                 | patch #1           | patch #1 + sole scalar ID prunin=
g
> >   ---------------------------------------------------------------------=
-
> >   states_pct>10 | 40                 | 40
> >   states_pct>20 | 20                 | 19
> >   states_pct>30 | 15                 | 13
> >   states_pct>40 | 11                 | 8
> >=20
> > (Out of 177 programs).
> >=20
> > I'll modify mark_chain_precision() to propagate precision marks for
> > find_equal_scalars(), so that it could be compared to current patch #3
> > in terms of code complexity and verification performance.
> >=20
> > If you have any thoughts regarding my previous email, please share.
> >=20
>=20
> Yep, I do. Given SCALAR registers with the same ID are meant to "share
> the destiny", shouldn't it be required that when we mark r6 as precise
> we should automatically mark linked r7 as precise at the same point.
> So in your example:
>=20
> 7: r9 +=3D r6
>=20
> should be where we request both r6 and r7 (and whatever other register
> has the same ID) to be marked as precise. It should be very easy to
> implement, especially given my recent refactoring with
> mark_chain_precision_batch.

Ok, I'll modify the `struct backtrack_state` as follows:

  struct backtrack_state {
	struct bpf_verifier_env *env;
	u32 frame;
	u32 reg_masks[MAX_CALL_FRAMES];
+	u32 reg_ids[MAX_CALL_FRAMES];
	u64 stack_masks[MAX_CALL_FRAMES];
+	u64 stack_ids[MAX_CALL_FRAMES];
  };

And add corresponding logic to backtrack_insn().

> The question I have (and again, haven't spent any time thinking about
> any other corner cases, sorry) is whether that alone would be a proper
> fix?

As far as I understand, in terms of correctness it would be a proper fix.
In terms of performance, I hope that it would be enough but we will see.

> As for this u32_hashset, it just feels like a big overkill, tbh. If we
> have to do something like that, wouldn't it be better to, say, set
> highest bit in reg->id (for all linked registers, of course) to mark
> it as "used for range checks" instead of maintaining a separate check?

Unfortunately no, because this ID change would have to be propagated
backwards. It was the first implementation I tried.

> But just the whole idea of keeping track of some special circumstances
> under which IDs are meaningful seems wrong... All this logic is
> complicated, now we are adding another layer of complexity on top. And
> the complexity is not in the code, it's in thinking about all possible
> scenarios and their interactions.

I agree that adding more layers is a complication in itself.
Thank you for your input.

> > [...]


