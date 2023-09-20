Return-Path: <bpf+bounces-10477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D01D7A8A5F
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E9281EAA
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61431A587;
	Wed, 20 Sep 2023 17:13:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570F1A580
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 17:13:17 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D7CD7
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:13:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so903031966b.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695229994; x=1695834794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ohJLru9fPzcIzYIpRPLixFtDu90ezv0RNxrrpzTQ03E=;
        b=FffGqOEvOPIgWQNSlr+buk5gZFqzLW3uLMh6oH1gVnyA6Dhw3p8WDFDH4TAg+QiJGy
         xyTJj9R/Usoknc52+Ba0ZiV8KdVSkDDQ9RwcsNUVyaBD9WtRlcCA3SXVr68U7ANmPk4H
         dGwKsnZiYqzCtwvLOuN6h78/d0FOCIGVmkfNmiv3A+Utvb2gL2rbFM8RcyzaExmBQRaO
         ePI417FKxL3JaCAYjWszo8e9DzZuwshmfL8uT7FY/O6bK4c+WgO8NDiIEWUcaZrGpvw7
         ugHeuNjXloqsfWMCNK7D2HnZczaThZHTxoRnisC7vgB0nfA1uUFJUgOD5r3uKjGFO58w
         P2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229994; x=1695834794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohJLru9fPzcIzYIpRPLixFtDu90ezv0RNxrrpzTQ03E=;
        b=KTlCyaWlKmabk8c7WlB/a94K9Frm6nrJwCZbcUZI/na5En9a29FGEcgkvOtpmHvKZS
         IilBKt8GjCpTYYUJJX8Zd76CQSSWRUC+bD3F8u7ubi4qMLegYl0IryqFnWUhEwrk0qey
         EGM6wNCSulO7APFFuQAoz9nEbGHHbmHq2ZIRDs4rBzYbGygHjUQK5yiHsitBRJgLfbIp
         WaRy5OBDhpJIBu2dXQZBX24NIy+ZSkilco06lOJJ/6XsdHvRCiKHsrZuH18XFnsi1yc5
         snNYpyB6a45B6w8oqWsPQd5PN3LkqDWnXf4/q7mVVrmaY+iG7nb/WD5QfEkZDvE64Wed
         wa6w==
X-Gm-Message-State: AOJu0YxISetTKfAxwV7ZFxyYVz7DPg5xtbd8R/vobR6caD9MstUE1fjo
	kR2zF/CKv7Bc1rfm0PC/IhalRLkT4tWHkA==
X-Google-Smtp-Source: AGHT+IFFXiJdbRK2GQkp7WL6LOsIWFfp0fKT2+WOXBMClxRsIP9UN5eqSTZ6IK1U6d8WbZzK8BgFew==
X-Received: by 2002:a17:906:3185:b0:9ae:6d0:84f7 with SMTP id 5-20020a170906318500b009ae06d084f7mr2716217ejy.32.1695229993856;
        Wed, 20 Sep 2023 10:13:13 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b009929ab17be0sm9591124ejb.162.2023.09.20.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:13:13 -0700 (PDT)
Message-ID: <db56499b2ec25b6bfe5d20d95676155ad5c3fce3.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>
Date: Wed, 20 Sep 2023 20:13:12 +0300
In-Reply-To: <CAEf4Bzb-bauJ-gSVdUJdDHzFwOnGNwA4ee9OhYnq1D5sAGhDSw@mail.gmail.com>
References: 
	<CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAEf4BzbKV5eHSWk8LgQmCM1vx1N2__ANUbB137i7_7RqBOsTiQ@mail.gmail.com>
	 <feb852b58c39fb50e3e5fdd33fa8ddf46bce3a8c.camel@gmail.com>
	 <CAEf4Bzb-bauJ-gSVdUJdDHzFwOnGNwA4ee9OhYnq1D5sAGhDSw@mail.gmail.com>
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

On Wed, 2023-09-20 at 09:37 -0700, Andrii Nakryiko wrote:
> On Tue, Sep 19, 2023 at 5:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
[...]
> > This was a bit tricky but I think I figured an acceptable solution w/o
> > extra copies for r1-r5. The tricky part is the structure of
> > check_helper_call():
> > - collect arguments 'meta' info & check arguments
> > - call __check_func_call():
> >   - setup frame for callback;
> >   - schedule next instruction index to be callback entry;
> > - reset r1-r5 in caller's frame;
> > - set r0 in caller's frame.
> >=20
> > The problem is that check_helper_call() resets caller's r1-r5
> > immediately. I figured that this reset could be done at BPF_EXIT
> > processing for callback instead =3D> no extra copy needed.
> >=20
>=20
> I guess then r0 setting would have to happen at BPF_EXIT as well,
> right? Is that a problem?

Ideally yes, r0 should be set at BPF_EXIT, but that would require:
- splitting check_helper_call() in two parts;
- separate handling for helpers that don't call callbacks.

For now I decided against it and r0 in caller's frame is modified
immediately. This is safe, because check_helper_call() logic does not
rely on r0 value (and check_helper_call() would be called again and
again for each new iteration). But it is a hack and maybe change in
check_helper_call() structure is indeed necessary. I leave it out for
now as a secondary concern.

[...]
> > > > - loop detection is broken for simple callback as below:
> > > >=20
> > > >   static int loop_callback_infinite(__u32 idx, __u64 *data)
> > > >   {
> > > >       for (;;)
> > > >           (*ctx)++;
> > > >       return 0;
> > > >   }
> > > >=20
> > > >   To handle such code I need to change is_state_visited() to do
> > > >   callback iterator loop/hit detection on exit from callback
> > > >   (returns are not prune points at the moment), currently it is don=
e
> > > >   on entry.
> > >=20
> > > I'm a bit confused. What's ctx in the above example? And why loop
> > > detection doesn't detect for(;;) loop right now?
> >=20
> > It's an implementation detail for the fix sketch shared in the parent
> > email. It can catch cases like this:
> >=20
> >     ... any insn ...;
> >     for (;;)
> >         (*ctx)++;
> >     return 0;
> >=20
> > But cannot catch case like this:
> >=20
> >     for (;;)
> >         (*ctx)++;
> >     return 0;
> >=20
> > In that sketch I jump to the callback start from callback return and
> > callback entry needs two checks:
> > - iteration convergence
> > - simple looping
> > Because of the code structure only iteration convergence check was done=
.
> > Locally, I fixed this issue by jumping to the callback call instruction
> > instead.
>=20
> wouldn't this be a problem for just any subprog if we don't check the
> looping condition on the entry instruction? Perhaps that's a separate
> issue that needs generic fix?

This didn't occur to me. In the following example loop detection does
not work indeed, however verifier still bails out correctly upon
instruction processing limit:

    SEC("fentry/" SYS_PREFIX "sys_nanosleep")
    __failure
    int iter_next_infinite_loop(const void *ctx)
    {
    	struct bpf_iter_num it;

    	bpf_iter_num_new(&it, 0, 10);
    	for (;;)
    		bpf_iter_num_next(&it);
    	bpf_iter_num_destroy(&it);
    	return 0;
    }

[...]

