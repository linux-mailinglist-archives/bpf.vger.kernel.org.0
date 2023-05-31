Return-Path: <bpf+bounces-1523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B244718961
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90A91C20F12
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF3168CB;
	Wed, 31 May 2023 18:30:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98134CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 18:30:08 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A07137
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:30:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f6a9131fdso923334166b.1
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685557804; x=1688149804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37mGzhNhLCscWP841eyXpFbXDhCe9EINoQi8zfuIf1E=;
        b=H2fSQI4eD5fnsI3zUAvS8zlqZQvHzeTFTMCEYtLNJQzEn1RdV7+AZfva8m5bSdzYtH
         EDOe/WH9r1Etz+qtG8qn6pa+JVDOTagLUb4uo3yfFuIb1GVAefG+EFJlLa36cmX+QNo6
         wn9rflCDKk8B3/bLsj2Y4k+J+Y0ZrxfqfhyMEwptCy3MfoQYXKnqaFTfP5Vv22jNZ5UK
         ZrdHkXuiieQjSHyKrdm90pibSrWt/zm2GQCBO0naGLtJ1CbhIMOcoR8Yb8sH3O+ohr64
         ic1/vm1CwKgpZKtrzhTNQ7IBzXlxLKfGZqHAY3/MhrwxbMm7dNY8YxLXZ/JKG5Bdolae
         G30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557804; x=1688149804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37mGzhNhLCscWP841eyXpFbXDhCe9EINoQi8zfuIf1E=;
        b=CnchkxyNwS3w3iQqIdzjvJj8P5I8dCjdw2TvTbilun82HWogRsiIueHHGt4B9gcv0T
         eBK3uUAW7DXRJE7oVQVxWLS6ydw5zmqwZqPS0MxKPO4r9+pcpxu9TzgHpvNpjIJwy9W1
         qcoKaD8/YV8Vdx7Iox4k9l2UL/e6wvjUrc5lYDWXbKRUibBONRyjOwQbf1/DC/lm669O
         ilHlcIWV8ef4g5lRRuOi94KJ/1N7dxT4Uau7Hx6VrLJN5sQTYxJ7a4vaRS7WIA9vBBGR
         NnB9aBj8VstgtSBfWibF/1QS84obAMpj+dbPvQdqb2GT4iUMF/P8pZ3ciFYDegrDVwOn
         ElCg==
X-Gm-Message-State: AC+VfDw0JMjYMWvGrCU3svES6GF/H+Km6+85LO8tNleGQFzHEWT4J50z
	8+ZLUdXVbsh2jcJ2yJ5sm1NzUxFYZ41PgsK9jvk=
X-Google-Smtp-Source: ACHHUZ44Cgudvaf+c50CWdnLycHSEWt+fCwUwpsdOxZhRY1X4JvaSVKcF6s1BKyYAQSBLHpP5lBL5crunpZwNr5rCR0=
X-Received: by 2002:a17:907:6d1f:b0:974:1eeb:1ad6 with SMTP id
 sa31-20020a1709076d1f00b009741eeb1ad6mr5969228ejc.30.1685557803913; Wed, 31
 May 2023 11:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com> <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
In-Reply-To: <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 May 2023 11:29:52 -0700
Message-ID: <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
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

On Wed, May 31, 2023 at 10:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> [...]
> > Also, it might make sense to drop SCALAR register IDs as soon as we
> > have only one instance of it left (e.g., if "paired" register was
> > overwritten already). I.e., aggressively drop IDs when they become
> > useless. WDYT?
>
> I added modification which resets sole scalar IDs to zero before
> states comparison, it shows some speedup but is still slow:
>
>   Filter        | Number of programs | Number of programs
>                 | patch #1           | patch #1 + sole scalar ID pruning
>   ----------------------------------------------------------------------
>   states_pct>10 | 40                 | 40
>   states_pct>20 | 20                 | 19
>   states_pct>30 | 15                 | 13
>   states_pct>40 | 11                 | 8
>
> (Out of 177 programs).
>
> I'll modify mark_chain_precision() to propagate precision marks for
> find_equal_scalars(), so that it could be compared to current patch #3
> in terms of code complexity and verification performance.
>
> If you have any thoughts regarding my previous email, please share.
>

Yep, I do. Given SCALAR registers with the same ID are meant to "share
the destiny", shouldn't it be required that when we mark r6 as precise
we should automatically mark linked r7 as precise at the same point.
So in your example:

7: r9 +=3D r6

should be where we request both r6 and r7 (and whatever other register
has the same ID) to be marked as precise. It should be very easy to
implement, especially given my recent refactoring with
mark_chain_precision_batch.

The question I have (and again, haven't spent any time thinking about
any other corner cases, sorry) is whether that alone would be a proper
fix?


As for this u32_hashset, it just feels like a big overkill, tbh. If we
have to do something like that, wouldn't it be better to, say, set
highest bit in reg->id (for all linked registers, of course) to mark
it as "used for range checks" instead of maintaining a separate check?

But just the whole idea of keeping track of some special circumstances
under which IDs are meaningful seems wrong... All this logic is
complicated, now we are adding another layer of complexity on top. And
the complexity is not in the code, it's in thinking about all possible
scenarios and their interactions.


> [...]

