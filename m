Return-Path: <bpf+bounces-10311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C528C7A4E66
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26511C2197A
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5E2375B;
	Mon, 18 Sep 2023 16:15:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A31F5EF
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:15:41 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DC426686
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:15:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50317080342so1949183e87.2
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053735; x=1695658535; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnQ6LneeJ3oh0Wn2peQo3Xl8k00US1hnY2kHOrzS3gs=;
        b=QGvAiNNufbmZgpNL9rTWsNQcLFTdImzpqx4RXwvMKh+0SfyUT4RmBDB9qEHWWnFPAG
         wKV5kKMvH8idA6IYIJFaMucIy+2REq/QaVss3Jx9O5AFjbRBIVWrlb4uDN2IxtRfvuro
         94VFWQ8DN/kKffNSU7dMTfdfU6mWKf67/LQjF9SFBTh1GJ7SIeaWleVM+csOBaakQlf1
         20bI2JTKYA1CvQl/Awjg71wRGqX1UVab5EoNaDMyGUsIom7w0B6LsZiJ9nIO8EQWc8ns
         idb74HCTkacM4xovX9v8Gy7KpVNzXrX/sBW12wgMtgYZoCmgR1wTsekS9KM2sF4l1eGK
         VjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053735; x=1695658535;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnQ6LneeJ3oh0Wn2peQo3Xl8k00US1hnY2kHOrzS3gs=;
        b=cj7TQVEYBSrpd5girWrcbeiMHH3oxv8buqj/JGKDn7lieJCuz6gtQSWgyKWyUX8ihZ
         fDzJe+43LoZzoilUwqVa/rdhnTeE2qPS01GX6ceMuoBWrLJG+Oe9wM48yvBxm6rB0Bn+
         3mXHRdm+cxu6uuyN3i6AN3J8quIX2VDA1hG72l9CyURFH7+0Dn87aG+iwVwwxXLyyaE8
         s7qmgDFLvoS31HwvORHulH1cpYQFERPExeXxIEVMIDmHbuHTVsIktzo0umyLJsUd998n
         oHeAoN8iM1tdJTuXhMiN138vcGGx7OsMjiEs24kJ8+ZjHLGzVQLDXpvrmaqlMJRgAkHv
         OhhA==
X-Gm-Message-State: AOJu0YwrFlAUlB8/49YGhsPhyT8H6dX1LexjkQSnn/40wYR17qdHIteE
	IKumxACUSAR7GRzE25Q/78LDID+YuV8=
X-Google-Smtp-Source: AGHT+IHeoP2CWOjjLyQJ+IXyvzkzdsH36fPe07+1yHUg/sVTUGnMA9jz1+OFjBGNCTX9twsF62oVEQ==
X-Received: by 2002:a17:907:7627:b0:9a1:e57a:362c with SMTP id jy7-20020a170907762700b009a1e57a362cmr7420908ejc.9.1695042376708;
        Mon, 18 Sep 2023 06:06:16 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906359a00b009875a6d28b0sm6421898ejb.51.2023.09.18.06.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 06:06:16 -0700 (PDT)
Message-ID: <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, bpf
 <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, Tamir
 Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
 kernel-team@dataexmachina.dev, Song Liu <song@kernel.org>
Date: Mon, 18 Sep 2023 16:06:14 +0300
In-Reply-To: <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
References: 
	<CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
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

On Mon, 2023-09-18 at 00:09 +0200, Kumar Kartikeya Dwivedi wrote:
[...]
>=20
> I was planning to get to this eventually, but it's great if you are
> looking to do it.
>=20
> > After some analysis I decided to go with Alexei's suggestion and
> > implement something similar to iterators for selected set of helper
> > functions that accept "looping" callbacks, such as:
> > - bpf_loop
> > - bpf_for_each_map_elem
> > - bpf_user_ringbuf_drain
> > - bpf_timer_set_callback (?)
> >=20
>=20
> The last one won't require this, I think. The callback only runs once,
> and asynchronously.
> Others you are missing are bpf_find_vma and the bpf_rbtree_add kfunc.
> While the latter is not an interator, it can invoke the same callback
> an unknown number of times.

Noted, thank you.

> The other major thing that needs to be checked is cases where callback
> will be executed zero times. There is some discussion on this in [0],
> where this bug was reported originally. Basically, we need to explore
> a path where the callback execution does not happen and ensure the
> program is still safe.
>=20
> [0]: https://lore.kernel.org/bpf/CAP01T74cOJzo3xQcW6weURH+mYRQ7kAWMqQOgtd=
_ymSbhrOoMQ@mail.gmail.com
>=20
> You could also consider taking the selftests from this link, some of
> them allow completely breaking safety properties of the verifier.

Thank you, I missed this thread.

[...]
> > I have a patch (at the end of this email) that correctly recognizes
> > the bpf_loop example in this thread as unsafe. However this patch has
> > a few deficiencies:
> >=20
> > - verif_scale_strobemeta_bpf_loop selftest is not passing, because
> >   read_map_var function invoked from the callback continuously
> >   increments 'payload' pointer used in subsequent iterations.
> >=20
> >   In order to handle such code I need to add an upper bound tracking
> >   for iteration depth (when such bound could be deduced).
> >=20
>=20
> Yes, either the loop converges before the upper limit is hit, or we
> keep unrolling it until we exhaust the deduced loop count passed to
> the bpf_loop helper. But we will need to mark the loop count argument
> register as precise when we make use of its value in such a case.

Yes, marking counter as precise makes sense but I think it would
happen automatically. My current plan is to mark index register as
bounded and use depth tracking only internally to decide whether to
schedule another "active" iteration state. If that would not be
sufficient, I will try assigning specific values for loop counter
(hesitate to do it to avoid conflict with convergence detection).

[...]
> > - the callback as bellow currently causes state explosion:
> >=20
> >   static int precise1_callback(__u32 idx, struct precise1_ctx *ctx)
> >   {
> >       if (idx =3D=3D 0)
> >           ctx->a =3D 1;
> >       if (idx =3D=3D 1 && ctx->a =3D=3D 1)
> >           ctx->b =3D 1;
> >       return 0;
> >   }
> >=20
> >   I'm not sure yet what to do about this, there are several possibiliti=
es:
> >   - tweak the order in which states are visited (need to think about it=
);
> >   - check states in bpf_verifier_env::head (not explored yet) for
> >     equivalence and avoid enqueuing duplicate states.
> >=20
> >=20
> > I'll proceed addressing the issues above on Monday.
> >=20
>=20
> I think there is a class of programs that are nevertheless going to be
> broken now, as bpf_loop and others basically permitted incorrect code
> to pass through. And the iteration until we arrive at a fixpoint won't
> be able to cover all classes of loop bodies, so I think we will need
> to make a tradeoff in terms of expressibility vs verifier complexity.
> In general, cases like this with branches/conditional exit from the
> loop body which do not converge will lead to state explosion anyway.

This might be the case, however I found that specific issue with
"precise1_callback" could be resolved by using mark_force_checkpoint()
to mark iteration back-edges (same way it is done for regular iterators).
So maybe impact won't be that bad.

Thanks,
Eduard

