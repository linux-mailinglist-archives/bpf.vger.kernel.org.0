Return-Path: <bpf+bounces-10576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122127A9C2F
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11072828B8
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D281944A;
	Thu, 21 Sep 2023 18:17:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BD4E26F
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:17:27 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B59D2D53C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 11:17:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9adb9fa7200so280080166b.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695320217; x=1695925017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+BSTpDGURclV71GWi0u2bIvjvtBJ8BE2Net+MXKX08=;
        b=X+lPQ68rXWT9XP4KPVjqreriOJLZYgfBVOBc2f7dYba/N3013x91nF5/ArmS0jzARr
         X7OYEzPsdZoWnCkhfOiXONJ3iQueXVqxpFo7rNcyFujGptAxy4PDNpKuQ1QfRUx5y44z
         LQRKy+1YimYvwT1T4UBAo8NuROCrzDeZCw+2stl3CIPCb0mAy3ezf7tmI1pdpMNwpseO
         zphM78SSr+gvZIILc2HLUpcu8FUAVVDr9GB1uafCraHPYr0N3gZIt9xFUv+YNQnurAGi
         b3zvWPbHTydppeFQlp4O5isJDut8KVyRHC7VNa4IDIn3fzcpHe6FYRTScRf5cXB8n4aa
         rP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320217; x=1695925017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+BSTpDGURclV71GWi0u2bIvjvtBJ8BE2Net+MXKX08=;
        b=ScsmQj5zsl+9TEDyiQ0UWd4qhGDeOh8qi6BUTkzZ3WnvM9YDBZJ8nyu57BV8GZF6JK
         mAsHyk0ZmTgxD4c7VpLjOaDdwHIec1y/zVTfs8Sit9jKUuPobmSiDKAMTV39UAo+fvWC
         UbKQZ2XiW+lBjpODyA2qXEQMNthRIIBo68FHr9wSMkd8266lJZy9mRI15YcGI7VUiU5S
         0DdjyMBPne3G2nivVpbMLAgKUXCdL50yfoBbJsVDehyRFo720mTLVyEd14j35QbrwmZg
         crxRzcDWDGn8C5bugCnUQ5jsr4aEAoRQHFcNjp1CVHjKN3xbKH4AnlnG2upqPa5PCu9o
         7npQ==
X-Gm-Message-State: AOJu0YxEoq5d5EcYdgNXv3hJRQTlI3Uh7SLXFBnu+Ze6PErq+Bwc5Nbk
	pcXysulnGqlxmtSuMhRmkJ0=
X-Google-Smtp-Source: AGHT+IEvjEKyChEXBucxiX4/Edz7A1QrGg+S0PPZUiJxhbCJMjXs+BvaNfWky7amp4lYsGne92MkLQ==
X-Received: by 2002:a17:906:21c:b0:9a1:b144:30f4 with SMTP id 28-20020a170906021c00b009a1b14430f4mr625961ejd.14.1695320217115;
        Thu, 21 Sep 2023 11:16:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rp13-20020a170906d96d00b009ada9f7217asm1409404ejb.88.2023.09.21.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:16:56 -0700 (PDT)
Message-ID: <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Sep 2023 21:16:55 +0300
In-Reply-To: <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
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

On Thu, 2023-09-21 at 09:35 -0700, Andrii Nakryiko wrote:
> I've been thinking in a similar direction as Alexei, overnight. Here
> are some raw thoughts.
>=20
> I think the overall approach with iter verification is sound. If we
> loop and see an equivalent state at the entry to next loop iteration,
> then it's safe to assume doing many iterations is safe. The problem is
> that delayed precision and read marks make this state equivalence
> wrong in some case. So we need to find a solution that will ensure
> that all precision and read marks are propagated to parent state
> before making a decision about convergence.
>=20
> The idea is to let verifier explore all code paths starting from
> iteration #N, except the code paths that lead to looping into
> iteration #N+1. I tried to do that with validating NULL case first and
> exiting from loop on each iteration (first), but clearly that doesn't
> capture all the cases, as Eduard have shown.
>
> So what if we delay convergence state checks (and then further
> exploration at iteration #N+1) using BFS instead of DFS? That is, when
> we are about to start new iteration and check state convergence, we
> enqueue current state to be processed later after all the states that
> "belong" to iteration #N are processed.

This sounds correct if one iterator is involved.

> We should work out exact details on how to do this hybrid BFS+DFS, but
> let's think carefully if this will solve the problems?
>=20
> I think this is conceptually similar to what Alexei proposed above.
> Basically, we "unroll" loop verification iteration by iteration, but
> make sure that we explore all the branching within iteration #N before
> going one iteration deeper.
>=20
> Let's think if there are any cases which wouldn't be handled. And then
> think how to implement this elegantly (e.g., some sort of queue within
> a parent state, which sounds similar to this separate "branches"
> counter that Alexei is proposing above).

To better understand the suggestion, suppose there is some iterator
'I' and two states:
- state S1 where depth(I) =3D=3D N and pending instruction is "next(I)"
- state S2 where depth(I) =3D=3D N and pending instruction is *not* "next(I=
)"
In such situation state S2 should be verified first, right?
And in general, any state that is not at "next(I)" should be explored
before S1, right?

Such interpretation seems to be prone to deadlocks, e.g. suppose there
are two iterators: I1 and I2, and two states:
- state S1 with depth(I1) =3D=3D N, depth(I2) =3D=3D M, at instruction "nex=
t(I1)";
- state S2 with depth(I1) =3D=3D N, depth(I2) =3D=3D M, at instruction "nex=
t(I2)".

E.g. like in the following loop:

    for (;;) {
      if (<random condition>)
        if (!next(it1)) break; // a
      else
        if (!next(it2)) break; // b
      ...
    }

I think it is possible to get to two states here:
- (a) it1(active, depth 0), it2(active, depth 0) at insn "next(it1)"
- (b) it1(active, depth 0), it2(active, depth 0) at insn "next(it2)"

And it is unclear which one should be processed next.
Am I missing something?

