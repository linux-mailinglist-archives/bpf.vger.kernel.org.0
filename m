Return-Path: <bpf+bounces-10546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96C7A99E5
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B891C20B1E
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9201171A9;
	Thu, 21 Sep 2023 17:27:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043C2033B
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:27:55 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679B561FA
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:27:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so2580675a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317225; x=1695922025; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7oDIFCXg4LqRXkIEh09qhklBqeapWmuUvp+MmSXfA78=;
        b=c/qV4X5VAzWziGbl2ysY3OxJe+VXChgL3deC9hoX4TY9zu0pxK7kGs4vqQ1nHPTifQ
         WkMQFyVuS2pgnlw4G0Jj7AN+Gqgyo/nq4GGPrVlQMZMTEt5je3CxiOr/KmstjRg2DBsD
         sJ83QK3+0cBh/F0qxpkXJ4Hw8hXq0ieqhPj+IKBQog0VKFH3HgICaM4oksZ7bckELmTX
         EjGYgaNgD3ElDRw+wNrVK9OFoa8xby4A7hTEnWEfYTgRkVMDe7dCZqHJMhNJyoxc1JhF
         0dOtPAGqfqnvY13vbtQDJR8jRX9hLXGRvTeXz+09gNirFfYWUiLBqyqXPQDVN4E3oBnj
         Hj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317225; x=1695922025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oDIFCXg4LqRXkIEh09qhklBqeapWmuUvp+MmSXfA78=;
        b=tr/kVK07GVO7UG96NaGbC/1hU3DjRmmdQedQcsw+i8uZCrlO/K59zTW2xun1HQU3mM
         yjzTLz+nrDva8Pj5UUDo2wk4C3B4JLfTHiY1fmVRTQUfvRnCvRT56mPwsIhpLnX/HgQq
         MMGTQOBJh7qJ7MJaq3NFK4jYAVnFBp0VXWQn1hiYLx7KDjtoC5f8Z5FccFyq2G2tSZcG
         GQqOImPQqGNHY+fb3OkXsnYVy2QwLNassGSMY+dVh7FOqAikB77pi/Y0XsyBbc3tq8pN
         v0xMKvV0olP5es1LZ4vrthnhPHgm3fGraN6T9HuLXNa9kKzOXQUju4Gq3G0Ylu2jWCi+
         ZpAg==
X-Gm-Message-State: AOJu0Yx+4AOCM9lBkU2Wmj/w14AlKT31R5ijcKWvOnYUewQHWgPJFsm0
	HxvfBv2ocKCpRm62gQ5sxuPdPG32S4c=
X-Google-Smtp-Source: AGHT+IGameIfbCXh8u1G8hpb9lrzt0rA89XFVayQZ26tR69m304H0LS12ZI3STyPXG+zQ8GTqfb83w==
X-Received: by 2002:a17:906:74db:b0:9a1:b528:d0f6 with SMTP id z27-20020a17090674db00b009a1b528d0f6mr185049ejl.27.1695313424033;
        Thu, 21 Sep 2023 09:23:44 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906564c00b0099ddc81903asm1267362ejr.221.2023.09.21.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 09:23:43 -0700 (PDT)
Message-ID: <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Sep 2023 19:23:41 +0300
In-Reply-To: <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-21 at 05:56 -0700, Alexei Starovoitov wrote:
[...]
> Now I see that asm matches if (likely(r6 !=3D 42)).
> I suspect if you use that in C code you wouldn't need to
> write the test in asm.
> Just a thought.

Thank you this does change test behavior, however compiler still decides
to partially unroll the loop for whatever reason. Will stick to asm
snippets for now.

> Maybe instead of brute forcing all regs to live and precise
> we can add iter.depth check to stacksafe() such
> that depth=3D0 !=3D depth=3D1, but
> depth=3D1 =3D=3D depthN ?
> (and a tweak to iter_active_depths_differ() as well)
>=20
> Then in the above r7 will be 'equivalent', but fp-8 will differ,
> then the state with r7=3D-32 won't be pruned
> and it will address this particular example ? or not ?

This does help for the particular example, however a simple
modification can still trick the verifier:

     ...
     r6 =3D bpf_get_current_pid_tgid()
     bpf_iter_num_new(&fp[-8], 0, 10)
+    bpf_iter_num_next(&fp[-8])
     while (bpf_iter_num_next(&fp[-8])) {
       ...
     }
     ...

> Another idea is to add another state.branches specifically for loop body
> and keep iterating the body until branches=3D=3D0.
> Same concept as the verifier uses for the whole prog, but localized
> to a loop to make sure we don't declare 'equivalent' state
> until all paths in the loop body are explored.

I'm not sure I understand the idea. If we count branches there always
would be back-edges leading to new branches. Or do you suggest to not
prune "equivalent" loop states until all basic blocks in the loop are
visited? (So that all read marks are propagated and probably all
precision marks).

I'm still doubt range_within() check for is_iter_next_insn() case but
can't come up with counter example.

