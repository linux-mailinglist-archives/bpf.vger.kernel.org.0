Return-Path: <bpf+bounces-10655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E517F7ABAB1
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 89611281FE9
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE14735E;
	Fri, 22 Sep 2023 20:52:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3747357
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 20:52:20 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179781A1
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 13:52:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso405569266b.0
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695415936; x=1696020736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uTufhaN4rpFxmUZAOST+4/jjcSrLjzCUbBCYuqd86c=;
        b=eYI1H5SeLhfg6gR1u9ehN6S12iF+oULo5gPbB3Xoe7VmHcNvKy+YIoeepsJ1eZfln3
         a6nrigOwKbNcJtNvlcxgEyRdgWDQ6BWI66jjZiiNtRaT+z9k9vZNQgC4n2uEvpYVMn1N
         uJvqYISE7yTTxCv//9AtKj6GjNSSLYhUajVcN+L9iSNkNyx5YEED6RvLMMoyE0NkDqkr
         4xzjXj5LHyiT27YecJL/3qshNLpuJjcNDXMgMEAaRA7OAQcFOrspdqVIWx8CO548v0/M
         LhUKgH1OLpzrKrAamauQbF+oi6TP+p2B3mcGYMfSJtylT2BBnJMrBKDkLKcR2ihSAe+X
         QXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695415936; x=1696020736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uTufhaN4rpFxmUZAOST+4/jjcSrLjzCUbBCYuqd86c=;
        b=pdCkdoF2IkL7G6hWX90iBh2SEsKcpvzzo6Oni92u4kO+urEOTrokHHxHy0zIDFbLyC
         lBiY5ZGzHBoUgacfxmiKY64gtBzbhjrTiGmbWPPyIbGjHGQzruOM+n6mnhJEHnkbHAXJ
         8IJam/O7ZqqRxEGWaEv3e8OXOetto8b0k4d8otE7HKHAdwdvklTz2JjkvPFFSUdfzjQ+
         ZeXEhMNUcJyYtJ5eALxVjRoe1HCXQIbyvpEDWb2aVSc5IzmfeaJiNMKJ0OKxK4IqGkAD
         5fz1NjL0BCQZy/b3gjsbqMZdfa+3N+kmg0SJ4zEvldEB5XCMGREqsAqu9Z75RZ7/5rL/
         kcGw==
X-Gm-Message-State: AOJu0YxlQqye6ns/KzmP8K8FO09EfUVcrtF1LwNe8V5v7yYC47QScJRs
	zRINfNMn4RCzu8bAR2l6RaCv85Ha8sh/ZVMBLsqPZ8M+
X-Google-Smtp-Source: AGHT+IGedq/Xn3rc1VOhfwZIVvE7sSEkdpRkVNGw+pS8x5zEyDwkmW9bqAuwlc2mjWNKYg5JieWkI5fZisBJU4MzyP4=
X-Received: by 2002:a17:906:5a59:b0:9ae:5df2:2291 with SMTP id
 my25-20020a1709065a5900b009ae5df22291mr1300581ejc.1.1695415936248; Fri, 22
 Sep 2023 13:52:16 -0700 (PDT)
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
 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com> <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
In-Reply-To: <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Sep 2023 13:52:04 -0700
Message-ID: <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2023-09-21 at 19:48 -0700, Andrii Nakryiko wrote:
> > Yes, my gut feeling was that if this idea works at all, then ordering
> > for this won't matter. The question is if the idea itself is sound.
> > Basically, I need to convince myself that subsequent iterations won't
> > add any new read/precise marks. You are good at counter examples, so
> > maybe you can come up with an example where input state into iteration
> > #1 will get more precision marks only at iteration #2 or deeper. If
> > that's the case, then this whole idea of postponing loop convergence
> > checks probably doesn't work.
>
> Consider the following code:
>
>     1.  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>     2.  int num_iter_bug(const void *ctx) {
>     3.      struct bpf_iter_num it;
>     4.      __u64 val =3D 0;
>     5.      __u64 *ptr =3D &val;
>     6.      __u64 rnd =3D bpf_get_current_pid_tgid();
>     7.
>     8.      bpf_iter_num_new(&it, 0, 10);
>     9.      while (bpf_iter_num_next(&it)) {
>     10.          rnd++;
>     11.          if (rnd =3D=3D 42) {
>     12.              ptr =3D (void*)(0xdead);
>     13.              continue;
>     14.          }
>     15.          if (!bpf_iter_num_next(&it))
>     16.              break;
>     17.          bpf_probe_read_user(ptr, 8, (void*)(0xdeadbeef));
>     18.      }
>     19.      bpf_iter_num_destroy(&it);
>     20.      return 0;
>     21. }
>
> As far as I understand the following verification paths would be
> explored (ignoring traces with drained iterators):
> - entry:
>   - 8,9,10,11,12,13:
>     - at 9 checkpoint (C1) would be created with it{.depth=3D0,.state=3Da=
ctive},ptr=3D&val;
>     - at 11 branch (B1) would be created with it{.depth=3D0,.state=3Dacti=
ve},ptr=3D&val;
>     - jump from 13 to 9 would be postponed with state
>       it{.depth=3D0,.state=3Dactive},ptr=3D0xdead as proceeding would inc=
rease 'it' depth;
> - jump from 11 to 15 (branch B1):
>   - 15:
>     - checkpoint would be created with it{.depth=3D0,.state=3Dactive};
>     - jump from 15 to 17 would be postponed with state
>       it{.depth=3D0,.state=3Dactive} as proceeding would increase 'it' de=
pth.
> - at this point verifier would run out of paths that don't increase
>   iterators depth and there are two choices:
>   - (a) jump from 13 to 9 with state it{.depth=3D0,.state=3Dactive},ptr=
=3D0xdead;
>   - (b) jump from 15 to 17 with state it{.depth=3D0,.state=3Dactive},ptr=
=3D&val.
>   If (a) would be processed first there would be no read mark for
>   'ptr' in C1 yet and verifier runs into to the same issue as with
>   original example.
>
> Do I miss something or is it a legit counter-example?
>

I think it is, yes. With the use of

if (!bpf_iter_num_next(&it))
    break;

you can postpone any important markings as deep into iteration
verification as necessary. So yeah, the idea to explore code path
level by level won't cover all the cases, unfortunately.

> > I can't say I understand what exactly you are proposing and how you
> > are going to determine these conservative precision marks. But I'd
> > like to learn some new ideas, so please elaborate :)
>
> I'll send a follow-up email, trying to figure out what to do with pointer=
s.

Ok, sounds good.

