Return-Path: <bpf+bounces-10652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4897AB93D
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 20:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3B9AC28265C
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480141E40;
	Fri, 22 Sep 2023 18:36:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37B1C29
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 18:36:58 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C0BAB
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 11:36:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso44406401fa.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695407810; x=1696012610; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gQe5ealIQWWefqLXCyIJySSV0y9/zbzwRVFj2qsIUOc=;
        b=G9z5hY64qnRoY6VEA1TFmqNSTmWPe6pz9v+pLL8cspHcJYCdQaQowN2JqugM8IzLlW
         eBK1ehFK7S8HX+UDAbYf4G9E18oBgcVWwmqzEb7aSpyBmkgCkLlb9Rhik5Vlb5TWWNaL
         wFBYyIVa7xB4Z1K1WVdRXTKMUt3yAreB/6PinwQXUXdyxXXU5T7hGmF1nXZsNv6QwbBQ
         a40sbx1ySAp9kL0wS55SmBGTLz3Lm0XZ8V108IpRT96z/3ivKTJJlzrWUd1WoBcUkD+8
         3GU7ICuDcAC7k9zVlL/ZDUhi8h9W8R03kjux0WIRhzKGk5NZVyrZsEKgjfyilJj4Dq7P
         5zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407810; x=1696012610;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQe5ealIQWWefqLXCyIJySSV0y9/zbzwRVFj2qsIUOc=;
        b=qftuFFbngXTj2+uheAAq96i4DTtEtKhdMQys8I12uenhg91LBErQUy8Fnyxn6wIs+L
         EZOECrjX6Q2JBKZhqWm4LvR1QugSvO2rrLoL90ptMA1sR2jhAyB/COTtFJOFIShvGkNd
         ST4Go6YfzYoO7tv4OQcvzR6L0Pc/NfjAT7op3lLXnIdQ3PB1kvpMxDxU9WsG+282IpEq
         eRAgXvDvKcIagjps6wWtF8sVd/CtmPmjONzLJAE08ka7lMcwU8JAPLqrAqZFD+QpKOKP
         SuEUjGra5lTBh1dc1KTPjMgeB722gkHEJe+eRyM9dxbt3Q13DzxZeuC+ZrMaaOGqw8fs
         xu6w==
X-Gm-Message-State: AOJu0YyUIXSls8WuikIt/rvyUjGDcoE2d3mQ/P0FmAM2wQe3CYYzfJSF
	zlB3SxsGLf5oPCsgVZ9FeWM7/GGuhKE=
X-Google-Smtp-Source: AGHT+IGpYWw+72q8GoZ4EZsxJ9i2saMl/0soxEcoTFribrYewXYsy5zF9xLJklbJQndLxhDY+1byJg==
X-Received: by 2002:a2e:b0dc:0:b0:2bf:f365:c7b9 with SMTP id g28-20020a2eb0dc000000b002bff365c7b9mr80362ljl.18.1695407809836;
        Fri, 22 Sep 2023 11:36:49 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906278b00b00977eec7b7e8sm3050643ejc.68.2023.09.22.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:36:49 -0700 (PDT)
Message-ID: <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 22 Sep 2023 21:36:47 +0300
In-Reply-To: <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
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

On Thu, 2023-09-21 at 19:48 -0700, Andrii Nakryiko wrote:
> Yes, my gut feeling was that if this idea works at all, then ordering
> for this won't matter. The question is if the idea itself is sound.
> Basically, I need to convince myself that subsequent iterations won't
> add any new read/precise marks. You are good at counter examples, so
> maybe you can come up with an example where input state into iteration
> #1 will get more precision marks only at iteration #2 or deeper. If
> that's the case, then this whole idea of postponing loop convergence
> checks probably doesn't work.

Consider the following code:

    1.  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
    2.  int num_iter_bug(const void *ctx) {
    3.      struct bpf_iter_num it;
    4.      __u64 val =3D 0;
    5.      __u64 *ptr =3D &val;
    6.      __u64 rnd =3D bpf_get_current_pid_tgid();
    7.
    8.      bpf_iter_num_new(&it, 0, 10);
    9.      while (bpf_iter_num_next(&it)) {
    10.          rnd++;
    11.          if (rnd =3D=3D 42) {
    12.              ptr =3D (void*)(0xdead);
    13.              continue;
    14.          }
    15.          if (!bpf_iter_num_next(&it))
    16.              break;
    17.          bpf_probe_read_user(ptr, 8, (void*)(0xdeadbeef));
    18.      }
    19.      bpf_iter_num_destroy(&it);
    20.      return 0;
    21. }

As far as I understand the following verification paths would be
explored (ignoring traces with drained iterators):
- entry:
  - 8,9,10,11,12,13:
    - at 9 checkpoint (C1) would be created with it{.depth=3D0,.state=3Dact=
ive},ptr=3D&val;
    - at 11 branch (B1) would be created with it{.depth=3D0,.state=3Dactive=
},ptr=3D&val;
    - jump from 13 to 9 would be postponed with state
      it{.depth=3D0,.state=3Dactive},ptr=3D0xdead as proceeding would incre=
ase 'it' depth;
- jump from 11 to 15 (branch B1):
  - 15:
    - checkpoint would be created with it{.depth=3D0,.state=3Dactive};
    - jump from 15 to 17 would be postponed with state
      it{.depth=3D0,.state=3Dactive} as proceeding would increase 'it' dept=
h.
- at this point verifier would run out of paths that don't increase
  iterators depth and there are two choices:
  - (a) jump from 13 to 9 with state it{.depth=3D0,.state=3Dactive},ptr=3D0=
xdead;
  - (b) jump from 15 to 17 with state it{.depth=3D0,.state=3Dactive},ptr=3D=
&val.
  If (a) would be processed first there would be no read mark for
  'ptr' in C1 yet and verifier runs into to the same issue as with
  original example.

Do I miss something or is it a legit counter-example?

> I can't say I understand what exactly you are proposing and how you
> are going to determine these conservative precision marks. But I'd
> like to learn some new ideas, so please elaborate :)

I'll send a follow-up email, trying to figure out what to do with pointers.

